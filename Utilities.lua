----------------------------------------------------------------------------------
---- Localized Lua globals.
---------------------------------------------------------------------------------
-- Functions
local pairs = _G.pairs
local tonumber = _G.tonumber
local tostring = _G.tostring
local type = _G.type

-- Libraries
local table = _G.table

-----------------------------------------------------------------------
-- AddOn Namespace
-----------------------------------------------------------------------
local AddOnFolderName = ... ---@type string
local private = select(2, ...) ---@class PrivateNamespace

local Data = private.Data
local Enum = private.Enum

-----------------------------------------------------------------------
-- WoW 7 to 8 transition
-----------------------------------------------------------------------
function GetOldMapData(oldMapID)
    local HBDMigrate = _G.LibStub("HereBeDragons-Migrate")
    local newMapID = HBDMigrate:GetUIMapIDFromMapAreaId(oldMapID)
    local mapInfo = _G.C_Map.GetMapInfo(newMapID)
    local continentInfo = _G.MapUtil.GetMapParentInfo(newMapID, _G.Enum.UIMapType.Continent, true)

    return { oldMapID = oldMapID, mapInfo = mapInfo, continentInfo = continentInfo }
end

function GetMapData(mapID)
    mapID = mapID or _G.C_Map.GetBestMapForUnit("player")

    local mapInfo = _G.C_Map.GetMapInfo(mapID)
    local continentInfo = _G.MapUtil.GetMapParentInfo(mapID, _G.Enum.UIMapType.Continent, true)
    local worldInfo = _G.MapUtil.GetMapParentInfo(mapID, _G.Enum.UIMapType.World, true)

    return { mapInfo = mapInfo, continentInfo = continentInfo, worldInfo = worldInfo }
end

-----------------------------------------------------------------------
-- Helpers
-----------------------------------------------------------------------
local function CreateAlphaAnimation(animationGroup, fromAlpha, toAlpha, duration, startDelay, order)
    local animation = animationGroup:CreateAnimation("Alpha")
    animation:SetFromAlpha(fromAlpha)
    animation:SetToAlpha(toAlpha)
    animation:SetDuration(duration)

    if startDelay then
        animation:SetStartDelay(startDelay)
    end

    if order then
        animation:SetOrder(order)
    end

    return animation
end

private.CreateAlphaAnimation = CreateAlphaAnimation

local function CreateScaleAnimation(
    animationGroup,
    fromScaleX,
    fromScaleY,
    toScaleX,
    toScaleY,
    duration,
    startDelay,
    order
)
    local animation = animationGroup:CreateAnimation("Scale")
    animation:SetFromScale(fromScaleX, fromScaleY)
    animation:SetToScale(toScaleX, toScaleY)
    animation:SetDuration(duration)

    if startDelay then
        animation:SetStartDelay(startDelay)
    end

    if order then
        animation:SetOrder(order)
    end

    return animation
end

private.CreateScaleAnimation = CreateScaleAnimation

local function FormatAtlasTexture(atlasName)
    local atlasInfo = _G.C_Texture.GetAtlasInfo(atlasName)

    if not atlasInfo.file then
        return
    end

    local bottomTexCoord = atlasInfo.bottomTexCoord
    local leftTexCoord = atlasInfo.leftTexCoord
    local rightTexCoord = atlasInfo.rightTexCoord
    local topTexCoord = atlasInfo.topTexCoord

    local atlasWidth = atlasInfo.width / (rightTexCoord - leftTexCoord)
    local atlasHeight = atlasInfo.height / (bottomTexCoord - topTexCoord)
    local pxLeft = atlasWidth * leftTexCoord
    local pxRight = atlasWidth * rightTexCoord
    local pxTop = atlasHeight * topTexCoord
    local pxBottom = atlasHeight * bottomTexCoord

    return ("|T%s:%d:%d:0:0:%d:%d:%d:%d:%d:%d|t"):format(
        atlasInfo.file,
        0,
        0,
        atlasWidth,
        atlasHeight,
        pxLeft,
        pxRight,
        pxTop,
        pxBottom
    )
end

private.FormatAtlasTexture = FormatAtlasTexture

local function GetMapOptionDescription(mapID)
    local continentID = Data.Maps[mapID].continentID

    if continentID then
        local continentName = Data.Continents[continentID].name

        if continentName then
            return ("%s %s %s"):format(_G.ID, mapID, _G.PARENS_TEMPLATE:format(continentName))
        end

        private.Debug("GetMapOptionDescription: No continentName for mapID %d", mapID)
    end

    return ("%s %s"):format(_G.ID, mapID)
end

private.GetMapOptionDescription = GetMapOptionDescription

local function GetMapOptionName(mapID)
    local continentID = Data.Maps[mapID].continentID
    local profile = private.db.profile
    local isBlacklisted = profile.blacklist.mapIDs[mapID]
        or profile.detection.continentIDs[continentID] == Enum.DetectionGroupStatus.Disabled
    local colorCode = isBlacklisted and _G.RED_FONT_COLOR_CODE or _G.GREEN_FONT_COLOR_CODE
    return ("%s%s|r"):format(colorCode, Data.Maps[mapID].name)
end

private.GetMapOptionName = GetMapOptionName

do
    local ValidUnitTypeNames = {
        Creature = true,
        Vehicle = true,
    }

    local function GUIDToCreatureID(GUID)
        local unitTypeName, _, _, _, _, unitID = ("-"):split(GUID)
        if ValidUnitTypeNames[unitTypeName] then
            return tonumber(unitID)
        end
    end

    private.GUIDToCreatureID = GUIDToCreatureID

    local function UnitTokenToCreatureID(unitToken)
        if unitToken then
            local GUID = _G.UnitGUID(unitToken)
            if not GUID then
                return
            end

            return GUIDToCreatureID(GUID)
        end
    end

    private.UnitTokenToCreatureID = UnitTokenToCreatureID
end -- do-block

local function NumericSortString(a, b)
    local x, y = tonumber(a), tonumber(b)

    if x and y then
        return x < y
    end

    return a < b
end

local function TableKeyFormat(input)
    return input
            and input:upper():gsub(" ", "_"):gsub("'", ""):gsub(":", ""):gsub("-", "_"):gsub("%(", ""):gsub("%)", "")
        or ""
end

do
    local OrderedNPCDataFields = {
        "achievementQuestID",
        "classification",
        "factionGroup",
        "isTameable",
        "questID",
        "vignetteID",
        "vignetteName",
        "worldQuestID",
    }

    local IsQuestField = {
        ["achievementQuestID"] = true,
        ["questID"] = true,
        ["worldQuestID"] = true,
    }

    local sectionDelimiter = "-- ----------------------------------------------------------------------------"

    local function displayContinents()
        print("A continentID must be supplied. Valid choices:")

        for continentID, continent in pairs(Data.Continents) do
            print(continentID .. ":", continent.name)
        end
    end

    function private.DumpNPCData(continentID)
        if not continentID then
            displayContinents()

            return
        end

        local NPCScan = _G.LibStub("AceAddon-3.0"):GetAddon(AddOnFolderName)
        local continent = Data.Continents[continentID]

        local sortedMapIDs = {}
        local sortedNPCIDs = {}

        for mapID, map in pairs(continent.Maps) do
            local npcIDs = {}

            sortedNPCIDs[mapID] = npcIDs
            sortedMapIDs[#sortedMapIDs + 1] = mapID

            for npcID in pairs(map.NPCs) do
                npcIDs[#npcIDs + 1] = npcID
            end

            table.sort(sortedNPCIDs[mapID])
        end

        table.sort(sortedMapIDs, private.SortByMapNameThenByID)

        local classificationEnumName = {}

        for name, value in pairs(Enum.NPCClassification) do
            print(("Assigning %s as %s"):format(value, name))
            classificationEnumName[value] = name
        end

        local output = private.TextDump
        output:Clear()

        output:AddLine(sectionDelimiter)
        output:AddLine("-- AddOn Namespace")
        output:AddLine(sectionDelimiter)
        output:AddLine("local AddOnFolderName, private = ...")
        output:AddLine("local NPCs = private.Data.NPCs")
        output:AddLine("local NPCClassification = private.Enum.NPCClassification\n")

        for mapIndex = 1, #sortedMapIDs do
            local map = Data.Maps[sortedMapIDs[mapIndex]]
            local addedZoneHeader = false

            for npcIndex = 1, #sortedNPCIDs[map.ID] do
                local npcID = sortedNPCIDs[map.ID][npcIndex]
                local npc = Data.NPCs[npcID]

                local startedEntry = false

                for index = 1, #OrderedNPCDataFields do
                    local field = OrderedNPCDataFields[index]
                    local fieldValue = npc[field]

                    if fieldValue then
                        if not addedZoneHeader then
                            addedZoneHeader = true

                            output:AddLine(sectionDelimiter)
                            output:AddLine(("-- %s (%d)"):format(map.name, map.ID))
                            output:AddLine(sectionDelimiter)
                        end

                        if not startedEntry then
                            startedEntry = true
                            output:AddLine(("NPCs[%d] = { -- %s"):format(npcID, NPCScan:GetNPCNameFromID(npcID)))
                        end

                        if field == "classification" then
                            local enumName = classificationEnumName[fieldValue]

                            if enumName then
                                fieldValue = ("NPCClassification.%s"):format(enumName)
                            end
                        end

                        -- Seal the value by surrounding with quotes if it's a string.
                        local fieldInfoOutput = field ~= "classification"
                                and type(fieldValue) == "string"
                                and ('"%s"'):format(fieldValue:gsub('"', '\\"'))
                            or tostring(fieldValue)

                        output:AddLine(
                            ("\t%s = %s,%s"):format(
                                field,
                                fieldInfoOutput,
                                IsQuestField[field] and (" -- %s"):format(NPCScan:GetQuestNameFromID(fieldValue)) or ""
                            )
                        )
                    end
                end

                if startedEntry then
                    output:AddLine("}\n")
                end
            end
        end

        output:Display()
    end

    function private.DumpNPCQuests(continentID)
        if not continentID then
            displayContinents()

            return
        end

        local NPCScan = _G.LibStub("AceAddon-3.0"):GetAddon(AddOnFolderName)
        local continent = Data.Continents[continentID]

        local sortedMapIDs = {}
        local sortedQuestIDs = {}

        for mapID, map in pairs(continent.Maps) do
            local questIDs = {}

            sortedQuestIDs[mapID] = questIDs
            sortedMapIDs[#sortedMapIDs + 1] = mapID

            for npcID in pairs(map.NPCs) do
                local npc = map.NPCs[npcID]

                if npc.questID then
                    questIDs[#questIDs + 1] = npc.questID
                end
            end

            table.sort(sortedQuestIDs[mapID])
        end

        table.sort(sortedMapIDs, private.SortByMapNameThenByID)

        local output = private.TextDump
        output:Clear()

        output:AddLine(sectionDelimiter)
        output:AddLine("-- AddOn Namespace")
        output:AddLine(sectionDelimiter)
        output:AddLine("local AddOnFolderName, private = ...")
        output:AddLine("local Quests = private.Data.Quests\n")

        for mapIndex = 1, #sortedMapIDs do
            local map = Data.Maps[sortedMapIDs[mapIndex]]
            local addedZoneHeader = false

            for questIndex = 1, #sortedQuestIDs[map.ID] do
                local questID = sortedQuestIDs[map.ID][questIndex]
                local quest = Data.Quests[questID]

                local startedEntry = false

                for index = 1, #OrderedQuestDataFields do
                    local field = OrderedQuestDataFields[index]
                    local fieldInfo = quest[field]

                    if fieldInfo then
                        if not addedZoneHeader then
                            addedZoneHeader = true

                            output:AddLine(sectionDelimiter)
                            output:AddLine(("-- %s (%d)"):format(map.name, map.ID))
                            output:AddLine(sectionDelimiter)
                        end

                        if not startedEntry then
                            startedEntry = true
                            output:AddLine(("Quests[%d] = { -- %s"):format(npcID, NPCScan:GetQuestNameFromID(questID)))
                        end

                        local fieldInfoOutput
                        if type(fieldInfo) == "string" then
                            fieldInfoOutput = ('"%s"'):format(fieldInfo:gsub('"', '\\"'))
                        else
                            fieldInfoOutput = tostring(fieldInfo)
                        end

                        local fieldInfoComment = field == "questID"
                                and (" -- %s"):format(NPCScan:GetQuestNameFromID(fieldInfo))
                            or ""
                        output:AddLine(("    %s = %s,%s"):format(field, fieldInfoOutput, fieldInfoComment))
                    end
                end

                if startedEntry then
                    output:AddLine("}\n")
                end
            end
        end

        output:Display()
    end

    function private.DumpQuestData(continentID)
        if not continentID then
            displayContinents()

            return
        end

        local NPCScan = _G.LibStub("AceAddon-3.0"):GetAddon(AddOnFolderName)
        local continent = Data.Continents[continentID]

        local sortedMapIDs = {}
        local sortedQuestIDs = {}

        for mapID, map in pairs(continent.Maps) do
            local questIDs = {}
            sortedQuestIDs[mapID] = questIDs
            sortedMapIDs[#sortedMapIDs + 1] = mapID

            for questID in pairs(map.Quests) do
                questIDs[#questIDs + 1] = questID
            end

            table.sort(sortedQuestIDs[mapID])
        end

        table.sort(sortedMapIDs, private.SortByMapNameThenByID)

        local output = private.TextDump
        output:Clear()

        output:AddLine(sectionDelimiter)
        output:AddLine("-- AddOn Namespace")
        output:AddLine(sectionDelimiter)
        output:AddLine("local AddOnFolderName, private = ...")
        output:AddLine("local Quests = private.Data.Quests\n")

        for mapIndex = 1, #sortedMapIDs do
            local map = Data.Maps[sortedMapIDs[mapIndex]]
            local addedZoneHeader = false

            for questIndex = 1, #sortedQuestIDs[map.ID] do
                local questID = sortedQuestIDs[map.ID][questIndex]
                local quest = Data.Quests[questID]

                local startedEntry = false

                for index = 1, #OrderedQuestDataFields do
                    local field = OrderedQuestDataFields[index]
                    local fieldInfo = quest[field]

                    if fieldInfo then
                        if not addedZoneHeader then
                            addedZoneHeader = true

                            output:AddLine(sectionDelimiter)
                            output:AddLine(("-- %s (%d)"):format(map.name, map.ID))
                            output:AddLine(sectionDelimiter)
                        end

                        if not startedEntry then
                            startedEntry = true
                            output:AddLine(("Quests[%d] = { -- %s"):format(npcID, NPCScan:GetQuestNameFromID(questID)))
                        end

                        local fieldInfoOutput
                        if type(fieldInfo) == "string" then
                            fieldInfoOutput = ('"%s"'):format(fieldInfo:gsub('"', '\\"'))
                        else
                            fieldInfoOutput = tostring(fieldInfo)
                        end

                        local fieldInfoComment = field == "questID"
                                and (" -- %s"):format(NPCScan:GetQuestNameFromID(fieldInfo))
                            or ""
                        output:AddLine(("    %s = %s,%s"):format(field, fieldInfoOutput, fieldInfoComment))
                    end
                end

                if startedEntry then
                    output:AddLine("}\n")
                end
            end
        end

        output:Display()
    end

    private.DUMP_COMMANDS = {
        npcdata = function(parameters)
            private.DumpNPCData(tonumber(parameters))
        end,
        npcquests = function(parameters)
            private.DumpNPCQuests(tonumber(parameters))
        end,
        questdata = function(parameters)
            private.DumpQuestData(tonumber(parameters))
        end,
    }
end -- do-block

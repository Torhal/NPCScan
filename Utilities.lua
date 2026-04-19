--------------------------------------------------------------------------------
---- Lua Builtins
--------------------------------------------------------------------------------

-- Functions
local pairs = pairs
local tonumber = tonumber
local tostring = tostring
local type = type

-- Libraries
local table = table

--------------------------------------------------------------------------------
---- AddOn Namespace
--------------------------------------------------------------------------------

local AddOnFolderName = ... ---@type string
local private = select(2, ...) ---@class PrivateNamespace

--------------------------------------------------------------------------------
---- Helpers
--------------------------------------------------------------------------------

---@param animationGroup AnimationGroup
---@param fromAlpha number
---@param toAlpha number
---@param duration number
---@param startDelay? number
---@param order? number
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

---@param animationGroup AnimationGroup
---@param fromScaleX number
---@param fromScaleY number
---@param toScaleX number
---@param toScaleY number
---@param duration number
---@param startDelay? number
---@param order? number
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
    animation:SetScaleFrom(fromScaleX, fromScaleY)
    animation:SetScaleTo(toScaleX, toScaleY)
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

---@param atlasName string
local function FormatAtlasTexture(atlasName)
    local atlasInfo = C_Texture.GetAtlasInfo(atlasName)

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

---@param mapID integer
local function GetMapOptionDescription(mapID)
    local continentID = private.Data.Maps[mapID].continentID

    if continentID then
        local continentName = private.Data.Continents[continentID].name

        if continentName then
            return ("%s %s %s"):format(ID, mapID, PARENS_TEMPLATE:format(continentName))
        end

        private.Debug("GetMapOptionDescription: No continentName for mapID %d", mapID)
    end

    return ("%s %s"):format(ID, mapID)
end

private.GetMapOptionDescription = GetMapOptionDescription

---@param mapID integer
local function GetMapOptionName(mapID)
    local continentID = private.Data.Maps[mapID].continentID
    local profile = private.db.profile
    local isBlacklisted = profile.blacklist.mapIDs[mapID]
        or profile.detection.continentIDs[continentID] == private.Enum.DetectionGroupStatus.Disabled
    local colorCode = isBlacklisted and RED_FONT_COLOR_CODE or GREEN_FONT_COLOR_CODE
    return ("%s%s|r"):format(colorCode, private.Data.Maps[mapID].name)
end

private.GetMapOptionName = GetMapOptionName

do
    local ValidUnitTypeNames = {
        Creature = true,
        Vehicle = true,
    }

    ---@param GUID string
    ---@return integer | nil
    local function GUIDToCreatureID(GUID)
        local unitTypeName, _, _, _, _, unitID = ("-"):split(GUID)
        if ValidUnitTypeNames[unitTypeName] then
            return tonumber(unitID)
        end
    end

    private.GUIDToCreatureID = GUIDToCreatureID

    ---@param unitToken UnitToken
    ---@return integer | nil
    local function UnitTokenToCreatureID(unitToken)
        if unitToken then
            local GUID = UnitGUID(unitToken)
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
        "mounts",
        "npcID",
        "pets",
        "questID",
        "toys",
        "vignetteID",
        "vignetteName",
        "worldQuestID",
    }

    local IsQuestField = {
        ["achievementQuestID"] = true,
        ["questID"] = true,
        ["worldQuestID"] = true,
    }

    local sectionDelimiter = "--------------------------------------------------------------------------------"

    local function displayContinents()
        print("A continentID must be supplied. Valid choices:")

        for continentID, continent in pairs(private.Data.Continents) do
            print(continentID .. ":", continent.name)
        end
    end

    ---@param continentID integer
    function private.DumpNPCData(continentID)
        if not continentID then
            displayContinents()

            return
        end

        local NPCScan = LibStub("AceAddon-3.0"):GetAddon(AddOnFolderName) ---@class NPCScan
        local continent = private.Data.Continents[continentID]

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

        for name, value in pairs(private.Enum.NPCClassification) do
            classificationEnumName[value] = name
        end

        local output = private.TextDump
        output:Clear()

        output:AddLine(sectionDelimiter)
        output:AddLine("---- AddOn Namespace")
        output:AddLine(("%s\n"):format(sectionDelimiter))
        output:AddLine("local AddOnFolderName = ... ---@type string")
        output:AddLine("local private = select(2, ...) ---@class PrivateNamespace\n")
        output:AddLine("local NPCs = private.Data.NPCs")
        output:AddLine("local NPCClassification = private.Enum.NPCClassification\n")

        for mapIndex = 1, #sortedMapIDs do
            local map = private.Data.Maps[sortedMapIDs[mapIndex]]
            local addedZoneHeader = false

            for npcIndex = 1, #sortedNPCIDs[map.ID] do
                local npcID = sortedNPCIDs[map.ID][npcIndex]
                local npc = private.Data.NPCs[npcID]

                local startedEntry = false

                for index = 1, #OrderedNPCDataFields do
                    local fieldName = OrderedNPCDataFields[index]
                    local fieldValue = npc[fieldName]

                    if fieldValue then
                        if not addedZoneHeader then
                            addedZoneHeader = true

                            output:AddLine(sectionDelimiter)
                            output:AddLine(("---- %s (%d)"):format(map.name, map.ID))
                            output:AddLine(("%s\n"):format(sectionDelimiter))
                        end

                        if not startedEntry then
                            startedEntry = true
                            output:AddLine(("NPCs[%d] = { -- %s"):format(npcID, NPCScan:GetNPCNameFromID(npcID)))
                        end

                        local fieldInfoOutput = ""
                        local questName = ""

                        if fieldName == "classification" then
                            local enumName = classificationEnumName[fieldValue]

                            if enumName then
                                fieldInfoOutput = ("NPCClassification.%s"):format(enumName)
                            end
                        else
                            local valueType = type(fieldValue)

                            -- Seal the value by surrounding with quotes if it's a string.
                            if valueType == "string" then
                                fieldInfoOutput = ('"%s"'):format(fieldValue:gsub('"', '\\"')) or tostring(fieldValue)
                            elseif valueType == "table" then
                                fieldInfoOutput = "{\n"

                                for childKey, childValue in pairs(fieldValue) do
                                    if type(childValue) == "table" then
                                        fieldInfoOutput = ("%s        {\n"):format(fieldInfoOutput)

                                        for grandchildKey, grandchildValue in pairs(childValue) do
                                            fieldInfoOutput = ("%s            %s = %s,\n"):format(
                                                fieldInfoOutput,
                                                grandchildKey,
                                                grandchildValue
                                            )
                                        end

                                        fieldInfoOutput = ("%s        },\n"):format(fieldInfoOutput)
                                    else
                                        fieldInfoOutput = ("%s    %s = %s,\n"):format(
                                            fieldInfoOutput,
                                            childKey,
                                            childValue
                                        )
                                    end
                                end

                                fieldInfoOutput = ("%s    }"):format(fieldInfoOutput)
                            elseif valueType == "number" then
                                fieldInfoOutput = tostring(fieldValue)

                                if IsQuestField[fieldName] then
                                    questName = (" -- %s"):format(NPCScan:GetQuestNameFromID(fieldValue))
                                end
                            else
                                fieldInfoOutput = tostring(fieldValue)
                            end
                        end

                        output:AddLine(("    %s = %s,%s"):format(fieldName, fieldInfoOutput, questName))
                    end
                end

                if startedEntry then
                    output:AddLine("}\n")
                end
            end
        end

        output:Display()
    end

    ---@param continentID integer
    function private.DumpNPCQuests(continentID)
        if not continentID then
            displayContinents()

            return
        end

        local NPCScan = LibStub("AceAddon-3.0"):GetAddon(AddOnFolderName)
        local continent = private.Data.Continents[continentID]

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
            local map = private.Data.Maps[sortedMapIDs[mapIndex]]
            local addedZoneHeader = false

            for questIndex = 1, #sortedQuestIDs[map.ID] do
                local questID = sortedQuestIDs[map.ID][questIndex]
                local quest = private.Data.Quests[questID]

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

        local NPCScan = LibStub("AceAddon-3.0"):GetAddon(AddOnFolderName)
        local continent = private.Data.Continents[continentID]

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
            local map = private.Data.Maps[sortedMapIDs[mapIndex]]
            local addedZoneHeader = false

            for questIndex = 1, #sortedQuestIDs[map.ID] do
                local questID = sortedQuestIDs[map.ID][questIndex]
                local quest = private.Data.Quests[questID]

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

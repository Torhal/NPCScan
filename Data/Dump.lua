--------------------------------------------------------------------------------
---- AddOn Namespace
--------------------------------------------------------------------------------

local AddOnFolderName = ... ---@type string
local private = select(2, ...) ---@class PrivateNamespace

local NPCScan = LibStub("AceAddon-3.0"):GetAddon(AddOnFolderName) ---@class NPCScan

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
function private.DumpMapNPCs(continentID)
    if not continentID then
        displayContinents()

        return
    end

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

    local output = private.TextDump
    output:Clear()

    output:AddLine(sectionDelimiter)
    output:AddLine("---- AddOn Namespace")
    output:AddLine(("%s\n"):format(sectionDelimiter))
    output:AddLine("local AddOnFolderName = ... ---@type string")
    output:AddLine("local private = select(2, ...) ---@class PrivateNamespace\n")
    output:AddLine("local Maps = private.Data.Maps")
    output:AddLine("local MapID = private.Enum.MapID\n")

    for mapIndex = 1, #sortedMapIDs do
        local map = private.Data.Maps[sortedMapIDs[mapIndex]]

        output:AddLine(sectionDelimiter)
        output:AddLine(("---- %s (%d)"):format(map.name, map.ID))
        output:AddLine(("%s\n"):format(sectionDelimiter))

        local enumName = UNKNOWN

        for entryName, entryID in pairs(private.Enum.MapID) do
            if entryID == map.ID then
                enumName = entryName
                break
            end
        end

        output:AddLine(("Maps[MapID.%s].NPCs = {"):format(enumName))
        for npcIndex = 1, #sortedNPCIDs[map.ID] do
            local npcID = sortedNPCIDs[map.ID][npcIndex]

            output:AddLine(("    [%d] = true, -- %s"):format(npcID, private.GetNPCNameFromID(npcID)))
        end

        output:AddLine("}\n")
    end

    output:Display()
end

---@param continentID integer
function private.DumpNPCData(continentID)
    if not continentID then
        displayContinents()

        return
    end

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
                        output:AddLine(("NPCs[%d] = {"):format(npcID))
                        output:AddLine(("    %s"):format(sectionDelimiter))
                        output:AddLine(("    ---- %s"):format(private.GetNPCNameFromID(npcID)))
                        output:AddLine(("    %s"):format(sectionDelimiter))
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
                                    local grandchildValueName = ""

                                    fieldInfoOutput = ("%s        {\n"):format(fieldInfoOutput)

                                    for grandchildKey, grandchildValue in pairs(childValue) do
                                        if grandchildKey == "npcID" then
                                            grandchildValueName = (" -- %s"):format(
                                                private.GetNPCNameFromID(grandchildValue)
                                            )
                                        elseif grandchildKey == "itemID" then
                                            local itemName = private.GetItemNameFromID(grandchildValue)

                                            if itemName then
                                                grandchildValueName = (" -- %s"):format(itemName)
                                            end
                                        elseif grandchildKey == "spellID" then
                                            grandchildValueName = (" -- %s"):format(
                                                C_Spell.GetSpellInfo(grandchildValue).name
                                            )
                                        end

                                        fieldInfoOutput = ("%s            %s = %s,%s\n"):format(
                                            fieldInfoOutput,
                                            grandchildKey,
                                            grandchildValue,
                                            grandchildValueName
                                        )
                                    end

                                    fieldInfoOutput = ("%s        },\n"):format(fieldInfoOutput)
                                else
                                    fieldInfoOutput = ("%s    %s = %s,\n"):format(fieldInfoOutput, childKey, childValue)
                                end
                            end

                            fieldInfoOutput = ("%s    }"):format(fieldInfoOutput)
                        elseif valueType == "number" then
                            fieldInfoOutput = tostring(fieldValue)

                            if IsQuestField[fieldName] then
                                questName = (" -- %s"):format(private.GetQuestNameFromID(fieldValue))
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
                        output:AddLine(("Quests[%d] = { -- %s"):format(npcID, private.GetQuestNameFromID(questID)))
                    end

                    local fieldInfoOutput
                    if type(fieldInfo) == "string" then
                        fieldInfoOutput = ('"%s"'):format(fieldInfo:gsub('"', '\\"'))
                    else
                        fieldInfoOutput = tostring(fieldInfo)
                    end

                    local fieldInfoComment = field == "questID"
                            and (" -- %s"):format(private.GetQuestNameFromID(fieldInfo))
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
                        output:AddLine(("Quests[%d] = { -- %s"):format(questID, private.GetQuestNameFromID(questID)))
                    end

                    local fieldInfoOutput
                    if type(fieldInfo) == "string" then
                        fieldInfoOutput = ('"%s"'):format(fieldInfo:gsub('"', '\\"'))
                    else
                        fieldInfoOutput = tostring(fieldInfo)
                    end

                    local fieldInfoComment = field == "questID"
                            and (" -- %s"):format(private.GetQuestNameFromID(fieldInfo))
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
    mapnpcs = function(parameters)
        private.DumpMapNPCs(tonumber(parameters))
    end,
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

--------------------------------------------------------------------------------
---- AddOn Namespace
--------------------------------------------------------------------------------

local AddOnFolderName = ... ---@type string
local private = select(2, ...) ---@class PrivateNamespace

local NPCScan = LibStub("AceAddon-3.0"):GetAddon(AddOnFolderName) ---@class NPCScan

--------------------------------------------------------------------------------
---- Helpers
--------------------------------------------------------------------------------

---@param first string
---@param rest string
local function ToTitleCase(first, rest)
    return first:upper() .. rest:lower()
end

local function DisplayContinents()
    print("A continentID must be supplied. Valid choices:")

    for continentID, continent in pairs(private.Data.Continents) do
        print(continentID .. ":", continent.name)
    end
end

--------------------------------------------------------------------------------
---- Constants
--------------------------------------------------------------------------------

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

--------------------------------------------------------------------------------
---- Dump Functions
--------------------------------------------------------------------------------

---@param continentID ContinentID?
function private.DumpMapNPCs(continentID)
    if not continentID then
        DisplayContinents()

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

---@param continentID ContinentID?
function private.DumpNPCData(continentID)
    if not continentID then
        DisplayContinents()

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
    output:AddLine("local Mount = private.Enum.Mount")
    output:AddLine("local Pet = private.Enum.Pet")
    output:AddLine("local Toy = private.Enum.Toy\n")

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
                    elseif fieldName == "mounts" then
                        fieldInfoOutput = "{\n"

                        for _, mount in ipairs(fieldValue) do
                            for mountLabel, mountData in pairs(private.Enum.Mount) do
                                if mount.itemID == mountData.itemID then
                                    fieldInfoOutput = ("%s        Mount.%s,\n"):format(fieldInfoOutput, mountLabel)
                                end
                            end
                        end

                        fieldInfoOutput = ("%s    }"):format(fieldInfoOutput)
                    elseif fieldName == "pets" then
                        fieldInfoOutput = "{\n"

                        for _, pet in ipairs(fieldValue) do
                            for petLabel, petData in pairs(private.Enum.Pet) do
                                if pet.itemID == petData.itemID then
                                    fieldInfoOutput = ("%s        Pet.%s,\n"):format(fieldInfoOutput, petLabel)
                                end
                            end
                        end

                        fieldInfoOutput = ("%s    }"):format(fieldInfoOutput)
                    elseif fieldName == "toys" then
                        fieldInfoOutput = "{\n"

                        for _, toy in ipairs(fieldValue) do
                            for toyLabel, toyData in pairs(private.Enum.Toy) do
                                if toy.itemID == toyData.itemID then
                                    fieldInfoOutput = ("%s        Toy.%s,\n"):format(fieldInfoOutput, toyLabel)
                                end
                            end
                        end

                        fieldInfoOutput = ("%s    }"):format(fieldInfoOutput)
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
                                                private.GetSpellNameFromID(grandchildValue)
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

---@param continentID ContinentID?
function private.DumpNPCQuests(continentID)
    if not continentID then
        DisplayContinents()

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

---@param continentID ContinentID?
function private.DumpQuestData(continentID)
    if not continentID then
        DisplayContinents()

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

--------------------------------------------------------------------------------
---- Mounts
--------------------------------------------------------------------------------

do
    local MountRegistry = {}
    local MountLabelToItemID = {}
    local MountLabelToSpellID = {}
    local SortedMountLabels = {}

    function private.DumpMountData()
        local output = private.TextDump
        output:Clear()

        for continentID, continent in pairs(private.Data.Continents) do
            for mapID, map in pairs(continent.Maps) do
                for npcID, npc in pairs(map.NPCs) do
                    if npc.mounts then
                        for index, mount in ipairs(npc.mounts) do
                            if not MountRegistry[mount.itemID] then
                                MountRegistry[mount.itemID] = true

                                local mountLabel = private
                                    .GetSpellNameFromID(mount.spellID)
                                    :gsub("(%a)([%w_']*)", ToTitleCase)
                                    :gsub("%W", "")

                                MountLabelToItemID[mountLabel] = mount.itemID
                                MountLabelToSpellID[mountLabel] = mount.spellID

                                table.insert(SortedMountLabels, mountLabel)
                            end
                        end
                    end
                end
            end
        end

        table.sort(SortedMountLabels)

        for index = 1, #SortedMountLabels do
            local label = SortedMountLabels[index]
            local itemID = MountLabelToItemID[label]
            local spellID = MountLabelToSpellID[label]

            output:AddLine(("    %s = {"):format(label))
            output:AddLine(("        itemID = %d, -- %s"):format(itemID, private.GetItemNameFromID(itemID)))
            output:AddLine(("        spellID = %d, -- %s"):format(spellID, private.GetSpellNameFromID(spellID)))
            output:AddLine("    },")
        end

        output:Display()
    end
end

--------------------------------------------------------------------------------
---- Pets
--------------------------------------------------------------------------------

do
    local PetRegistry = {}
    local PetLabelToItemID = {}
    local PetLabelToNPCID = {}
    local SortedPetLabels = {}

    function private.DumpPetData()
        local output = private.TextDump
        output:Clear()

        for continentID, continent in pairs(private.Data.Continents) do
            for mapID, map in pairs(continent.Maps) do
                for npcID, npc in pairs(map.NPCs) do
                    if npc.pets then
                        for index, pet in ipairs(npc.pets) do
                            if not PetRegistry[pet.itemID] then
                                PetRegistry[pet.itemID] = true

                                local petLabel = private
                                    .GetNPCNameFromID(pet.npcID)
                                    :gsub("(%a)([%w_']*)", ToTitleCase)
                                    :gsub("%W", "")

                                PetLabelToItemID[petLabel] = pet.itemID
                                PetLabelToNPCID[petLabel] = pet.npcID

                                table.insert(SortedPetLabels, petLabel)
                            end
                        end
                    end
                end
            end
        end

        table.sort(SortedPetLabels)

        for index = 1, #SortedPetLabels do
            local label = SortedPetLabels[index]
            local itemID = PetLabelToItemID[label]
            local npcID = PetLabelToNPCID[label]

            output:AddLine(("    %s = {"):format(label))
            output:AddLine(("        itemID = %d, -- %s"):format(itemID, private.GetItemNameFromID(itemID)))
            output:AddLine(("        npcID = %d, -- %s"):format(npcID, private.GetNPCNameFromID(npcID)))
            output:AddLine("    },")
        end

        output:Display()
    end
end

--------------------------------------------------------------------------------
---- Toys
--------------------------------------------------------------------------------

do
    local ToyRegistry = {}
    local ToyLabelToItemID = {}
    local SortedToyLabels = {}

    function private.DumpToyData()
        local output = private.TextDump
        output:Clear()

        for continentID, continent in pairs(private.Data.Continents) do
            for mapID, map in pairs(continent.Maps) do
                for npcID, npc in pairs(map.NPCs) do
                    if npc.toys then
                        for index, toy in ipairs(npc.toys) do
                            if not ToyRegistry[toy.itemID] then
                                ToyRegistry[toy.itemID] = true

                                local toyLabel = private
                                    .GetItemNameFromID(toy.itemID)
                                    :gsub("(%a)([%w_']*)", ToTitleCase)
                                    :gsub("%W", "")

                                ToyLabelToItemID[toyLabel] = toy.itemID
                                table.insert(SortedToyLabels, toyLabel)
                            end
                        end
                    end
                end
            end
        end

        table.sort(SortedToyLabels)

        for index = 1, #SortedToyLabels do
            local label = SortedToyLabels[index]
            local itemID = ToyLabelToItemID[label]

            output:AddLine(("    %s = {"):format(label))
            output:AddLine(("        itemID = %d, -- %s"):format(itemID, private.GetItemNameFromID(itemID)))
            output:AddLine("    },")
        end

        output:Display()
    end
end

private.DUMP_COMMANDS = {
    mapnpcs = function(parameters)
        private.DumpMapNPCs(tonumber(parameters))
    end,
    mounts = function(parameters)
        private.DumpMountData()
    end,
    npcdata = function(parameters)
        private.DumpNPCData(tonumber(parameters))
    end,
    npcquests = function(parameters)
        private.DumpNPCQuests(tonumber(parameters))
    end,
    pets = function(parameters)
        private.DumpPetData()
    end,
    questdata = function(parameters)
        private.DumpQuestData(tonumber(parameters))
    end,
    toys = function(parameters)
        private.DumpToyData()
    end,
}

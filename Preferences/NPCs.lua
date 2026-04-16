--------------------------------------------------------------------------------
---- AddOn Namespace
--------------------------------------------------------------------------------

local AddOnFolderName = ... ---@type string
local private = select(2, ...) ---@class PrivateNamespace

local AceConfigRegistry = LibStub("AceConfigRegistry-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale(AddOnFolderName)
local NPCScan = LibStub("AceAddon-3.0"):GetAddon(AddOnFolderName) ---@class NPCScan

--------------------------------------------------------------------------------
---- Constants
--------------------------------------------------------------------------------

local EmptyListOption = {
    order = 1,
    name = EMPTY,
    type = "header",
}

--------------------------------------------------------------------------------
---- Variables
--------------------------------------------------------------------------------

local npcIDs = {}
local npcNames = {}

--------------------------------------------------------------------------------
---- Helpers
--------------------------------------------------------------------------------

local UpdateBlacklistedNPCOptions

local GetMapIDsAlphabetizedByName
do
    local mapIDs

    function GetMapIDsAlphabetizedByName()
        if mapIDs then
            return mapIDs
        end

        local Data = private.Data

        mapIDs = {}

        for mapID in pairs(Data.Maps) do
            mapIDs[#mapIDs + 1] = mapID
        end

        table.sort(mapIDs, function(a, b)
            local mapNameA = Data.Maps[a].name
            local mapNameB = Data.Maps[b].name

            if mapNameA == mapNameB then
                return a < b
            end

            return mapNameA < mapNameB
        end)

        return mapIDs
    end
end -- do-block

---@param input integer | string
---@param operationType "add" | "remove"
---@return boolean, integer? -- isValidated, npcID
local function ValidateUserDefinedNPCInput(input, operationType)
    local value = type(input) == "string" and input:gsub('"', "") or input

    if value == "mouseover" or value == "target" then
        value = private.UnitTokenToCreatureID(value)
    end

    local npcID = tonumber(value)

    if npcID then
        if operationType == "add" and private.Data.NPCs[npcID] then
            NPCScan:Print(L["Predefined NPCs cannot be added to the user-defined NPC list."])
            return false
        end

        if private.db.profile.userDefined.npcIDs[npcID] then
            if operationType == "add" then
                NPCScan:Printf(
                    L["%1$s (%2$d) is already on the user-defined NPC list."],
                    NPCScan:GetNPCNameFromID(npcID),
                    npcID
                )
                return false
            end
        else
            if operationType == "remove" then
                NPCScan:Printf(
                    L["%1$s (%2$d) is not on the user-defined NPC list."],
                    NPCScan:GetNPCNameFromID(npcID),
                    npcID
                )
                return false
            end
        end

        return true, npcID
    end

    NPCScan:Print(
        L['Valid values are a numeric NPC ID, the word "mouseover" while you have your mouse cursor over an NPC, or the word "target" while you have an NPC set as your target.']
    )

    return false
end

local function AddUserDefinedNPC(input)
    local isValid, npcID = ValidateUserDefinedNPCInput(input, "add")

    if not isValid or not npcID then
        return
    end

    private.db.profile.userDefined.npcIDs[npcID] = true

    private.UpdateUserDefinedNPCOptions()

    NPCScan:UpdateScanList()
    NPCScan:Printf(L["Added %1$s (%2$d) to the user-defined NPC list."], NPCScan:GetNPCNameFromID(npcID), npcID)
end

private.AddUserDefinedNPC = AddUserDefinedNPC

local function RemoveUserDefinedNPC(input)
    local isValid, npcID = ValidateUserDefinedNPCInput(input, "remove")

    if not isValid or not npcID then
        return
    end

    private.db.profile.userDefined.npcIDs[npcID] = nil

    private.UpdateUserDefinedNPCOptions()

    NPCScan:UpdateScanList()
    NPCScan:SendMessage(private.EventMessage.DismissTargetButtonByID, npcID)
    NPCScan:Printf(L["Removed %1$s (%2$d) from the user-defined NPC list."], NPCScan:GetNPCNameFromID(npcID), npcID)
end

private.RemoveUserDefinedNPC = RemoveUserDefinedNPC

local function GetNPCOptionsDescription(npcID)
    local npc = private.Data.NPCs[npcID]
    local mapNames = {}

    for mapIDIndex = 1, #npc.mapIDs do
        mapNames[#mapNames + 1] = private.Data.Maps[npc.mapIDs[mapIDIndex]].name
    end

    return ("%s %s %s"):format(ID, npcID, table.concat(mapNames, ", "))
end

local ICON_QUEST_ACTIVE = private.FormatAtlasTexture("QuestDaily")
local ICON_QUEST_COMPLETE = private.FormatAtlasTexture("QuestRepeatableTurnin")

local function GetNPCOptionsName(npcID)
    local colorCode = NORMAL_FONT_COLOR_CODE
    local npc = private.Data.NPCs[npcID]

    if npc.achievementID then
        colorCode = npc:IsAchievementCriteriaComplete() and GREEN_FONT_COLOR_CODE or RED_FONT_COLOR_CODE
    end

    local prefix = ""

    if npc:HasQuest() then
        prefix = npc:IsQuestComplete() and ICON_QUEST_COMPLETE or ICON_QUEST_ACTIVE
    end

    local npcName = NPCScan:GetNPCNameFromID(npcID)
    local assetName = npc.achievementAssetName
    local label = ""

    if assetName and assetName ~= npcName then
        label = (" %s"):format(PARENS_TEMPLATE:format(assetName))
    end

    return ("%s%s%s%s|r"):format(prefix, colorCode, npcName, label)
end

private.GetNPCOptionsName = GetNPCOptionsName

local function SortByNPCNameThenByID(a, b)
    local nameA = npcNames[a]
    local nameB = npcNames[b]

    if nameA == nameB then
        return a < b
    end

    return nameA < nameB
end

local function SetNPCDataFromList(savedNPCIDs)
    table.wipe(npcIDs)
    table.wipe(npcNames)

    for npcID in pairs(savedNPCIDs) do
        npcNames[npcID] = NPCScan:GetNPCNameFromID(npcID)
        npcIDs[#npcIDs + 1] = npcID
    end

    table.sort(npcIDs, SortByNPCNameThenByID)
end

--------------------------------------------------------------------------------
---- Achievement Options
--------------------------------------------------------------------------------

local AchievementIDs -- Populated below.
local AchievementNPCOptions = {}

local function UpdateAchievementNPCOptions()
    local Data = private.Data

    table.wipe(AchievementNPCOptions)

    if not AchievementIDs then
        AchievementIDs = {}

        for achievementID in pairs(Data.Achievements) do
            AchievementIDs[#AchievementIDs + 1] = achievementID
        end

        table.sort(AchievementIDs, function(a, b)
            return Data.Achievements[a].name < Data.Achievements[b].name
        end)
    end

    local profile = private.db.profile

    for achievementIDIndex = 1, #AchievementIDs do
        local achievementID = AchievementIDs[achievementIDIndex]
        local achievementStatus = profile.detection.achievementIDs[achievementID]

        local achievementOptionsTable = {
            order = achievementIDIndex,
            name = ("%s%s|r"):format(
                private.DetectionGroupStatusColors[achievementStatus],
                Data.Achievements[achievementID].name
            ),
            desc = Data.Achievements[achievementID].description,
            type = "group",
            args = {
                status = {
                    order = 1,
                    name = STATUS,
                    type = "select",
                    values = private.DetectionGroupStatusLabels,
                    get = function()
                        return profile.detection.achievementIDs[achievementID]
                    end,
                    set = function(_, value)
                        profile.detection.achievementIDs[achievementID] = value

                        if value ~= private.Enum.DetectionGroupStatus.UserDefined then
                            for npcID in pairs(Data.Achievements[achievementID].criteriaNPCs) do
                                profile.blacklist.npcIDs[npcID] = nil
                            end
                        end

                        UpdateAchievementNPCOptions()
                        UpdateBlacklistedNPCOptions()

                        NPCScan:UpdateScanList()
                    end,
                },
                npcs = {
                    order = 2,
                    name = " ",
                    type = "group",
                    guiInline = true,
                    args = {},
                },
            },
        }

        table.wipe(npcIDs)
        table.wipe(npcNames)

        for npcID, npc in pairs(Data.Achievements[achievementID].criteriaNPCs) do
            if npc.factionGroup ~= UnitFactionGroup("player") then
                npcNames[npcID] = NPCScan:GetNPCNameFromID(npcID)
                npcIDs[#npcIDs + 1] = npcID
            end
        end

        table.sort(npcIDs, SortByNPCNameThenByID)

        for npcIDIndex = 1, #npcIDs do
            local npcID = npcIDs[npcIDIndex]

            achievementOptionsTable.args.npcs.args["npcID" .. npcID] = {
                order = npcIDIndex,
                name = GetNPCOptionsName(npcID),
                desc = GetNPCOptionsDescription(npcID),
                type = "toggle",
                width = "full",
                descStyle = "inline",
                disabled = function()
                    return profile.detection.achievementIDs[achievementID]
                        ~= private.Enum.DetectionGroupStatus.UserDefined
                end,
                get = function()
                    return not profile.blacklist.npcIDs[npcID]
                end,
                set = function()
                    local isBlacklisted = not profile.blacklist.npcIDs[npcID] and true or nil
                    profile.blacklist.npcIDs[npcID] = isBlacklisted

                    UpdateAchievementNPCOptions()
                    UpdateBlacklistedNPCOptions()

                    NPCScan:UpdateScanList()

                    if isBlacklisted then
                        NPCScan:SendMessage(private.EventMessage.DismissTargetButtonByID, npcID)
                    end
                end,
            }
        end

        AchievementNPCOptions["achievementID" .. achievementID] = achievementOptionsTable
    end

    AceConfigRegistry:NotifyChange(AddOnFolderName)
end

private.UpdateAchievementNPCOptions = UpdateAchievementNPCOptions

--------------------------------------------------------------------------------
---- Rare Options
--------------------------------------------------------------------------------

local DungeonRareNPCOptions = {}
local ZoneRareNPCOptions = {}

local RareClassifications = {
    rare = true,
    rareelite = true,
}

local function UpdateRareNPCOptions()
    table.wipe(DungeonRareNPCOptions)
    table.wipe(ZoneRareNPCOptions)

    local sortedMapIDs = GetMapIDsAlphabetizedByName()
    local profile = private.db.profile

    for mapIDIndex = 1, #sortedMapIDs do
        local mapID = sortedMapIDs[mapIDIndex]

        table.wipe(npcIDs)
        table.wipe(npcNames)

        for npcID, npc in pairs(private.Data.Maps[mapID].NPCs) do
            if
                (not npc.classification or RareClassifications[npc.classification])
                and npc.factionGroup ~= UnitFactionGroup("player")
            then
                npcNames[npcID] = NPCScan:GetNPCNameFromID(npcID)
                npcIDs[#npcIDs + 1] = npcID
            end
        end

        if #npcIDs > 0 then
            table.sort(npcIDs, SortByNPCNameThenByID)

            local mapOptionsTable = {
                order = mapIDIndex,
                name = private.GetMapOptionName(mapID),
                desc = private.GetMapOptionDescription(mapID),
                type = "group",
                args = {
                    npcs = {
                        order = 1,
                        name = " ",
                        type = "group",
                        guiInline = true,
                        args = {},
                    },
                },
            }

            for npcIDIndex = 1, #npcIDs do
                local npcID = npcIDs[npcIDIndex]

                if npcID then
                    mapOptionsTable.args.npcs.args["npc" .. npcID] = {
                        order = npcIDIndex,
                        name = GetNPCOptionsName(npcID),
                        desc = GetNPCOptionsDescription(npcID),
                        descStyle = "inline",
                        type = "toggle",
                        width = "full",
                        disabled = function()
                            return not profile.detection.rares
                        end,
                        get = function()
                            return not profile.blacklist.npcIDs[npcID]
                        end,
                        set = function()
                            local isBlacklisted = not profile.blacklist.npcIDs[npcID] and true or nil
                            profile.blacklist.npcIDs[npcID] = isBlacklisted

                            UpdateRareNPCOptions()
                            UpdateBlacklistedNPCOptions()

                            NPCScan:UpdateScanList()

                            if isBlacklisted then
                                NPCScan:SendMessage(private.EventMessage.DismissTargetButtonByID, npcID)
                            end
                        end,
                    }
                end
            end

            if private.Data.Maps[mapID].isDungeon then
                DungeonRareNPCOptions["map" .. mapID] = mapOptionsTable
            else
                ZoneRareNPCOptions["map" .. mapID] = mapOptionsTable
            end
        end
    end

    AceConfigRegistry:NotifyChange(AddOnFolderName)
end

private.UpdateRareNPCOptions = UpdateRareNPCOptions

--------------------------------------------------------------------------------
---- Tameable Rare Options
--------------------------------------------------------------------------------

local DungeonTameableRareNPCOptions = {}
local ZoneTameableRareNPCOptions = {}

local function UpdateTameableRareNPCOptions()
    table.wipe(DungeonTameableRareNPCOptions)
    table.wipe(ZoneTameableRareNPCOptions)

    local sortedMapIDs = GetMapIDsAlphabetizedByName()
    local profile = private.db.profile

    for mapIDIndex = 1, #sortedMapIDs do
        local mapID = sortedMapIDs[mapIDIndex]

        table.wipe(npcIDs)
        table.wipe(npcNames)

        for npcID, npc in pairs(private.Data.Maps[mapID].NPCs) do
            if npc.isTameable and npc.factionGroup ~= UnitFactionGroup("player") then
                npcNames[npcID] = NPCScan:GetNPCNameFromID(npcID)
                npcIDs[#npcIDs + 1] = npcID
            end
        end

        if #npcIDs > 0 then
            table.sort(npcIDs, SortByNPCNameThenByID)

            local mapOptionsTable = {
                order = mapIDIndex,
                name = private.GetMapOptionName(mapID),
                desc = private.GetMapOptionDescription(mapID),
                type = "group",
                args = {
                    npcs = {
                        order = 1,
                        name = " ",
                        type = "group",
                        guiInline = true,
                        args = {},
                    },
                },
            }

            for npcIDIndex = 1, #npcIDs do
                local npcID = npcIDs[npcIDIndex]

                if npcID then
                    mapOptionsTable.args.npcs.args["npc" .. npcID] = {
                        order = npcIDIndex,
                        name = GetNPCOptionsName(npcID),
                        desc = GetNPCOptionsDescription(npcID),
                        descStyle = "inline",
                        type = "toggle",
                        width = "full",
                        disabled = function()
                            return not profile.detection.tameables
                        end,
                        get = function()
                            return not profile.blacklist.npcIDs[npcID]
                        end,
                        set = function()
                            local isBlacklisted = not profile.blacklist.npcIDs[npcID] and true or nil
                            profile.blacklist.npcIDs[npcID] = isBlacklisted

                            UpdateTameableRareNPCOptions()
                            UpdateBlacklistedNPCOptions()

                            NPCScan:UpdateScanList()

                            if isBlacklisted then
                                NPCScan:SendMessage(private.EventMessage.DismissTargetButtonByID, npcID)
                            end
                        end,
                    }
                end
            end

            if private.Data.Maps[mapID].isDungeon then
                DungeonTameableRareNPCOptions["map" .. mapID] = mapOptionsTable
            else
                ZoneTameableRareNPCOptions["map" .. mapID] = mapOptionsTable
            end
        end
    end

    AceConfigRegistry:NotifyChange(AddOnFolderName)
end

private.UpdateTameableRareNPCOptions = UpdateTameableRareNPCOptions

--------------------------------------------------------------------------------
---- Search Options
--------------------------------------------------------------------------------

local NPCSearchOptions = {}

local function AddApplicableSearchID(npc)
    if npc.factionGroup ~= UnitFactionGroup("player") then
        local npcID = npc.npcID

        npcNames[npcID] = NPCScan:GetNPCNameFromID(npcID)
        npcIDs[#npcIDs + 1] = npcID
    end
end

local function UpdateNPCSearchOptions()
    table.wipe(NPCSearchOptions)

    table.sort(npcIDs, SortByNPCNameThenByID)

    local profile = private.db.profile

    if #npcIDs > 0 then
        for npcIDIndex = 1, #npcIDs do
            local npcID = npcIDs[npcIDIndex]
            local npc = private.Data.NPCs[npcID]

            local achievementText = ""
            if npc.achievementID then
                achievementText = PARENS_TEMPLATE:format(private.Data.Achievements[npc.achievementID].name)
            end

            NPCSearchOptions["npc" .. npcID] = {
                order = npcIDIndex,
                name = GetNPCOptionsName(npcID),
                desc = ("%s %s"):format(GetNPCOptionsDescription(npcID), achievementText),
                descStyle = "inline",
                type = "toggle",
                width = "full",
                disabled = function()
                    if
                        npc.achievementID
                        and profile.detection.achievementIDs[npc.achievementID]
                            ~= private.Enum.DetectionGroupStatus.UserDefined
                    then
                        return true
                    end
                end,
                get = function()
                    return not profile.blacklist.npcIDs[npcID]
                end,
                set = function()
                    local isBlacklisted = not profile.blacklist.npcIDs[npcID] and true or nil
                    profile.blacklist.npcIDs[npcID] = isBlacklisted

                    UpdateRareNPCOptions()
                    UpdateTameableRareNPCOptions()
                    UpdateBlacklistedNPCOptions()

                    NPCScan:UpdateScanList()

                    if isBlacklisted then
                        NPCScan:SendMessage(private.EventMessage.DismissTargetButtonByID, npcID)
                    end
                end,
            }
        end
    else
        NPCSearchOptions["npc0"] = EmptyListOption
    end

    AceConfigRegistry:NotifyChange(AddOnFolderName)
end

local function PerformNPCSearch(searchString)
    searchString = searchString:lower():trim()

    table.wipe(npcIDs)
    table.wipe(npcNames)

    for continentID = 1, #private.Enum.ContinentMapID do
        local continent = private.Data.Continents[continentID]

        if continent.name:lower() == searchString then
            for _, map in pairs(continent.Maps) do
                for _, npc in pairs(map.NPCs) do
                    AddApplicableSearchID(npc)
                end
            end

            UpdateNPCSearchOptions()

            return
        end
    end

    for mapID, map in pairs(private.Data.Maps) do
        if not map.name then
            private.Debug("MapID %d: No map name", mapID)
        end

        if map.name and map.name:lower() == searchString then
            for _, npc in pairs(map.NPCs) do
                AddApplicableSearchID(npc)
            end

            UpdateNPCSearchOptions()

            return
        end
    end

    for _, npc in pairs(private.Data.NPCs) do
        if NPCScan:GetNPCNameFromID(npc.npcID):lower():find(searchString) then
            AddApplicableSearchID(npc)
        end
    end

    UpdateNPCSearchOptions()
end

private.PerformNPCSearch = PerformNPCSearch

--------------------------------------------------------------------------------
---- User-Defined NPC Options
--------------------------------------------------------------------------------

local UserDefinedNPCOptions = {}

local function UpdateUserDefinedNPCOptions()
    table.wipe(UserDefinedNPCOptions)

    local savedNPCIDs = private.db.profile.userDefined.npcIDs
    SetNPCDataFromList(savedNPCIDs)

    if #npcIDs > 0 then
        for index = 1, #npcIDs do
            local npcID = npcIDs[index]

            UserDefinedNPCOptions["npc" .. index] = {
                order = index,
                name = ("%s: %d"):format(NPCScan:GetNPCNameFromID(npcID), npcID),
                descStyle = "inline",
                type = "toggle",
                width = "full",
                get = function()
                    return true
                end,
                set = function()
                    RemoveUserDefinedNPC(npcID)
                end,
            }
        end
    else
        UserDefinedNPCOptions["npc0"] = EmptyListOption
    end

    AceConfigRegistry:NotifyChange(AddOnFolderName)
end

private.UpdateUserDefinedNPCOptions = UpdateUserDefinedNPCOptions

--------------------------------------------------------------------------------
---- Blacklisted NPC Options
--------------------------------------------------------------------------------

local BlacklistedNPCOptions = {}

function UpdateBlacklistedNPCOptions()
    table.wipe(BlacklistedNPCOptions)

    local savedNPCIDs = private.db.profile.blacklist.npcIDs
    SetNPCDataFromList(savedNPCIDs)

    if #npcIDs > 0 then
        for index = 1, #npcIDs do
            local npcID = npcIDs[index]

            BlacklistedNPCOptions["npc" .. npcID] = {
                order = index,
                name = ("%s: %d"):format(NPCScan:GetNPCNameFromID(npcID), npcID),
                descStyle = "inline",
                type = "toggle",
                width = "full",
                get = function()
                    return true
                end,
                set = function()
                    savedNPCIDs[npcID] = nil

                    UpdateAchievementNPCOptions()
                    UpdateBlacklistedNPCOptions()

                    NPCScan:UpdateScanList()
                end,
            }
        end
    else
        BlacklistedNPCOptions["npc0"] = EmptyListOption
    end

    AceConfigRegistry:NotifyChange(AddOnFolderName)
end

private.UpdateBlacklistedNPCOptions = UpdateBlacklistedNPCOptions

--------------------------------------------------------------------------------
---- Initialization
--------------------------------------------------------------------------------

local NPCOptions

local function GetOrUpdateNPCOptions()
    local profile = private.db.profile

    NPCOptions = NPCOptions
        or {
            name = L["NPCs"],
            order = 1,
            type = "group",
            childGroups = "tab",
            args = {
                achievements = {
                    order = 1,
                    name = ACHIEVEMENTS,
                    type = "group",
                    childGroups = "tree",
                    args = AchievementNPCOptions,
                },
                rare = {
                    order = 2,
                    name = BATTLE_PET_BREED_QUALITY4,
                    type = "group",
                    childGroups = "tab",
                    args = {
                        isEnabled = {
                            order = 1,
                            type = "toggle",
                            name = ENABLE,
                            descStyle = "inline",
                            get = function()
                                return profile.detection.rares
                            end,
                            set = function(_, value)
                                profile.detection.rares = value

                                NPCScan:UpdateScanList()
                            end,
                        },
                        zoneNPCOptions = {
                            order = 2,
                            name = ZONE,
                            descStyle = "inline",
                            type = "group",
                            args = ZoneRareNPCOptions,
                        },
                        dungeonNPCOptions = {
                            order = 3,
                            name = DUNGEONS,
                            descStyle = "inline",
                            type = "group",
                            args = DungeonRareNPCOptions,
                        },
                    },
                },
                tameableRare = {
                    order = 3,
                    name = TAMEABLE,
                    type = "group",
                    childGroups = "tab",
                    args = {
                        isEnabled = {
                            order = 1,
                            type = "toggle",
                            name = ENABLE,
                            descStyle = "inline",
                            get = function()
                                return profile.detection.tameables
                            end,
                            set = function(_, value)
                                profile.detection.tameables = value

                                NPCScan:UpdateScanList()
                            end,
                        },
                        zoneNPCOptions = {
                            order = 2,
                            name = ZONE,
                            descStyle = "inline",
                            type = "group",
                            args = ZoneTameableRareNPCOptions,
                        },
                        dungeonNPCOptions = {
                            order = 3,
                            name = DUNGEONS,
                            descStyle = "inline",
                            type = "group",
                            args = DungeonTameableRareNPCOptions,
                        },
                    },
                },
                search = {
                    order = 4,
                    name = SEARCH,
                    type = "group",
                    args = {
                        description = {
                            order = 1,
                            type = "description",
                            name = L["Type the name of a Continent, Dungeon, or Zone, or the partial name of an NPC. Accepts Lua patterns."],
                        },
                        entryBox = {
                            order = 2,
                            name = " ",
                            descStyle = "inline",
                            type = "input",
                            get = function()
                                return ""
                            end,
                            set = function(_, value)
                                PerformNPCSearch(value)
                            end,
                        },
                        results = {
                            order = 3,
                            name = KBASE_SEARCH_RESULTS,
                            type = "group",
                            inline = true,
                            args = NPCSearchOptions,
                        },
                    },
                },
                userDefined = {
                    order = 5,
                    name = CUSTOM,
                    type = "group",
                    args = {
                        isEnabled = {
                            order = 1,
                            type = "toggle",
                            name = ENABLE,
                            descStyle = "inline",
                            get = function()
                                return profile.detection.userDefined
                            end,
                            set = function(_, value)
                                profile.detection.userDefined = value

                                NPCScan:UpdateScanList()
                            end,
                        },
                        npcID = {
                            order = 2,
                            name = ADD,
                            desc = L['Valid values are a numeric NPC ID, the word "mouseover" while you have your mouse cursor over an NPC, or the word "target" while you have an NPC set as your target.'],
                            type = "input",
                            disabled = function()
                                return not profile.detection.userDefined
                            end,
                            get = function()
                                return ""
                            end,
                            set = function(_, value)
                                AddUserDefinedNPC(value)
                            end,
                        },
                        npcIDs = {
                            order = 3,
                            name = ASSIGNED_COLON,
                            type = "group",
                            inline = true,
                            disabled = function()
                                return not profile.detection.userDefined
                            end,
                            args = UserDefinedNPCOptions,
                        },
                    },
                },
                blacklisted = {
                    order = 6,
                    name = IGNORED,
                    type = "group",
                    args = {
                        npcIDs = {
                            order = 1,
                            name = ASSIGNED_COLON,
                            type = "group",
                            inline = true,
                            args = BlacklistedNPCOptions,
                        },
                    },
                },
            },
        }

    UpdateAchievementNPCOptions()
    UpdateRareNPCOptions()
    UpdateTameableRareNPCOptions()
    UpdateUserDefinedNPCOptions()
    UpdateBlacklistedNPCOptions()

    return NPCOptions
end

private.GetOrUpdateNPCOptions = GetOrUpdateNPCOptions

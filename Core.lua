--------------------------------------------------------------------------------
----  AddOn Namespace
--------------------------------------------------------------------------------

local AddOnFolderName = ... ---@type string

---@class PrivateNamespace
---@field db NPCScanDatabase
---@field TextDump LibTextDump.Interface
local private = select(2, ...)

local AceConfigDialog = LibStub("AceConfigDialog-3.0")
local HereBeDragons = LibStub("HereBeDragons-2.0")

---@class NPCScan: AceAddon, AceConsole-3.0, AceEvent-3.0, AceTimer-3.0, AceBucket-3.0, LibSink-2.0
local NPCScan = LibStub("AceAddon-3.0"):NewAddon(
    AddOnFolderName,
    "AceConsole-3.0",
    "AceEvent-3.0",
    "AceTimer-3.0",
    "AceBucket-3.0",
    "LibSink-2.0",
    "LibToast-1.0"
)

--------------------------------------------------------------------------------
---- Debugger
--------------------------------------------------------------------------------

do
    local TextDump = LibStub("LibTextDump-1.0")

    local DEBUGGER_WIDTH = 750
    local DEBUGGER_HEIGHT = 800

    ---@type LibTextDump.Interface
    local debugger

    local function GetDebugger()
        if not debugger then
            debugger = TextDump:New(("%s Debug Output"):format(AddOnFolderName), DEBUGGER_WIDTH, DEBUGGER_HEIGHT)
        end

        return debugger
    end

    private.GetDebugger = GetDebugger

    function private.Debug(...)
        local message = string.format(...)

        GetDebugger():AddLine(message, "%X")

        return message
    end
end

--------------------------------------------------------------------------------
---- AddOn Methods
--------------------------------------------------------------------------------

function NPCScan:OnInitialize() ---@diagnostic disable-line: unused-function
    --------------------------------------------------------------------------------
    ---- Data Initialization
    --------------------------------------------------------------------------------

    local DefaultPreferences = private.DefaultPreferences
    local UIMapType = Enum.UIMapType

    for _, achievementID in pairs(private.Enum.AchievementID) do
        DefaultPreferences.profile.detection.achievementIDs[achievementID] = private.Enum.DetectionGroupStatus.Enabled
    end

    for _, continentID in pairs(private.Enum.ContinentID) do
        local continent = private.Data.Continents[continentID]

        if not continent then
            continent = {
                ID = -1,
                Maps = {},
                name = "",
            }

            private.Data.Continents[continentID] = continent
        end

        continent.ID = continentID
        continent.name = HereBeDragons:GetLocalizedMap(private.Enum.ContinentMapID[continentID])

        DefaultPreferences.profile.detection.continentIDs[continentID] = private.Enum.DetectionGroupStatus.Enabled
    end

    for mapID, map in pairs(private.Data.Maps) do
        local parentMapInfo = MapUtil.GetMapParentInfo(mapID, UIMapType.Continent)
            or MapUtil.GetMapParentInfo(mapID, UIMapType.World)
            or MapUtil.GetMapParentInfo(mapID, UIMapType.Cosmic)

        local continentID = parentMapInfo and private.Enum.MapContinentID[parentMapInfo.mapID]
            or private.Enum.ContinentID.Cosmic
        local mapInfo = C_Map.GetMapInfo(mapID)

        if mapInfo.mapType == UIMapType.Dungeon or mapInfo.mapType == UIMapType.Orphan then
            map.isDungeon = true
        end

        map.continentID = continentID
        map.ID = mapID
        map.name = HereBeDragons:GetLocalizedMap(mapID) or UNKNOWN

        private.Data.Continents[continentID].Maps[mapID] = map
    end

    ---@class NPCScanDatabase
    local db = LibStub("AceDB-3.0"):New("NPCScanDB", DefaultPreferences, "Default")
    db.RegisterCallback(self, "OnProfileChanged", "RefreshPreferences")
    db.RegisterCallback(self, "OnProfileCopied", "RefreshPreferences")
    db.RegisterCallback(self, "OnProfileReset", "RefreshPreferences")

    self:DefineSinkToast(AddOnFolderName, [[Interface\LFGFRAME\BattlenetWorking0]])
    self:SetSinkStorage(db.profile.alert.output)

    private.db = db

    private.TextDump = LibStub("LibTextDump-1.0"):New(AddOnFolderName, 750, 600)

    --------------------------------------------------------------------------------
    ---- DB Migrations
    --------------------------------------------------------------------------------

    local sharedMediaNames = db.profile.alert.sound.sharedMediaNames

    for index = 1, 50 do
        local actualName = sharedMediaNames[index]
        if actualName then
            sharedMediaNames[actualName] = true
            sharedMediaNames[index] = nil
        end
    end

    self:RegisterChatCommand("npcscan", "ChatCommand")
end
---@diagnostic disable-line: unused-function
function NPCScan:OnEnable()
    --------------------------------------------------------------------------------
    ---- Lookup Tables
    --------------------------------------------------------------------------------

    local MapID = private.Enum.MapID
    local mapIDs = {} ---@type MapID[]

    for mapID, map in pairs(private.Data.Maps) do
        table.insert(mapIDs, mapID)
        for npcID in pairs(map.NPCs) do
            local npc = private.InitializeNPC(npcID)

            map.NPCs[npcID] = npc

            npc.mapIDs = npc.mapIDs or {}
            npc.mapIDs[#npc.mapIDs + 1] = mapID

            table.sort(npc.mapIDs, private.SortByMapNameThenByID)
        end
    end

    private.InitializeAchievements()

    local hasChecked = {}

    local questMapIDs = {
        [MapID.Argus] = true,
        [MapID.BrokenIsles] = true,
        [MapID.KulTiras] = true,
        [MapID.Zandalar] = true,
        [MapID.TheShadowlands] = true,
        [MapID.DragonIsles] = true,
        [MapID.KhazAlgar] = true,
    }

    local vignetteMapIDs = {
        [MapID.Argus] = true,
        [MapID.BrokenIsles] = true,
        [MapID.Draenor] = true,
        [MapID.KulTiras] = true,
        [MapID.Pandaria] = true,
        [MapID.Zandalar] = true,
        [MapID.TheShadowlands] = true,
        [MapID.DragonIsles] = true,
        [MapID.KhazAlgar] = true,
    }

    local NPCIDs = {} ---@type NPCID[]

    table.sort(mapIDs)

    for index = 1, #mapIDs do
        local mapID = mapIDs[index]
        local map = private.Data.Maps[mapID]
        local continent = MapUtil.GetMapParentInfo(mapID, Enum.UIMapType.Continent, true)

        local missingData = {}
        local mapHeaderPrinted = false

        for npcID in pairs(map.NPCs) do
            local npc = map.NPCs[npcID]
            if not hasChecked[npcID] then
                table.insert(NPCIDs, npcID)

                if npc.vignetteID then
                    if npc.vignetteID ~= -1 and not npc.questID and (not continent or questMapIDs[continent.mapID]) then
                        missingData[npcID] = "questID"
                    end
                elseif not continent or vignetteMapIDs[continent.mapID] then
                    if missingData[npcID] then
                        missingData[npcID] = ("%s, vignetteID"):format(missingData[npcID])
                    else
                        missingData[npcID] = "vignetteID"
                    end
                end

                hasChecked[npcID] = true
            end
        end

        table.sort(NPCIDs)

        for IDIndex = 1, #NPCIDs do
            local npcID = NPCIDs[IDIndex]
            local missingText = missingData[npcID]

            if missingText then
                if not mapHeaderPrinted then
                    mapHeaderPrinted = true
                    private.Debug("--------------------------------------------------------------------------------")
                    private.Debug("---- %s (%d)", HereBeDragons:GetLocalizedMap(mapID) or UNKNOWN, mapID)
                    private.Debug("--------------------------------------------------------------------------------")
                end

                private.Debug("NPC %d - %s - is missing: %s.", npcID, private.GetNPCNameFromID(npcID), missingText)
            end
        end
    end

    -- Handle custom additions.
    for npcID, npcName in pairs(private.db.locale.npcNames) do
        private.NPCIDFromName[npcName] = npcID
    end

    self:SetupOptions()
    self:InitializeTargetButton()

    self:RegisterBucketEvent("CRITERIA_UPDATE", 5)
    self:RegisterEvent("LOOT_CLOSED")
    self:RegisterEvent("NAME_PLATE_UNIT_ADDED")
    self:RegisterEvent("PLAYER_ENTERING_WORLD")
    self:RegisterEvent("PLAYER_TARGET_CHANGED")
    self:RegisterEvent("QUEST_DATA_LOAD_RESULT")
    self:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
    self:RegisterEvent("VIGNETTE_MINIMAP_UPDATED")
    self:RegisterBucketEvent("VIGNETTES_UPDATED", 0.5)

    HereBeDragons.RegisterCallback(NPCScan, "PlayerZoneChanged", "UpdateScanList")

    self:UpdateScanList()
    private.Overlays.Register()
end

function NPCScan:RefreshPreferences() end

do
    ---@type table<string, function>?
    local SUBCOMMAND_FUNCTIONS

    ---@param input string
    function NPCScan:ChatCommand(input)
        SUBCOMMAND_FUNCTIONS = SUBCOMMAND_FUNCTIONS
            or {
                ADD = private.AddUserDefinedNPC,
                COMPARE = private.CompareData,
                REMOVE = private.RemoveUserDefinedNPC,
                ---@param subject string
                SEARCH = function(subject)
                    AceConfigDialog:Open(AddOnFolderName)
                    AceConfigDialog:SelectGroup(AddOnFolderName, "npcOptions", "search")
                    private.PerformNPCSearch(subject)
                end,
                --@debug@
                DEBUG = function()
                    local debugger = private.GetDebugger()

                    if debugger:Lines() == 0 then
                        debugger:AddLine("Nothing to report.")
                        debugger:Display()
                        debugger:Clear()
                        return
                    end

                    debugger:Display()
                end,
                ---@param dumpType string
                ---@param parameters string?
                DUMP = function(dumpType, parameters)
                    local func = private.DUMP_COMMANDS[dumpType]

                    if func then
                        func(parameters)
                    else
                        NPCScan:Print("Unknown dump command. Valid commands:")

                        for command in pairs(private.DUMP_COMMANDS) do
                            NPCScan:Printf("     %s", command)
                        end
                    end
                end,
                --@end-debug@
            }

        local subcommand, arg1, arg2 = self:GetArgs(input, 3)

        if subcommand then
            local func = SUBCOMMAND_FUNCTIONS[subcommand:upper()]

            if func then
                func(arg1, arg2)
            end

            return
        end

        AceConfigDialog:Open(AddOnFolderName)
    end
end -- do-block

-------------------------------------------------------------------------------
-- Localized Lua globals.
-------------------------------------------------------------------------------
local _G = getfenv(0)

-- Functions
local next = _G.next
local pairs = _G.pairs
local tonumber = _G.tonumber
local tostring = _G.tostring
local type = _G.type

-- Libraries
local string = _G.string
local table = _G.table

-------------------------------------------------------------------------------
-- AddOn namespace.
-------------------------------------------------------------------------------
local FOLDER_NAME, private = ...

local LibStub = _G.LibStub
local Dialog = LibStub("LibDialog-1.0")
local HereBeDragons = LibStub("HereBeDragons-1.0")
local Toast = LibStub("LibToast-1.0")

local L = private.L
_G._NPCScan = private

local debugger -- Only defined if needed.

-- Create a new Add-on object using AceAddon for Profile DB
private.Ace = _G.LibStub("AceAddon-3.0"):NewAddon(FOLDER_NAME)

local EventFrame = _G.CreateFrame("Frame")
EventFrame:RegisterEvent("PLAYER_LEAVING_WORLD")
EventFrame:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
EventFrame:RegisterEvent("LOOT_CLOSED")
EventFrame:RegisterEvent("NAME_PLATE_UNIT_ADDED")

EventFrame:SetScript("OnEvent", function(self, event_name, ...)
	if self[event_name] then
		return self[event_name](self, event_name, ...)
	end
end)

private.Updater = EventFrame:CreateAnimationGroup()
private.Updater.UpdateRate = 0.5
private.Updater:CreateAnimation("Animation"):SetDuration(private.Updater.UpdateRate)
private.Updater:SetLooping("REPEAT")

-------------------------------------------------------------------------------
-- Constants.
-------------------------------------------------------------------------------
local DB_VERSION = 3
local ANTI_SPAM_DELAY = 300

--@debug@
ANTI_SPAM_DELAY = 30
--@end-debug@
private.ANTI_SPAM_DELAY = ANTI_SPAM_DELAY


-------------------------------------------------------------------------------
-- Variables.
-------------------------------------------------------------------------------
_NPCScanOptions = {}
private.CharacterOptions = {}

local GlobalOptionsDefault = {
	Version = DB_VERSION,
	AlertSound = nil, -- Default sound
	NPCs = {
		[50409] = private.L.NPCs["50409"], --"Mysterious Camel Figurine",
		[50410] = private.L.NPCs["50410"], --"Mysterious Camel Figurine",
		[64004] = private.L.NPCs["64004"], --"Ghostly Pandaren Fisherman",
		[64191] = private.L.NPCs["64191"], --"Ghostly Pandaren Craftsman",
	},
	NPCWorldIDs = {
		[50409] = private.ZONE_NAMES.KALIMDOR,
		[50410] = private.ZONE_NAMES.KALIMDOR,
		[64004] = private.ZONE_NAMES.PANDARIA,
		[64191] = private.ZONE_NAMES.PANDARIA,
	},
	IgnoreList = {
		NPCs = {},
		MapName = {},
		WorldID = {},
	},
	CacheWarnings = nil,
	ShowAlertAsToast = nil,
	PersistentToast = nil,
}


--Options table for AceConfig
local ProfileOptions = {
	["type"] = "group",
	["handler"] = private.Ace,
	["args"] = {
		["Profiles"] = nil, -- Reserved for profile options
	},
};

--This replaces OptionsCharacterDefault
local ProfileDefaults = {
	profile = {
		Achievements = {
			[private.ACHIEVEMENT_IDS.BLOODY_RARE] = true,
			[private.ACHIEVEMENT_IDS.FROSTBITTEN] = true,
			[private.ACHIEVEMENT_IDS.ONE_MANY_ARMY] = true,
			[private.ACHIEVEMENT_IDS.GLORIOUS] = true,
			[private.ACHIEVEMENT_IDS.CHAMPIONS_OF_LEI_SHEN] = true,
			[private.ACHIEVEMENT_IDS.TIMELESS_CHAMPION] = true,
			[private.ACHIEVEMENT_IDS.GORGROND_MONSTER_HUNTER] = true,
			[private.ACHIEVEMENT_IDS.HIGH_VALUE_TARGETS_ASHRAN] = true,
			[private.ACHIEVEMENT_IDS.CUT_OFF_THE_HEAD] = true,
			[private.ACHIEVEMENT_IDS.HERALDS_OF_THE_LEGION] = true,
			[private.ACHIEVEMENT_IDS.FIGHT_THE_POWER] = true,
			[private.ACHIEVEMENT_IDS.ANCIENT_NO_MORE] = true,
			[private.ACHIEVEMENT_IDS.HELLBANE] = true,
			[private.ACHIEVEMENT_IDS.JUNGLE_STALKER] = true,
		},
		AchievementsAddFound = true,
		AlertScreenEdgeFlash = true,
		AlertSoundUnmute = false,
		CacheWarnings = false,
		FlightSupress = true,
		PersistentToast = false,
		ShowAlertAsToast = false,
		TargetIcon = 8, --Skull
		TrackBeasts = true,
		TrackRares = true,
		TrackNameplate = false,
		TrackVignettes = true,
		TrackMouseover = false,
		TrackHellbane = true,
	}
}

local antiSpamList = {}
local lastAntiSpam = 0
local active_tracking_quest_mobs = {}


-------------------------------------------------------------------------------
-- Dialogs and Toasts.
-------------------------------------------------------------------------------
Dialog:Register("NPCSCAN_AUTOADD_WARNING", {
	text = "You appear to be running _NPCScan.AutoAdd, which may prevent _NPCScan from working properly.\n\nIt is recommended that you disable _NPCScan.AutoAdd.",
	text_justify_h = "left",
	text_justify_v = "bottom",
	buttons = {
		{
			text = _G.OKAY,
		},
	},
	icon = [[Interface\DialogFrame\UI-Dialog-Icon-AlertNew]],
	show_while_dead = true,
	hide_on_escape = true,
	width = 500,
})


Toast:Register("_NPCScanAlertToast", function(toast, ...)
	if private.CharacterOptions.PersistentToast then
		toast:MakePersistent()
	end
	toast:SetTitle(L.CONFIG_TITLE)
	toast:SetFormattedText("%s%s|r", _G.GREEN_FONT_COLOR_CODE, ...)
	toast:SetIconTexture([[Interface\LFGFRAME\BattlenetWorking0]])
end)

-------------------------------------------------------------------------------
-- Helpers.
-------------------------------------------------------------------------------
function private.Print(message, color)
	if not color then
		color = _G.NORMAL_FONT_COLOR
	end
	_G.DEFAULT_CHAT_FRAME:AddMessage(L.PRINT_FORMAT:format(private.CharacterOptions.PrintTime and _G.date(_G.CHAT_TIMESTAMP_FORMAT or L.TIME_FORMAT) or "", message), color.r, color.g, color.b)
end

local function IsNPCQuestComplete(npc_id)
	local quest_id = private.NPC_ID_TO_QUEST_ID[npc_id]

	if quest_id then
		return _G.IsQuestFlaggedCompleted(quest_id)
	else
		return false
	end
end
private.IsNPCQuestComplete = IsNPCQuestComplete

-- TODO: Fix this abomination. Necessary because _NPCScan.Overlay looks for _NPCScan.NPCQuestIsComplete
private.NPCQuestIsComplete = IsNPCQuestComplete

private.ScanIDs = {} -- [ NpcID ] = Number of concurrent scans for this ID

-- Begins searching for an NPC.
local function ScanAdd(npc_id)
	if private.ScanIDs[npc_id] then
		private.ScanIDs[npc_id] = private.ScanIDs[npc_id] + 1
	else
		-- First
		if not next(private.ScanIDs) then
			private.Updater:Play()
		end
		private.ScanIDs[npc_id] = 1
		private.Overlays.Add(npc_id)
	end

	return true
end


-- Stops searching for an NPC when nothing is searching for it.
local function ScanRemove(npc_id)
	local count = assert(private.ScanIDs[npc_id], "Attempt to remove inactive scan. " .. npc_id)

	if count > 1 then
		private.ScanIDs[npc_id] = count - 1
	else
		private.ScanIDs[npc_id] = nil
		private.Overlays.Remove(npc_id)

		-- Last
		if not next(private.ScanIDs) then
			private.Updater:Stop()
		end
	end
end


local currentMapID

local function IsMapIDCurrent(mapID)
	return not mapID or mapID == currentMapID
end


local NPCActivate, NPCDeactivate
do
	local NPCsActive = {}

	-- Starts actual scan for NPC if on the right world.
	function NPCActivate(npc_id, world_id)
		if NPCsActive[npc_id] or not IsMapIDCurrent(world_id) or not ScanAdd(npc_id) then
			return
		end

		NPCsActive[npc_id] = true
		private.Config.Search.UpdateTab("NPC")

		return true
	end


	-- Ends actual scan for NPC.
	function NPCDeactivate(npc_id)
		if not NPCsActive[npc_id] then
			return
		end

		NPCsActive[npc_id] = nil
		ScanRemove(npc_id)
		private.Config.Search.UpdateTab("NPC")

		return true -- Successfully deactivated
	end


	function private.NPCIsActive(npc_id)
		return NPCsActive[npc_id]
	end

	function private.ClearActiveList()
		table.wipe(NPCsActive)
	end
end


-- Adds an NPC name and ID to settings and begins searching.
-- @param npc_id Numeric ID of the NPC (See Wowhead.com).
-- @param Name Temporary name to identify this NPC by in the search table.
-- @param WorldID Number or localized string WorldID to limit this search to.
-- @return True if custom NPC added.
function private.NPCAdd(npc_id, npc_name, world_id)
	local options = private.GlobalOptions
	npc_id = assert(tonumber(npc_id), "NpcID must be numeric.")

	if options.NPCs[npc_id] then
		return
	end
	assert(type(npc_name) == "string", "Name must be a string.")
	assert(world_id == nil or type(world_id) == "string" or type(world_id) == "number", "Invalid WorldID.")
	options.NPCs[npc_id] = npc_name
	options.NPCWorldIDs[npc_id] = world_id

	private.CUSTOM_NPC_ID_TO_NAME[npc_id] = npc_name
	private.CUSTOM_NPC_ID_TO_WORLD_NAME[npc_id] = world_id

	if not NPCActivate(npc_id, world_id) then
		-- Didn't activate; Just add row
		private.Config.Search.UpdateTab("NPC")
	end

	return true
end


-- Removes an NPC from settings and stops searching for it.
-- @param NpcID Numeric ID of the NPC.
-- @return True if custom NPC removed.
function private.NPCRemove(npc_id)
	local options = private.GlobalOptions
	npc_id = tonumber(npc_id)

	if not options.NPCs[npc_id] then
		return
	end
	options.NPCs[npc_id] = nil
	options.NPCWorldIDs[npc_id] = nil

	local npc_name = private.CUSTOM_NPC_ID_TO_NAME[npc_id]
	private.CUSTOM_NPC_ID_TO_NAME[npc_id] = nil
	private.CUSTOM_NPC_ID_TO_WORLD_NAME[npc_id] = nil

	if not NPCDeactivate(npc_id) then
		private.Config.Search.UpdateTab("NPC")
	end
	return true
end


-- Starts searching for an achievement's NPC if it meets all settings.
local function AchievementNPCActivate(achievement, npc_id, criteria_id)
	if (achievement.Active and not achievement.NPCsActive[npc_id]
		and (private.CharacterOptions.AchievementsAddFound or not select(3, GetAchievementCriteriaInfoByID(achievement.ID, criteria_id))) -- Not completed
		and ScanAdd(npc_id)) then
		achievement.NPCsActive[npc_id] = criteria_id
		private.Config.Search.UpdateTab(achievement.ID)
		return true
	end
end


-- Stops searching for an achievement's NPC.
local function AchievementNPCDeactivate(achievement, npc_id)
	if not achievement.NPCsActive[npc_id] then
		return
	end
	achievement.NPCsActive[npc_id] = nil
	ScanRemove(npc_id)
	private.Config.Search.UpdateTab(achievement.ID)
	return true
end


-- Starts actual scans for achievement NPCs if on the right world.
local function AchievementActivate(achievement)
	if achievement.Active or not IsMapIDCurrent(achievement.WorldID) then
		return
	end
	achievement.Active = true

	for criteria_id, npc_id in pairs(achievement.Criteria) do
		if not _G._NPCScanOptions.IgnoreList.NPCs[npc_id] and not IsNPCQuestComplete(npc_id) then
			AchievementNPCActivate(achievement, npc_id, criteria_id)
		end
	end
	return true
end


-- Ends actual scans for achievement NPCs.
local function AchievementDeactivate(achievement)
	if not achievement.Active then
		return
	end
	achievement.Active = nil

	for npc_id in pairs(achievement.NPCsActive) do
		AchievementNPCDeactivate(achievement, npc_id)
	end
	return true
end


-- @param achievement Achievement data table from NS.Achievements.
-- @return True if the achievement NPC is being searched for.
function private.AchievementNPCIsActive(achievement, npc_id)
	return achievement.NPCsActive[npc_id] ~= nil
end

-- Adds a kill-related achievement to track.
-- @param achievement_id Numeric ID of achievement.
-- @return True if achievement added.
function private.AchievementAdd(achievement_id)
	achievement_id = assert(tonumber(achievement_id), "AchievementID must be numeric.")
	local achievement = private.ACHIEVEMENTS[achievement_id]

	if not achievement then return false end

	if not next(private.CharacterOptions.Achievements) then -- First
	EventFrame:RegisterEvent("ACHIEVEMENT_EARNED")
	EventFrame:RegisterEvent("CRITERIA_UPDATE")
	end

	private.CharacterOptions.Achievements[achievement_id] = true
	private.Config.Search.AchievementSetEnabled(achievement_id, true)
	AchievementActivate(achievement)
	return true
end


-- Removes an achievement from settings and stops tracking it.
-- @param achievement_id Numeric ID of achievement.
-- @return True if achievement removed.
function private.AchievementRemove(achievement_id)
	if not private.CharacterOptions.Achievements[achievement_id] then
		return
	end
	AchievementDeactivate(private.ACHIEVEMENTS[achievement_id])
	private.CharacterOptions.Achievements[achievement_id] = false

	if not next(private.CharacterOptions.Achievements) then -- Last
	EventFrame:UnregisterEvent("ACHIEVEMENT_EARNED")
	EventFrame:UnregisterEvent("CRITERIA_UPDATE")
	end
	private.Config.Search.AchievementSetEnabled(achievement_id, false)
	return true
end


-- Adds a previously ignored Mob to be tracked.
-- @param Mob Id & World ID .
function private.ReactivateIgnoreMob(npc_id, world_id)
	NPCActivate(npc_id, world_id)
end


-- Removes an ignored Mob from being tracked.
-- @param Mob Id
function private.DeactivateIgnoreMob(npc_id)
	NPCDeactivate(npc_id)
end


-- Toggles a Mob type to track.
-- @param Identifier of Type and Toggle State.
function private.RareMobToggle(identifier, enable)
	local npc_list

	if identifier == "BEASTS" then
		private.CharacterOptions.TrackBeasts = enable
		private.Config.Search.AchievementSetEnabled(identifier, enable)
		npc_list = private.TAMABLE_ID_TO_NAME
	elseif identifier == "RARENPC" then
		private.CharacterOptions.TrackRares = enable
		private.Config.Search.AchievementSetEnabled(identifier, enable)
		npc_list = private.UNTAMABLE_ID_TO_NAME
	end

	if npc_list and enable then
		for npc_id, _ in pairs(npc_list) do
			if not _G._NPCScanOptions.IgnoreList.NPCs[npc_id] then
				NPCActivate(npc_id, private.NPC_ID_TO_WORLD_NAME[npc_id])
			end
		end
	elseif npc_list and not enable then
		for npc_id, _ in pairs(npc_list) do
			if private.NPCIsActive(npc_id) then
				NPCDeactivate(npc_id)
			end
		end
	end
end


-------------------------------------------------------------------------------
-- Config Menu Toggles.
-------------------------------------------------------------------------------

-- Enables adding a timestamp to printed messages.
function private.SetPrintTime(enable)
	private.CharacterOptions.PrintTime = enable
	private.Config.print_time_checkbox:SetChecked(enable)
end


-- Enables tracking of unneeded achievement NPCs.
function private.SetAchievementsAddFound(enable)
	private.CharacterOptions.AchievementsAddFound = enable
	private.Config.Search.add_found_checkbox:SetChecked(enable)

	for _, achievement in pairs(private.ACHIEVEMENTS) do
		-- Was active
		if AchievementDeactivate(achievement) then
			AchievementActivate(achievement)
		end
	end
end


-- Enables alerts to be displayed as toast display.
function private.SetShowAsToast(enable)
	private.CharacterOptions.ShowAlertAsToast = enable
	private.Config.show_as_toast_checkbox:SetChecked(enable)
end


-- Enables displayed toasts to be shown untill closed by the user.
function private.SetPersistentToast(enable)
	private.CharacterOptions.PersistentToast = enable
	private.Config.persistent_toast_checkbox:SetChecked(enable)
end


-- Enables unmuting sound to play found alerts.
function private.SetAlertSoundUnmute(enable)
	private.CharacterOptions.AlertSoundUnmute = enable
	private.Config.alert_unmute_checkbox:SetChecked(enable)
end


-- Enables screen edge flash to show on found alerts.
function private.SetAlertScreenEdgeFlash(enable)
	private.CharacterOptions.AlertScreenEdgeFlash = enable
	private.Config.screen_edge_flash_checkbox:SetChecked(enable)
end


-- Sets the sound to play when NPCs are found.
function private.SetAlertSound(alert_sound)
	assert(alert_sound == nil or type(alert_sound) == "string", "AlertSound must be a string or nil.")
	private.GlobalOptions.AlertSound = alert_sound
	_G.UIDropDownMenu_SetText(private.Config.alert_sound_dropdown, alert_sound == nil and L.CONFIG_ALERT_SOUND_DEFAULT or alert_sound)
end


-- Sets the icon to display over found NPC.
function private.SetTargetIcon(icon_id)
	icon_id = icon_id or private.NUM_RAID_ICONS
	private.CharacterOptions.TargetIcon = icon_id

	local icon_info = _G.UnitPopupButtons["RAID_TARGET_" .. icon_id]
	local colorCode = ("|cFF%02x%02x%02x"):format(icon_info.color.r * 255, icon_info.color.g * 255, icon_info.color.b * 255)
	_G.UIDropDownMenu_SetText(private.Config.alert_icon_dropdown, colorCode .. icon_info.text)
end


-- Enables Blocking alerts while on taxi.
function private.SetBlockFlightScan(enable)
	private.CharacterOptions.FlightSupress = enable
	private.Config.block_flight_scan_checkbox:SetChecked(enable)
	return enable
end


-- Enables Hellbane mob tracking when their icons appear on the world map.
function private.SetHellbaneScan(enable)
	private.CharacterOptions.TrackHellbane = enable
	private.Config.hellbane_scan_checkbox:SetChecked(enable)
	return enable
end


-- Enables tracking of mobs by Nameplate.
function private.SetNameplateScan(enable)
	private.CharacterOptions.TrackNameplate = enable
	private.Config.nameplate_scan_checkbox:SetChecked(enable)
	return enable
end


-- Enables tracking of mobs by Vignette.
function private.SetVignetteScan(enable)
	private.CharacterOptions.TrackVignettes = enable
	private.Config.viginette_scan_checkbox:SetChecked(enable)
	return enable
end

-- Enables Mouseover tracking.
function private.SetMouseoverScan(enable)
	private.CharacterOptions.TrackMouseover = enable
	private.Config.mouseover_scan_checkbox:SetChecked(enable)
	return enable
end

-- TODO: Either incorporate this, or scrap it. It's not used anywhere.
local IsDefaultNPCValid
do
	local TAMABLE_EXCEPTIONS = {
		[49822] = true -- Jadefang drops a pet
	}

	local NPC_FACTION = {
		[51071] = "Horde", -- Captain Florence
		[51079] = "Alliance", -- Captain Foulwind
		[68317] = "Horde", -- Mavis Harms
		[68318] = "Horde", -- Dalan Nightbreaker
		[68319] = "Horde", -- Disha Fearwarden
		[68320] = "Alliance", -- Ubunti the Shade
		[68321] = "Alliance", -- Kar Warmaker
		[68322] = "Alliance", -- Muerta
	}

	local PLAYER_CLASS = _G.select(2, _G.UnitClass("player"))
	local PLAYER_FACTION = _G.UnitFactionGroup("player")

	-- @return True if NpcID should be a default for this character.
	function IsDefaultNPCValid(npc_id)
		return (PLAYER_CLASS == "HUNTER" or not private.TAMABLE_ID_TO_NAME[npc_id] or TAMABLE_EXCEPTIONS[npc_id]) and (not NPC_FACTION[npc_id] or NPC_FACTION[npc_id] == PLAYER_FACTION)
	end
end


-- Resets the scanning list and reloads it from saved settings.
function private.Synchronize()
	for var, value in pairs(GlobalOptionsDefault) do
		private.GlobalOptions[var] = private.GlobalOptions[var] == nil and value or private.GlobalOptions[var]
	end

	local options = private.GlobalOptions
	local character_options = private.CharacterOptions

	assert(not next(private.ScanIDs), "Orphan NpcIDs in scan pool!")

	private.SetPrintTime(character_options.PrintTime)
	private.SetAchievementsAddFound(character_options.AchievementsAddFound)
	private.SetShowAsToast(character_options.ShowAlertAsToast)
	private.SetPersistentToast(character_options.PersistentToast)
	private.SetAlertSoundUnmute(character_options.AlertSoundUnmute)
	private.SetAlertScreenEdgeFlash(character_options.AlertScreenEdgeFlash)
	private.SetTargetIcon(character_options.TargetIcon)
	private.SetAlertSound(options.AlertSound)
	private.SetNameplateScan(character_options.TrackNameplate)
	private.SetVignetteScan(character_options.TrackVignettes)
	private.SetHellbaneScan(character_options.TrackHellbane)
	private.SetMouseoverScan(character_options.TrackMouseover)
	private.SetBlockFlightScan(character_options.FlightSupress)
	private.RareMobToggle("BEASTS", character_options.TrackBeasts)
	private.RareMobToggle("RARENPC", character_options.TrackRares)

	for achievement_id, achievement in pairs(private.ACHIEVEMENTS) do
		-- If defaults, don't enable completed achievements unless explicitly allowed
		if character_options.Achievements[achievement_id] then
			private.AchievementAdd(achievement_id)
		else
			private.AchievementRemove(achievement_id)
			private.Config.Search.AchievementSetEnabled(achievement_id, false)
		end
	end

	--Builds custom NPC lookup tables
	for npc_id, npc_name in pairs(private.GlobalOptions.NPCs) do
		private.CUSTOM_NPC_ID_TO_NAME[npc_id] = npc_name
		private.CUSTOM_NPC_ID_TO_WORLD_NAME[npc_id] = private.GlobalOptions.NPCWorldIDs[npc_id]
	end
end


-- An anti spam function to throttle spammy events
-- @param time the time to wait between two events (optional, default 2.5 seconds)
-- @param id the id to distinguish different events (optional, only necessary if your mod keeps track of two different spam events at the same time)
function private.AntiSpam(time, id)
	if _G.GetTime() - (id and (antiSpamList["lastAntiSpam" .. tostring(id)] or 0) or lastAntiSpam or 0) > (time or 2.5) then
		if id then
			antiSpamList["lastAntiSpam" .. tostring(id)] = _G.GetTime()
		else
			lastAntiSpam = _G.GetTime()
		end
		return true
	else
		return false
	end
end


local OnFound
do
	local PetList = {}

	local function GetScanSource(npc_id)
		local custom_name = private.GlobalOptions.NPCs[npc_id]

		if custom_name then
			return custom_name
		end

		for achievement_id in pairs(private.CharacterOptions.Achievements) do
			if private.ACHIEVEMENTS[achievement_id].NPCsActive[npc_id] then
				return _G.GetAchievementLink(achievement_id)
			end
		end
	end

	-- Validates found mobs before showing alerts.
	function OnFound(npcID, unitToken, sourceText)
		local npcName = _G.UnitName(unitToken)

		if private.CharacterOptions.FlightSupress and _G.UnitOnTaxi("player") then
			_G.SetMapToCurrentZone()
			_G.PlaySound("TellMessage", "master")

			local x, y = _G.GetPlayerMapPosition("player")
			private.Print(L.FOUND_UNIT_TAXI:format(npcName, x * 100, y * 100, _G.GetZoneText()))

			return
		end

		local isTamable = private.TAMABLE_ID_TO_NAME[npcID] or false

		if private.AntiSpam(private.ANTI_SPAM_DELAY, npcName) then
			local alertText = ("%s %s"):format(L[isTamable and "FOUND_TAMABLE_FORMAT" or "FOUND_FORMAT"]:format(npcName), _G.PARENS_TEMPLATE:format(sourceText))

			if private.CharacterOptions.ShowAlertAsToast then
				Toast:Spawn("_NPCScanAlertToast", alertText)
			else
				private.Print(alertText, _G.GREEN_FONT_COLOR)
			end

			private.Button:SetNPC(npcID, npcName, GetScanSource(npcID)) -- Sends added and found overlay messages

			if _G.GetRaidTargetIndex(unitToken) ~= private.CharacterOptions.TargetIcon and (not _G.IsInRaid() or (_G.UnitIsGroupAssistant("player") or _G.UnitIsGroupLeader("player"))) then
				_G.SetRaidTarget(unitToken, private.CharacterOptions.TargetIcon)
			end
		end
	end

	local criteria_updated_bucket

	function EventFrame:CRITERIA_UPDATE()
		criteria_updated_bucket = true
	end


	-- Scans all NPCs on a timer and alerts if any are found.
	function private.Updater:OnLoop()
		if criteria_updated_bucket then
			criteria_updated_bucket = false

			if not private.CharacterOptions.AchievementsAddFound then
				for achievement_id in pairs(private.CharacterOptions.Achievements) do
					local achievement = private.ACHIEVEMENTS[achievement_id]

					for npc_id, criteria_id in pairs(achievement.NPCsActive) do
						local _, _, is_completed = _G.GetAchievementCriteriaInfoByID(achievement_id, criteria_id)

						if is_completed then
							AchievementNPCDeactivate(achievement, npc_id)
						end
					end
				end
			end
		end
	end
end

--Initializes Ace Database for profile & adds profile menu to Blizzard menu
function private.Ace:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("_NPCScanProfiles", ProfileDefaults, true)
	ProfileOptions.args.Profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
	LibStub("AceConfig-3.0"):RegisterOptionsTable(FOLDER_NAME, ProfileOptions)
	LibStub("AceConfigDialog-3.0"):AddToBlizOptions(FOLDER_NAME, "Profiles", L.CONFIG_TITLE, "Profiles")

	self.db.RegisterCallback(self, "OnProfileChanged", "RefreshProfile")
	self.db.RegisterCallback(self, "OnProfileCopied", "RefreshProfile")
	self.db.RegisterCallback(self, "OnProfileReset", "RefreshProfile")

	--Save any old setting to character profile
	local charName = _G.UnitName("player") .. " - " .. _G.GetRealmName()
	if _G._NPCScanOptionsCharacter then
		if not _G._NPCScanProfiles.profiles then _G._NPCScanProfiles.profiles = {} end
		_G._NPCScanProfiles.profiles[charName] = {}
		for var, value in pairs(_G._NPCScanOptionsCharacter) do
			_NPCScanProfiles.profiles[charName][var] = value
		end
	end
end


--Called whenever profile is changed to reload new settings
function private.Ace:RefreshProfile()
	for npc_id, _ in pairs(private.ScanIDs) do
		NPCDeactivate(npc_id)
	end

	private.CharacterOptions = private.Ace.db.profile
	EventFrame:PLAYER_LEAVING_WORLD()

	table.wipe(private.ScanIDs)
	private.ClearActiveList()

	private.Synchronize()
end


-- Loads defaults, validates settings, and starts scan.
-- Used instead of ADDON_LOADED to give overlay mods a chance to load and register for messages.
function EventFrame:PLAYER_LOGIN(event_name)
	if _G.IsAddOnLoaded("_NPCScan.AutoAdd") then
		if _G.GetAddOnMetadata("_NPCScan.AutoAdd", "Version"):match("^([%d.]+)") <= "2.2" then
			Dialog:Spawn("NPCSCAN_AUTOADD_WARNING")
		end
	end

	private.GlobalOptions = _G._NPCScanOptions
	private.CharacterOptions = private.Ace.db.profile
	private.Overlays.Register()
	private.Synchronize()

	self[event_name] = nil
end


function EventFrame:UpdateScanningData(eventName, mapID)
	currentMapID = mapID

	local currentMapNPCs = private.MapNPCs[mapID]
	if not currentMapNPCs then
		return
	end
	local characterOptions = private.CharacterOptions

	for npcID in pairs(currentMapNPCs) do
		if not private.GlobalOptions.IgnoreList.NPCs[npcID] then
			local npcData = private.NPCData[npcID]
			local isTamable = npcData and npcData.isTamable

			if characterOptions.TrackRares and not isTamable then
				NPCActivate(npcID)
			end

			if characterOptions.TrackBeasts and isTamable then
				NPCActivate(npcID)
			end
		end
	end

	for achievement_id, enable in pairs(private.CharacterOptions.Achievements) do
		local achievement = private.ACHIEVEMENTS[achievement_id]
		if achievement.WorldID and enable then
			AchievementActivate(achievement)
		end
	end

	-- Removes any one time kill / daily kill rares that have been completed
	for npc_id, quest_id in pairs(private.NPC_ID_TO_QUEST_ID) do
		if IsNPCQuestComplete(npc_id) then
			NPCDeactivate(npc_id)
		else
			active_tracking_quest_mobs[npc_id] = quest_id
		end
	end

	-- Adds any custom mobs
	for npcID in pairs(private.GlobalOptions.NPCs) do
		NPCActivate(npcID, private.GlobalOptions.NPCWorldIDs[npcID])
	end

	private.Config.Search:UpdateTabNames()
end

HereBeDragons.RegisterCallback(EventFrame, "PlayerZoneChanged", "UpdateScanningData")


function EventFrame:PLAYER_LEAVING_WORLD()
	if private.GlobalOptions.NPCWorldIDs then
		for npc_id in pairs(private.GlobalOptions.NPCWorldIDs) do
			NPCDeactivate(npc_id)
		end
	end

	for npc_id, world_id in pairs(private.TAMABLE_ID_TO_WORLD_NAME) do
		if world_id == currentMapID then
			NPCDeactivate(npc_id)
		end
	end

	for npc_id, world_id in pairs(private.UNTAMABLE_ID_TO_WORLD_NAME) do
		if world_id == currentMapID then
			NPCDeactivate(npc_id)
		end
	end

	for achievement_id in pairs(private.CharacterOptions.Achievements) do
		local achievement = private.ACHIEVEMENTS[achievement_id]
		if achievement.WorldID then
			AchievementDeactivate(achievement)
		end
	end

	currentMapID = nil
end


function EventFrame:ACHIEVEMENT_EARNED(_, achievement_id)
	if not private.ACHIEVEMENTS[achievement_id] then
		return
	end
	private.ACHIEVEMENTS[achievement_id].is_completed = true

	if not private.CharacterOptions.AchievementsAddFound then
		private.AchievementRemove(achievement_id)
	end
end


--Using this to check for kill track quests as they only complete after looting
function EventFrame:LOOT_CLOSED(event_name)
	--Removes any one time kill / daily kill rares that have been completed
	for npc_id, quest_id in pairs(active_tracking_quest_mobs) do
		if IsNPCQuestComplete(npc_id) then
			NPCDeactivate(npc_id)
			active_tracking_quest_mobs[npc_id] = nil
		end
	end
end


do
	local SUBCOMMAND_FUNCS = {
		[L.CMD_ADD] = function(arguments)
			local id, name = arguments:match("^(%d+)%s+(.+)$")
			id = tonumber(id)

			if not id then
				return
			end

			private.NPCRemove(id)
			private.NPCAdd(id, name)
		end,
		[L.CMD_REMOVE] = function(arguments)
			local id = tonumber(arguments)

			if not id then
				for npc_id, npc_name in pairs(private.GlobalOptions.NPCs) do
					if npc_name == arguments then
						id = npc_id
						break
					end
				end
			end

			if not private.NPCRemove(id) then
				private.Print(L.CMD_REMOVENOTFOUND_FORMAT:format(arguments), _G.RED_FONT_COLOR)
			end
		end,
		--@debug@
		DEBUG = function()
			debugger = debugger or CreateDebugFrame()

			if debugger:Lines() == 0 then
				debugger:AddLine("Nothing to report.")
				debugger:Display()
				debugger:Clear()
				return
			end
			debugger:Display()
		end,
		DUMP = function()
			private.TextDump = private.TextDump or _G.LibStub("LibTextDump-1.0"):New(FOLDER_NAME)
			private.DumpNewTables()
		end,
		--@end-debug@
	}


	_G.SlashCmdList["_NPCSCAN"] = function(input)
		local subcommand, arguments = input:match("^(%S+)%s*(.-)%s*$")
		if subcommand then
			local func = SUBCOMMAND_FUNCS[subcommand:upper()]
			if func then
				func(arguments)
			else
				private.Print(L.CMD_HELP)
			end
		else
			_G.InterfaceOptionsFrame_OpenToCategory(private.Config.Search)
		end
	end
end -- do-block


if _G.IsLoggedIn() then
	EventFrame:PLAYER_LOGIN("PLAYER_LOGIN")
else
	EventFrame:RegisterEvent("PLAYER_LOGIN")
end


-------------------------------------------------------------------------------
-- Nameplate scanning.
-------------------------------------------------------------------------------
local function UnitTokenToCreatureID(unitToken)
	if unitToken then
		local GUID = _G.UnitGUID(unitToken)
		if not GUID then
			return
		end

		local unitTypeName, _, _, _, _, unitID = ("-"):split(GUID)
		if unitTypeName == "Creature" then
			return tonumber(unitID)
		end
	end
end

function EventFrame:NAME_PLATE_UNIT_ADDED(eventName, nameplateUnitToken)
	if not private.CharacterOptions.TrackNameplate or _G.UnitIsUnit("player", nameplateUnitToken) or _G.UnitIsFriend("player", nameplateUnitToken) or _G.UnitIsDeadOrGhost(nameplateUnitToken) then
		return
	end

	local unitID = UnitTokenToCreatureID(nameplateUnitToken)
	if private.ScanIDs[unitID] and not _G._NPCScanOptions.IgnoreList.NPCs[unitID] then
		OnFound(unitID, nameplateUnitToken, _G.UNIT_NAMEPLATES)
	end
end

-------------------------------------------------------------------------------
-- Mouseover Trigger Functions
-------------------------------------------------------------------------------
function EventFrame:UPDATE_MOUSEOVER_UNIT()
	if not private.CharacterOptions.TrackMouseover or _G.UnitIsDeadOrGhost("mouseover") then
		return
	end

	local mouseoverID = UnitTokenToCreatureID("mouseover")
	local targetID = UnitTokenToCreatureID("target")
	if mouseoverID ~= targetID and private.ScanIDs[mouseoverID] and not _G._NPCScanOptions.IgnoreList.NPCs[mouseoverID] then
		OnFound(mouseoverID, "mouseover", _G.MOUSE_LABEL)
	end
end


-------------------------------------------------------------------------------
-- Dynamic Target Macro Functions
-------------------------------------------------------------------------------
local MacroDelay = false
local target_button = _G.CreateFrame("Button", "_NPCScan_Search_Button", _G.UIParent, "SecureActionButtonTemplate,SecureHandlerShowHideTemplate")
target_button:Hide()

target_button:SetAttribute("type", "macro")
target_button:SetAttribute("macrotext", private.macrotext)
target_button:RegisterEvent("PLAYER_REGEN_ENABLED")
target_button:SetScript("OnEvent", function(self, event_name, ...)
	if event_name == "PLAYER_REGEN_ENABLED" then
		-- Only needs to trigger after combat if a delay was set
		if not MacroDelay then
			return
		end
		MacroDelay = false
	end

	private.GenerateTargetMacro()
end)

function private.GenerateTargetMacro(instanceID)
	if _G.InCombatLockdown() then
		MacroDelay = true
		return
	end

	local mapID = HereBeDragons:GetPlayerZone()
	if not mapID then
		return
	end

	local zoneName = _G.GetMapNameByID(mapID)
	local continentID = HereBeDragons:GetCZFromMapID(mapID)

	private.macrotext = "/cleartarget"

	for npcID, mapZoneName in pairs(private.NPC_ID_TO_MAP_NAME) do
		if zoneName == mapZoneName and not _G._NPCScanOptions.IgnoreList.NPCs[npcID] and private.ScanIDs[npcID] then
			private.macrotext = private.MACRO_FORMAT:format(private.macrotext, private.NPC_ID_TO_NAME[npcID])
		end
	end

	if _G._NPCScanOptions.NPCs then
		for npcID, npcName in pairs(_G._NPCScanOptions.NPCs) do
			if not _G._NPCScanOptions.IgnoreList.NPCs[npcID] then
				local npcWorldID = _G._NPCScanOptions.NPCWorldIDs[npcID]

				if not npcWorldID or npcWorldID == private.LOCALIZED_CONTINENT_NAMES[continentID] then
					private.macrotext = private.MACRO_FORMAT_CUSTOM_MOB:format(private.macrotext, npcName)
				end
			end
		end
	end

	if instanceID then
		private.macrotext = private.macrotext .. "\n/run _G._NPCScan.SetVignetteTarget()"
	else
		private.macrotext = private.macrotext .. "\n/run _G._NPCScan.CheckMacroTarget()"
	end

	target_button:SetAttribute("macrotext", private.macrotext)
end

--Checks target found by macro and triggers NPCScan alert for tracked mobs
function private.CheckMacroTarget()
	if _G.UnitIsDeadOrGhost("target") then
		return
	end

	local targetID = UnitTokenToCreatureID("target")

	if private.ScanIDs[targetID] and not _G._NPCScanOptions.IgnoreList.NPCs[targetID] then
		OnFound(targetID, "target", _G.TARGET)
	end
end

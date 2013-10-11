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
local L = private.L
_G._NPCScan = private

private.Frame = _G.CreateFrame("Frame")
private.Frame:RegisterEvent("PLAYER_ENTERING_WORLD")
private.Frame:RegisterEvent("PLAYER_LEAVING_WORLD")
private.Frame:RegisterEvent("PLAYER_UPDATE_RESTING")
private.Frame:SetScript("OnEvent", function(self, event_name, ...)
	if self[event_name] then
		return self[event_name](self, event_name, ...)
	end
end)

private.Updater = private.Frame:CreateAnimationGroup()
private.Updater.UpdateRate = 0.5
private.Updater:CreateAnimation("Animation"):SetDuration(private.Updater.UpdateRate)
private.Updater:SetLooping("REPEAT")


-------------------------------------------------------------------------------
-- Constants.
-------------------------------------------------------------------------------
local DB_VERSION = 1
local PLAYER_CLASS = _G.select(2, _G.UnitClass("player"))
local PLAYER_FACTION = _G.UnitFactionGroup("player")


-------------------------------------------------------------------------------
-- Variables.
-------------------------------------------------------------------------------
private.Options = {
	Version = DB_VERSION,
	NPCs = {},
	NPCWorldIDs = {},
}

private.OptionsCharacter = {
	Version = DB_VERSION,
	Achievements = {},
	AchievementsAddFound = nil,
	AlertSoundUnmute = nil,
	AlertSound = nil, -- Default sound
	CacheWarnings = true,
	FlightSupress = true,
	Modules = {},
	ModulesAlpha = {},
	ModulesExtra = {},
	ModulesSaved = {},
	NPCWorldIDs = {},
	ShowAll = false,
	TrackBeasts = true,
	TrackRares = true,
}

private.OptionsDefault = {
	Version = DB_VERSION,
	NPCs = {
		[64004] = "Ghostly Pandaren Fisherman",
		[64191] = "Ghostly Pandaren Craftsman",
		[50409] = "Mysterious Camel Figurine",
		[50410] = "Mysterious Camel Figurine",
	},
	NPCWorldIDs = {
		[50409] = 1, -- Mysterious Camel Figurine
		[50410] = 1, -- Mysterious Camel Figurine
		[64004] = 6, --"Ghostly Pandaren Fisherman"
		[64191] = 6, --"Ghostly Pandaren Craftsman"
	},
}

private.OptionsCharacterDefault = {
	Version = DB_VERSION,
	Achievements = {
		[1312] = true, -- Bloody Rare (Outlands)
		[2257] = true, -- Frostbitten (Northrend)
		[7439] = true, -- Glorious! (Pandaria)
		[8103] = true, -- Champions of Lei Shen
		[8714] = true, --Timeless Champion
		[7317] = true, -- One Of Many
	},
	AchievementsAddFound = nil,
	AlertSoundUnmute = nil,
	AlertSound = nil, -- Default sound
	CacheWarnings = true,
	FlightSupress = true,
	Modules = {},
	ModulesSaved = {},
	ModulesAlpha = {},
	ModulesExtra = {},
	NPCWorldIDs = {},
	ShowAll = false,
	TrackBeasts = true,
	TrackRares = true,
}


do
	private.Achievements = {
		-- Criteria data for each achievement.
		[1312] = { WorldID = 3 }, -- Bloody Rare (Outlands)
		[2257] = { WorldID = 4 }, -- Frostbitten (Northrend)
		[7439] = { WorldID = 6 }, -- Glorious! (Pandaria)
		[7317] = { WorldID = 6 }, -- One Of Many
		[8103] = { WorldID = 6 }, -- Champions of Lei Shen
		[8714] = { WorldID = 6 }, -- Timeless Champion
	}

	for achievement_id, achievement in pairs(private.Achievements) do
		achievement.ID = achievement_id
		achievement.Criteria = {} -- [ CriteriaID ] = NpcID
		achievement.NPCsActive = {} -- [ NpcID ] = CriteriaID

		for criteria_index = 1, _G.GetAchievementNumCriteria(achievement_id) do
			local _, criteria_type, _, _, _, _, _, asset_id, _, criteria_id = _G.GetAchievementCriteriaInfo(achievement_id, criteria_index)
			if criteria_type == 0 then -- Mob kill type
				achievement.Criteria[criteria_id] = asset_id
			end
		end
	end
end -- do-block


do
	local VIRTUAL_CONTINENTS = {
		[5] = true -- The Maelstrom
	}

	private.ContinentNames = { _G.GetMapContinents() }
	for continent_id in pairs(VIRTUAL_CONTINENTS) do
		-- Continents without physical maps aren't used.
		private.ContinentNames[continent_id] = nil
	end

	private.ContinentIDs = {}
	for continent_id, continent_name in pairs(private.ContinentNames) do
		private.ContinentIDs[continent_name] = continent_id
	end

end


private.NpcIDMax = 0xFFFFF --- Largest ID that will fit in a GUID's 20-bit NPC ID field.


-------------------------------------------------------------------------------
-- Helpers.
-------------------------------------------------------------------------------
function private.Print(Message, Color)
	if not Color then
		Color = _G.NORMAL_FONT_COLOR
	end
	_G.DEFAULT_CHAT_FRAME:AddMessage(L.PRINT_FORMAT:format(private.Options.PrintTime and _G.date(_G.CHAT_TIMESTAMP_FORMAT or L.TIME_FORMAT) or "", Message), Color.r, Color.g, Color.b)
end


do
	local Tooltip = _G.CreateFrame("GameTooltip", "_NPCScanTooltip")

	-- Add template text lines
	local Text = Tooltip:CreateFontString()
	Tooltip:AddFontStrings(Text, Tooltip:CreateFontString())
	--- Checks the cache for a given NpcID.
	-- @return Localized name of the NPC if cached, or nil if not.
	function private.TestID(NpcID)
		Tooltip:SetOwner(_G.WorldFrame, "ANCHOR_NONE")
		Tooltip:SetHyperlink(("unit:0xF53%05X00000000"):format(NpcID))

		if Tooltip:IsShown() then
			return Text:GetText()
		end
	end
end


local CacheListBuild
do
	local build_list = {}
	local id_registry = {}

	--- Compiles a cache list into a printable list string.
	-- @param Relist True to relist NPC names that have already been printed.
	-- @return List string, or nil if the list was empty.
	function CacheListBuild(source_data, should_relist)
		if not next(source_data) then
			return
		end
		table.wipe(build_list)

		for npc_id, npc_name in pairs(source_data) do
			if should_relist or not id_registry[npc_id] then
				if not should_relist then
					id_registry[npc_id] = true
				end
				build_list[#build_list + 1] = L.CACHELIST_ENTRY_FORMAT:format(npc_name)
			end
		end
		table.wipe(source_data)

		if #build_list > 0 then
			table.sort(build_list)
			return table.concat(build_list, L.CACHELIST_SEPARATOR)
		end
	end
end

local CacheList = {}
do
	--- Fills a cache list with all added NPCs, active or not.
	local function CacheListPopulate(self)
		for NpcID in pairs(private.Options.NPCs) do
			self[NpcID] = private.TestID(NpcID)
		end

		if private.OptionsCharacter.TrackBeasts then
			for NpcID in pairs(private.TamableIDs) do
				self[NpcID] = private.TestID(NpcID)
			end
		end

		if private.OptionsCharacter.TrackRares then
			for NpcID in pairs(private.RareMobData.RareNPCs) do
				self[NpcID] = private.TestID(NpcID)
			end
		end

		for AchievementID in pairs(private.OptionsCharacter.Achievements) do
			for CriteriaID, NpcID in pairs(private.Achievements[AchievementID].Criteria) do
				if private.OptionsCharacter.AchievementsAddFound or not select(3, GetAchievementCriteriaInfoByID(AchievementID, CriteriaID)) then -- Not completed
					self[NpcID] = private.TestID(NpcID)
				end
			end
		end
	end

	local FirstPrint = true
	--- Prints a standard message listing cached mobs.
	-- Will also print details about the cache the first time it's called.
	-- @param ForcePrint Overrides the user's option to not print cache warnings.
	-- @param FullListing Adds all cached NPCs before printing, active or not.
	-- @return True if list printed.
	function private.CacheListPrint(ForcePrint, FullListing)
		if ForcePrint or private.Options.CacheWarnings then
			if FullListing then
				CacheListPopulate(CacheList)
			end
			local ListString = CacheListBuild(CacheList, ForcePrint or FullListing) -- Allow printing an NPC a second time if forced or full listing

			if ListString then
				private.Print(L[FirstPrint and "CACHED_LONG_FORMAT" or "CACHED_FORMAT"]:format(ListString), ForcePrint and _G.RED_FONT_COLOR)
				FirstPrint = false
				return true
			end
		else
			table.wipe(CacheList)
		end
	end
end

local ScanIDs = {} --- [ NpcID ] = Number of concurrent scans for this ID
--- Begins searching for an NPC.
-- @return True if successfully added.
local function ScanAdd(NpcID)
	local Name = private.TestID(NpcID)
	if Name then -- Already seen
		CacheList[NpcID] = Name
	else -- Increment
		if ScanIDs[NpcID] then
			ScanIDs[NpcID] = ScanIDs[NpcID] + 1
		else
			if not next(ScanIDs) then -- First
				private.Updater:Play()
			end
			ScanIDs[NpcID] = 1
			private.Overlays.Add(NpcID)
		end
		return true -- Successfully added
	end
end

--- Stops searching for an NPC when nothing is searching for it.
local function ScanRemove(NpcID)
	local Count = assert(ScanIDs[NpcID], "Attempt to remove inactive scan.")
	if Count > 1 then
		ScanIDs[NpcID] = Count - 1
	else
		ScanIDs[NpcID] = nil
		private.Overlays.Remove(NpcID)
		if not next(ScanIDs) then -- Last
			private.Updater:Stop()
		end
	end
end




--- @return True if the given WorldID is active on the current world.
local function IsWorldIDActive(WorldID)
	return not WorldID or WorldID == private.WorldID -- False/nil active on all worlds
end

local NPCActivate, NPCDeactivate
do
	local NPCsActive = {}
	--- Starts actual scan for NPC if on the right world.
	function NPCActivate(NpcID, WorldID)
		if not NPCsActive[NpcID] and IsWorldIDActive(WorldID) and ScanAdd(NpcID) then
			NPCsActive[NpcID] = true
			private.Config.Search.UpdateTab("NPC")
			return true -- Successfully activated
		end
	end

	--- Ends actual scan for NPC.
	function NPCDeactivate(NpcID)
		if not NPCsActive[NpcID] then
			return
		end
		NPCsActive[NpcID] = nil
		ScanRemove(NpcID)
		private.Config.Search.UpdateTab("NPC")
		return true -- Successfully deactivated
	end

	--- @return True if a custom NPC is actively being searched for.
	function private.NPCIsActive(NpcID)
		return NPCsActive[NpcID]
	end
end
--- Adds an NPC name and ID to settings and begins searching.
-- @param npc_id Numeric ID of the NPC (See Wowhead.com).
-- @param Name Temporary name to identify this NPC by in the search table.
-- @param WorldID Number or localized string WorldID to limit this search to.
-- @return True if custom NPC added.
function private.NPCAdd(npc_id, npc_name, world_id)
	local options = private.Options
	npc_id = assert(tonumber(npc_id), "NpcID must be numeric.")

	if options.NPCs[npc_id] then
		return
	end
	assert(type(npc_name) == "string", "Name must be a string.")
	assert(world_id == nil or type(world_id) == "string" or type(world_id) == "number", "Invalid WorldID.")
	options.NPCs[npc_id] = npc_name
	options.NPCWorldIDs[npc_id] = world_id

	if not NPCActivate(npc_id, world_id) then -- Didn't activate
		private.Config.Search.UpdateTab("NPC") -- Just add row
	end
	return true
end

--- Removes an NPC from settings and stops searching for it.
-- @param NpcID Numeric ID of the NPC.
-- @return True if custom NPC removed.
function private.NPCRemove(npc_id)
	local options = private.Options
	npc_id = tonumber(npc_id)

	if not options.NPCs[npc_id] then
		return
	end
	options.NPCs[npc_id] = nil
	options.NPCWorldIDs[npc_id] = nil

	if not NPCDeactivate(npc_id) then
		private.Config.Search.UpdateTab("NPC")
	end
	return true
end


--- Starts searching for an achievement's NPC if it meets all settings.
local function AchievementNPCActivate(achievement, npc_id, criteria_id)
	if (achievement.Active and not achievement.NPCsActive[npc_id]
		and (private.OptionsCharacter.AchievementsAddFound or not select(3, GetAchievementCriteriaInfoByID(achievement.ID, criteria_id))) -- Not completed
		and ScanAdd(npc_id)) then
		achievement.NPCsActive[npc_id] = criteria_id
		private.Config.Search.UpdateTab(achievement.ID)
		return true
	end
end

--- Stops searching for an achievement's NPC.
local function AchievementNPCDeactivate(achievement, npc_id)
	if not achievement.NPCsActive[npc_id] then
		return
	end
	achievement.NPCsActive[npc_id] = nil
	ScanRemove(npc_id)
	private.Config.Search.UpdateTab(achievement.ID)
	return true
end

--- Starts actual scans for achievement NPCs if on the right world.
local function AchievementActivate(achievement)
	if achievement.Active or not IsWorldIDActive(achievement.WorldID) then
		return
	end
	achievement.Active = true

	for criteria_id, npc_id in pairs(achievement.Criteria) do
		AchievementNPCActivate(achievement, npc_id, criteria_id)
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

--- @param achievement Achievement data table from NS.Achievements.
-- @return True if the achievement NPC is being searched for.
function private.AchievementNPCIsActive(achievement, npc_id)
	return achievement.NPCsActive[npc_id] ~= nil
end

--- Adds a kill-related achievement to track.
-- @param achievement_id Numeric ID of achievement.
-- @return True if achievement added.
function private.AchievementAdd(achievement_id)
	achievement_id = assert(tonumber(achievement_id), "AchievementID must be numeric.")
	local achievement = private.Achievements[achievement_id]

	if not achievement or private.OptionsCharacter.Achievements[achievement_id] then
		return
	end

	if not next(private.OptionsCharacter.Achievements) then -- First
		private.Frame:RegisterEvent("ACHIEVEMENT_EARNED")
		private.Frame:RegisterEvent("CRITERIA_UPDATE")
	end
	private.OptionsCharacter.Achievements[achievement_id] = true
	private.Config.Search.AchievementSetEnabled(achievement_id, true)
	AchievementActivate(achievement)
	return true
end

--- Removes an achievement from settings and stops tracking it.
-- @param achievement_id Numeric ID of achievement.
-- @return True if achievement removed.
function private.AchievementRemove(achievement_id)
	if not private.OptionsCharacter.Achievements[achievement_id] then
		return
	end
	AchievementDeactivate(private.Achievements[achievement_id])
	private.OptionsCharacter.Achievements[achievement_id] = nil

	if not next(private.OptionsCharacter.Achievements) then -- Last
		private.Frame:UnregisterEvent("ACHIEVEMENT_EARNED")
		private.Frame:UnregisterEvent("CRITERIA_UPDATE")
	end
	private.Config.Search.AchievementSetEnabled(achievement_id, false)
	return true
end

--- Adds a kill-related achievement to track.
-- @param AchievementID Numeric ID of achievement.
-- @return True if achievement added.
function private.SetRareMob(ID, enable)
	if ID == "BEASTS" then
		private.OptionsCharacter.TrackBeasts = enable or nil
		private.Config.Search.AchievementSetEnabled(ID, enable)
		return true
	elseif ID == "RARENPC" then
		private.OptionsCharacter.TrackRares = enable or nil
		private.Config.Search.AchievementSetEnabled(ID, enable)
		return true
	end
end

function private.RareMobToggle(ID, enable)
	local Mobs

	if ID == "BEASTS" then
		Mobs = private.TamableIDs
	elseif ID == "RARENPC" then
		Mobs = private.RareMobData.RareNPCs
	end

	if enable then
		--Loads Rare Mob Databas
		for NpcID, _ in pairs(Mobs) do
			local WorldID = private.RareMobData.NPCWorldIDs[NpcID]
			NPCActivate(NpcID, WorldID)
		end
	else
		for NpcID, _ in pairs(Mobs) do
			local WorldID = private.RareMobData.NPCWorldIDs[NpcID]
			NPCDeactivate(NpcID)
		end
	end
end

--- Enables printing cache lists on login.
-- @return True if changed.
function private.SetCacheWarnings(enable)
	if not enable ~= not private.Options.CacheWarnings then
		private.Options.CacheWarnings = enable or nil

		private.Config.CacheWarnings:SetChecked(enable)
		return true
	end
end

--- Enables adding a timestamp to printed messages.
-- @return True if changed.
function private.SetPrintTime(enable)
	if not enable ~= not private.Options.PrintTime then
		private.Options.PrintTime = enable or nil

		private.Config.PrintTime:SetChecked(enable)
		return true
	end
end

--- Enables tracking of unneeded achievement NPCs.
-- @return True if changed.
function private.SetAchievementsAddFound(enable)
	if not enable ~= not private.OptionsCharacter.AchievementsAddFound then
		private.OptionsCharacter.AchievementsAddFound = enable or nil
		private.Config.Search.AddFoundCheckbox:SetChecked(enable)

		for _, Achievement in pairs(private.Achievements) do
			if AchievementDeactivate(Achievement) then -- Was active
				AchievementActivate(Achievement)
			end
		end
		return true
	end
end

--- Enables unmuting sound to play found alerts.
-- @return True if changed.
function private.SetAlertSoundUnmute(enable)
	if not enable ~= not private.OptionsCharacter.AlertSoundUnmute then
		private.OptionsCharacter.AlertSoundUnmute = enable or nil

		private.Config.AlertSoundUnmute:SetChecked(enable)
		return true
	end
end

--- Sets the sound to play when NPCs are found.
-- @return True if changed.
function private.SetAlertSound(AlertSound)
	assert(AlertSound == nil or type(AlertSound) == "string", "AlertSound must be a string or nil.")
	if AlertSound ~= private.OptionsCharacter.AlertSound then
		private.OptionsCharacter.AlertSound = AlertSound

		UIDropDownMenu_SetText(private.Config.AlertSound, AlertSound == nil and L.CONFIG_ALERT_SOUND_DEFAULT or AlertSound)
		return true
	end
end

--- Enables Blocking alerts while on taxi.
-- @return True if changed.
function private.SetBlockFlightScan(Enable)
	private.OptionsCharacter.FlightSupress = Enable
	private.Config.Search.BlockFlightScanCheckbox:SetChecked(Enable)
	return Enable
end


local IsDefaultNPCValid
do
	local TAMABLE_EXCEPTIONS = {
		[49822] = true -- Jadefang drops a pet
	}

	local NPC_FACTION = {
		[51071] = "Horde", -- Captain Florence
		[51079] = "Alliance", -- Captain Foulwind
	}

	--- @return True if NpcID should be a default for this character.
	function IsDefaultNPCValid(NpcID)
		return (PLAYER_CLASS == "HUNTER" or not private.TamableIDs[NpcID] or TAMABLE_EXCEPTIONS[NpcID]) and (not NPC_FACTION[NpcID] or NPC_FACTION[NpcID] == PLAYER_FACTION)
	end
end

--- Resets the scanning list and reloads it from saved settings.
function private.Synchronize(Options, OptionsCharacter)
	-- Load defaults if settings omitted
	local IsDefaultScan = false
	if not Options then
		Options = private.OptionsDefault
	end

	if not OptionsCharacter then
		OptionsCharacter = private.OptionsCharacterDefault
		IsDefaultScan = true
	end

	-- Clear all scans
	for AchievementID in pairs(private.Achievements) do
		private.AchievementRemove(AchievementID)
	end

	for NpcID in pairs(private.Options.NPCs) do
		private.NPCRemove(NpcID)
	end

	for NpcID, WorldID in pairs(private.RareMobData.NPCWorldIDs) do
		private.NPCRemove(NpcID)
	end
	assert(not next(ScanIDs), "Orphan NpcIDs in scan pool!")

	private.SetCacheWarnings(Options.CacheWarnings)
	private.SetPrintTime(Options.PrintTime)
	private.SetAchievementsAddFound(OptionsCharacter.AchievementsAddFound)
	private.SetAlertSoundUnmute(OptionsCharacter.AlertSoundUnmute)
	private.SetAlertSound(OptionsCharacter.AlertSound)
	private.SetBlockFlightScan(OptionsCharacter.FlightSupress)
	private.SetRareMob("BEASTS", OptionsCharacter.TrackBeasts)
	private.SetRareMob("RARENPC", OptionsCharacter.TrackRares)

	local AddAllDefaults = _G.IsShiftKeyDown()
	for NpcID, Name in pairs(Options.NPCs) do
		-- If defaults, only add tamable custom mobs if the player is a hunter
		if AddAllDefaults or not IsDefaultScan or IsDefaultNPCValid(NpcID) then
			private.NPCAdd(NpcID, Name, Options.NPCWorldIDs[NpcID])
		end
	end

	for AchievementID in pairs(private.Achievements) do
		-- If defaults, don't enable completed achievements unless explicitly allowed
		if OptionsCharacter.Achievements[AchievementID] and (not IsDefaultScan or OptionsCharacter.AchievementsAddFound or not select(4, GetAchievementInfo(AchievementID))) then -- Not completed
			private.AchievementAdd(AchievementID)
		end
	end


	private.CacheListPrint(false, true) -- Populates cache list with inactive mobs too before printing
end




do
	local PetList = {}

	--- Prints the list of cached pets when leaving a city or inn.
	function private.Frame:PLAYER_UPDATE_RESTING()
		if not _G.IsResting() and next(PetList) then
			if private.Options.CacheWarnings then
				local ListString = CacheListBuild(PetList)
				if ListString then
					private.Print(L.CACHED_PET_RESTING_FORMAT:format(ListString), _G.RED_FONT_COLOR)
				end
			else
				table.wipe(PetList)
			end
		end
	end

	--- @return True if the tamable mob is in its correct zone, else false with an optional reason string.
	local function OnFoundTamable(npc_id, npc_name)
		local expected_zone = private.TamableIDs[npc_id]
		local current_zone_id = _G.GetCurrentMapAreaID()

		local in_correct_zone
		if expected_zone == true then -- Expected zone is unknown (instance mob, etc.)
            in_correct_zone = not _G.IsResting() -- Assume any tamable mob found in a city/inn is a hunter pet
		else
			_G.SetMapToCurrentZone()
            in_correct_zone = expected_zone == _G.GetCurrentMapAreaID()
		end
        local invalid_reason

		if not in_correct_zone then
			if _G.IsResting() then
				PetList[npc_id] = npc_name -- Suppress error message until the player stops resting
			else
				local expected_zone_name = _G.GetMapNameByID(expected_zone)
				if not expected_zone_name then -- GetMapNameByID returns nil for continent maps
					_G.SetMapByID(expected_zone)

					local map_continent = _G.GetCurrentMapContinent()
					if map_continent >= 1 then
                        expected_zone_name = select(map_continent, _G.GetMapContinents())
					end
                end
                invalid_reason = L.FOUND_TAMABLE_WRONGZONE_FORMAT:format(npc_name, _G.GetRealZoneText(), expected_zone_name or L.FOUND_ZONE_UNKNOWN, expected_zone)
			end
		end
		_G.SetMapByID(current_zone_id)

		return in_correct_zone, invalid_reason
	end

	--- @return Name of the source of NpcID's scan--either a custom name or achievement name.
	local function GetScanSource(NpcID)
		local CustomName = private.Options.NPCs[NpcID]
		if CustomName then
			return CustomName
		end
		-- Must have been from an achievement
		for AchievementID in pairs(private.OptionsCharacter.Achievements) do
			if private.Achievements[AchievementID].NPCsActive[NpcID] then
				return _G.GetAchievementLink(AchievementID) -- Colored link to distinguish from a custom name
			end
		end
	end

	--- Validates found mobs before showing alerts.
	local function OnFound(NpcID, Name)
		-- Disable active scans
		NPCDeactivate(NpcID)
		for AchievementID in pairs(private.OptionsCharacter.Achievements) do
			AchievementNPCDeactivate(private.Achievements[AchievementID], NpcID)
		end

		local Valid = true
		local InvalidReason
		local Tamable = private.TamableIDs[NpcID]

		if Tamable then
			Valid, InvalidReason = OnFoundTamable(NpcID, Name)
		end

		--Checks to see if player is on flightpath, this will block possible cross realm alerts
		if private.OptionsCharacter.FlightSupress and _G.UnitOnTaxi("player") then
			Valid = false
			_G.SetMapToCurrentZone()

			local posX, posY = _G.GetPlayerMapPosition("player")
			local zoneName = _G.GetZoneText()
			InvalidReason = L.FOUND_UNIT_TAXI:format(Name, posX * 100, posY * 100, zoneName)
			--NS.PlaySound ( AlertSound )
			_G.PlaySound("TellMessage", "master")
		end

		if Valid then
			private.Print(L[Tamable and "FOUND_TAMABLE_FORMAT" or "FOUND_FORMAT"]:format(Name), _G.GREEN_FONT_COLOR)
			private.Button:SetNPC(NpcID, Name, GetScanSource(NpcID)) -- Sends added and found overlay messages
		elseif InvalidReason then
			private.Print(InvalidReason)
		end
	end

	--- Scans all active criteria and removes any completed NPCs.
	local function AchievementCriteriaUpdate()
		if private.OptionsCharacter.AchievementsAddFound then
			return
		end

		for achievement_id in pairs(private.OptionsCharacter.Achievements) do
			local achievement = private.Achievements[achievement_id]
			for npc_id, criteria_id in pairs(achievement.NPCsActive) do
				local _, _, is_complete = _G.GetAchievementCriteriaInfoByID(achievement_id, criteria_id)
				if is_complete then
					AchievementNPCDeactivate(achievement, npc_id)
				end
			end
		end
	end

	local CriteriaUpdated = false
	--- Stops tracking individual achievement NPCs when the player gets kill credit.
	function private.Frame:CRITERIA_UPDATE()
		CriteriaUpdated = true
	end

	--- Scans all NPCs on a timer and alerts if any are found.
	function private.Updater:OnLoop()
		if CriteriaUpdated then -- CRITERIA_UPDATE bucket
			CriteriaUpdated = false
			AchievementCriteriaUpdate()
		end

		for NpcID in pairs(ScanIDs) do
			local Name = private.TestID(NpcID)
			if Name then
				OnFound(NpcID, Name)
			end
		end
	end
end

if PLAYER_CLASS == "HUNTER" then
	local StableUpdater = _G.CreateFrame("Frame")

	local StabledList = {}
	--- Stops scans for stabled hunter pets before a bogus alert can fire.
	function private.Frame:PET_STABLE_UPDATE()
		for npc_id in pairs(ScanIDs) do
			local npc_name = private.TestID(npc_id)
			if npc_name then
				StabledList[npc_id] = npc_name
				NPCDeactivate(npc_id)

				for achievement_id in pairs(private.OptionsCharacter.Achievements) do
					AchievementNPCDeactivate(private.Achievements[achievement_id], npc_id)
				end
			end
		end
		StableUpdater:Show()
	end

	--- Bucket to print cached stabled pets on one line.
	function StableUpdater:OnUpdate()
		self:Hide()
		if private.Options.CacheWarnings then
			local ListString = CacheListBuild(StabledList)
			if ListString then
				private.Print(L.CACHED_STABLED_FORMAT:format(ListString))
			end
		else
			table.wipe(StabledList)
		end
	end

	StableUpdater:Hide()
	StableUpdater:SetScript("OnUpdate", StableUpdater.OnUpdate)
	private.Frame:RegisterEvent("PET_STABLE_UPDATE")

	local Backup = _G.GetStablePetInfo
	--- Prevents the pet UI from querying (and caching) stabled pets until actually viewing the stables.
	-- @param Override Forces a normal query even if the stables aren't open.
	function _G.GetStablePetInfo(Slot, Override, ...)
		if Override or Slot <= _G.NUM_PET_ACTIVE_SLOTS or _G.IsAtStableMaster() then
			return Backup(Slot, Override, ...)
		end
	end
end




--- Loads defaults, validates settings, and starts scan.
-- Used instead of ADDON_LOADED to give overlay mods a chance to load and register for messages.
function private.Frame:PLAYER_LOGIN(event_name)
	if _G.IsAddOnLoaded("_NPCScan.AutoAdd") then
		StaticPopup_Show("NPCSCAN_AUTOADD_WARNING")
	end

	local stored_options = _G._NPCScanOptions
	local stored_character_options = _G._NPCScanOptionsCharacter
	_G._NPCScanOptions= private.Options
	_G._NPCScanOptionsCharacter = private.OptionsCharacter

	if stored_options and stored_options.Version ~= DB_VERSION then
		local stored_version = stored_options.Version

		if not stored_version or type(stored_version) == "string" or stored_version < DB_VERSION then
			stored_options = private.OptionsDefault
		end

		if type(stored_options.Version) == "string" and stored_options.Version < "5.2" then
			for npc_id, npc_name in pairs(private.OptionsDefault.NPCs) do
				stored_options.NPCs[npc_id] = npc_name
			end

			for npc_id, world_id in pairs(private.OptionsDefault.NPCWorldIDs) do
				stored_options.NPCWorldIDs[npc_id] = world_id
				stored_options.NPCWorldIDs[62346] = nil
				stored_options.NPCWorldIDs[60491] = nil
				stored_options.NPCWorldIDs[69099] = nil
				stored_options.NPCWorldIDs[69161] = nil
			end
		end
		stored_options.Version = DB_VERSION
	end

	if stored_character_options and stored_character_options.Version ~= DB_VERSION then
		if not stored_character_options.Version or type(stored_character_options.Version) == "string" or stored_character_options < DB_VERSION then
			stored_character_options = private.OptionsCharacterDefault
		end
		stored_character_options.Version = DB_VERSION
	end
	private.Overlays.Register()
	private.Synchronize(stored_options, stored_character_options)

	self[event_name] = nil
end

do
	local FirstWorld = true
	--- Starts world-specific scans when entering a world.
	function private.Frame:PLAYER_ENTERING_WORLD()
		-- Print cached pets if player ported out of a city
		self:PLAYER_UPDATE_RESTING()

		-- Since real MapIDs aren't available to addons, a "WorldID" is a universal ContinentID or the map's localized name.
		local MapName, _, _, _, _, _, _, MapID = _G.GetInstanceInfo()

		if MapID == 1064 then --Fix for Isle of Thunder having a diffrent Instance name
			private.WorldID = 6
		else
			private.WorldID = private.ContinentIDs[MapName] or MapName
		end


		-- Activate scans on this world

		if private.OptionsCharacter.TrackRares then
			--Loads Rare Mob Databas
			for NpcID, _ in pairs(private.RareMobData.RareNPCs) do
				local WorldID = private.RareMobData.NPCWorldIDs[NpcID]
				NPCActivate(NpcID, WorldID)
			end
		end

		if private.OptionsCharacter.TrackBeasts then
			--Loads Rare Beasts Databas
			for NpcID, _ in pairs(private.TamableIDs) do
				local WorldID = private.RareMobData.NPCWorldIDs[NpcID]
				NPCActivate(NpcID, WorldID)
			end
		end

		for AchievementID in pairs(private.OptionsCharacter.Achievements) do
			local Achievement = private.Achievements[AchievementID]
			if Achievement.WorldID then
				AchievementActivate(Achievement)
			end
		end

		--Loads Any Custom Mobs
		for NpcID, _ in pairs(private.Options.NPCs) do
			local WorldID = private.Options.NPCWorldIDs[NpcID]
			NPCActivate(NpcID, WorldID)
		end

		if FirstWorld or not private.Options.CacheWarnings then -- Full listing of cached mobs gets printed on login
			FirstWorld = false
			table.wipe(CacheList)
		else -- Print list of cached mobs specific to new world
			local ListString = CacheListBuild(CacheList)
			if ListString then
				private.Print(L.CACHED_WORLD_FORMAT:format(ListString, MapName))
			end
		end
		private.Config.Search:UpdateTabNames()
	end
end

--- Stops world-specific scans when leaving a world.
function private.Frame:PLAYER_LEAVING_WORLD()
	-- Stop scans that were only active on the previous world
	for NpcID in pairs(private.Options.NPCWorldIDs) do
		NPCDeactivate(NpcID)
	end

	for AchievementID in pairs(private.OptionsCharacter.Achievements) do
		local Achievement = private.Achievements[AchievementID]
		if Achievement.WorldID then
			AchievementDeactivate(Achievement)
		end
	end
	private.WorldID = nil
end

--- Stops tracking achievements when they finish.
function private.Frame:ACHIEVEMENT_EARNED(_, AchievementID)
	if not private.OptionsCharacter.AchievementsAddFound then
		private.AchievementRemove(AchievementID)
	end
end

--- Sets the update handler only after zone info is known.
function private.Frame:ZONE_CHANGED_NEW_AREA(Event)
	self:UnregisterEvent(Event)
	self[Event] = nil

	private.Updater:SetScript("OnLoop", private.Updater.OnLoop)
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

			if private.NPCAdd(id, name) then
				private.CacheListPrint(true)
			end
		end,
		[L.CMD_REMOVE] = function(arguments)
			local id = tonumber(arguments)
			if not id then -- Search custom names
				for npc_id, npc_name in pairs(private.Options.NPCs) do
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
		[L.CMD_CACHE] = function(arguments)
			if not private.CacheListPrint(true, true) then
				private.Print(L.CMD_CACHE_EMPTY, _G.GREEN_FONT_COLOR)
			end
		end,
	}

	function private.SlashCommand(input)
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
	private.Frame:PLAYER_LOGIN("PLAYER_LOGIN")
else
	private.Frame:RegisterEvent("PLAYER_LOGIN")
end

-- Set update handler after zone info loads
if _G.GetZoneText() == "" then -- Zone information unknown (initial login)
	private.Frame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
else -- Zone information is known
	private.Frame:ZONE_CHANGED_NEW_AREA("ZONE_CHANGED_NEW_AREA")
end

_G.SlashCmdList["_NPCSCAN"] = private.SlashCommand

--Warning Popup for users running _NPCScan.AutoAdd.
_G.StaticPopupDialogs["NPCSCAN_AUTOADD_WARNING"] = {
	text = "_NPCScan has detected that you are running _NPCScan.AutoAdd.  This addon is not supported and may prevent _NPCScan from working properly.  It is reccomended that you disable _NPCScan.AutoAdd.",
	button1 = "Ok",
	OnAccept = function()
	end,
	timeout = 0,
	whileDead = true,
	hideOnEscape = true,
}

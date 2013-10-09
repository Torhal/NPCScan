--[[****************************************************************************
  * _NPCScan by Saiket                                                         *
  * _NPCScan.lua - Scans NPCs near you for specific rare NPC IDs.              *
  ****************************************************************************]]


local NS = select( 2, ... )
_NPCScan = NS
local L = NS.L

NS.Frame = CreateFrame( "Frame" )
NS.Updater = NS.Frame:CreateAnimationGroup()
NS.Version = "5.2"


NS.Options = {
	Version = NS.Version,
	NPCs = {},
	NPCWorldIDs = {},
}

NS.OptionsCharacter = {
	Version = NS.Version,
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

NS.OptionsDefault = {
	Version = NS.Version,
	NPCs = {
		[ 64004 ] = "Ghostly Pandaren Fisherman",
		[ 64191 ] = "Ghostly Pandaren Craftsman",
		[ 50409 ] ="Mysterious Camel Figurine",
		[ 50410 ] = "Mysterious Camel Figurine",
	},
	NPCWorldIDs = {
		[ 50409 ] = 1, -- Mysterious Camel Figurine
		[ 50410 ] = 1, -- Mysterious Camel Figurine
		[ 64004 ] = 6, --"Ghostly Pandaren Fisherman"
		[ 64191 ] = 6, --"Ghostly Pandaren Craftsman"
		},
}

NS.OptionsCharacterDefault = {
	Version = NS.Version,
	Achievements = {
		[ 1312 ] = true, -- Bloody Rare (Outlands)
		[ 2257 ] = true, -- Frostbitten (Northrend)
		[ 7439 ] = true, -- Glorious! (Pandaria)
		[ 8103 ] = true, -- Champions of Lei Shen
		[ 8714 ] = true,  --Timeless Champion
		[ 7317 ] = true, -- One Of Many
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

NS.Achievements = { --- Criteria data for each achievement.
	[ 1312 ] = { WorldID = 3 }, -- Bloody Rare (Outlands)
	[ 2257 ] = { WorldID = 4 }, -- Frostbitten (Northrend)
	[ 7439 ] = { WorldID = 6 }, -- Glorious! (Pandaria)
	[ 7317 ] = { WorldID = 6 }, -- One Of Many
	[ 8103 ] = { WorldID = 6 }, -- Champions of Lei Shen
	[ 8714 ] = { WorldID = 6 },  --Timeless Champion
}
do
	local VirtualContinents = { --- Continents without physical maps aren't used.
		[ 5 ] = true -- The Maelstrom
	}
	NS.ContinentNames = { GetMapContinents() }
	for ContinentID in pairs( VirtualContinents ) do
		NS.ContinentNames[ ContinentID ] = nil
	end
	NS.ContinentIDs = {} --- Reverse lookup of NS.ContinentNames.
end

NS.NpcIDMax = 0xFFFFF --- Largest ID that will fit in a GUID's 20-bit NPC ID field.
NS.Updater.UpdateRate = 0.1




--- Prints a message in the default chat window.
function NS.Print ( Message, Color )
	if ( not Color ) then
		Color = NORMAL_FONT_COLOR
	end
	DEFAULT_CHAT_FRAME:AddMessage( L.PRINT_FORMAT:format(
		NS.Options.PrintTime and date( CHAT_TIMESTAMP_FORMAT or L.TIME_FORMAT ) or "",
		Message ), Color.r, Color.g, Color.b )
end


do
	local Tooltip = CreateFrame( "GameTooltip", "_NPCScanTooltip" )
	-- Add template text lines
	local Text = Tooltip:CreateFontString()
	Tooltip:AddFontStrings( Text, Tooltip:CreateFontString() )
	--- Checks the cache for a given NpcID.
	-- @return Localized name of the NPC if cached, or nil if not.
	function NS.TestID ( NpcID )
		Tooltip:SetOwner( WorldFrame, "ANCHOR_NONE" )
		Tooltip:SetHyperlink( ( "unit:0xF53%05X00000000" ):format( NpcID ) )
		if ( Tooltip:IsShown() ) then
			return Text:GetText()
		end
	end
end


local CacheListBuild
do
	local TempList, AlreadyListed = {}, {}
	--- Compiles a cache list into a printable list string.
	-- @param Relist  True to relist NPC names that have already been printed.
	-- @return List string, or nil if the list was empty.
	function CacheListBuild ( self, Relist )
		if ( next( self ) ) then
			-- Build and sort list
			for NpcID, Name in pairs( self ) do
				if ( Relist or not AlreadyListed[ NpcID ] ) then
					if ( not Relist ) then -- Filtered to show NPCs only once
						AlreadyListed[ NpcID ] = true -- Don't list again
					end
					-- Add quotes to all entries
					TempList[ #TempList + 1 ] = L.CACHELIST_ENTRY_FORMAT:format( Name )
				end
			end

			wipe( self )
			if ( #TempList > 0 ) then
				sort( TempList )
				local ListString = table.concat( TempList, L.CACHELIST_SEPARATOR )
				wipe( TempList )
				return ListString
			end
		end
	end
end

local CacheList = {}
do
	--- Fills a cache list with all added NPCs, active or not.
	local function CacheListPopulate ( self )
		for NpcID in pairs( NS.Options.NPCs ) do
			self[ NpcID ] = NS.TestID( NpcID )
		end

		if ( NS.OptionsCharacter.TrackBeasts) then
			for NpcID in pairs( NS.TamableIDs) do
				self[ NpcID ] = NS.TestID( NpcID )
			end
		end

		if ( NS.OptionsCharacter.TrackRares) then
			for NpcID in pairs( NS.RareMobData.RareNPCs) do
				self[ NpcID ] = NS.TestID( NpcID )
			end
		end

		for AchievementID in pairs( NS.OptionsCharacter.Achievements ) do
			for CriteriaID, NpcID in pairs( NS.Achievements[ AchievementID ].Criteria ) do
				if ( NS.OptionsCharacter.AchievementsAddFound or not select( 3, GetAchievementCriteriaInfoByID( AchievementID, CriteriaID ) ) ) then -- Not completed
					self[ NpcID ] = NS.TestID( NpcID )
				end
			end
		end
	end
	local FirstPrint = true
	--- Prints a standard message listing cached mobs.
	-- Will also print details about the cache the first time it's called.
	-- @param ForcePrint  Overrides the user's option to not print cache warnings.
	-- @param FullListing  Adds all cached NPCs before printing, active or not.
	-- @return True if list printed.
	function NS.CacheListPrint ( ForcePrint, FullListing )
		if ( ForcePrint or NS.Options.CacheWarnings ) then
			if ( FullListing ) then
				CacheListPopulate( CacheList )
			end
			local ListString = CacheListBuild( CacheList, ForcePrint or FullListing ) -- Allow printing an NPC a second time if forced or full listing
			if ( ListString ) then
				NS.Print( L[ FirstPrint and "CACHED_LONG_FORMAT" or "CACHED_FORMAT" ]:format( ListString ), ForcePrint and RED_FONT_COLOR )
				FirstPrint = false
				return true
			end
		else
			wipe( CacheList )
		end
	end
end




local next, assert = next, assert

local ScanIDs = {} --- [ NpcID ] = Number of concurrent scans for this ID
--- Begins searching for an NPC.
-- @return True if successfully added.
local function ScanAdd ( NpcID )
	local Name = NS.TestID( NpcID )
	if ( Name ) then -- Already seen
		CacheList[ NpcID ] = Name
	else -- Increment
		if ( ScanIDs[ NpcID ] ) then
			ScanIDs[ NpcID ] = ScanIDs[ NpcID ] + 1
		else
			if ( not next( ScanIDs ) ) then -- First
				NS.Updater:Play()
			end
			ScanIDs[ NpcID ] = 1
			NS.Overlays.Add( NpcID )
		end
		return true -- Successfully added
	end
end
--- Stops searching for an NPC when nothing is searching for it.
local function ScanRemove ( NpcID )
	local Count = assert( ScanIDs[ NpcID ], "Attempt to remove inactive scan." )
	if ( Count > 1 ) then
		ScanIDs[ NpcID ] = Count - 1
	else
		ScanIDs[ NpcID ] = nil
		NS.Overlays.Remove( NpcID )
		if ( not next( ScanIDs ) ) then -- Last
			NS.Updater:Stop()
		end
	end
end




--- @return True if the given WorldID is active on the current world.
local function IsWorldIDActive ( WorldID )
	return not WorldID or WorldID == NS.WorldID -- False/nil active on all worlds
end

local NPCActivate, NPCDeactivate
do
	local NPCsActive = {}
	--- Starts actual scan for NPC if on the right world.
	function NPCActivate ( NpcID, WorldID )
		if ( not NPCsActive[ NpcID ] and IsWorldIDActive( WorldID ) and ScanAdd( NpcID ) ) then
			NPCsActive[ NpcID ] = true
			NS.Config.Search.UpdateTab( "NPC" )
			return true -- Successfully activated
		end
	end
	--- Ends actual scan for NPC.
	function NPCDeactivate ( NpcID )
		if ( NPCsActive[ NpcID ] ) then
			NPCsActive[ NpcID ] = nil
			ScanRemove( NpcID )
			NS.Config.Search.UpdateTab( "NPC" )
			return true -- Successfully deactivated
		end
	end
	--- @return True if a custom NPC is actively being searched for.
	function NS.NPCIsActive ( NpcID )
		return NPCsActive[ NpcID ]
	end
end
--- Adds an NPC name and ID to settings and begins searching.
-- @param NpcID  Numeric ID of the NPC (See Wowhead.com).
-- @param Name  Temporary name to identify this NPC by in the search table.
-- @param WorldID  Number or localized string WorldID to limit this search to.
-- @return True if custom NPC added.
function NS.NPCAdd ( NpcID, Name, WorldID )
	NpcID = assert( tonumber( NpcID ), "NpcID must be numeric." )
	local Options = NS.Options
	if ( not Options.NPCs[ NpcID ] ) then
		assert( type( Name ) == "string", "Name must be a string." )
		assert( WorldID == nil or type( WorldID ) == "string" or type( WorldID ) == "number", "Invalid WorldID." )
		Options.NPCs[ NpcID ], Options.NPCWorldIDs[ NpcID ] = Name, WorldID
		if ( not NPCActivate( NpcID, WorldID ) ) then -- Didn't activate
			NS.Config.Search.UpdateTab( "NPC" ) -- Just add row
		end
		return true
	end
end
--- Removes an NPC from settings and stops searching for it.
-- @param NpcID  Numeric ID of the NPC.
-- @return True if custom NPC removed.
function NS.NPCRemove ( NpcID )
	NpcID = tonumber( NpcID )
	local Options = NS.Options
	if ( Options.NPCs[ NpcID ] ) then
		Options.NPCs[ NpcID ] = nil
		Options.NPCWorldIDs[ NpcID ] = nil

		if ( not NPCDeactivate( NpcID ) ) then -- Wasn't active
			NS.Config.Search.UpdateTab( "NPC" ) -- Just remove row
		end
		return true
	end
end




--- Starts searching for an achievement's NPC if it meets all settings.
local function AchievementNPCActivate ( Achievement, NpcID, CriteriaID )
	if ( Achievement.Active and not Achievement.NPCsActive[ NpcID ]
		and ( NS.OptionsCharacter.AchievementsAddFound or not select( 3, GetAchievementCriteriaInfoByID( Achievement.ID, CriteriaID ) ) ) -- Not completed
		and ScanAdd( NpcID )
	) then
		Achievement.NPCsActive[ NpcID ] = CriteriaID
		NS.Config.Search.UpdateTab( Achievement.ID )
		return true
	end
end
--- Stops searching for an achievement's NPC.
local function AchievementNPCDeactivate ( Achievement, NpcID )
	if ( Achievement.NPCsActive[ NpcID ]  ) then
		Achievement.NPCsActive[ NpcID ] = nil
		ScanRemove( NpcID )
		NS.Config.Search.UpdateTab( Achievement.ID )
		return true
	end
end
--- Starts actual scans for achievement NPCs if on the right world.
local function AchievementActivate ( Achievement )
	if ( not Achievement.Active and IsWorldIDActive( Achievement.WorldID ) ) then
		Achievement.Active = true
		for CriteriaID, NpcID in pairs( Achievement.Criteria ) do
			AchievementNPCActivate( Achievement, NpcID, CriteriaID )
		end
		return true
	end
end
-- Ends actual scans for achievement NPCs.
local function AchievementDeactivate ( Achievement )
	if ( Achievement.Active ) then
		Achievement.Active = nil
		for NpcID in pairs( Achievement.NPCsActive ) do
			AchievementNPCDeactivate( Achievement, NpcID )
		end
		return true
	end
end
--- @param Achievement  Achievement data table from NS.Achievements.
-- @return True if the achievement NPC is being searched for.
function NS.AchievementNPCIsActive ( Achievement, NpcID )
	return Achievement.NPCsActive[ NpcID ] ~= nil
end
--- Adds a kill-related achievement to track.
-- @param AchievementID  Numeric ID of achievement.
-- @return True if achievement added.
function NS.AchievementAdd ( AchievementID )
	AchievementID = assert( tonumber( AchievementID ), "AchievementID must be numeric." )
	local Achievement = NS.Achievements[ AchievementID ]
	if ( Achievement and not NS.OptionsCharacter.Achievements[ AchievementID ] ) then
		if ( not next( NS.OptionsCharacter.Achievements ) ) then -- First
			NS.Frame:RegisterEvent( "ACHIEVEMENT_EARNED" )
			NS.Frame:RegisterEvent( "CRITERIA_UPDATE" )
		end
		NS.OptionsCharacter.Achievements[ AchievementID ] = true
		NS.Config.Search.AchievementSetEnabled( AchievementID, true )
		AchievementActivate( Achievement )
		return true
	end
end
--- Removes an achievement from settings and stops tracking it.
-- @param AchievementID  Numeric ID of achievement.
-- @return True if achievement removed.
function NS.AchievementRemove ( AchievementID )
	if ( NS.OptionsCharacter.Achievements[ AchievementID ] ) then
		AchievementDeactivate( NS.Achievements[ AchievementID ] )
		NS.OptionsCharacter.Achievements[ AchievementID ] = nil
		if ( not next( NS.OptionsCharacter.Achievements ) ) then -- Last
			NS.Frame:UnregisterEvent( "ACHIEVEMENT_EARNED" )
			NS.Frame:UnregisterEvent( "CRITERIA_UPDATE" )
		end
		NS.Config.Search.AchievementSetEnabled( AchievementID, false )
		return true
	end
end





--NEW
--- Adds a kill-related achievement to track.
-- @param AchievementID  Numeric ID of achievement.
-- @return True if achievement added.
function NS.SetRareMob ( ID, enable )
	if ( ID == "BEASTS" )  then
		NS.OptionsCharacter.TrackBeasts = enable or nil
		NS.Config.Search.AchievementSetEnabled( ID, enable )
		return true
	elseif ( ID == "RARENPC" )  then
		NS.OptionsCharacter.TrackRares = enable or nil
		NS.Config.Search.AchievementSetEnabled( ID, enable )
		return true
	end
end

function NS.RareMobToggle(ID, enable)
	local Mobs

	if ( ID == "BEASTS" )  then
		Mobs = NS.TamableIDs
	elseif ( ID == "RARENPC" )  then
		Mobs = NS.RareMobData.RareNPCs
	end

	if (enable) then
			--Loads Rare Mob Databas
		for NpcID, _ in pairs( Mobs ) do
			local WorldID = NS.RareMobData.NPCWorldIDs[NpcID]
			NPCActivate( NpcID, WorldID )
		end
	else
		for NpcID, _ in pairs( Mobs ) do
			local WorldID = NS.RareMobData.NPCWorldIDs[NpcID]
			NPCDeactivate( NpcID )
		end
	end

end

--- Enables printing cache lists on login.
-- @return True if changed.
function NS.SetCacheWarnings ( Enable )
	if ( not Enable ~= not NS.Options.CacheWarnings ) then
		NS.Options.CacheWarnings = Enable or nil

		NS.Config.CacheWarnings:SetChecked( Enable )
		return true
	end
end
--- Enables adding a timestamp to printed messages.
-- @return True if changed.
function NS.SetPrintTime ( Enable )
	if ( not Enable ~= not NS.Options.PrintTime ) then
		NS.Options.PrintTime = Enable or nil

		NS.Config.PrintTime:SetChecked( Enable )
		return true
	end
end
--- Enables tracking of unneeded achievement NPCs.
-- @return True if changed.
function NS.SetAchievementsAddFound ( Enable )
	if ( not Enable ~= not NS.OptionsCharacter.AchievementsAddFound ) then
		NS.OptionsCharacter.AchievementsAddFound = Enable or nil
		NS.Config.Search.AddFoundCheckbox:SetChecked( Enable )

		for _, Achievement in pairs( NS.Achievements ) do
			if ( AchievementDeactivate( Achievement ) ) then -- Was active
				AchievementActivate( Achievement )
			end
		end
		return true
	end
end
--- Enables unmuting sound to play found alerts.
-- @return True if changed.
function NS.SetAlertSoundUnmute ( Enable )
	if ( not Enable ~= not NS.OptionsCharacter.AlertSoundUnmute ) then
		NS.OptionsCharacter.AlertSoundUnmute = Enable or nil

		NS.Config.AlertSoundUnmute:SetChecked( Enable )
		return true
	end
end
--- Sets the sound to play when NPCs are found.
-- @return True if changed.
function NS.SetAlertSound ( AlertSound )
	assert( AlertSound == nil or type( AlertSound ) == "string", "AlertSound must be a string or nil." )
	if ( AlertSound ~= NS.OptionsCharacter.AlertSound ) then
		NS.OptionsCharacter.AlertSound = AlertSound

		UIDropDownMenu_SetText( NS.Config.AlertSound, AlertSound == nil and L.CONFIG_ALERT_SOUND_DEFAULT or AlertSound )
		return true
	end
end

--- Enables Blocking alerts while on taxi.
-- @return True if changed.
function NS.SetBlockFlightScan ( Enable )
		NS.OptionsCharacter.FlightSupress = Enable
		NS.Config.Search.BlockFlightScanCheckbox:SetChecked( Enable )
		return Enable

end


local IsDefaultNPCValid
do
	local IsHunter = select( 2, UnitClass( "player" ) ) == "HUNTER"
	local TamableExceptions = {
		[ 49822 ] = true -- Jadefang drops a pet
	}

	local FactionRestrictions = { -- [NpcID] = FactionGroup to enable for
		[ 51071 ] = "Horde", -- Captain Florence
		[ 51079 ] = "Alliance", -- Captain Foulwind
	}

	--- @return True if NpcID should be a default for this character.
	function IsDefaultNPCValid ( NpcID )
		return ( IsHunter or not NS.TamableIDs[ NpcID ] or TamableExceptions[ NpcID ] )
			and ( not FactionRestrictions[ NpcID ] or FactionRestrictions[ NpcID ] == UnitFactionGroup( "player" ) )
	end
end
--- Resets the scanning list and reloads it from saved settings.
function NS.Synchronize ( Options, OptionsCharacter )
	-- Load defaults if settings omitted
	local IsDefaultScan = false
	if ( not Options ) then
		Options = NS.OptionsDefault
	end
	if ( not OptionsCharacter ) then
		OptionsCharacter, IsDefaultScan = NS.OptionsCharacterDefault, true
	end

	-- Clear all scans
	for AchievementID in pairs( NS.Achievements ) do
		NS.AchievementRemove( AchievementID )
	end
	for NpcID in pairs( NS.Options.NPCs ) do
		NS.NPCRemove( NpcID )
	end

	for NpcID, WorldID in pairs( NS.RareMobData.NPCWorldIDs ) do
		NS.NPCRemove( NpcID )
	end
	assert( not next( ScanIDs ), "Orphan NpcIDs in scan pool!" )

	NS.SetCacheWarnings( Options.CacheWarnings )
	NS.SetPrintTime( Options.PrintTime )
	NS.SetAchievementsAddFound( OptionsCharacter.AchievementsAddFound )
	NS.SetAlertSoundUnmute( OptionsCharacter.AlertSoundUnmute )
	NS.SetAlertSound( OptionsCharacter.AlertSound )
	NS.SetBlockFlightScan(OptionsCharacter.FlightSupress)
	NS.SetRareMob ( "BEASTS", OptionsCharacter.TrackBeasts)
	NS.SetRareMob ( "RARENPC", OptionsCharacter.TrackRares)

	local AddAllDefaults = IsShiftKeyDown()
	for NpcID, Name in pairs( Options.NPCs ) do
		-- If defaults, only add tamable custom mobs if the player is a hunter
		if ( AddAllDefaults or not IsDefaultScan or IsDefaultNPCValid( NpcID ) ) then
			NS.NPCAdd( NpcID, Name, Options.NPCWorldIDs[ NpcID ] )
		end
	end
	for AchievementID in pairs( NS.Achievements ) do
		-- If defaults, don't enable completed achievements unless explicitly allowed
		if ( OptionsCharacter.Achievements[ AchievementID ] and (
			not IsDefaultScan or OptionsCharacter.AchievementsAddFound or not select( 4, GetAchievementInfo( AchievementID ) ) -- Not completed
		) ) then
			NS.AchievementAdd( AchievementID )
		end
	end


	NS.CacheListPrint( false, true ) -- Populates cache list with inactive mobs too before printing

end




do
	local PetList = {}

	--- Prints the list of cached pets when leaving a city or inn.
	function NS.Frame:PLAYER_UPDATE_RESTING ()
		if ( not IsResting() and next( PetList ) ) then
			if ( NS.Options.CacheWarnings ) then
				local ListString = CacheListBuild( PetList )
				if ( ListString ) then
					NS.Print( L.CACHED_PET_RESTING_FORMAT:format( ListString ), RED_FONT_COLOR )
				end
			else
				wipe( PetList )
			end
		end
	end

	--- @return True if the tamable mob is in its correct zone, else false with an optional reason string.
	local function OnFoundTamable ( NpcID, Name )
		local ExpectedZone = NS.TamableIDs[ NpcID ]
		local ZoneIDBackup = GetCurrentMapAreaID()

		local InCorrectZone, InvalidReason
		if ( ExpectedZone == true ) then -- Expected zone is unknown (instance mob, etc.)
			InCorrectZone = not IsResting() -- Assume any tamable mob found in a city/inn is a hunter pet
		else
			SetMapToCurrentZone()
			InCorrectZone = ExpectedZone == GetCurrentMapAreaID()
		end

		if ( not InCorrectZone ) then
			if ( IsResting() ) then
				PetList[ NpcID ] = Name  -- Suppress error message until the player stops resting
			else
				-- Get details about expected zone
				local ExpectedZoneName = GetMapNameByID( ExpectedZone )
				if ( not ExpectedZoneName ) then -- GetMapNameByID returns nil for continent maps
					SetMapByID( ExpectedZone )
					local Continent = GetCurrentMapContinent()
					if ( Continent >= 1 ) then
						ExpectedZoneName = select( Continent, GetMapContinents() )
					end
				end
				InvalidReason = L.FOUND_TAMABLE_WRONGZONE_FORMAT:format(
					Name, GetRealZoneText(), ExpectedZoneName or L.FOUND_ZONE_UNKNOWN, ExpectedZone )
			end
		end

		SetMapByID( ZoneIDBackup ) -- Restore previous map view
		return InCorrectZone, InvalidReason
	end
	--- @return Name of the source of NpcID's scan--either a custom name or achievement name.
	local function GetScanSource ( NpcID )
		local CustomName = NS.Options.NPCs[ NpcID ]
		if ( CustomName ) then
			return CustomName
		end
		-- Must have been from an achievement
		for AchievementID in pairs( NS.OptionsCharacter.Achievements ) do
			if ( NS.Achievements[ AchievementID ].NPCsActive[ NpcID ] ) then
				return GetAchievementLink( AchievementID ) -- Colored link to distinguish from a custom name
			end
		end
	end
	--- Validates found mobs before showing alerts.
	local function OnFound ( NpcID, Name )
		-- Disable active scans
		NPCDeactivate( NpcID )
		for AchievementID in pairs( NS.OptionsCharacter.Achievements ) do
			AchievementNPCDeactivate( NS.Achievements[ AchievementID ], NpcID )
		end

		local Valid = true
		local InvalidReason
		local Tamable = NS.TamableIDs[ NpcID ]

		if ( Tamable ) then
			Valid, InvalidReason = OnFoundTamable( NpcID, Name )
		end

		--Checks to see if player is on flightpath, this will block possible cross realm alerts
		if (NS.OptionsCharacter.FlightSupress) then
			local onTaxi = UnitOnTaxi("player")
			if onTaxi then
				Valid = false
				 SetMapToCurrentZone()
				local posX, posY = GetPlayerMapPosition("player")
				local zoneName = GetZoneText()
				InvalidReason = L.FOUND_UNIT_TAXI:format(Name,posX*100, posY*100, zoneName )
					--NS.PlaySound ( AlertSound )
				PlaySound("TellMessage", "master")
			end
		end

		if ( Valid ) then
			NS.Print( L[ Tamable and "FOUND_TAMABLE_FORMAT" or "FOUND_FORMAT" ]:format( Name ), GREEN_FONT_COLOR )
			NS.Button:SetNPC( NpcID, Name, GetScanSource( NpcID ) ) -- Sends added and found overlay messages
		elseif ( InvalidReason ) then
			NS.Print( InvalidReason )
		end
	end

	local pairs = pairs
	local GetAchievementCriteriaInfoByID = GetAchievementCriteriaInfoByID
	--- Scans all active criteria and removes any completed NPCs.
	local function AchievementCriteriaUpdate ()
		if ( not NS.OptionsCharacter.AchievementsAddFound ) then
			for AchievementID in pairs( NS.OptionsCharacter.Achievements ) do
				local Achievement = NS.Achievements[ AchievementID ]
				for NpcID, CriteriaID in pairs( Achievement.NPCsActive ) do
					local _, _, Complete = GetAchievementCriteriaInfoByID( AchievementID, CriteriaID )
					if ( Complete ) then
						AchievementNPCDeactivate( Achievement, NpcID )
					end
				end
			end
		end
	end
	local CriteriaUpdated = false
	--- Stops tracking individual achievement NPCs when the player gets kill credit.
	function NS.Frame:CRITERIA_UPDATE ()
		CriteriaUpdated = true
	end

	--- Scans all NPCs on a timer and alerts if any are found.
	function NS.Updater:OnLoop ()
		if ( CriteriaUpdated ) then -- CRITERIA_UPDATE bucket
			CriteriaUpdated = false
			AchievementCriteriaUpdate()
		end

		for NpcID in pairs( ScanIDs ) do
			local Name = NS.TestID( NpcID )
			if ( Name ) then
				OnFound( NpcID, Name )
			end
		end
	end
end
if ( select( 2, UnitClass( "player" ) ) == "HUNTER" ) then
	local StableUpdater = CreateFrame( "Frame" )

	local StabledList = {}
	--- Stops scans for stabled hunter pets before a bogus alert can fire.
	function NS.Frame:PET_STABLE_UPDATE ()
		for NpcID in pairs( ScanIDs ) do
			local Name = NS.TestID( NpcID )
			if ( Name ) then
				StabledList[ NpcID ] = Name
				NPCDeactivate( NpcID )
				for AchievementID in pairs( NS.OptionsCharacter.Achievements ) do
					AchievementNPCDeactivate( NS.Achievements[ AchievementID ], NpcID )
				end
			end
		end
		StableUpdater:Show()
	end
	--- Bucket to print cached stabled pets on one line.
	function StableUpdater:OnUpdate ()
		self:Hide()
		if ( NS.Options.CacheWarnings ) then
			local ListString = CacheListBuild( StabledList )
			if ( ListString ) then
				NS.Print( L.CACHED_STABLED_FORMAT:format( ListString ) )
			end
		else
			wipe( StabledList )
		end
	end

	StableUpdater:Hide()
	StableUpdater:SetScript( "OnUpdate", StableUpdater.OnUpdate )
	NS.Frame:RegisterEvent( "PET_STABLE_UPDATE" )

	local Backup = GetStablePetInfo
	--- Prevents the pet UI from querying (and caching) stabled pets until actually viewing the stables.
	-- @param Override  Forces a normal query even if the stables aren't open.
	function GetStablePetInfo ( Slot, Override, ... )
		if ( Override or Slot <= NUM_PET_ACTIVE_SLOTS or IsAtStableMaster() ) then
			return Backup( Slot, Override, ... )
		end
	end
end




--- Loads defaults, validates settings, and starts scan.
-- Used instead of ADDON_LOADED to give overlay mods a chance to load and register for messages.
function NS.Frame:PLAYER_LOGIN ( Event )

	--Warning message for users running _NPCScan.AutoAdd
	if IsAddOnLoaded("_NPCScan.AutoAdd") then
		StaticPopup_Show("NPCSCAN_AUTOADD_WARNING")

	end

	self[ Event ] = nil

	local Options, OptionsCharacter = _NPCScanOptions, _NPCScanOptionsCharacter
	_NPCScanOptions, _NPCScanOptionsCharacter = NS.Options, NS.OptionsCharacter

	--fix to correct 5.1.1 verson saved as iterger instead of string

	-- Update settings incrementally
	if ( Options and Options.Version ~= NS.Version ) then
	--Clears old global settings and updates to new variables
		if ( (Options.Version == nil) or (tostring(Options.Version) < "5.1.2") ) then
			Options = NS.OptionsDefault
		end
			if (tostring(Options.Version) < "5.2") then
			for NPCid , Name in pairs(NS.OptionsDefault.NPCs) do
				Options.NPCs[NPCid] = Name
			end
			for NPCid , WorldID in pairs(NS.OptionsDefault.NPCWorldIDs) do
				Options.NPCWorldIDs[NPCid] = WorldID
				Options.NPCWorldIDs[ 62346 ] = nil
				Options.NPCWorldIDs[ 60491 ] = nil
				Options.NPCWorldIDs[ 69099 ] = nil
				Options.NPCWorldIDs[ 69161 ] = nil
			end

		end
		Options.Version = NS.Version
	end

		if ( OptionsCharacter and OptionsCharacter.Version ~= NS.Version ) then
	--Clears old character settings and updates to new variables
		if ( (OptionsCharacter.Version == nil) or (tostring(OptionsCharacter.Version) < "5.1.2") ) then
			OptionsCharacter = NS.OptionsCharacterDefault
		end
		OptionsCharacter.Version = NS.Version
	end

	-- Character settings
	NS.Overlays.Register()
	NS.Synchronize( Options, OptionsCharacter ) -- Loads defaults if either are nil
end
do
	local FirstWorld = true
	--- Starts world-specific scans when entering a world.
	function NS.Frame:PLAYER_ENTERING_WORLD ()
		-- Print cached pets if player ported out of a city
		self:PLAYER_UPDATE_RESTING()

		-- Since real MapIDs aren't available to addons, a "WorldID" is a universal ContinentID or the map's localized name.
		local MapName,_,_,_,_,_,_,MapID = GetInstanceInfo()

		if (MapID == 1064) then --Fix for Isle of Thunder having a diffrent Instance name
			NS.WorldID = 6
		else
			NS.WorldID = NS.ContinentIDs[ MapName ] or MapName
		end


				-- Activate scans on this world

		if (NS.OptionsCharacter.TrackRares) then
			--Loads Rare Mob Databas
			for NpcID, _ in pairs( NS.RareMobData.RareNPCs ) do
				local WorldID = NS.RareMobData.NPCWorldIDs[NpcID]
				NPCActivate( NpcID, WorldID )
			end
		end

		if (NS.OptionsCharacter.TrackBeasts) then
			--Loads Rare Beasts Databas
			for NpcID, _ in pairs( NS.TamableIDs) do
				local WorldID = NS.RareMobData.NPCWorldIDs[NpcID]
				NPCActivate( NpcID, WorldID )
			end
		end

		for AchievementID in pairs( NS.OptionsCharacter.Achievements ) do
			local Achievement = NS.Achievements[ AchievementID ]
			if ( Achievement.WorldID ) then
				AchievementActivate( Achievement )
			end
		end

		--Loads Any Custom Mobs
		for NpcID, _ in pairs( NS.Options.NPCs ) do
			local WorldID = NS.Options.NPCWorldIDs[NpcID]
			NPCActivate( NpcID, WorldID )
		end

		if ( FirstWorld or not NS.Options.CacheWarnings ) then -- Full listing of cached mobs gets printed on login
			FirstWorld = false
			wipe( CacheList )
		else -- Print list of cached mobs specific to new world
			local ListString = CacheListBuild( CacheList )
			if ( ListString ) then
				NS.Print( L.CACHED_WORLD_FORMAT:format( ListString, MapName ) )
			end
		end
		NS.Config.Search:UpdateTabNames()
	end
end
--- Stops world-specific scans when leaving a world.
function NS.Frame:PLAYER_LEAVING_WORLD ()
	-- Stop scans that were only active on the previous world
	for NpcID in pairs( NS.Options.NPCWorldIDs ) do
		NPCDeactivate( NpcID )
	end
	for AchievementID in pairs( NS.OptionsCharacter.Achievements ) do
		local Achievement = NS.Achievements[ AchievementID ]
		if ( Achievement.WorldID ) then
			AchievementDeactivate( Achievement )
		end
	end
	NS.WorldID = nil
end
--- Stops tracking achievements when they finish.
function NS.Frame:ACHIEVEMENT_EARNED ( _, AchievementID )
	if ( not NS.OptionsCharacter.AchievementsAddFound ) then
		NS.AchievementRemove( AchievementID )
	end
end
--- Sets the update handler only after zone info is known.
function NS.Frame:ZONE_CHANGED_NEW_AREA ( Event )
	self:UnregisterEvent( Event )
	self[ Event ] = nil

	NS.Updater:SetScript( "OnLoop", NS.Updater.OnLoop )
end
--- Global event handler.
function NS.Frame:OnEvent ( Event, ... )
	if ( self[ Event ] ) then
		return self[ Event ]( self, Event, ... )
	end
end




--- Slash command chat handler to open the options pane and manage the NPC list.
function NS.SlashCommand ( Input )
	local Command, Arguments = Input:match( "^(%S+)%s*(.-)%s*$" )
	if ( Command ) then
		Command = Command:upper()
		if ( Command == L.CMD_ADD ) then
			local ID, Name = Arguments:match( "^(%d+)%s+(.+)$" )
			if ( ID ) then
				ID = tonumber( ID )
				NS.NPCRemove( ID )
				if ( NS.NPCAdd( ID, Name ) ) then
					NS.CacheListPrint( true )
				end
				return
			end
		elseif ( Command == L.CMD_REMOVE ) then
			local ID = tonumber( Arguments )
			if ( not ID ) then -- Search custom names
				for NpcID, Name in pairs( NS.Options.NPCs ) do
					if ( Name == Arguments ) then
						ID = NpcID
						break
					end
				end
			end
			if ( not NS.NPCRemove( ID ) ) then
				NS.Print( L.CMD_REMOVENOTFOUND_FORMAT:format( Arguments ), RED_FONT_COLOR )
			end
			return
		elseif ( Command == L.CMD_CACHE ) then -- Force print full cache list
			if ( not NS.CacheListPrint( true, true ) ) then -- Nothing in cache
				NS.Print( L.CMD_CACHE_EMPTY, GREEN_FONT_COLOR )
			end
			return
		end
		-- Invalid subcommand
		NS.Print( L.CMD_HELP )

	else -- No subcommand
		InterfaceOptionsFrame_OpenToCategory( NS.Config.Search )
	end
end




-- Create reverse lookup of continent names
for Index, Name in pairs( NS.ContinentNames ) do
	NS.ContinentIDs[ Name ] = Index
end

-- Save achievement criteria data
for AchievementID, Achievement in pairs( NS.Achievements ) do
	Achievement.ID = AchievementID
	Achievement.Criteria = {} -- [ CriteriaID ] = NpcID
	Achievement.NPCsActive = {} -- [ NpcID ] = CriteriaID

	for Criteria = 1, GetAchievementNumCriteria( AchievementID ) do
		local _, CriteriaType, _, _, _, _, _, AssetID, _, CriteriaID = GetAchievementCriteriaInfo( AchievementID, Criteria )
		if ( CriteriaType == 0 ) then -- Mob kill type
			Achievement.Criteria[ CriteriaID ] = AssetID
		end
	end
end


local Frame = NS.Frame
Frame:SetScript( "OnEvent", Frame.OnEvent )
if ( IsLoggedIn() ) then
	Frame:PLAYER_LOGIN( "PLAYER_LOGIN" )
else
	Frame:RegisterEvent( "PLAYER_LOGIN" )
end
Frame:RegisterEvent( "PLAYER_ENTERING_WORLD" )
Frame:RegisterEvent( "PLAYER_LEAVING_WORLD" )
Frame:RegisterEvent( "PLAYER_UPDATE_RESTING" )

NS.Updater:CreateAnimation( "Animation" ):SetDuration( NS.Updater.UpdateRate )
NS.Updater:SetLooping( "REPEAT" )
-- Set update handler after zone info loads
if ( GetZoneText() == "" ) then -- Zone information unknown (initial login)
	Frame:RegisterEvent( "ZONE_CHANGED_NEW_AREA" )
else -- Zone information is known
	Frame:ZONE_CHANGED_NEW_AREA( "ZONE_CHANGED_NEW_AREA" )
end

SlashCmdList[ "_NPCSCAN" ] = NS.SlashCommand

--Warning Popup for users running _NPCScan.AutoAdd.
StaticPopupDialogs["NPCSCAN_AUTOADD_WARNING"] = {
  text = "_NPCScan has detected that you are running _NPCScan.AutoAdd.  This addon is not supported and may prevent _NPCScan from working properly.  It is reccomended that you disable _NPCScan.AutoAdd.",
  button1 = "Ok",
  OnAccept = function()
        end,
  timeout = 0,
  whileDead = true,
  hideOnEscape = true,
}

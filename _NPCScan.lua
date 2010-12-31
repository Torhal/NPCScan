--[[****************************************************************************
  * _NPCScan by Saiket                                                         *
  * _NPCScan.lua - Scans NPCs near you for specific rare NPC IDs.              *
  ****************************************************************************]]


local me = select( 2, ... );
_NPCScan = me;
local L = me.L;

me.Frame = CreateFrame( "Frame" );
me.Updater = me.Frame:CreateAnimationGroup();
me.Version = GetAddOnMetadata( ..., "Version" ):match( "^([%d.]+)" );

me.Options = {
	Version = me.Version;
};
me.OptionsCharacter = {
	Version = me.Version;
	NPCs = {};
	NPCWorldIDs = {};
	Achievements = {};
};

me.OptionsDefault = {
	Version = me.Version;
	CacheWarnings = true;
	AchievementsAddFound = nil;
	AlertSoundUnmute = nil;
	AlertSound = nil; -- Default sound
};

do
	local ContinentID, MapID = WORLDMAP_MAELSTROM_ID, 640;
	--- @return The localized name of Deepholm.
	local function FindDeepholm ( ... )
		for ZoneIndex = 1, select( "#", ... ) do
			SetMapZoom( ContinentID, ZoneIndex );
			if ( GetCurrentMapAreaID() == MapID ) then
				return select( ZoneIndex, ... );
			end
		end
	end
	local DEEPHOLM = FindDeepholm( GetMapZones( ContinentID ) );

	me.OptionsCharacterDefault = {
		Version = me.Version;
		NPCs = {
			[ 18684 ] = L.NPCs[ 18684 ]; -- Bro'Gaz the Clanless
			[ 32491 ] = L.NPCs[ 32491 ]; -- Time-Lost Proto Drake
			[ 33776 ] = L.NPCs[ 33776 ]; -- Gondria
			[ 35189 ] = L.NPCs[ 35189 ]; -- Skoll
			[ 38453 ] = L.NPCs[ 38453 ]; -- Arcturis
			[ 49822 ] = L.NPCs[ 49822 ]; -- Jadefang
			[ 49913 ] = L.NPCs[ 49913 ]; -- Lady LaLa
			[ 50005 ] = L.NPCs[ 50005 ]; -- Poseidus
			[ 50009 ] = L.NPCs[ 50009 ]; -- Mobus
			[ 50050 ] = L.NPCs[ 50050 ]; -- Shok'sharak
			[ 50051 ] = L.NPCs[ 50051 ]; -- Ghostcrawler
			[ 50052 ] = L.NPCs[ 50052 ]; -- Burgy Blackheart
			[ 50053 ] = L.NPCs[ 50053 ]; -- Thartuk the Exile
			[ 50056 ] = L.NPCs[ 50056 ]; -- Garr
			[ 50057 ] = L.NPCs[ 50057 ]; -- Blazewing
			[ 50058 ] = L.NPCs[ 50058 ]; -- Terrorpene
			[ 50059 ] = L.NPCs[ 50059 ]; -- Golgarok
			[ 50060 ] = L.NPCs[ 50060 ]; -- Terborus
			[ 50061 ] = L.NPCs[ 50061 ]; -- Xariona
			[ 50062 ] = L.NPCs[ 50062 ]; -- Aeonaxx
			[ 50063 ] = L.NPCs[ 50063 ]; -- Akma'hat
			[ 50064 ] = L.NPCs[ 50064 ]; -- Cyrus the Black
			[ 50065 ] = L.NPCs[ 50065 ]; -- Armagedillo
			[ 50085 ] = L.NPCs[ 50085 ]; -- Overlord Sunderfury
			[ 50086 ] = L.NPCs[ 50086 ]; -- Tarvus the Vile
			[ 50089 ] = L.NPCs[ 50089 ]; -- Julak-Doom
			[ 50138 ] = L.NPCs[ 50138 ]; -- Karoma
			[ 50154 ] = L.NPCs[ 50154 ]; -- Madexx
			[ 50159 ] = L.NPCs[ 50159 ]; -- Sambas
			[ 50409 ] = L.NPCs[ 50409 ]; -- Mysterious Camel Figurine
			[ 50410 ] = L.NPCs[ 50410 ]; -- Mysterious Camel Figurine
			[ 51071 ] = L.NPCs[ 51071 ]; -- Captain Florence
			[ 51079 ] = L.NPCs[ 51079 ]; -- Captain Foulwind
			[ 51401 ] = L.NPCs[ 51401 ]; -- Madexx
			[ 51402 ] = L.NPCs[ 51402 ]; -- Madexx
			[ 51403 ] = L.NPCs[ 51403 ]; -- Madexx
			[ 51404 ] = L.NPCs[ 51404 ]; -- Madexx
		};
		NPCWorldIDs = {
			[ 18684 ] = 3; -- Bro'Gaz the Clanless
			[ 32491 ] = 4; -- Time-Lost Proto Drake
			[ 33776 ] = 4; -- Gondria
			[ 35189 ] = 4; -- Skoll
			[ 38453 ] = 4; -- Arcturis
			[ 49822 ] = DEEPHOLM; -- Jadefang
			[ 49913 ] = 2; -- Lady LaLa
			[ 50005 ] = 2; -- Poseidus
			[ 50009 ] = 2; -- Mobus
			[ 50050 ] = 2; -- Shok'sharak
			[ 50051 ] = 2; -- Ghostcrawler
			[ 50052 ] = 2; -- Burgy Blackheart
			[ 50053 ] = 1; -- Thartuk the Exile
			[ 50056 ] = 1; -- Garr
			[ 50057 ] = 1; -- Blazewing
			[ 50058 ] = 1; -- Terrorpene
			[ 50059 ] = DEEPHOLM; -- Golgarok
			[ 50060 ] = DEEPHOLM; -- Terborus
			[ 50061 ] = DEEPHOLM; -- Xariona
			[ 50062 ] = DEEPHOLM; -- Aeonaxx
			[ 50063 ] = 1; -- Akma'hat
			[ 50064 ] = 1; -- Cyrus the Black
			[ 50065 ] = 1; -- Armagedillo
			[ 50085 ] = 2; -- Overlord Sunderfury
			[ 50086 ] = 2; -- Tarvus the Vile
			[ 50089 ] = 2; -- Julak-Doom
			[ 50138 ] = 2; -- Karoma
			[ 50154 ] = 1; -- Madexx
			[ 50159 ] = 2; -- Sambas
			[ 50409 ] = 1; -- Mysterious Camel Figurine
			[ 50410 ] = 1; -- Mysterious Camel Figurine
			[ 51071 ] = 2; -- Captain Florence
			[ 51079 ] = 2; -- Captain Foulwind
			[ 51401 ] = 1; -- Madexx
			[ 51402 ] = 1; -- Madexx
			[ 51403 ] = 1; -- Madexx
			[ 51404 ] = 1; -- Madexx
		};
		Achievements = {
			[ 1312 ] = true; -- Bloody Rare (Outlands)
			[ 2257 ] = true; -- Frostbitten (Northrend)
		};
	};
end


me.Achievements = { --- Criteria data for each achievement.
	[ 1312 ] = { WorldID = 3; }; -- Bloody Rare (Outlands)
	[ 2257 ] = { WorldID = 4; }; -- Frostbitten (Northrend)
};
do
	local VirtualContinents = { --- Continents without physical maps aren't used.
		[ 5 ] = true; -- The Maelstrom
	};
	me.ContinentNames = { GetMapContinents() };
	for ContinentID in pairs( VirtualContinents ) do
		me.ContinentNames[ ContinentID ] = nil;
	end
	me.ContinentIDs = {}; --- Reverse lookup of me.ContinentNames.
end

me.NpcIDMax = 0xFFFFF; --- Largest ID that will fit in a GUID's 20-bit NPC ID field.
me.Updater.UpdateRate = 0.1;




--- Prints a message in the default chat window.
function me.Print ( Message, Color )
	if ( not Color ) then
		Color = NORMAL_FONT_COLOR;
	end
	DEFAULT_CHAT_FRAME:AddMessage( L.PRINT_FORMAT:format(
		me.Options.PrintTime and date( CHAT_TIMESTAMP_FORMAT or L.TIME_FORMAT ) or "",
		Message ), Color.r, Color.g, Color.b );
end


do
	local Tooltip = CreateFrame( "GameTooltip", "_NPCScanTooltip" );
	-- Add template text lines
	local Text = Tooltip:CreateFontString();
	Tooltip:AddFontStrings( Text, Tooltip:CreateFontString() );
	--- Checks the cache for a given NpcID.
	-- @return Localized name of the NPC if cached, or nil if not.
	function me.TestID ( NpcID )
		Tooltip:SetOwner( WorldFrame, "ANCHOR_NONE" );
		Tooltip:SetHyperlink( ( "unit:0xF53%05X00000000" ):format( NpcID ) );
		if ( Tooltip:IsShown() ) then
			return Text:GetText();
		end
	end
end


local CacheListBuild;
do
	local TempList, AlreadyListed = {}, {};
	--- Compiles a cache list into a printable list string.
	-- @param Relist  True to relist NPC names that have already been printed.
	-- @return List string, or nil if the list was empty.
	function CacheListBuild ( self, Relist )
		if ( next( self ) ) then
			-- Build and sort list
			for NpcID, Name in pairs( self ) do
				if ( Relist or not AlreadyListed[ NpcID ] ) then
					if ( not Relist ) then -- Filtered to show NPCs only once
						AlreadyListed[ NpcID ] = true; -- Don't list again
					end
					-- Add quotes to all entries
					TempList[ #TempList + 1 ] = L.CACHELIST_ENTRY_FORMAT:format( Name );
				end
			end

			wipe( self );
			if ( #TempList > 0 ) then
				sort( TempList );
				local ListString = table.concat( TempList, L.CACHELIST_SEPARATOR );
				wipe( TempList );
				return ListString;
			end
		end
	end
end
local CacheList = {};
do
	--- Fills a cache list with all added NPCs, active or not.
	local function CacheListPopulate ( self )
		for NpcID in pairs( me.OptionsCharacter.NPCs ) do
			self[ NpcID ] = me.TestID( NpcID );
		end
		for AchievementID in pairs( me.OptionsCharacter.Achievements ) do
			for CriteriaID, NpcID in pairs( me.Achievements[ AchievementID ].Criteria ) do
				if ( me.Options.AchievementsAddFound or not select( 3, GetAchievementCriteriaInfo( CriteriaID ) ) ) then -- Not completed
					self[ NpcID ] = me.TestID( NpcID );
				end
			end
		end
	end
	local FirstPrint = true;
	--- Prints a standard message listing cached mobs.
	-- Will also print details about the cache the first time it's called.
	-- @param ForcePrint  Overrides the user's option to not print cache warnings.
	-- @param FullListing  Adds all cached NPCs before printing, active or not.
	-- @return True if list printed.
	function me.CacheListPrint ( ForcePrint, FullListing )
		if ( ForcePrint or me.Options.CacheWarnings ) then
			if ( FullListing ) then
				CacheListPopulate( CacheList );
			end
			local ListString = CacheListBuild( CacheList, ForcePrint or FullListing ); -- Allow printing an NPC a second time if forced or full listing
			if ( ListString ) then
				me.Print( L[ FirstPrint and "CACHED_LONG_FORMAT" or "CACHED_FORMAT" ]:format( ListString ), ForcePrint and RED_FONT_COLOR );
				FirstPrint = false;
				return true;
			end
		else
			wipe( CacheList );
		end
	end
end




local next, assert = next, assert;

local ScanIDs = {}; --- [ NpcID ] = Number of concurrent scans for this ID
--- Begins searching for an NPC.
-- @return True if successfully added.
local function ScanAdd ( NpcID )
	local Name = me.TestID( NpcID );
	if ( Name ) then -- Already seen
		CacheList[ NpcID ] = Name;
	else -- Increment
		if ( ScanIDs[ NpcID ] ) then
			ScanIDs[ NpcID ] = ScanIDs[ NpcID ] + 1;
		else
			if ( not next( ScanIDs ) ) then -- First
				me.Updater:Play();
			end
			ScanIDs[ NpcID ] = 1;
			me.Overlays.Add( NpcID );
		end
		return true; -- Successfully added
	end
end
--- Stops searching for an NPC when nothing is searching for it.
local function ScanRemove ( NpcID )
	local Count = assert( ScanIDs[ NpcID ], "Attempt to remove inactive scan." );
	if ( Count > 1 ) then
		ScanIDs[ NpcID ] = Count - 1;
	else
		ScanIDs[ NpcID ] = nil;
		me.Overlays.Remove( NpcID );
		if ( not next( ScanIDs ) ) then -- Last
			me.Updater:Stop();
		end
	end
end




--- @return True if the given WorldID is active on the current world.
local function IsWorldIDActive ( WorldID )
	return not WorldID or WorldID == me.WorldID; -- False/nil active on all worlds
end

local NPCActivate, NPCDeactivate;
do
	local NPCsActive = {};
	--- Starts actual scan for NPC if on the right world.
	function NPCActivate ( NpcID, WorldID )
		if ( not NPCsActive[ NpcID ] and IsWorldIDActive( WorldID ) and ScanAdd( NpcID ) ) then
			NPCsActive[ NpcID ] = true;
			me.Config.Search.UpdateTab( "NPC" );
			return true; -- Successfully activated
		end
	end
	--- Ends actual scan for NPC.
	function NPCDeactivate ( NpcID )
		if ( NPCsActive[ NpcID ] ) then
			NPCsActive[ NpcID ] = nil;
			ScanRemove( NpcID );
			me.Config.Search.UpdateTab( "NPC" );
			return true; -- Successfully deactivated
		end
	end
	--- @return True if a custom NPC is actively being searched for.
	function me.NPCIsActive ( NpcID )
		return NPCsActive[ NpcID ];
	end
end
--- Adds an NPC name and ID to settings and begins searching.
-- @param NpcID  Numeric ID of the NPC (See Wowhead.com).
-- @param Name  Temporary name to identify this NPC by in the search table.
-- @param WorldID  Number or localized string WorldID to limit this search to.
-- @return True if custom NPC added.
function me.NPCAdd ( NpcID, Name, WorldID )
	NpcID = assert( tonumber( NpcID ), "NpcID must be numeric." );
	local Options = me.OptionsCharacter;
	if ( not Options.NPCs[ NpcID ] ) then
		assert( type( Name ) == "string", "Name must be a string." );
		assert( WorldID == nil or type( WorldID ) == "string" or type( WorldID ) == "number", "Invalid WorldID." );
		Options.NPCs[ NpcID ], Options.NPCWorldIDs[ NpcID ] = Name, WorldID;
		if ( not NPCActivate( NpcID, WorldID ) ) then -- Didn't activate
			me.Config.Search.UpdateTab( "NPC" ); -- Just add row
		end
		return true;
	end
end
--- Removes an NPC from settings and stops searching for it.
-- @param NpcID  Numeric ID of the NPC.
-- @return True if custom NPC removed.
function me.NPCRemove ( NpcID )
	NpcID = tonumber( NpcID );
	local Options = me.OptionsCharacter;
	if ( Options.NPCs[ NpcID ] ) then
		Options.NPCs[ NpcID ], Options.NPCWorldIDs[ NpcID ] = nil;
		if ( not NPCDeactivate( NpcID ) ) then -- Wasn't active
			me.Config.Search.UpdateTab( "NPC" ); -- Just remove row
		end
		return true;
	end
end




--- Starts searching for an achievement's NPC if it meets all settings.
local function AchievementNPCActivate ( Achievement, NpcID, CriteriaID )
	if ( Achievement.Active and not Achievement.NPCsActive[ NpcID ]
		and ( me.Options.AchievementsAddFound or not select( 3, GetAchievementCriteriaInfo( CriteriaID ) ) ) -- Not completed
		and ScanAdd( NpcID )
	) then
		Achievement.NPCsActive[ NpcID ] = CriteriaID;
		me.Config.Search.UpdateTab( Achievement.ID );
		return true;
	end
end
--- Stops searching for an achievement's NPC.
local function AchievementNPCDeactivate ( Achievement, NpcID )
	if ( Achievement.NPCsActive[ NpcID ] ) then
		Achievement.NPCsActive[ NpcID ] = nil;
		ScanRemove( NpcID );
		me.Config.Search.UpdateTab( Achievement.ID );
		return true;
	end
end
--- Starts actual scans for achievement NPCs if on the right world.
local function AchievementActivate ( Achievement )
	if ( not Achievement.Active and IsWorldIDActive( Achievement.WorldID ) ) then
		Achievement.Active = true;
		for CriteriaID, NpcID in pairs( Achievement.Criteria ) do
			AchievementNPCActivate( Achievement, NpcID, CriteriaID );
		end
		return true;
	end
end
-- Ends actual scans for achievement NPCs.
local function AchievementDeactivate ( Achievement )
	if ( Achievement.Active ) then
		Achievement.Active = nil;
		for NpcID in pairs( Achievement.NPCsActive ) do
			AchievementNPCDeactivate( Achievement, NpcID );
		end
		return true;
	end
end
--- @param Achievement  Achievement data table from me.Achievements.
-- @return True if the achievement NPC is being searched for.
function me.AchievementNPCIsActive ( Achievement, NpcID )
	return Achievement.NPCsActive[ NpcID ] ~= nil;
end
--- Adds a kill-related achievement to track.
-- @param AchievementID  Numeric ID of achievement.
-- @return True if achievement added.
function me.AchievementAdd ( AchievementID )
	AchievementID = assert( tonumber( AchievementID ), "AchievementID must be numeric." );
	local Achievement = me.Achievements[ AchievementID ];
	if ( Achievement and not me.OptionsCharacter.Achievements[ AchievementID ] ) then
		if ( not next( me.OptionsCharacter.Achievements ) ) then -- First
			me.Frame:RegisterEvent( "ACHIEVEMENT_EARNED" );
			me.Frame:RegisterEvent( "CRITERIA_UPDATE" );
		end
		me.OptionsCharacter.Achievements[ AchievementID ] = true;
		me.Config.Search.AchievementSetEnabled( AchievementID, true );
		AchievementActivate( Achievement );
		return true;
	end
end
--- Removes an achievement from settings and stops tracking it.
-- @param AchievementID  Numeric ID of achievement.
-- @return True if achievement removed.
function me.AchievementRemove ( AchievementID )
	if ( me.OptionsCharacter.Achievements[ AchievementID ] ) then
		AchievementDeactivate( me.Achievements[ AchievementID ] );
		me.OptionsCharacter.Achievements[ AchievementID ] = nil;
		if ( not next( me.OptionsCharacter.Achievements ) ) then -- Last
			me.Frame:UnregisterEvent( "ACHIEVEMENT_EARNED" );
			me.Frame:UnregisterEvent( "CRITERIA_UPDATE" );
		end
		me.Config.Search.AchievementSetEnabled( AchievementID, false );
		return true;
	end
end




--- Enables printing cache lists on login.
-- @return True if changed.
function me.SetCacheWarnings ( Enable )
	if ( not Enable ~= not me.Options.CacheWarnings ) then
		me.Options.CacheWarnings = Enable or nil;

		me.Config.CacheWarnings:SetChecked( Enable );
		return true;
	end
end
--- Enables adding a timestamp to printed messages.
-- @return True if changed.
function me.SetPrintTime ( Enable )
	if ( not Enable ~= not me.Options.PrintTime ) then
		me.Options.PrintTime = Enable or nil;

		me.Config.PrintTime:SetChecked( Enable );
		return true;
	end
end
--- Enables tracking of unneeded achievement NPCs.
-- @return True if changed.
function me.SetAchievementsAddFound ( Enable )
	if ( not Enable ~= not me.Options.AchievementsAddFound ) then
		me.Options.AchievementsAddFound = Enable or nil;
		me.Config.Search.AddFoundCheckbox:SetChecked( Enable );

		for _, Achievement in pairs( me.Achievements ) do
			if ( AchievementDeactivate( Achievement ) ) then -- Was active
				AchievementActivate( Achievement );
			end
		end
		return true;
	end
end
--- Enables unmuting sound to play found alerts.
-- @return True if changed.
function me.SetAlertSoundUnmute ( Enable )
	if ( not Enable ~= not me.Options.AlertSoundUnmute ) then
		me.Options.AlertSoundUnmute = Enable or nil;

		me.Config.AlertSoundUnmute:SetChecked( Enable );
		return true;
	end
end
--- Sets the sound to play when NPCs are found.
-- @return True if changed.
function me.SetAlertSound ( AlertSound )
	assert( AlertSound == nil or type( AlertSound ) == "string", "AlertSound must be a string or nil." );
	if ( AlertSound ~= me.Options.AlertSound ) then
		me.Options.AlertSound = AlertSound;

		UIDropDownMenu_SetText( me.Config.AlertSound, AlertSound == nil and L.CONFIG_ALERT_SOUND_DEFAULT or AlertSound );
		return true;
	end
end




local IsDefaultNPCValid;
do
	local IsHunter = select( 2, UnitClass( "player" ) ) == "HUNTER";
	local TamableExceptions = {
		[ 49822 ] = true; -- Jadefang drops a pet
	};
	--- @return True if NpcID should be a default for this character.
	function IsDefaultNPCValid ( NpcID )
		return IsHunter or not me.TamableIDs[ NpcID ] or TamableExceptions[ NpcID ];
	end
end
--- Resets the scanning list and reloads it from saved settings.
function me.Synchronize ( Options, OptionsCharacter )
	-- Load defaults if settings omitted
	local IsDefaultScan;
	if ( not Options ) then
		Options = me.OptionsDefault;
	end
	if ( not OptionsCharacter ) then
		OptionsCharacter, IsDefaultScan = me.OptionsCharacterDefault, true;
	end

	-- Clear all scans
	for AchievementID in pairs( me.OptionsCharacter.Achievements ) do
		me.AchievementRemove( AchievementID );
	end
	for NpcID in pairs( me.OptionsCharacter.NPCs ) do
		me.NPCRemove( NpcID );
	end
	assert( not next( ScanIDs ), "Orphan NpcIDs in scan pool!" );

	me.SetCacheWarnings( Options.CacheWarnings );
	me.SetPrintTime( Options.PrintTime );
	me.SetAchievementsAddFound( Options.AchievementsAddFound );
	me.SetAlertSoundUnmute( Options.AlertSoundUnmute );
	me.SetAlertSound( Options.AlertSound );

	local AddAllDefaults = IsShiftKeyDown();
	for NpcID, Name in pairs( OptionsCharacter.NPCs ) do
		-- If defaults, only add tamable custom mobs if the player is a hunter
		if ( AddAllDefaults or not IsDefaultScan or IsDefaultNPCValid( NpcID ) ) then
			me.NPCAdd( NpcID, Name, OptionsCharacter.NPCWorldIDs[ NpcID ] );
		end
	end
	for AchievementID in pairs( me.Achievements ) do
		-- If defaults, don't enable completed achievements unless explicitly allowed
		if ( OptionsCharacter.Achievements[ AchievementID ] and (
			not IsDefaultScan or Options.AchievementsAddFound or not select( 4, GetAchievementInfo( AchievementID ) ) -- Not completed
		) ) then
			me.AchievementAdd( AchievementID );
		end
	end
	me.CacheListPrint( false, true ); -- Populates cache list with inactive mobs too before printing
end




do
	local PetList = {};

	--- Prints the list of cached pets when leaving a city or inn.
	function me.Frame:PLAYER_UPDATE_RESTING ()
		if ( not IsResting() and next( PetList ) ) then
			if ( me.Options.CacheWarnings ) then
				local ListString = CacheListBuild( PetList );
				if ( ListString ) then
					me.Print( L.CACHED_PET_RESTING_FORMAT:format( ListString ), RED_FONT_COLOR );
				end
			else
				wipe( PetList );
			end
		end
	end

	--- @return True if the tamable mob is in its correct zone, else false with an optional reason string.
	local function OnFoundTamable ( NpcID, Name )
		local ExpectedZone = me.TamableIDs[ NpcID ];
		local ZoneIDBackup = GetCurrentMapAreaID();
		SetMapToCurrentZone();

		local InCorrectZone, InvalidReason =
			ExpectedZone == true -- Expected zone is unknown (instance mob, etc.)
			or ExpectedZone == GetCurrentMapAreaID();

		if ( not InCorrectZone ) then
			if ( IsResting() ) then -- Assume any tamable mob found in a city/inn is a hunter pet
				PetList[ NpcID ] = Name;  -- Suppress error message until the player stops resting
			else
				-- Get details about expected zone
				local ExpectedZoneName;
				SetMapByID( ExpectedZone );
				local Continent = GetCurrentMapContinent();
				if ( Continent >= 1 ) then
					local Zone = GetCurrentMapZone();
					if ( Zone == 0 ) then
						ExpectedZoneName = select( Continent, GetMapContinents() );
					else
						ExpectedZoneName = select( Zone, GetMapZones( Continent ) );
					end
				end
				InvalidReason = L.FOUND_TAMABLE_WRONGZONE_FORMAT:format(
					Name, GetZoneText(), ExpectedZoneName or L.FOUND_ZONE_UNKNOWN, ExpectedZone );
			end
		end

		SetMapByID( ZoneIDBackup ); -- Restore previous map view
		return InCorrectZone, InvalidReason;
	end
	--- Validates found mobs before showing alerts.
	local function OnFound ( NpcID, Name )
		-- Disable active scans
		NPCDeactivate( NpcID );
		for AchievementID in pairs( me.OptionsCharacter.Achievements ) do
			AchievementNPCDeactivate( me.Achievements[ AchievementID ], NpcID );
		end

		local Valid, InvalidReason = true;
		local Tamable = me.TamableIDs[ NpcID ];
		if ( Tamable ) then
			Valid, InvalidReason = OnFoundTamable( NpcID, Name );
		end

		if ( Valid ) then
			me.Print( L[ Tamable and "FOUND_TAMABLE_FORMAT" or "FOUND_FORMAT" ]:format( Name ), GREEN_FONT_COLOR );
			me.Button:SetNPC( NpcID, Name ); -- Sends added and found overlay messages
		elseif ( InvalidReason ) then
			me.Print( InvalidReason );
		end
	end

	local pairs = pairs;
	local GetAchievementCriteriaInfo = GetAchievementCriteriaInfo;
	--- Scans all active criteria and removes any completed NPCs.
	local function AchievementCriteriaUpdate ()
		if ( not me.Options.AchievementsAddFound ) then
			for AchievementID in pairs( me.OptionsCharacter.Achievements ) do
				local Achievement = me.Achievements[ AchievementID ];
				for NpcID, CriteriaID in pairs( Achievement.NPCsActive ) do
					local _, _, Complete = GetAchievementCriteriaInfo( CriteriaID );
					if ( Complete ) then
						AchievementNPCDeactivate( Achievement, NpcID );
					end
				end
			end
		end
	end
	local CriteriaUpdated = false;
	--- Stops tracking individual achievement NPCs when the player gets kill credit.
	function me.Frame:CRITERIA_UPDATE ()
		CriteriaUpdated = true;
	end

	--- Scans all NPCs on a timer and alerts if any are found.
	function me.Updater:OnLoop ()
		if ( CriteriaUpdated ) then -- CRITERIA_UPDATE bucket
			CriteriaUpdated = false;
			AchievementCriteriaUpdate();
		end

		for NpcID in pairs( ScanIDs ) do
			local Name = me.TestID( NpcID );
			if ( Name ) then
				OnFound( NpcID, Name );
			end
		end
	end
end
if ( select( 2, UnitClass( "player" ) ) == "HUNTER" ) then
	local StableUpdater = CreateFrame( "Frame" );

	local StabledList = {};
	--- Stops scans for stabled hunter pets before a bogus alert can fire.
	function me.Frame:PET_STABLE_UPDATE ()
		for NpcID in pairs( ScanIDs ) do
			local Name = me.TestID( NpcID );
			if ( Name ) then
				StabledList[ NpcID ] = Name;
				NPCDeactivate( NpcID );
				for AchievementID in pairs( me.OptionsCharacter.Achievements ) do
					AchievementNPCDeactivate( me.Achievements[ AchievementID ], NpcID );
				end
			end
		end
		StableUpdater:Show();
	end
	--- Bucket to print cached stabled pets on one line.
	function StableUpdater:OnUpdate ()
		self:Hide();
		if ( me.Options.CacheWarnings ) then
			local ListString = CacheListBuild( StabledList );
			if ( ListString ) then
				me.Print( L.CACHED_STABLED_FORMAT:format( ListString ) );
			end
		else
			wipe( StabledList );
		end
	end

	StableUpdater:Hide();
	StableUpdater:SetScript( "OnUpdate", StableUpdater.OnUpdate );
	me.Frame:RegisterEvent( "PET_STABLE_UPDATE" );

	local Backup = GetStablePetInfo;
	--- Prevents the pet UI from querying (and caching) pets until actually viewing the stables.
	-- @param Override  Forces a normal query even if the stables aren't open.
	function GetStablePetInfo ( Slot, Override, ... )
		if ( Override or IsAtStableMaster() ) then
			return Backup( Slot, Override, ... );
		end
	end
end




--- Loads defaults, validates settings, and starts scan.
-- Used instead of ADDON_LOADED to give overlay mods a chance to load and register for messages.
function me.Frame:PLAYER_LOGIN ( Event )
	self[ Event ] = nil;

	local Options, OptionsCharacter = _NPCScanOptions, _NPCScanOptionsCharacter;
	_NPCScanOptions, _NPCScanOptionsCharacter = me.Options, me.OptionsCharacter;

	-- Update settings incrementally
	if ( Options and Options.Version ~= me.Version ) then
		if ( Options.Version == "3.0.9.2" ) then -- 3.1.0.1: Added options for finding already found and tamable mobs
			Options.CacheWarnings = true;
			Options.Version = "3.1.0.1";
		end
		Options.Version = me.Version;
	end
	-- Character settings
	if ( OptionsCharacter and OptionsCharacter.Version ~= me.Version ) then
		local Version = OptionsCharacter.Version;

		local WorldIDs = me.OptionsCharacterDefault.NPCWorldIDs;
		--- Add NpcID if not already being searched for.
		local function AddDefault ( NpcID )
			if ( not OptionsCharacter.NPCs[ NpcID ] -- Not already searched for
				and IsDefaultNPCValid( NpcID )
			) then
				OptionsCharacter.NPCs[ NpcID ] = L.NPCs[ NpcID ];
				OptionsCharacter.NPCWorldIDs[ NpcID ] = WorldIDs[ NpcID ];
			end
		end

		if ( Version == "3.0.9.2" ) then -- 3.1.0.1: Remove NPCs that are duplicated by achievements
			local NPCs = OptionsCharacter.IDs;
			OptionsCharacter.IDs = nil;
			OptionsCharacter.NPCs = NPCs;
			OptionsCharacter.Achievements = {};
			local AchievementNPCs = {};
			for AchievementID, Achievement in pairs( me.Achievements ) do
				for _, NpcID in pairs( Achievement.Criteria ) do
					AchievementNPCs[ NpcID ] = AchievementID;
				end
			end
			for Name, NpcID in pairs( NPCs ) do
				if ( AchievementNPCs[ NpcID ] ) then
					NPCs[ Name ] = nil;
					OptionsCharacter.Achievements[ AchievementNPCs[ NpcID ] ] = true;
				end
			end
			Version = "3.1.0.1";
		end
		if ( Version == "3.1.0.1" or Version == "3.2.0.1" or Version == "3.2.0.2" ) then
			-- 3.2.0.3: Added default scan for Skoll
			OptionsCharacter.NPCs[ L.NPCs[ 35189 ] ] = 35189;
			Version = "3.2.0.3";
		end
		if ( "3.2.0.3" <= Version and Version <= "3.3.0.1" ) then
			-- 3.3.0.2: Added default scan for Arcturis
			OptionsCharacter.NPCs[ L.NPCs[ 38453 ] ] = 38453;
			Version = "3.3.0.2";
		end
		if ( Version == "3.3.0.2" or Version == "3.3.0.3" or Version == "3.3.0.4" ) then
			-- 3.3.5.1: Custom NPC scans are indexed by ID instead of name, and can now be map-specific
			local DefaultWorldIDs = me.OptionsCharacterDefault.NPCWorldIDs;
			local NPCsNew, NPCWorldIDs = {}, {};
			for Name, NpcID in pairs( OptionsCharacter.NPCs ) do
				NPCsNew[ NpcID ] = Name;
				NPCWorldIDs[ NpcID ] = DefaultWorldIDs[ NpcID ];
			end
			OptionsCharacter.NPCs, OptionsCharacter.NPCWorldIDs = NPCsNew, NPCWorldIDs;
			Version = "3.3.5.1";
		end
		if ( Version < "4.0.3.1" ) then
			-- 4.0.3.1: Added default scans for Cataclysm rares
			AddDefault( 49913 ); -- Lady LaLa
			AddDefault( 50005 ); -- Poseidus
			AddDefault( 50009 ); -- Mobus
			AddDefault( 50050 ); -- Shok'sharak
			AddDefault( 50051 ); -- Ghostcrawler
			AddDefault( 50052 ); -- Burgy Blackheart
			AddDefault( 50053 ); -- Thartuk the Exile
			AddDefault( 50056 ); -- Garr
			AddDefault( 50057 ); -- Blazewing
			AddDefault( 50058 ); -- Terrorpene
			AddDefault( 50059 ); -- Golgarok
			AddDefault( 50060 ); -- Terborus
			AddDefault( 50061 ); -- Xariona
			AddDefault( 50062 ); -- Aeonaxx
			AddDefault( 50063 ); -- Akma'hat
			AddDefault( 50064 ); -- Cyrus the Black
			AddDefault( 50065 ); -- Armagedillo
			AddDefault( 50085 ); -- Overlord Sunderfury
			AddDefault( 50086 ); -- Tarvus the Vile
			AddDefault( 50089 ); -- Julak-Doom
			AddDefault( 50138 ); -- Karoma
			AddDefault( 50154 ); -- Madexx
			AddDefault( 50159 ); -- Sambas
			AddDefault( 50409 ); -- Mysterious Camel Figurine
			AddDefault( 50410 ); -- Mysterious Camel Figurine
			AddDefault( 51071 ); -- Captain Florence
			AddDefault( 51079 ); -- Captain Foulwind
			AddDefault( 51401 ); -- Madexx
			AddDefault( 51402 ); -- Madexx
			AddDefault( 51403 ); -- Madexx
			AddDefault( 51404 ); -- Madexx
			Version = "4.0.3.1";
		end
		if ( Version < "4.0.3.3" ) then
			-- 4.0.3.3: Fixed omission of Jadefang.
			AddDefault( 49822 ); -- Jadefang
			Version = "4.0.3.3";
		end
		OptionsCharacter.Version = me.Version;
	end

	me.Overlays.Register();
	me.Synchronize( Options, OptionsCharacter ); -- Loads defaults if either are nil
end
do
	local FirstWorld = true;
	--- Starts world-specific scans when entering a world.
	function me.Frame:PLAYER_ENTERING_WORLD ()
		-- Print cached pets if player ported out of a city
		self:PLAYER_UPDATE_RESTING();

		-- Since real MapIDs aren't available to addons, a "WorldID" is a universal ContinentID or the map's localized name.
		local MapName = GetInstanceInfo();
		me.WorldID = me.ContinentIDs[ MapName ] or MapName;

		-- Activate scans on this world
		for NpcID, WorldID in pairs( me.OptionsCharacter.NPCWorldIDs ) do
			NPCActivate( NpcID, WorldID );
		end
		for AchievementID in pairs( me.OptionsCharacter.Achievements ) do
			local Achievement = me.Achievements[ AchievementID ];
			if ( Achievement.WorldID ) then
				AchievementActivate( Achievement );
			end
		end

		if ( FirstWorld or not me.Options.CacheWarnings ) then -- Full listing of cached mobs gets printed on login
			FirstWorld = false;
			wipe( CacheList );
		else -- Print list of cached mobs specific to new world
			local ListString = CacheListBuild( CacheList );
			if ( ListString ) then
				me.Print( L.CACHED_WORLD_FORMAT:format( ListString, MapName ) );
			end
		end
	end
end
--- Stops world-specific scans when leaving a world.
function me.Frame:PLAYER_LEAVING_WORLD ()
	-- Stop scans that were only active on the previous world
	for NpcID in pairs( me.OptionsCharacter.NPCWorldIDs ) do
		NPCDeactivate( NpcID );
	end
	for AchievementID in pairs( me.OptionsCharacter.Achievements ) do
		local Achievement = me.Achievements[ AchievementID ];
		if ( Achievement.WorldID ) then
			AchievementDeactivate( Achievement );
		end
	end
	me.WorldID = nil;
end
--- Stops tracking achievements when they finish.
function me.Frame:ACHIEVEMENT_EARNED ( _, AchievementID )
	if ( not me.Options.AchievementsAddFound ) then
		me.AchievementRemove( AchievementID );
	end
end
--- Sets the update handler only after zone info is known.
function me.Frame:ZONE_CHANGED_NEW_AREA ( Event )
	self:UnregisterEvent( Event );
	self[ Event ] = nil;

	me.Updater:SetScript( "OnLoop", me.Updater.OnLoop );
end
--- Global event handler.
function me.Frame:OnEvent ( Event, ... )
	if ( self[ Event ] ) then
		return self[ Event ]( self, Event, ... );
	end
end




--- Slash command chat handler to open the options pane and manage the NPC list.
function me.SlashCommand ( Input )
	local Command, Arguments = Input:match( "^(%S+)%s*(.-)%s*$" );
	if ( Command ) then
		Command = Command:upper();
		if ( Command == L.CMD_ADD ) then
			local ID, Name = Arguments:match( "^(%d+)%s+(.+)$" );
			if ( ID ) then
				ID = tonumber( ID );
				me.NPCRemove( ID );
				if ( me.NPCAdd( ID, Name ) ) then
					me.CacheListPrint( true );
				end
				return;
			end
		elseif ( Command == L.CMD_REMOVE ) then
			local ID = tonumber( Arguments );
			if ( not ID ) then -- Search custom names
				for NpcID, Name in pairs( me.OptionsCharacter.NPCs ) do
					if ( Name == Arguments ) then
						ID = NpcID;
						break;
					end
				end
			end
			if ( not me.NPCRemove( ID ) ) then
				me.Print( L.CMD_REMOVENOTFOUND_FORMAT:format( Arguments ), RED_FONT_COLOR );
			end
			return;
		elseif ( Command == L.CMD_CACHE ) then -- Force print full cache list
			if ( not me.CacheListPrint( true, true ) ) then -- Nothing in cache
				me.Print( L.CMD_CACHE_EMPTY, GREEN_FONT_COLOR );
			end
			return;
		end
		-- Invalid subcommand
		me.Print( L.CMD_HELP );

	else -- No subcommand
		InterfaceOptionsFrame_OpenToCategory( me.Config.Search );
	end
end




-- Create reverse lookup of continent names
for Index, Name in pairs( me.ContinentNames ) do
	me.ContinentIDs[ Name ] = Index;
end
-- Save achievement criteria data
for AchievementID, Achievement in pairs( me.Achievements ) do
	Achievement.ID = AchievementID;
	Achievement.Criteria = {}; -- [ CriteriaID ] = NpcID;
	Achievement.NPCsActive = {}; -- [ NpcID ] = CriteriaID;
	for Criteria = 1, GetAchievementNumCriteria( AchievementID ) do
		local _, CriteriaType, _, _, _, _, _, AssetID, _, CriteriaID = GetAchievementCriteriaInfo( AchievementID, Criteria );
		if ( CriteriaType == 0 ) then -- Mob kill type
			Achievement.Criteria[ CriteriaID ] = AssetID;
		end
	end
end


local Frame = me.Frame;
Frame:SetScript( "OnEvent", Frame.OnEvent );
if ( not IsLoggedIn() ) then
	Frame:RegisterEvent( "PLAYER_LOGIN" );
else
	Frame:PLAYER_LOGIN( "PLAYER_LOGIN" );
end
Frame:RegisterEvent( "PLAYER_ENTERING_WORLD" );
Frame:RegisterEvent( "PLAYER_LEAVING_WORLD" );
Frame:RegisterEvent( "PLAYER_UPDATE_RESTING" );

me.Updater:CreateAnimation( "Animation" ):SetDuration( me.Updater.UpdateRate );
me.Updater:SetLooping( "REPEAT" );
-- Set update handler after zone info loads
if ( GetZoneText() == "" ) then -- Zone information unknown (initial login)
	Frame:RegisterEvent( "ZONE_CHANGED_NEW_AREA" );
else -- Zone information is known
	Frame:ZONE_CHANGED_NEW_AREA( "ZONE_CHANGED_NEW_AREA" );
end

SlashCmdList[ "_NPCSCAN" ] = me.SlashCommand;
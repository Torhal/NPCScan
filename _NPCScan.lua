--[[****************************************************************************
  * _NPCScan by Saiket                                                         *
  * _NPCScan.lua - Scans NPCs near you for specific rare NPC IDs.              *
  ****************************************************************************]]


local L = _NPCScanLocalization;
local me = CreateFrame( "Frame", "_NPCScan" );
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
me.OptionsCharacterDefault = {
	Version = me.Version;
	NPCs = {
		[ 18684 ] = L.NPCS[ 18684 ]; -- Bro'Gaz the Clanless
		[ 32491 ] = L.NPCS[ 32491 ]; -- Time-Lost Proto Drake
		[ 33776 ] = L.NPCS[ 33776 ]; -- Gondria
		[ 35189 ] = L.NPCS[ 35189 ]; -- Skoll
		[ 38453 ] = L.NPCS[ 38453 ]; -- Arcturis
	};
	NPCWorldIDs = {
		[ 18684 ] = 3; -- Bro'Gaz the Clanless
		[ 32491 ] = 4; -- Time-Lost Proto Drake
		[ 33776 ] = 4; -- Gondria
		[ 35189 ] = 4; -- Skoll
		[ 38453 ] = 4; -- Arcturis
	};
	Achievements = {
		[ 1312 ] = true; -- Bloody Rare (Outlands)
		[ 2257 ] = true; -- Frostbitten (Northrend)
	};
};


me.Achievements = { -- Criteria data for each achievement
	[ 1312 ] = { WorldID = 3; }; -- Bloody Rare (Outlands)
	[ 2257 ] = { WorldID = 4; }; -- Frostbitten (Northrend)
};
me.ContinentIDs = {}; -- [ Localized continent name ] = Continent ID (mirrors WorldMapContinent.dbc)

me.NpcIDMax = 0xFFFFF; -- Largest ID that will fit in a GUID's 20-bit NPC ID field
me.UpdateRate = 0.1;




--[[****************************************************************************
  * Function: _NPCScan.Print                                                   *
  * Description: Prints a message in the default chat window.                  *
  ****************************************************************************]]
function me.Print ( Message, Color )
	if ( not Color ) then
		Color = NORMAL_FONT_COLOR;
	end
	DEFAULT_CHAT_FRAME:AddMessage( L.PRINT_FORMAT:format( Message ), Color.r, Color.g, Color.b );
end


--[[****************************************************************************
  * Function: _NPCScan.TestID                                                  *
  * Description: Checks for a given NpcID.                                     *
  ****************************************************************************]]
do
	local Tooltip = CreateFrame( "GameTooltip", "_NPCScanTooltip", me );
	-- Add template text lines
	local Text = Tooltip:CreateFontString();
	Tooltip:AddFontStrings( Text, Tooltip:CreateFontString() );
	function me.TestID ( NpcID )
		Tooltip:SetOwner( WorldFrame, "ANCHOR_NONE" );
		Tooltip:SetHyperlink( ( "unit:0xF5300%05X000000" ):format( NpcID ) );
		if ( Tooltip:IsShown() ) then
			return Text:GetText();
		end
	end
end


local CacheListAdd, CacheListClear;
do
	local CachedIDs, CacheList = {}, {};
	function CacheListAdd ( NpcID, FoundName ) -- Adds a cached NPC's name to the string builder
		if ( not CachedIDs[ NpcID ] ) then
			CachedIDs[ NpcID ], CacheList[ #CacheList + 1 ] = true, FoundName;
		end
	end
	function CacheListClear () -- Clears the string builder's tables
		wipe( CachedIDs );
		wipe( CacheList );
	end
--[[****************************************************************************
  * Function: _NPCScan.CacheListPrint                                          *
  * Description: Prints a standard message listing cached mobs.  Will also     *
  *   print details about the cache the first time it's called.                *
  ****************************************************************************]]
	local FirstPrint = true;
	function me.CacheListPrint ( ForcePrint, Format, ... )
		if ( #CacheList > 0 ) then
			if ( ForcePrint or me.Options.CacheWarnings ) then
				if ( not Format ) then
					Format = L[ FirstPrint and "CACHED_LONG_FORMAT" or "CACHED_FORMAT" ];
					FirstPrint = false;
				end

				sort( CacheList );
				-- Add quotes to all names
				for Index, Name in ipairs( CacheList ) do
					CacheList[ Index ] = L.CACHED_NAME_FORMAT:format( Name );
				end
				me.Print( Format:format( table.concat( CacheList, L.CACHED_SEPARATOR ), ... ), ForcePrint and RED_FONT_COLOR );
			end
			CacheListClear();
			return true;
		end
	end
end
local function CacheListPopulate () -- Fills the cache list with all added NPCs, active or not
	for NpcID in pairs( me.OptionsCharacter.NPCs ) do
		local Name = me.TestID( NpcID );
		if ( Name ) then
			CacheListAdd( NpcID, Name );
		end
	end
	for AchievementID in pairs( me.OptionsCharacter.Achievements ) do
		for CriteriaID, NpcID in pairs( me.Achievements[ AchievementID ].Criteria ) do
			if ( me.Options.AchievementsAddFound or not select( 3, GetAchievementCriteriaInfo( CriteriaID ) ) ) then -- Not completed
				local Name = me.TestID( NpcID );
				if ( Name ) then
					CacheListAdd( NpcID, Name );
				end
			end
		end
	end
end




local next, assert = next, assert;

local ScanIDs = {}; -- [ NpcID ] = Number of concurrent scans for this ID
local function ScanAdd ( NpcID ) -- Begins searching for an NPC, and returns true if successful
	local FoundName = me.TestID( NpcID );
	if ( FoundName ) then -- Already seen
		CacheListAdd( NpcID, FoundName );
	else -- Increment
		if ( ScanIDs[ NpcID ] ) then
			ScanIDs[ NpcID ] = ScanIDs[ NpcID ] + 1;
		else
			if ( not next( ScanIDs ) ) then -- First
				me:Show();
			end
			ScanIDs[ NpcID ] = 1;
			me.Overlays.Add( NpcID );
		end
		return true; -- Successfully added
	end
end
local function ScanRemove ( NpcID ) -- Stops searching for an NPC when nothing is searching for it
	local Count = assert( ScanIDs[ NpcID ], "Attempt to remove inactive scan." );
	if ( Count > 1 ) then
		ScanIDs[ NpcID ] = Count - 1;
	else
		ScanIDs[ NpcID ] = nil;
		me.Overlays.Remove( NpcID );
		if ( not next( ScanIDs ) ) then -- Last
			me:Hide();
		end
	end
end




local function IsWorldIDActive ( WorldID ) -- Returns true if the given WorldID is active on the current world
	return not WorldID or WorldID == me.WorldID; -- False/nil active on all worlds
end

local NPCActivate, NPCDeactivate;
do
	local NPCsActive = {};
	function NPCActivate ( NpcID, WorldID ) -- Starts actual scan for NPC when entering a world
		if ( not NPCsActive[ NpcID ] and IsWorldIDActive( WorldID ) and ScanAdd( NpcID ) ) then
			NPCsActive[ NpcID ] = true;
			me.Config.Search.UpdateTab( "NPC" );
			return true; -- Successfully activated
		end
	end
	function NPCDeactivate ( NpcID ) -- Ends actual scan for NPC when leaving a world
		if ( NPCsActive[ NpcID ] ) then
			NPCsActive[ NpcID ] = nil;
			ScanRemove( NpcID );
			me.Config.Search.UpdateTab( "NPC" );
			return true; -- Successfully deactivated
		end
	end
--[[****************************************************************************
  * Function: _NPCScan.NPCIsActive                                             *
  * Description: Returns true if an NPC is actively being searched for.        *
  ****************************************************************************]]
	function me.NPCIsActive ( NpcID )
		return NPCsActive[ NpcID ];
	end
end
--[[****************************************************************************
  * Function: _NPCScan.NPCAdd                                                  *
  * Description: Adds an NPC name and ID to settings and begins searching.     *
  ****************************************************************************]]
function me.NPCAdd ( NpcID, Name, WorldID )
	local Options = me.OptionsCharacter;
	if ( not Options.NPCs[ NpcID ] ) then
		Options.NPCs[ NpcID ], Options.NPCWorldIDs[ NpcID ] = Name, WorldID;
		if ( not NPCActivate( NpcID, WorldID ) ) then -- Didn't activate
			me.Config.Search.UpdateTab( "NPC" ); -- Just add row
		end
		return true;
	end
end
--[[****************************************************************************
  * Function: _NPCScan.NPCRemove                                               *
  * Description: Removes an NPC from settings and stops searching for it.      *
  ****************************************************************************]]
function me.NPCRemove ( NpcID )
	local Options = me.OptionsCharacter;
	if ( Options.NPCs[ NpcID ] ) then
		Options.NPCs[ NpcID ], Options.NPCWorldIDs[ NpcID ] = nil;
		if ( not NPCDeactivate( NpcID ) ) then -- Wasn't active
			me.Config.Search.UpdateTab( "NPC" ); -- Just remove row
		end
		return true;
	end
end




local function AchievementNPCActivate ( Achievement, NpcID, CriteriaID ) -- Starts searching for an achievement's NPC
	if ( Achievement.Active and not Achievement.NPCsActive[ NpcID ]
		and ( me.Options.AchievementsAddFound or not select( 3, GetAchievementCriteriaInfo( CriteriaID ) ) ) -- Not completed
		and ScanAdd( NpcID )
	) then
		Achievement.NPCsActive[ NpcID ] = CriteriaID;
		me.Config.Search.UpdateTab( Achievement.ID );
		return true;
	end
end
local function AchievementNPCDeactivate ( Achievement, NpcID ) -- Stops searching for an achievement's NPC
	if ( Achievement.NPCsActive[ NpcID ] ) then
		Achievement.NPCsActive[ NpcID ] = nil;
		ScanRemove( NpcID );
		me.Config.Search.UpdateTab( Achievement.ID );
		return true;
	end
end
local function AchievementActivate ( Achievement ) -- Starts actual scans for achievement NPCs when entering a world
	if ( not Achievement.Active and IsWorldIDActive( Achievement.WorldID ) ) then
		Achievement.Active = true;
		for CriteriaID, NpcID in pairs( Achievement.Criteria ) do
			AchievementNPCActivate( Achievement, NpcID, CriteriaID );
		end
		return true;
	end
end
local function AchievementDeactivate ( Achievement ) -- Ends actual scans for achievement NPCs when leaving a world
	if ( Achievement.Active ) then
		Achievement.Active = nil;
		for NpcID in pairs( Achievement.NPCsActive ) do
			AchievementNPCDeactivate( Achievement, NpcID );
		end
		return true;
	end
end
--[[****************************************************************************
  * Function: _NPCScan.AchievementNPCIsActive                                  *
  * Description: Returns true if an achievement NPC is being searched for.     *
  ****************************************************************************]]
function me.AchievementNPCIsActive ( Achievement, NpcID )
	return Achievement.NPCsActive[ NpcID ] ~= nil;
end
--[[****************************************************************************
  * Function: _NPCScan.AchievementAdd                                          *
  * Description: Adds a kill-related achievement to track.                     *
  ****************************************************************************]]
function me.AchievementAdd ( AchievementID )
	local Achievement = me.Achievements[ AchievementID ];
	if ( Achievement and not me.OptionsCharacter.Achievements[ AchievementID ] ) then
		if ( not next( me.OptionsCharacter.Achievements ) ) then -- First
			me:RegisterEvent( "ACHIEVEMENT_EARNED" );
			me:RegisterEvent( "CRITERIA_UPDATE" );
		end
		me.OptionsCharacter.Achievements[ AchievementID ] = true;
		me.Config.Search.AchievementSetEnabled( AchievementID, true );
		AchievementActivate( Achievement );
		return true;
	end
end
--[[****************************************************************************
  * Function: _NPCScan.AchievementRemove                                       *
  * Description: Removes an achievement from settings and stops tracking it.   *
  ****************************************************************************]]
function me.AchievementRemove ( AchievementID )
	if ( me.OptionsCharacter.Achievements[ AchievementID ] ) then
		AchievementDeactivate( me.Achievements[ AchievementID ] );
		me.OptionsCharacter.Achievements[ AchievementID ] = nil;
		if ( not next( me.OptionsCharacter.Achievements ) ) then -- Last
			me:UnregisterEvent( "ACHIEVEMENT_EARNED" );
			me:UnregisterEvent( "CRITERIA_UPDATE" );
		end
		me.Config.Search.AchievementSetEnabled( AchievementID, false );
		return true;
	end
end




--[[****************************************************************************
  * Function: _NPCScan.SetCacheWarnings                                        *
  * Description: Enables printing cache lists on login.                        *
  ****************************************************************************]]
function me.SetCacheWarnings ( Enable )
	if ( not Enable ~= not me.Options.CacheWarnings ) then
		me.Options.CacheWarnings = Enable or nil;

		me.Config.CacheWarnings:SetChecked( Enable );
		return true;
	end
end
--[[****************************************************************************
  * Function: _NPCScan.SetAchievementsAddFound                                 *
  * Description: Enables tracking of unneeded achievement NPCs.                *
  ****************************************************************************]]
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
--[[****************************************************************************
  * Function: _NPCScan.SetAlertSoundUnmute                                     *
  * Description: Enables unmuting sound to play found alerts.                  *
  ****************************************************************************]]
function me.SetAlertSoundUnmute ( Enable )
	if ( not Enable ~= not me.Options.AlertSoundUnmute ) then
		me.Options.AlertSoundUnmute = Enable or nil;

		me.Config.AlertSoundUnmute:SetChecked( Enable );
		return true;
	end
end
--[[****************************************************************************
  * Function: _NPCScan.SetAlertSound                                           *
  * Description: Sets the sound to play when NPCs are found.                   *
  ****************************************************************************]]
function me.SetAlertSound ( AlertSound )
	if ( AlertSound ~= me.Options.AlertSound ) then
		me.Options.AlertSound = AlertSound;

		UIDropDownMenu_SetText( me.Config.AlertSound, AlertSound == nil and L.CONFIG_ALERT_SOUND_DEFAULT or AlertSound );
		return true;
	end
end




--[[****************************************************************************
  * Function: _NPCScan.Synchronize                                             *
  * Description: Resets the scanning list and reloads it from saved settings.  *
  ****************************************************************************]]
function me.Synchronize ( Options, OptionsCharacter )
	-- Load defaults if settings omitted
	local IsDefaultScan, IsHunter;
	if ( not Options ) then
		Options = me.OptionsDefault;
	end
	if ( not OptionsCharacter ) then
		OptionsCharacter = me.OptionsCharacterDefault;
		IsDefaultScan, IsHunter = true, IsShiftKeyDown() or select( 2, UnitClass( "player" ) ) == "HUNTER";
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
	me.SetAchievementsAddFound( Options.AchievementsAddFound );
	me.SetAlertSoundUnmute( Options.AlertSoundUnmute );
	me.SetAlertSound( Options.AlertSound );

	for NpcID, Name in pairs( OptionsCharacter.NPCs ) do
		-- If defaults, only add tamable custom mobs if the player is a hunter
		if ( not IsDefaultScan or IsHunter or not me.TamableIDs[ NpcID ] ) then
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
	CacheListPopulate(); -- Adds inactive mobs to printed list as well
	me.CacheListPrint();
end


--[[****************************************************************************
  * Function: _NPCScan:OnUpdate                                                *
  * Description: Scans all NPCs and alerts if any are found.                   *
  ****************************************************************************]]
do
	local pairs = pairs;
	local GetAchievementCriteriaInfo = GetAchievementCriteriaInfo;
	local function AchievementCriteriaUpdate () -- Scans all active criteria and removes any completed NPCs
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

	local function OnFound ( NpcID, Name ) -- Validates found mobs before showing alerts
		NPCDeactivate( NpcID );
		for AchievementID in pairs( me.OptionsCharacter.Achievements ) do
			AchievementNPCDeactivate( me.Achievements[ AchievementID ], NpcID );
		end

		local ZoneIDExpected, InvalidMessage = me.TamableIDs[ NpcID ];
		if ( ZoneIDExpected == true ) then -- Tamable, but expected zone is unknown (instance mob, etc.)
			if ( IsResting() ) then -- Most likely a hunter pet in town
				InvalidMessage = L.FOUND_TAMABLE_RESTING_FORMAT:format( Name );
			end
		elseif ( ZoneIDExpected ) then -- Expected zone of the mob is known
			local ZoneIDBackup = GetCurrentMapAreaID() - 1;
			SetMapToCurrentZone();

			if ( ZoneIDExpected ~= GetCurrentMapAreaID() - 1 ) then -- Definitely a pet; Found in wrong zone
				-- Find the name of the expected zone
				local ZoneTextExpected;
				SetMapByID( ZoneIDExpected );
				local Continent = GetCurrentMapContinent();
				if ( Continent >= 1 ) then
					local Zone = GetCurrentMapZone();
					if ( Zone == 0 ) then
						ZoneTextExpected = select( Continent, GetMapContinents() );
					else
						ZoneTextExpected = select( Zone, GetMapZones( Continent ) );
					end
				end
				InvalidMessage = L.FOUND_TAMABLE_WRONGZONE_FORMAT:format( Name, GetZoneText(),
					ZoneTextExpected or L.FOUND_ZONE_UNKNOWN, ZoneIDExpected );
			end

			SetMapByID( ZoneIDBackup ); -- Restore previous map view
		end

		me.Print( InvalidMessage or L[ ZoneIDExpected and "FOUND_TAMABLE_FORMAT" or "FOUND_FORMAT" ]:format( Name ), GREEN_FONT_COLOR );
		if ( not InvalidMessage ) then
			me.Button:SetNPC( NpcID, Name ); -- Sends added and found overlay messages
		end
	end

	local LastUpdate = 0;
	function me:OnUpdate ( Elapsed )
		LastUpdate = LastUpdate + Elapsed;
		if ( LastUpdate >= me.UpdateRate ) then
			LastUpdate = 0;

			if ( me.CriteriaUpdateRequested ) then -- CRITERIA_UPDATE bucket
				me.CriteriaUpdateRequested = nil;
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
end
--[[****************************************************************************
  * Function: _NPCScan:PLAYER_LOGIN                                            *
  * Description: Loads defaults, validates settings, and starts scan.          *
  ****************************************************************************]]
function me:PLAYER_LOGIN ()
	me.PLAYER_LOGIN = nil;

	local Options = _NPCScanOptions;
	local OptionsCharacter = _NPCScanOptionsCharacter;
	_NPCScanOptions = me.Options;
	_NPCScanOptionsCharacter = me.OptionsCharacter;

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
			OptionsCharacter.NPCs[ L.NPCS[ 35189 ] ] = 35189;
			Version = "3.2.0.3";
		end
		if ( "3.2.0.3" <= Version and Version <= "3.3.0.1" ) then
			-- 3.3.0.2: Added default scan for Arcturis
			OptionsCharacter.NPCs[ L.NPCS[ 38453 ] ] = 38453;
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
		OptionsCharacter.Version = me.Version;
	end

	me.Overlays.Register();
	me.Synchronize( Options, OptionsCharacter ); -- Loads defaults if either are nil
end
--[[****************************************************************************
  * Function: _NPCScan:PLAYER_ENTERING_WORLD                                   *
  ****************************************************************************]]
do
	local FirstWorld = true;
	function me:PLAYER_ENTERING_WORLD ()
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
		if ( FirstWorld ) then -- Full listing of cached mobs gets printed on login
			FirstWorld = false;
			CacheListClear();
		else -- Print list of cached mobs specific to new world
			me.CacheListPrint( false, L.CACHED_WORLD_FORMAT, MapName );
		end
	end
end
--[[****************************************************************************
  * Function: _NPCScan:PLAYER_LEAVING_WORLD                                    *
  ****************************************************************************]]
function me:PLAYER_LEAVING_WORLD ()
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
--[[****************************************************************************
  * Function: _NPCScan:ACHIEVEMENT_EARNED                                      *
  ****************************************************************************]]
function me:ACHIEVEMENT_EARNED ( _, AchievementID )
	if ( not me.Options.AchievementsAddFound ) then
		me.AchievementRemove( AchievementID );
	end
end
--[[****************************************************************************
  * Function: _NPCScan:CRITERIA_UPDATE                                         *
  ****************************************************************************]]
function me:CRITERIA_UPDATE ()
	me.CriteriaUpdateRequested = true;
end
--[[****************************************************************************
  * Function: _NPCScan:ZONE_CHANGED_NEW_AREA                                   *
  * Description: Sets the OnUpdate handler only after zone info is known.      *
  ****************************************************************************]]
function me:ZONE_CHANGED_NEW_AREA ( Event )
	self:UnregisterEvent( Event );
	self[ Event ] = nil;

	self:SetScript( "OnUpdate", me.OnUpdate );
end
--[[****************************************************************************
  * Function: _NPCScan:OnEvent                                                 *
  ****************************************************************************]]
do
	local type = type;
	function me:OnEvent ( Event, ... )
		if ( type( self[ Event ] ) == "function" ) then
			self[ Event ]( self, Event, ... );
		end
	end
end




--[[****************************************************************************
  * Function: _NPCScan.SlashCommand                                            *
  * Description: Slash command chat handler to open the options pane.  Also    *
  *   supports various subcommands for managing the NPC list.                  *
  ****************************************************************************]]
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
		elseif ( Command == L.CMD_CACHE ) then
			CacheListPopulate();
			if ( not me.CacheListPrint( true ) ) then -- Nothing in cache
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
for Index, Name in ipairs( { GetMapContinents() } ) do
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


me:Hide();
me:SetScript( "OnEvent", me.OnEvent );
me:RegisterEvent( "PLAYER_LOGIN" );
me:RegisterEvent( "PLAYER_ENTERING_WORLD" );
me:RegisterEvent( "PLAYER_LEAVING_WORLD" );
-- Set OnUpdate script after zone info loads
if ( GetZoneText() == "" ) then -- Zone information unknown (initial login)
	me:RegisterEvent( "ZONE_CHANGED_NEW_AREA" );
else -- Zone information is known
	me:ZONE_CHANGED_NEW_AREA( "ZONE_CHANGED_NEW_AREA" );
end

SlashCmdList[ "_NPCSCAN" ] = me.SlashCommand;
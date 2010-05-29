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
	NPCs = { -- Values must be lowercase and trimmed, but don't have to match the NPC name
		[ 33776 ] = L.NPCS[ "Gondria" ]:trim():lower();
		[ 35189 ] = L.NPCS[ "Skoll" ]:trim():lower();
		[ 38453 ] = L.NPCS[ "Arcturis" ]:trim():lower();
		[ 32491 ] = L.NPCS[ "Time-Lost Proto Drake" ]:trim():lower();
	};
	NPCWorldIDs = {
		[ 33776 ] = 4; -- Gondria
		[ 35189 ] = 4; -- Skoll
		[ 38453 ] = 4; -- Arcturis
		[ 32491 ] = 4; -- Time-Lost Proto Drake
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

me.IDMax = 0xFFFFF; -- Largest ID that will fit in a GUID's 20-bit NPC ID field
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
  * Function: _NPCScan.CacheListAdd                                            *
  ****************************************************************************]]
do
	local CachedIDs, CacheList = {}, {};
	function me.CacheListAdd ( NpcID, FoundName )
		if ( not CachedIDs[ NpcID ] ) then
			CachedIDs[ NpcID ] = true;
			CacheList[ #CacheList + 1 ] = FoundName;
		end
	end
--[[****************************************************************************
  * Function: _NPCScan.CacheListPrint                                          *
  ****************************************************************************]]
	local FirstPrint = true;
	function me.CacheListPrint ( ForcePrint )
		if ( #CacheList > 0 ) then
			if ( ForcePrint or me.Options.CacheWarnings ) then
				for Index, Name in ipairs( CacheList ) do
					CacheList[ Index ] = L.CACHED_NAME_FORMAT:format( Name );
				end
				sort( CacheList );
				me.Print( L[ FirstPrint and "CACHED_LONG_FORMAT" or "CACHED_FORMAT" ]:format( table.concat( CacheList, L.CACHED_SEPARATOR ) ),
					ForcePrint and RED_FONT_COLOR );
				FirstPrint = false;
			end
			wipe( CachedIDs );
			wipe( CacheList );
			return true;
		end
	end
end


--[[****************************************************************************
  * Function: _NPCScan.GetCurrentWorldID                                       *
  * Description: Gets the ID of the current continent or its map name.         *
  ****************************************************************************]]
function me.GetCurrentWorldID ()
	local MapName = GetInstanceInfo();
	return me.ContinentIDs[ MapName ] or MapName;
end
--[[****************************************************************************
  * Function: _NPCScan.TestID                                                  *
  * Description: Checks for a given NpcID.                                     *
  ****************************************************************************]]
do
	local Tooltip = CreateFrame( "GameTooltip", "_NPCScanTooltip", me );
	-- Add template text lines
	local Text = Tooltip:CreateFontString( "$parentTextLeft1", nil, "GameTooltipText" );
	Tooltip:AddFontStrings( Text, Tooltip:CreateFontString( "$parentTextRight1", nil, "GameTooltipText" ) );
	function me.TestID ( NpcID )
		Tooltip:SetOwner( WorldFrame, "ANCHOR_NONE" );
		Tooltip:SetHyperlink( ( "unit:0xF5300%05X000000" ):format( NpcID ) );
		if ( Tooltip:IsShown() ) then
			return Text:GetText();
		end
	end
end

local ScanIDs = {}; -- [ NpcID ] = Number of concurrent scans for this ID
local function ScanAdd ( NpcID ) -- Begins searching for an NPC
	local FoundName = me.TestID( NpcID );
	if ( FoundName ) then -- Already seen
		me.CacheListAdd( NpcID, FoundName );
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
		return true;
	end
end
local function ScanRemove ( NpcID ) -- Stops searching for an NPC when nothing is searching for it
	local Count = ScanIDs[ NpcID ];
	if ( Count ) then -- Decrement
		if ( Count > 1 ) then
			ScanIDs[ NpcID ] = Count - 1;
		else
			ScanIDs[ NpcID ] = nil;
			me.Overlays.Remove( NpcID );
			if ( not next( ScanIDs ) ) then -- Last
				me:Hide();
			end
		end
		return true;
	end
end
local function ScanRemoveAll ( NpcID ) -- Removes all concurrent scans for an ID
	if ( ScanIDs[ NpcID ] ) then
		ScanIDs[ NpcID ] = nil;
		me.Overlays.Remove( NpcID );
		if ( not next( ScanIDs ) ) then -- Last
			me:Hide();
		end
	end
end




local function NPCSetActive ( NpcID, Activate ) -- Starts/stops actual scan for NPC when changing worlds
	( Activate and ScanAdd or ScanRemove )( NpcID );
	me.Config.Search.UpdateTab( "NPC" );
end
--[[****************************************************************************
  * Function: _NPCScan.NPCAdd                                                  *
  * Description: Adds an NPC name and ID to settings and begins searching.     *
  ****************************************************************************]]
function me.NPCAdd ( NpcID, Name, WorldID )
	local Options = me.OptionsCharacter;
	if ( not Options.NPCs[ NpcID ] ) then
		Options.NPCs[ NpcID ], Options.NPCWorldIDs[ NpcID ] = Name:trim():lower(), WorldID;
		if ( not WorldID or WorldID == me.GetCurrentWorldID() ) then
			NPCSetActive( NpcID, true );
		else -- Wasn't active; Just add row
			me.Config.Search.UpdateTab( "NPC" );
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
		local WorldID = Options.NPCWorldIDs[ NpcID ];
		Options.NPCs[ NpcID ], Options.NPCWorldIDs[ NpcID ] = nil;
		if ( not WorldID or WorldID == me.GetCurrentWorldID() ) then
			NPCSetActive( NpcID, false );
		else -- Wasn't active; Just remove row
			me.Config.Search.UpdateTab( "NPC" );
		end
		return true;
	end
end




local function AchievementSetActive ( AchievementID, Activate ) -- Starts/stops actual scan for NPCs when changing worlds
	local Achievement = me.Achievements[ AchievementID ];
	local Updated;

	if ( Activate ) then
		for CriteriaID, NpcID in pairs( Achievement.Criteria ) do
			if ( not Achievement.Active[ NpcID ]
				and ( me.Options.AchievementsAddFound or select( 3, GetAchievementCriteriaInfo( CriteriaID ) ) ) -- Completed
				and ScanAdd( NpcID )
			) then
				Updated, Achievement.Active[ NpcID ] = true, true;
			end
		end
	else -- End all active scans
		for NpcID in pairs( Achievement.Active ) do
			if ( ScanRemove( NpcID ) ) then
				Updated, Achievement.Active[ NpcID ] = true, nil;
			end
		end
	end

	if ( Updated ) then -- Added or removed scans
		me.Config.Search.UpdateTab( AchievementID );
	end
end
do
	local function AchievementSetEnabled ( AchievementID, Enable )
		me.Config.Search.AchievementSetEnabled( AchievementID, Enable );
		if ( not me.Achievements[ AchievementID ].WorldID
			or me.GetCurrentWorldID() == me.Achievements[ AchievementID ].WorldID
		) then -- Active on this map
			AchievementSetActive( AchievementID, Enable );
		end
	end
--[[****************************************************************************
  * Function: _NPCScan.AchievementAdd                                          *
  * Description: Adds a kill-related achievement to track.                     *
  ****************************************************************************]]
	function me.AchievementAdd ( AchievementID )
		if ( me.Achievements[ AchievementID ] and not me.OptionsCharacter.Achievements[ AchievementID ] ) then
			if ( not next( me.OptionsCharacter.Achievements ) ) then -- First
				me:RegisterEvent( "ACHIEVEMENT_EARNED" );
				me:RegisterEvent( "CRITERIA_UPDATE" );
			end
			me.OptionsCharacter.Achievements[ AchievementID ] = true;
			AchievementSetEnabled( AchievementID, true );
			return true;
		end
	end
--[[****************************************************************************
  * Function: _NPCScan.AchievementRemove                                       *
  * Description: Removes an achievement from settings and stops tracking it.   *
  ****************************************************************************]]
	function me.AchievementRemove ( AchievementID )
		if ( me.OptionsCharacter.Achievements[ AchievementID ] ) then
			me.OptionsCharacter.Achievements[ AchievementID ] = nil;
			if ( not next( me.OptionsCharacter.Achievements ) ) then -- Last
				me:UnregisterEvent( "ACHIEVEMENT_EARNED" );
				me:UnregisterEvent( "CRITERIA_UPDATE" );
			end
			AchievementSetEnabled( AchievementID, false );
			return true;
		end
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

		for AchievementID in pairs( me.OptionsCharacter.Achievements ) do
			me.AchievementRemove( AchievementID );
			me.AchievementAdd( AchievementID );
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
		IsDefaultScan, IsHunter = true, select( 2, UnitClass( "player" ) ) == "HUNTER";
	end

	-- Clear all scans
	for AchievementID in pairs( me.OptionsCharacter.Achievements ) do
		me.AchievementRemove( AchievementID );
	end
	for NpcID in pairs( me.OptionsCharacter.NPCs ) do
		me.NPCRemove( NpcID );
	end
	for NpcID in pairs( ScanIDs ) do
		ScanRemoveAll( NpcID );
	end

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
				local Updated = false;
				for NpcID, CriteriaID in pairs( Achievement.Active ) do
					local _, _, Complete = GetAchievementCriteriaInfo( CriteriaID );
					if ( Complete ) then
						Updated, Achievement.Active[ NpcID ] = true, nil;
						ScanRemove( NpcID );
					end
				end
				if ( Updated ) then
					me.Config.Search.UpdateTab( AchievementID );
				end
			end
		end
	end

	local function OnFound ( NpcID, Name ) -- Validates found mobs before showing alerts
		ScanRemoveAll( NpcID );
		for AchievementID in pairs( me.OptionsCharacter.Achievements ) do
			me.Achievements[ AchievementID ].Active[ NpcID ] = nil;
		end
		me.Config.Search.UpdateTab();

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
			OptionsCharacter.NPCs[ L.NPCS[ "Skoll" ]:trim():lower() ] = 35189;
			Version = "3.2.0.3";
		end
		if ( "3.2.0.3" <= Version and Version <= "3.3.0.1" ) then
			-- 3.3.0.2: Added default scan for Arcturis
			OptionsCharacter.NPCs[ L.NPCS[ "Arcturis" ]:trim():lower() ] = 38453;
			Version = "3.3.0.2";
		end
		if ( Version == "3.3.0.2" or Version == "3.3.0.3" or Version == "3.3.0.4" ) then
			-- 3.3.0.5: Custom NPC scans are indexed by ID instead of name, and can now be map-specific
			local DefaultWorldIDs = me.OptionsCharacterDefault.NPCWorldIDs;
			local NPCsNew, NPCWorldIDs = {}, {};
			for Name, NpcID in pairs( OptionsCharacter.NPCs ) do
				NPCsNew[ NpcID ] = Name;
				NPCWorldIDs[ NpcID ] = DefaultWorldIDs[ NpcID ];
			end
			OptionsCharacter.NPCs, OptionsCharacter.NPCWorldIDs = NPCsNew, NPCWorldIDs;
			Version = "3.3.0.5";
		end
		OptionsCharacter.Version = me.Version;
	end

	me.Overlays.Register();
	me.Synchronize( Options, OptionsCharacter ); -- Loads defaults if either are nil
end
do
	local function SetWorldScansActive ( Active ) -- Activates or deactivates all scans tied to the current map
		local CurrentWorldID = me.GetCurrentWorldID();
		for NpcID, WorldID in pairs( me.OptionsCharacter.NPCWorldIDs ) do
			if ( WorldID == CurrentWorldID ) then
				NPCSetActive( NpcID, Active );
			end
		end
		for AchievementID in pairs( me.OptionsCharacter.Achievements ) do
			if ( me.Achievements[ AchievementID ].WorldID == CurrentWorldID ) then
				AchievementSetActive( AchievementID, Active );
			end
		end
	end
--[[****************************************************************************
  * Function: _NPCScan:PLAYER_ENTERING_WORLD                                   *
  ****************************************************************************]]
	function me:PLAYER_ENTERING_WORLD ()
		SetWorldScansActive( true );
	end
--[[****************************************************************************
  * Function: _NPCScan:PLAYER_LEAVING_WORLD                                    *
  ****************************************************************************]]
	function me:PLAYER_LEAVING_WORLD ()
		SetWorldScansActive( false );
	end
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
				Arguments = Arguments:trim():lower();
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
			for ID, Name in pairs( me.OptionsCharacter.NPCs ) do
				me.NPCRemove( ID );
				me.NPCAdd( ID, Name );
			end
			for AchievementID in pairs( me.OptionsCharacter.Achievements ) do
				me.AchievementRemove( AchievementID );
				me.AchievementAdd( AchievementID );
			end
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




--------------------------------------------------------------------------------
-- Function Hooks / Execution
-----------------------------

do
	-- Create reverse lookup of continent names
	for Index, Name in ipairs( { GetMapContinents() } ) do
		me.ContinentIDs[ Name ] = Index;
	end
	-- Save achievement criteria data
	for AchievementID, Achievement in pairs( me.Achievements ) do
		Achievement.Criteria = {}; -- [ CriteriaID ] = NpcID;
		Achievement.Active = {}; -- [ NpcID ] = CriteriaID;
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
end

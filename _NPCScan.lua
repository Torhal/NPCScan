--[[****************************************************************************
  * _NPCScan by Saiket                                                         *
  * _NPCScan.lua - Scans NPCs near you for specific rare NPC IDs.              *
  ****************************************************************************]]


_NPCScanOptions = nil; -- Filled in on load
_NPCScanOptionsCharacter = nil;


local L = _NPCScanLocalization;
local me = CreateFrame( "Frame", "_NPCScan" );
me.Version = GetAddOnMetadata( "_NPCScan", "Version" ):match( "^([%d.]+)" );

me.OptionsDefault = {
	Version = me.Version;
};
me.OptionsCharacterDefault = {
	Version = me.Version;
	NPCs = { -- Keys must be lowercase and trimmed, but don't have to match the NPC name
		-- Note: Tameable NPCs will be "found" if you encounter them as pets, so don't search for them.
		[ L.NPCS[ "Time-Lost Proto Drake" ]:trim():lower() ] = 32491;
	};
	Achievements = {}; -- Filled with all entries in me.Achievements
	AchievementsAddFound = false;
};


me.TamableIDs = {
	-- Bloody Rare (Outlands)
	[ 17144 ] = true; -- Goretooth
	[ 20932 ] = true; -- Nuramoc
	-- Frostbitten (Northrend)
	[ 32485 ] = true; -- King Krush
	[ 32517 ] = true; -- Loque'nahak
};

me.ScanIDs = {}; -- [ NPC ID ] = Number of concurrent scans for this ID
me.ScanGroups = setmetatable( {}, { -- Subsets of scanned NPCs divided by group ("NPC" or AchievementID)
	__index = function ( self, Group ) local Table = {}; rawset( self, Group, Table ); return Table; end;
} );

me.Achievements = { -- Criteria data for each achievement
	[ 1312 ] = {}; -- Bloody Rare (Outlands)
	[ 2257 ] = {}; -- Frostbitten (Northrend)
};

me.IDMax = 0xFFFF; -- Largest ID that will fit in a GUID's 2-byte NPC ID field
me.UpdateRate = 0.1;

local Tooltip = CreateFrame( "GameTooltip", "_NPCScanTooltip", me );




--[[****************************************************************************
  * Function: _NPCScan.Message                                                 *
  * Description: Prints a message in the default chat window.                  *
  ****************************************************************************]]
function me.Message ( Message, Color )
	if ( not Color ) then
		Color = NORMAL_FONT_COLOR;
	end
	DEFAULT_CHAT_FRAME:AddMessage( L.MESSAGE_FORMAT:format( Message ), Color.r, Color.g, Color.b );
end
--[[****************************************************************************
  * Function: _NPCScan.Alert                                                   *
  * Description: Dramatically prints a message and play a sound.               *
  ****************************************************************************]]
function me.Alert ( Message, Color )
	me.Message( Message, Color );
	PlaySoundFile( "sound\\event sounds\\event_wardrum_ogre.wav" );
	PlaySoundFile( "sound\\events\\scourge_horn.wav" );
	UIFrameFlash( LowHealthFrame, 0.5, 0.5, 6, false, 0.5 );
end


--[[****************************************************************************
  * Function: _NPCScan.TestID                                                  *
  * Description: Checks for a given NPC ID.                                    *
  ****************************************************************************]]
do
	local GUID;
	function me.TestID ( ID )
		GUID = ( "unit:0xF53000%04X000000" ):format( ID );
		Tooltip:SetOwner( WorldFrame, "ANCHOR_NONE" );
		Tooltip:SetHyperlink( GUID );
		if ( Tooltip:IsShown() ) then
			return Tooltip.Text:GetText();
		end
	end
end


--[[****************************************************************************
  * Function: _NPCScan.ScanAdd                                                 *
  * Description: Begins searching for an NPC ID.                               *
  ****************************************************************************]]
function me.ScanAdd ( Group, ID )
	Group = me.ScanGroups[ Group ];

	-- Increment both group and total
	Group[ ID ] = ( Group[ ID ] or 0 ) + 1;
	me.ScanIDs[ ID ] = ( me.ScanIDs[ ID ] or 0 ) + 1;
end
--[[****************************************************************************
  * Function: _NPCScan.ScanRemove                                              *
  * Description: Stops searching for an NPC ID.                                *
  ****************************************************************************]]
function me.ScanRemove ( Group, ID )
	local Removed = false;
	Group = me.ScanGroups[ Group ];

	-- Remove from group
	local Count = Group[ ID ];
	if ( Count ) then -- Reduce counter, and clear if zero
		Group[ ID ] = Count > 1 and Count - 1 or nil;
		Removed = true;
	end

	if ( Removed ) then -- Was present in group; Decrement total
		me.ScanIDs[ ID ] = me.ScanIDs[ ID ] > 1 and me.ScanIDs[ ID ] - 1 or nil;
	end
end
--[[****************************************************************************
  * Function: _NPCScan.ScanRemoveAll                                           *
  * Description: Stops all concurrent scans for a common NPC ID.               *
  ****************************************************************************]]
function me.ScanRemoveAll ( ID )
	for _, Group in pairs( me.ScanGroups ) do
		Group[ ID ] = nil;
	end
	me.ScanIDs[ ID ] = nil;
end
--[[****************************************************************************
  * Function: _NPCScan.ScanSynchronize                                         *
  * Description: Resets the scanning list and reloads it from saved settings.  *
  ****************************************************************************]]
do
	local CachedNames = {};
	function me.ScanSynchronize ()
		-- Clear all scans
		for ID in pairs( me.ScanIDs ) do
			me.ScanRemoveAll( ID );
		end

		-- Add all NPCs from options
		for Name, ID in pairs( _NPCScanOptionsCharacter.NPCs ) do
			_NPCScanOptionsCharacter.NPCs[ Name ] = nil;
			local Success, FoundName = me.NPCAdd( Name, ID );
			if ( Success and FoundName ) then -- Was already cached
				CachedNames[ #CachedNames + 1 ] = L.NAME_FORMAT:format( FoundName );
			end
		end
		-- Print all cached NPC names
		if ( next( CachedNames ) ) then
			table.sort( CachedNames );
			me.Message( L.ALREADY_CACHED_FORMAT:format( table.concat( CachedNames, L.NAME_SEPARATOR ) ) );
			wipe( CachedNames );
		end

		for AchievementID in pairs( me.Achievements ) do
			if ( _NPCScanOptionsCharacter.Achievements[ AchievementID ] ) then
				_NPCScanOptionsCharacter.Achievements[ AchievementID ] = nil;
				local Success, FoundList = me.AchievementAdd( AchievementID );
				if ( Success and FoundList ) then -- Some NPCs were already cached
					me.Message( L.ALREADY_CACHED_FORMAT:format( FoundList ) );
				end
			end
		end
	end
end


--[[****************************************************************************
  * Function: _NPCScan.AchievementAdd                                          *
  * Description: Adds a kill-related achievement to track.                     *
  ****************************************************************************]]
do
	local CachedNames = {};
	function me.AchievementAdd ( AchievementID )
		if ( not _NPCScanOptionsCharacter.Achievements[ AchievementID ] ) then
			_NPCScanOptionsCharacter.Achievements[ AchievementID ] = true;

			for ID, CriteriaID in pairs( me.Achievements[ AchievementID ].NPCs ) do
				local _, CriteriaType, Completed = GetAchievementCriteriaInfo( CriteriaID );
				if ( not Completed or _NPCScanOptionsCharacter.AchievementsAddFound ) then
					local FoundName = me.TestID( ID );
					if ( FoundName ) then -- Already seen
						CachedNames[ #CachedNames + 1 ] = L.NAME_FORMAT:format( FoundName );
					else
						me.ScanAdd( AchievementID, ID );
					end
				end
			end

			local CachedList;
			if ( next( CachedNames ) ) then -- Return all cached names
				table.sort( CachedNames );
				CachedList = table.concat( CachedNames, L.NAME_SEPARATOR );
				wipe( CachedNames );
			end
			return true, CachedList;
		end
	end
end
--[[****************************************************************************
  * Function: _NPCScan.AchievementRemove                                       *
  * Description: Removes an achievement from settings and stops tracking it.   *
  ****************************************************************************]]
function me.AchievementRemove ( AchievementID )
	if ( _NPCScanOptionsCharacter.Achievements[ AchievementID ] ) then
		_NPCScanOptionsCharacter.Achievements[ AchievementID ] = nil;

		for ID in pairs( me.Achievements[ AchievementID ].NPCs ) do
			me.ScanRemove( AchievementID, ID );
		end
		return true;
	end
end


--[[****************************************************************************
  * Function: _NPCScan.NPCAdd                                                  *
  * Description: Adds an NPC name and ID to settings and begins searching.     *
  ****************************************************************************]]
function me.NPCAdd ( Name, ID )
	Name = Name:trim():lower();
	ID = tonumber( ID );

	if ( not _NPCScanOptionsCharacter.NPCs[ Name ] ) then
		_NPCScanOptionsCharacter.NPCs[ Name ] = ID;

		local FoundName = me.TestID( ID );
		if ( FoundName ) then -- Already seen
			return true, FoundName;
		else
			me.ScanAdd( "NPC", ID );
			return true;
		end
	end
end
--[[****************************************************************************
  * Function: _NPCScan.NPCRemove                                               *
  * Description: Removes an NPC from settings by name and stops searching.     *
  ****************************************************************************]]
function me.NPCRemove ( Name )
	Name = Name:trim():lower();
	local ID = _NPCScanOptionsCharacter.NPCs[ Name ];

	if ( ID ) then
		_NPCScanOptionsCharacter.NPCs[ Name ] = nil;
		me.ScanRemove( "NPC", ID );

		return true;
	end
end


--[[****************************************************************************
  * Function: _NPCScan:OnUpdate                                                *
  * Description: Scans all NPCs and alerts if any are found.                   *
  ****************************************************************************]]
do
	local pairs = pairs;
	local Name;
	local LastUpdate = 0;
	function me:OnUpdate ( Elapsed )
		LastUpdate = LastUpdate + Elapsed;
		if ( LastUpdate >= me.UpdateRate ) then
			LastUpdate = 0;

			for ID in pairs( me.ScanIDs ) do
				Name = me.TestID( ID );
				if ( Name ) then
					me.Alert( L.FOUND_FORMAT:format( Name ), GREEN_FONT_COLOR );
					me.Button.SetNPC( Name, ID );
					me.ScanRemoveAll( ID );
				end
			end
		end
	end
end
--[[****************************************************************************
  * Function: _NPCScan.OnLoad                                                  *
  * Description: Loads defaults, validates settings, and starts scan.          *
  ****************************************************************************]]
function me.OnLoad ()
	me.OnLoad = nil;

	-- Apply default settings
	if ( not _NPCScanOptions ) then
		_NPCScanOptions = CopyTable( me.OptionsDefault );
	end
	if ( not _NPCScanOptionsCharacter ) then
		_NPCScanOptionsCharacter = CopyTable( me.OptionsCharacterDefault );
	end

	-- Validate settings
	if ( _NPCScanOptionsCharacter.Version ~= me.Version ) then
		if ( _NPCScanOptions.Version ~= me.Version ) then
			_NPCScanOptions = CopyTable( me.OptionsDefault );
		end
		_NPCScanOptionsCharacter = CopyTable( me.OptionsCharacterDefault );
	end

	me.ScanSynchronize();
end
--[[****************************************************************************
  * Function: _NPCScan:PLAYER_ENTERING_WORLD                                   *
  ****************************************************************************]]
function me:PLAYER_ENTERING_WORLD ()
	if ( me.OnLoad ) then -- Only run once
		me.OnLoad();
	end

	-- Do not scan while in instances
	if ( IsInInstance() ) then
		self:Hide();
	else
		self:Show();
	end
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




--------------------------------------------------------------------------------
-- Function Hooks / Execution
-----------------------------

do
	me:SetScript( "OnUpdate", me.OnUpdate );
	me:SetScript( "OnEvent", me.OnEvent );
	me:RegisterEvent( "PLAYER_ENTERING_WORLD" );

	-- Add template text lines
	Tooltip.Text = Tooltip:CreateFontString( "$parentTextLeft1", nil, "GameTooltipText" );
	Tooltip:AddFontStrings(
		Tooltip.Text,
		Tooltip:CreateFontString( "$parentTextRight1", nil, "GameTooltipText" ) );


	-- Save achievement criteria data
	for AchievementID, Table in pairs( me.Achievements ) do
		me.OptionsCharacterDefault.Achievements[ AchievementID ] = true;
		Table.Name = select( 2, GetAchievementInfo( AchievementID ) );

		Table.NPCs = {};
		for Criteria = 1, GetAchievementNumCriteria( AchievementID ) do
			local _, CriteriaType, _, _, _, _, _, AssetID, _, CriteriaID = GetAchievementCriteriaInfo( AchievementID, Criteria );
			if ( CriteriaType == 0 and not me.TamableIDs[ AssetID ] ) then -- Mob kill type
				Table.NPCs[ AssetID ] = CriteriaID;
			end
		end
	end
end

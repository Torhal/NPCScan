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

me.Achievements = { -- Criteria data for each achievement
	[ 1312 ] = {}; -- Bloody Rare (Outlands)
	[ 2257 ] = {}; -- Frostbitten (Northrend)
};

me.IDMax = 0xFFFF; -- Largest ID that will fit in a GUID's 2-byte NPC ID field
me.UpdateRate = 0.1;

local Tooltip = CreateFrame( "GameTooltip", "_NPCScanTooltip", me );

local List = setmetatable( {}, { __index = { -- List string builder
	Add = function ( self, Element )
		self[ #self + 1 ] = Element;
	end;
	Clear = function ( self ) -- Assemble string and clear
		if ( next( self ) ) then
			sort( self );
			local String = table.concat( self, L.LIST_SEPARATOR );
			wipe( self );
			return String;
		end
	end;
} } );




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
function me.ScanAdd ( ID )
	me.ScanIDs[ ID ] = ( me.ScanIDs[ ID ] or 0 ) + 1; -- Increment
end
--[[****************************************************************************
  * Function: _NPCScan.ScanRemove                                              *
  * Description: Stops searching for an NPC ID.                                *
  ****************************************************************************]]
function me.ScanRemove ( ID )
	local Count = me.ScanIDs[ ID ];
	if ( Count ) then -- Decrement
		me.ScanIDs[ ID ] = Count > 1 and Count - 1 or nil;
	end
end
--[[****************************************************************************
  * Function: _NPCScan.ScanRemoveAll                                           *
  * Description: Stops all concurrent scans for a common NPC ID.               *
  ****************************************************************************]]
function me.ScanRemoveAll ( ID )
	me.ScanIDs[ ID ] = nil;
end
--[[****************************************************************************
  * Function: _NPCScan.ScanSynchronize                                         *
  * Description: Resets the scanning list and reloads it from saved settings.  *
  ****************************************************************************]]
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
			List:Add( L.NAME_FORMAT:format( FoundName ) );
		end
	end
	-- Print all cached NPC names
	local CachedNames = List:Clear();
	if ( CachedNames ) then
		me.Message( L.ALREADY_CACHED_FORMAT:format( CachedNames ) );
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


--[[****************************************************************************
  * Function: _NPCScan.AchievementAdd                                          *
  * Description: Adds a kill-related achievement to track.                     *
  ****************************************************************************]]
function me.AchievementAdd ( AchievementID )
	if ( not _NPCScanOptionsCharacter.Achievements[ AchievementID ] ) then
		_NPCScanOptionsCharacter.Achievements[ AchievementID ] = true;

		for ID, CriteriaID in pairs( me.Achievements[ AchievementID ].Criteria ) do
			local _, CriteriaType, Completed = GetAchievementCriteriaInfo( CriteriaID );
			if ( not Completed or _NPCScanOptionsCharacter.AchievementsAddFound ) then
				local FoundName = me.TestID( ID );
				if ( FoundName ) then -- Already seen
					List:Add( L.NAME_FORMAT:format( FoundName ) );
				else
					me.Achievements[ AchievementID ].Active[ ID ] = true;
					me.ScanAdd( ID );
				end
			end
		end

		return true, List:Clear();
	end
end
--[[****************************************************************************
  * Function: _NPCScan.AchievementRemove                                       *
  * Description: Removes an achievement from settings and stops tracking it.   *
  ****************************************************************************]]
function me.AchievementRemove ( AchievementID )
	if ( _NPCScanOptionsCharacter.Achievements[ AchievementID ] ) then
		_NPCScanOptionsCharacter.Achievements[ AchievementID ] = nil;

		for ID in pairs( me.Achievements[ AchievementID ].Active ) do
			me.ScanRemove( ID );
		end
		wipe( me.Achievements[ AchievementID ].Active );
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
			me.ScanAdd( ID );
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
		me.ScanRemove( ID );

		return true;
	end
end


--[[****************************************************************************
  * Function: _NPCScan.LoadDefaults                                            *
  * Description: Loads defaults per character and optionally globally.         *
  ****************************************************************************]]
function me.LoadDefaults ( Global )
	if ( Global ) then
		_NPCScanOptions = CopyTable( me.OptionsDefault );
	end
	_NPCScanOptionsCharacter = CopyTable( me.OptionsCharacterDefault );

	-- Add all uncompleted achievements
	for AchievementID in pairs( me.Achievements ) do
		if ( _NPCScanOptionsCharacter.AchievementsAddFound or not select( 4, GetAchievementInfo( AchievementID ) ) ) then -- Not completed
			_NPCScanOptionsCharacter.Achievements[ AchievementID ] = true;
		end
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
	if ( not _NPCScanOptionsCharacter ) then
		me.LoadDefaults( not _NPCScanOptions );
	end

	-- Validate settings
	if ( _NPCScanOptionsCharacter.Version ~= me.Version ) then
		me.LoadDefaults( _NPCScanOptions.Version ~= me.Version );
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
	for AchievementID, Achievement in pairs( me.Achievements ) do
		Achievement.Criteria = {};
		Achievement.Active = {};
		for Criteria = 1, GetAchievementNumCriteria( AchievementID ) do
			local _, CriteriaType, _, _, _, _, _, AssetID, _, CriteriaID = GetAchievementCriteriaInfo( AchievementID, Criteria );
			if ( CriteriaType == 0 and not me.TamableIDs[ AssetID ] ) then -- Mob kill type
				Achievement.Criteria[ AssetID ] = CriteriaID;
			end
		end
	end
end

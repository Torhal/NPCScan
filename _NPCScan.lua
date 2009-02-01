--[[****************************************************************************
  * _NPCScan by Saiket                                                         *
  * _NPCScan.lua - Scans NPCs near you for specific rare NPC IDs.              *
  ****************************************************************************]]


local L = _NPCScanLocalization;
_NPCScanOptions = {
	IDs = { -- Keys (names) in this table don't matter; they aren't used in searching.
		-- Note: Tameable NPCs will be "found" if you encounter them as pets, so don't search for them.

		[ L[ "Time-Lost Proto-Drake" ] ] = 32491;

		-- Northern Exposure (Northrend)
		[ L[ "Aotona" ] ] = 32481;
		[ L[ "Dirkee" ] ] = 32500;
		[ L[ "Griegen" ] ] = 32471;
		[ L[ "High Thane Jorfus" ] ] = 32501;
		[ L[ "Icehorn" ] ] = 32361;
		[ L[ "King Ping" ] ] = 32398;
		[ L[ "Old Crystalbark" ] ] = 32357;
		[ L[ "Putridus the Ancient" ] ] = 32487;
		[ L[ "Seething Hate" ] ] = 32429;
		[ L[ "Terror Spinner" ] ] = 32475;
		[ L[ "Vigdis the War Maiden" ] ] = 32386;
		[ L[ "Zul'drak Sentinel" ] ] = 32447;
		[ L[ "Crazed Indu'le Survivor" ] ] = 32409;
		[ L[ "Fumblub Gearwind" ] ] = 32358;
		[ L[ "Grocklar" ] ] = 32422;
		[ L[ "Hildana Deathstealer" ] ] = 32495;
		--[ L[ "King Krush" ] ] = 32485;
		--[ L[ "Loque'nahak" ] ] = 32517;
		[ L[ "Perobas the Bloodthirster" ] ] = 32377;
		[ L[ "Scarlet Highlord Daion" ] ] = 32417;
		[ L[ "Syreian the Bonecarver" ] ] = 32438;
		[ L[ "Tukemuth" ] ] = 32400;
		[ L[ "Vyragosa" ] ] = 32630;

		-- Bloody Rare (Outlands)
		[ L[ "Ambassador Jerrikar" ] ] = 18695;
		[ L[ "Chief Engineer Lorthander" ] ] = 18697;
		[ L[ "Collidus the Warp-Watcher" ] ] = 18694;
		[ L[ "Doomsayer Jurim" ] ] = 18686;
		[ L[ "Fulgorge" ] ] = 18678;
		[ L[ "Hemathion" ] ] = 18692;
		[ L[ "Marticar" ] ] = 18680;
		[ L[ "Morcrush" ] ] = 18690;
		[ L[ "Okrek" ] ] = 18685;
		[ L[ "Voidhunter Yar" ] ] = 18683;
		[ L[ "Bog Lurker" ] ] = 18682;
		[ L[ "Coilfang Emissary" ] ] = 18681;
		[ L[ "Crippler" ] ] = 18689;
		[ L[ "Ever-Core the Punisher" ] ] = 18698;
		--[ L[ "Goretooth" ] ] = 17144;
		[ L[ "Kraator" ] ] = 18696;
		[ L[ "Mekthorg the Wild" ] ] = 18677;
		--[ L[ "Nuramoc" ] ] = 20932;
		[ L[ "Speaker Mar'grom" ] ] = 18693;
		[ L[ "Vorakem Doomspeaker" ] ] = 18679;
	};
};


local me = CreateFrame( "Frame", "_NPCScan" );

local Tooltip = CreateFrame( "GameTooltip", "_NPCScanTooltip", me );
me.Tooltip = Tooltip

local IDs = {};
me.IDs = IDs;




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
  * Description: Show a message in the middle of the screen and play a sound.  *
  ****************************************************************************]]
function me.Alert ( Message, Color )
	me.Message( Message, Color );
	if ( not Color ) then
		Color = NORMAL_FONT_COLOR;
	end
	RaidNotice_AddMessage( RaidWarningFrame, L.ALERT_FORMAT:format( Message ), Color );
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
  * Function: _NPCScan.AddNPC                                                  *
  * Description: Adds an NPC ID to scan for.                                   *
  ****************************************************************************]]
function me.AddNPC ( Name, ID )
	assert( type( Name ) == "string", "Invalid argument #1 \"Name\" to _NPCScan.AddNPC - string expected." );
	assert( tonumber( ID ), "Invalid argument #2 \"ID\" to _NPCScan.AddNPC - number expected." );

	if ( not _NPCScanOptions.IDs[ Name ] ) then
		IDs[ ID ] = true;
		_NPCScanOptions.IDs[ Name ] = ID;
		me.Message( L.NPC_ADD_FORMAT:format( Name, ID ), GREEN_FONT_COLOR );
		return true;
	end
end
--[[****************************************************************************
  * Function: _NPCScan.RemoveNPC                                               *
  * Description: Removes an NPC from the scanning list.                        *
  ****************************************************************************]]
function me.RemoveNPC ( Name )
	assert( type( Name ) == "string", "Invalid argument #1 \"Name\" to _NPCScan.RemoveNPC - string expected." );

	local ID = _NPCScanOptions.IDs[ Name ];
	if ( ID ) then
		IDs[ ID ] = nil;
		_NPCScanOptions.IDs[ Name ] = nil;
		me.Message( L.NPC_REMOVE_FORMAT:format( Name, ID ), RED_FONT_COLOR );
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
	function me:OnUpdate ( Elapsed )
		for ID in pairs( IDs ) do
			Name = me.TestID( ID );
			if ( Name ) then
				me.Alert( L.FOUND_FORMAT:format( Name ) );
				me.Button.SetNPC( Name, ID );
				IDs[ ID ] = nil; -- Stop searching for this NPC
			end
		end
	end
end
--[[****************************************************************************
  * Function: _NPCScan:ADDON_LOADED                                            *
  ****************************************************************************]]
function me:ADDON_LOADED ( _, AddOn )
	if ( AddOn:upper() == "_NPCSCAN" ) then
		me:UnregisterEvent( "ADDON_LOADED" );
		me.ADDON_LOADED = nil;

		-- Add all NPCs from options
		local CachedNames = {};
		for Name, ID in pairs( _NPCScanOptions.IDs ) do
			-- Don't add NPCs already in the cache
			if ( me.TestID( ID ) ) then
				CachedNames[ #CachedNames + 1 ] = L.NAME_FORMAT:format( Name );
			else -- Add
				IDs[ ID ] = true;
			end
		end
		-- Print all cached names
		if ( next( CachedNames ) ) then
			table.sort( CachedNames );
			me.Message( L.ALREADY_CACHED_FORMAT:format( table.concat( CachedNames, L.NAME_SEPARATOR ) ) );
		end
	end
end
--[[****************************************************************************
  * Function: _NPCScan:PLAYER_ENTERING_WORLD                                   *
  ****************************************************************************]]
function me:PLAYER_ENTERING_WORLD ()
	-- Do not scan while in instances
	if ( IsInInstance() ) then
		self:Hide();
	else
		self:Show();
	end
end
--[[****************************************************************************
  * Function: _NPCScan:OnEvent                                                 *
  * Description: Global event handler.                                         *
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
  * Description: Slash command to add and remove NPCs.                         *
  ****************************************************************************]]
function me.SlashCommand ( Input )
	local Command, Arguments = Input:match( "^(%S+)%s+(.+)%s*$" );
	if ( Command ) then
		Command = Command:upper();
		if ( Command == L.CMD_ADD ) then
			local ID, Name = Arguments:match( "^(%d+)%s+(.+)$" );
			if ( ID ) then
				if ( not me.AddNPC( Name, tonumber( ID ) ) ) then
					me.Message( L.CMD_ADDDUPLICATE_FORMAT:format( Name, ID ), RED_FONT_COLOR );
				end
				return;
			end
		elseif ( Command == L.CMD_REMOVE ) then
			if ( not me.RemoveNPC( Arguments ) ) then
				me.Message( L.CMD_REMOVENOTFOUND_FORMAT:format( Arguments ), RED_FONT_COLOR );
			end
			return;
		end
	end

	-- No such command
	me.Message( L.CMD_HELP );
end




--------------------------------------------------------------------------------
-- Function Hooks / Execution
-----------------------------

do
	me:SetScript( "OnUpdate", me.OnUpdate );
	me:SetScript( "OnEvent", me.OnEvent );
	me:RegisterEvent( "ADDON_LOADED" );
	me:RegisterEvent( "PLAYER_ENTERING_WORLD" );

	-- Add template text lines
	Tooltip.Text = Tooltip:CreateFontString( "$parentTextLeft1", nil, "GameTooltipText" );
	Tooltip:AddFontStrings(
		Tooltip.Text,
		Tooltip:CreateFontString( "$parentTextRight1", nil, "GameTooltipText" ) );

	SlashCmdList[ "_NPCSCAN" ] = me.SlashCommand;
end

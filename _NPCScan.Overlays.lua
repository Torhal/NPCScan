--[[****************************************************************************
  * _NPCScan by Saiket                                                         *
  * _NPCScan.Overlays.lua - Integration with NPC map overlay mods.             *
  ****************************************************************************]]


local AddOnName = ...;
local L = _NPCScanLocalization;
local _NPCScan = _NPCScan;
local me = {};
_NPCScan.Overlays = me;

me.Debug = false; -- Set to true so incompatible hooks will throw real errors

local MESSAGE_REGISTER = "NpcOverlay_RegisterScanner";
local MESSAGE_ADD = "NpcOverlay_Add";
local MESSAGE_REMOVE = "NpcOverlay_Remove";
local MESSAGE_FOUND = "NpcOverlay_Found";




--[[****************************************************************************
  * Function: _NPCScan.Overlays.Register                                       *
  * Description: Announces to overlay mods that _NPCScan will take over        *
  *   control of shown paths.                                                  *
  ****************************************************************************]]
function me.Register ()
	me:SendMessage( MESSAGE_REGISTER, AddOnName );
end


--[[****************************************************************************
  * Function: _NPCScan.Overlays.Add                                            *
  * Description: Enables overlay maps for a given NPC ID.                      *
  ****************************************************************************]]
function me.Add ( ID )
	me:SendMessage( MESSAGE_ADD, ID, AddOnName );
end
--[[****************************************************************************
  * Function: _NPCScan.Overlays.Remove                                         *
  * Description: Disables overlay maps for a given NPC ID.                     *
  ****************************************************************************]]
function me.Remove ( ID )
	me:SendMessage( MESSAGE_REMOVE, ID, AddOnName );
end
--[[****************************************************************************
  * Function: _NPCScan.Overlays.Found                                          *
  * Description: Lets overlay mods know the NPC ID was found.                  *
  ****************************************************************************]]
function me.Found ( ID )
	me:SendMessage( MESSAGE_FOUND, ID, AddOnName );
end




--------------------------------------------------------------------------------
-- Function Hooks / Execution
-----------------------------

do
	LibStub( "AceEvent-3.0" ):Embed( me );

	-- Add message support for RareSpawnOverlay
	if ( select( 4, GetAddOnInfo( "RareSpawnOverlay" ) ) ) then -- Enabled
		local function SafeCall ( Func, ... )
			if ( me.Debug ) then
				Func( ... );
			elseif ( not pcall( Func, ... ) ) then -- Error
				me:UnregisterAllMessages();
				_NPCScan.Print( L.OVERLAY_INCOMPATIBLE:format( "RareSpawnOverlay",
					tostring( GetAddOnMetadata( "RareSpawnOverlay", "Version" ) ),
					_NPCScan.Version ), RED_FONT_COLOR );
			end
		end

		me:RegisterMessage( MESSAGE_REGISTER, function ( Event, AddOn )
			if ( AddOn == AddOnName ) then -- _NPCScan registered
				me:UnregisterMessage( Event );

				local RSO, Show, Hide;
				me:RegisterMessage( MESSAGE_ADD, function ( _, ID )
					SafeCall( Show, RSO, ID );
				end );
				me:RegisterMessage( MESSAGE_REMOVE, function ( _, ID )
					SafeCall( Hide, RSO, ID );
				end );

				SafeCall( function () -- Save function refs and hide all shown overlays
					RSO = RareSpawnOverlay.API;
					Show, Hide = assert( RSO.ShowNPC ), assert( RSO.HideNPC );

					-- Remove all achievement overlays
					for _, Achievement in pairs( _NPCScan.Achievements ) do
						for _, NpcID in pairs( Achievement.Criteria ) do
							Hide( RSO, NpcID );
						end
					end
				end );
			end
		end );
	end
end

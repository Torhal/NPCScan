--[[****************************************************************************
  * _NPCScan by Saiket                                                         *
  * _NPCScan.Overlays.lua - Integration with NPC map overlay mods.             *
  ****************************************************************************]]


local AddOnName = ...;
local me = {};
_NPCScan.Overlays = me;

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
end

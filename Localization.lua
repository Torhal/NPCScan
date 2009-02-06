--[[****************************************************************************
  * _NPCScan by Saiket                                                         *
  * Localization.lua - Localized string constants (en-US).                     *
  ****************************************************************************]]


do
	local Title = "_|cffCCCC88NPCScan|r";
	local LDQuo, RDQuo = GRAY_FONT_COLOR_CODE.."\226\128\156", "\226\128\157"..FONT_COLOR_CODE_CLOSE;
	local Bullet = "\226\151\143";
	_NPCScanLocalization = setmetatable(
		{
			MESSAGE_FORMAT = Title..": %s";

			FOUND_FORMAT = "Found "..LDQuo.."%s"..RDQuo.."!";
			BUTTON_FOUND = "NPC found!";

			NPC_ADD_FORMAT = "Added NPC "..LDQuo.."%s"..RDQuo.." (ID %d).";
			NPC_REMOVE_FORMAT = "Removed NPC "..LDQuo.."%s"..RDQuo.." (ID %d).";

			ALREADY_CACHED_FORMAT = "Consider clearing your cache to reset the following units: %s.";
			NAME_FORMAT = LDQuo.."%s"..RDQuo;
			NAME_SEPARATOR = ", ";

			CMD_LIST = "LIST";
			CMD_LIST_FORMAT = "Listing %d |4unit:units;:";
			CMD_LISTENTRY_FORMAT = "    "..Bullet.." "..LDQuo.."%s"..RDQuo.." (ID %d)";
			CMD_ADD = "ADD";
			CMD_ADDDUPLICATE_FORMAT = "NPC "..LDQuo.."%s"..RDQuo.." (ID %d) already being searched for.";
			CMD_REMOVE = "REMOVE";
			CMD_REMOVENOTFOUND_FORMAT = "NPC "..LDQuo.."%s"..RDQuo.." not found.";
			CMD_HELP = "Commands are "..LDQuo.."/npcscan list"..RDQuo..", "..LDQuo.."/npcscan add <NpcID> <Name>"..RDQuo..", and "..LDQuo.."/npcscan remove <Name>"..RDQuo..".";
		}, {
			__index = function ( self, Key )
				rawset( self, Key, Key );
				return Key;
			end;
		} );




--------------------------------------------------------------------------------
-- Globals
----------

	SLASH__NPCSCAN1 = "/npcscan";
	SLASH__NPCSCAN2 = "/scan";

	BINDING_HEADER__NPCSCAN = Title;
	_G[ "BINDING_NAME_CLICK _NPCScanButton:LeftButton" ] = "Target found unit";
end

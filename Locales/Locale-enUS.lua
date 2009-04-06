--[[****************************************************************************
  * _NPCScan by Saiket                                                         *
  * Locales/Locale-enUS.lua - Localized string constants (en-US).              *
  ****************************************************************************]]


do
	local Title = "_|cffCCCC88NPCScan|r";
	local LDQuo, RDQuo = GRAY_FONT_COLOR_CODE.."\226\128\156", "\226\128\157|r";


	_NPCScanLocalization = setmetatable( {
		MESSAGE_FORMAT = Title..": %s";

		FOUND_FORMAT = "Found "..LDQuo.."%s"..RDQuo.."!";
		BUTTON_FOUND = "NPC found!";

		ALREADY_CACHED_FORMAT = "The following unit(s) are already cached.  Consider removing them using "..LDQuo.."/npcscan"..RDQuo.."'s menu or resetting them by clearing your cache: %s.";
		NAME_FORMAT = LDQuo.."%s"..RDQuo;
		NAME_SEPARATOR = ", ";


		OPTIONS_TITLE = Title;
		OPTIONS_DESC = "This table allows you to add or remove NPCs to scan for.  Note that tameable mobs cannot be searched for since they get found even as hunter pets.";

		OPTIONS_TEST = "Test Found Alert";
		OPTIONS_TEST_DESC = "Simulates an "..LDQuo.."NPC found"..RDQuo.." alert to let you know what to look out for.";
		OPTIONS_TEST_NAME = "You! (Test)";
		OPTIONS_TEST_HELP_FORMAT = "Click the target button or use the provided keybinding to target the found mob.  Hold "..HIGHLIGHT_FONT_COLOR_CODE.."<%s>|r and drag to move the target button.  Note that if an NPC is found while you're in combat, the button will only appear after you exit combat.";

		OPTIONS_CACHED = "Found";
		OPTIONS_NAME = "Name:";
		OPTIONS_NAME_DESC = "A label for the NPC.  It is case insensitive and doesn't have to match the NPC's actual name.";
		OPTIONS_ID = "NPC ID:";
		OPTIONS_ID_DESC = "The ID of the NPC to search for.  This value can be found on sites like WowHead.com.";

		OPTIONS_CACHED_YES = "|T"..READY_CHECK_NOT_READY_TEXTURE..":0|t";
		OPTIONS_CACHED_NO = "";

		OPTIONS_ADD = "+";
		OPTIONS_REMOVE = "-";
	}, {
		__index = function ( self, Key )
			if ( Key ~= nil ) then
				rawset( self, Key, Key );
				return Key;
			end
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

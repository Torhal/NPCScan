--[[****************************************************************************
  * _NPCScan by Saiket                                                         *
  * Locales/Locale-enUS.lua - Localized string constants (en-US).              *
  ****************************************************************************]]


do
	local Title = "_|cffCCCC88NPCScan|r";
	local LDQuo, RDQuo = GRAY_FONT_COLOR_CODE.."\226\128\156", "\226\128\157|r";


	local Metatable = {
		__index = function ( self, Key )
			if ( Key ~= nil ) then
				rawset( self, Key, Key );
				return Key;
			end
		end;
	};
	_NPCScanLocalization = setmetatable( {
		NPCS = setmetatable( {}, Metatable );

		MESSAGE_FORMAT = Title..": %s";

		FOUND_FORMAT = "Found "..LDQuo.."%s"..RDQuo.."!";
		FOUND_TAMABLE_FORMAT = "Found "..LDQuo.."%s"..RDQuo.."!  "..RED_FONT_COLOR_CODE.."(Note: Tamable mob, may only be a pet.)|r";
		BUTTON_FOUND = "NPC found!";

		CACHED_LONG_FORMAT = "The following unit(s) are already cached.  Consider removing them using "..LDQuo.."/npcscan"..RDQuo.."'s menu or resetting them by clearing your cache: %s.";
		CACHED_FORMAT = "The following unit(s) are already cached: %s.";
		CACHED_NAME_FORMAT = LDQuo.."%s"..RDQuo;
		CACHED_SEPARATOR = ", ";


		OPTIONS_TITLE = Title;
		OPTIONS_DESC = "These options let you configure the way _NPCScan alerts you when it finds rare NPCs.";

		OPTIONS_TEST = "Test Found Alert";
		OPTIONS_TEST_DESC = "Simulates an "..LDQuo.."NPC found"..RDQuo.." alert to let you know what to look out for.";
		OPTIONS_TEST_NAME = "You! (Test)";
		OPTIONS_TEST_HELP_FORMAT = "Click the target button or use the provided keybinding to target the found mob.  Hold "..HIGHLIGHT_FONT_COLOR_CODE.."<%s>|r and drag to move the target button.  Note that if an NPC is found while you're in combat, the button will only appear after you exit combat.";


		SEARCH_TITLE = "Search";
		SEARCH_DESC = "This table allows you to add or remove NPCs and achievements to scan for.  Note that tameable mobs cannot be searched for since they get found even as hunter pets.";

		SEARCH_NPCS = "Custom NPCs";
		SEARCH_NPCS_DESC = "Add any NPC to track, even if it has no achievement.";

		SEARCH_CACHED = "Cached";
		SEARCH_NAME = "Name:";
		SEARCH_NAME_DESC = "A label for the NPC.  It is case insensitive and doesn't have to match the NPC's actual name.";
		SEARCH_ID = "NPC ID:";
		SEARCH_ID_DESC = "The ID of the NPC to search for.  This value can be found on sites like WowHead.com.";
		SEARCH_COMPLETED = "Done";

		SEARCH_CACHED_YES = "|T"..READY_CHECK_NOT_READY_TEXTURE..":0|t";
		SEARCH_CACHED_NO = "";
		SEARCH_COMPLETED_YES = "|T"..READY_CHECK_READY_TEXTURE..":0|t";
		SEARCH_COMPLETED_NO = "";

		SEARCH_ADD = "+";
		SEARCH_REMOVE = "-";

		SEARCH_ACHIEVEMENTADDFOUND = "Search for completed achievement NPCs";
		SEARCH_ACHIEVEMENTADDFOUND_DESC = "Continues searching for all achievement NPCs, even if you no longer need them.";
		SEARCH_ACHIEVEMENTADDTAMABLE = "Search for tamable NPCs";
		SEARCH_ACHIEVEMENTADDTAMABLE_DESC = "Scans for NPCs tamable by hunters.";
		SEARCH_ACHIEVEMENTADDTAMABLE_WARNING = RED_FONT_COLOR_CODE.."Warning: Pets that originally were rare NPCs will trigger the found alert.|r";


		CMD_ADD = "ADD";
		CMD_REMOVE = "REMOVE";
		CMD_REMOVENOTFOUND_FORMAT = "NPC "..LDQuo.."%s"..RDQuo.." not found.";
		CMD_HELP = "Commands are "..LDQuo.."/npcscan add <NpcID> <Name>"..RDQuo..", "..LDQuo.."/npcscan remove <Name>"..RDQuo..", and simply "..LDQuo.."/npcscan"..RDQuo.." for the options menu.";
	}, Metatable );




--------------------------------------------------------------------------------
-- Globals
----------

	SLASH__NPCSCAN1 = "/npcscan";
	SLASH__NPCSCAN2 = "/scan";

	BINDING_HEADER__NPCSCAN = Title;
	_G[ "BINDING_NAME_CLICK _NPCScanButton:LeftButton" ] = "Target found unit";
end

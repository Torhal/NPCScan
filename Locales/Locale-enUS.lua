--[[****************************************************************************
  * _NPCScan by Saiket                                                         *
  * Locales/Locale-enUS.lua - Localized string constants (en-US).              *
  ****************************************************************************]]


do
	local Title = "_|cffCCCC88NPCScan|r";
	local LDQuo, RDQuo = GRAY_FONT_COLOR_CODE.."\226\128\156", "\226\128\157|r";


	_NPCScanLocalization = setmetatable( {
		NPCS = {
			[ 18684 ] = "Bro'Gaz the Clanless";
			[ 32491 ] = "Time-Lost Proto Drake";
			[ 33776 ] = "Gondria";
			[ 35189 ] = "Skoll";
			[ 38453 ] = "Arcturis";
		};

		PRINT_FORMAT = Title..": %s";

		FOUND_FORMAT = "Found "..LDQuo.."%s"..RDQuo.."!";
		FOUND_ZONE_UNKNOWN = UNKNOWN;
		FOUND_TAMABLE_FORMAT = "Found "..LDQuo.."%s"..RDQuo.."!  "..RED_FONT_COLOR_CODE.."(Note: Tamable mob, may only be a pet.)|r";
		FOUND_TAMABLE_WRONGZONE_FORMAT = RED_FONT_COLOR_CODE.."False alarm:|r Found tamable mob "..LDQuo.."%s"..RDQuo.." in %s instead of %s (ID %d); Definitely a pet."; -- Name, CurrentZone, ExpectedZone, ExpectedZoneID
		FOUND_TAMABLE_RESTING_FORMAT = RED_FONT_COLOR_CODE.."False alarm:|r Found tamable mob "..LDQuo.."%s"..RDQuo.." while resting; Probably a pet.";
		BUTTON_FOUND = "NPC found!";

		CACHED_LONG_FORMAT = "The following unit(s) are already cached.  Consider removing them using "..LDQuo.."/npcscan"..RDQuo.."'s menu or resetting them by clearing your cache: %s.";
		CACHED_FORMAT = "The following unit(s) are already cached: %s.";
		CACHED_WORLD_FORMAT = "The following %2$s unit(s) are already cached: %1$s."; -- CacheList, MapName
		CACHED_NAME_FORMAT = LDQuo.."%s"..RDQuo;
		CACHED_SEPARATOR = ", ";


		CONFIG_TITLE = Title;
		CONFIG_DESC = "These options let you configure the way _NPCScan alerts you when it finds rare NPCs.";

		CONFIG_CACHEWARNINGS = "Print cache reminders on login and world changes";
		CONFIG_CACHEWARNINGS_DESC = "If an NPC is already cached when you log in or change worlds, this option prints a reminder of which chached mobs can't be searched for.";


		CONFIG_ALERT = "Alert Options";

		CONFIG_TEST = "Test Found Alert";
		CONFIG_TEST_DESC = "Simulates an "..LDQuo.."NPC found"..RDQuo.." alert to let you know what to look out for.";
		CONFIG_TEST_NAME = "You! (Test)";
		CONFIG_TEST_HELP_FORMAT = "Click the target button or use the provided keybinding to target the found mob.  Hold "..HIGHLIGHT_FONT_COLOR_CODE.."<%s>|r and drag to move the target button.  Note that if an NPC is found while you're in combat, the button will only appear after you exit combat.";

		CONFIG_ALERT_UNMUTE = "Unmute for alert sound";
		CONFIG_ALERT_UNMUTE_DESC = "Briefly enables game sound when an NPC is found to play an alert tone if you have muted the game.";
		CONFIG_ALERT_SOUND = "Alert sound file";
		CONFIG_ALERT_SOUND_DESC = "Choose the alert sound to play when an NPC is found.  Additional sounds can be added through "..LDQuo.."SharedMedia"..RDQuo.." addons.";
		CONFIG_ALERT_SOUND_DEFAULT = NORMAL_FONT_COLOR_CODE..DEFAULT.."|r";


		SEARCH_TITLE = "Search";
		SEARCH_DESC = "This table allows you to add or remove NPCs and achievements to scan for.";

		SEARCH_ACHIEVEMENTADDFOUND = "Search for completed Achievement NPCs";
		SEARCH_ACHIEVEMENTADDFOUND_DESC = "Continues searching for all achievement NPCs, even if you no longer need them.";

		SEARCH_NPCS = "Custom NPCs";
		SEARCH_NPCS_DESC = "Add any NPC to track, even if it has no achievement.";
		SEARCH_WORLD_FORMAT = "(%s)";
		SEARCH_ACHIEVEMENT_DISABLED = "Disabled";

		SEARCH_CACHED = "Cached";
		SEARCH_NAME = "Name:";
		SEARCH_NAME_DESC = "A label for the NPC.  It doesn't have to match the NPC's actual name.";
		SEARCH_ID = "NPC ID:";
		SEARCH_ID_DESC = "The ID of the NPC to search for.  This value can be found on sites like Wowhead.com.";
		SEARCH_COMPLETED = "Done";
		SEARCH_WORLD = "World:";
		SEARCH_WORLD_DESC = "An optional world name to limit searching to.  Can be a continent name or "..ORANGE_FONT_COLOR_CODE.."instance name|r (case-sensitive).";

		SEARCH_CACHED_YES = "|T"..READY_CHECK_NOT_READY_TEXTURE..":0|t";
		SEARCH_CACHED_NO = "";
		SEARCH_COMPLETED_YES = "|T"..READY_CHECK_READY_TEXTURE..":0|t";
		SEARCH_COMPLETED_NO = "";

		SEARCH_ADD = "+";
		SEARCH_REMOVE = "-";
		SEARCH_ADD_TAMABLE_FORMAT = "Note: "..LDQuo.."%s"..RDQuo.." is tamable, so seeing it as a tamed hunter's pet will cause a false alarm.";

		SEARCH_IMAGE_FORMAT = "|T%s:%d:%d|t"; -- Path, Height, Width
		SEARCH_LEVEL_TYPE_FORMAT = UNIT_TYPE_LEVEL_TEMPLATE; -- Level, Type


		CMD_ADD = "ADD";
		CMD_REMOVE = "REMOVE";
		CMD_REMOVENOTFOUND_FORMAT = "NPC "..LDQuo.."%s"..RDQuo.." not found.";
		CMD_CACHE = "CACHE";
		CMD_CACHE_EMPTY = "None of the mobs being searched for are cached.";
		CMD_HELP = "Commands are "..LDQuo.."/npcscan add <NpcID> <Name>"..RDQuo..", "..LDQuo.."/npcscan remove <NpcID or Name>"..RDQuo..", "..LDQuo.."/npcscan cache"..RDQuo.." to list cached mobs, and simply "..LDQuo.."/npcscan"..RDQuo.." for the options menu.";
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
	_G[ "BINDING_NAME_CLICK _NPCScanButton:LeftButton" ] = "Target last found mob\n"..GRAY_FONT_COLOR_CODE.."(Use when _NPCScan alerts you)|r";
end

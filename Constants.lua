-------------------------------------------------------------------------------
-- Localized Lua globals.
-------------------------------------------------------------------------------
local _G = getfenv(0)

-- Functions
local pairs = _G.pairs

-------------------------------------------------------------------------------
-- AddOn namespace.
-------------------------------------------------------------------------------
local FOLDER_NAME, private = ...

-------------------------------------------------------------------------------
-- General constants.
-------------------------------------------------------------------------------
private.NPC_ID_MAX = 0xFFFFF -- Largest ID that will fit in a GUID's 20-bit NPC ID field.
private.NUM_RAID_ICONS = 8

-------------------------------------------------------------------------------
-- Zones.
-------------------------------------------------------------------------------
local CONTINENT_IDS = {
	KALIMDOR = 1,
	EASTERN_KINGDOMS = 2,
	OUTLAND = 3,
	NORTHREND = 4,
	THE_MAELSTROM = 5,
	PANDARIA = 6,
	DRAENOR = 7,
	BROKEN_ISLES = 8,
}

private.CONTINENT_IDS = CONTINENT_IDS

local continentNames = {}
do
	local continentData = { _G.GetMapContinents() }
	for continentDataIndex = 1, #continentData do
		-- Odd indices are IDs, even are names.
		if continentDataIndex % 2 == 0 then
			continentNames[#continentNames + 1] = continentData[continentDataIndex]
		end
	end
end -- do-block

private.LOCALIZED_CONTINENT_NAMES = continentNames

local ZONE_IDS = {
	DUROTAR = 4,
	MULGORE = 9,
	NORTHERN_BARRENS = 11,
	ARATHI_HIGHLANDS = 16,
	BADLANDS = 17,
	BLASTED_LANDS = 19,
	TIRISFAL_GLADES = 20,
	SILVERPINE_FOREST = 21,
	WESTERN_PLAGUELANDS = 22,
	EASTERN_PLAGUELANDS = 23,
	HILLSBRAD_FOOTHILLS = 24,
	THE_HINTERLANDS = 26,
	DUN_MOROGH = 27,
	SEARING_GORGE = 28,
	BURNING_STEPPES = 29,
	ELWYNN_FOREST = 30,
	DUSKWOOD = 34,
	LOCH_MODAN = 35,
	REDRIDGE_MOUNTAINS = 36,
	NORTHERN_STRANGLETHORN = 37,
	SWAMP_OF_SORROWS = 38,
	WESTFALL = 39,
	WETLANDS = 40,
	TELDRASSIL = 41,
	DARKSHORE = 42,
	ASHENVALE = 43,
	THOUSAND_NEEDLES = 61,
	STONETALON_MOUNTAINS = 81,
	DESOLACE = 101,
	FERALAS = 121,
	DUSTWALLOW_MARSH = 141,
	TANARIS = 161,
	AZSHARA = 181,
	FELWOOD = 182,
	UNGORO_CRATER = 201,
	SILITHUS = 261,
	WINTERSPRING = 281,
	STORMWIND_CITY = 301,
	EVERSONG_WOODS = 462,
	GHOSTLANDS = 463,
	HELLFIRE_PENINSULA = 465,
	ZANGARMARSH = 467,
	SHADOWMOON_VALLEY_OUTLAND = 473,
	BLADES_EDGE_MOUNTAINS = 475,
	BLOODMYST_ISLE = 476,
	NAGRAND_OUTLAND = 477,
	TEROKKAR_FOREST = 478,
	NETHERSTORM = 479,
	BOREAN_TUNDRA = 486,
	DRAGONBLIGHT = 488,
	GRIZZLY_HILLS = 490,
	HOWLING_FJORD = 491,
	ICECROWN = 492,
	SHOLAZAR_BASIN = 493,
	THE_STORM_PEAKS = 495,
	ZULDRAK = 496,
	MOUNT_HYJAL = 606,
	SOUTHERN_BARRENS = 607,
	KELPTHAR_FOREST = 610,
	VASHJIR = 613,
	ABYSSAL_DEPTHS = 614,
	SHIMMERING_EXPANSE = 615,
	DEEPHOLM = 640,
	THE_CAPE_OF_STRANGLETHORN = 673,
	ZULFARRAK = 686,
	THE_TEMPLE_OF_ATALHAKKAR = 687,
	BLACKFATHOM_DEEPS = 688,
	GNOMEREGAN = 691,
	DIRE_MAUL = 699,
	TWILIGHT_HIGHLANDS = 700,
	BLACKROCK_DEPTHS = 704,
	ULDUM = 720,
	BLACKROCK_SPIRE = 721,
	OLD_HILLSBRAD_FOOTHILLS = 734,
	WAILING_CAVERNS = 749,
	MARAUDON = 750,
	THE_DEADMINES = 756,
	RAZORFEN_KRAUL = 761,
	SHADOWFANG_KEEP = 764,
	STRATHOLME = 765,
	AHNQIRAJ_THE_FALLEN_KINGDOM = 772,
	MOLTEN_FRONT = 795,
	KARAZHAN = 799,
	THE_JADE_FOREST = 806,
	VALLEY_OF_THE_FOUR_WINDS = 807,
	KUN_LAI_SUMMIT = 809,
	TOWNLONG_STEPPES = 810,
	VALE_OF_ETERNAL_BLOSSOMS = 811,
	KRASARANG_WILDS = 857,
	DREAD_WASTES = 858,
	NORTHSHIRE = 864,
	THE_VEILED_STAIR = 873,
	CAMP_NARACHE = 890,
	DEATHKNELL = 892,
	NEW_TINKERTOWN = 895,
	SCHOLOMANCE = 898,
	ISLE_OF_THUNDER = 928,
	ISLE_OF_GIANTS = 929,
	THRONE_OF_THUNDER = 930,
	TIMELESS_ISLE = 951,
	FROSTFIRE_RIDGE = 941,
	TANAAN_JUNGLE = 945,
	TALADOR = 946,
	SHADOWMOON_VALLEY_DRAENOR = 947,
	SPIRES_OF_ARAK = 948,
	GORGROND = 949,
	NAGRAND_DRAENOR = 950,
	DRAENOR = 962,
	LUNARFALL = 971,
	FROSTWALL = 976,
	ASHRAN = 978,
	STORMSHIELD = 1009,
	WARSPEAR = 1011,
}

private.ZONE_IDS = ZONE_IDS

local ZONE_NAMES = {}
private.ZONE_NAMES = ZONE_NAMES
private.ZONE_ID_TO_LABEL = {}

for label, id in pairs(private.ZONE_IDS) do
	local zone_name = _G.GetMapNameByID(id)
	private.ZONE_NAMES[label] = zone_name
	private.ZONE_ID_TO_LABEL[id] = label
end

ZONE_NAMES.KALIMDOR = continentNames[CONTINENT_IDS.KALIMDOR]
ZONE_NAMES.EASTERN_KINGDOMS = continentNames[CONTINENT_IDS.EASTERN_KINGDOMS]
ZONE_NAMES.OUTLAND = continentNames[CONTINENT_IDS.OUTLAND]
ZONE_NAMES.NORTHREND = continentNames[CONTINENT_IDS.NORTHREND]
ZONE_NAMES.THE_MAELSTROM = continentNames[CONTINENT_IDS.THE_MAELSTROM]
ZONE_NAMES.PANDARIA = continentNames[CONTINENT_IDS.PANDARIA]
ZONE_NAMES.DRAENOR = continentNames[CONTINENT_IDS.DRAENOR]
ZONE_NAMES.BROKEN_ISLES = continentNames[CONTINENT_IDS.BROKEN_ISLES]

ZONE_NAMES.SHADOWMOON_VALLEY_OUTLAND = (("%s %s"):format(_G.GetMapNameByID(ZONE_IDS.SHADOWMOON_VALLEY_OUTLAND), _G.PARENS_TEMPLATE:format(ZONE_NAMES.OUTLAND)))
ZONE_NAMES.SHADOWMOON_VALLEY_DRAENOR = (("%s %s"):format(_G.GetMapNameByID(ZONE_IDS.SHADOWMOON_VALLEY_DRAENOR), _G.PARENS_TEMPLATE:format(ZONE_NAMES.DRAENOR)))
ZONE_NAMES.NAGRAND_OUTLAND = (("%s %s"):format(_G.GetMapNameByID(ZONE_IDS.NAGRAND_OUTLAND), _G.PARENS_TEMPLATE:format(ZONE_NAMES.OUTLAND)))
ZONE_NAMES.NAGRAND_DRAENOR = (("%s %s"):format(_G.GetMapNameByID(ZONE_IDS.NAGRAND_DRAENOR), _G.PARENS_TEMPLATE:format(ZONE_NAMES.DRAENOR)))

local VIRTUAL_CONTINENTS = {
	[CONTINENT_IDS.THE_MAELSTROM] = true
}

for continent_id in pairs(VIRTUAL_CONTINENTS) do
	private.LOCALIZED_CONTINENT_NAMES[continent_id] = nil
end

private.LOCALIZED_CONTINENT_IDS = {}
for continent_id, continent_name in pairs(private.LOCALIZED_CONTINENT_NAMES) do
	private.LOCALIZED_CONTINENT_IDS[continent_name] = continent_id
end

-------------------------------------------------------------------------------
-- Achievements.
-------------------------------------------------------------------------------
private.ACHIEVEMENT_IDS = {
	BLOODY_RARE = 1312,
	FROSTBITTEN = 2257,
	ONE_MANY_ARMY = 7317,
	GLORIOUS = 7439,
	CHAMPIONS_OF_LEI_SHEN = 8103,
	TIMELESS_CHAMPION = 8714,
	GORGROND_MONSTER_HUNTER = 9400,
	HIGH_VALUE_TARGETS_ASHRAN = 9216,
	CUT_OFF_THE_HEAD = 9633,
	HERALDS_OF_THE_LEGION = 9638,
	FIGHT_THE_POWER = 9655,
	ANCIENT_NO_MORE = 9678,
	HELLBANE = 10061,
	JUNGLE_STALKER = 10070,
}

do
	private.ACHIEVEMENTS = {
		[private.ACHIEVEMENT_IDS.BLOODY_RARE]			= { WorldID = private.ZONE_NAMES.OUTLAND },
		[private.ACHIEVEMENT_IDS.FROSTBITTEN]			= { WorldID = private.ZONE_NAMES.NORTHREND },
		[private.ACHIEVEMENT_IDS.ONE_MANY_ARMY]			= { WorldID = private.ZONE_NAMES.PANDARIA },
		[private.ACHIEVEMENT_IDS.GLORIOUS]			= { WorldID = private.ZONE_NAMES.PANDARIA },
		[private.ACHIEVEMENT_IDS.CHAMPIONS_OF_LEI_SHEN]         = { WorldID = private.ZONE_NAMES.PANDARIA },
		[private.ACHIEVEMENT_IDS.TIMELESS_CHAMPION]		= { WorldID = private.ZONE_NAMES.PANDARIA },
		[private.ACHIEVEMENT_IDS.GORGROND_MONSTER_HUNTER]	= { WorldID = private.ZONE_NAMES.DRAENOR },
		[private.ACHIEVEMENT_IDS.HIGH_VALUE_TARGETS_ASHRAN]	= { WorldID = private.ZONE_NAMES.DRAENOR },
		[private.ACHIEVEMENT_IDS.CUT_OFF_THE_HEAD] 		= { WorldID = private.ZONE_NAMES.DRAENOR },
		[private.ACHIEVEMENT_IDS.HERALDS_OF_THE_LEGION]         = { WorldID = private.ZONE_NAMES.DRAENOR },
		[private.ACHIEVEMENT_IDS.FIGHT_THE_POWER]		= { WorldID = private.ZONE_NAMES.DRAENOR },
		[private.ACHIEVEMENT_IDS.ANCIENT_NO_MORE]		= { WorldID = private.ZONE_NAMES.DRAENOR },
		[private.ACHIEVEMENT_IDS.HELLBANE]			= { WorldID = private.ZONE_NAMES.DRAENOR },
		[private.ACHIEVEMENT_IDS.JUNGLE_STALKER]		= { WorldID = private.ZONE_NAMES.DRAENOR },
	}

	local CRITERIA_TYPE_NPC_KILL = 0

	for achievementID, achievement in pairs(private.ACHIEVEMENTS) do
		achievement.ID = achievementID
		achievement.Criteria = {} -- [ CriteriaID ] = NpcID
		achievement.NPCsActive = {} -- [ NpcID ] = CriteriaID

		for criteria_index = 1, _G.GetAchievementNumCriteria(achievementID) do
			local _, criteriaType, _, _, _, _, _, npcID, _, criteriaID = _G.GetAchievementCriteriaInfo(achievementID, criteria_index)
			local _, _, _, isCompleted = _G.GetAchievementInfo(achievementID)

			achievement.is_completed = isCompleted

			if criteriaType == CRITERIA_TYPE_NPC_KILL then
				achievement.Criteria[criteriaID] = npcID
			end
		end
	end
end -- do-block

-------------------------------------------------------------------------------
-- Macro Items.
-------------------------------------------------------------------------------
private.macrotext = "/cleartarget"
private.MACRO_FORMAT = "%s\n/targetexact %s"
private.MACRO_FORMAT_CUSTOM_MOB = "%s\n/target %s"

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


-------------------------------------------------------------------------------
-- Zones.
-------------------------------------------------------------------------------
private.CONTINENT_IDS = {
	KALIMDOR = 1,
	EASTERN_KINGDOMS = 2,
	OUTLAND = 3,
	NORTHREND = 4,
	THE_MAELSTROM = 5,
	PANDARIA = 6,
}


do
	local VIRTUAL_CONTINENTS = {
		[private.CONTINENT_IDS.THE_MAELSTROM] = true
	}


	private.LOCALIZED_CONTINENT_NAMES = { _G.GetMapContinents() }
	for continent_id in pairs(VIRTUAL_CONTINENTS) do
		private.LOCALIZED_CONTINENT_NAMES[continent_id] = nil
	end


	private.LOCALIZED_CONTINENT_IDS = {}
	for continent_id, continent_name in pairs(private.LOCALIZED_CONTINENT_NAMES) do
		private.LOCALIZED_CONTINENT_IDS[continent_name] = continent_id
	end
end -- do-block


private.ZONE_NAMES = {
	DUROTAR = _G.GetMapNameByID(4),
	MULGORE = _G.GetMapNameByID(9),
	NORTHERN_BARRENS = _G.GetMapNameByID(11),
	ARATHI_HIGHLANDS = _G.GetMapNameByID(16),
	BADLANDS = _G.GetMapNameByID(17),
	BLASTED_LANDS = _G.GetMapNameByID(19),
	TIRISFAL_GLADES = _G.GetMapNameByID(20),
	SILVERPINE_FOREST = _G.GetMapNameByID(21),
	WESTERN_PLAGUELANDS = _G.GetMapNameByID(22),
	EASTERN_PLAGUELANDS = _G.GetMapNameByID(23),
	HILLSBRAD_FOOTHILLS = _G.GetMapNameByID(24),
	THE_HINTERLANDS = _G.GetMapNameByID(26),
	DUN_MOROGH = _G.GetMapNameByID(27),
	SEARING_GORGE = _G.GetMapNameByID(28),
	BURNING_STEPPES = _G.GetMapNameByID(29),
	ELWYNN_FOREST = _G.GetMapNameByID(30),
	DUSKWOOD = _G.GetMapNameByID(34),
	LOCH_MODAN = _G.GetMapNameByID(35),
	REDRIDGE_MOUNTAINS = _G.GetMapNameByID(36),
	NORTHERN_STRANGLETHORN = _G.GetMapNameByID(37),
	SWAMP_OF_SORROWS = _G.GetMapNameByID(38),
	WESTFALL = _G.GetMapNameByID(39),
	WETLANDS = _G.GetMapNameByID(40),
	TELDRASSIL = _G.GetMapNameByID(41),
	DARKSHORE = _G.GetMapNameByID(42),
	ASHENVALE = _G.GetMapNameByID(43),
	THOUSAND_NEEDLES = _G.GetMapNameByID(61),
	STONETALON_MOUNTAINS = _G.GetMapNameByID(81),
	DESOLACE = _G.GetMapNameByID(101),
	FERALAS = _G.GetMapNameByID(121),
	DUSTWALLOW_MARSH = _G.GetMapNameByID(141),
	TANARIS = _G.GetMapNameByID(161),
	AZSHARA = _G.GetMapNameByID(181),
	FELWOOD = _G.GetMapNameByID(182),
	UNGORO_CRATER = _G.GetMapNameByID(201),
	SILITHUS = _G.GetMapNameByID(261),
	WINTERSPRING = _G.GetMapNameByID(281),
	STORMWIND_CITY = _G.GetMapNameByID(301),
	EVERSONG_WOODS = _G.GetMapNameByID(462),
	GHOSTLANDS = _G.GetMapNameByID(463),
	HELLFIRE_PENINSULA = _G.GetMapNameByID(465),
	ZANGARMARSH = _G.GetMapNameByID(467),
	SHADOWMOON_VALLEY = _G.GetMapNameByID(473),
	BLADES_EDGE_MOUNTAINS = _G.GetMapNameByID(475),
	BLOODMYST_ISLE = _G.GetMapNameByID(476),
	NAGRAND = _G.GetMapNameByID(477),
	TEROKKAR_FOREST = _G.GetMapNameByID(478),
	NETHERSTORM = _G.GetMapNameByID(479),
	BOREAN_TUNDRA = _G.GetMapNameByID(486),
	DRAGONBLIGHT = _G.GetMapNameByID(488),
	GRIZZLY_HILLS = _G.GetMapNameByID(490),
	HOWLING_FJORD = _G.GetMapNameByID(491),
	ICECROWN = _G.GetMapNameByID(492),
	SHOLAZAR_BASIN = _G.GetMapNameByID(493),
	THE_STORM_PEAKS = _G.GetMapNameByID(495),
	ZULDRAK = _G.GetMapNameByID(496),
	MOUNT_HYJAL = _G.GetMapNameByID(606),
	SOUTHERN_BARRENS = _G.GetMapNameByID(607),
	KELPTHAR_FOREST = _G.GetMapNameByID(610),
	VASHJIR = _G.GetMapNameByID(613),
	ABYSSAL_DEPTHS = _G.GetMapNameByID(614),
	SHIMMERING_EXPANSE = _G.GetMapNameByID(615),
	DEEPHOLM = _G.GetMapNameByID(640),
	THE_CAPE_OF_STRANGLETHORN = _G.GetMapNameByID(673),
	ZULFARRAK = _G.GetMapNameByID(686),
	THE_TEMPLE_OF_ATALHAKKAR = _G.GetMapNameByID(687),
	BLACKFATHOM_DEEPS = _G.GetMapNameByID(688),
	GNOMEREGAN = _G.GetMapNameByID(691),
	DIRE_MAUL = _G.GetMapNameByID(699),
	TWILIGHT_HIGHLANDS = _G.GetMapNameByID(700),
	BLACKROCK_DEPTHS = _G.GetMapNameByID(704),
	ULDUM = _G.GetMapNameByID(720),
	BLACKROCK_SPIRE = _G.GetMapNameByID(721),
	OLD_HILLSBRAD_FOOTHILLS = _G.GetMapNameByID(734),
	WAILING_CAVERNS = _G.GetMapNameByID(749),
	MARAUDON = _G.GetMapNameByID(750),
	THE_DEADMINES = _G.GetMapNameByID(756),
	RAZORFEN_KRAUL = _G.GetMapNameByID(761),
	SHADOWFANG_KEEP = _G.GetMapNameByID(764),
	STRATHOLME = _G.GetMapNameByID(765),
	AHNQIRAJ_THE_FALLEN_KINGDOM = _G.GetMapNameByID(772),
	MOLTEN_FRONT = _G.GetMapNameByID(795),
	KARAZHAN = _G.GetMapNameByID(799),
	THE_JADE_FOREST = _G.GetMapNameByID(806),
	VALLEY_OF_THE_FOUR_WINDS = _G.GetMapNameByID(807),
	KUN_LAI_SUMMIT = _G.GetMapNameByID(809),
	TOWNLONG_STEPPES = _G.GetMapNameByID(810),
	VALE_OF_ETERNAL_BLOSSOMS = _G.GetMapNameByID(811),
	KRASARANG_WILDS = _G.GetMapNameByID(857),
	DREAD_WASTES = _G.GetMapNameByID(858),
	NORTHSHIRE = _G.GetMapNameByID(864),
	THE_VEILED_STAIR = _G.GetMapNameByID(873),
	CAMP_NARACHE = _G.GetMapNameByID(890),
	DEATHKNELL = _G.GetMapNameByID(892),
	NEW_TINKERTOWN = _G.GetMapNameByID(895),
	SCHOLOMANCE = _G.GetMapNameByID(898),
	ISLE_OF_THUNDER = _G.GetMapNameByID(928),
	ISLE_OF_GIANTS = _G.GetMapNameByID(929),
	THRONE_OF_THUNDER = _G.GetMapNameByID(930),
	TIMELESS_ISLE = _G.GetMapNameByID(951),
}

do
	local continent_names = { _G.GetMapContinents() }

	private.ZONE_NAMES.KALIMDOR = continent_names[1]
	private.ZONE_NAMES.EASTERN_KINGDOMS = continent_names[2]
	private.ZONE_NAMES.OUTLAND = continent_names[3]
	private.ZONE_NAMES.NORTHREND = continent_names[4]
	private.ZONE_NAMES.THE_MAELSTROM = continent_names[5]
	private.ZONE_NAMES.PANDARIA = continent_names[6]
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
}


do
	private.ACHIEVEMENTS = {
		[private.ACHIEVEMENT_IDS.BLOODY_RARE]		= { WorldID = private.CONTINENT_IDS.OUTLAND },
		[private.ACHIEVEMENT_IDS.FROSTBITTEN]		= { WorldID = private.CONTINENT_IDS.NORTHREND },
		[private.ACHIEVEMENT_IDS.ONE_MANY_ARMY]		= { WorldID = private.CONTINENT_IDS.PANDARIA },
		[private.ACHIEVEMENT_IDS.GLORIOUS]		= { WorldID = private.CONTINENT_IDS.PANDARIA },
		[private.ACHIEVEMENT_IDS.CHAMPIONS_OF_LEI_SHEN]	= { WorldID = private.CONTINENT_IDS.PANDARIA },
		[private.ACHIEVEMENT_IDS.TIMELESS_CHAMPION]	= { WorldID = private.CONTINENT_IDS.PANDARIA },
	}


	local CRITERIA_TYPE_NPC_KILL = 0


	for achievement_id, achievement in pairs(private.ACHIEVEMENTS) do
		achievement.ID = achievement_id
		achievement.Criteria = {} -- [ CriteriaID ] = NpcID
		achievement.NPCsActive = {} -- [ NpcID ] = CriteriaID

		for criteria_index = 1, _G.GetAchievementNumCriteria(achievement_id) do
			local _, criteria_type, _, _, _, _, _, asset_id, _, criteria_id = _G.GetAchievementCriteriaInfo(achievement_id, criteria_index)
			local _, _, _, is_completed = _G.GetAchievementInfo(achievement_id)

			achievement.is_completed = is_completed

			if criteria_type == CRITERIA_TYPE_NPC_KILL then
				achievement.Criteria[criteria_id] = asset_id
			end
		end
	end
end -- do-block

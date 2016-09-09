-- ----------------------------------------------------------------------------
-- Localized Lua globals.
-- ----------------------------------------------------------------------------
-- Functions
local pairs = _G.pairs

-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local AddOnFolderName, private = ...

-- ----------------------------------------------------------------------------
-- General constants.
-- ----------------------------------------------------------------------------
local DEFAULT_OS_SPAWN_POINT = _G.IsMacClient() and "TOPRIGHT" or "BOTTOMRIGHT"
private.DEFAULT_OS_SPAWN_POINT = DEFAULT_OS_SPAWN_POINT

local NUM_RAID_ICONS = 8
private.NUM_RAID_ICONS = NUM_RAID_ICONS

-- ----------------------------------------------------------------------------
-- Database Defaults.
-- ----------------------------------------------------------------------------
local DATABASE_DEFAULTS = {
	locale = {
		npcNames = {},
		questNames = {},
	},
	profile = {
		alert = {
			screenFlash = {
				color = {
					r = 1,
					g = 1,
					b = 1,
					a = 1,
				},
				isEnabled = true,
				texture = "Blizzard Low Health",
			},
			sound = {
				channel = "Master",
				ignoreMute = false,
				isEnabled = true,
				sharedMediaNames = {
					"NPCScan Chimes",
					"NPCScan Ogre War Drums",
				},
			}
		},
		blacklist = {
			continentIDs = {},
			mapIDs = {},
			npcIDs = {},
		},
		detection = {
			achievements = {},
			ignoreCompletedAchievementCriteria = true,
			ignoreCompletedQuestObjectives = true,
			intervalSeconds = 600,
			raidMarker = {
				add = true,
				addInGroup = false,
			},
			rares = true,
			tameables = true,
			userDefined = true,
			whileOnTaxi = false,
		},
		targetButtonGroup = {
			durationSeconds = 60,
			point = "TOPRIGHT",
			scale = 1,
			x = -300,
			y = -150,
		},
		userDefined = {
			continentNPCs = {},
			mapNPCs = {},
			npcIDs = {},
		},
	},
}

private.DatabaseDefaults = DATABASE_DEFAULTS

-- ----------------------------------------------------------------------------
-- Continents.
-- ----------------------------------------------------------------------------
local ContinentID = {
	KALIMDOR = 1,
	EASTERN_KINGDOMS = 2,
	OUTLAND = 3,
	NORTHREND = 4,
	THE_MAELSTROM = 5,
	PANDARIA = 6,
	DRAENOR = 7,
	BROKEN_ISLES = 8,
}

private.ContinentID = ContinentID

-- ----------------------------------------------------------------------------
-- Achievements.
-- ----------------------------------------------------------------------------
local AchievementID = {
	AdventurerOfAzsuna = 11261,
	AdventurerOfHighmountain = 11264,
	AdventurerOfStormheim = 11263,
	AdventurerOfSuramar = 11265,
	AdventurerOfValsharah = 11262,
	AncientNoMore = 9678,
	BloodyRare = 1312,
	ChampionsOfLeiShen = 8103,
	CutOffTheHead = 9633,
	FightThePower = 9655,
	Frostbitten = 2257,
	Glorious = 7439,
	GorgrondMonsterHunter = 9400,
	Hellbane = 10061,
	HeraldsOfTheLegion = 9638,
	HighValueTargets = 9216,
	JungleStalker = 10070,
	OneManArmy = 7317,
	TimelessChampion = 8714,
	UnleashedMonstrosities = 11160,
}

private.AchievementID = AchievementID

for label, ID in pairs(AchievementID) do
	DATABASE_DEFAULTS.profile.detection.achievements[ID] = true
end

local AchievementLabel = {}
for label, ID in pairs(AchievementID) do
	AchievementLabel[ID] = label
end

private.AchievementLabel = AchievementLabel

local ACHIEVEMENTS = {
	[AchievementID.AdventurerOfAzsuna] = { continentID = ContinentID.BROKEN_ISLES },
	[AchievementID.AdventurerOfHighmountain] = { continentID = ContinentID.BROKEN_ISLES },
	[AchievementID.AdventurerOfStormheim] = { continentID = ContinentID.BROKEN_ISLES },
	[AchievementID.AdventurerOfSuramar] = { continentID = ContinentID.BROKEN_ISLES },
	[AchievementID.AdventurerOfValsharah] = { continentID = ContinentID.BROKEN_ISLES },
	[AchievementID.AncientNoMore] = { continentID = ContinentID.DRAENOR },
	[AchievementID.BloodyRare] = { continentID = ContinentID.OUTLAND },
	[AchievementID.ChampionsOfLeiShen] = { continentID = ContinentID.PANDARIA },
	[AchievementID.CutOffTheHead] = { continentID = ContinentID.DRAENOR },
	[AchievementID.FightThePower] = { continentID = ContinentID.DRAENOR },
	[AchievementID.Frostbitten] = { continentID = ContinentID.NORTHREND },
	[AchievementID.Glorious] = { continentID = ContinentID.PANDARIA },
	[AchievementID.GorgrondMonsterHunter] = { continentID = ContinentID.DRAENOR },
	[AchievementID.Hellbane] = { continentID = ContinentID.DRAENOR },
	[AchievementID.HeraldsOfTheLegion] = { continentID = ContinentID.DRAENOR },
	[AchievementID.HighValueTargets] = { continentID = ContinentID.DRAENOR },
	[AchievementID.JungleStalker] = { continentID = ContinentID.DRAENOR },
	[AchievementID.OneManArmy] = { continentID = ContinentID.PANDARIA },
	[AchievementID.TimelessChampion] = { continentID = ContinentID.PANDARIA },
	[AchievementID.UnleashedMonstrosities] = { continentID = ContinentID.BROKEN_ISLES },
}

private.ACHIEVEMENTS = ACHIEVEMENTS

local AchievementNameByID = {}
private.AchievementNameByID = AchievementNameByID

local AchievementDescriptionByID = {}
private.AchievementDescriptionByID = AchievementDescriptionByID

for achievementID, data in pairs(ACHIEVEMENTS) do
	data.criteriaNPCs = {}

	local _, achievementName, _, _, _, _, _, achievementDescription = _G.GetAchievementInfo(achievementID)
	AchievementNameByID[achievementID] = achievementName
	AchievementDescriptionByID[achievementID] = achievementDescription
end


-- ----------------------------------------------------------------------------
-- Localized Lua globals.
-- ----------------------------------------------------------------------------
-- Functions
local pairs = _G.pairs

-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local AddOnFolderName, private = ...

local LibStub = _G.LibStub
local HereBeDragons = LibStub("HereBeDragons-1.0")

-- ----------------------------------------------------------------------------
-- General constants.
-- ----------------------------------------------------------------------------
local DEFAULT_OS_SPAWN_POINT = _G.IsMacClient() and "TOPRIGHT" or "BOTTOMRIGHT"
private.DEFAULT_OS_SPAWN_POINT = DEFAULT_OS_SPAWN_POINT

local NUM_RAID_ICONS = 8
private.NUM_RAID_ICONS = NUM_RAID_ICONS

local PlayerFactionGroup = _G.UnitFactionGroup("player")
private.PlayerFactionGroup = PlayerFactionGroup

-- ----------------------------------------------------------------------------
-- Database Defaults.
-- ----------------------------------------------------------------------------
local DatabaseDefaults = {
	locale = {
		npcNames = {},
		questNames = {},
	},
	profile = {
		alert = {
			output = {
				sink20OutputSink = "None",
			},
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
					["NPCScan Chimes"] = true,
					["NPCScan Ogre War Drums"] = true,
				},
			}
		},
		blacklist = {
			mapIDs = {},
			npcIDs = {},
		},
		detection = {
			achievementIDs = {},
			continentIDs = {},
			ignoreCompletedAchievementCriteria = true,
			ignoreCompletedQuestObjectives = true,
			ignoreDeadNPCs = true,
			ignoreMinimap = false,
			ignoreWorldMap = false,
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
			hideDuringCombat = false,
			isEnabled = true,
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

private.DatabaseDefaults = DatabaseDefaults

-- ----------------------------------------------------------------------------
-- Preferences.
-- ----------------------------------------------------------------------------
local DetectionGroupStatus = {
	Enabled = 1,
	UserDefined = 2,
	Disabled = 3,
}

private.DetectionGroupStatus = DetectionGroupStatus

local DetectionGroupStatusLabels = {
	_G.ENABLE,
	_G.CUSTOM,
	_G.DISABLE,
}

private.DetectionGroupStatusLabels = DetectionGroupStatusLabels

local DetectionGroupStatusColors = {
	_G.GREEN_FONT_COLOR_CODE,
	_G.NORMAL_FONT_COLOR_CODE,
	_G.RED_FONT_COLOR_CODE,
}

private.DetectionGroupStatusColors = DetectionGroupStatusColors

-- ----------------------------------------------------------------------------
-- Continents.
-- ----------------------------------------------------------------------------
local ContinentID = {
	Kalimdor = 1,
	EasternKingdoms = 2,
	Outland = 3,
	Northrend = 4,
	TheMaelstrom = 5,
	Pandaria = 6,
	Draenor = 7,
	BrokenIsles = 8,
	Argus = 9,
}

private.ContinentID = ContinentID

local ContinentMapID = {
	[ContinentID.Kalimdor] = 13,
	[ContinentID.EasternKingdoms] = 14,
	[ContinentID.Outland] = 466,
	[ContinentID.Northrend] = 485,
	[ContinentID.TheMaelstrom] = 737,
	[ContinentID.Pandaria] = 862,
	[ContinentID.Draenor] = 962,
	[ContinentID.BrokenIsles] = 1007,
	[ContinentID.Argus] = 1184,
}

private.ContinentMapID = ContinentMapID

local ContinentNameByID = {}
private.ContinentNameByID = ContinentNameByID

for continentID = 1, #private.ContinentMapID do
	DatabaseDefaults.profile.detection.continentIDs[continentID] = DetectionGroupStatus.Enabled
	ContinentNameByID[continentID] = HereBeDragons:GetLocalizedMap(private.ContinentMapID[continentID])
end

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
	CommanderOfArgus = 12078,
	CutOffTheHead = 9633,
	FightThePower = 9655,
	Frostbitten = 2257,
	Glorious = 7439,
	GorgrondMonsterHunter = 9400,
	Hellbane = 10061,
	HeraldsOfTheLegion = 9638,
	HighValueTargets = 9216,
	JungleStalker = 10070,
	NaxtVictim = 11841,
	OneManArmy = 7317,
	TerrorsOfTheShore = 11786,
	TimelessChampion = 8714,
	UnleashedMonstrosities = 11160,
}

private.AchievementID = AchievementID

for label, achievementID in pairs(AchievementID) do
	DatabaseDefaults.profile.detection.achievementIDs[achievementID] = DetectionGroupStatus.Enabled
end

local AchievementLabel = {}
for label, ID in pairs(AchievementID) do
	AchievementLabel[ID] = label
end

private.AchievementLabel = AchievementLabel

local AchievementData = {
	[AchievementID.AdventurerOfAzsuna] = { continentID = ContinentID.BrokenIsles },
	[AchievementID.AdventurerOfHighmountain] = { continentID = ContinentID.BrokenIsles },
	[AchievementID.AdventurerOfStormheim] = { continentID = ContinentID.BrokenIsles },
	[AchievementID.AdventurerOfSuramar] = { continentID = ContinentID.BrokenIsles },
	[AchievementID.AdventurerOfValsharah] = { continentID = ContinentID.BrokenIsles },
	[AchievementID.AncientNoMore] = { continentID = ContinentID.Draenor },
	[AchievementID.BloodyRare] = { continentID = ContinentID.Outland },
	[AchievementID.ChampionsOfLeiShen] = { continentID = ContinentID.Pandaria },
	[AchievementID.CommanderOfArgus] = { continentID = ContinentID.BrokenIsles },
	[AchievementID.CutOffTheHead] = { continentID = ContinentID.Draenor },
	[AchievementID.FightThePower] = { continentID = ContinentID.Draenor },
	[AchievementID.Frostbitten] = { continentID = ContinentID.Northrend },
	[AchievementID.Glorious] = { continentID = ContinentID.Pandaria },
	[AchievementID.GorgrondMonsterHunter] = { continentID = ContinentID.Draenor },
	[AchievementID.Hellbane] = { continentID = ContinentID.Draenor },
	[AchievementID.HeraldsOfTheLegion] = { continentID = ContinentID.Draenor },
	[AchievementID.HighValueTargets] = { continentID = ContinentID.Draenor },
	[AchievementID.JungleStalker] = { continentID = ContinentID.Draenor },
	[AchievementID.NaxtVictim] = { continentID = ContinentID.BrokenIsles},
	[AchievementID.OneManArmy] = { continentID = ContinentID.Pandaria },
	[AchievementID.TerrorsOfTheShore] = { continentID = ContinentID.BrokenIsles },
	[AchievementID.TimelessChampion] = { continentID = ContinentID.Pandaria },
	[AchievementID.UnleashedMonstrosities] = { continentID = ContinentID.BrokenIsles },
}

private.AchievementData = AchievementData

for achievementID, data in pairs(AchievementData) do
	data.criteriaNPCs = {}

	local _, achievementName, _, _, _, _, _, achievementDescription, _, iconTexturePath = _G.GetAchievementInfo(achievementID)
	data.name = achievementName
	data.description = achievementDescription
	data.iconTexturePath = iconTexturePath
end


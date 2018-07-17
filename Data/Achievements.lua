-- ----------------------------------------------------------------------------
-- Lua globals
-- ----------------------------------------------------------------------------
local pairs = _G.pairs

-- ----------------------------------------------------------------------------
-- AddOn namespace
-- ----------------------------------------------------------------------------
local AddOnFolderName, private = ...
local AchievementID = private.Enum.AchievementID
local ContinentID = private.Enum.ContinentID
local Data = private.Data

Data.Achievements = {
	[AchievementID.AdventurerOfAzsuna] = {
		continentID = ContinentID.BrokenIsles
	},
	[AchievementID.AdventurerOfHighmountain] = {
		continentID = ContinentID.BrokenIsles
	},
	[AchievementID.AdventurerOfStormheim] = {
		continentID = ContinentID.BrokenIsles
	},
	[AchievementID.AdventurerOfSuramar] = {
		continentID = ContinentID.BrokenIsles
	},
	[AchievementID.AdventurerOfValsharah] = {
		continentID = ContinentID.BrokenIsles
	},
	[AchievementID.AncientNoMore] = {
		continentID = ContinentID.Draenor
	},
	[AchievementID.BloodyRare] = {
		continentID = ContinentID.Outland
	},
	[AchievementID.BrokeBackPrecipice] = {
		continentID = ContinentID.Draenor
	},
	[AchievementID.ChampionsOfLeiShen] = {
		continentID = ContinentID.Pandaria
	},
	[AchievementID.CommanderOfArgus] = {
		continentID = ContinentID.BrokenIsles
	},
	[AchievementID.CutOffTheHead] = {
		continentID = ContinentID.Draenor
	},
	[AchievementID.FightThePower] = {
		continentID = ContinentID.Draenor
	},
	[AchievementID.Frostbitten] = {
		continentID = ContinentID.Northrend
	},
	[AchievementID.Glorious] = {
		continentID = ContinentID.Pandaria
	},
	[AchievementID.GorgrondMonsterHunter] = {
		continentID = ContinentID.Draenor
	},
	[AchievementID.Hellbane] = {
		continentID = ContinentID.Draenor
	},
	[AchievementID.HeraldsOfTheLegion] = {
		continentID = ContinentID.Draenor
	},
	[AchievementID.HighValueTargets] = {
		continentID = ContinentID.Draenor
	},
	[AchievementID.ImInYourBaseKillingYourDudes] = {
		continentID = ContinentID.Pandaria
	},
	[AchievementID.JungleStalker] = {
		continentID = ContinentID.Draenor
	},
	[AchievementID.KingOfTheMonsters] = {
		continentID = ContinentID.Draenor
	},
	[AchievementID.MakingTheCut] = {
		continentID = ContinentID.Draenor
	},
	[AchievementID.MillionsOfYearsOfEvolutionVsMyFist] = {
		continentID = ContinentID.Pandaria,
		criteriaNPCs = {
			[69161] = true, -- Oondasta
		}
	},
	[AchievementID.NaxtVictim] = {
		continentID = ContinentID.BrokenIsles
	},
	[AchievementID.OneManArmy] = {
		continentID = ContinentID.Pandaria
	},
	[AchievementID.PraiseTheSun] = {
		continentID = ContinentID.Pandaria,
		criteriaNPCs = {
			[69099] = true, -- Nalak¸
		},
	},
	[AchievementID.Predator] = {
		continentID = ContinentID.Draenor,
		criteriaNPCs = {
			[96235] = true, -- Xemirkol
		}
	},
	[AchievementID.TerrorsOfTheShore] = {
		continentID = ContinentID.BrokenIsles
	},
	[AchievementID.TheSongOfSilence] = {
		continentID = ContinentID.Draenor
	},
	[AchievementID.TimelessChampion] = {
		continentID = ContinentID.Pandaria
	},
	[AchievementID.UnleashedMonstrosities] = {
		continentID = ContinentID.BrokenIsles
	},
	[AchievementID.ZulAgain] = {
		continentID = ContinentID.Pandaria,
		criteriaNPCs = {
			[69768] = true, -- Zandalari Warscout
			[69769] = true, -- Zandalari Warbringer
			[69841] = true, -- Zandalari Warbringer
			[69842] = true, -- Zandalari Warbringer
		},
	},
}

-- ----------------------------------------------------------------------------
-- Achievements.
-- ----------------------------------------------------------------------------
for achievementID, achievement in pairs(private.Data.Achievements) do
    local _, name, _, _, _, _, _, description, _, iconTexturePath = _G.GetAchievementInfo(achievementID)
    achievement.criteriaNPCs = {}
    achievement.description = description
    achievement.iconTexturePath = iconTexturePath
    achievement.name = name
end

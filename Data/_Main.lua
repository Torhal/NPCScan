-- ----------------------------------------------------------------------------
-- AddOn namespace
-- ----------------------------------------------------------------------------
local AddOnFolderName, private = ...
local AchievementID = private.Enum.AchievementID
local ContinentID = private.Enum.ContinentID

-- ----------------------------------------------------------------------------
-- Constants
-- ----------------------------------------------------------------------------
local addTableMeta = {
	__index = function(t, mapID)
		if mapID < 0 then
			return
		end

		local new = {}
        rawset(t, mapID, new)

        return new
    end
}

private.Data = {
    Achievements = {
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
        [AchievementID.JungleStalker] = {
            continentID = ContinentID.Draenor
        },
        [AchievementID.KingOfTheMonsters] = {
            continentID = ContinentID.Draenor
        },
        [AchievementID.MakingTheCut] = {
            continentID = ContinentID.Draenor
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
				[69099] = true, -- Nalak
			},
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
        }
    },
    Continents = {},
	Maps = setmetatable({}, addTableMeta),
	NPCs = {},
	Scanner = {
		continentID = nil,
		mapID = nil,
		NPCCount = 0,
		NPCs = {},
	}
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

-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local AddOnFolderName, private = ...

-- ----------------------------------------------------------------------------
-- Constants
-- ----------------------------------------------------------------------------
local ContinentID = {
	Cosmic = -1,
    Kalimdor = 1,
    EasternKingdoms = 2,
    Outland = 3,
    Northrend = 4,
    TheMaelstrom = 5,
    Pandaria = 6,
    Draenor = 7,
    BrokenIsles = 8,
    Argus = 9
}

private.Enum = {
    AchievementID = {
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
        UnleashedMonstrosities = 11160
    },
    ContinentID = ContinentID,
    ContinentMapID = {
        [ContinentID.Kalimdor] = 13,
        [ContinentID.EasternKingdoms] = 14,
        [ContinentID.Outland] = 466,
        [ContinentID.Northrend] = 485,
        [ContinentID.TheMaelstrom] = 737,
        [ContinentID.Pandaria] = 862,
        [ContinentID.Draenor] = 962,
        [ContinentID.BrokenIsles] = 1007,
        [ContinentID.Argus] = 1184
    },
    DetectionGroupStatus = {
        Enabled = 1,
        UserDefined = 2,
        Disabled = 3
    }
}

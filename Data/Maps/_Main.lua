----------------------------------------------------------------------------------
---- AddOn Namespace
---------------------------------------------------------------------------------
local AddOnFolderName = ... ---@type string
local private = select(2, ...) ---@class PrivateNamespace

local Data = private.Data
local Enum = private.Enum

--------------------------------------------------------------------------------
---- Constants
--------------------------------------------------------------------------------
local MapID = {
    AbyssalDepths = 204,
    AhnQirajTheFallenKingdom = 327,
    AntoranWastes = 885,
    ArathiHighlands = 14,
    Ardenweald = 1565,
    Argus = 905,
    Ashenvale = 63,
    Ashran = 588,
    Azeroth = 947,
    Azshara = 76,
    Azsuna = 630,
    AzuremystIsle = 97,
    Badlands = 15,
    Bastion = 1533,
    BlackfathomDeeps = 221,
    BlackrockDepths = 242,
    BlackrockSpire = 250,
    BladesEdgeMountains = 105,
    BlastedLands = 17,
    BloodmystIsle = 106,
    Boralus = 1161,
    BoreanTundra = 114,
    BrokenIsles = 619,
    BrokenShore = 646,
    BurningSteppes = 36,
    CampNarache = 462,
    Cosmic = 946,
    DarkheartThicket = 733,
    DarkmoonIsland = 407,
    Darkshore = 62,
    Dazaralor = 1165,
    Deathknell = 465,
    Deepholm = 207,
    Desolace = 66,
    DireMaul = 234,
    Draenor = 572,
    Dragonblight = 115,
    DreadWastes = 422,
    Drustvar = 896,
    DunMorogh = 27,
    Durotar = 1,
    Duskwood = 47,
    DustwallowMarsh = 70,
    EasternKingdoms = 13,
    EasternPlaguelands = 23,
    ElwynnForest = 37,
    EversongWoods = 94,
    EyeOfAzshara = 713,
    Felwood = 77,
    Feralas = 69,
    FrostfireRidge = 525,
    Frostwall = 590,
    FrostwallMine = 585,
    Ghostlands = 95,
    Gnomeregan = 226,
    Gorgrond = 543,
    GrizzlyHills = 116,
    HallsOfValor = 703,
    Helheim = 649,
    HellfirePeninsula = 100,
    Highmountain = 650,
    HillsbradFoothills = 25,
    HowlingFjord = 117,
    Icecrown = 118,
    IsleOfGiants = 507,
    IsleOfThunder = 504,
    Kalimdor = 12,
    Karazhan = 350,
    KelptharForest = 201,
    KrasarangWilds = 418,
    Krokuun = 830,
    KulTiras = 876,
    KunLaiSummit = 379,
    LochModan = 48,
    Lunarfall = 582,
    LunarfallExcavation = 579,
    MacAree = 882,
    Maldraxxus = 1536,
    Maraudon = 280,
    MardumTheShatteredAbyss = 672,
    MechagonIsland = 1462,
    MoltenFront = 338,
    MountHyjal = 198,
    Mulgore = 7,
    NagrandDraenor = 550,
    NagrandOutland = 107,
    Nazjatar = 1355,
    Nazmir = 863,
    Netherstorm = 109,
    NewTinkertown = 469,
    NorthernBarrens = 10,
    NorthernStranglethorn = 50,
    Northrend = 113,
    Northshire = 425,
    OldHillsbradFoothills = 274,
    Outland = 101,
    Pandaria = 424,
    RazorfenKraul = 301,
    RedridgeMountains = 49,
    Revendreth = 1525,
    Scholomance = 476,
    SearingGorge = 32,
    ShadowfangKeep = 310,
    ShadowmoonValleyDraenor = 539,
    ShadowmoonValleyOutland = 104,
    ShimmeringExpanse = 205,
    SholazarBasin = 119,
    Silithus = 81,
    SilverpineForest = 21,
    SouthernBarrens = 199,
    SpiresOfArak = 542,
    StonetalonMountains = 65,
    Stormheim = 634,
    StormsongValley = 942,
    StormwindCity = 84,
    Stratholme = 317,
    Suramar = 680,
    SwampOfSorrows = 51,
    Talador = 535,
    TanaanJungle = 534,
    Tanaris = 71,
    Teldrassil = 57,
    TerokkarForest = 108,
    TheCapeOfStranglethorn = 210,
    TheDeadmines = 291,
    TheExodar = 775,
    TheHinterlands = 26,
    TheJadeForest = 371,
    TheMaelstrom = 948,
    TheMaw = 1543,
    TheShadowlands = 1550,
    TheStormPeaks = 120,
    TheTempleOfAtalHakkar = 220,
    TheVeiledStair = 433,
    ThousandNeedles = 64,
    ThroneOfThunder = 508,
    ThunderTotem = 750,
    TimelessIsle = 554,
    TiragardeSound = 895,
    TirisfalGlades = 18,
    TownlongSteppes = 388,
    TwilightHighlands = 241,
    Uldum = 249,
    UldumBFA = 1527,
    UnchartedIsland = 1022,
    UnGoroCrater = 78,
    UpperBlackrockSpire = 616,
    ValeOfEternalBlossoms = 390,
    ValeOfEternalBlossomsBFA = 1530,
    ValleyOfTheFourWinds = 376,
    ValSharah = 641,
    Vashjir = 203,
    VaultOfTheWardens = 677,
    Voldun = 864,
    WailingCaverns = 279,
    WesternPlaguelands = 22,
    Westfall = 52,
    Wetlands = 56,
    Winterspring = 83,
    Zandalar = 875,
    Zangarmarsh = 102,
    Zuldazar = 862,
    ZulDrak = 121,
    ZulFarrak = 219,
}

Enum.MapID = MapID

local ContinentID = {
    Cosmic = 1,
    Azeroth = 2,
    Kalimdor = 3,
    EasternKingdoms = 4,
    Outland = 5,
    Northrend = 6,
    TheMaelstrom = 7,
    Pandaria = 8,
    Draenor = 9,
    BrokenIsles = 10,
    Argus = 11,
    Zandalar = 12,
    KulTiras = 13,
    TheShadowlands = 14,
}

Enum.ContinentID = ContinentID

local ContinentMapID = {
    [ContinentID.Cosmic] = MapID.Cosmic,
    [ContinentID.Azeroth] = MapID.Azeroth,
    [ContinentID.Kalimdor] = MapID.Kalimdor,
    [ContinentID.EasternKingdoms] = MapID.EasternKingdoms,
    [ContinentID.Outland] = MapID.Outland,
    [ContinentID.Northrend] = MapID.Northrend,
    [ContinentID.TheMaelstrom] = MapID.TheMaelstrom,
    [ContinentID.Pandaria] = MapID.Pandaria,
    [ContinentID.Draenor] = MapID.Draenor,
    [ContinentID.BrokenIsles] = MapID.BrokenIsles,
    [ContinentID.Argus] = MapID.Argus,
    [ContinentID.Zandalar] = MapID.Zandalar,
    [ContinentID.KulTiras] = MapID.KulTiras,
    [ContinentID.TheShadowlands] = MapID.TheShadowlands,
}

Enum.ContinentMapID = ContinentMapID

local MapContinentID = {}

for continentID, mapID in _G.pairs(ContinentMapID) do
    MapContinentID[mapID] = continentID
end

Enum.MapContinentID = MapContinentID

--------------------------------------------------------------------------------
---- Helpers
--------------------------------------------------------------------------------
local function SortByMapNameThenByID(a, b)
    local mapNameA = Data.Maps[a].name
    local mapNameB = Data.Maps[b].name

    if mapNameA == mapNameB then
        return a < b
    end

    return mapNameA < mapNameB
end

private.SortByMapNameThenByID = SortByMapNameThenByID

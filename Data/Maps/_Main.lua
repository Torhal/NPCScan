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

---@type table<string, integer>
local MapID = {
    AbyssalDepths = 204,
    AhnQirajTheFallenKingdom = 327,
    AntoranWastes = 885,
    ArathiHighlands = 14,
    Ardenweald = 1565,
    Argus = 905,
    Ashenvale = 63,
    Ashran = 588,
    AtalAman = 2536,
    Azeroth = 947,
    AzjKahetLower = 2256,
    Azshara = 76,
    Azsuna = 630,
    AzuremystIsle = 97,
    Badlands = 15,
    Bastion = 1533,
    BlackfathomDeeps = 221,
    BlackrockDepths = 242,
    BlackrockMountain = 33,
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
    DalaranLegion = 628,
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
    DragonIsles = 1978,
    DreadWastes = 422,
    Drustvar = 896,
    DunMorogh = 27,
    Durotar = 1,
    Duskwood = 47,
    DustwallowMarsh = 70,
    EasternKingdoms = 13,
    EasternPlaguelands = 23,
    ElwynnForest = 37,
    EmeraldDream = 2200,
    Eredath = 882,
    EversongWoods = 94,
    EversongWoodsMidnight = 2395,
    ExilesReach = 1409,
    EyeOfAzshara = 713,
    Felwood = 77,
    Feralas = 69,
    FrostfireRidge = 525,
    Frostwall = 590,
    FrostwallMine = 585,
    Ghostlands = 95,
    Gnomeregan = 226,
    GolBolarQuarry = 31,
    Gorgrond = 543,
    GrizzlyHills = 116,
    GromitHollow = 2007,
    Hallowfall = 2215,
    HallsOfValor = 703,
    Harandar = 2413,
    Helheim = 649,
    HellfirePeninsula = 100,
    Highmountain = 650,
    HillsbradFoothills = 25,
    HowlingFjord = 117,
    Icecrown = 118,
    IsleOfDorn = 2248,
    IsleOfGiants = 507,
    IsleOfThunder = 504,
    IsleOfQuelDanas = 2424,
    Kalimdor = 12,
    Karazhan = 350,
    Karesh = 2371,
    KelptharForest = 201,
    KhazAlgar = 2274,
    Korthia = 1961,
    KrasarangWilds = 418,
    Krokuun = 830,
    KulTiras = 876,
    KunLaiSummit = 379,
    LochModan = 48,
    Lunarfall = 582,
    LunarfallExcavation = 579,
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
    OhnahranPlains = 2023,
    OldHillsbradFoothills = 274,
    Outland = 101,
    Pandaria = 424,
    QuelThalas = 2537,
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
    SirenIsle = 2369,
    SlayersRise = 2444,
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
    Thaldraszus = 2025,
    TheAzureSpan = 2024,
    TheCapeOfStranglethorn = 210,
    TheDeadmines = 291,
    TheExodar = 775,
    TheForbiddenReach = 2118,
    TheForbiddenReach2 = 2151,
    TheForgottenVault = 2375,
    TheHinterlands = 26,
    TheJadeForest = 371,
    TheMaelstrom = 948,
    TheMaw = 1543,
    ThePrimalistFuture = 2085,
    TheRingingDeeps = 2214,
    TheSeatOfTheTriumvirate = 903,
    TheShadowlands = 1550,
    TheStormPeaks = 120,
    TheTempleOfAtalHakkar = 220,
    TheVeiledStair = 433,
    TheWakingShores = 2022,
    ThousandNeedles = 64,
    ThroneOfThunder = 508,
    ThunderTotem = 750,
    TimelessIsle = 554,
    TiragardeSound = 895,
    TirisfalGlades = 18,
    TorghastEntrance = 1705,
    TownlongSteppes = 388,
    TwilightHighlands = 241,
    Uldum = 249,
    UldumBFA = 1527,
    UnchartedIsland = 1022,
    Undermine = 2346,
    UnGoroCrater = 78,
    UpperBlackrockSpire = 616,
    ValeOfEternalBlossoms = 390,
    ValeOfEternalBlossomsBFA = 1530,
    ValleyOfTheFourWinds = 376,
    ValSharah = 641,
    Vashjir = 203,
    VaultOfTheWardens = 677,
    Voidstorm = 2405,
    Voldun = 864,
    WailingCaverns = 279,
    WesternPlaguelands = 22,
    Westfall = 52,
    Wetlands = 56,
    Winterspring = 83,
    Zandalar = 875,
    Zangarmarsh = 102,
    ZaralekCavern = 2133,
    ZerethMortis = 1970,
    ZulAman = 2437,
    Zuldazar = 862,
    ZulDrak = 121,
    ZulFarrak = 219,
}

private.Enum.MapID = MapID

---@type table<string, integer>
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
    DragonIsles = 15,
    KhazAlgar = 16,
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
    [ContinentID.DragonIsles] = MapID.DragonIsles,
    [ContinentID.KhazAlgar] = MapID.KhazAlgar,
}

Enum.ContinentMapID = ContinentMapID

local MapContinentID = {}

for continentID, mapID in _G.pairs(ContinentMapID) do
    MapContinentID[mapID] = continentID
end

Enum.MapContinentID = MapContinentID

-----------------------------------------------------------------------
-- WoW 7 to 8 transition
-----------------------------------------------------------------------
function GetOldMapData(oldMapID)
    local HBDMigrate = _G.LibStub("HereBeDragons-Migrate")
    local newMapID = HBDMigrate:GetUIMapIDFromMapAreaId(oldMapID)
    local mapInfo = _G.C_Map.GetMapInfo(newMapID)
    local continentInfo = _G.MapUtil.GetMapParentInfo(newMapID, _G.Enum.UIMapType.Continent, true)

    return { oldMapID = oldMapID, mapInfo = mapInfo, continentInfo = continentInfo }
end

function GetMapData(mapID)
    mapID = mapID or _G.C_Map.GetBestMapForUnit("player")

    local mapInfo = _G.C_Map.GetMapInfo(mapID)
    local continentInfo = _G.MapUtil.GetMapParentInfo(mapID, _G.Enum.UIMapType.Continent, true)
    local worldInfo = _G.MapUtil.GetMapParentInfo(mapID, _G.Enum.UIMapType.World, true)

    return { mapInfo = mapInfo, continentInfo = continentInfo, worldInfo = worldInfo }
end

--------------------------------------------------------------------------------
---- Helpers
--------------------------------------------------------------------------------

local function SortByMapNameThenByID(mapIDA, mapIDB)
    local mapNameA = Data.Maps[mapIDA].name
    local mapNameB = Data.Maps[mapIDB].name

    if mapNameA == mapNameB then
        return mapIDA < mapIDB
    end

    return mapNameA < mapNameB
end

private.SortByMapNameThenByID = SortByMapNameThenByID

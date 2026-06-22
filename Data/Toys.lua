--------------------------------------------------------------------------------
----  AddOn Namespace
--------------------------------------------------------------------------------

local AddOnFolderName = ... ---@type string
local private = select(2, ...) ---@class PrivateNamespace

--------------------------------------------------------------------------------
---- Constants
--------------------------------------------------------------------------------

private.Enum.Toy = {
    AiLisSkymirror = {
        itemID = 86589, -- Ai-Li's Skymirror
    },
    AncientsBloom = {
        itemID = 113570, -- Ancient's Bloom
    },
    AquaJewel = {
        itemID = 86582, -- Aqua Jewel
    },
    BaarutTheBrisk = {
        itemID = 153193, -- Baarut the Brisk
    },
    BarrierGenerator = {
        itemID = 153183, -- Barrier Generator
    },
    BaruunsBountifulBloom = {
        itemID = 113540, -- Ba'ruun's Bountiful Bloom
    },
    BattleHorn = {
        itemID = 86565, -- Battle Horn
    },
    BlackWhirlwind = {
        itemID = 119178, -- Black Whirlwind
    },
    BlackflameDaggers = {
        itemID = 104302, -- Blackflame Daggers
    },
    BlueConservatoryScroll = {
        itemID = 153179, -- Blue Conservatory Scroll
    },
    BotaniCamouflage = {
        itemID = 119432, -- Botani Camouflage
    },
    BottledTornado = {
        itemID = 134023, -- Bottled Tornado
    },
    BrazierCap = {
        itemID = 163713, -- Brazier Cap
    },
    BreathOfTalador = {
        itemID = 116113, -- Breath of Talador
    },
    BubbleWand = {
        itemID = 114227, -- Bubble Wand
    },
    BurningLegionMissive = {
        itemID = 116122, -- Burning Legion Missive
    },
    ChaliceOfSecrets = {
        itemID = 86575, -- Chalice of Secrets
    },
    ColdragesCooler = {
        itemID = 163744, -- Coldrage's Cooler
    },
    CrabShank = {
        itemID = 140314, -- Crab Shank
    },
    CrashinThrashinCannonController = {
        itemID = 108633, -- Crashin' Thrashin' Cannon Controller
    },
    CrashinThrashinMortarController = {
        itemID = 108634, -- Crashin' Thrashin' Mortar Controller
    },
    CrashinThrashinRollerController = {
        itemID = 108631, -- Crashin' Thrashin' Roller Controller
    },
    CursedFeatherOfIkzan = {
        itemID = 122117, -- Cursed Feather of Ikzan
    },
    CursedOrb = {
        itemID = 130171, -- Cursed Orb
    },
    EssenceOfTheBreeze = {
        itemID = 86590, -- Essence of the Breeze
    },
    EternalKiln = {
        itemID = 104309, -- Eternal Kiln
    },
    EternalWarriorsSigil = {
        itemID = 86578, -- Eternal Warrior's Sigil
    },
    EverAbundantHearth = {
        itemID = 184404, -- Ever-Abundant Hearth
    },
    FaintlyGlowingFlagonOfMead = {
        itemID = 129113, -- Faintly Glowing Flagon of Mead
    },
    FarwaterConch = {
        itemID = 86581, -- Farwater Conch
    },
    FelflameCampfire = {
        itemID = 127652, -- Felflame Campfire
    },
    FoulBelly = {
        itemID = 163735, -- Foul Belly
    },
    GhostlyIronBuccaneersHat = {
        itemID = 127659, -- Ghostly Iron Buccaneer's Hat
    },
    GorenLogRoller = {
        itemID = 119180, -- Goren "Log" Roller
    },
    HardenedShell = {
        itemID = 86584, -- Hardened Shell
    },
    HelpfulWikkysWhistle = {
        itemID = 86594, -- Helpful Wikky's Whistle
    },
    HozenBeachBall = {
        itemID = 86593, -- Hozen Beach Ball
    },
    HypnosisGoggles = {
        itemID = 113631, -- Hypnosis Goggles
    },
    InfectedIchor = {
        itemID = 200178, -- Infected Ichor
    },
    IronBuccaneersHat = {
        itemID = 118244, -- Iron Buccaneer's Hat
    },
    KangsBindstone = {
        itemID = 86571, -- Kang's Bindstone
    },
    KlikixxsWebspinner = {
        itemID = 116125, -- Klikixx's Webspinner
    },
    KovorkKostume = {
        itemID = 163750, -- Kovork Kostume
    },
    LegionCommunicationOrb = {
        itemID = 153194, -- Legion Communication Orb
    },
    MagesChewedWand = {
        itemID = 200249, -- Mage's Chewed Wand
    },
    MagicBanana = {
        itemID = 86591, -- Magic Banana
    },
    MagicFunRock = {
        itemID = 163741, -- Magic Fun Rock
    },
    MajesticElderhornHoof = {
        itemID = 131900, -- Majestic Elderhorn Hoof
    },
    MicroArtilleryController = {
        itemID = 153126, -- Micro-Artillery Controller
    },
    MnemonicAttunementPane = {
        itemID = 184413, -- Mnemonic Attunement Pane
    },
    MolokMorion = {
        itemID = 163775, -- Molok Morion
    },
    MoonfangShroud = {
        itemID = 101571, -- Moonfang Shroud
    },
    MoonfangsPaw = {
        itemID = 105898, -- Moonfang's Paw
    },
    MournfulMoanOfMurmur = {
        itemID = 113670, -- Mournful Moan of Murmur
    },
    MrSmitesBrassCompass = {
        itemID = 86568, -- Mr. Smite's Brass Compass
    },
    OddPolishedStone = {
        itemID = 104262, -- Odd Polished Stone
    },
    OgreBrewingKit = {
        itemID = 118224, -- Ogre Brewing Kit
    },
    PandarenFireworkLauncher = {
        itemID = 86588, -- Pandaren Firework Launcher
    },
    PanfluteOfPandaria = {
        itemID = 86586, -- Panflute of Pandaria
    },
    PersonalShell = {
        itemID = 198409, -- Personal Shell
    },
    PetrificationStone = {
        itemID = 118221, -- Petrification Stone
    },
    PrimalistPrison = {
        itemID = 200198, -- Primalist Prison
    },
    RedConservatoryScroll = {
        itemID = 153181, -- Red Conservatory Scroll
    },
    RimeOfTheTimeLostMariner = {
        itemID = 104294, -- Rime of the Time-Lost Mariner
    },
    RodOfAmbershaping = {
        itemID = 86577, -- Rod of Ambershaping
    },
    SFEInterceptor = {
        itemID = 153253, -- S.F.E. Interceptor
    },
    SalyinBattleBanner = {
        itemID = 86583, -- Salyin Battle Banner
    },
    SassyImp = {
        itemID = 127655, -- Sassy Imp
    },
    ShardOfArchstone = {
        itemID = 86573, -- Shard of Archstone
    },
    SightlessEye = {
        itemID = 153293, -- Sightless Eye
    },
    Smolderheart = {
        itemID = 180873, -- Smolderheart
    },
    SoulInhaler = {
        itemID = 119163, -- Soul Inhaler
    },
    SpectralVisage = {
        itemID = 163736, -- Spectral Visage
    },
    SpireOfSpite = {
        itemID = 153124, -- Spire of Spite
    },
    SpiritOfBashiok = {
        itemID = 118222, -- Spirit of Bashiok
    },
    SpiritOfShinri = {
        itemID = 113543, -- Spirit of Shinri
    },
    StolenBreath = {
        itemID = 111476, -- Stolen Breath
    },
    SyndicateMask = {
        itemID = 163738, -- Syndicate Mask
    },
    ThistleleafBranch = {
        itemID = 130147, -- Thistleleaf Branch
    },
    ToySiegeTower = {
        itemID = 163828, -- Toy Siege Tower
    },
    ToyWarMachine = {
        itemID = 163829, -- Toy War Machine
    },
    VialOfRedGoo = {
        itemID = 127666, -- Vial of Red Goo
    },
    WarningSign = {
        itemID = 104331, -- Warning Sign
    },
    WhispersOfRaivosh = {
        itemID = 113542, -- Whispers of Rai'Vosh
    },
    WitherbarkGong = {
        itemID = 163745, -- Witherbark Gong
    },
    WornDoll = {
        itemID = 130214, -- Worn Doll
    },
    YellowConservatoryScroll = {
        itemID = 153180, -- Yellow Conservatory Scroll
    },
}

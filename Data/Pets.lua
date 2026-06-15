--------------------------------------------------------------------------------
----  AddOn Namespace
--------------------------------------------------------------------------------

local AddOnFolderName = ... ---@type string
local private = select(2, ...) ---@class PrivateNamespace

--------------------------------------------------------------------------------
---- Constants
--------------------------------------------------------------------------------

private.Enum.Pet = {
    AldrusianSproutling = {
        itemID = 163650, -- Aldrusian Sproutling
        npcID = 143503, -- Aldrusian Sproutling
    },
    AquaStrider = {
        itemID = 86563, -- Hollow Reed
        npcID = 64633, -- Aqua Strider
    },
    AshleafSpriteling = {
        itemID = 104156, -- Ashleaf Spriteling
        npcID = 73533, -- Ashleaf Spriteling
    },
    Benax = {
        itemID = 140934, -- Benax
        npcID = 113136, -- Benax
    },
    BrilliantSpore = {
        itemID = 118107, -- Brilliant Spore
        npcID = 86719, -- Brilliant Spore
    },
    ChirpyValeshrieker = {
        itemID = 180643, -- Chirpy Valeshrieker
        npcID = 171239, -- Chirpy Valeshrieker
    },
    Crispin = {
        itemID = 129175, -- Crispin
        npcID = 98077, -- Crispin
    },
    DeathAdderHatchling = {
        itemID = 104161, -- Death Adder Hatchling
        npcID = 73364, -- Death Adder Hatchling
    },
    DetectiveRay = {
        itemID = 166451, -- Rattling Bones
        npcID = 148825, -- Detective Ray
    },
    DocileSkyfin = {
        itemID = 153054, -- Docile Skyfin
        npcID = 128157, -- Docile Skyfin
    },
    Dodger = {
        itemID = 180645, -- Dodger
        npcID = 171247, -- Dodger
    },
    DoomBloom = {
        itemID = 118709, -- Doom Bloom
        npcID = 88103, -- Doom Bloom
    },
    EmeraldWhelpling = {
        itemID = 8498, -- Emerald Whelpling
        npcID = 7545, -- Emerald Whelpling
    },
    EmpoweredManafiend = {
        itemID = 129217, -- Warm Arcane Crystal
        npcID = 98237, -- Empowered Manafiend
    },
    EmpyrealManafiend = {
        itemID = 129218, -- Glittering Arcane Crystal
        npcID = 98238, -- Empyreal Manafiend
    },
    EnergizedManafiend = {
        itemID = 129216, -- Vibrating Arcane Crystal
        npcID = 98236, -- Energized Manafiend
    },
    EyeOfInquisition = {
        itemID = 136901, -- Eye of Inquisition
        npcID = 97179, -- Eye of Inquisition
    },
    EyeOfObservation = {
        itemID = 119170, -- Eye of Observation
        npcID = 88490, -- Eye of Observation
    },
    FelAfflictedSkyfin = {
        itemID = 153055, -- Fel-Afflicted Skyfin
        npcID = 128158, -- Fel-Afflicted Skyfin
    },
    FetidWaveling = {
        itemID = 130168, -- Fetid Waveling
        npcID = 99394, -- Fetid Waveling
    },
    Foulfeather = {
        itemID = 163690, -- Plagued Egg
        npcID = 143564, -- Foulfeather
    },
    Fozling = {
        itemID = 163711, -- Shard of Fozruk
        npcID = 143627, -- Fozling
    },
    FuzzyCreepling = {
        itemID = 163648, -- Fuzzy Creepling
        npcID = 143499, -- Fuzzy Creepling
    },
    GoldenCloudfeather = {
        itemID = 180812, -- Golden Cloudfeather
        npcID = 171565, -- Golden Cloudfeather
    },
    GormNeedler = {
        itemID = 180631, -- Gorm Needler
        npcID = 171231, -- Gorm Needler
    },
    GraspingManifestation = {
        itemID = 153056, -- Grasping Manifestation
        npcID = 128159, -- Grasping Manifestation
    },
    Grinder = {
        itemID = 86564, -- Imbued Jade Fragment
        npcID = 64634, -- Grinder
    },
    GuchiSwarmling = {
        itemID = 104291, -- Swarmling of Gu'chi
        npcID = 73730, -- Gu'chi Swarmling
    },
    GulpFroglet = {
        itemID = 104169, -- Gulp Froglet
        npcID = 73359, -- Gulp Froglet
    },
    GustOfCyclarus = {
        itemID = 166448, -- Binding of Cyclarus
        npcID = 148784, -- Gust of Cyclarus
    },
    HydrathDroplet = {
        itemID = 166452, -- Bottled Essence of Hydrath
        npcID = 148841, -- Hydrath Droplet
    },
    JadefireSpirit = {
        itemID = 104307, -- Jadefire Spirit
        npcID = 73738, -- Jadefire Spirit
    },
    LarionPouncer = {
        itemID = 184401, -- Larion Pouncer
        npcID = 175562, -- Larion Pouncer
    },
    LavenderNibbler = {
        itemID = 183196, -- Lavender Nibbler
        npcID = 173993, -- Lavender Nibbler
    },
    MoonMoon = {
        itemID = 101570, -- Moon Moon
        npcID = 72160, -- Moon Moon
    },
    NetherspawnSpawnOfNetherspawn = {
        itemID = 116815, -- Netherspawn, Spawn of Netherspawn
        npcID = 86081, -- Netherspawn, Spawn of Netherspawn
    },
    PygmyOwl = {
        itemID = 130154, -- Pygmy Owl
        npcID = 108568, -- Pygmy Owl
    },
    Ragepeep = {
        itemID = 163689, -- Angry Egg
        npcID = 143563, -- Ragepeep
    },
    RebelliousImp = {
        itemID = 153252, -- Rebellious Imp
        npcID = 128388, -- Rebellious Imp
    },
    RisenSaberKitten = {
        itemID = 130166, -- Risen Saber Kitten
        npcID = 99403, -- Risen Saber Kitten
    },
    Rocky = {
        itemID = 180644, -- Rocky
        npcID = 171246, -- Rocky
    },
    RubyDroplet = {
        itemID = 104159, -- Ruby Droplet
        npcID = 73356, -- Ruby Droplet
    },
    Scabby = {
        itemID = 163684, -- Scabby
        npcID = 143533, -- Scabby
    },
    ServantOfDemidos = {
        itemID = 119431, -- Servant of Demidos
        npcID = 88692, -- Servant of Demidos
    },
    SkunkyAlemental = {
        itemID = 104167, -- Skunky Alemental
        npcID = 73367, -- Skunky Alemental
    },
    SpineclawCrab = {
        itemID = 104168, -- Spineclaw Crab
        npcID = 73366, -- Spineclaw Crab
    },
    Squawkling = {
        itemID = 163712, -- Mana-Warped Egg
        npcID = 143628, -- Squawkling
    },
    StormborneWhelpling = {
        itemID = 129208, -- Stormborne Whelpling
        npcID = 97205, -- Stormborne Whelpling
    },
    SunreaverMicroSentry = {
        itemID = 94124, -- Sunreaver Micro-Sentry
        npcID = 69778, -- Sunreaver Micro-Sentry
    },
    TeenyTitanOrb = {
        itemID = 163677, -- Teeny Titan Orb
        npcID = 143515, -- Teeny Titan Orb
    },
    TinyShaleSpider = {
        itemID = 64494, -- Tiny Shale Spider
        npcID = 48982, -- Tiny Shale Spider
    },
    Uuna = {
        itemID = 153195, -- Uuna's Doll
        npcID = 128396, -- Uuna
    },
    Voidwiggler = {
        itemID = 163652, -- Tiny Grimoire
        npcID = 143507, -- Voidwiggler
    },
    Wriggler = {
        itemID = 169366, -- Wriggler
        npcID = 154839, -- Wriggler
    },
    ZandalariAnklerender = {
        itemID = 95422, -- Zandalari Anklerender
        npcID = 70451, -- Zandalari Anklerender
    },
    ZandalariFootslasher = {
        itemID = 95423, -- Zandalari Footslasher
        npcID = 70452, -- Zandalari Footslasher
    },
    ZandalariKneebiter = {
        itemID = 94126, -- Zandalari Kneebiter
        npcID = 69796, -- Zandalari Kneebiter
    },
    ZandalariToenibbler = {
        itemID = 95424, -- Zandalari Toenibbler
        npcID = 70453, -- Zandalari Toenibbler
    },
}

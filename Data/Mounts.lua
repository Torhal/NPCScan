--------------------------------------------------------------------------------
----  AddOn Namespace
--------------------------------------------------------------------------------

local AddOnFolderName = ... ---@type string
local private = select(2, ...) ---@class PrivateNamespace

--------------------------------------------------------------------------------
---- Constants
--------------------------------------------------------------------------------

private.Enum.Mount = {
    AcidBelcher = {
        itemID = 152904, -- Acid Belcher
        spellID = 253662, -- Acid Belcher
    },
    AmberPrimordialDirehorn = {
        itemID = 94230, -- Reins of the Amber Primordial Direhorn
        spellID = 138424, -- Amber Primordial Direhorn
    },
    ArborealGulper = {
        itemID = 182650, -- Arboreal Gulper
        spellID = 339632, -- Arboreal Gulper
    },
    ArmoredRazorback = {
        itemID = 116669, -- Armored Razorback
        spellID = 171630, -- Armored Razorback
    },
    AscendedSkymane = {
        itemID = 183741, -- Ascended Skymane
        spellID = 342335, -- Ascended Skymane
    },
    AshenvaleChimaera = {
        itemID = 166432, -- Ashenvale Chimaera
        spellID = 288495, -- Ashenvale Chimaera
    },
    BiletoothGnasher = {
        itemID = 152903, -- Biletooth Gnasher
        spellID = 253660, -- Biletooth Gnasher
    },
    BloodhoofBull = {
        itemID = 116659, -- Bloodhoof Bull
        spellID = 171620, -- Bloodhoof Bull
    },
    BrokenHighlandMustang = {
        itemID = 163578, -- Broken Highland Mustang
        spellID = 279457, -- Broken Highland Mustang
    },
    CobaltPrimordialDirehorn = {
        itemID = 94228, -- Reins of the Cobalt Primordial Direhorn
        spellID = 138423, -- Cobalt Primordial Direhorn
    },
    CrimsonSlavermaw = {
        itemID = 152905, -- Crimson Slavermaw
        spellID = 253661, -- Crimson Slavermaw
    },
    DarksporeManaRay = {
        itemID = 152843, -- Darkspore Mana Ray
        spellID = 235764, -- Darkspore Mana Ray
    },
    FelglowManaRay = {
        itemID = 152841, -- Felglow Mana Ray
        spellID = 253108, -- Felglow Mana Ray
    },
    FrightenedKodo = {
        itemID = 166433, -- Frightened Kodo
        spellID = 288499, -- Frightened Kodo
    },
    GarnNighthowl = {
        itemID = 116794, -- Garn Nighthowl
        spellID = 171851, -- Garn Nighthowl
    },
    Goldenmane = {
        itemID = 163573, -- Goldenmane's Reins
        spellID = 260175, -- Goldenmane
    },
    GreatGreytusk = {
        itemID = 116674, -- Great Greytusk
        spellID = 171636, -- Great Greytusk
    },
    HeavenlyOnyxCloudSerpent = {
        itemID = 87771, -- Reins of the Heavenly Onyx Cloud Serpent
        spellID = 127158, -- Heavenly Onyx Cloud Serpent
    },
    HighlandMustang = {
        itemID = 163579, -- Highland Mustang
        spellID = 279456, -- Highland Mustang
    },
    HorridDredwing = {
        itemID = 180461, -- Horrid Dredwing
        spellID = 332882, -- Horrid Dredwing
    },
    JadePrimordialDirehorn = {
        itemID = 94231, -- Reins of the Jade Primordial Direhorn
        spellID = 138426, -- Jade Primordial Direhorn
    },
    LambentManaRay = {
        itemID = 152844, -- Lambent Mana Ray
        spellID = 253107, -- Lambent Mana Ray
    },
    LeapingVeinseeker = {
        itemID = 163575, -- Reins of a Tamed Bloodfeaster
        spellID = 243795, -- Leaping Veinseeker
    },
    LilDonkey = {
        itemID = 163646, -- Lil' Donkey
        spellID = 279608, -- Lil' Donkey
    },
    MaddenedChaosrunner = {
        itemID = 152814, -- Maddened Chaosrunner
        spellID = 253058, -- Maddened Chaosrunner
    },
    Mollie = {
        itemID = 174842, -- Slightly Damp Pile of Fur
        spellID = 298367, -- Mollie
    },
    MottledMeadowstomper = {
        itemID = 116661, -- Mottled Meadowstomper
        spellID = 171622, -- Mottled Meadowstomper
    },
    SapphireRiverbeast = {
        itemID = 116767, -- Sapphire Riverbeast
        spellID = 171824, -- Sapphire Riverbeast
    },
    ScintillatingManaRay = {
        itemID = 152840, -- Scintillating Mana Ray
        spellID = 253109, -- Scintillating Mana Ray
    },
    Skullripper = {
        itemID = 163645, -- Skullripper
        spellID = 279611, -- Skullripper
    },
    SlatePrimordialDirehorn = {
        itemID = 94229, -- Reins of the Slate Primordial Direhorn
        spellID = 138425, -- Slate Primordial Direhorn
    },
    SonOfGalleon = {
        itemID = 89783, -- Son of Galleon's Saddle
        spellID = 130965, -- Son of Galleon
    },
    SpinemawGladechewer = {
        itemID = 180725, -- Spinemaw Gladechewer
        spellID = 334364, -- Spinemaw Gladechewer
    },
    Sundancer = {
        itemID = 180773, -- Sundancer
        spellID = 312765, -- Sundancer
    },
    SunhideGronnling = {
        itemID = 116792, -- Sunhide Gronnling
        spellID = 171849, -- Sunhide Gronnling
    },
    SwiftAlbinoRaptor = {
        itemID = 163644, -- Swift Albino Raptor
        spellID = 279569, -- Swift Albino Raptor
    },
    SwiftBreezestrider = {
        itemID = 116773, -- Swift Breezestrider
        spellID = 171830, -- Swift Breezestrider
    },
    SwiftGloomhoof = {
        itemID = 180728, -- Swift Gloomhoof
        spellID = 312767, -- Swift Gloomhoof
    },
    ThunderingCobaltCloudSerpent = {
        itemID = 95057, -- Reins of the Thundering Cobalt Cloud Serpent
        spellID = 139442, -- Thundering Cobalt Cloud Serpent
    },
    ThunderingOnyxCloudSerpent = {
        itemID = 104269, -- Reins of the Thundering Onyx Cloud Serpent
        spellID = 148476, -- Thundering Onyx Cloud Serpent
    },
    TundraIcehoof = {
        itemID = 116658, -- Tundra Icehoof
        spellID = 171619, -- Tundra Icehoof
    },
    VibrantManaRay = {
        itemID = 152842, -- Vibrant Mana Ray
        spellID = 253106, -- Vibrant Mana Ray
    },
    VileFiend = {
        itemID = 152790, -- Vile Fiend
        spellID = 243652, -- Vile Fiend
    },
    WarsongDirefang = {
        itemID = 116780, -- Warsong Direfang
        spellID = 171837, -- Warsong Direfang
    },
    WildGlimmerfurProwler = {
        itemID = 180730, -- Wild Glimmerfur Prowler
        spellID = 334366, -- Wild Glimmerfur Prowler
    },
    WitherbarkDirewing = {
        itemID = 163706, -- Witherbark Direwing
        spellID = 279868, -- Witherbark Direwing
    },
}

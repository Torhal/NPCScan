--------------------------------------------------------------------------------
---- AddOn Namespace
--------------------------------------------------------------------------------

local AddOnFolderName = ... ---@type string
local private = select(2, ...) ---@class PrivateNamespace

local NPCs = private.Data.NPCs
local NPCClassification = private.Enum.NPCClassification

--------------------------------------------------------------------------------
---- Ashran (588)
--------------------------------------------------------------------------------

NPCs[82876] = {
    --------------------------------------------------------------------------------
    ---- Grand Marshal Tremblade
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    factionGroup = "Alliance",
    npcID = 82876,
    vignetteID = 611,
}

NPCs[82877] = {
    --------------------------------------------------------------------------------
    ---- High Warlord Volrath
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    factionGroup = "Horde",
    npcID = 82877,
    vignetteID = 612,
}

NPCs[82878] = {
    --------------------------------------------------------------------------------
    ---- Marshal Gabriel
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    factionGroup = "Alliance",
    npcID = 82878,
}

NPCs[82880] = {
    --------------------------------------------------------------------------------
    ---- Marshal Karsh Stormforge
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    factionGroup = "Alliance",
    npcID = 82880,
}

NPCs[82882] = {
    --------------------------------------------------------------------------------
    ---- General Aevd
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    factionGroup = "Horde",
    npcID = 82882,
}

NPCs[82883] = {
    --------------------------------------------------------------------------------
    ---- Warlord Noktyn
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    factionGroup = "Horde",
    npcID = 82883,
}

NPCs[83683] = {
    --------------------------------------------------------------------------------
    ---- Mandragoraster
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 83683,
    vignetteID = 427,
}

NPCs[83691] = {
    --------------------------------------------------------------------------------
    ---- Panthora
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 83691,
    vignetteID = 486,
}

NPCs[83713] = {
    --------------------------------------------------------------------------------
    ---- Titarus
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 83713,
    vignetteID = 439,
}

NPCs[83819] = {
    --------------------------------------------------------------------------------
    ---- Brickhouse
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 83819,
    vignetteID = 445,
}

NPCs[84110] = {
    --------------------------------------------------------------------------------
    ---- Korthall Soulgorger
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 84110,
    vignetteID = 422,
}

NPCs[84196] = {
    --------------------------------------------------------------------------------
    ---- Web-wrapped Soldier
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 84196,
    vignetteID = 423,
}

NPCs[84465] = {
    --------------------------------------------------------------------------------
    ---- Leaping Gorger
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 84465,
    vignetteID = 430,
}

NPCs[84746] = {
    --------------------------------------------------------------------------------
    ---- Captured Gor'vosh Stoneshaper
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 84746,
    vignetteID = 440,
}

NPCs[84854] = {
    --------------------------------------------------------------------------------
    ---- Slippery Slime
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 84854,
    vignetteID = 450,
}

NPCs[84875] = {
    --------------------------------------------------------------------------------
    ---- Ancient Inferno
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 84875,
    vignetteID = 454,
}

NPCs[84893] = {
    --------------------------------------------------------------------------------
    ---- Goregore
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 84893,
    vignetteID = 455,
}

NPCs[84904] = {
    --------------------------------------------------------------------------------
    ---- Oraggro
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 84904,
    vignetteID = 456,
}

NPCs[84926] = {
    --------------------------------------------------------------------------------
    ---- Burning Power
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 84926,
    vignetteID = 458,
}

NPCs[85763] = {
    --------------------------------------------------------------------------------
    ---- Cursed Ravager
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 85763,
}

NPCs[85765] = {
    --------------------------------------------------------------------------------
    ---- Cursed Kaliri
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 85765,
}

NPCs[85766] = {
    --------------------------------------------------------------------------------
    ---- Cursed Sharptalon
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 85766,
}

NPCs[85767] = {
    --------------------------------------------------------------------------------
    ---- Cursed Harbinger
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 85767,
}

NPCs[85771] = {
    --------------------------------------------------------------------------------
    ---- Elder Darkweaver Kath
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 85771,
    vignetteID = 490,
}

NPCs[87362] = {
    --------------------------------------------------------------------------------
    ---- Gibby
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 87362,
}

NPCs[91921] = {
    --------------------------------------------------------------------------------
    ---- Wyrmple
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 91921,
    vignetteID = 972,
}

NPCs[94113] = {
    --------------------------------------------------------------------------------
    ---- Rukmaz
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 94113,
}

--------------------------------------------------------------------------------
---- Frostfire Ridge (525)
--------------------------------------------------------------------------------

NPCs[50992] = {
    --------------------------------------------------------------------------------
    ---- Gorok
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    mounts = {
        {
            itemID = 116674, -- Great Greytusk
            spellID = 171636, -- Great Greytusk
        },
    },
    npcID = 50992,
    vignetteID = 616,
}

NPCs[71665] = {
    --------------------------------------------------------------------------------
    ---- Giant-Slayer Kul
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 71665,
    questID = 32918, -- Vignette: Giant-Slayer Kul
    vignetteID = 194,
}

NPCs[71721] = {
    --------------------------------------------------------------------------------
    ---- Canyon Icemother
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 71721,
    questID = 32941, -- Vignette: Oasis Icemother
    vignetteID = 195,
}

NPCs[72156] = {
    --------------------------------------------------------------------------------
    ---- Borrok the Devourer
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 72156,
    questID = 33511, -- Unknown
    vignetteID = 202,
}

NPCs[72294] = {
    --------------------------------------------------------------------------------
    ---- Cindermaw
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 72294,
    questID = 33014, -- Vignette: Cindermaw
    vignetteID = 197,
}

NPCs[72364] = {
    --------------------------------------------------------------------------------
    ---- Gorg'ak the Lava Guzzler
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 72364,
    questID = 33512, -- Vignette: Lava-Gorged Goren
    vignetteID = 203,
}

NPCs[74613] = {
    --------------------------------------------------------------------------------
    ---- Broodmother Reeg'ak
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 74613,
    questID = 33843, -- Vignette: Broodmother Reeg'ak
    vignetteID = 255,
}

NPCs[74971] = {
    --------------------------------------------------------------------------------
    ---- Firefury Giant
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 74971,
    questID = 33504, -- Vignette: Shaman Fire Stone
    vignetteID = 201,
}

NPCs[75120] = {
    --------------------------------------------------------------------------------
    ---- Clumsy Cragmaul Brute
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 75120,
    questID = 33531, -- Unknown
}

NPCs[76914] = {
    --------------------------------------------------------------------------------
    ---- Coldtusk
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 76914,
    questID = 34131, -- Vignette: Coldtusk
    vignetteID = 227,
}

NPCs[76918] = {
    --------------------------------------------------------------------------------
    ---- Primalist Mur'og
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 76918,
    questID = 33938, -- Vignette: Ogre Primalist
    vignetteID = 214,
}

NPCs[77513] = {
    --------------------------------------------------------------------------------
    ---- Coldstomp the Griever
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 77513,
    questID = 34129, -- Vignette: Coldstomp
    vignetteID = 225,
}

NPCs[77519] = {
    --------------------------------------------------------------------------------
    ---- Giantbane
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 77519,
    vignetteID = 226,
}

NPCs[77526] = {
    --------------------------------------------------------------------------------
    ---- Scout Goreseeker
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 77526,
    questID = 34132, -- Vignette: Scout Goreseeker
    vignetteID = 228,
}

NPCs[77527] = {
    --------------------------------------------------------------------------------
    ---- The Beater
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 77527,
    questID = 34133, -- Vignette: The Beater
    vignetteID = 229,
}

NPCs[78128] = {
    --------------------------------------------------------------------------------
    ---- Gronnstalker Dawarn
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 78128,
    questID = 34130, -- Vignette: Giantstalker Hunting Party
    vignetteID = 226,
}

NPCs[78134] = {
    --------------------------------------------------------------------------------
    ---- Pathfinder Jalog
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 78134,
    questID = 34130, -- Vignette: Giantstalker Hunting Party
    vignetteID = 226,
}

NPCs[78144] = {
    --------------------------------------------------------------------------------
    ---- Giantslayer Kimla
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 78144,
    questID = 34130, -- Vignette: Giantstalker Hunting Party
    vignetteID = 226,
}

NPCs[78150] = {
    --------------------------------------------------------------------------------
    ---- Beastcarver Saramor
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 78150,
    questID = 34130, -- Vignette: Giantstalker Hunting Party
    vignetteID = 226,
}

NPCs[78151] = {
    --------------------------------------------------------------------------------
    ---- Huntmaster Kuang
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 78151,
    questID = 34130, -- Vignette: Giantstalker Hunting Party
    vignetteID = 226,
}

NPCs[78169] = {
    --------------------------------------------------------------------------------
    ---- Cloudspeaker Daber
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 78169,
    questID = 34130, -- Vignette: Giantstalker Hunting Party
    vignetteID = 226,
}

NPCs[78265] = {
    --------------------------------------------------------------------------------
    ---- The Bone Crawler
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 78265,
    questID = 34361, -- Vignette: The Bone Crawler
    vignetteID = 254,
}

NPCs[78606] = {
    --------------------------------------------------------------------------------
    ---- Pale Fishmonger
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 78606,
    questID = 34470, -- Vignette: Pale Gone Fishin'
    vignetteID = 259,
}

NPCs[78621] = {
    --------------------------------------------------------------------------------
    ---- Cyclonic Fury
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 78621,
    questID = 34477, -- Vignette: Cyclonic Fury
    vignetteID = 261,
}

NPCs[78867] = {
    --------------------------------------------------------------------------------
    ---- Breathless
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 78867,
    questID = 34497, -- Vignette: Breathless
    toys = {
        {
            itemID = 111476, -- Stolen Breath
        },
    },
    vignetteID = 285,
}

NPCs[79104] = {
    --------------------------------------------------------------------------------
    ---- Ug'lok the Frozen
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 79104,
    questID = 34522, -- Vignette: Ug'lok the Frozen
    vignetteID = 304,
}

NPCs[79145] = {
    --------------------------------------------------------------------------------
    ---- Yaga the Scarred
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 79145,
    questID = 34559, -- Vignette: Yaga the Scarred
    vignetteID = 306,
}

NPCs[79678] = {
    --------------------------------------------------------------------------------
    ---- Jehil the Climber
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 79678,
    questID = 34708, -- Unknown
    vignetteID = 317,
}

NPCs[80190] = {
    --------------------------------------------------------------------------------
    ---- Gruuk
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 80190,
    questID = 34825, -- Vignette: Gruuk
    vignetteID = 327,
}

NPCs[80235] = {
    --------------------------------------------------------------------------------
    ---- Gurun
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 80235,
    questID = 34839, -- Vignette: Skog
    vignetteID = 328,
}

NPCs[80242] = {
    --------------------------------------------------------------------------------
    ---- Chillfang
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 80242,
    questID = 34843, -- Vignette: Chillfang
    vignetteID = 330,
}

NPCs[80312] = {
    --------------------------------------------------------------------------------
    ---- Grutush the Pillager
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 80312,
    questID = 34865, -- Vignette: Skog
    vignetteID = 334,
}

NPCs[81001] = {
    --------------------------------------------------------------------------------
    ---- Nok-Karosh
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    mounts = {
        {
            itemID = 116794, -- Garn Nighthowl
            spellID = 171851, -- Garn Nighthowl
        },
    },
    npcID = 81001,
}

NPCs[82536] = {
    --------------------------------------------------------------------------------
    ---- Gorivax
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 82536,
    questID = 37388, -- Vignette: Gorivax
    vignetteID = 372,
}

NPCs[82614] = {
    --------------------------------------------------------------------------------
    ---- Moltnoma
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 82614,
    questID = 37387, -- Vignette: Moltnoma
    vignetteID = 371,
}

NPCs[82616] = {
    --------------------------------------------------------------------------------
    ---- Jabberjaw
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 82616,
    questID = 37386, -- Vignette: Jabberjaw
    vignetteID = 373,
}

NPCs[82617] = {
    --------------------------------------------------------------------------------
    ---- Slogtusk the Corpse-Eater
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 82617,
    questID = 37385, -- Vignette: Slogtusk the Corpse Eater
    vignetteID = 374,
}

NPCs[82618] = {
    --------------------------------------------------------------------------------
    ---- Tor'goroth
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 82618,
    questID = 37384, -- Vignette: Tor'goroth
    toys = {
        {
            itemID = 119163, -- Soul Inhaler
        },
    },
    vignetteID = 375,
}

NPCs[82620] = {
    --------------------------------------------------------------------------------
    ---- Son of Goramal
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 82620,
    questID = 37383, -- Vignette: Son of Goramal
    vignetteID = 376,
}

NPCs[84374] = {
    --------------------------------------------------------------------------------
    ---- Kaga the Ironbender
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 84374,
    questID = 37404, -- Vignette: Kaga the Ironbender
    vignetteID = 599,
}

NPCs[84376] = {
    --------------------------------------------------------------------------------
    ---- Earthshaker Holar
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 84376,
    questID = 37403, -- Vignette: Earthshaker Holar
    vignetteID = 600,
}

NPCs[84378] = {
    --------------------------------------------------------------------------------
    ---- Ak'ox the Slaughterer
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 84378,
    questID = 37525, -- Vignette: Ak'ox the Slaughterer
    vignetteID = 635,
}

NPCs[84392] = {
    --------------------------------------------------------------------------------
    ---- Ragore Driftstalker
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 84392,
    questID = 37401, -- Vignette: Ragore Driftstalker
    vignetteID = 604,
}

NPCs[87348] = {
    --------------------------------------------------------------------------------
    ---- Hoarfrost
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 87348,
    questID = 37382, -- Vignette: Hoarfrost
    vignetteID = 543,
}

NPCs[87351] = {
    --------------------------------------------------------------------------------
    ---- Mother of Goren
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 87351,
    questID = 37381, -- Vignette: Mother of Goren
    vignetteID = 545,
}

NPCs[87352] = {
    --------------------------------------------------------------------------------
    ---- Gibblette the Cowardly
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 87352,
    questID = 37380, -- Vignette: Giblette the Cowardly
    toys = {
        {
            itemID = 119180, -- Goren "Log" Roller
        },
    },
    vignetteID = 546,
}

NPCs[87356] = {
    --------------------------------------------------------------------------------
    ---- Vrok the Ancient
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 87356,
    questID = 37379, -- Vignette: Vrok the Ancient
    vignetteID = 547,
}

NPCs[87357] = {
    --------------------------------------------------------------------------------
    ---- Valkor
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 87357,
    questID = 37378, -- Vignette: Valkor
    vignetteID = 548,
}

NPCs[87600] = {
    --------------------------------------------------------------------------------
    ---- Jaluk the Pacifist
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 87600,
    questID = 37556, -- Vignette: Jaluk the Pacifist
    vignetteID = 601,
}

NPCs[87622] = {
    --------------------------------------------------------------------------------
    ---- Ogom the Mangler
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 87622,
    questID = 37402, -- Vignette: Ogom the Mangler
    vignetteID = 605,
}

NPCs[90041] = {
    --------------------------------------------------------------------------------
    ---- The Last Voidtalon
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 90041,
    questID = 37864, -- Unknown
}

--------------------------------------------------------------------------------
---- Frostwall (590)
--------------------------------------------------------------------------------

NPCs[96323] = {
    --------------------------------------------------------------------------------
    ---- Arachnis
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 96323,
    questID = 39617, -- Vignette Tracking Quest
    vignetteID = 1017,
}

--------------------------------------------------------------------------------
---- Frostwall Mine (585)
--------------------------------------------------------------------------------

NPCs[96323] = {
    --------------------------------------------------------------------------------
    ---- Arachnis
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 96323,
    questID = 39617, -- Vignette Tracking Quest
    vignetteID = 1017,
}

--------------------------------------------------------------------------------
---- Gorgrond (543)
--------------------------------------------------------------------------------

NPCs[50985] = {
    --------------------------------------------------------------------------------
    ---- Poundfist
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    mounts = {
        {
            itemID = 116792, -- Sunhide Gronnling
            spellID = 171849, -- Sunhide Gronnling
        },
    },
    npcID = 50985,
    vignetteID = 619,
}

NPCs[75207] = {
    --------------------------------------------------------------------------------
    ---- Biolante
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 75207,
}

NPCs[76473] = {
    --------------------------------------------------------------------------------
    ---- Mother Araneae
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 76473,
    questID = 34726, -- Vignette: Pale Spider Broodmother
    vignetteID = 336,
}

NPCs[77093] = {
    --------------------------------------------------------------------------------
    ---- Roardan the Sky Terror
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 77093,
    vignetteID = 247,
}

NPCs[78260] = {
    --------------------------------------------------------------------------------
    ---- King Slime
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 78260,
    questID = 37412, -- Vignette: King Slime
    vignetteID = 258,
}

NPCs[78269] = {
    --------------------------------------------------------------------------------
    ---- Gnarljaw
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 78269,
    questID = 37413, -- Vignette: Gnarljaw
    vignetteID = 257,
}

NPCs[79629] = {
    --------------------------------------------------------------------------------
    ---- Stomper Kreego
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 79629,
    questID = 35910, -- Vignette: Stomper Kreego
    toys = {
        {
            itemID = 118224, -- Ogre Brewing Kit
        },
    },
    vignetteID = 409,
}

NPCs[80371] = {
    --------------------------------------------------------------------------------
    ---- Typhon
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 80371,
    questID = 37405, -- Vignette: Typhon
    vignetteID = 592,
}

NPCs[80725] = {
    --------------------------------------------------------------------------------
    ---- Sulfurious
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 80725,
    questID = 36394, -- Sulfurious
    toys = {
        {
            itemID = 114227, -- Bubble Wand
        },
    },
    vignetteID = 340,
}

NPCs[80785] = {
    --------------------------------------------------------------------------------
    ---- Fungal Praetorian
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 80785,
    questID = 35153, -- Unknown
    vignetteID = 343,
}

NPCs[80868] = {
    --------------------------------------------------------------------------------
    ---- Glut
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 80868,
    questID = 36204, -- Vignette: Gorger the Hungry
    vignetteID = 434,
}

NPCs[81038] = {
    --------------------------------------------------------------------------------
    ---- Gelgor of the Blue Flame
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 81038,
    questID = 36391, -- The Blue Flame
    vignetteID = 468,
}

NPCs[81528] = {
    --------------------------------------------------------------------------------
    ---- Crater Lord Igneous
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 81528,
}

NPCs[81529] = {
    --------------------------------------------------------------------------------
    ---- Dessicus of the Dead Pools
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 81529,
}

NPCs[81537] = {
    --------------------------------------------------------------------------------
    ---- Khargax the Devourer
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 81537,
}

NPCs[81540] = {
    --------------------------------------------------------------------------------
    ---- Erosian the Violent
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 81540,
}

NPCs[81548] = {
    --------------------------------------------------------------------------------
    ---- Charl Doomwing
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 81548,
}

NPCs[82058] = {
    --------------------------------------------------------------------------------
    ---- Depthroot
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 82058,
    questID = 37370, -- Vignette: Depthroot
    vignetteID = 415,
}

NPCs[82085] = {
    --------------------------------------------------------------------------------
    ---- Bashiok
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 82085,
    questID = 35335, -- Vignette: Bashiok
    toys = {
        {
            itemID = 118222, -- Spirit of Bashiok
        },
    },
    vignetteID = 355,
}

NPCs[82311] = {
    --------------------------------------------------------------------------------
    ---- Char the Burning
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 82311,
    questID = 35503, -- Char the Burning
    vignetteID = 361,
}

NPCs[83522] = {
    --------------------------------------------------------------------------------
    ---- Hive Queen Skrikka
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 83522,
    questID = 35908, -- Vignette: Stoneshard Broodmother
    vignetteID = 406,
}

NPCs[84406] = {
    --------------------------------------------------------------------------------
    ---- Mandrakor
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 84406,
    pets = {
        {
            itemID = 118709, -- Doom Bloom
            npcID = 88103, -- Doom Bloom
        },
    },
    questID = 36178, -- Vignette: Mandrakor the Night Hunter
    vignetteID = 428,
}

NPCs[84431] = {
    --------------------------------------------------------------------------------
    ---- Greldrok the Cunning
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 84431,
    questID = 36186, -- Vignette: Greldrok the Cunning
    vignetteID = 429,
}

NPCs[85250] = {
    --------------------------------------------------------------------------------
    ---- Fossilwood the Petrified
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 85250,
    questID = 36387, -- Fossil the Petrified
    toys = {
        {
            itemID = 118221, -- Petrification Stone
        },
    },
    vignetteID = 467,
}

NPCs[85264] = {
    --------------------------------------------------------------------------------
    ---- Rolkor
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 85264,
    questID = 36393, -- Rolkor the Ironbreaker
    vignetteID = 469,
}

NPCs[85907] = {
    --------------------------------------------------------------------------------
    ---- Berthora
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 85907,
    questID = 36597, -- Vignette: Berthora
    vignetteID = 497,
}

NPCs[85970] = {
    --------------------------------------------------------------------------------
    ---- Riptar
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 85970,
    questID = 36600, -- Vignette: Riptar
    vignetteID = 498,
}

NPCs[86137] = {
    --------------------------------------------------------------------------------
    ---- Sunclaw
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 86137,
    questID = 36656, -- Vignette: Sunclaw
    vignetteID = 499,
}

NPCs[86257] = {
    --------------------------------------------------------------------------------
    ---- Basten
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 86257,
    questID = 37369, -- Vignette: Protectors of the Grove
    toys = {
        {
            itemID = 119432, -- Botani Camouflage
        },
    },
    vignetteID = 586,
}

NPCs[86258] = {
    --------------------------------------------------------------------------------
    ---- Nultra
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 86258,
    questID = 37369, -- Vignette: Protectors of the Grove
    vignetteID = 586,
}

NPCs[86259] = {
    --------------------------------------------------------------------------------
    ---- Valstil
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 86259,
    questID = 37369, -- Vignette: Protectors of the Grove
    vignetteID = 586,
}

NPCs[86266] = {
    --------------------------------------------------------------------------------
    ---- Venolasix
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 86266,
    questID = 37372, -- Vignette: Venolasix
    vignetteID = 596,
}

NPCs[86268] = {
    --------------------------------------------------------------------------------
    ---- Alkali
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 86268,
    questID = 37371, -- Vignette: Alkali
    vignetteID = 614,
}

NPCs[86410] = {
    --------------------------------------------------------------------------------
    ---- Sylldross
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 86410,
    questID = 36794, -- Vignette: Sylldross
    vignetteID = 510,
}

NPCs[86520] = {
    --------------------------------------------------------------------------------
    ---- Stompalupagus
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 86520,
    questID = 36837, -- Vignette: Stompalupagus
    vignetteID = 511,
}

NPCs[86562] = {
    --------------------------------------------------------------------------------
    ---- Maniacal Madgard
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 86562,
    questID = 37363, -- Vignette: Maniacal Madgard
    vignetteID = 514,
}

NPCs[86566] = {
    --------------------------------------------------------------------------------
    ---- Defector Dazgo
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 86566,
    questID = 37362, -- Vignette: Defector Dazgo
    vignetteID = 513,
}

NPCs[86571] = {
    --------------------------------------------------------------------------------
    ---- Durp the Hated
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 86571,
    questID = 37366, -- Vignette: Durp the Hated
    vignetteID = 517,
}

NPCs[86574] = {
    --------------------------------------------------------------------------------
    ---- Inventor Blammo
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 86574,
    questID = 37367, -- Vignette: Inventor Blammo
    vignetteID = 518,
}

NPCs[86577] = {
    --------------------------------------------------------------------------------
    ---- Horgg
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 86577,
    questID = 37365, -- Vignette: Horgg
    vignetteID = 516,
}

NPCs[86579] = {
    --------------------------------------------------------------------------------
    ---- Blademaster Ro'gor
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 86579,
    questID = 37368, -- Vignette: Blademaster Ro'gor
    vignetteID = 519,
}

NPCs[86582] = {
    --------------------------------------------------------------------------------
    ---- Morgo Kain
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 86582,
    questID = 37364, -- Vignette: Morgo Kain
    vignetteID = 515,
}

NPCs[88580] = {
    --------------------------------------------------------------------------------
    ---- Firestarter Grash
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 88580,
    questID = 37373, -- Vignette: Firestarter Grash
    vignetteID = 598,
}

NPCs[88582] = {
    --------------------------------------------------------------------------------
    ---- Swift Onyx Flayer
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 88582,
    questID = 37374, -- Vignette: Swift Onyx Flayer
    vignetteID = 595,
}

NPCs[88583] = {
    --------------------------------------------------------------------------------
    ---- Grove Warden Yal
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 88583,
    questID = 37375, -- Vignette: Grove Warden Yal
    vignetteID = 597,
}

NPCs[88586] = {
    --------------------------------------------------------------------------------
    ---- Mogamago
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 88586,
    questID = 37376, -- Vignette: Mogamago
    vignetteID = 613,
}

NPCs[88672] = {
    --------------------------------------------------------------------------------
    ---- Hunter Bal'ra
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 88672,
    questID = 37377, -- Vignette: Hunter Bal'ra
    vignetteID = 610,
}

NPCs[90041] = {
    --------------------------------------------------------------------------------
    ---- The Last Voidtalon
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 90041,
    questID = 37864, -- Unknown
}

--------------------------------------------------------------------------------
---- Lunarfall (582)
--------------------------------------------------------------------------------

NPCs[96323] = {
    --------------------------------------------------------------------------------
    ---- Arachnis
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 96323,
    questID = 39617, -- Vignette Tracking Quest
    vignetteID = 1017,
}

--------------------------------------------------------------------------------
---- Lunarfall Excavation (579)
--------------------------------------------------------------------------------

NPCs[96323] = {
    --------------------------------------------------------------------------------
    ---- Arachnis
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 96323,
    questID = 39617, -- Vignette Tracking Quest
    vignetteID = 1017,
}

--------------------------------------------------------------------------------
---- Nagrand (550)
--------------------------------------------------------------------------------

NPCs[50981] = {
    --------------------------------------------------------------------------------
    ---- Luk'hok
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    mounts = {
        {
            itemID = 116661, -- Mottled Meadowstomper
            spellID = 171622, -- Mottled Meadowstomper
        },
    },
    npcID = 50981,
    vignetteID = 620,
}

NPCs[50990] = {
    --------------------------------------------------------------------------------
    ---- Nakk the Thunderer
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    mounts = {
        {
            itemID = 116659, -- Bloodhoof Bull
            spellID = 171620, -- Bloodhoof Bull
        },
    },
    npcID = 50990,
    vignetteID = 618,
}

NPCs[78161] = {
    --------------------------------------------------------------------------------
    ---- Hyperious
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 78161,
    questID = 34862, -- Vignette: Light the Braziers
    vignetteID = 332,
}

NPCs[79024] = {
    --------------------------------------------------------------------------------
    ---- Warmaster Blugthol
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 79024,
    questID = 34645, -- Vignette: Warmaster Blugthol
    vignetteID = 310,
}

NPCs[79725] = {
    --------------------------------------------------------------------------------
    ---- Captain Ironbeard
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 79725,
    questID = 34727, -- Vignette: Sea Lord Torglork
    toys = {
        {
            itemID = 118244, -- Iron Buccaneer's Hat
        },
    },
    vignetteID = 318,
}

NPCs[80057] = {
    --------------------------------------------------------------------------------
    ---- Soulfang
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 80057,
    questID = 36128, -- Sabermaw - Saberon Vignette Boss
    vignetteID = 424,
}

NPCs[80122] = {
    --------------------------------------------------------------------------------
    ---- Gaz'orda
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 80122,
    questID = 34725, -- Vignette: Sea Hydra
    vignetteID = 339,
}

NPCs[80370] = {
    --------------------------------------------------------------------------------
    ---- Lernaea
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 80370,
    questID = 37408, -- Vignette: Lernaea
    vignetteID = 594,
}

NPCs[81330] = {
    --------------------------------------------------------------------------------
    ---- Warleader Tome
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 81330,
}

NPCs[82486] = {
    --------------------------------------------------------------------------------
    ---- Explorer Nozzand
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 82486,
    questID = 35623, -- Nagrand - Vignette Boss - Explorer Rixak
    vignetteID = 370,
}

NPCs[82755] = {
    --------------------------------------------------------------------------------
    ---- Redclaw the Feral
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 82755,
    questID = 35712, -- Nagrand - Vignette Boss 012 - Redclaw the Feral
    vignetteID = 381,
}

NPCs[82758] = {
    --------------------------------------------------------------------------------
    ---- Greatfeather
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 82758,
    questID = 35714, -- Nagrand - Vignette Boss 001 - Greatfeather
    vignetteID = 382,
}

NPCs[82764] = {
    --------------------------------------------------------------------------------
    ---- Gar'lua
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 82764,
    questID = 35715, -- Nagrand - Vignette Boss 002 - Gar'lua the Wolfmother
    vignetteID = 383,
}

NPCs[82778] = {
    --------------------------------------------------------------------------------
    ---- Gnarlhoof the Rabid
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 82778,
    questID = 35717, -- Nagrand - Vignette Boss 015 - Gnarlhoof the Rabid
    vignetteID = 384,
}

NPCs[82826] = {
    --------------------------------------------------------------------------------
    ---- Berserk T-300 Series Mark II
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 82826,
    questID = 35735, -- Nagrand - Vignette Boss 021 - Berserk Shredder
}

NPCs[82899] = {
    --------------------------------------------------------------------------------
    ---- Ancient Blademaster
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 82899,
    questID = 35778, -- Nagrand - Vignette Boss 020 - Ancient Blademaster - TSH
    vignetteID = 391,
}

NPCs[82912] = {
    --------------------------------------------------------------------------------
    ---- Grizzlemaw
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 82912,
    questID = 35784, -- Vignette Boss
    vignetteID = 392,
}

NPCs[82975] = {
    --------------------------------------------------------------------------------
    ---- Fangler
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 82975,
    questID = 35836, -- Nagrand - Vignette Boss 008 - The Lunker
}

NPCs[83401] = {
    --------------------------------------------------------------------------------
    ---- Netherspawn
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 83401,
    pets = {
        {
            itemID = 116815, -- Netherspawn, Spawn of Netherspawn
            npcID = 86081, -- Netherspawn, Spawn of Netherspawn
        },
    },
    questID = 35865, -- Nagrand - Vignette Boss 018 - Void Ooze
    vignetteID = 396,
}

NPCs[83409] = {
    --------------------------------------------------------------------------------
    ---- Ophiis
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 83409,
    questID = 35875, -- Nagrand - Vignette Boss 024 - Ophiis
    vignetteID = 397,
}

NPCs[83428] = {
    --------------------------------------------------------------------------------
    ---- Windcaller Korast
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 83428,
    questID = 35877, -- Nagrand - Vignette Boss 005 - Windcaller Korast
    vignetteID = 398,
}

NPCs[83483] = {
    --------------------------------------------------------------------------------
    ---- Flinthide
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 83483,
    questID = 35893, -- Nagrand - Vignette Boss 011 - Flinthide
    vignetteID = 401,
}

NPCs[83509] = {
    --------------------------------------------------------------------------------
    ---- Gorepetal
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 83509,
    questID = 35898, -- Nagrand - Vignette Boss 005 - Gorepetal
}

NPCs[83526] = {
    --------------------------------------------------------------------------------
    ---- Ru'klaa
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 83526,
    questID = 35900, -- Nagrand - Vignette Boss 013 - Ru'klaa
    vignetteID = 404,
}

NPCs[83542] = {
    --------------------------------------------------------------------------------
    ---- Sean Whitesea
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 83542,
    questID = 35912, -- Nagrand - Vignette Boss 017 - Swindler Whitesea
}

NPCs[83591] = {
    --------------------------------------------------------------------------------
    ---- Tura'aka
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 83591,
    questID = 35920, -- Nagrand - Vignette Boss 019 - Tura'aka
    vignetteID = 410,
}

NPCs[83603] = {
    --------------------------------------------------------------------------------
    ---- Hunter Blacktooth
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 83603,
    questID = 35923, -- Nagrand - Vignette Boss 006 - Hunter Blacktooth
    vignetteID = 411,
}

NPCs[83634] = {
    --------------------------------------------------------------------------------
    ---- Scout Pokhar
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 83634,
    questID = 35931, -- Nagrand - Vignette Boss 016 - Warsong Scout
    vignetteID = 412,
}

NPCs[83643] = {
    --------------------------------------------------------------------------------
    ---- Malroc Stonesunder
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 83643,
    questID = 35932, -- Nagrand - Vignette Boss 026 - Warsong Tactician
    vignetteID = 413,
}

NPCs[83680] = {
    --------------------------------------------------------------------------------
    ---- Outrider Duretha
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 83680,
    questID = 35943, -- Nagrand - Vignette Boss 026 - Duretha
    vignetteID = 414,
}

NPCs[84263] = {
    --------------------------------------------------------------------------------
    ---- Graveltooth
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 84263,
    questID = 36159, -- Nagrand - Vignette Boss 004 - Graveltooth
    vignetteID = 426,
}

NPCs[84435] = {
    --------------------------------------------------------------------------------
    ---- Mr. Pinchy Sr.
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 84435,
    questID = 36229, -- Nagrand - Vignette Boss - Mr. Pinchy Sr.
    vignetteID = 437,
}

NPCs[86729] = {
    --------------------------------------------------------------------------------
    ---- Direhoof
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 86729,
    questID = 37222, -- Direhoof's Hide
    vignetteID = 632,
}

NPCs[86732] = {
    --------------------------------------------------------------------------------
    ---- Bergruu
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 86732,
    questID = 37211, -- Bergruu's Horn
    vignetteID = 626,
}

NPCs[86743] = {
    --------------------------------------------------------------------------------
    ---- Dekorhan
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 86743,
    questID = 37221, -- Dekorhan's Tusk
    vignetteID = 627,
}

NPCs[86750] = {
    --------------------------------------------------------------------------------
    ---- Thek'talon
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 86750,
    questID = 37225, -- Thek'talon's Talon
    vignetteID = 629,
}

NPCs[86771] = {
    --------------------------------------------------------------------------------
    ---- Gagrog the Brutal
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 86771,
    questID = 37223, -- Gagrog's Skull
    vignetteID = 628,
}

NPCs[86774] = {
    --------------------------------------------------------------------------------
    ---- Aogexon
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 86774,
    questID = 37210, -- Aogexon's Fang
    vignetteID = 631,
}

NPCs[86835] = {
    --------------------------------------------------------------------------------
    ---- Xelganak
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 86835,
    questID = 37226, -- Xelganak's Stinger
    vignetteID = 633,
}

NPCs[86959] = {
    --------------------------------------------------------------------------------
    ---- Karosh Blackwind
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 86959,
    questID = 37399, -- Vignette: Karosh Blackwind
    vignetteID = 549,
}

NPCs[87234] = {
    --------------------------------------------------------------------------------
    ---- Brutag Grimblade
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 87234,
    questID = 37400, -- Vignette: Brutag Grimblade
    vignetteID = 550,
}

NPCs[87239] = {
    --------------------------------------------------------------------------------
    ---- Krahl Deadeye
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 87239,
    questID = 37473, -- Vignette: Krahl Deathwind
    vignetteID = 551,
}

NPCs[87344] = {
    --------------------------------------------------------------------------------
    ---- Gortag Steelgrip
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 87344,
    questID = 37472, -- Vignette: Gortag Steelgrip
    vignetteID = 552,
}

NPCs[87641] = {
    --------------------------------------------------------------------------------
    ---- Xelganak
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 87641,
}

NPCs[87647] = {
    --------------------------------------------------------------------------------
    ---- Aogexon
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 87647,
}

NPCs[87650] = {
    --------------------------------------------------------------------------------
    ---- Direhoof
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 87650,
}

NPCs[87653] = {
    --------------------------------------------------------------------------------
    ---- Vileclaw
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 87653,
}

NPCs[87655] = {
    --------------------------------------------------------------------------------
    ---- Thek'talon
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 87655,
}

NPCs[87660] = {
    --------------------------------------------------------------------------------
    ---- Dekorhan
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 87660,
}

NPCs[87661] = {
    --------------------------------------------------------------------------------
    ---- Bergruu
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 87661,
}

NPCs[87666] = {
    --------------------------------------------------------------------------------
    ---- Mu'gra
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 87666,
    questID = 37224, -- Mu'gra's Head
    vignetteID = 630,
}

NPCs[87667] = {
    --------------------------------------------------------------------------------
    ---- Mu'gra
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 87667,
}

NPCs[87788] = {
    --------------------------------------------------------------------------------
    ---- Durg Spinecrusher
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 87788,
    questID = 37395, -- Vignette: Durg Spinecrusher
    vignetteID = 560,
}

NPCs[87837] = {
    --------------------------------------------------------------------------------
    ---- Bonebreaker
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 87837,
    questID = 37396, -- Vignette: Bonebreaker
    vignetteID = 558,
}

NPCs[87846] = {
    --------------------------------------------------------------------------------
    ---- Pit Slayer
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 87846,
    questID = 37397, -- Vignette: Pit-Slayer
    vignetteID = 559,
}

NPCs[88208] = {
    --------------------------------------------------------------------------------
    ---- Pit Beast
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 88208,
    questID = 37637, -- Vignette: Pit Beast
    vignetteID = 583,
}

NPCs[88210] = {
    --------------------------------------------------------------------------------
    ---- Krud the Eviscerator
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 88210,
    questID = 37398, -- Vignette: Krud the Eviscerator
    vignetteID = 582,
}

NPCs[88951] = {
    --------------------------------------------------------------------------------
    ---- Vileclaw
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 88951,
    questID = 37520, -- Vileclaw's Claw
    vignetteID = 634,
}

NPCs[90041] = {
    --------------------------------------------------------------------------------
    ---- The Last Voidtalon
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 90041,
    questID = 37864, -- Unknown
}

NPCs[98198] = {
    --------------------------------------------------------------------------------
    ---- Rukdug
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 98198,
    pets = {
        {
            itemID = 129216, -- Vibrating Arcane Crystal
            npcID = 98236, -- Energized Manafiend
        },
    },
    questID = 40075, -- Rukdug
    vignetteID = 1068,
}

NPCs[98199] = {
    --------------------------------------------------------------------------------
    ---- Pugg
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 98199,
    pets = {
        {
            itemID = 129217, -- Warm Arcane Crystal
            npcID = 98237, -- Empowered Manafiend
        },
    },
    questID = 40073, -- Pugg
    vignetteID = 1066,
}

NPCs[98200] = {
    --------------------------------------------------------------------------------
    ---- Guk
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 98200,
    pets = {
        {
            itemID = 129218, -- Glittering Arcane Crystal
            npcID = 98238, -- Empyreal Manafiend
        },
    },
    questID = 40074, -- Guk
    vignetteID = 1067,
}

--------------------------------------------------------------------------------
---- Shadowmoon Valley (539)
--------------------------------------------------------------------------------

NPCs[50883] = {
    --------------------------------------------------------------------------------
    ---- Pathrunner
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    mounts = {
        {
            itemID = 116773, -- Swift Breezestrider
            spellID = 171830, -- Swift Breezestrider
        },
    },
    npcID = 50883,
    vignetteID = 621,
}

NPCs[72362] = {
    --------------------------------------------------------------------------------
    ---- Ku'targ the Voidseer
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 72362,
    questID = 33039, -- Vignette: The Voidseer
    vignetteID = 13,
}

NPCs[72537] = {
    --------------------------------------------------------------------------------
    ---- Leaf-Reader Kurri
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 72537,
    questID = 33055, -- Vignette: Foreling Worship Circle
    vignetteID = 23,
}

NPCs[72606] = {
    --------------------------------------------------------------------------------
    ---- Rockhoof
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 72606,
    questID = 34068, -- Vignette: Rockhoof
    vignetteID = 26,
}

NPCs[74206] = {
    --------------------------------------------------------------------------------
    ---- Killmaw
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 74206,
    questID = 33043, -- Vignette: Killmaw
    vignetteID = 217,
}

NPCs[75071] = {
    --------------------------------------------------------------------------------
    ---- Mother Om'ra
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 75071,
    questID = 33642, -- Vignette: Mother Om'ra
    vignetteID = 399,
}

NPCs[75434] = {
    --------------------------------------------------------------------------------
    ---- Windfang Matriarch
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 75434,
    questID = 33038, -- Vignette: Embaari Defense Crystal
    vignetteID = 16,
}

NPCs[75435] = {
    --------------------------------------------------------------------------------
    ---- Yggdrel
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 75435,
    questID = 33389, -- Vignette: Yggdrel the Corrupted
    toys = {
        {
            itemID = 113570, -- Ancient's Bloom
        },
    },
    vignetteID = 30,
}

NPCs[75482] = {
    --------------------------------------------------------------------------------
    ---- Veloss
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 75482,
    questID = 33640, -- Vignette: Veloss
    vignetteID = 205,
}

NPCs[75492] = {
    --------------------------------------------------------------------------------
    ---- Venomshade
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 75492,
    questID = 33643, -- Vignette: Venomshade (Plant Hydra)
    vignetteID = 207,
}

NPCs[76380] = {
    --------------------------------------------------------------------------------
    ---- Gorum
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 76380,
    questID = 33664, -- Vignette: Gorum
    vignetteID = 293,
}

NPCs[77085] = {
    --------------------------------------------------------------------------------
    ---- Dark Emanation
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 77085,
    questID = 33064, -- Vignette: Shadowmoon Cultist Ritual
    vignetteID = 215,
}

NPCs[77140] = {
    --------------------------------------------------------------------------------
    ---- Amaukwa
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 77140,
    questID = 33061, -- Vignette: Amaukwa
    vignetteID = 218,
}

NPCs[77310] = {
    --------------------------------------------------------------------------------
    ---- Mad "King" Sporeon
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 77310,
    questID = 35906, -- Vignette: Mad "King" Sporeon
    vignetteID = 405,
}

NPCs[79524] = {
    --------------------------------------------------------------------------------
    ---- Hypnocroak
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 79524,
    questID = 35558, -- Vignette: Hypnocroak
    toys = {
        {
            itemID = 113631, -- Hypnosis Goggles
        },
    },
    vignetteID = 482,
}

NPCs[79686] = {
    --------------------------------------------------------------------------------
    ---- Silverleaf Ancient
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 79686,
}

NPCs[79692] = {
    --------------------------------------------------------------------------------
    ---- Silverleaf Ancient
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 79692,
}

NPCs[79693] = {
    --------------------------------------------------------------------------------
    ---- Silverleaf Ancient
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 79693,
}

NPCs[81406] = {
    --------------------------------------------------------------------------------
    ---- Bahameye
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 81406,
    questID = 35281, -- Vignette: Bahameye
    vignetteID = 350,
}

NPCs[81639] = {
    --------------------------------------------------------------------------------
    ---- Brambleking Fili
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 81639,
    questID = 33383, -- Vignette: Brambleking Fili
    vignetteID = 349,
}

NPCs[82207] = {
    --------------------------------------------------------------------------------
    ---- Faebright
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 82207,
    questID = 35725, -- Vignette: Faebright
    vignetteID = 385,
}

NPCs[82268] = {
    --------------------------------------------------------------------------------
    ---- Darkmaster Go'vid
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 82268,
    questID = 35448, -- Vignette: Darkmaster Go'vid
    vignetteID = 358,
}

NPCs[82326] = {
    --------------------------------------------------------------------------------
    ---- Ba'ruun
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 82326,
    questID = 35731, -- Vignette: Ba'ruun
    toys = {
        {
            itemID = 113540, -- Ba'ruun's Bountiful Bloom
        },
    },
    vignetteID = 386,
}

NPCs[82362] = {
    --------------------------------------------------------------------------------
    ---- Morva Soultwister
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 82362,
    questID = 35523, -- Vignette: Morva Soultwister
    vignetteID = 362,
}

NPCs[82374] = {
    --------------------------------------------------------------------------------
    ---- Rai'vosh
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 82374,
    questID = 35553, -- Vignette: Rai'vosh
    toys = {
        {
            itemID = 113542, -- Whispers of Rai'Vosh
        },
    },
    vignetteID = 364,
}

NPCs[82411] = {
    --------------------------------------------------------------------------------
    ---- Darktalon
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 82411,
    questID = 35555, -- Vignette: Darktalon
    vignetteID = 365,
}

NPCs[82415] = {
    --------------------------------------------------------------------------------
    ---- Shinri
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 82415,
    questID = 35732, -- Vignette: Shinri
    toys = {
        {
            itemID = 113543, -- Spirit of Shinri
        },
    },
    vignetteID = 387,
}

NPCs[82676] = {
    --------------------------------------------------------------------------------
    ---- Enavra
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 82676,
    questID = 35688, -- Vignette: Enavra Varandi
    vignetteID = 378,
}

NPCs[82742] = {
    --------------------------------------------------------------------------------
    ---- Enavra
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 82742,
    questID = 35688, -- Vignette: Enavra Varandi
    vignetteID = 378,
}

NPCs[83385] = {
    --------------------------------------------------------------------------------
    ---- Voidseer Kalurg
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 83385,
    questID = 35847, -- Vignette: Voidseer Kalurg
    vignetteID = 394,
}

NPCs[83553] = {
    --------------------------------------------------------------------------------
    ---- Insha'tar
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 83553,
    questID = 35909, -- Vignette: Insha'tar
    vignetteID = 407,
}

NPCs[84911] = {
    --------------------------------------------------------------------------------
    ---- Demidos
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 84911,
    pets = {
        {
            itemID = 119431, -- Servant of Demidos
            npcID = 88692, -- Servant of Demidos
        },
    },
    questID = 37351, -- Vignette: Demidos
    vignetteID = 478,
}

NPCs[84925] = {
    --------------------------------------------------------------------------------
    ---- Quartermaster Hershak
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 84925,
    questID = 37352, -- Vignette: Quartermaster Hershak
    vignetteID = 476,
}

NPCs[85001] = {
    --------------------------------------------------------------------------------
    ---- Master Sergeant Milgra
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 85001,
    questID = 37353, -- Vignette: Master Sergeant Milgra
    vignetteID = 475,
}

NPCs[85029] = {
    --------------------------------------------------------------------------------
    ---- Shadowspeaker Niir
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 85029,
    questID = 37354, -- Vignette: Shadowspeaker Niir
    vignetteID = 479,
}

NPCs[85121] = {
    --------------------------------------------------------------------------------
    ---- Lady Temptessa
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 85121,
    questID = 37355, -- Vignette: Lady Temptessa
    vignetteID = 477,
}

NPCs[85451] = {
    --------------------------------------------------------------------------------
    ---- Malgosh Shadowkeeper
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 85451,
    questID = 37357, -- Vignette: Malgosh Shadowkeeper
    vignetteID = 492,
}

NPCs[85555] = {
    --------------------------------------------------------------------------------
    ---- Nagidna
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 85555,
    questID = 37409, -- Vignette: Nagidna
    vignetteID = 580,
}

NPCs[85568] = {
    --------------------------------------------------------------------------------
    ---- Avalanche
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 85568,
    questID = 37410, -- Vignette: Avalanche
    vignetteID = 581,
}

NPCs[85837] = {
    --------------------------------------------------------------------------------
    ---- Slivermaw
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 85837,
    questID = 37411, -- Vignette: Slivermaw
    vignetteID = 579,
}

NPCs[86213] = {
    --------------------------------------------------------------------------------
    ---- Aqualir
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 86213,
    questID = 37356, -- Vignette: Aqualir
    vignetteID = 500,
}

NPCs[86689] = {
    --------------------------------------------------------------------------------
    ---- Sneevel
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 86689,
    questID = 36880, -- Vignette: Sneevel
    vignetteID = 521,
}

NPCs[90041] = {
    --------------------------------------------------------------------------------
    ---- The Last Voidtalon
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 90041,
    questID = 37864, -- Unknown
}

--------------------------------------------------------------------------------
---- Spires of Arak (542)
--------------------------------------------------------------------------------

NPCs[79938] = {
    --------------------------------------------------------------------------------
    ---- Shadowbark
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 79938,
    questID = 36478, -- Spires - Vignette 020 - Shadowbark
    vignetteID = 484,
}

NPCs[80372] = {
    --------------------------------------------------------------------------------
    ---- Echidna
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 80372,
    questID = 37406, -- Vignette: Echidna
    vignetteID = 591,
}

NPCs[80614] = {
    --------------------------------------------------------------------------------
    ---- Blade-Dancer Aeryx
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 80614,
    questID = 35599, -- Vignette: Blade-Dancer Aeryx
    vignetteID = 369,
}

NPCs[82050] = {
    --------------------------------------------------------------------------------
    ---- Varasha
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 82050,
    questID = 35334, -- Vignette: The Egg of Varasha
    vignetteID = 356,
}

NPCs[82247] = {
    --------------------------------------------------------------------------------
    ---- Nas Dunberlin
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 82247,
    questID = 36129, -- Vignette: Nas Dunberlin
    vignetteID = 425,
}

NPCs[83746] = {
    --------------------------------------------------------------------------------
    ---- Rukhmar
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 83746,
    questID = 37464, -- Unknown
}

NPCs[83990] = {
    --------------------------------------------------------------------------------
    ---- Solar Magnifier
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 83990,
    questID = 37394, -- Vignette: Solar Magnifier
    vignetteID = 433,
}

NPCs[84417] = {
    --------------------------------------------------------------------------------
    ---- Mutafen
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 84417,
    questID = 36396, -- Spires - Vignette Boss - Mutafen
    vignetteID = 474,
}

NPCs[84775] = {
    --------------------------------------------------------------------------------
    ---- Tesska the Broken
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 84775,
    questID = 36254, -- Spires - Vignette Boss 002 - Tesska the Broken
    vignetteID = 441,
}

NPCs[84805] = {
    --------------------------------------------------------------------------------
    ---- Stonespite
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 84805,
    questID = 36265, -- Spires - Vignette Boss 001 - Stonespite
    vignetteID = 442,
}

NPCs[84807] = {
    --------------------------------------------------------------------------------
    ---- Durkath Steelmaw
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 84807,
    questID = 36267, -- Spires - Vignette 005 - Durkath Steelmaw
    vignetteID = 443,
}

NPCs[84810] = {
    --------------------------------------------------------------------------------
    ---- Kalos the Bloodbathed
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 84810,
    questID = 36268, -- Spires - Vignette Boss 007 - Kalos the Bloodbathed
    vignetteID = 444,
}

NPCs[84833] = {
    --------------------------------------------------------------------------------
    ---- Sangrikass
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 84833,
    questID = 36276, -- Spires - Vignette Boss 008 - Spawn of Sethe
    vignetteID = 654,
}

NPCs[84836] = {
    --------------------------------------------------------------------------------
    ---- Talonbreaker
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 84836,
    questID = 36278, -- Spires - Vignette Boss 009 - Talonbreaker
    vignetteID = 447,
}

NPCs[84838] = {
    --------------------------------------------------------------------------------
    ---- Poisonmaster Bortusk
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 84838,
    questID = 36279, -- Spires - Vignette 010 - Poisonmaster Bortusk
    vignetteID = 448,
}

NPCs[84856] = {
    --------------------------------------------------------------------------------
    ---- Blightglow
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 84856,
    questID = 36283, -- Spires - Vignette Boss 011 - Blightglow
    vignetteID = 448,
}

NPCs[84872] = {
    --------------------------------------------------------------------------------
    ---- Oskiira the Vengeful
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 84872,
    questID = 36288, -- Spires - Vignette Boss 012 - Oskiira
    vignetteID = 451,
}

NPCs[84887] = {
    --------------------------------------------------------------------------------
    ---- Betsi Boombasket
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 84887,
    questID = 36291, -- Spires - Vignette Boss 014 -  Betsi Boombasket
    vignetteID = 452,
}

NPCs[84890] = {
    --------------------------------------------------------------------------------
    ---- Festerbloom
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 84890,
    questID = 36297, -- Spires - Vignette Boss 016 - Festerbloom
    vignetteID = 453,
}

NPCs[84912] = {
    --------------------------------------------------------------------------------
    ---- Sunderthorn
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 84912,
    questID = 36298, -- Spires - Vignette Boss 017 - Sunderthorn
    vignetteID = 457,
}

NPCs[84951] = {
    --------------------------------------------------------------------------------
    ---- Gobblefin
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 84951,
    questID = 36305, -- Spires - Vignette Boss 023 - Gobblefin
    vignetteID = 462,
}

NPCs[84955] = {
    --------------------------------------------------------------------------------
    ---- Jiasska the Sporegorger
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 84955,
    questID = 36306, -- Spires - Vignette Boss 024 - Jiasska the Sporegorger
    vignetteID = 463,
}

NPCs[85026] = {
    --------------------------------------------------------------------------------
    ---- Soul-Twister Torek
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 85026,
    questID = 37358, -- Vignette: Soul-Twister Torek
    toys = {
        {
            itemID = 119178, -- Black Whirlwind
        },
    },
    vignetteID = 366,
}

NPCs[85036] = {
    --------------------------------------------------------------------------------
    ---- Formless Nightmare
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 85036,
    questID = 37360, -- Vignette: Formless Nightmare
    vignetteID = 493,
}

NPCs[85037] = {
    --------------------------------------------------------------------------------
    ---- Kenos the Unraveler
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 85037,
    questID = 37361, -- Vignette: Kenos the Unraveller
    vignetteID = 622,
}

NPCs[85078] = {
    --------------------------------------------------------------------------------
    ---- Voidreaver Urnae
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 85078,
    questID = 37359, -- Vignette: Voidreaver Urnae
    vignetteID = 494,
}

NPCs[85504] = {
    --------------------------------------------------------------------------------
    ---- Rotcap
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 85504,
    pets = {
        {
            itemID = 118107, -- Brilliant Spore
            npcID = 86719, -- Brilliant Spore
        },
    },
    questID = 36470, -- Spires - Vignette Boss 006 - Rotcap
    vignetteID = 602,
}

NPCs[85520] = {
    --------------------------------------------------------------------------------
    ---- Swarmleaf
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 85520,
    questID = 36472, -- Spires - Vignette Boss 028 - Wasp Ancient
    vignetteID = 483,
}

NPCs[86621] = {
    --------------------------------------------------------------------------------
    ---- Morphed Sentient
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 86621,
    questID = 37493, -- Vignette: Morphed Sentient
    vignetteID = 566,
}

NPCs[86724] = {
    --------------------------------------------------------------------------------
    ---- Hermit Palefur
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 86724,
    questID = 36887, -- Spires - Vignette 029 - Hermit Palefur
    vignetteID = 528,
}

NPCs[86978] = {
    --------------------------------------------------------------------------------
    ---- Gaze
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 86978,
    questID = 36943, -- Spires - Vignette 030 - Gaze
    vignetteID = 603,
}

NPCs[87019] = {
    --------------------------------------------------------------------------------
    ---- Gluttonous Giant
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 87019,
    questID = 37390, -- Vignette: Gluttonous Giant
    vignetteID = 567,
}

NPCs[87026] = {
    --------------------------------------------------------------------------------
    ---- Mecha Plunderer
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 87026,
    questID = 37391, -- Vignette: Mecha Plunderer
    vignetteID = 568,
}

NPCs[87027] = {
    --------------------------------------------------------------------------------
    ---- Shadow Hulk
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 87027,
    questID = 37392, -- Vignette: Shadow Hulk
    vignetteID = 570,
}

NPCs[87029] = {
    --------------------------------------------------------------------------------
    ---- Giga Sentinel
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 87029,
    questID = 37393, -- Vignette: Giga Sentinel
    vignetteID = 569,
}

NPCs[87493] = {
    --------------------------------------------------------------------------------
    ---- Rukhmar
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 87493,
    questID = 37464, -- Unknown
}

NPCs[90041] = {
    --------------------------------------------------------------------------------
    ---- The Last Voidtalon
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 90041,
    questID = 37864, -- Unknown
}

--------------------------------------------------------------------------------
---- Talador (535)
--------------------------------------------------------------------------------

NPCs[51015] = {
    --------------------------------------------------------------------------------
    ---- Silthide
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    mounts = {
        {
            itemID = 116767, -- Sapphire Riverbeast
            spellID = 171824, -- Sapphire Riverbeast
        },
    },
    npcID = 51015,
    vignetteID = 617,
}

NPCs[76876] = {
    --------------------------------------------------------------------------------
    ---- O'mogg Blackheart
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 76876,
    questID = 35219, -- Vignette: Burning Front
}

NPCs[77529] = {
    --------------------------------------------------------------------------------
    ---- Yazheera the Incinerator
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 77529,
    questID = 34135, -- Vignette: Yazheera the Incinerator
    vignetteID = 230,
}

NPCs[77561] = {
    --------------------------------------------------------------------------------
    ---- Dr. Gloom
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 77561,
    questID = 34142, -- Vignette: Dr. Gloom
    vignetteID = 231,
}

NPCs[77614] = {
    --------------------------------------------------------------------------------
    ---- Frenzied Golem
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 77614,
    questID = 34145, -- Vignette: Frenzied Animus
    vignetteID = 236,
}

NPCs[77620] = {
    --------------------------------------------------------------------------------
    ---- Cro Fleshrender
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 77620,
    questID = 34165, -- Vignette: Cro Fleshrender
    vignetteID = 237,
}

NPCs[77626] = {
    --------------------------------------------------------------------------------
    ---- Hen-Mother Hami
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 77626,
    questID = 34167, -- Vignette: Hen-Mother Hami
    vignetteID = 238,
}

NPCs[77634] = {
    --------------------------------------------------------------------------------
    ---- Taladorantula
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 77634,
    questID = 34171, -- Vignette: Taladorantula
}

NPCs[77664] = {
    --------------------------------------------------------------------------------
    ---- Aarko
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 77664,
    questID = 34182, -- Vignette: Aarkos - Looted Treasure
    vignetteID = 241,
}

NPCs[77715] = {
    --------------------------------------------------------------------------------
    ---- Hammertooth
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 77715,
    questID = 34185, -- Vignette: Hammertooth
    vignetteID = 242,
}

NPCs[77719] = {
    --------------------------------------------------------------------------------
    ---- Glimmerwing
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 77719,
    questID = 34189, -- Vignette: Glimmerwing
    toys = {
        {
            itemID = 116113, -- Breath of Talador
        },
    },
    vignetteID = 243,
}

NPCs[77741] = {
    --------------------------------------------------------------------------------
    ---- Ra'kahn
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 77741,
    questID = 34196, -- Vignette: Ra'kahn
    vignetteID = 245,
}

NPCs[77750] = {
    --------------------------------------------------------------------------------
    ---- Kaavu the Crimson Claw
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 77750,
    questID = 34199, -- Vignette: Anchorite's Sojourn
    vignetteID = 248,
}

NPCs[77776] = {
    --------------------------------------------------------------------------------
    ---- Wandering Vindicator
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 77776,
    questID = 34205, -- Vignette: Wandering Vindicator - Looted Treasure
    vignetteID = 249,
}

NPCs[77784] = {
    --------------------------------------------------------------------------------
    ---- Lo'marg Jawcrusher
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 77784,
    questID = 34208, -- Vignette: Lo'marg Jawcrusher
    vignetteID = 250,
}

NPCs[77795] = {
    --------------------------------------------------------------------------------
    ---- Echo of Murmur
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 77795,
    questID = 34221, -- Vignette: Echo of Murmur
    vignetteID = 251,
}

NPCs[77828] = {
    --------------------------------------------------------------------------------
    ---- Echo of Murmur
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 77828,
    questID = 34220, -- Vignette: Echo of Murmur
    toys = {
        {
            itemID = 113670, -- Mournful Moan of Murmur
        },
    },
    vignetteID = 251,
}

NPCs[78710] = {
    --------------------------------------------------------------------------------
    ---- Kharazos the Triumphant
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 78710,
    questID = 35219, -- Vignette: Burning Front
    toys = {
        {
            itemID = 116122, -- Burning Legion Missive
        },
    },
    vignetteID = 262,
}

NPCs[78713] = {
    --------------------------------------------------------------------------------
    ---- Galzomar
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 78713,
    questID = 35219, -- Vignette: Burning Front
    toys = {
        {
            itemID = 116122, -- Burning Legion Missive
        },
    },
    vignetteID = 263,
}

NPCs[78715] = {
    --------------------------------------------------------------------------------
    ---- Sikthiss, Maiden of Slaughter
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 78715,
    questID = 35219, -- Vignette: Burning Front
    toys = {
        {
            itemID = 116122, -- Burning Legion Missive
        },
    },
    vignetteID = 346,
}

NPCs[78872] = {
    --------------------------------------------------------------------------------
    ---- Klikixx
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 78872,
    questID = 34498, -- Vignette: Klikixx
    toys = {
        {
            itemID = 116125, -- Klikixx's Webspinner
        },
    },
    vignetteID = 286,
}

NPCs[79334] = {
    --------------------------------------------------------------------------------
    ---- No'losh
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 79334,
    questID = 34859, -- Vignette: No'losh
    vignetteID = 331,
}

NPCs[79485] = {
    --------------------------------------------------------------------------------
    ---- Talonpriest Zorkra
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 79485,
    questID = 34668, -- Vignette: Talonpriest Zorkra
    vignetteID = 313,
}

NPCs[79543] = {
    --------------------------------------------------------------------------------
    ---- Shirzir
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 79543,
    questID = 34671, -- Vignette: Shirzir
    vignetteID = 314,
}

NPCs[80204] = {
    --------------------------------------------------------------------------------
    ---- Felbark
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 80204,
    questID = 35018, -- Vignette: Felbark
    vignetteID = 341,
}

NPCs[80471] = {
    --------------------------------------------------------------------------------
    ---- Gennadian
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 80471,
    questID = 34929, -- Vignette: Gennadian
    vignetteID = 335,
}

NPCs[80524] = {
    --------------------------------------------------------------------------------
    ---- Underseer Bloodmane
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 80524,
    questID = 34945, -- Tracking Flag - Underseer Bloodmane Vignette
    vignetteID = 337,
}

NPCs[80785] = {
    --------------------------------------------------------------------------------
    ---- Fungal Praetorian
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 80785,
    questID = 35153, -- Unknown
    vignetteID = 343,
}

NPCs[82920] = {
    --------------------------------------------------------------------------------
    ---- Lord Korinak
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 82920,
    questID = 37345, -- Vignette: Lord Korinak
    vignetteID = 571,
}

NPCs[82922] = {
    --------------------------------------------------------------------------------
    ---- Xothear, the Destroyer
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 82922,
    questID = 37343, -- Vignette: Xothear, The Destroyer
    vignetteID = 589,
}

NPCs[82930] = {
    --------------------------------------------------------------------------------
    ---- Shadowflame Terrorwalker
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 82930,
    questID = 37347, -- Vignette: Shadowflame Terror
    vignetteID = 576,
}

NPCs[82942] = {
    --------------------------------------------------------------------------------
    ---- Lady Demlash
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 82942,
    questID = 37346, -- Vignette: Lady Demlash
    vignetteID = 575,
}

NPCs[82988] = {
    --------------------------------------------------------------------------------
    ---- Kurlosh Doomfang
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 82988,
    questID = 37348, -- Vignette: Kurlosh Doomfang
    vignetteID = 574,
}

NPCs[82992] = {
    --------------------------------------------------------------------------------
    ---- Felfire Consort
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 82992,
    questID = 37341, -- Vignette: Felfire Consort
    vignetteID = 564,
}

NPCs[82998] = {
    --------------------------------------------------------------------------------
    ---- Matron of Sin
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 82998,
    questID = 37349, -- Vignette: Matron of Sin
    vignetteID = 573,
}

NPCs[83008] = {
    --------------------------------------------------------------------------------
    ---- Haakun the All-Consuming
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 83008,
    questID = 37312, -- Vignette: Haakun, The All-Consuming
    vignetteID = 562,
}

NPCs[83019] = {
    --------------------------------------------------------------------------------
    ---- Gug'tol
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 83019,
    questID = 37340, -- Vignette: Gug'tol
    vignetteID = 563,
}

NPCs[85572] = {
    --------------------------------------------------------------------------------
    ---- Grrbrrgle
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 85572,
    questID = 36919, -- Talador - Shore Vignette - Murloc Boss
}

NPCs[86549] = {
    --------------------------------------------------------------------------------
    ---- Steeltusk
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 86549,
    questID = 36858, -- Vignette: Steeltusk
    vignetteID = 512,
}

NPCs[87597] = {
    --------------------------------------------------------------------------------
    ---- Bombardier Gu'gok
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 87597,
    questID = 37339, -- Vignette: Bombardier Gu'gok
    vignetteID = 554,
}

NPCs[87668] = {
    --------------------------------------------------------------------------------
    ---- Orumo the Observer
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 87668,
    pets = {
        {
            itemID = 119170, -- Eye of Observation
            npcID = 88490, -- Eye of Observation
        },
    },
    questID = 37344, -- Vignette: Orumo the Observer
    vignetteID = 572,
}

NPCs[88043] = {
    --------------------------------------------------------------------------------
    ---- Avatar of Socrethar
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 88043,
    questID = 37338, -- Vignette: Avatar of Sothrecar
    vignetteID = 561,
}

NPCs[88071] = {
    --------------------------------------------------------------------------------
    ---- Strategist Ankor
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 88071,
    questID = 37337, -- Vignette: Strategist Ankor
    vignetteID = 565,
}

NPCs[88072] = {
    --------------------------------------------------------------------------------
    ---- Archmagus Tekar
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 88072,
    questID = 37337, -- Vignette: Strategist Ankor
    vignetteID = 565,
}

NPCs[88083] = {
    --------------------------------------------------------------------------------
    ---- Soulbinder Naylana
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 88083,
    questID = 37337, -- Vignette: Strategist Ankor
    vignetteID = 565,
}

NPCs[88436] = {
    --------------------------------------------------------------------------------
    ---- Vigilant Paarthos
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 88436,
    questID = 37350, -- Vignette: Vigilant Paarthos
    vignetteID = 588,
}

NPCs[88494] = {
    --------------------------------------------------------------------------------
    ---- Legion Vanguard
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 88494,
    questID = 37342, -- Vignette: Legion Vanguard
    vignetteID = 590,
}

NPCs[90041] = {
    --------------------------------------------------------------------------------
    ---- The Last Voidtalon
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 90041,
    questID = 37864, -- Unknown
}

--------------------------------------------------------------------------------
---- Tanaan Jungle (534)
--------------------------------------------------------------------------------

NPCs[80398] = {
    --------------------------------------------------------------------------------
    ---- Keravnos
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 80398,
    questID = 37407, -- Vignette: Keravnos
    vignetteID = 593,
}

NPCs[89675] = {
    --------------------------------------------------------------------------------
    ---- Commander Org'mok
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 89675,
    questID = 38749, -- Vignette: Commander Org'mok
    vignetteID = 858,
}

NPCs[90024] = {
    --------------------------------------------------------------------------------
    ---- Sergeant Mor'grak
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 90024,
    questID = 37953, -- Vignette: Sergeant Mor'grak
    vignetteID = 696,
}

NPCs[90094] = {
    --------------------------------------------------------------------------------
    ---- Harbormaster Korak
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 90094,
    questID = 39046, -- Vignette: Harbormaster Korak
    vignetteID = 687,
}

NPCs[90122] = {
    --------------------------------------------------------------------------------
    ---- Zoug the Heavy
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 90122,
    questID = 39045, -- Vignette: Zoug
    vignetteID = 688,
}

NPCs[90429] = {
    --------------------------------------------------------------------------------
    ---- Imp-Master Valessa
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 90429,
    questID = 38026, -- Vignette: Imp-Master Valessa
    toys = {
        {
            itemID = 127655, -- Sassy Imp
        },
    },
    vignetteID = 700,
}

NPCs[90434] = {
    --------------------------------------------------------------------------------
    ---- Ceraxas
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 90434,
    questID = 38031, -- Vignette: Ceraxas
    vignetteID = 704,
}

NPCs[90437] = {
    --------------------------------------------------------------------------------
    ---- Jax'zor
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 90437,
    questID = 38030, -- Vignette: Houndmaster Jax'zor
    vignetteID = 703,
}

NPCs[90438] = {
    --------------------------------------------------------------------------------
    ---- Lady Oran
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 90438,
    questID = 38029, -- Vignette: Lady Oran
    vignetteID = 702,
}

NPCs[90442] = {
    --------------------------------------------------------------------------------
    ---- Mistress Thavra
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 90442,
    questID = 38032, -- Vignette: Mistress Thavra
    vignetteID = 705,
}

NPCs[90519] = {
    --------------------------------------------------------------------------------
    ---- Cindral the Wildfire
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 90519,
    questID = 37990, -- Vignette: Cindral
    vignetteID = 698,
}

NPCs[90777] = {
    --------------------------------------------------------------------------------
    ---- High Priest Ikzan
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 90777,
    questID = 38028, -- Vignette: High Priest Ikzan
    toys = {
        {
            itemID = 122117, -- Cursed Feather of Ikzan
        },
    },
    vignetteID = 701,
}

NPCs[90782] = {
    --------------------------------------------------------------------------------
    ---- Rasthe
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 90782,
    questID = 38034, -- Vignette: Rasthe
    vignetteID = 706,
}

NPCs[90884] = {
    --------------------------------------------------------------------------------
    ---- Bilkor the Thrower
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 90884,
    questID = 38262, -- Vignette: Bilkor the Thrower
    vignetteID = 725,
}

NPCs[90885] = {
    --------------------------------------------------------------------------------
    ---- Rogond the Tracker
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 90885,
    questID = 38263, -- Vignette: Rogond
    vignetteID = 726,
}

NPCs[90887] = {
    --------------------------------------------------------------------------------
    ---- Dorg the Bloody
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 90887,
    questID = 38265, -- Vignette: Dorg
    vignetteID = 728,
}

NPCs[90888] = {
    --------------------------------------------------------------------------------
    ---- Drivnul
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 90888,
    questID = 38264, -- Vignette: Drivnul
    vignetteID = 727,
}

NPCs[90936] = {
    --------------------------------------------------------------------------------
    ---- Bloodhunter Zulk
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 90936,
    questID = 38266, -- Vignette: Zulk
    vignetteID = 729,
}

NPCs[91009] = {
    --------------------------------------------------------------------------------
    ---- Putre'thar
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 91009,
    questID = 38457, -- Vignette: Putre'thar
    vignetteID = 772,
}

NPCs[91087] = {
    --------------------------------------------------------------------------------
    ---- Zeter'el
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 91087,
    questID = 38207, -- Vignette: Zeter'el
    vignetteID = 717,
}

NPCs[91093] = {
    --------------------------------------------------------------------------------
    ---- Bramblefell
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 91093,
    questID = 38209, -- Vignette: Bramblefell
    toys = {
        {
            itemID = 127652, -- Felflame Campfire
        },
    },
    vignetteID = 718,
}

NPCs[91098] = {
    --------------------------------------------------------------------------------
    ---- Felspark
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 91098,
    questID = 38211, -- Vignette: Felspark
    vignetteID = 719,
}

NPCs[91227] = {
    --------------------------------------------------------------------------------
    ---- Remnant of the Blood Moon
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 91227,
    questID = 39159, -- Vignette: Blood Moon Boss
    toys = {
        {
            itemID = 127666, -- Vial of Red Goo
        },
    },
    vignetteID = 730,
}

NPCs[91232] = {
    --------------------------------------------------------------------------------
    ---- Commander Krag'goth
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 91232,
    questID = 38746, -- Vignette: Iron Front Captain 1
    vignetteID = 856,
}

NPCs[91243] = {
    --------------------------------------------------------------------------------
    ---- Tho'gar Gorefist
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 91243,
    questID = 38747, -- Vignette: Iron Front Captain 2
    vignetteID = 857,
}

NPCs[91374] = {
    --------------------------------------------------------------------------------
    ---- Podlord Wakkawam
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 91374,
    questID = 38282, -- Vignette: Wakkawam
    vignetteID = 734,
}

NPCs[91695] = {
    --------------------------------------------------------------------------------
    ---- Grand Warlock Nethekurse
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 91695,
    questID = 38400, -- Vignette: Grand Warlock Nethekurse
    vignetteID = 758,
}

NPCs[91727] = {
    --------------------------------------------------------------------------------
    ---- Executor Riloth
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 91727,
    questID = 38411, -- Vignette: Executor Riloth
    vignetteID = 759,
}

NPCs[91871] = {
    --------------------------------------------------------------------------------
    ---- Argosh the Destroyer
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 91871,
    questID = 38430, -- Vignette: Argosh the Destroyer
    vignetteID = 768,
}

NPCs[92197] = {
    --------------------------------------------------------------------------------
    ---- Relgor
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 92197,
    questID = 38496, -- Vignette: BH Master Scout
    vignetteID = 798,
}

NPCs[92274] = {
    --------------------------------------------------------------------------------
    ---- Painmistress Selora
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 92274,
    questID = 38557, -- Vignette: Invasion Point: Devastation
    vignetteID = 813,
}

NPCs[92408] = {
    --------------------------------------------------------------------------------
    ---- Xanzith the Everlasting
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 92408,
    questID = 38579, -- Vignette: Xanzith the Everlasting
    vignetteID = 815,
}

NPCs[92411] = {
    --------------------------------------------------------------------------------
    ---- Overlord Ma'gruth
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 92411,
    questID = 38580, -- Vignette: Overlord Ma'gruth
    vignetteID = 816,
}

NPCs[92429] = {
    --------------------------------------------------------------------------------
    ---- Broodlord Ixkor
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 92429,
    questID = 38589, -- Vignette: Ravager Broodlord
    vignetteID = 817,
}

NPCs[92451] = {
    --------------------------------------------------------------------------------
    ---- Varyx the Damned
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 92451,
    questID = 37937, -- Vignette: Varyx the Damned
    vignetteID = 695,
}

NPCs[92465] = {
    --------------------------------------------------------------------------------
    ---- The Blackfang
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 92465,
    questID = 38597, -- Vignette: Panther Saberon Boss
    vignetteID = 818,
}

NPCs[92495] = {
    --------------------------------------------------------------------------------
    ---- Soulslicer
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 92495,
    questID = 38600, -- Vignette: Fel Saberon Shaman
    vignetteID = 819,
}

NPCs[92508] = {
    --------------------------------------------------------------------------------
    ---- Gloomtalon
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 92508,
    questID = 38604, -- Vignette: Saberon Shaman
    vignetteID = 820,
}

NPCs[92517] = {
    --------------------------------------------------------------------------------
    ---- Krell the Serene
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 92517,
    questID = 38605, -- Vignette: Saberon Blademaster
    vignetteID = 821,
}

NPCs[92552] = {
    --------------------------------------------------------------------------------
    ---- Belgork
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 92552,
    questID = 38609, -- Vignette: Iron Tunnel Foreman
    vignetteID = 822,
}

NPCs[92574] = {
    --------------------------------------------------------------------------------
    ---- Thromma the Gutslicer
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 92574,
    questID = 38620, -- Vignette: Pale Assassin
    vignetteID = 823,
}

NPCs[92606] = {
    --------------------------------------------------------------------------------
    ---- Sylissa
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 92606,
    questID = 38628, -- Vignette: Giant Python
    vignetteID = 827,
}

NPCs[92627] = {
    --------------------------------------------------------------------------------
    ---- Rendrak
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 92627,
    questID = 38631, -- Vignette: Alpha Bat
    vignetteID = 829,
}

NPCs[92636] = {
    --------------------------------------------------------------------------------
    ---- The Night Haunter
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 92636,
    questID = 38632, -- Vignette: Night Haunter
    toys = {
        {
            itemID = 127652, -- Felflame Campfire
        },
    },
    vignetteID = 830,
}

NPCs[92645] = {
    --------------------------------------------------------------------------------
    ---- The Night Haunter
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 92645,
    questID = 38632, -- Vignette: Night Haunter
    vignetteID = 830,
}

NPCs[92647] = {
    --------------------------------------------------------------------------------
    ---- Felsmith Damorka
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 92647,
    questID = 38634, -- Vignette: Felsmith Damorka
    vignetteID = 831,
}

NPCs[92657] = {
    --------------------------------------------------------------------------------
    ---- Bleeding Hollow Horror
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 92657,
    questID = 38696, -- Vignette: Bleeding Hollow Horror
    vignetteID = 841,
}

NPCs[92694] = {
    --------------------------------------------------------------------------------
    ---- The Goreclaw
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 92694,
    questID = 38654, -- Vignette: Giant Raptor
    vignetteID = 834,
}

NPCs[92766] = {
    --------------------------------------------------------------------------------
    ---- Akrrilo
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 92766,
}

NPCs[92817] = {
    --------------------------------------------------------------------------------
    ---- Rendarr
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 92817,
}

NPCs[92819] = {
    --------------------------------------------------------------------------------
    ---- Eyepiercer
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 92819,
}

NPCs[92887] = {
    --------------------------------------------------------------------------------
    ---- Steelsnout
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 92887,
    questID = 38700, -- Vignette: Steelsnout
    vignetteID = 842,
}

NPCs[92941] = {
    --------------------------------------------------------------------------------
    ---- Gorabosh
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 92941,
    questID = 38709, -- Vignette: Cave Keeper
    vignetteID = 846,
}

NPCs[92977] = {
    --------------------------------------------------------------------------------
    ---- The Iron Houndmaster
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 92977,
    questID = 38751, -- Vignette: Iron Houndmaster
    vignetteID = 860,
}

NPCs[93001] = {
    --------------------------------------------------------------------------------
    ---- Szirek the Twisted
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 93001,
    questID = 38752, -- Vignette: Szirek
    vignetteID = 861,
}

NPCs[93002] = {
    --------------------------------------------------------------------------------
    ---- Magwia
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 93002,
    questID = 38726, -- Vignette: Magwia
    vignetteID = 850,
}

NPCs[93028] = {
    --------------------------------------------------------------------------------
    ---- Driss Vile
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 93028,
    questID = 38736, -- Vignette: IH Elite Sniper
    vignetteID = 853,
}

NPCs[93057] = {
    --------------------------------------------------------------------------------
    ---- Grannok
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 93057,
    questID = 38750, -- Vignette: Iron Front Captain 3
    vignetteID = 859,
}

NPCs[93076] = {
    --------------------------------------------------------------------------------
    ---- Captain Ironbeard
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 93076,
    questID = 38756, -- Vignette: Dead Orc Captain
    toys = {
        {
            itemID = 127659, -- Ghostly Iron Buccaneer's Hat
        },
    },
    vignetteID = 862,
}

NPCs[93125] = {
    --------------------------------------------------------------------------------
    ---- Glub'glok
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 93125,
    questID = 38764, -- Vignette: Murktide Alpha
    vignetteID = 864,
}

NPCs[93168] = {
    --------------------------------------------------------------------------------
    ---- Felbore
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 93168,
    questID = 38775, -- Felbore
    vignetteID = 868,
}

NPCs[93236] = {
    --------------------------------------------------------------------------------
    ---- Shadowthrash
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 93236,
    questID = 38812, -- Vignette: Shadowthrash
    vignetteID = 873,
}

NPCs[93264] = {
    --------------------------------------------------------------------------------
    ---- Captain Grok'mar
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 93264,
    questID = 38820, -- Vignette: Captain Grok'mar
    vignetteID = 874,
}

NPCs[93279] = {
    --------------------------------------------------------------------------------
    ---- Kris'kar the Unredeemed
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 93279,
    questID = 38825, -- Blazing Crusader
    vignetteID = 875,
}

NPCs[95044] = {
    --------------------------------------------------------------------------------
    ---- Terrorfist
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    mounts = {
        {
            itemID = 116658, -- Tundra Icehoof
            spellID = 171619, -- Tundra Icehoof
        },
        {
            itemID = 116669, -- Armored Razorback
            spellID = 171630, -- Armored Razorback
        },
        {
            itemID = 116780, -- Warsong Direfang
            spellID = 171837, -- Warsong Direfang
        },
    },
    npcID = 95044,
    questID = 39288, -- Terrorfist
    vignetteID = 956,
}

NPCs[95053] = {
    --------------------------------------------------------------------------------
    ---- Deathtalon
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    mounts = {
        {
            itemID = 116658, -- Tundra Icehoof
            spellID = 171619, -- Tundra Icehoof
        },
        {
            itemID = 116669, -- Armored Razorback
            spellID = 171630, -- Armored Razorback
        },
        {
            itemID = 116780, -- Warsong Direfang
            spellID = 171837, -- Warsong Direfang
        },
    },
    npcID = 95053,
    questID = 39287, -- Deathtalon
    vignetteID = 959,
}

NPCs[95054] = {
    --------------------------------------------------------------------------------
    ---- Vengeance
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    mounts = {
        {
            itemID = 116658, -- Tundra Icehoof
            spellID = 171619, -- Tundra Icehoof
        },
        {
            itemID = 116669, -- Armored Razorback
            spellID = 171630, -- Armored Razorback
        },
        {
            itemID = 116780, -- Warsong Direfang
            spellID = 171837, -- Warsong Direfang
        },
    },
    npcID = 95054,
    questID = 39290, -- Vengeance
    vignetteID = 958,
}

NPCs[95056] = {
    --------------------------------------------------------------------------------
    ---- Doomroller
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    mounts = {
        {
            itemID = 116658, -- Tundra Icehoof
            spellID = 171619, -- Tundra Icehoof
        },
        {
            itemID = 116669, -- Armored Razorback
            spellID = 171630, -- Armored Razorback
        },
        {
            itemID = 116780, -- Warsong Direfang
            spellID = 171837, -- Warsong Direfang
        },
    },
    npcID = 95056,
    questID = 39289, -- Doomroller
    vignetteID = 957,
}

NPCs[96235] = {
    --------------------------------------------------------------------------------
    ---- Xemirkol
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 96235,
}

NPCs[98283] = {
    --------------------------------------------------------------------------------
    ---- Drakum
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 98283,
    questID = 40105, -- Drakum
    toys = {
        {
            itemID = 108631, -- Crashin' Thrashin' Roller Controller
        },
    },
    vignetteID = 1090,
}

NPCs[98284] = {
    --------------------------------------------------------------------------------
    ---- Gondar
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 98284,
    questID = 40106, -- Gondar
    toys = {
        {
            itemID = 108633, -- Crashin' Thrashin' Cannon Controller
        },
    },
    vignetteID = 1089,
}

NPCs[98285] = {
    --------------------------------------------------------------------------------
    ---- Smashum Grabb
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 98285,
    questID = 40104, -- Smashum Grabb
    toys = {
        {
            itemID = 108634, -- Crashin' Thrashin' Mortar Controller
        },
    },
    vignetteID = 1088,
}

NPCs[98408] = {
    --------------------------------------------------------------------------------
    ---- Fel Overseer Mudlump
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 98408,
    questID = 40107, -- Mudlump
    vignetteID = 1091,
}

--------------------------------------------------------------------------------
---- AddOn Namespace
--------------------------------------------------------------------------------

local AddOnFolderName = ... ---@type string
local private = select(2, ...) ---@class PrivateNamespace

local NPCs = private.Data.NPCs
local NPCClassification = private.Enum.NPCClassification

--------------------------------------------------------------------------------
---- Darkmoon Island (407)
--------------------------------------------------------------------------------

NPCs[71992] = {
    --------------------------------------------------------------------------------
    ---- Moonfang
    --------------------------------------------------------------------------------
    classification = NPCClassification.Elite,
    npcID = 71992,
    pets = {
        {
            itemID = 101570, -- Moon Moon
            npcID = 72160, -- Moon Moon
        },
    },
    toys = {
        {
            itemID = 101571, -- Moonfang Shroud
        },
        {
            itemID = 105898, -- Moonfang's Paw
        },
    },
    vignetteID = 63,
}

NPCs[122899] = {
    --------------------------------------------------------------------------------
    ---- Death Metal Knight
    --------------------------------------------------------------------------------
    classification = NPCClassification.RareElite,
    npcID = 122899,
    questID = 47767, -- Unknown
    vignetteID = 2003,
}

--------------------------------------------------------------------------------
---- Nazjatar (1355)
--------------------------------------------------------------------------------

NPCs[144644] = {
    --------------------------------------------------------------------------------
    ---- Mirecrawler
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 144644,
    pets = {
        {
            itemID = 169366, -- Wriggler
            npcID = 154839, -- Wriggler
        },
    },
    questID = 56274, -- Unknown
    vignetteID = 3706,
}

NPCs[149653] = {
    --------------------------------------------------------------------------------
    ---- Carnivorous Lasher
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 149653,
    questID = 55366, -- Unknown
    vignetteID = 3598,
}

NPCs[150191] = {
    --------------------------------------------------------------------------------
    ---- Avarius
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 150191,
    questID = 55584, -- Unknown
    vignetteID = 3597,
}

NPCs[150468] = {
    --------------------------------------------------------------------------------
    ---- Vor'koth
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 150468,
    questID = 55603, -- Unknown
    vignetteID = 3599,
}

NPCs[150583] = {
    --------------------------------------------------------------------------------
    ---- Rockweed Shambler
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 150583,
    questID = 56291, -- Unknown
    vignetteID = 3723,
}

NPCs[151719] = {
    --------------------------------------------------------------------------------
    ---- Voice in the Deeps
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 151719,
    questID = 56300, -- Unknown
    vignetteID = 3732,
}

NPCs[151870] = {
    --------------------------------------------------------------------------------
    ---- Sandcastle
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 151870,
    questID = 56276, -- Unknown
    vignetteID = 3708,
}

NPCs[152290] = {
    --------------------------------------------------------------------------------
    ---- Soundless
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 152290,
    questID = 56298, -- Unknown
    vignetteID = 3730,
}

NPCs[152291] = {
    --------------------------------------------------------------------------------
    ---- Deepglider
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 152291,
    questID = 56272, -- Unknown
    vignetteID = 3704,
}

NPCs[152323] = {
    --------------------------------------------------------------------------------
    ---- King Gakula
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 152323,
    questID = 55671, -- Unknown
    vignetteID = 3619,
}

NPCs[152359] = {
    --------------------------------------------------------------------------------
    ---- Siltstalker the Packmother
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 152359,
    questID = 56297, -- Unknown
    vignetteID = 3729,
}

NPCs[152360] = {
    --------------------------------------------------------------------------------
    ---- Toxigore the Alpha
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 152360,
    questID = 56278, -- Unknown
    vignetteID = 3710,
}

NPCs[152361] = {
    --------------------------------------------------------------------------------
    ---- Banescale the Packfather
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 152361,
    questID = 56282, -- Unknown
    vignetteID = 3714,
}

NPCs[152397] = {
    --------------------------------------------------------------------------------
    ---- Oronu
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 152397,
    questID = 56288, -- Unknown
    vignetteID = 3720,
}

NPCs[152414] = {
    --------------------------------------------------------------------------------
    ---- Elder Unu
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 152414,
    questID = 56284, -- Unknown
    vignetteID = 3716,
}

NPCs[152415] = {
    --------------------------------------------------------------------------------
    ---- Alga the Eyeless
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 152415,
    questID = 56279, -- Unknown
    vignetteID = 3711,
}

NPCs[152416] = {
    --------------------------------------------------------------------------------
    ---- Allseer Oma'kil
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 152416,
    questID = 56280, -- Unknown
    vignetteID = 3712,
}

NPCs[152448] = {
    --------------------------------------------------------------------------------
    ---- Iridescent Glimmershell
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 152448,
    questID = 56286, -- Unknown
    vignetteID = 3718,
}

NPCs[152464] = {
    --------------------------------------------------------------------------------
    ---- Caverndark Terror
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 152464,
    questID = 56283, -- Unknown
    vignetteID = 3715,
}

NPCs[152465] = {
    --------------------------------------------------------------------------------
    ---- Needlespine
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 152465,
    questID = 56275, -- Unknown
    vignetteID = 3707,
}

NPCs[152542] = {
    --------------------------------------------------------------------------------
    ---- Scale Matriarch Zodia
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 152542,
    questID = 56294, -- Unknown
    vignetteID = 3726,
}

NPCs[152545] = {
    --------------------------------------------------------------------------------
    ---- Scale Matriarch Vynara
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 152545,
    questID = 56293, -- Unknown
    vignetteID = 3725,
}

NPCs[152548] = {
    --------------------------------------------------------------------------------
    ---- Scale Matriarch Gratinax
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 152548,
    questID = 56292, -- Unknown
    vignetteID = 3724,
}

NPCs[152552] = {
    --------------------------------------------------------------------------------
    ---- Shassera
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 152552,
    questID = 56295, -- Unknown
    vignetteID = 3727,
}

NPCs[152553] = {
    --------------------------------------------------------------------------------
    ---- Garnetscale
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 152553,
    questID = 56273, -- Unknown
    vignetteID = 3705,
}

NPCs[152555] = {
    --------------------------------------------------------------------------------
    ---- Elderspawn Nalaada
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 152555,
    questID = 56285, -- Unknown
    vignetteID = 3717,
}

NPCs[152556] = {
    --------------------------------------------------------------------------------
    ---- Chasm-Haunter
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 152556,
    questID = 56270, -- Unknown
    vignetteID = 3701,
}

NPCs[152566] = {
    --------------------------------------------------------------------------------
    ---- Anemonar
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 152566,
    questID = 56281, -- Unknown
    vignetteID = 3713,
}

NPCs[152567] = {
    --------------------------------------------------------------------------------
    ---- Kelpwillow
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 152567,
    questID = 56287, -- Unknown
    vignetteID = 3719,
}

NPCs[152568] = {
    --------------------------------------------------------------------------------
    ---- Urduu
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 152568,
    questID = 56299, -- Unknown
    vignetteID = 3731,
}

NPCs[152681] = {
    --------------------------------------------------------------------------------
    ---- Prince Typhonus
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 152681,
    questID = 56289, -- Unknown
    vignetteID = 3721,
}

NPCs[152682] = {
    --------------------------------------------------------------------------------
    ---- Prince Vortran
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 152682,
    questID = 56290, -- Unknown
    vignetteID = 3722,
}

NPCs[152697] = {
    --------------------------------------------------------------------------------
    ---- Ulmath
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 152697,
    questID = 56057, -- The Soulbinder
}

NPCs[152712] = {
    --------------------------------------------------------------------------------
    ---- Blindlight
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 152712,
    questID = 56269, -- Unknown
    vignetteID = 3700,
}

NPCs[152729] = {
    --------------------------------------------------------------------------------
    ---- Moon Priestess Liara
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 152729,
    questID = 56057, -- The Soulbinder
}

NPCs[152736] = {
    --------------------------------------------------------------------------------
    ---- Guardian Tannin
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 152736,
    questID = 56057, -- The Soulbinder
}

NPCs[152756] = {
    --------------------------------------------------------------------------------
    ---- Daggertooth Terror
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 152756,
    questID = 56271, -- Unknown
    vignetteID = 3702,
}

NPCs[152794] = {
    --------------------------------------------------------------------------------
    ---- Amethyst Spireshell
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 152794,
    questID = 56268, -- Unknown
    vignetteID = 3699,
}

NPCs[152795] = {
    --------------------------------------------------------------------------------
    ---- Sandclaw Stoneshell
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 152795,
    questID = 56277, -- Unknown
    vignetteID = 3709,
}

NPCs[153296] = {
    --------------------------------------------------------------------------------
    ---- Shalan'ali Stormtongue
    --------------------------------------------------------------------------------
    achievementQuestID = 55898, -- Tempest-Speaker Shalan'ali
    classification = NPCClassification.Rare,
    npcID = 153296,
}

NPCs[153299] = {
    --------------------------------------------------------------------------------
    ---- Bonebreaker Szun
    --------------------------------------------------------------------------------
    achievementQuestID = 55897, -- Szun, Breaker of Slaves
    classification = NPCClassification.Rare,
    npcID = 153299,
}

NPCs[153300] = {
    --------------------------------------------------------------------------------
    ---- Iron Zoko
    --------------------------------------------------------------------------------
    achievementQuestID = 55894, -- Zoko, Her Iron Defender
    classification = NPCClassification.Rare,
    npcID = 153300,
}

NPCs[153301] = {
    --------------------------------------------------------------------------------
    ---- Shirakess Starseeker
    --------------------------------------------------------------------------------
    achievementQuestID = 55899, -- Starseeker of the Shirakess
    classification = NPCClassification.Rare,
    npcID = 153301,
}

NPCs[153302] = {
    --------------------------------------------------------------------------------
    ---- Glacier Mage Zhiela
    --------------------------------------------------------------------------------
    achievementQuestID = 55895, -- Frozen Winds of Zhiela
    classification = NPCClassification.Rare,
    npcID = 153302,
}

NPCs[153303] = {
    --------------------------------------------------------------------------------
    ---- Voidblade Kassar
    --------------------------------------------------------------------------------
    achievementQuestID = 55900, -- Kassar, Wielder of Dark Blades
    classification = NPCClassification.Rare,
    npcID = 153303,
}

NPCs[153304] = {
    --------------------------------------------------------------------------------
    ---- Undana Frostbarb
    --------------------------------------------------------------------------------
    achievementQuestID = 55896, -- Undana, Chilling Assassin
    classification = NPCClassification.Rare,
    npcID = 153304,
}

NPCs[153305] = {
    --------------------------------------------------------------------------------
    ---- Zanj'ir Brutalizer
    --------------------------------------------------------------------------------
    achievementQuestID = 55886, -- The Zanj'ir Brutalizer
    classification = NPCClassification.Rare,
    npcID = 153305,
}

NPCs[153309] = {
    --------------------------------------------------------------------------------
    ---- Alzana, Arrow of Thunder
    --------------------------------------------------------------------------------
    achievementQuestID = 55887, -- Champion Alzana, Arrow of Thunder
    classification = NPCClassification.Rare,
    npcID = 153309,
    questID = 57169, -- Unknown
}

NPCs[153310] = {
    --------------------------------------------------------------------------------
    ---- Qalina, Spear of Ice
    --------------------------------------------------------------------------------
    achievementQuestID = 55888, -- Champion Qalina, Spear of Ice
    classification = NPCClassification.Rare,
    npcID = 153310,
}

NPCs[153311] = {
    --------------------------------------------------------------------------------
    ---- Slitherblade Azanz
    --------------------------------------------------------------------------------
    achievementQuestID = 55893, -- Azanz, the Slitherblade
    classification = NPCClassification.Rare,
    npcID = 153311,
}

NPCs[153312] = {
    --------------------------------------------------------------------------------
    ---- Kyx'zhul the Deepspeaker
    --------------------------------------------------------------------------------
    achievementQuestID = 55889, -- Champion Kyx'zhul the Deepspeaker
    classification = NPCClassification.Rare,
    npcID = 153312,
    questID = 57168, -- Unknown
}

NPCs[153313] = {
    --------------------------------------------------------------------------------
    ---- Vyz'olgo the Mind-Taker
    --------------------------------------------------------------------------------
    achievementQuestID = 55890, -- Champion Vyz'olgo the Mind-Taker
    classification = NPCClassification.Rare,
    npcID = 153313,
}

NPCs[153314] = {
    --------------------------------------------------------------------------------
    ---- Aldrantiss
    --------------------------------------------------------------------------------
    achievementQuestID = 55891, -- Champion Aldrantiss, Defender of Her Kingdom
    classification = NPCClassification.Rare,
    npcID = 153314,
}

NPCs[153315] = {
    --------------------------------------------------------------------------------
    ---- Eldanar
    --------------------------------------------------------------------------------
    achievementQuestID = 55892, -- Champion Eldanar, Shield of Her Glory
    classification = NPCClassification.Rare,
    npcID = 153315,
}

NPCs[153658] = {
    --------------------------------------------------------------------------------
    ---- Shiz'narasz the Consumer
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 153658,
    questID = 56296, -- Unknown
    vignetteID = 3728,
}

NPCs[153898] = {
    --------------------------------------------------------------------------------
    ---- Tidelord Aquatus
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 153898,
    questID = 56122, -- Unknown
    vignetteID = 3675,
}

NPCs[153928] = {
    --------------------------------------------------------------------------------
    ---- Tidelord Dispersius
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 153928,
    questID = 56123, -- Unknown
    vignetteID = 3676,
}

NPCs[154148] = {
    --------------------------------------------------------------------------------
    ---- Tidemistress Leth'sindra
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 154148,
    questID = 56106, -- Unknown
    vignetteID = 3674,
}

NPCs[155811] = {
    --------------------------------------------------------------------------------
    ---- Commander Minzera
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 155811,
    questID = 56882, -- Unknown
    vignetteID = 3759,
}

NPCs[155836] = {
    --------------------------------------------------------------------------------
    ---- Theurgist Nitara
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 155836,
    questID = 56890, -- Unknown
    vignetteID = 3760,
}

NPCs[155838] = {
    --------------------------------------------------------------------------------
    ---- Incantatrix Vazina
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 155838,
    questID = 56895, -- Unknown
    vignetteID = 3763,
}

NPCs[155840] = {
    --------------------------------------------------------------------------------
    ---- Warlord Zalzjar
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 155840,
    questID = 56893, -- Unknown
    vignetteID = 3761,
}

NPCs[155841] = {
    --------------------------------------------------------------------------------
    ---- Shadowbinder Athissa
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 155841,
    questID = 56894, -- Unknown
    vignetteID = 3762,
}

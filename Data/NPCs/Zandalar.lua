--------------------------------------------------------------------------------
---- AddOn Namespace
--------------------------------------------------------------------------------

local AddOnFolderName = ... ---@type string
local private = select(2, ...) ---@class PrivateNamespace

local NPCs = private.Data.NPCs
local NPCClassification = private.Enum.NPCClassification

--------------------------------------------------------------------------------
---- Dazar'alor (1165)
--------------------------------------------------------------------------------

NPCs[120899] = {
    --------------------------------------------------------------------------------
    ---- Kul'krazahn
    --------------------------------------------------------------------------------
    achievementQuestID = 48333, -- Unknown
    classification = NPCClassification.Rare,
    npcID = 120899,
    vignetteID = 2038,
    worldQuestID = 50845, -- Kul'krazahn
}

NPCs[122639] = {
    --------------------------------------------------------------------------------
    ---- Old R'gal
    --------------------------------------------------------------------------------
    classification = NPCClassification.RareElite,
    factionGroup = "Horde",
    npcID = 122639,
    questID = 50856, -- Unknown
    vignetteID = 2784,
    worldQuestID = 50855, -- Old R'gal
}

NPCs[125816] = {
    --------------------------------------------------------------------------------
    ---- Sky Queen
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    factionGroup = "Horde",
    npcID = 125816,
    questID = 53567, -- Unknown
    vignetteID = 3271,
    worldQuestID = 50858, -- Sky Queen
}

--------------------------------------------------------------------------------
---- Nazmir (863)
--------------------------------------------------------------------------------

NPCs[121242] = {
    --------------------------------------------------------------------------------
    ---- Glompmaw
    --------------------------------------------------------------------------------
    achievementQuestID = 50361, -- Unknown
    classification = NPCClassification.Rare,
    npcID = 121242,
    vignetteID = 2603,
    worldQuestID = 50496, -- Glompmaw
}

NPCs[124375] = {
    --------------------------------------------------------------------------------
    ---- Overstuffed Saurolisk
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 124375,
    questID = 47827, -- Unknown
    vignetteID = 2009,
    worldQuestID = 50510, -- Overstuffed Saurolisk
}

NPCs[124397] = {
    --------------------------------------------------------------------------------
    ---- Kal'draxa
    --------------------------------------------------------------------------------
    achievementQuestID = 47843, -- Unknown
    classification = NPCClassification.Rare,
    npcID = 124397,
    vignetteID = 2010,
    worldQuestID = 50505, -- Kal'draxa
}

NPCs[124399] = {
    --------------------------------------------------------------------------------
    ---- Infected Direhorn
    --------------------------------------------------------------------------------
    achievementQuestID = 47877, -- Unknown
    classification = NPCClassification.Rare,
    npcID = 124399,
    vignetteID = 2013,
}

NPCs[124475] = {
    --------------------------------------------------------------------------------
    ---- Shambling Ambusher
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 124475,
    questID = 47878, -- Unknown
    vignetteID = 2014,
}

NPCs[125214] = {
    --------------------------------------------------------------------------------
    ---- Krubbs
    --------------------------------------------------------------------------------
    achievementQuestID = 48052, -- Unknown
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 125214,
    vignetteID = 2028,
    worldQuestID = 50507, -- Krubbs
}

NPCs[125232] = {
    --------------------------------------------------------------------------------
    ---- Captain Mu'kala
    --------------------------------------------------------------------------------
    achievementQuestID = 48057, -- Unknown
    classification = NPCClassification.Rare,
    npcID = 125232,
    vignetteID = 2029,
    worldQuestID = 50492, -- Cursed Chest
}

NPCs[125250] = {
    --------------------------------------------------------------------------------
    ---- Ancient Jawbreaker
    --------------------------------------------------------------------------------
    achievementQuestID = 48063, -- Unknown
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 125250,
    vignetteID = 2031,
    worldQuestID = 50488, -- Ancient Jawbreaker
}

NPCs[126056] = {
    --------------------------------------------------------------------------------
    ---- Totem Maker Jash'ga
    --------------------------------------------------------------------------------
    achievementQuestID = 48406, -- Unknown
    classification = NPCClassification.Rare,
    npcID = 126056,
    vignetteID = 2068,
    worldQuestID = 50514, -- Totem Maker Jash'ga
}

NPCs[126142] = {
    --------------------------------------------------------------------------------
    ---- Bajiatha
    --------------------------------------------------------------------------------
    achievementQuestID = 48439, -- Unknown
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 126142,
    vignetteID = 2120,
    worldQuestID = 50511, -- Bajiatha
}

NPCs[126187] = {
    --------------------------------------------------------------------------------
    ---- Corpse Bringer Yal'kar
    --------------------------------------------------------------------------------
    achievementQuestID = 48462, -- Unknown
    classification = NPCClassification.Rare,
    mounts = {
        {
            itemID = 163575, -- Reins of a Tamed Bloodfeaster
            spellID = 243795, -- Leaping Veinseeker
        },
    },
    npcID = 126187,
    vignetteID = 2130,
    worldQuestID = 50491, -- Corpse Bringer Yal'kar
}

NPCs[126460] = {
    --------------------------------------------------------------------------------
    ---- Tainted Guardian
    --------------------------------------------------------------------------------
    achievementQuestID = 48508, -- Unknown
    classification = NPCClassification.Rare,
    npcID = 126460,
    vignetteID = 2192,
    worldQuestID = 50513, -- Tainted Guardian
}

NPCs[126635] = {
    --------------------------------------------------------------------------------
    ---- Blood Priest Xak'lar
    --------------------------------------------------------------------------------
    achievementQuestID = 48541, -- Unknown
    classification = NPCClassification.Rare,
    npcID = 126635,
    vignetteID = 2195,
}

NPCs[126907] = {
    --------------------------------------------------------------------------------
    ---- Wardrummer Zurula
    --------------------------------------------------------------------------------
    achievementQuestID = 48623, -- Unknown
    classification = NPCClassification.Rare,
    npcID = 126907,
    vignetteID = 2219,
    worldQuestID = 50516, -- Wardrummer Zurula
}

NPCs[126926] = {
    --------------------------------------------------------------------------------
    ---- Venomjaw
    --------------------------------------------------------------------------------
    achievementQuestID = 48626, -- Unknown
    classification = NPCClassification.Rare,
    npcID = 126926,
    vignetteID = 2221,
    worldQuestID = 50515, -- Venomjaw
}

NPCs[127001] = {
    --------------------------------------------------------------------------------
    ---- Gwugnug the Cursed
    --------------------------------------------------------------------------------
    achievementQuestID = 48638, -- Unknown
    classification = NPCClassification.Rare,
    npcID = 127001,
    vignetteID = 2224,
    worldQuestID = 50499, -- Gwugnug
}

NPCs[127820] = {
    --------------------------------------------------------------------------------
    ---- Scout Skrasniss
    --------------------------------------------------------------------------------
    achievementQuestID = 48972, -- Unknown
    classification = NPCClassification.Rare,
    npcID = 127820,
    vignetteID = 2306,
    worldQuestID = 50512, -- Scout Skrasniss
}

NPCs[127873] = {
    --------------------------------------------------------------------------------
    ---- Scrounger Patriarch
    --------------------------------------------------------------------------------
    achievementQuestID = 48980, -- Unknown
    classification = NPCClassification.Rare,
    npcID = 127873,
    vignetteID = 2310,
}

NPCs[128426] = {
    --------------------------------------------------------------------------------
    ---- Gutrip
    --------------------------------------------------------------------------------
    achievementQuestID = 49231, -- Unknown
    classification = NPCClassification.Rare,
    npcID = 128426,
    vignetteID = 2337,
    worldQuestID = 50498, -- Gutrip
}

NPCs[128578] = {
    --------------------------------------------------------------------------------
    ---- Zujothgul
    --------------------------------------------------------------------------------
    classification = NPCClassification.RareElite,
    npcID = 128578,
    questID = 50460, -- Unknown
    vignetteID = 2640,
    worldQuestID = 50461, -- Zujothgul
}

NPCs[128584] = {
    --------------------------------------------------------------------------------
    ---- Vugthuth
    --------------------------------------------------------------------------------
    classification = NPCClassification.RareElite,
    npcID = 128584,
    questID = 50366, -- Unknown
    vignetteID = 2605,
    worldQuestID = 50459, -- Vugthuth
}

NPCs[128610] = {
    --------------------------------------------------------------------------------
    ---- Maw of Shul-Nagruth
    --------------------------------------------------------------------------------
    classification = NPCClassification.RareElite,
    npcID = 128610,
    questID = 50467, -- Unknown
    vignetteID = 2642,
    worldQuestID = 50468, -- Shul-Nagruth
}

NPCs[128930] = {
    --------------------------------------------------------------------------------
    ---- Rohnkor
    --------------------------------------------------------------------------------
    achievementQuestID = 50040, -- Unknown
    classification = NPCClassification.Rare,
    npcID = 128930,
    vignetteID = 2529,
    worldQuestID = 50517, -- Mala'kili and Rohnkor
}

NPCs[128935] = {
    --------------------------------------------------------------------------------
    ---- Mala'kili
    --------------------------------------------------------------------------------
    achievementQuestID = 50040, -- Unknown
    classification = NPCClassification.Rare,
    npcID = 128935,
    vignetteID = 2529,
    worldQuestID = 50517, -- Mala'kili and Rohnkor
}

NPCs[128965] = {
    --------------------------------------------------------------------------------
    ---- Uroku the Bound
    --------------------------------------------------------------------------------
    achievementQuestID = 49305, -- Unknown
    classification = NPCClassification.Rare,
    npcID = 128965,
    vignetteID = 2376,
    worldQuestID = 50490, -- Uroku the Bound
}

NPCs[128974] = {
    --------------------------------------------------------------------------------
    ---- Queen Tzxi'kik
    --------------------------------------------------------------------------------
    achievementQuestID = 49312, -- Unknown
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 128974,
    vignetteID = 2381,
    worldQuestID = 50501, -- Queen Tzxi'kik
}

NPCs[129005] = {
    --------------------------------------------------------------------------------
    ---- King Kooba
    --------------------------------------------------------------------------------
    achievementQuestID = 49317, -- Unknown
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 129005,
    vignetteID = 2383,
    worldQuestID = 50506, -- King Kooba
}

NPCs[129657] = {
    --------------------------------------------------------------------------------
    ---- Za'amar the Queen's Blade
    --------------------------------------------------------------------------------
    achievementQuestID = 49469, -- Unknown
    classification = NPCClassification.Rare,
    npcID = 129657,
    vignetteID = 2194,
    worldQuestID = 50519, -- Za'amar
}

NPCs[132701] = {
    --------------------------------------------------------------------------------
    ---- T'zane
    --------------------------------------------------------------------------------
    classification = NPCClassification.RareElite,
    npcID = 132701,
    questID = 52996, -- Unknown

    worldQuestID = 52181, -- Smoke and Shadow
}

NPCs[133373] = {
    --------------------------------------------------------------------------------
    ---- Jax'teb the Reanimated
    --------------------------------------------------------------------------------
    achievementQuestID = 50307, -- Unknown
    classification = NPCClassification.Rare,
    npcID = 133373,
    vignetteID = 2593,
    worldQuestID = 50502, -- Jax'teb the Reanimated
}

NPCs[133505] = {
    --------------------------------------------------------------------------------
    ---- Aiji the Accursed
    --------------------------------------------------------------------------------
    classification = NPCClassification.Elite,
    npcID = 133505,
    questID = 50339, -- Unknown
    vignetteID = 2796,
    worldQuestID = 50976, -- An Ancient Curse
}

NPCs[133527] = {
    --------------------------------------------------------------------------------
    ---- Juba the Scarred
    --------------------------------------------------------------------------------
    achievementQuestID = 50342, -- Unknown
    classification = NPCClassification.Rare,
    npcID = 133527,
    vignetteID = 2599,
    worldQuestID = 50503, -- Juba the Scarred
}

NPCs[133531] = {
    --------------------------------------------------------------------------------
    ---- Xu'ba
    --------------------------------------------------------------------------------
    achievementQuestID = 50348, -- Unknown
    classification = NPCClassification.Rare,
    npcID = 133531,
    vignetteID = 2600,
    worldQuestID = 50489, -- Xu'ba
}

NPCs[133539] = {
    --------------------------------------------------------------------------------
    ---- Lo'kuno
    --------------------------------------------------------------------------------
    achievementQuestID = 50355, -- Unknown
    classification = NPCClassification.Rare,
    npcID = 133539,
    vignetteID = 2601,
    worldQuestID = 50509, -- Lo'kuno
}

NPCs[133812] = {
    --------------------------------------------------------------------------------
    ---- Zanxib
    --------------------------------------------------------------------------------
    achievementQuestID = 50423, -- Unknown
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 133812,
    vignetteID = 2630,
    worldQuestID = 50518, -- Zanxib
}

NPCs[134002] = {
    --------------------------------------------------------------------------------
    ---- Underlord Xerxiz
    --------------------------------------------------------------------------------
    classification = NPCClassification.RareElite,
    npcID = 134002,
    questID = 50480, -- Unknown
    vignetteID = 2648,
    worldQuestID = 50483, -- Underlord Xerxiz
}

NPCs[134293] = {
    --------------------------------------------------------------------------------
    ---- Azerite-Infused Slag
    --------------------------------------------------------------------------------
    achievementQuestID = 50563, -- Unknown
    classification = NPCClassification.Rare,
    npcID = 134293,
    vignetteID = 2658,
    worldQuestID = 50564, -- Azerite Infused Slag
}

NPCs[134294] = {
    --------------------------------------------------------------------------------
    ---- Enraged Water Elemental
    --------------------------------------------------------------------------------
    achievementQuestID = 50565, -- Unknown
    classification = NPCClassification.Rare,
    npcID = 134294,
    vignetteID = 2659,
    worldQuestID = 50566, -- Lost Scroll
}

NPCs[134296] = {
    --------------------------------------------------------------------------------
    ---- Lucille
    --------------------------------------------------------------------------------
    achievementQuestID = 50567, -- Unknown
    classification = NPCClassification.Rare,
    npcID = 134296,
    vignetteID = 2660,
    worldQuestID = 50568, -- Chag's Challenge
}

NPCs[134298] = {
    --------------------------------------------------------------------------------
    ---- Azerite-Infused Elemental
    --------------------------------------------------------------------------------
    achievementQuestID = 50569, -- Unknown
    classification = NPCClassification.Rare,
    npcID = 134298,
    vignetteID = 2661,
    worldQuestID = 50570, -- Azerite Infused Elemental
}

NPCs[135565] = {
    --------------------------------------------------------------------------------
    ---- Guardian of Agussu
    --------------------------------------------------------------------------------
    achievementQuestID = 50888, -- Unknown
    classification = NPCClassification.Normal,
    npcID = 135565,
    vignetteID = 2788,
}

NPCs[143311] = {
    --------------------------------------------------------------------------------
    ---- Toadcruel
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 143311,
}

NPCs[143316] = {
    --------------------------------------------------------------------------------
    ---- Skullcap
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 143316,
}

NPCs[143898] = {
    --------------------------------------------------------------------------------
    ---- Makatau
    --------------------------------------------------------------------------------
    classification = NPCClassification.Elite,
    npcID = 143898,
}

NPCs[148637] = {
    --------------------------------------------------------------------------------
    ---- Shadow Hunter Vol'tris
    --------------------------------------------------------------------------------
    npcID = 148637,
}

NPCs[148642] = {
    --------------------------------------------------------------------------------
    ---- Caravan Leader
    --------------------------------------------------------------------------------
    npcID = 148642,
}

NPCs[148651] = {
    --------------------------------------------------------------------------------
    ---- Overgrown Ancient
    --------------------------------------------------------------------------------
    npcID = 148651,
}

NPCs[148674] = {
    --------------------------------------------------------------------------------
    ---- Plague Master Herbert
    --------------------------------------------------------------------------------
    npcID = 148674,
}

NPCs[148679] = {
    --------------------------------------------------------------------------------
    ---- Arcanist Quintril
    --------------------------------------------------------------------------------
    npcID = 148679,
}

NPCs[148744] = {
    --------------------------------------------------------------------------------
    ---- Brewmaster Lin
    --------------------------------------------------------------------------------
    npcID = 148744,
}

NPCs[148753] = {
    --------------------------------------------------------------------------------
    ---- Ptin'go
    --------------------------------------------------------------------------------
    npcID = 148753,
}

NPCs[148759] = {
    --------------------------------------------------------------------------------
    ---- Stormcaller Morka
    --------------------------------------------------------------------------------
    npcID = 148759,
}

NPCs[148779] = {
    --------------------------------------------------------------------------------
    ---- Lightforged Warframe
    --------------------------------------------------------------------------------
    npcID = 148779,
}

NPCs[148792] = {
    --------------------------------------------------------------------------------
    ---- Skycaptain Thermospark
    --------------------------------------------------------------------------------
    npcID = 148792,
}

NPCs[148813] = {
    --------------------------------------------------------------------------------
    ---- Thomas Vandergrief
    --------------------------------------------------------------------------------
    npcID = 148813,
}

NPCs[148842] = {
    --------------------------------------------------------------------------------
    ---- Siegeotron
    --------------------------------------------------------------------------------
    npcID = 148842,
}

NPCs[149383] = {
    --------------------------------------------------------------------------------
    ---- Xizz Gutshank
    --------------------------------------------------------------------------------
    npcID = 149383,
}

--------------------------------------------------------------------------------
---- Vol'dun (864)
--------------------------------------------------------------------------------

NPCs[124722] = {
    --------------------------------------------------------------------------------
    ---- Commodore Calhoun
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 124722,
    questID = 50905, -- Unknown
    vignetteID = 2797,
    worldQuestID = 51098, -- Commodore Calhoun
}

NPCs[127776] = {
    --------------------------------------------------------------------------------
    ---- Scaleclaw Broodmother
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 127776,
    questID = 48960, -- Unknown
    vignetteID = 2298,
    worldQuestID = 48656, -- Savage Saurolisks
}

NPCs[128497] = {
    --------------------------------------------------------------------------------
    ---- Bajiani the Slick
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 128497,
    questID = 49251, -- Unknown
    vignetteID = 2351,
    worldQuestID = 51117, -- Bajiani the Slick
}

NPCs[128553] = {
    --------------------------------------------------------------------------------
    ---- Azer'tor
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 128553,
    questID = 49252, -- Unknown
    vignetteID = 2352,
    worldQuestID = 51096, -- Azer'tor
}

NPCs[128674] = {
    --------------------------------------------------------------------------------
    ---- Gut-Gut the Glutton
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 128674,
    questID = 49270, -- Unknown
    vignetteID = 2361,
    worldQuestID = 51099, -- Gut-Gut the Glutton
}

NPCs[128686] = {
    --------------------------------------------------------------------------------
    ---- Kamid the Trapper
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 128686,
    questID = 50528, -- Unknown
    vignetteID = 2655,
    worldQuestID = 51102, -- Kamid the Trapper
}

NPCs[128951] = {
    --------------------------------------------------------------------------------
    ---- Nez'ara
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 128951,
    questID = 50898, -- Unknown
    vignetteID = 2795,
    worldQuestID = 51103, -- Nez'ara
}

NPCs[129027] = {
    --------------------------------------------------------------------------------
    ---- Golanar
    --------------------------------------------------------------------------------
    classification = NPCClassification.RareElite,
    npcID = 129027,
    questID = 50362, -- Unknown
    vignetteID = 2604,
    worldQuestID = 51157, -- Golanar
}

NPCs[129180] = {
    --------------------------------------------------------------------------------
    ---- Warbringer Hozzik
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 129180,
    questID = 49373, -- Unknown
    vignetteID = 2391,
    worldQuestID = 51112, -- Warbringer Hozzik
}

NPCs[129283] = {
    --------------------------------------------------------------------------------
    ---- Jumbo Sandsnapper
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 129283,
    questID = 49392, -- Unknown
    vignetteID = 2406,
    worldQuestID = 51100, -- Jumbo Sandsnapper
}

NPCs[129411] = {
    --------------------------------------------------------------------------------
    ---- Zunashi the Exile
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 129411,
    questID = 48319, -- Unknown
    vignetteID = 2410,
    worldQuestID = 51115, -- Zunashi the Exile
}

NPCs[129476] = {
    --------------------------------------------------------------------------------
    ---- Bloated Krolusk
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 129476,
    questID = 47562, -- Unknown
    vignetteID = 2411,
    worldQuestID = 51097, -- Bloated Krolusk
}

NPCs[130401] = {
    --------------------------------------------------------------------------------
    ---- Vathikur
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 130401,
    questID = 49674, -- Unknown
    vignetteID = 2445,
    worldQuestID = 51119, -- Vathikur
}

NPCs[130439] = {
    --------------------------------------------------------------------------------
    ---- Ashmane
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 130439,
    questID = 47532, -- Unknown
    vignetteID = 2446,
    worldQuestID = 51095, -- Ashmane
}

NPCs[130443] = {
    --------------------------------------------------------------------------------
    ---- Hivemother Kraxi
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 130443,
    questID = 47533, -- Unknown
    vignetteID = 2447,
    worldQuestID = 51108, -- Hivemother Kraxi
}

NPCs[133843] = {
    --------------------------------------------------------------------------------
    ---- First Mate Swainbeak
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 133843,
    questID = 51073, -- Unknown
    vignetteID = 2889,
    worldQuestID = 51120, -- Stef "Marrow" Quin
}

NPCs[134571] = {
    --------------------------------------------------------------------------------
    ---- Skycaller Teskris
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 134571,
    questID = 50637, -- Unknown
    vignetteID = 2668,
    worldQuestID = 51104, -- Skycaller Teskris
}

NPCs[134625] = {
    --------------------------------------------------------------------------------
    ---- Warmother Captive
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 134625,
    questID = 50658, -- Unknown
    vignetteID = 2672,
    worldQuestID = 51114, -- Warmother Captive
}

NPCs[134638] = {
    --------------------------------------------------------------------------------
    ---- Warlord Zothix
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 134638,
    questID = 50662, -- Unknown
    vignetteID = 2674,
    worldQuestID = 51113, -- Warlord Zothix
}

NPCs[134643] = {
    --------------------------------------------------------------------------------
    ---- Brgl-Lrgl the Basher
    --------------------------------------------------------------------------------
    classification = NPCClassification.RareElite,
    npcID = 134643,
    questID = 50663, -- Unknown
    vignetteID = 2675,
    worldQuestID = 51155, -- Brgl-Lrgl the Basher
}

NPCs[134694] = {
    --------------------------------------------------------------------------------
    ---- Mor'fani the Exile
    --------------------------------------------------------------------------------
    classification = NPCClassification.RareElite,
    npcID = 134694,
    questID = 50666, -- Unknown
    vignetteID = 2677,
    worldQuestID = 51153, -- Mor'fani the Exile
}

NPCs[134745] = {
    --------------------------------------------------------------------------------
    ---- Skycarver Krakit
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 134745,
    questID = 50686, -- Unknown
    vignetteID = 2683,
    worldQuestID = 51116, -- Skycarver Krakit
}

NPCs[135852] = {
    --------------------------------------------------------------------------------
    ---- Ak'tar
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 135852,
    questID = 51058, -- Unknown
    vignetteID = 2885,
    worldQuestID = 51105, -- Ak'tar
}

NPCs[136304] = {
    --------------------------------------------------------------------------------
    ---- Songstress Nahjeen
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 136304,
    questID = 51063, -- Unknown
    vignetteID = 2886,
    worldQuestID = 51106, -- Songstress Nahjeen
}

NPCs[136323] = {
    --------------------------------------------------------------------------------
    ---- Fangcaller Xorreth
    --------------------------------------------------------------------------------
    classification = NPCClassification.RareElite,
    npcID = 136323,
    questID = 51065, -- Unknown
    vignetteID = 2887,
    worldQuestID = 51156, -- Fangcaller Xorreth
}

NPCs[136335] = {
    --------------------------------------------------------------------------------
    ---- Enraged Krolusk
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 136335,
    questID = 51077, -- Unknown
    vignetteID = 2893,
    worldQuestID = 51121, -- Enraged Krolusk
}

NPCs[136336] = {
    --------------------------------------------------------------------------------
    ---- Scorpox
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 136336,
    questID = 51076, -- Unknown
    vignetteID = 2892,
    worldQuestID = 51122, -- Scorpox
}

NPCs[136338] = {
    --------------------------------------------------------------------------------
    ---- Sirokar
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 136338,
    questID = 51075, -- Unknown
    vignetteID = 2891,
    worldQuestID = 51123, -- Sirokar
}

NPCs[136340] = {
    --------------------------------------------------------------------------------
    ---- Relic Hunter Hazaak
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 136340,
    questID = 51126, -- Unknown
    vignetteID = 2899,
    worldQuestID = 51124, -- Relic Hunter Hazaak
}

NPCs[136341] = {
    --------------------------------------------------------------------------------
    ---- Jungleweb Hunter
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 136341,
    questID = 51074, -- Unknown
    vignetteID = 2890,
    worldQuestID = 51125, -- Jungleweb Hunter
}

NPCs[136346] = {
    --------------------------------------------------------------------------------
    ---- Captain Stef "Marrow" Quin
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 136346,
    questID = 51073, -- Unknown
    vignetteID = 2889,
    worldQuestID = 51120, -- Stef "Marrow" Quin
}

NPCs[136393] = {
    --------------------------------------------------------------------------------
    ---- Bloodwing Bonepicker
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 136393,
    questID = 51079, -- Unknown
    vignetteID = 2894,
    worldQuestID = 51118, -- Bloodwing Bonepicker
}

NPCs[137553] = {
    --------------------------------------------------------------------------------
    ---- General Krathax
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 137553,
}

NPCs[137681] = {
    --------------------------------------------------------------------------------
    ---- King Clickyclack
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 137681,
    questID = 51424, -- Unknown
    vignetteID = 2954,
    worldQuestID = 51429, -- King Clickyclack
}

NPCs[138794] = {
    --------------------------------------------------------------------------------
    ---- Dunegorger Kraulok
    --------------------------------------------------------------------------------
    classification = NPCClassification.RareElite,
    isTameable = true,
    mounts = {
        {
            itemID = 174842, -- Slightly Damp Pile of Fur
            spellID = 298367, -- Mollie
        },
    },
    npcID = 138794,
    worldQuestID = 52196, -- Sandswept Bones
}

NPCs[143313] = {
    --------------------------------------------------------------------------------
    ---- Portakillo
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 143313,
}

NPCs[146942] = {
    --------------------------------------------------------------------------------
    ---- Grand Marshal Fury
    --------------------------------------------------------------------------------
    npcID = 146942,
}

NPCs[146979] = {
    --------------------------------------------------------------------------------
    ---- Ormin Rocketbop
    --------------------------------------------------------------------------------
    npcID = 146979,
}

NPCs[148446] = {
    --------------------------------------------------------------------------------
    ---- Wolfleader Skraug
    --------------------------------------------------------------------------------
    npcID = 148446,
}

NPCs[148451] = {
    --------------------------------------------------------------------------------
    ---- Siege O' Matic 9000
    --------------------------------------------------------------------------------
    npcID = 148451,
}

NPCs[148456] = {
    --------------------------------------------------------------------------------
    ---- Jin'tago
    --------------------------------------------------------------------------------
    npcID = 148456,
}

NPCs[148477] = {
    --------------------------------------------------------------------------------
    ---- Beastlord Drakara
    --------------------------------------------------------------------------------
    npcID = 148477,
}

NPCs[148494] = {
    --------------------------------------------------------------------------------
    ---- Sandbinder Sodir
    --------------------------------------------------------------------------------
    npcID = 148494,
}

NPCs[148510] = {
    --------------------------------------------------------------------------------
    ---- Drox'ar Morgar
    --------------------------------------------------------------------------------
    npcID = 148510,
}

NPCs[148534] = {
    --------------------------------------------------------------------------------
    ---- Evezon the Eternal
    --------------------------------------------------------------------------------
    npcID = 148534,
}

NPCs[148550] = {
    --------------------------------------------------------------------------------
    ---- Caravan Leader
    --------------------------------------------------------------------------------
    npcID = 148550,
}

NPCs[148558] = {
    --------------------------------------------------------------------------------
    ---- Rockfury
    --------------------------------------------------------------------------------
    npcID = 148558,
}

NPCs[148597] = {
    --------------------------------------------------------------------------------
    ---- Iron Shaman Grimbeard
    --------------------------------------------------------------------------------
    npcID = 148597,
}

NPCs[162681] = {
    --------------------------------------------------------------------------------
    ---- Elusive Quickhoof
    --------------------------------------------------------------------------------
    npcID = 162681,
}

--------------------------------------------------------------------------------
---- Zuldazar (862)
--------------------------------------------------------------------------------

NPCs[120899] = {
    --------------------------------------------------------------------------------
    ---- Kul'krazahn
    --------------------------------------------------------------------------------
    achievementQuestID = 48333, -- Unknown
    classification = NPCClassification.Rare,
    npcID = 120899,
    vignetteID = 2038,
    worldQuestID = 50845, -- Kul'krazahn
}

NPCs[122004] = {
    --------------------------------------------------------------------------------
    ---- Umbra'jin
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 122004,
    questID = 47567, -- Umbra'jin
    vignetteID = 1998,
    worldQuestID = 50854, -- Crimsonclaw
}

NPCs[122639] = {
    --------------------------------------------------------------------------------
    ---- Old R'gal
    --------------------------------------------------------------------------------
    classification = NPCClassification.RareElite,
    factionGroup = "Horde",
    npcID = 122639,
    questID = 50856, -- Unknown
    vignetteID = 2784,
    worldQuestID = 50855, -- Old R'gal
}

NPCs[123502] = {
    --------------------------------------------------------------------------------
    ---- King K'tal
    --------------------------------------------------------------------------------
    classification = NPCClassification.Elite,
    npcID = 123502,
}

NPCs[124185] = {
    --------------------------------------------------------------------------------
    ---- Golrakahn
    --------------------------------------------------------------------------------
    achievementQuestID = 47792, -- Unknown
    classification = NPCClassification.Rare,
    npcID = 124185,
    vignetteID = 2004,
    worldQuestID = 50857, -- Golrakahn
}

NPCs[126637] = {
    --------------------------------------------------------------------------------
    ---- Kandak
    --------------------------------------------------------------------------------
    achievementQuestID = 48543, -- Kandak
    classification = NPCClassification.Rare,
    npcID = 126637,
    vignetteID = 2196,
    worldQuestID = 50859, -- Kandak
}

NPCs[127939] = {
    --------------------------------------------------------------------------------
    ---- Torraske the Eternal
    --------------------------------------------------------------------------------
    achievementQuestID = 49004, -- Unknown
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 127939,
    vignetteID = 2314,
    worldQuestID = 50861, -- Torraske the Eternal
}

NPCs[128699] = {
    --------------------------------------------------------------------------------
    ---- Bloodbulge
    --------------------------------------------------------------------------------
    achievementQuestID = 49267, -- Unknown
    classification = NPCClassification.Rare,
    npcID = 128699,
    vignetteID = 2359,
    worldQuestID = 50862, -- Bloodbulge
}

NPCs[129323] = {
    --------------------------------------------------------------------------------
    ---- Sabertusk Empress
    --------------------------------------------------------------------------------
    classification = NPCClassification.Elite,
    npcID = 129323,
}

NPCs[129343] = {
    --------------------------------------------------------------------------------
    ---- Avatar of Xolotal
    --------------------------------------------------------------------------------
    achievementQuestID = 49410, -- Unknown
    classification = NPCClassification.Rare,
    npcID = 129343,
    vignetteID = 2407,
    worldQuestID = 50863, -- Avatar of Xolotal
}

NPCs[129954] = {
    --------------------------------------------------------------------------------
    ---- Gahz'ralka
    --------------------------------------------------------------------------------
    achievementQuestID = 50439, -- Unknown
    classification = NPCClassification.Rare,
    npcID = 129954,
    vignetteID = 2636,
    worldQuestID = 50877, -- Gahz'ralka
}

NPCs[129961] = {
    --------------------------------------------------------------------------------
    ---- Atal'zul Gotaka
    --------------------------------------------------------------------------------
    achievementQuestID = 50280, -- Unknown
    classification = NPCClassification.Rare,
    npcID = 129961,
    vignetteID = 2588,
    worldQuestID = 50864, -- Atal'zul Gotaka
}

NPCs[130643] = {
    --------------------------------------------------------------------------------
    ---- Twisted Child of Rezan
    --------------------------------------------------------------------------------
    classification = NPCClassification.RareElite,
    npcID = 130643,
    questID = 50333, -- Unknown
    vignetteID = 2597,
    worldQuestID = 50847, -- Twisted Child of Rezan
}

NPCs[130741] = {
    --------------------------------------------------------------------------------
    ---- Nol'ixwan
    --------------------------------------------------------------------------------
    classification = NPCClassification.Elite,
    npcID = 130741,
}

NPCs[131233] = {
    --------------------------------------------------------------------------------
    ---- Lei-zhi
    --------------------------------------------------------------------------------
    achievementQuestID = 49911, -- Unknown
    classification = NPCClassification.Rare,
    npcID = 131233,
    vignetteID = 2496,
    worldQuestID = 50885, -- Lei-zhi
}

NPCs[131476] = {
    --------------------------------------------------------------------------------
    ---- Zayoos
    --------------------------------------------------------------------------------
    achievementQuestID = 49972, -- Unknown
    classification = NPCClassification.Rare,
    npcID = 131476,
    vignetteID = 2513,
    worldQuestID = 50866, -- Zayoos
}

NPCs[131687] = {
    --------------------------------------------------------------------------------
    ---- Tambano
    --------------------------------------------------------------------------------
    achievementQuestID = 50013, -- Unknown
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 131687,
    vignetteID = 2524,
    worldQuestID = 50867, -- Tambano
}

NPCs[131704] = {
    --------------------------------------------------------------------------------
    ---- Coati
    --------------------------------------------------------------------------------
    classification = NPCClassification.RareElite,
    isTameable = true,
    npcID = 131704,
    questID = 50846, -- Headhunter Lee'za
    vignetteID = 2525,
    worldQuestID = 50846, -- Headhunter Lee'za
}

NPCs[131718] = {
    --------------------------------------------------------------------------------
    ---- Bramblewing
    --------------------------------------------------------------------------------
    achievementQuestID = 50034, -- Unknown
    classification = NPCClassification.Rare,
    npcID = 131718,
    vignetteID = 2527,
    worldQuestID = 50868, -- Bramblewing
}

NPCs[132244] = {
    --------------------------------------------------------------------------------
    ---- Kiboku
    --------------------------------------------------------------------------------
    achievementQuestID = 50159, -- Unknown
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 132244,
    vignetteID = 2548,
    worldQuestID = 50869, -- Kiboku
}

NPCs[132253] = {
    --------------------------------------------------------------------------------
    ---- Ji'arak
    --------------------------------------------------------------------------------
    classification = NPCClassification.RareElite,
    npcID = 132253,

    worldQuestID = 52169, -- The Matriarch
}

NPCs[133155] = {
    --------------------------------------------------------------------------------
    ---- G'Naat
    --------------------------------------------------------------------------------
    achievementQuestID = 50260, -- Unknown
    classification = NPCClassification.Rare,
    npcID = 133155,
    vignetteID = 2581,
    worldQuestID = 50870, -- G'Naat
}

NPCs[133163] = {
    --------------------------------------------------------------------------------
    ---- Tia'Kawan
    --------------------------------------------------------------------------------
    classification = NPCClassification.RareElite,
    npcID = 133163,
    questID = 50263, -- Unknown
    vignetteID = 2584,
    worldQuestID = 50850, -- Tia'Kawan
}

NPCs[133190] = {
    --------------------------------------------------------------------------------
    ---- Daggerjaw
    --------------------------------------------------------------------------------
    achievementQuestID = 50269, -- Unknown
    classification = NPCClassification.Rare,
    npcID = 133190,
    vignetteID = 2587,
    worldQuestID = 50871, -- Daggerjaw
}

NPCs[133842] = {
    --------------------------------------------------------------------------------
    ---- Warcrawler Karkithiss
    --------------------------------------------------------------------------------
    achievementQuestID = 50438, -- Unknown
    classification = NPCClassification.Rare,
    npcID = 133842,
    vignetteID = 2635,
    worldQuestID = 50872, -- Warcrawler Karkithiss
}

NPCs[134048] = {
    --------------------------------------------------------------------------------
    ---- Vukuba
    --------------------------------------------------------------------------------
    achievementQuestID = 50508, -- Unknown
    classification = NPCClassification.Rare,
    npcID = 134048,
    vignetteID = 2650,
    worldQuestID = 50873, -- Strange Egg
}

NPCs[134637] = {
    --------------------------------------------------------------------------------
    ---- Headhunter Lee'za
    --------------------------------------------------------------------------------
    classification = NPCClassification.RareElite,
    npcID = 134637,
    questID = 50661, -- Unknown
    vignetteID = 2673,
    worldQuestID = 50846, -- Headhunter Lee'za
}

NPCs[134717] = {
    --------------------------------------------------------------------------------
    ---- Umbra'rix
    --------------------------------------------------------------------------------
    classification = NPCClassification.RareElite,
    npcID = 134717,
    questID = 50673, -- Unknown
    vignetteID = 2680,
    worldQuestID = 50853, -- Umbra'rix
}

NPCs[134738] = {
    --------------------------------------------------------------------------------
    ---- Hakbi the Risen
    --------------------------------------------------------------------------------
    achievementQuestID = 50677, -- Unknown
    classification = NPCClassification.Rare,
    npcID = 134738,
    vignetteID = 2682,
    worldQuestID = 50874, -- Hakbi the Risen
}

NPCs[134760] = {
    --------------------------------------------------------------------------------
    ---- Darkspeaker Jo'la
    --------------------------------------------------------------------------------
    achievementQuestID = 50693, -- Unknown
    classification = NPCClassification.Rare,
    npcID = 134760,
    vignetteID = 2685,
    worldQuestID = 50875, -- Darkspeaker Jo'la
}

NPCs[134782] = {
    --------------------------------------------------------------------------------
    ---- Murderbeak
    --------------------------------------------------------------------------------
    achievementQuestID = 50281, -- Unknown
    classification = NPCClassification.Rare,
    npcID = 134782,
    vignetteID = 2651,
    worldQuestID = 50876, -- Murderbeak
}

NPCs[135510] = {
    --------------------------------------------------------------------------------
    ---- Azuresail the Ancient
    --------------------------------------------------------------------------------
    classification = NPCClassification.Elite,
    isTameable = true,
    npcID = 135510,
}

NPCs[135512] = {
    --------------------------------------------------------------------------------
    ---- Thunderfoot
    --------------------------------------------------------------------------------
    classification = NPCClassification.Elite,
    npcID = 135512,
}

NPCs[136413] = {
    --------------------------------------------------------------------------------
    ---- Syrawon the Dominus
    --------------------------------------------------------------------------------
    achievementQuestID = 51080, -- Unknown
    classification = NPCClassification.Rare,
    npcID = 136413,
    vignetteID = 2895,
    worldQuestID = 51081, -- Syrawon the Dominus
}

NPCs[136428] = {
    --------------------------------------------------------------------------------
    ---- Dark Chronicler
    --------------------------------------------------------------------------------
    achievementQuestID = 51083, -- Unknown
    classification = NPCClassification.Rare,
    npcID = 136428,
    vignetteID = 2897,
    worldQuestID = 51084, -- Dark Chronicler
}

NPCs[139365] = {
    --------------------------------------------------------------------------------
    ---- Queenfeather
    --------------------------------------------------------------------------------
    classification = NPCClassification.Normal,
    isTameable = true,
    npcID = 139365,
}

NPCs[142434] = {
    --------------------------------------------------------------------------------
    ---- Loo'ay
    --------------------------------------------------------------------------------
    npcID = 142434,
}

NPCs[142475] = {
    --------------------------------------------------------------------------------
    ---- Ka'za the Mezmerizing
    --------------------------------------------------------------------------------
    npcID = 142475,
}

NPCs[143314] = {
    --------------------------------------------------------------------------------
    ---- Bane of the Woods
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 143314,
}

NPCs[143536] = {
    --------------------------------------------------------------------------------
    ---- High Warlord Volrath
    --------------------------------------------------------------------------------
    classification = NPCClassification.RareElite,
    factionGroup = "Horde",
    npcID = 143536,
}

NPCs[143910] = {
    --------------------------------------------------------------------------------
    ---- Sludgecrusher
    --------------------------------------------------------------------------------
    classification = NPCClassification.Elite,
    npcID = 143910,
}

NPCs[145391] = {
    --------------------------------------------------------------------------------
    ---- Caravan Leader
    --------------------------------------------------------------------------------
    npcID = 145391,
}

NPCs[148198] = {
    --------------------------------------------------------------------------------
    ---- Scout Captain Grizzleknob
    --------------------------------------------------------------------------------
    npcID = 148198,
}

NPCs[148231] = {
    --------------------------------------------------------------------------------
    ---- Siegebreaker Vol'gar
    --------------------------------------------------------------------------------
    npcID = 148231,
}

NPCs[148253] = {
    --------------------------------------------------------------------------------
    ---- Death Captain Detheca
    --------------------------------------------------------------------------------
    npcID = 148253,
}

NPCs[148257] = {
    --------------------------------------------------------------------------------
    ---- Death Captain Danielle
    --------------------------------------------------------------------------------
    npcID = 148257,
}

NPCs[148259] = {
    --------------------------------------------------------------------------------
    ---- Death Captain Delilah
    --------------------------------------------------------------------------------
    npcID = 148259,
}

NPCs[148264] = {
    --------------------------------------------------------------------------------
    ---- Dinomancer Dajingo
    --------------------------------------------------------------------------------
    npcID = 148264,
}

NPCs[148276] = {
    --------------------------------------------------------------------------------
    ---- Tidebinder Maka
    --------------------------------------------------------------------------------
    npcID = 148276,
}

NPCs[148308] = {
    --------------------------------------------------------------------------------
    ---- Eric Quietfist
    --------------------------------------------------------------------------------
    npcID = 148308,
}

NPCs[148322] = {
    --------------------------------------------------------------------------------
    ---- Blinky Gizmospark
    --------------------------------------------------------------------------------
    npcID = 148322,
}

NPCs[148343] = {
    --------------------------------------------------------------------------------
    ---- Dinohunter Wildbeard
    --------------------------------------------------------------------------------
    npcID = 148343,
}

NPCs[148390] = {
    --------------------------------------------------------------------------------
    ---- Jessibelle Moonshield
    --------------------------------------------------------------------------------
    npcID = 148390,
}

NPCs[148393] = {
    --------------------------------------------------------------------------------
    ---- Ancient Defender
    --------------------------------------------------------------------------------
    npcID = 148393,
}

NPCs[148403] = {
    --------------------------------------------------------------------------------
    ---- Portal Keeper Romiir
    --------------------------------------------------------------------------------
    npcID = 148403,
}

NPCs[148428] = {
    --------------------------------------------------------------------------------
    ---- Bilestomper
    --------------------------------------------------------------------------------
    npcID = 148428,
}

NPCs[149147] = {
    --------------------------------------------------------------------------------
    ---- N'chala the Egg Thief
    --------------------------------------------------------------------------------
    npcID = 149147,
}

--------------------------------------------------------------------------------
---- AddOn Namespace
--------------------------------------------------------------------------------

local AddOnFolderName = ... ---@type string
local private = select(2, ...) ---@class PrivateNamespace

local NPCs = private.Data.NPCs
local NPCClassification = private.Enum.NPCClassification

local Mount = private.Enum.Mount
local Pet = private.Enum.Pet
local Toy = private.Enum.Toy

--------------------------------------------------------------------------------
---- Antoran Wastes (885)
--------------------------------------------------------------------------------

NPCs[122947] = {
    --------------------------------------------------------------------------------
    ---- Mistress Il'thendra
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 122947,
    questID = 49240, -- Unknown
    vignetteID = 2345,
}

NPCs[122958] = {
    --------------------------------------------------------------------------------
    ---- Blistermaw
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    mounts = {
        Mount.CrimsonSlavermaw,
    },
    npcID = 122958,
    questID = 49183, -- Unknown
    vignetteID = 2328,
}

NPCs[122999] = {
    --------------------------------------------------------------------------------
    ---- Gar'zoth
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 122999,
    questID = 49241, -- Unknown
    vignetteID = 2344,
}

NPCs[126040] = {
    --------------------------------------------------------------------------------
    ---- Puscilla
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    mounts = {
        Mount.BiletoothGnasher,
    },
    npcID = 126040,
    questID = 48809, -- Unknown
    vignetteID = 2265,
}

NPCs[126115] = {
    --------------------------------------------------------------------------------
    ---- Ven'orn
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 126115,
    questID = 48811, -- Unknown
    vignetteID = 2266,
}

NPCs[126199] = {
    --------------------------------------------------------------------------------
    ---- Vrax'thul
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    mounts = {
        Mount.BiletoothGnasher,
    },
    npcID = 126199,
    questID = 48810, -- Unknown
    vignetteID = 2267,
}

NPCs[126208] = {
    --------------------------------------------------------------------------------
    ---- Varga
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    mounts = {
        Mount.ScintillatingManaRay,
        Mount.FelglowManaRay,
        Mount.VibrantManaRay,
        Mount.DarksporeManaRay,
    },
    npcID = 126208,
    pets = {
        Pet.DocileSkyfin,
        Pet.FelAfflictedSkyfin,
    },
    questID = 48812, -- Unknown
    vignetteID = 2268,
}

NPCs[126254] = {
    --------------------------------------------------------------------------------
    ---- Lieutenant Xakaar
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 126254,
    questID = 48813, -- Unknown
    vignetteID = 2269,
}

NPCs[126338] = {
    --------------------------------------------------------------------------------
    ---- Wrath-Lord Yarez
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 126338,
    questID = 48814, -- Unknown
    toys = {
        Toy.MicroArtilleryController,
    },
    vignetteID = 2270,
}

NPCs[126946] = {
    --------------------------------------------------------------------------------
    ---- Inquisitor Vethroz
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 126946,
    questID = 48815, -- Unknown
    vignetteID = 2271,
}

NPCs[127084] = {
    --------------------------------------------------------------------------------
    ---- Commander Texlaz
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 127084,
    questID = 48816, -- Unknown
    vignetteID = 2272,
}

NPCs[127090] = {
    --------------------------------------------------------------------------------
    ---- Admiral Rel'var
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 127090,
    questID = 48817, -- Unknown
    vignetteID = 2273,
}

NPCs[127096] = {
    --------------------------------------------------------------------------------
    ---- All-Seer Xanarian
    --------------------------------------------------------------------------------
    classification = NPCClassification.RareElite,
    npcID = 127096,
    questID = 48818, -- Unknown
    vignetteID = 2274,
    worldQuestID = 48837, -- All-Seer Xanarian
}

NPCs[127118] = {
    --------------------------------------------------------------------------------
    ---- Worldsplitter Skuul
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 127118,
    questID = 48820, -- Unknown
    vignetteID = 2276,
}

NPCs[127288] = {
    --------------------------------------------------------------------------------
    ---- Houndmaster Kerrax
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    mounts = {
        Mount.VileFiend,
    },
    npcID = 127288,
    questID = 48821, -- Unknown
    vignetteID = 2277,
}

NPCs[127291] = {
    --------------------------------------------------------------------------------
    ---- Watcher Aival
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 127291,
    questID = 48822, -- Unknown
    vignetteID = 2278,
    worldQuestID = 48836, -- Watcher Aival
}

NPCs[127300] = {
    --------------------------------------------------------------------------------
    ---- Void Warden Valsuran
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 127300,
    questID = 48824, -- Unknown
    vignetteID = 2279,
    worldQuestID = 48866, -- Void Warden Valsuran
}

NPCs[127376] = {
    --------------------------------------------------------------------------------
    ---- Chief Alchemist Munculus
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 127376,
    questID = 48865, -- Unknown
    vignetteID = 2281,
}

NPCs[127581] = {
    --------------------------------------------------------------------------------
    ---- The Many-Faced Devourer
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 127581,
    pets = {
        Pet.Uuna,
    },
    questID = 48966, -- Unknown
    vignetteID = 2300,
}

NPCs[127700] = {
    --------------------------------------------------------------------------------
    ---- Squadron Commander Vishax
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 127700,
    questID = 48967, -- Unknown
    toys = {
        Toy.SFEInterceptor,
    },
    vignetteID = 2301,
}

NPCs[127703] = {
    --------------------------------------------------------------------------------
    ---- Doomcaster Suprax
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 127703,
    questID = 48968, -- Unknown
    toys = {
        Toy.LegionCommunicationOrb,
    },
    vignetteID = 2302,
}

NPCs[127705] = {
    --------------------------------------------------------------------------------
    ---- Mother Rosula
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 127705,
    pets = {
        Pet.RebelliousImp,
    },
    questID = 48970, -- Unknown
    vignetteID = 2304,
}

NPCs[127706] = {
    --------------------------------------------------------------------------------
    ---- Rezira the Seer
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 127706,
    questID = 48971, -- Unknown
    toys = {
        Toy.SightlessEye,
    },
    vignetteID = 2305,
}

--------------------------------------------------------------------------------
---- Eredath (882)
--------------------------------------------------------------------------------

NPCs[122838] = {
    --------------------------------------------------------------------------------
    ---- Shadowcaster Voruun
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 122838,
    questID = 48692, -- Unknown
    vignetteID = 2230,
}

NPCs[124440] = {
    --------------------------------------------------------------------------------
    ---- Overseer Y'Beda
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 124440,
    questID = 48714, -- Unknown
    vignetteID = 2246,
}

NPCs[125497] = {
    --------------------------------------------------------------------------------
    ---- Overseer Y'Sorna
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 125497,
    questID = 48716, -- Unknown
    vignetteID = 2247,
}

NPCs[125498] = {
    --------------------------------------------------------------------------------
    ---- Overseer Y'Morna
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 125498,
    questID = 48717, -- Unknown
    vignetteID = 2248,
}

NPCs[126815] = {
    --------------------------------------------------------------------------------
    ---- Soultwisted Monstrosity
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 126815,
    questID = 48693, -- Unknown
    vignetteID = 2232,
}

NPCs[126852] = {
    --------------------------------------------------------------------------------
    ---- Wrangler Kravos
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    mounts = {
        Mount.MaddenedChaosrunner,
    },
    npcID = 126852,
    questID = 48695, -- Unknown
    vignetteID = 2231,
}

NPCs[126860] = {
    --------------------------------------------------------------------------------
    ---- Kaara the Pale
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 126860,
    questID = 48697, -- Unknown
    vignetteID = 2233,
}

NPCs[126862] = {
    --------------------------------------------------------------------------------
    ---- Baruut the Bloodthirsty
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 126862,
    questID = 48700, -- Unknown
    toys = {
        Toy.BaarutTheBrisk,
    },
    vignetteID = 2234,
}

NPCs[126864] = {
    --------------------------------------------------------------------------------
    ---- Feasel the Muffin Thief
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 126864,
    questID = 48702, -- Unknown
    vignetteID = 2235,
    worldQuestID = 48722, -- Feasel the Muffin Thief
}

NPCs[126865] = {
    --------------------------------------------------------------------------------
    ---- Vigilant Thanos
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 126865,
    questID = 48703, -- Unknown
    toys = {
        Toy.BarrierGenerator,
    },
    vignetteID = 2236,
}

NPCs[126866] = {
    --------------------------------------------------------------------------------
    ---- Vigilant Kuro
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 126866,
    questID = 48704, -- Unknown
    toys = {
        Toy.BarrierGenerator,
    },
    vignetteID = 2237,
}

NPCs[126867] = {
    --------------------------------------------------------------------------------
    ---- Venomtail Skyfin
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    mounts = {
        Mount.LambentManaRay,
    },
    npcID = 126867,
    questID = 48705, -- Unknown
    vignetteID = 2238,
    worldQuestID = 48725, -- Venomtail Skyfin
}

NPCs[126868] = {
    --------------------------------------------------------------------------------
    ---- Turek the Lucid
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 126868,
    questID = 48706, -- Unknown
    vignetteID = 2239,
    worldQuestID = 48726, -- Turek the Lucid
}

NPCs[126869] = {
    --------------------------------------------------------------------------------
    ---- Captain Faruq
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 126869,
    questID = 48707, -- Unknown
    vignetteID = 2240,
}

NPCs[126885] = {
    --------------------------------------------------------------------------------
    ---- Umbraliss
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    npcID = 126885,
    questID = 48708, -- Unknown
    vignetteID = 2241,
    worldQuestID = 48728, -- Umbraliss
}

NPCs[126887] = {
    --------------------------------------------------------------------------------
    ---- Ataxon
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 126887,
    pets = {
        Pet.GraspingManifestation,
    },
    questID = 48709, -- Unknown
    vignetteID = 2242,
}

NPCs[126889] = {
    --------------------------------------------------------------------------------
    ---- Sorolis the Ill-Fated
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 126889,
    questID = 48710, -- Unknown
    vignetteID = 2243,
}

NPCs[126896] = {
    --------------------------------------------------------------------------------
    ---- Herald of Chaos
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 126896,
    questID = 48711, -- Unknown
    vignetteID = 2244,
    worldQuestID = 48731, -- Herald of Chaos
}

NPCs[126898] = {
    --------------------------------------------------------------------------------
    ---- Sabuul
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    mounts = {
        Mount.ScintillatingManaRay,
        Mount.FelglowManaRay,
        Mount.VibrantManaRay,
        Mount.DarksporeManaRay,
    },
    npcID = 126898,
    pets = {
        Pet.DocileSkyfin,
        Pet.FelAfflictedSkyfin,
    },
    questID = 48712, -- Unknown
    vignetteID = 2253,
}

NPCs[126899] = {
    --------------------------------------------------------------------------------
    ---- Jed'hin Champion Vorusk
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 126899,
    questID = 48713, -- Unknown
    vignetteID = 2245,
}

NPCs[126900] = {
    --------------------------------------------------------------------------------
    ---- Instructor Tarahna
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 126900,
    questID = 48718, -- Unknown
    toys = {
        Toy.BlueConservatoryScroll,
        Toy.YellowConservatoryScroll,
        Toy.RedConservatoryScroll,
    },
    vignetteID = 2249,
}

NPCs[126908] = {
    --------------------------------------------------------------------------------
    ---- Zul'tan the Numerous
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 126908,
    questID = 48719, -- Unknown
    vignetteID = 2250,
}

NPCs[126910] = {
    --------------------------------------------------------------------------------
    ---- Commander Xethgar
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 126910,
    questID = 48720, -- Unknown
    vignetteID = 2251,
}

NPCs[126912] = {
    --------------------------------------------------------------------------------
    ---- Skreeg the Devourer
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    mounts = {
        Mount.AcidBelcher,
    },
    npcID = 126912,
    questID = 48721, -- Unknown
    vignetteID = 2252,
    worldQuestID = 48740, -- Skreeg the Devourer
}

NPCs[126913] = {
    --------------------------------------------------------------------------------
    ---- Slithon the Last
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 126913,
    questID = 48935, -- Unknown
    vignetteID = 2294,
}

--------------------------------------------------------------------------------
---- Krokuun (830)
--------------------------------------------------------------------------------

NPCs[120393] = {
    --------------------------------------------------------------------------------
    ---- Siegemaster Voraan
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 120393,
    questID = 48627, -- Unknown
    vignetteID = 1996,
}

NPCs[122911] = {
    --------------------------------------------------------------------------------
    ---- Commander Vecaya
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 122911,
    questID = 48563, -- Unknown
    vignetteID = 2199,
}

NPCs[122912] = {
    --------------------------------------------------------------------------------
    ---- Commander Sathrenael
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 122912,
    questID = 48562, -- Unknown
    vignetteID = 2198,
}

NPCs[123464] = {
    --------------------------------------------------------------------------------
    ---- Sister Subversia
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 123464,
    questID = 48565, -- Unknown
    toys = {
        Toy.SpireOfSpite,
    },
    vignetteID = 2201,
}

NPCs[123689] = {
    --------------------------------------------------------------------------------
    ---- Talestra the Vile
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 123689,
    questID = 48628, -- Unknown
    vignetteID = 2222,
}

NPCs[124775] = {
    --------------------------------------------------------------------------------
    ---- Commander Endaxis
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 124775,
    questID = 48564, -- Unknown
    vignetteID = 2200,
}

NPCs[124804] = {
    --------------------------------------------------------------------------------
    ---- Tereck the Selector
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 124804,
    questID = 48664, -- Unknown
    vignetteID = 2225,
}

NPCs[125388] = {
    --------------------------------------------------------------------------------
    ---- Vagath the Betrayed
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 125388,
    questID = 48629, -- Unknown
    vignetteID = 2223,
}

NPCs[125479] = {
    --------------------------------------------------------------------------------
    ---- Tar Spitter
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 125479,
    questID = 48665, -- Unknown
    vignetteID = 2227,
}

NPCs[125820] = {
    --------------------------------------------------------------------------------
    ---- Imp Mother Laglath
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 125820,
    questID = 48666, -- Unknown
    vignetteID = 2228,
}

NPCs[125824] = {
    --------------------------------------------------------------------------------
    ---- Khazaduum
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 125824,
    questID = 48561, -- Unknown
    vignetteID = 2197,
}

NPCs[126419] = {
    --------------------------------------------------------------------------------
    ---- Naroua
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    isTameable = true,
    mounts = {
        Mount.ScintillatingManaRay,
        Mount.FelglowManaRay,
        Mount.VibrantManaRay,
        Mount.DarksporeManaRay,
    },
    npcID = 126419,
    pets = {
        Pet.DocileSkyfin,
        Pet.FelAfflictedSkyfin,
    },
    questID = 48667, -- Unknown
    vignetteID = 2229,
}

--------------------------------------------------------------------------------
---- The Seat of the Triumvirate (903)
--------------------------------------------------------------------------------

NPCs[127882] = {
    --------------------------------------------------------------------------------
    ---- Vixx the Collector
    --------------------------------------------------------------------------------
    classification = NPCClassification.Rare,
    npcID = 127882,
    questID = -1, -- Unknown
    vignetteID = 2313,
}

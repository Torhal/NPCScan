-- ----------------------------------------------------------------------------
-- AddOn namespace
-- ----------------------------------------------------------------------------
local AddOnFolderName, private = ...
local NPCs = private.Data.NPCs
local NPCClassification = private.Enum.NPCClassification

-- ----------------------------------------------------------------------------
-- Dazar'alor
-- ----------------------------------------------------------------------------
NPCs[120899] = { -- Kul'krazahn
	achievementQuestID = 48333, -- Kul'krazahn
	classification = NPCClassification.Rare,
	vignetteID = 2038,
	worldQuestID = 50845, -- Kul'krazahn
}

NPCs[122639] = { -- Old R'gal
	classification = NPCClassification.RareElite,
	factionGroup = "Horde",
	questID = 50856, -- Old R'gal
	vignetteID = 2784,
	worldQuestID = 50855, -- Old R'gal
}

NPCs[125816] = { -- Sky Queen
	classification = NPCClassification.Rare,
	factionGroup = "Horde",
	questID = 53567,
	vignetteID = 3271,
	worldQuestID = 50858, -- Sky Queen
}

-- ----------------------------------------------------------------------------
-- Nazmir
-- ----------------------------------------------------------------------------
NPCs[121242] = { -- Glompmaw
	achievementQuestID = 50361, -- Glompmaw
	classification = NPCClassification.Rare,
	vignetteID = 2603,
	worldQuestID = 50496, -- Glompmaw
}

NPCs[124375] = { -- Overstuffed Saurolisk
	classification = NPCClassification.Rare,
	isTameable = true,
	questID = 47827,
	vignetteID = 2009,
	worldQuestID = 50510, -- Overstuffed Saurolisk
}

NPCs[124397] = { -- Kal'draxa
	achievementQuestID = 47843, -- Kal'draxa
	classification = NPCClassification.Rare,
	vignetteID = 2010,
	worldQuestID = 50505, -- Kal'draxa
}

NPCs[124399] = { -- Infected Direhorn
	achievementQuestID = 47877, -- Infected Direhorn
	classification = NPCClassification.Rare,
	vignetteID = 2013,
}

NPCs[124475] = { -- Shambling Ambusher
	classification = NPCClassification.Rare,
	questID = 47878,
	vignetteID = 2014, -- Abandoned Treasure
}

NPCs[125214] = { -- Krubbs
	achievementQuestID = 48052, -- Krubbs
	classification = NPCClassification.Rare,
	isTameable = true,
	vignetteID = 2028,
	worldQuestID = 50507, -- Krubbs
}

NPCs[125232] = { -- Captain Mu'kala
	achievementQuestID = 48057, -- Cursed Chest
	classification = NPCClassification.Rare,
	vignetteID = 2029, -- The Cursed Chest
	worldQuestID = 50492, -- Cursed Chest
}

NPCs[125250] = { -- Ancient Jawbreaker
	achievementQuestID = 48063, -- Ancient Jawbreaker
	classification = NPCClassification.Rare,
	isTameable = true,
	vignetteID = 2031,
	worldQuestID = 50488, -- Ancient Jawbreaker
}

NPCs[126056] = { -- Totem Maker Jash'ga
	achievementQuestID = 48406, -- Totem Maker Jash'ga
	classification = NPCClassification.Rare,
	vignetteID = 2068,
	worldQuestID = 50514, -- Totem Maker Jash'ga
}

NPCs[126142] = { -- Bajiatha
	achievementQuestID = 48439, -- Bajiatha
	classification = NPCClassification.Rare,
	isTameable = true,
	vignetteID = 2120,
	worldQuestID = 50511, -- Bajiatha
}

NPCs[126187] = { -- Corpse Bringer Yal'kar
	achievementQuestID = 48462, -- Corpse Bringer Yal'kar
	classification = NPCClassification.Rare,
	mounts = {
		{
			itemID = 163575, -- Reins of a Tamed Bloodfeaster
			spellID = 243795 -- Leaping Veinseeker
		}
	},
	vignetteID = 2130,
	worldQuestID = 50491, -- Corpse Bringer Yal'kar
}

NPCs[126460] = { -- Tainted Guardian
	achievementQuestID = 48508, -- Tainted Guardian
	classification = NPCClassification.Rare,
	vignetteID = 2192,
	worldQuestID = 50513, -- Tainted Guardian
}

NPCs[126635] = { -- Blood Priest Xak'lar
	achievementQuestID = 48541, -- Blood Priest Xak'lar
	classification = NPCClassification.Rare,
	vignetteID = 2195,
}

NPCs[126907] = { -- Wardrummer Zurula
	achievementQuestID = 48623, -- Wardrummer Zurula
	classification = NPCClassification.Rare,
	vignetteID = 2219,
	worldQuestID = 50516, -- Wardrummer Zurula
}

NPCs[126926] = { -- Venomjaw
	achievementQuestID = 48626, -- Venomjaw
	classification = NPCClassification.Rare,
	vignetteID = 2221,
	worldQuestID = 50515, -- Venomjaw
}

NPCs[127001] = { -- Gwugnug the Cursed
	achievementQuestID = 48638, -- Gwugnug the Cursed
	classification = NPCClassification.Rare,
	vignetteID = 2224,
	worldQuestID = 50499, -- Gwugnug
}

NPCs[127820] = { -- Scout Skrasniss
	achievementQuestID = 48972, -- Scout Skrasnis
	classification = NPCClassification.Rare,
	vignetteID = 2306,
	worldQuestID = 50512, -- Scout Skrasnis
}

NPCs[127873] = { -- Scrounger Patriarch
	achievementQuestID = 48980, -- Scrounger Patriarch
	classification = NPCClassification.Rare,
	vignetteID = 2310,
}

NPCs[128426] = { -- Gutrip
	achievementQuestID = 49231, -- Gutrip the Hungry
	classification = NPCClassification.Rare,
	vignetteID = 2337, -- Gutrip the Hungry
	worldQuestID = 50498, -- Gutrip
}

NPCs[128584] = { -- Vugthuth
	classification = NPCClassification.RareElite,
	questID = 50366,
	vignetteID = 2605,
	worldQuestID = 50459, -- Vugthuth
}

NPCs[128578] = { -- Zujothgul
	classification = NPCClassification.RareElite,
	questID = 50460, -- Zujothgul
	vignetteID = 2640,
	worldQuestID = 50461, -- Zujothgul
}

NPCs[128610] = { -- Maw of Shul-Nagruth
	classification = NPCClassification.RareElite,
	questID = 50467,
	vignetteID = 2642,
	worldQuestID = 50468, -- Shul-Nagruth
}

NPCs[128930] = { -- Rohnkor
	achievementQuestID = 50040, -- Mala'kili and Rohnkor
	classification = NPCClassification.Rare,
	vignetteID = 2529, -- Mala'kili and Rohnkor
	worldQuestID = 50517, -- Mala'kili and Rohnkor
}

NPCs[128935] = { -- Mala'kili
	achievementQuestID = 50040, -- Mala'kili and Rohnkor
	classification = NPCClassification.Rare,
	vignetteID = 2529, -- Mala'kili and Rohnkor
	worldQuestID = 50517, -- Mala'kili and Rohnkor
}

NPCs[128965] = { -- Uroku the Bound
	achievementQuestID = 49305, -- Uroku the Bound
	classification = NPCClassification.Rare,
	vignetteID = 2376,
	worldQuestID = 50490, -- Uroku the Bound
}

NPCs[128974] = { -- Queen Tzxi'kik
	achievementQuestID = 49312, -- Queen Tzxi'kik
	classification = NPCClassification.Rare,
	isTameable = true,
	vignetteID = 2381,
	worldQuestID = 50501, -- Queen Tzxi'kik
}

NPCs[129005] = { -- King Kooba
	achievementQuestID = 49317, -- King Kooba
	classification = NPCClassification.Rare,
	isTameable = true,
	vignetteID = 2383,
	worldQuestID = 50506, -- King Kooba
}

NPCs[129657] = { -- Za'amar the Queen's Blade
	achievementQuestID = 49469, -- Za'amar the Queen's Blade
	classification = NPCClassification.Rare,
	vignetteID = 2194,
	worldQuestID = 50519, -- Za'amar
}

NPCs[132701] = { -- T'zane
	classification = NPCClassification.RareElite,
	questID = 52996,
	vignetteID = -1,
	worldQuestID = 52181, -- Smoke and Shadow
}

NPCs[133373] = { -- Jax'teb the Reanimated
	achievementQuestID = 50307, -- Jax'teb the Reanimated
	classification = NPCClassification.Rare,
	vignetteID = 2593,
	worldQuestID = 50502, -- Jax'teb the Reanimated
}

NPCs[133505] = { -- Aiji the Accursed
	classification = NPCClassification.Elite,
	questID = 50339,
	vignetteID = 2796,
	worldQuestID = 50976, -- An Ancient Curse
}

NPCs[133527] = { -- Juba the Scarred
	achievementQuestID = 50342, -- Juba the Scarred
	classification = NPCClassification.Rare,
	vignetteID = 2599,
	worldQuestID = 50503, -- Juba the Scarred
}

NPCs[133531] = { -- Xu'ba
	achievementQuestID = 50348, -- Xu'ba the Bone Collector
	classification = NPCClassification.Rare,
	vignetteID = 2600, -- Xu'ba the Bone Collector
	worldQuestID = 50489, -- Xu'ba
}

NPCs[133539] = { -- Lo'kuno
	achievementQuestID = 50355, -- Lo'kuno
	classification = NPCClassification.Rare,
	vignetteID = 2601,
	worldQuestID = 50509,  -- Lo'kuno
}

NPCs[135565] = { -- Guardian of Agussu
	achievementQuestID = 50888, -- Urn of Agussu
	classification = NPCClassification.Normal,
	vignetteID = 2788, -- Urn of Agussu
}

NPCs[133812] = { -- Zanxib
	achievementQuestID = 50423, -- Zanxib the Engorged
	classification = NPCClassification.Rare,
	isTameable = true,
	vignetteID = 2630, -- Zanxib the Engorged
	worldQuestID = 50518, -- Zanxib
}

NPCs[134002] = { -- Underlord Xerxiz
	classification = NPCClassification.RareElite,
	questID = 50480, -- Underlord Xerxiz
	vignetteID = 2648,
	worldQuestID = 50483, -- Underlord Xerxiz
}

NPCs[134293] = { -- Azerite-Infused Slag
	achievementQuestID = 50563, -- Azerite Infused Slag
	classification = NPCClassification.Rare,
	vignetteID = 2658, -- Azerite Infused Slag
	worldQuestID = 50564, -- Azerite Infused Slag
}

NPCs[134294] = { -- Enraged Water Elemental
	achievementQuestID = 50565, -- Lost Scroll
	classification = NPCClassification.Rare,
	vignetteID = 2659, -- Lost Scroll
	worldQuestID = 50566, -- Lost Scroll
}

NPCs[134296] = { -- Lucille
	achievementQuestID = 50567, -- Chag's Challenge
	classification = NPCClassification.Rare,
	vignetteID = 2660, -- Chag's Challenge
	worldQuestID = 50568, -- Chag's Challenge
}

NPCs[134298] = { -- Azerite-Infused Elemental
	achievementQuestID = 50569, -- Azerite Infused Elemental
	classification = NPCClassification.Rare,
	vignetteID = 2661, -- Azerite Infused Elemental
	worldQuestID = 50570, -- Azerite Infused Elemental
}

NPCs[143311] = { -- Toadcruel
	classification = NPCClassification.Rare,
	questID = -1,
	vignetteID = -1,
}

NPCs[143316] = { -- Skullcap
	classification = NPCClassification.Rare,
	questID = -1,
	vignetteID = -1,
}

NPCs[143898] = { -- Makatau
	classification = NPCClassification.Elite,
	questID = -1,
	vignetteID = -1,
}

-- ----------------------------------------------------------------------------
-- Vol'dun
-- ----------------------------------------------------------------------------
NPCs[124722] = { -- Commodore Calhoun
	classification = NPCClassification.Rare,
	questID = 50905, -- Commodore Calhoun
	vignetteID = 2797,
	worldQuestID = 51098, -- Commodore Calhoun
}

NPCs[127776] = { -- Scaleclaw Broodmother
	classification = NPCClassification.Rare,
	isTameable = true,
	questID = 48960,
	vignetteID = 2298,
	worldQuestID = 48656, -- Savage Saurolisks
}

NPCs[128497] = { -- Bajiani the Slick
	classification = NPCClassification.Rare,
	questID = 49251, -- Bajiani the Slick
	vignetteID = 2351,
	worldQuestID = 51117, -- Bajiani the Slick
}

NPCs[128553] = { -- Azer'tor
	classification = NPCClassification.Rare,
	questID = 49252,
	vignetteID = 2352,
	worldQuestID = 51096, -- Azer'tor
}

NPCs[128674] = { -- Gut-Gut the Glutton
	classification = NPCClassification.Rare,
	questID = 49270, -- Gut-Gut the Glutton
	vignetteID = 2361,
	worldQuestID = 51099, -- Gut-Gut the Glutton
}

NPCs[128686] = { -- Kamid the Trapper
	classification = NPCClassification.Rare,
	questID = 50528,
	vignetteID = 2655,
	worldQuestID = 51102, -- Kamid the Trapper
}

NPCs[128951] = { -- Nez'ara
	classification = NPCClassification.Rare,
	questID = 50898,
	vignetteID = 2795,
	worldQuestID = 51103, -- Nez'ara
}

NPCs[129027] = { -- Golanar
	classification = NPCClassification.RareElite,
	questID = 50362,
	vignetteID = 2604,
	worldQuestID = 51157, -- Golanar
}

NPCs[129180] = { -- Warbringer Hozzik
	classification = NPCClassification.Rare,
	questID = 49373,
	vignetteID = 2391,
	worldQuestID = 51112, -- Warbringer Hozzik
}

NPCs[129283] = { -- Jumbo Sandsnapper
	classification = NPCClassification.Rare,
	isTameable = true,
	questID = 49392,
	vignetteID = 2406,
	worldQuestID = 51100, -- Jumbo Sandsnapper
}

NPCs[129411] = { -- Zunashi the Exile
	classification = NPCClassification.Rare,
	questID = 48319,
	vignetteID = 2410,
	worldQuestID = 51115, -- Zunashi the Exile
}

NPCs[129476] = { -- Bloated Krolusk
	classification = NPCClassification.Rare,
	questID = 47562,
	vignetteID = 2411, -- Bloated Ruincrawler
	worldQuestID = 51097, -- Bloated Ruincrawler
}

NPCs[130401] = { -- Vathikur
	classification = NPCClassification.Rare,
	questID = 49674,
	vignetteID = 2445,
	worldQuestID = 51119, -- Vathikur
}

NPCs[130439] = { -- Ashmane
	classification = NPCClassification.Rare,
	isTameable = true,
	questID = 47532, -- Ashmane
	vignetteID = 2446,
	worldQuestID = 51095, -- Ashmane
}

NPCs[130443] = { -- Hivemother Kraxi
	classification = NPCClassification.Rare,
	isTameable = true,
	questID = 47533,
	vignetteID = 2447,
	worldQuestID = 51108, -- Hivemother Kraxi
}

NPCs[133843] = { -- First Mate Swainbeak
	classification = NPCClassification.Rare,
	questID = 51073, -- Stef "Marrow" Quin
	vignetteID = 2889,
	worldQuestID = 51120, -- Stef "Marrow" Quin
}

NPCs[134571] = { -- Skycaller Teskris
	classification = NPCClassification.Rare,
	questID = 50637,
	vignetteID = 2668,
	worldQuestID = 51104, -- Skycaller Teskris
}

NPCs[134625] = { -- Warmother Captive
	classification = NPCClassification.Rare,
	questID = 50658,
	vignetteID = 2672,
	worldQuestID = 51114, -- Warmother Captive
}

NPCs[134638] = { -- Warlord Zothix
	classification = NPCClassification.Rare,
	questID = 50662,
	vignetteID = 2674,
	worldQuestID = 51113, -- Warlord Zothix
}

NPCs[134643] = { -- Brgl-Lrgl the Basher
	classification = NPCClassification.RareElite,
	questID = 50663,
	vignetteID = 2675,
	worldQuestID = 51155, -- Brgl-Lrgl the Basher
}

NPCs[134694] = { -- Mor'fani the Exile
	classification = NPCClassification.RareElite,
	questID = 50666,
	vignetteID = 2677,
	worldQuestID = 51153, -- Mor'fani the Exile
}

NPCs[134745] = { -- Skycarver Krakit
	classification = NPCClassification.Rare,
	questID = 50686,
	vignetteID = 2683,
	worldQuestID = 51116, -- Skycarver Krakit
}

NPCs[135852] = { -- Ak'tar
	classification = NPCClassification.Rare,
	questID = 51058, -- Ak'tar
	vignetteID = 2885,
	worldQuestID = 51105, -- Ak'tar
}

NPCs[136304] = { -- Songstress Nahjeen
	classification = NPCClassification.Rare,
	questID = 51063,
	vignetteID = 2886,
	worldQuestID = 51106, -- Songstress Nahjeen
}

NPCs[136323] = { -- Fangcaller Xorreth
	classification = NPCClassification.RareElite,
	questID = 51065, -- Fangcaller Xorreth
	vignetteID = 2887,
	worldQuestID = 51156, -- Fangcaller Xorreth
}

NPCs[136335] = { -- Enraged Krolusk
	classification = NPCClassification.Rare,
	isTameable = true,
	questID = 51077, -- Enraged Krolusk
	vignetteID = 2893,
	worldQuestID = 51121, -- Enraged Krolusk
}

NPCs[136336] = { -- Scorpox
	classification = NPCClassification.Rare,
	isTameable = true,
	questID = 51076,
	vignetteID = 2892,
	worldQuestID = 51122, -- Scorpox
}

NPCs[136338] = { -- Sirokar
	classification = NPCClassification.Rare,
	questID = 51075,
	vignetteID = 2891,
	worldQuestID = 51123, -- Sirokar
}

NPCs[136340] = { -- Relic Hunter Hazaak
	classification = NPCClassification.Rare,
	questID = 51126,
	vignetteID = 2899,
	worldQuestID = 51124, -- Relic Hunter Hazaak
}

NPCs[136341] = { -- Jungleweb Hunter
	classification = NPCClassification.Rare,
	isTameable = true,
	questID = 51074,
	vignetteID = 2890,
	worldQuestID = 51125, -- Jungleweb Hunter
}

NPCs[136346] = { -- Captain Stef "Marrow" Quin
	classification = NPCClassification.Rare,
	questID = 51073, -- Stef "Marrow" Quin
	vignetteID = 2889,
	worldQuestID = 51120, -- Stef "Marrow" Quin
}

NPCs[136393] = { -- Bloodwing Bonepicker
	classification = NPCClassification.Rare,
	isTameable = true,
	questID = 51079, -- Bloodwing Bonepicker
	vignetteID = 2894,
	worldQuestID = 51118, -- Bloodwing Bonepicker
}

NPCs[137553] = { -- General Krathax
	classification = NPCClassification.Rare,
	questID = -1,
	vignetteID = -1,
}

NPCs[137681] = { -- King Clickyclack
	classification = NPCClassification.Rare,
	isTameable = true,
	questID = 51424,
	vignetteID = 2954,
	worldQuestID = 51429, -- King Clickyclack
}

NPCs[138794] = { -- Dunegorger Kraulok
	classification = NPCClassification.RareElite,
	isTameable = true,
	mounts = {
		{
			itemID = 174842, -- Slightly Damp Pile of Fur
			spellID = 298367, -- Mollie
		},
	},
	questID = -1,
	vignetteID = -1,
	worldQuestID = 52196, -- Sandswept Bones
}

NPCs[143313] = { -- Portakillo
	classification = NPCClassification.Rare,
	questID = -1,
	vignetteID = -1,
}

-- ----------------------------------------------------------------------------
-- Zuldazar
-- ----------------------------------------------------------------------------
NPCs[122004] = { -- Umbra'jin
	classification = NPCClassification.Rare,
	questID = 47567,
	vignetteID = 1998,
	worldQuestID = 50854, -- Crimsonclaw
}

NPCs[123502] = { -- King K'tal
	classification = NPCClassification.Elite,
	questID = -1,
	vignetteID = -1,
}

NPCs[124185] = { -- Golrakahn
	achievementQuestID = 47792, -- Golrakahn
	classification = NPCClassification.Rare,
	vignetteID = 2004,
	worldQuestID = 50857, -- Golrakahn
}

NPCs[126637] = { -- Kandak
	achievementQuestID = 48543, -- Kandak
	classification = NPCClassification.Rare,
	vignetteID = 2196,
	worldQuestID = 50859, -- Kandak
}

NPCs[127939] = { -- Torraske the Eternal
	achievementQuestID = 49004, -- Torraske the Eternal
	classification = NPCClassification.Rare,
	isTameable = true,
	vignetteID = 2314, -- Torrsake the Eternal
	worldQuestID = 50861, -- Torraske the Eternal
}

NPCs[128699] = { -- Bloodbulge
	achievementQuestID = 49267, -- Bloodbulge
	classification = NPCClassification.Rare,
	vignetteID = 2359,
	worldQuestID = 50862, -- Bloodbulge
}

NPCs[129323] = { -- Sabertusk Empress
	classification = NPCClassification.Elite,
	questID = -1,
	vignetteID = -1,
}

NPCs[129343] = { -- Avatar of Xolotal
	achievementQuestID = 49410, -- Avatar of Xolotal
	classification = NPCs.Rare,
	vignetteID = 2407,
	worldQuestID = 50863, -- Avatar of Xolotal
}

NPCs[129954] = { -- Gahz'ralka
	achievementQuestID = 50439, -- Gahz'ralka
	classification = NPCClassification.Rare,
	vignetteID = 2636,
	worldQuestID = 50877, -- Gahz'ralka
}

NPCs[129961] = { -- Atal'zul Gotaka
	achievementQuestID = 50280, -- Atal'zul Gotaka
	classification = NPCClassification.Rare,
	vignetteID = 2588,
	worldQuestID = 50864, -- Atal'zul Gotaka
}

NPCs[130643] = { -- Twisted Child of Rezan
	classification = NPCClassification.RareElite,
	questID = 50333, -- Twisted Child of Rezan
	vignetteID = 2597,
	worldQuestID = 50847, -- Twisted Child of Rezan
}

NPCs[130741] = { -- Nol'ixwan
	classification = NPCClassification.Elite,
	questID = -1,
	vignetteID = -1,
}

NPCs[131233] = { -- Lei-zhi
	achievementQuestID = 49911, -- Lei-Zhi
	classification = NPCClassification.Rare,
	vignetteID = 2496,
	worldQuestID = 50885, -- Lei-zhi
}

NPCs[131476] = { -- Zayoos
	achievementQuestID = 49972, -- Zayoos
	classification = NPCClassification.Rare,
	vignetteID = 2513,
	worldQuestID = 50866, -- Zayoos
}

NPCs[131687] = { -- Tambano
	achievementQuestID = 50013, -- Tambano
	classification = NPCClassification.Rare,
	isTameable = true,
	vignetteID = 2524,
	worldQuestID = 50867, -- Tambano
}

NPCs[131704] = { -- Coati
	classification = NPCClassification.RareElite,
	isTameable = true,
	questID = 50846,
	vignetteID = 2525,
	worldQuestID = 50846, -- Headhunter Lee'za
}

NPCs[131718] = { -- Bramblewing
	achievementQuestID = 50034, -- Bramblewing
	classification = NPCClassification.Rare,
	vignetteID = 2527,
	worldQuestID = 50868, -- Bramblewing
}

NPCs[132244] = { -- Kiboku
	achievementQuestID = 50159, -- Kiboku
	classification = NPCClassification.Rare,
	isTameable = true,
	vignetteID = 2548,
	worldQuestID = 50869, -- Kiboku
}

NPCs[132253] = { -- Ji'arak
	classification = NPCClassification.RareElite,
	vignetteID = -1,
	worldQuestID = 52169, -- The Matriarch
}

NPCs[133155] = { -- G'Naat
	achievementQuestID = 50260, -- G'Naat
	classification = NPCClassification.Rare,
	vignetteID = 2581,
	worldQuestID = 50870, -- G'Naat
}

NPCs[133163] = { -- Tia'Kawan
	classification = NPCClassification.RareElite,
	questID = 50263,
	vignetteID = 2584,
	worldQuestID = 50850,
}

NPCs[133190] = { -- Daggerjaw
	achievementQuestID = 50269, -- Daggerjaw
	classification = NPCClassification.Rare,
	vignetteID = 2587,
	worldQuestID = 50871, -- Daggerjaw
}

NPCs[133842] = { -- Warcrawler Karkithiss
	achievementQuestID = 50438, -- Warcrawler Karkithiss
	classification = NPCClassification.Rare,
	vignetteID = 2635,
	worldQuestID = 50872, -- Warcrawler Karkithiss
}

NPCs[134048] = { -- Vukuba
	achievementQuestID = 50508, -- Vukuba
	classification = NPCClassification.Rare,
	vignetteID = 2650, -- Strange Egg
	worldQuestID = 50873, -- Strange Egg
}

NPCs[134637] = { -- Headhunter Lee'za
	classification = NPCClassification.RareElite,
	questID = 50661, -- Headhunter Lee'za
	vignetteID = 2673,
	worldQuestID = 50846, -- Headhunter Lee'za
}

NPCs[134717] = { -- Umbra'rix
	classification = NPCClassification.RareElite,
	questID = 50673, -- Umbra'rix
	vignetteID = 2680,
	worldQuestID = 50853, -- Umbra'rix
}

NPCs[134738] = { -- Hakbi the Risen
	achievementQuestID = 50677, -- Hakbi the Risen
	classification = NPCClassification.Rare,
	vignetteID = 2682,
	worldQuestID = 50874, -- Hakbi the Risen
}

NPCs[134760] = { -- Darkspeaker Jo'la
	achievementQuestID = 50693, -- Darkspeaker Jo'la
	classification = NPCClassification.Rare,
	vignetteID = 2685,
	worldQuestID = 50875, -- Darkspeaker Jo'la
}

NPCs[134782] = { -- Murderbeak
	achievementQuestID = 50281, -- Murderbeak
	classification = NPCClassification.Rare,
	vignetteID = 2651, -- Chum Bucket
	worldQuestID = 50876, -- Murderbeak
}

NPCs[135510] = { -- Azuresail the Ancient
	classification = NPCClassification.Elite,
	isTameable = true,
	questID = -1,
	vignetteID = -1,
}

NPCs[139365] = { -- Queenfeather
	classification = NPCClassification.Normal,
	isTameable = true,
	questID = -1,
	vignetteID = -1,
}

NPCs[135512] = { -- Thunderfoot
	classification = NPCClassification.Elite,
	questID = -1,
	vignetteID = -1,
}

NPCs[136413] = { -- Syrawon the Dominus
	achievementQuestID = 51080, -- Syrawon the Dominus
	classification = NPCClassification.Rare,
	vignetteID = 2895, -- Tehd & Marius
	worldQuestID = 51081, -- Syrawon the Dominus
}

NPCs[136428] = { -- Dark Chronicler
	achievementQuestID = 51083, -- Dark Chronicler
	classification = NPCClassification.Rare,
	vignetteID = 2897,
	worldQuestID = 51084, -- Dark Chronicler
}

NPCs[143314] = { -- Bane of the Woods
	classification = NPCClassification.Rare,
	questID = -1,
	vignetteID = -1,
}

NPCs[143536] = { -- High Warlord Volrath
	classification = NPCClassification.RareElite,
	factionGroup = "Horde",
	questID = -1,
	vignetteID = -1,
}

NPCs[143910] = { -- Sludgecrusher
	classification = NPCClassification.Elite,
	questID = -1,
	vignetteID = -1,
}

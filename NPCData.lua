-------------------------------------------------------------------------------
-- Localized Lua globals.
-------------------------------------------------------------------------------
local _G = getfenv(0)

-- Functions
local pairs = _G.pairs
local tostring = _G.tostring
local type = _G.type

-- Libraries
local string = _G.string
local table = _G.table


-------------------------------------------------------------------------------
-- AddOn namespace.
-------------------------------------------------------------------------------
local FOLDER_NAME, private = ...
local L = private.L
local ZN = private.ZONE_NAMES

local NPC_DATA = {
	[61] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.ELWYNN_FOREST, }, -- Thuros Lightfingers
	[62] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.NORTHSHIRE, }, -- Gug Fatcandle
	[79] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.ELWYNN_FOREST, }, -- Narg the Taskmaster
	[99] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.ELWYNN_FOREST, }, -- Morgaine the Sly
	[100] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.ELWYNN_FOREST, }, -- Gruff Swiftbite
	[462] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.WESTFALL, is_tamable = true, }, -- Vultros
	[471] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.ELWYNN_FOREST, is_tamable = true, }, -- Mother Fang
	[472] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.ELWYNN_FOREST, }, -- Fedfennel
	[506] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.WESTFALL, }, -- Sergeant Brashclaw
	[507] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.DUSKWOOD, }, -- Fenros
	[519] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.WESTFALL, }, -- Slark
	[520] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.WESTFALL, }, -- Brack
	[521] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.DUSKWOOD, is_tamable = true, }, -- Lupos
	[534] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.DUSKWOOD, }, -- Nefaru
	[572] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.WESTFALL, }, -- Leprithus
	[573] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.WESTFALL, }, -- Foe Reaper 4000
	[574] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.DUSKWOOD, is_tamable = true, }, -- Naraxis
	[584] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.REDRIDGE_MOUNTAINS, }, -- Kazon
	[596] = { world_id = ZN.THE_DEADMINES, map_name = ZN.THE_DEADMINES, }, -- Brainwashed Noble
	[599] = { world_id = ZN.THE_DEADMINES, map_name = ZN.THE_DEADMINES, }, -- Marisa du'Paige
	[616] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.REDRIDGE_MOUNTAINS, is_tamable = true, }, -- Chatter
	[763] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.SWAMP_OF_SORROWS, }, -- Lost One Chieftain
	[947] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.REDRIDGE_MOUNTAINS, }, -- Rohh the Silent
	[1063] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.SWAMP_OF_SORROWS, }, -- Jade
	[1106] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.SWAMP_OF_SORROWS, }, -- Lost One Cook
	[1112] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.WETLANDS, is_tamable = true, }, -- Leech Widow
	[1119] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.DUN_MOROGH, }, -- Hammerspine
	[1130] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.DUN_MOROGH, is_tamable = true, }, -- Bjarn
	[1132] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.NEW_TINKERTOWN, is_tamable = true, }, -- Timber
	[1137] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.DUN_MOROGH, }, -- Edan the Howler
	[1140] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.WETLANDS, is_tamable = true, }, -- Razormaw Matriarch
	[1260] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.DUN_MOROGH, }, -- Great Father Arctikus
	[1398] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.LOCH_MODAN, }, -- Boss Galgosh
	[1399] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.LOCH_MODAN, }, -- Magosh
	[1424] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.WESTFALL, }, -- Master Digger
	[1425] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.LOCH_MODAN, }, -- Kubb
	[1531] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.TIRISFAL_GLADES, }, -- Lost Soul
	[1533] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.TIRISFAL_GLADES, }, -- Tormented Spirit
	[1552] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.THE_CAPE_OF_STRANGLETHORN, is_tamable = true, }, -- Scale Belly
	[1837] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.WESTERN_PLAGUELANDS, }, -- Scarlet Judge
	[1838] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.WESTERN_PLAGUELANDS, }, -- Scarlet Interrogator
	[1839] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.WESTERN_PLAGUELANDS, }, -- Scarlet High Clerist
	[1841] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.WESTERN_PLAGUELANDS, }, -- Scarlet Executioner
	[1843] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.EASTERN_PLAGUELANDS, }, -- Foreman Jerris
	[1844] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.EASTERN_PLAGUELANDS, }, -- Foreman Marcrid
	[1847] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.WESTERN_PLAGUELANDS, }, -- Foulmane
	[1848] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.WESTERN_PLAGUELANDS, }, -- Lord Maldazzar
	[1849] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.WESTERN_PLAGUELANDS, }, -- Dreadwhisper
	[1850] = { world_id = ZN.SCHOLOMANCE, map_name = ZN.SCHOLOMANCE, }, -- Putridius
	[1851] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.WESTERN_PLAGUELANDS, }, -- The Husk
	[1885] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.WESTERN_PLAGUELANDS, }, -- Scarlet Smith
	[1910] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.TIRISFAL_GLADES, }, -- Muad
	[1911] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.TIRISFAL_GLADES, }, -- Deeb
	[1936] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.TIRISFAL_GLADES, }, -- Farmer Solliden
	[2090] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.WETLANDS, }, -- Ma'ruk Wyrmscale
	[2108] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.WETLANDS, }, -- Garneg Charskull
	[2162] = { world_id = ZN.KALIMDOR, map_name = ZN.TELDRASSIL, }, -- Agal
	[2172] = { world_id = ZN.KALIMDOR, map_name = ZN.DARKSHORE, is_tamable = true, }, -- Strider Clutchmother
	[2175] = { world_id = ZN.KALIMDOR, map_name = ZN.DARKSHORE, is_tamable = true, }, -- Shadowclaw
	[2184] = { world_id = ZN.KALIMDOR, map_name = ZN.DARKSHORE, }, -- Lady Moongazer
	[2186] = { world_id = ZN.KALIMDOR, map_name = ZN.DARKSHORE, }, -- Carnivous the Breaker
	[2191] = { world_id = ZN.KALIMDOR, map_name = ZN.DARKSHORE, }, -- Licillin
	[2192] = { world_id = ZN.KALIMDOR, map_name = ZN.DARKSHORE, }, -- Firecaller Radison
	[2258] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.HILLSBRAD_FOOTHILLS, }, -- Maggarrak
	[2452] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.HILLSBRAD_FOOTHILLS, }, -- Skhowl
	[2453] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.HILLSBRAD_FOOTHILLS, }, -- Lo'Grosh
	[2476] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.LOCH_MODAN, is_tamable = true, }, -- Gosh-Haldir
	[2541] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.THE_CAPE_OF_STRANGLETHORN, }, -- Lord Sakrasis
	[2598] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.ARATHI_HIGHLANDS, }, -- Darbel Montrose
	[2600] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.ARATHI_HIGHLANDS, }, -- Singer
	[2601] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.ARATHI_HIGHLANDS, }, -- Foulbelly
	[2602] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.ARATHI_HIGHLANDS, }, -- Ruul Onestone
	[2603] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.ARATHI_HIGHLANDS, }, -- Kovork
	[2604] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.ARATHI_HIGHLANDS, }, -- Molok the Crusher
	[2605] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.ARATHI_HIGHLANDS, }, -- Zalas Witherbark
	[2606] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.ARATHI_HIGHLANDS, }, -- Nimar the Slayer
	[2609] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.ARATHI_HIGHLANDS, }, -- Geomancer Flintdagger
	[2744] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.BADLANDS, }, -- Shadowforge Commander
	[2749] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.BADLANDS, }, -- Barricade
	[2751] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.BADLANDS, }, -- War Golem
	[2752] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.BADLANDS, }, -- Rumbler
	[2753] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.BADLANDS, is_tamable = true, }, -- Barnabus
	[2754] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.BADLANDS, }, -- Anathemus
	[2779] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.ARATHI_HIGHLANDS, }, -- Prince Nazjak
	[2850] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.BADLANDS, is_tamable = true, }, -- Broken Tooth
	[2931] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.BADLANDS, is_tamable = true, }, -- Zaricotl
	[3058] = { world_id = ZN.KALIMDOR, map_name = ZN.MULGORE, }, -- Arra'chea
	[3068] = { world_id = ZN.KALIMDOR, map_name = ZN.MULGORE, is_tamable = true, }, -- Mazzranache
	[3253] = { world_id = ZN.KALIMDOR, map_name = ZN.SOUTHERN_BARRENS, is_tamable = true, }, -- Silithid Harvester
	[3270] = { world_id = ZN.KALIMDOR, map_name = ZN.NORTHERN_BARRENS, }, -- Elder Mystic Razorsnout
	[3295] = { world_id = ZN.KALIMDOR, map_name = ZN.NORTHERN_BARRENS, }, -- Sludge Anomaly
	[3398] = { world_id = ZN.KALIMDOR, map_name = ZN.NORTHERN_BARRENS, }, -- Gesharahan
	[3470] = { world_id = ZN.KALIMDOR, map_name = ZN.NORTHERN_BARRENS, }, -- Rathorian
	[3535] = { world_id = ZN.KALIMDOR, map_name = ZN.TELDRASSIL, }, -- Blackmoss the Fetid
	[3581] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.STORMWIND_CITY, is_tamable = true, }, -- Sewer Beast
	[3652] = { world_id = ZN.KALIMDOR, map_name = ZN.NORTHERN_BARRENS, }, -- Trigore the Lasher
	[3672] = { world_id = ZN.KALIMDOR, map_name = ZN.NORTHERN_BARRENS, }, -- Boahn
	[3735] = { world_id = ZN.KALIMDOR, map_name = ZN.ASHENVALE, }, -- Apothecary Falthis
	[3736] = { world_id = ZN.KALIMDOR, map_name = ZN.ASHENVALE, }, -- Darkslayer Mordenthal
	[3773] = { world_id = ZN.KALIMDOR, map_name = ZN.ASHENVALE, }, -- Akkrilus
	[3792] = { world_id = ZN.KALIMDOR, map_name = ZN.ASHENVALE, }, -- Terrowulf Packlord
	[3872] = { world_id = ZN.SHADOWFANG_KEEP, map_name = ZN.SHADOWFANG_KEEP, }, -- Deathsworn Captain
	[4066] = { world_id = ZN.KALIMDOR, map_name = ZN.STONETALON_MOUNTAINS, }, -- Nal'taszar
	[4132] = { world_id = ZN.KALIMDOR, map_name = ZN.THOUSAND_NEEDLES, is_tamable = true, }, -- Krkk'kx
	[4339] = { world_id = ZN.KALIMDOR, map_name = ZN.DUSTWALLOW_MARSH, }, -- Brimgore
	[4380] = { world_id = ZN.KALIMDOR, map_name = ZN.DUSTWALLOW_MARSH, is_tamable = true, }, -- Darkmist Widow
	[4425] = { world_id = ZN.RAZORFEN_KRAUL, map_name = ZN.RAZORFEN_KRAUL, is_tamable = true, }, -- Blind Hunter
	[4842] = { world_id = ZN.RAZORFEN_KRAUL, map_name = ZN.RAZORFEN_KRAUL, }, -- Earthcaller Halmgar
	[5343] = { world_id = ZN.KALIMDOR, map_name = ZN.FERALAS, }, -- Lady Szallah
	[5345] = { world_id = ZN.KALIMDOR, map_name = ZN.FERALAS, }, -- Diamond Head
	[5346] = { world_id = ZN.KALIMDOR, map_name = ZN.FERALAS, }, -- Bloodroar the Stalker
	[5347] = { world_id = ZN.KALIMDOR, map_name = ZN.FERALAS, }, -- Antilus the Soarer
	[5348] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.SWAMP_OF_SORROWS, }, -- Dreamwatcher Forktongue
	[5349] = { world_id = ZN.KALIMDOR, map_name = ZN.FERALAS, is_tamable = true, }, -- Arash-ethis
	[5350] = { world_id = ZN.KALIMDOR, map_name = ZN.FERALAS, is_tamable = true, }, -- Qirot
	[5352] = { world_id = ZN.KALIMDOR, map_name = ZN.FERALAS, is_tamable = true, }, -- Old Grizzlegut
	[5354] = { world_id = ZN.KALIMDOR, map_name = ZN.FERALAS, }, -- Gnarl Leafbrother
	[5356] = { world_id = ZN.KALIMDOR, map_name = ZN.FERALAS, is_tamable = true, }, -- Snarler
	[5785] = { world_id = ZN.KALIMDOR, map_name = ZN.MULGORE, }, -- Sister Hatelash
	[5786] = { world_id = ZN.KALIMDOR, map_name = ZN.MULGORE, }, -- Snagglespear
	[5787] = { world_id = ZN.KALIMDOR, map_name = ZN.MULGORE, }, -- Enforcer Emilgund
	[5807] = { world_id = ZN.KALIMDOR, map_name = ZN.MULGORE, is_tamable = true, }, -- The Rake
	[5809] = { world_id = ZN.KALIMDOR, map_name = ZN.DUROTAR, }, -- Sergeant Curtis
	[5822] = { world_id = ZN.KALIMDOR, map_name = ZN.DUROTAR, }, -- Felweaver Scornn
	[5823] = { world_id = ZN.KALIMDOR, map_name = ZN.DUROTAR, is_tamable = true, }, -- Death Flayer
	[5824] = { world_id = ZN.KALIMDOR, map_name = ZN.DUROTAR, }, -- Captain Flat Tusk
	[5826] = { world_id = ZN.KALIMDOR, map_name = ZN.DUROTAR, }, -- Geolord Mottle
	[5828] = { world_id = ZN.KALIMDOR, map_name = ZN.NORTHERN_BARRENS, is_tamable = true, }, -- Humar the Pridelord
	[5829] = { world_id = ZN.KALIMDOR, map_name = ZN.SOUTHERN_BARRENS, is_tamable = true, }, -- Snort the Heckler
	[5830] = { world_id = ZN.KALIMDOR, map_name = ZN.NORTHERN_BARRENS, }, -- Sister Rathtalon
	[5831] = { world_id = ZN.KALIMDOR, map_name = ZN.NORTHERN_BARRENS, }, -- Swiftmane
	[5834] = { world_id = ZN.KALIMDOR, map_name = ZN.SOUTHERN_BARRENS, is_tamable = true, }, -- Azzere the Skyblade
	[5835] = { world_id = ZN.KALIMDOR, map_name = ZN.NORTHERN_BARRENS, }, -- Foreman Grills
	[5836] = { world_id = ZN.KALIMDOR, map_name = ZN.NORTHERN_BARRENS, }, -- Engineer Whirleygig
	[5837] = { world_id = ZN.KALIMDOR, map_name = ZN.NORTHERN_BARRENS, }, -- Stonearm
	[5838] = { world_id = ZN.KALIMDOR, map_name = ZN.NORTHERN_BARRENS, }, -- Brokespear
	[5841] = { world_id = ZN.KALIMDOR, map_name = ZN.NORTHERN_BARRENS, }, -- Rocklance
	[5842] = { world_id = ZN.KALIMDOR, map_name = ZN.NORTHERN_BARRENS, is_tamable = true, }, -- Takk the Leaper
	[5847] = { world_id = ZN.KALIMDOR, map_name = ZN.SOUTHERN_BARRENS, }, -- Heggin Stonewhisker
	[5848] = { world_id = ZN.KALIMDOR, map_name = ZN.SOUTHERN_BARRENS, }, -- Malgin Barleybrew
	[5849] = { world_id = ZN.KALIMDOR, map_name = ZN.SOUTHERN_BARRENS, }, -- Digger Flameforge
	[5851] = { world_id = ZN.KALIMDOR, map_name = ZN.SOUTHERN_BARRENS, }, -- Captain Gerogg Hammertoe
	[5859] = { world_id = ZN.KALIMDOR, map_name = ZN.SOUTHERN_BARRENS, }, -- Hagg Taurenbane
	[5863] = { world_id = ZN.KALIMDOR, map_name = ZN.SOUTHERN_BARRENS, }, -- Geopriest Gukk'rok
	[5864] = { world_id = ZN.KALIMDOR, map_name = ZN.SOUTHERN_BARRENS, }, -- Swinegart Spearhide
	[5865] = { world_id = ZN.KALIMDOR, map_name = ZN.NORTHERN_BARRENS, is_tamable = true, }, -- Dishu
	[5912] = { world_id = ZN.WAILING_CAVERNS, map_name = ZN.WAILING_CAVERNS, }, -- Deviate Faerie Dragon
	[5915] = { world_id = ZN.KALIMDOR, map_name = ZN.STONETALON_MOUNTAINS, }, -- Brother Ravenoak
	[5928] = { world_id = ZN.KALIMDOR, map_name = ZN.STONETALON_MOUNTAINS, }, -- Sorrow Wing
	[5930] = { world_id = ZN.KALIMDOR, map_name = ZN.STONETALON_MOUNTAINS, }, -- Sister Riven
	[5932] = { world_id = ZN.KALIMDOR, map_name = ZN.STONETALON_MOUNTAINS, }, -- Taskmaster Whipfang
	[5933] = { world_id = ZN.KALIMDOR, map_name = ZN.THOUSAND_NEEDLES, }, -- Achellios the Banished
	[5935] = { world_id = ZN.KALIMDOR, map_name = ZN.THOUSAND_NEEDLES, }, -- Ironeye the Invincible
	[5937] = { world_id = ZN.KALIMDOR, map_name = ZN.THOUSAND_NEEDLES, is_tamable = true, }, -- Vile Sting
	[6118] = { world_id = ZN.KALIMDOR, map_name = ZN.AZSHARA, }, -- Varo'then's Ghost
	[6228] = { world_id = ZN.GNOMEREGAN, map_name = ZN.GNOMEREGAN, }, -- Dark Iron Ambassador
	[6581] = { world_id = ZN.KALIMDOR, map_name = ZN.UNGORO_CRATER, is_tamable = true, }, -- Ravasaur Matriarch
	[6582] = { world_id = ZN.KALIMDOR, map_name = ZN.UNGORO_CRATER, is_tamable = true, }, -- Clutchmother Zavas
	[6583] = { world_id = ZN.KALIMDOR, map_name = ZN.UNGORO_CRATER, }, -- Gruff
	[6584] = { world_id = ZN.KALIMDOR, map_name = ZN.UNGORO_CRATER, is_tamable = true, }, -- King Mosh
	[6585] = { world_id = ZN.KALIMDOR, map_name = ZN.UNGORO_CRATER, is_tamable = true, }, -- Uhk'loc
	[6648] = { world_id = ZN.KALIMDOR, map_name = ZN.AZSHARA, }, -- Antilos
	[6649] = { world_id = ZN.KALIMDOR, map_name = ZN.AZSHARA, }, -- Lady Sesspira
	[6650] = { world_id = ZN.KALIMDOR, map_name = ZN.AZSHARA, }, -- General Fangferror
	[6651] = { world_id = ZN.KALIMDOR, map_name = ZN.AZSHARA, }, -- Gatekeeper Rageroar
	[7015] = { world_id = ZN.KALIMDOR, map_name = ZN.DARKSHORE, }, -- Flagglemurk the Cruel
	[7016] = { world_id = ZN.KALIMDOR, map_name = ZN.DARKSHORE, }, -- Lady Vespira
	[7017] = { world_id = ZN.KALIMDOR, map_name = ZN.DARKSHORE, }, -- Lord Sinslayer
	[7104] = { world_id = ZN.KALIMDOR, map_name = ZN.FELWOOD, }, -- Dessecus
	[7137] = { world_id = ZN.KALIMDOR, map_name = ZN.FELWOOD, }, -- Immolatus
	[7846] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.BLASTED_LANDS, }, -- Teremus the Devourer
	[8199] = { world_id = ZN.KALIMDOR, map_name = ZN.TANARIS, }, -- Warleader Krazzilak
	[8200] = { world_id = ZN.KALIMDOR, map_name = ZN.TANARIS, }, -- Jin'Zallah the Sandbringer
	[8201] = { world_id = ZN.KALIMDOR, map_name = ZN.TANARIS, }, -- Omgorn the Lost
	[8203] = { world_id = ZN.KALIMDOR, map_name = ZN.TANARIS, }, -- Kregg Keelhaul
	[8204] = { world_id = ZN.KALIMDOR, map_name = ZN.TANARIS, is_tamable = true, }, -- Soriid the Devourer
	[8205] = { world_id = ZN.KALIMDOR, map_name = ZN.TANARIS, is_tamable = true, }, -- Haarka the Ravenous
	[8207] = { world_id = ZN.KALIMDOR, map_name = ZN.TANARIS, is_tamable = true, }, -- Emberwing
	[8210] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.THE_HINTERLANDS, }, -- Razortalon
	[8211] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.THE_HINTERLANDS, is_tamable = true, }, -- Old Cliff Jumper
	[8212] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.THE_HINTERLANDS, }, -- The Reak
	[8213] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.THE_HINTERLANDS, is_tamable = true, }, -- Ironback
	[8214] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.THE_HINTERLANDS, }, -- Jalinde Summerdrake
	[8215] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.THE_HINTERLANDS, }, -- Grimungous
	[8216] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.THE_HINTERLANDS, }, -- Retherokk the Berserker
	[8217] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.THE_HINTERLANDS, }, -- Mith'rethis the Enchanter
	[8218] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.THE_HINTERLANDS, }, -- Witherheart the Stalker
	[8219] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.THE_HINTERLANDS, }, -- Zul'arek Hatefowler
	[8277] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.SEARING_GORGE, is_tamable = true, }, -- Rekk'tilac
	[8278] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.SEARING_GORGE, }, -- Smoldar
	[8279] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.SEARING_GORGE, }, -- Faulty War Golem
	[8280] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.SEARING_GORGE, }, -- Shleipnarr
	[8281] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.SEARING_GORGE, }, -- Scald
	[8282] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.SEARING_GORGE, }, -- Highlord Mastrogonde
	[8283] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.SEARING_GORGE, }, -- Slave Master Blackheart
	[8296] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.BLASTED_LANDS, }, -- Mojo the Twisted
	[8297] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.BLASTED_LANDS, }, -- Magronos the Unyielding
	[8298] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.BLASTED_LANDS, }, -- Akubar the Seer
	[8299] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.BLASTED_LANDS, is_tamable = true, }, -- Spiteflayer
	[8300] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.BLASTED_LANDS, is_tamable = true, }, -- Ravage
	[8301] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.BLASTED_LANDS, is_tamable = true, }, -- Clack the Reaver
	[8302] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.BLASTED_LANDS, }, -- Deatheye
	[8303] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.BLASTED_LANDS, is_tamable = true, }, -- Grunter
	[8304] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.BLASTED_LANDS, }, -- Dreadscorn
	[8503] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.NEW_TINKERTOWN, }, -- Gibblewilt
	[8660] = { world_id = ZN.KALIMDOR, map_name = ZN.AZSHARA, is_tamable = true, }, -- The Evalcharr
	[8923] = { world_id = ZN.BLACKROCK_DEPTHS, map_name = ZN.BLACKROCK_DEPTHS, }, -- Panzor the Invincible
	[8976] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.BURNING_STEPPES, }, -- Hematos
	[8978] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.BURNING_STEPPES, }, -- Thauris Balgarr
	[8979] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.BURNING_STEPPES, }, -- Gruklash
	[8981] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.BURNING_STEPPES, }, -- Malfunctioning Reaver
	[9217] = { world_id = ZN.BLACKROCK_SPIRE, map_name = ZN.BLACKROCK_SPIRE, }, -- Spirestone Lord Magus
	[9218] = { world_id = ZN.BLACKROCK_SPIRE, map_name = ZN.BLACKROCK_SPIRE, }, -- Spirestone Battle Lord
	[9219] = { world_id = ZN.BLACKROCK_SPIRE, map_name = ZN.BLACKROCK_SPIRE, }, -- Spirestone Butcher
	[9596] = { world_id = ZN.BLACKROCK_SPIRE, map_name = ZN.BLACKROCK_SPIRE, }, -- Bannok Grimaxe
	[9602] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.BURNING_STEPPES, }, -- Hahk'Zor
	[9604] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.BURNING_STEPPES, }, -- Gorgon'och
	[9718] = { world_id = ZN.BLACKROCK_SPIRE, map_name = ZN.BLACKROCK_SPIRE, }, -- Ghok Bashguud
	[9736] = { world_id = ZN.BLACKROCK_SPIRE, map_name = ZN.BLACKROCK_SPIRE, }, -- Quartermaster Zigris
	[10077] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.BURNING_STEPPES, is_tamable = true, }, -- Deathmaw
	[10078] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.BURNING_STEPPES, }, -- Terrorspark
	[10080] = { world_id = ZN.ZULFARRAK, map_name = ZN.ZULFARRAK, }, -- Sandarr Dunereaver
	[10081] = { world_id = ZN.ZULFARRAK, map_name = ZN.ZULFARRAK, }, -- Dustwraith
	[10082] = { world_id = ZN.ZULFARRAK, map_name = ZN.ZULFARRAK, }, -- Zerillis
	[10119] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.BURNING_STEPPES, }, -- Volchan
	[10196] = { world_id = ZN.KALIMDOR, map_name = ZN.WINTERSPRING, }, -- General Colbatann
	[10197] = { world_id = ZN.KALIMDOR, map_name = ZN.WINTERSPRING, }, -- Mezzir the Howler
	[10198] = { world_id = ZN.KALIMDOR, map_name = ZN.WINTERSPRING, }, -- Kashoch the Reaver
	[10199] = { world_id = ZN.KALIMDOR, map_name = ZN.WINTERSPRING, }, -- Grizzle Snowpaw
	[10200] = { world_id = ZN.KALIMDOR, map_name = ZN.WINTERSPRING, is_tamable = true, }, -- Rak'shiri
	[10202] = { world_id = ZN.KALIMDOR, map_name = ZN.WINTERSPRING, }, -- Azurous
	[10263] = { world_id = ZN.BLACKROCK_SPIRE, map_name = ZN.BLACKROCK_SPIRE, }, -- Burning Felguard
	[10356] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.TIRISFAL_GLADES, is_tamable = true, }, -- Bayne
	[10357] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.TIRISFAL_GLADES, is_tamable = true, }, -- Ressan the Needler
	[10358] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.TIRISFAL_GLADES, }, -- Fellicent's Shade
	[10359] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.TIRISFAL_GLADES, is_tamable = true, }, -- Sri'skulk
	[10376] = { world_id = ZN.BLACKROCK_SPIRE, map_name = ZN.BLACKROCK_SPIRE, is_tamable = true, }, -- Crystal Fang
	[10393] = { world_id = ZN.STRATHOLME, map_name = ZN.STRATHOLME, }, -- Skul
	[10509] = { world_id = ZN.BLACKROCK_SPIRE, map_name = ZN.BLACKROCK_SPIRE, }, -- Jed Runewatcher
	[10558] = { world_id = ZN.STRATHOLME, map_name = ZN.STRATHOLME, }, -- Hearthsinger Forresten
	[10559] = { world_id = ZN.KALIMDOR, map_name = ZN.ASHENVALE, }, -- Lady Vespia
	[10639] = { world_id = ZN.KALIMDOR, map_name = ZN.ASHENVALE, }, -- Rorgish Jowl
	[10640] = { world_id = ZN.KALIMDOR, map_name = ZN.ASHENVALE, }, -- Oakpaw
	[10641] = { world_id = ZN.KALIMDOR, map_name = ZN.ASHENVALE, }, -- Branch Snapper
	[10642] = { world_id = ZN.KALIMDOR, map_name = ZN.ASHENVALE, }, -- Eck'alom
	[10644] = { world_id = ZN.KALIMDOR, map_name = ZN.ASHENVALE, is_tamable = true, }, -- Mist Howler
	[10647] = { world_id = ZN.KALIMDOR, map_name = ZN.ASHENVALE, }, -- Prince Raze
	[10741] = { world_id = ZN.KALIMDOR, map_name = ZN.WINTERSPRING, is_tamable = true, }, -- Sian-Rotam
	[10809] = { world_id = ZN.STRATHOLME, map_name = ZN.STRATHOLME, }, -- Stonespine
	[10817] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.EASTERN_PLAGUELANDS, }, -- Duggan Wildhammer
	[10818] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.EASTERN_PLAGUELANDS, }, -- Death Knight Soulbearer
	[10819] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.EASTERN_PLAGUELANDS, }, -- Baron Bloodbane
	[10820] = { world_id = ZN.STRATHOLME, map_name = ZN.STRATHOLME, }, -- Duke Ragereaver
	[10821] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.EASTERN_PLAGUELANDS, }, -- Hed'mush the Rotting
	[10823] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.EASTERN_PLAGUELANDS, }, -- Zul'Brin Warpbranch
	[10824] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.EASTERN_PLAGUELANDS, }, -- Death-Hunter Hawkspear
	[10825] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.EASTERN_PLAGUELANDS, }, -- Gish the Unmoving
	[10826] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.EASTERN_PLAGUELANDS, }, -- Lord Darkscythe
	[10827] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.EASTERN_PLAGUELANDS, }, -- Deathspeaker Selendre
	[10828] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.EASTERN_PLAGUELANDS, }, -- Lynnia Abbendis
	[11383] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.NORTHERN_STRANGLETHORN, }, -- High Priestess Hai'watna
	[11447] = { world_id = ZN.KALIMDOR, map_name = ZN.FERALAS, }, -- Mushgog
	[11467] = { world_id = ZN.DIRE_MAUL, map_name = ZN.DIRE_MAUL, }, -- Tsu'zee
	[11497] = { world_id = ZN.KALIMDOR, map_name = ZN.FERALAS, is_tamable = true, }, -- The Razza
	[11498] = { world_id = ZN.KALIMDOR, map_name = ZN.FERALAS, }, -- Skarr the Broken
	[11688] = { world_id = ZN.KALIMDOR, map_name = ZN.DESOLACE, }, -- Cursed Centaur
	[12037] = { world_id = ZN.KALIMDOR, map_name = ZN.ASHENVALE, is_tamable = true, }, -- Ursol'lok
	[12237] = { world_id = ZN.MARAUDON, map_name = ZN.MARAUDON, }, -- Meshlok the Harvester
	[12431] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.SILVERPINE_FOREST, is_tamable = true, }, -- Gorefang
	[12433] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.SILVERPINE_FOREST, is_tamable = true, }, -- Krethis the Shadowspinner
	[12902] = { world_id = ZN.BLACKFATHOM_DEEPS, map_name = ZN.BLACKFATHOM_DEEPS, }, -- Lorgus Jett
	[13896] = { world_id = ZN.KALIMDOR, map_name = ZN.AZSHARA, }, -- Scalebeard
	[14221] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.HILLSBRAD_FOOTHILLS, }, -- Gravis Slipknot
	[14222] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.HILLSBRAD_FOOTHILLS, is_tamable = true, }, -- Araga
	[14223] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.HILLSBRAD_FOOTHILLS, is_tamable = true, }, -- Cranky Benj
	[14224] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.BADLANDS, }, -- 7:XT
	[14225] = { world_id = ZN.KALIMDOR, map_name = ZN.DESOLACE, }, -- Prince Kellen
	[14226] = { world_id = ZN.KALIMDOR, map_name = ZN.DESOLACE, }, -- Kaskk
	[14227] = { world_id = ZN.KALIMDOR, map_name = ZN.DESOLACE, }, -- Hissperak
	[14228] = { world_id = ZN.KALIMDOR, map_name = ZN.DESOLACE, is_tamable = true, }, -- Giggler
	[14229] = { world_id = ZN.KALIMDOR, map_name = ZN.DESOLACE, }, -- Accursed Slitherblade
	[14230] = { world_id = ZN.KALIMDOR, map_name = ZN.DUSTWALLOW_MARSH, }, -- Burgle Eye
	[14231] = { world_id = ZN.KALIMDOR, map_name = ZN.DUSTWALLOW_MARSH, }, -- Drogoth the Roamer
	[14232] = { world_id = ZN.KALIMDOR, map_name = ZN.DUSTWALLOW_MARSH, is_tamable = true, }, -- Dart
	[14233] = { world_id = ZN.KALIMDOR, map_name = ZN.DUSTWALLOW_MARSH, is_tamable = true, }, -- Ripscale
	[14234] = { world_id = ZN.KALIMDOR, map_name = ZN.DUSTWALLOW_MARSH, is_tamable = true, }, -- Hayoc
	[14235] = { world_id = ZN.KALIMDOR, map_name = ZN.DUSTWALLOW_MARSH, }, -- The Rot
	[14236] = { world_id = ZN.KALIMDOR, map_name = ZN.DUSTWALLOW_MARSH, }, -- Lord Angler
	[14237] = { world_id = ZN.KALIMDOR, map_name = ZN.DUSTWALLOW_MARSH, is_tamable = true, }, -- Oozeworm
	[14266] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.LOCH_MODAN, is_tamable = true, }, -- Shanda the Spinner
	[14267] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.LOCH_MODAN, }, -- Emogg the Crusher
	[14268] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.LOCH_MODAN, is_tamable = true, }, -- Lord Condar
	[14269] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.REDRIDGE_MOUNTAINS, }, -- Seeker Aqualon
	[14270] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.REDRIDGE_MOUNTAINS, }, -- Squiddic
	[14271] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.REDRIDGE_MOUNTAINS, }, -- Ribchaser
	[14272] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.REDRIDGE_MOUNTAINS, }, -- Snarlflare
	[14273] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.REDRIDGE_MOUNTAINS, }, -- Boulderheart
	[14275] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.HILLSBRAD_FOOTHILLS, }, -- Tamra Stormpike
	[14276] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.HILLSBRAD_FOOTHILLS, }, -- Scargil
	[14277] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.HILLSBRAD_FOOTHILLS, }, -- Lady Zephris
	[14278] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.HILLSBRAD_FOOTHILLS, }, -- Ro'Bark
	[14279] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.HILLSBRAD_FOOTHILLS, is_tamable = true, }, -- Creepthess
	[14280] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.HILLSBRAD_FOOTHILLS, is_tamable = true, }, -- Big Samras
	[14281] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.HILLSBRAD_FOOTHILLS, }, -- Jimmy the Bleeder
	[14339] = { world_id = ZN.KALIMDOR, map_name = ZN.FELWOOD, is_tamable = true, }, -- Death Howl
	[14340] = { world_id = ZN.KALIMDOR, map_name = ZN.FELWOOD, }, -- Alshirr Banebreath
	[14342] = { world_id = ZN.KALIMDOR, map_name = ZN.FELWOOD, }, -- Ragepaw
	[14343] = { world_id = ZN.KALIMDOR, map_name = ZN.FELWOOD, is_tamable = true, }, -- Olm the Wise
	[14344] = { world_id = ZN.KALIMDOR, map_name = ZN.FELWOOD, is_tamable = true, }, -- Mongress
	[14345] = { world_id = ZN.KALIMDOR, map_name = ZN.FELWOOD, }, -- The Ongar
	[14424] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.WETLANDS, }, -- Mirelow
	[14425] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.WETLANDS, }, -- Gnawbone
	[14426] = { world_id = ZN.KALIMDOR, map_name = ZN.THOUSAND_NEEDLES, }, -- Harb Foulmountain
	[14427] = { world_id = ZN.KALIMDOR, map_name = ZN.THOUSAND_NEEDLES, }, -- Gibblesnik
	[14428] = { world_id = ZN.KALIMDOR, map_name = ZN.TELDRASSIL, }, -- Uruson
	[14429] = { world_id = ZN.KALIMDOR, map_name = ZN.TELDRASSIL, }, -- Grimmaw
	[14430] = { world_id = ZN.KALIMDOR, map_name = ZN.TELDRASSIL, is_tamable = true, }, -- Duskstalker
	[14431] = { world_id = ZN.KALIMDOR, map_name = ZN.TELDRASSIL, }, -- Fury Shelda
	[14432] = { world_id = ZN.KALIMDOR, map_name = ZN.TELDRASSIL, }, -- Threggil
	[14433] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.WETLANDS, }, -- Sludginn
	[14445] = { world_id = ZN.THE_TEMPLE_OF_ATALHAKKAR, map_name = ZN.THE_TEMPLE_OF_ATALHAKKAR, }, -- Captain Wyrmak
	[14446] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.SWAMP_OF_SORROWS, }, -- Fingat
	[14447] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.SWAMP_OF_SORROWS, }, -- Gilmorian
	[14448] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.SWAMP_OF_SORROWS, }, -- Molt Thorn
	[14471] = { world_id = ZN.KALIMDOR, map_name = ZN.SILITHUS, }, -- Setis
	[14472] = { world_id = ZN.KALIMDOR, map_name = ZN.SILITHUS, is_tamable = true, }, -- Gretheer
	[14473] = { world_id = ZN.KALIMDOR, map_name = ZN.SILITHUS, is_tamable = true, }, -- Lapress
	[14474] = { world_id = ZN.KALIMDOR, map_name = ZN.SILITHUS, is_tamable = true, }, -- Zora
	[14475] = { world_id = ZN.KALIMDOR, map_name = ZN.SILITHUS, is_tamable = true, }, -- Rex Ashil
	[14476] = { world_id = ZN.KALIMDOR, map_name = ZN.SILITHUS, is_tamable = true, }, -- Krellack
	[14477] = { world_id = ZN.KALIMDOR, map_name = ZN.SILITHUS, is_tamable = true, }, -- Grubthor
	[14478] = { world_id = ZN.KALIMDOR, map_name = ZN.SILITHUS, }, -- Huricanian
	[14479] = { world_id = ZN.KALIMDOR, map_name = ZN.SILITHUS, }, -- Twilight Lord Everun
	[14487] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.NORTHERN_STRANGLETHORN, }, -- Gluggl
	[14488] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.NORTHERN_STRANGLETHORN, }, -- Roloch
	[14490] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.THE_CAPE_OF_STRANGLETHORN, }, -- Rippa
	[14491] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.THE_CAPE_OF_STRANGLETHORN, is_tamable = true, }, -- Kurmokk
	[14492] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.THE_CAPE_OF_STRANGLETHORN, }, -- Verifonix
	[16179] = { world_id = ZN.KARAZHAN, map_name = ZN.KARAZHAN, }, -- Hyakiss the Lurker
	[16180] = { world_id = ZN.KARAZHAN, map_name = ZN.KARAZHAN, is_tamable = true, }, -- Shadikith the Glider
	[16181] = { world_id = ZN.KARAZHAN, map_name = ZN.KARAZHAN, is_tamable = true, }, -- Rokad the Ravager
	[16184] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.EASTERN_PLAGUELANDS, }, -- Nerubian Overseer
	[16854] = { world_id = ZN.OUTLAND, map_name = ZN.EVERSONG_WOODS, }, -- Eldinarcus
	[16855] = { world_id = ZN.OUTLAND, map_name = ZN.EVERSONG_WOODS, }, -- Tregla
	[17144] = { world_id = ZN.OUTLAND, map_name = ZN.NAGRAND_OUTLAND, is_tamable = true, is_achievement = true, }, -- Goretooth
	[18241] = { world_id = ZN.KALIMDOR, map_name = ZN.DESOLACE, is_tamable = true, }, -- Crusty
	[18677] = { world_id = ZN.OUTLAND, map_name = ZN.HELLFIRE_PENINSULA, is_achievement = true, }, -- Mekthorg the Wild
	[18678] = { world_id = ZN.OUTLAND, map_name = ZN.HELLFIRE_PENINSULA, is_achievement = true, }, -- Fulgorge
	[18679] = { world_id = ZN.OUTLAND, map_name = ZN.HELLFIRE_PENINSULA, is_achievement = true, }, -- Vorakem Doomspeaker
	[18680] = { world_id = ZN.OUTLAND, map_name = ZN.ZANGARMARSH, is_tamable = true, is_achievement = true, }, -- Marticar
	[18681] = { world_id = ZN.OUTLAND, map_name = ZN.ZANGARMARSH, is_achievement = true, }, -- Coilfang Emissary
	[18682] = { world_id = ZN.OUTLAND, map_name = ZN.ZANGARMARSH, is_achievement = true, }, -- Bog Lurker
	[18683] = { world_id = ZN.OUTLAND, map_name = ZN.NAGRAND_OUTLAND, is_achievement = true, }, -- Voidhunter Yar
	[18684] = { world_id = ZN.OUTLAND, map_name = ZN.NAGRAND_OUTLAND, }, -- Bro'Gaz the Clanless
	[18685] = { world_id = ZN.OUTLAND, map_name = ZN.TEROKKAR_FOREST, is_achievement = true, }, -- Okrek
	[18686] = { world_id = ZN.OUTLAND, map_name = ZN.TEROKKAR_FOREST, is_achievement = true, }, -- Doomsayer Jurim
	[18689] = { world_id = ZN.OUTLAND, map_name = ZN.TEROKKAR_FOREST, is_achievement = true, }, -- Crippler
	[18690] = { world_id = ZN.OUTLAND, map_name = ZN.BLADES_EDGE_MOUNTAINS, is_achievement = true, }, -- Morcrush
	[18692] = { world_id = ZN.OUTLAND, map_name = ZN.BLADES_EDGE_MOUNTAINS, is_achievement = true, }, -- Hemathion
	[18693] = { world_id = ZN.OUTLAND, map_name = ZN.BLADES_EDGE_MOUNTAINS, is_achievement = true, }, -- Speaker Mar'grom
	[18694] = { world_id = ZN.OUTLAND, map_name = ZN.SHADOWMOON_VALLEY_OUTLAND, is_achievement = true, }, -- Collidus the Warp-Watcher
	[18695] = { world_id = ZN.OUTLAND, map_name = ZN.SHADOWMOON_VALLEY_OUTLAND, is_achievement = true, }, -- Ambassador Jerrikar
	[18696] = { world_id = ZN.OUTLAND, map_name = ZN.SHADOWMOON_VALLEY_OUTLAND, is_achievement = true, }, -- Kraator
	[18697] = { world_id = ZN.OUTLAND, map_name = ZN.NETHERSTORM, is_achievement = true, }, -- Chief Engineer Lorthander
	[18698] = { world_id = ZN.OUTLAND, map_name = ZN.NETHERSTORM, is_achievement = true, }, -- Ever-Core the Punisher
	[20932] = { world_id = ZN.OUTLAND, map_name = ZN.NETHERSTORM, is_tamable = true, is_achievement = true, }, -- Nuramoc
	[21724] = { world_id = ZN.OUTLAND, map_name = ZN.TEROKKAR_FOREST, is_tamable = true, }, -- Hawkbane
	[22060] = { world_id = ZN.OUTLAND, map_name = ZN.BLOODMYST_ISLE, }, -- Fenissa the Assassin
	[22062] = { world_id = ZN.OUTLAND, map_name = ZN.GHOSTLANDS, }, -- Dr. Whitherlimb
	[32357] = { world_id = ZN.NORTHREND, map_name = ZN.BOREAN_TUNDRA, is_achievement = true, }, -- Old Crystalbark
	[32358] = { world_id = ZN.NORTHREND, map_name = ZN.BOREAN_TUNDRA, is_achievement = true, }, -- Fumblub Gearwind
	[32361] = { world_id = ZN.NORTHREND, map_name = ZN.BOREAN_TUNDRA, is_tamable = true, is_achievement = true, }, -- Icehorn
	[32377] = { world_id = ZN.NORTHREND, map_name = ZN.HOWLING_FJORD, is_achievement = true, }, -- Perobas the Bloodthirster
	[32386] = { world_id = ZN.NORTHREND, map_name = ZN.HOWLING_FJORD, is_achievement = true, }, -- Vigdis the War Maiden
	[32398] = { world_id = ZN.NORTHREND, map_name = ZN.HOWLING_FJORD, is_achievement = true, }, -- King Ping
	[32400] = { world_id = ZN.NORTHREND, map_name = ZN.DRAGONBLIGHT, is_achievement = true, }, -- Tukemuth
	[32409] = { world_id = ZN.NORTHREND, map_name = ZN.DRAGONBLIGHT, is_achievement = true, }, -- Crazed Indu'le Survivor
	[32417] = { world_id = ZN.NORTHREND, map_name = ZN.DRAGONBLIGHT, is_achievement = true, }, -- Scarlet Highlord Daion
	[32422] = { world_id = ZN.NORTHREND, map_name = ZN.GRIZZLY_HILLS, is_achievement = true, }, -- Grocklar
	[32429] = { world_id = ZN.NORTHREND, map_name = ZN.GRIZZLY_HILLS, is_achievement = true, }, -- Seething Hate
	[32438] = { world_id = ZN.NORTHREND, map_name = ZN.GRIZZLY_HILLS, is_achievement = true, }, -- Syreian the Bonecarver
	[32447] = { world_id = ZN.NORTHREND, map_name = ZN.ZULDRAK, is_achievement = true, }, -- Zul'drak Sentinel
	[32471] = { world_id = ZN.NORTHREND, map_name = ZN.ZULDRAK, is_achievement = true, }, -- Griegen
	[32475] = { world_id = ZN.NORTHREND, map_name = ZN.ZULDRAK, is_tamable = true, is_achievement = true, }, -- Terror Spinner
	[32481] = { world_id = ZN.NORTHREND, map_name = ZN.SHOLAZAR_BASIN, is_tamable = true, is_achievement = true, }, -- Aotona
	[32485] = { world_id = ZN.NORTHREND, map_name = ZN.SHOLAZAR_BASIN, is_tamable = true, is_achievement = true, }, -- King Krush
	[32487] = { world_id = ZN.NORTHREND, map_name = ZN.ICECROWN, is_achievement = true, }, -- Putridus the Ancient
	[32491] = { world_id = ZN.NORTHREND, map_name = ZN.THE_STORM_PEAKS, }, -- Time-Lost Proto-Drake
	[32495] = { world_id = ZN.NORTHREND, map_name = ZN.ICECROWN, is_achievement = true, }, -- Hildana Deathstealer
	[32500] = { world_id = ZN.NORTHREND, map_name = ZN.THE_STORM_PEAKS, is_achievement = true, }, -- Dirkee
	[32501] = { world_id = ZN.NORTHREND, map_name = ZN.ICECROWN, is_achievement = true, }, -- High Thane Jorfus
	[32517] = { world_id = ZN.NORTHREND, map_name = ZN.SHOLAZAR_BASIN, is_tamable = true, is_achievement = true, }, -- Loque'nahak
	[32630] = { world_id = ZN.NORTHREND, map_name = ZN.THE_STORM_PEAKS, is_achievement = true, }, -- Vyragosa
	[33776] = { world_id = ZN.NORTHREND, map_name = ZN.ZULDRAK, is_tamable = true, }, -- Gondria
	[35189] = { world_id = ZN.NORTHREND, map_name = ZN.THE_STORM_PEAKS, is_tamable = true, }, -- Skoll
	[38453] = { world_id = ZN.NORTHREND, map_name = ZN.GRIZZLY_HILLS, is_tamable = true, }, -- Arcturis
	[39183] = { world_id = ZN.KALIMDOR, map_name = ZN.TANARIS, is_tamable = true, }, -- Scorpitar
	[39185] = { world_id = ZN.KALIMDOR, map_name = ZN.TANARIS, is_tamable = true, }, -- Slaverjaw
	[39186] = { world_id = ZN.KALIMDOR, map_name = ZN.TANARIS, }, -- Hellgazer
	[43488] = { world_id = ZN.KALIMDOR, map_name = ZN.FERALAS, }, -- Mordei the Earthrender
	[43613] = { world_id = ZN.KALIMDOR, map_name = ZN.MULGORE, }, -- Doomsayer Wiserunner
	[43720] = { world_id = ZN.KALIMDOR, map_name = ZN.CAMP_NARACHE, }, -- "Pokey" Thornmantle
	[44224] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.WETLANDS, }, -- Two-Toes
	[44225] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.WETLANDS, }, -- Rufus Darkshot
	[44226] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.WETLANDS, }, -- Sarltooth
	[44227] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.WETLANDS, }, -- Gazz the Loch-Hunter
	[44714] = { world_id = ZN.KALIMDOR, map_name = ZN.TANARIS, }, -- Fronkle the Disturbed
	[44722] = { world_id = ZN.KALIMDOR, map_name = ZN.TANARIS, }, -- Twisted Reflection of Narain
	[44750] = { world_id = ZN.KALIMDOR, map_name = ZN.TANARIS, }, -- Caliph Scorpidsting
	[44759] = { world_id = ZN.KALIMDOR, map_name = ZN.TANARIS, }, -- Andre Firebeard
	[44761] = { world_id = ZN.KALIMDOR, map_name = ZN.TANARIS, }, -- Aquementas the Unchained
	[44767] = { world_id = ZN.KALIMDOR, map_name = ZN.TANARIS, }, -- Occulus the Corrupted
	[45257] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.BLASTED_LANDS, }, -- Mordak Nightbender
	[45258] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.BLASTED_LANDS, }, -- Cassia the Slitherqueen
	[45260] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.BLASTED_LANDS, }, -- Blackleaf
	[45262] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.BLASTED_LANDS, }, -- Narixxus the Doombringer
	[45369] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.LOCH_MODAN, }, -- Morick Darkbrew
	[45380] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.LOCH_MODAN, is_tamable = true, }, -- Ashtail
	[45384] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.LOCH_MODAN, }, -- Sagepaw
	[45398] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.LOCH_MODAN, }, -- Grizlak
	[45399] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.LOCH_MODAN, }, -- Optimo
	[45401] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.LOCH_MODAN, }, -- Whitefin
	[45402] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.LOCH_MODAN, is_tamable = true, }, -- Nix
	[45404] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.LOCH_MODAN, }, -- Geoshaper Maren
	[45739] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.DUSKWOOD, }, -- The Unknown Soldier
	[45740] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.DUSKWOOD, }, -- Watcher Eva
	[45771] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.DUSKWOOD, }, -- Marus
	[45785] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.DUSKWOOD, }, -- Carved One
	[45801] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.DUSKWOOD, }, -- Eliza
	[45811] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.DUSKWOOD, }, -- Marina DeSirrus
	[46981] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.SILVERPINE_FOREST, }, -- Nightlash
	[46992] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.SILVERPINE_FOREST, }, -- Berard the Moon-Crazed
	[47003] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.SILVERPINE_FOREST, }, -- Bolgaff
	[47008] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.SILVERPINE_FOREST, }, -- Fenwick Thatros
	[47009] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.SILVERPINE_FOREST, }, -- Aquarius the Unbound
	[47010] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.HILLSBRAD_FOOTHILLS, }, -- Indigos
	[47012] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.SILVERPINE_FOREST, }, -- Effritus
	[47015] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.SILVERPINE_FOREST, }, -- Lost Son of Arugal
	[47023] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.SILVERPINE_FOREST, }, -- Thule Ravenclaw
	[47386] = { world_id = ZN.KALIMDOR, map_name = ZN.TANARIS, is_tamable = true, }, -- Ainamiss the Hive Queen
	[47387] = { world_id = ZN.KALIMDOR, map_name = ZN.TANARIS, is_tamable = true, }, -- Harakiss the Infestor
	[49822] = { world_id = ZN.DEEPHOLM, map_name = ZN.DEEPHOLM, is_tamable = true, }, -- Jadefang
	[49913] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.KELPTHAR_FOREST, }, -- Lady La-La
	[50005] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.SHIMMERING_EXPANSE, }, -- Poseidus
	[50050] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.ABYSSAL_DEPTHS, }, -- Shok'sharak
	[50051] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.ABYSSAL_DEPTHS, is_tamable = true, }, -- Ghostcrawler
	[50052] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.SHIMMERING_EXPANSE, }, -- Burgy Blackheart
	[50053] = { world_id = ZN.KALIMDOR, map_name = ZN.MOUNT_HYJAL, }, -- Thartuk the Exile
	[50057] = { world_id = ZN.KALIMDOR, map_name = ZN.MOUNT_HYJAL, }, -- Blazewing
	[50058] = { world_id = ZN.KALIMDOR, map_name = ZN.MOUNT_HYJAL, is_tamable = true, }, -- Terrorpene
	[50059] = { world_id = ZN.DEEPHOLM, map_name = ZN.DEEPHOLM, }, -- Golgarok
	[50060] = { world_id = ZN.DEEPHOLM, map_name = ZN.DEEPHOLM, }, -- Terborus
	[50062] = { world_id = ZN.DEEPHOLM, map_name = ZN.DEEPHOLM, }, -- Aeonaxx
	[50064] = { world_id = ZN.KALIMDOR, map_name = ZN.ULDUM, }, -- Cyrus the Black
	[50065] = { world_id = ZN.KALIMDOR, map_name = ZN.ULDUM, }, -- Armagedillo
	[50085] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.TWILIGHT_HIGHLANDS, }, -- Overlord Sunderfury
	[50086] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.TWILIGHT_HIGHLANDS, }, -- Tarvus the Vile
	[50138] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.TWILIGHT_HIGHLANDS, is_tamable = true, }, -- Karoma
	[50154] = { world_id = ZN.KALIMDOR, map_name = ZN.ULDUM, is_tamable = true, }, -- Madexx - Brown
	[50159] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.TWILIGHT_HIGHLANDS, is_tamable = true, }, -- Sambas
	[50328] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.DEATHKNELL, is_tamable = true, }, -- Fangor
	[50329] = { world_id = ZN.KALIMDOR, map_name = ZN.THOUSAND_NEEDLES, is_tamable = true, }, -- Rrakk
	[50330] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.SILVERPINE_FOREST, is_tamable = true, }, -- Kree
	[50331] = { world_id = ZN.PANDARIA, map_name = ZN.KRASARANG_WILDS, is_achievement = true, }, -- Go-Kan
	[50332] = { world_id = ZN.PANDARIA, map_name = ZN.KUN_LAI_SUMMIT, is_achievement = true, }, -- Korda Torros
	[50333] = { world_id = ZN.PANDARIA, map_name = ZN.TOWNLONG_STEPPES, is_achievement = true, }, -- Lon the Bull
	[50334] = { world_id = ZN.PANDARIA, map_name = ZN.DREAD_WASTES, is_achievement = true, }, -- Dak the Breaker
	[50335] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.HILLSBRAD_FOOTHILLS, is_tamable = true, }, -- Alitus
	[50336] = { world_id = ZN.PANDARIA, map_name = ZN.VALE_OF_ETERNAL_BLOSSOMS, is_achievement = true, }, -- Yorik Sharpeye
	[50337] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.ARATHI_HIGHLANDS, is_tamable = true, }, -- Cackle
	[50338] = { world_id = ZN.PANDARIA, map_name = ZN.THE_JADE_FOREST, is_achievement = true, }, -- Kor'nas Nightsavage
	[50339] = { world_id = ZN.PANDARIA, map_name = ZN.VALLEY_OF_THE_FOUR_WINDS, is_achievement = true, }, -- Sulik'shor
	[50340] = { world_id = ZN.PANDARIA, map_name = ZN.KRASARANG_WILDS, is_achievement = true, }, -- Gaarn the Toxic
	[50341] = { world_id = ZN.PANDARIA, map_name = ZN.KUN_LAI_SUMMIT, is_achievement = true, }, -- Borginn Darkfist
	[50342] = { world_id = ZN.KALIMDOR, map_name = ZN.DUSTWALLOW_MARSH, is_tamable = true, }, -- Heronis
	[50343] = { world_id = ZN.KALIMDOR, map_name = ZN.STONETALON_MOUNTAINS, is_tamable = true, }, -- Quall
	[50344] = { world_id = ZN.PANDARIA, map_name = ZN.TOWNLONG_STEPPES, is_achievement = true, }, -- Norlaxx
	[50345] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.WESTERN_PLAGUELANDS, is_tamable = true, }, -- Alit
	[50346] = { world_id = ZN.KALIMDOR, map_name = ZN.WINTERSPRING, is_tamable = true, }, -- Ronak
	[50347] = { world_id = ZN.PANDARIA, map_name = ZN.DREAD_WASTES, is_achievement = true, }, -- Karr the Darkener
	[50348] = { world_id = ZN.KALIMDOR, map_name = ZN.WINTERSPRING, is_tamable = true, }, -- Norissis
	[50349] = { world_id = ZN.PANDARIA, map_name = ZN.VALE_OF_ETERNAL_BLOSSOMS, is_achievement = true, }, -- Kang the Soul Thief
	[50350] = { world_id = ZN.PANDARIA, map_name = ZN.THE_JADE_FOREST, is_achievement = true, }, -- Morgrinn Crackfang
	[50351] = { world_id = ZN.PANDARIA, map_name = ZN.VALLEY_OF_THE_FOUR_WINDS, is_achievement = true, }, -- Jonn-Dar
	[50352] = { world_id = ZN.PANDARIA, map_name = ZN.KRASARANG_WILDS, is_achievement = true, }, -- Qu'nas
	[50353] = { world_id = ZN.KALIMDOR, map_name = ZN.WINTERSPRING, is_tamable = true, }, -- Manas
	[50354] = { world_id = ZN.PANDARIA, map_name = ZN.KUN_LAI_SUMMIT, is_achievement = true, }, -- Havak
	[50355] = { world_id = ZN.PANDARIA, map_name = ZN.TOWNLONG_STEPPES, is_achievement = true, }, -- Kah'tir
	[50356] = { world_id = ZN.PANDARIA, map_name = ZN.DREAD_WASTES, is_achievement = true, }, -- Krol the Blade
	[50357] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.BURNING_STEPPES, is_tamable = true, }, -- Sunwing
	[50358] = { world_id = ZN.PANDARIA, map_name = ZN.ISLE_OF_THUNDER, is_achievement = true, }, -- Haywire Sunreaver Construct
	[50359] = { world_id = ZN.PANDARIA, map_name = ZN.VALE_OF_ETERNAL_BLOSSOMS, is_achievement = true, }, -- Urgolax
	[50361] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.BURNING_STEPPES, is_tamable = true, }, -- Ornat
	[50362] = { world_id = ZN.KALIMDOR, map_name = ZN.FELWOOD, is_tamable = true, }, -- Blackbog the Fang
	[50363] = { world_id = ZN.PANDARIA, map_name = ZN.THE_JADE_FOREST, is_achievement = true, }, -- Krax'ik
	[50364] = { world_id = ZN.PANDARIA, map_name = ZN.VALLEY_OF_THE_FOUR_WINDS, is_achievement = true, }, -- Nal'lak the Ripper
	[50370] = { world_id = ZN.KALIMDOR, map_name = ZN.SILITHUS, is_tamable = true, }, -- Karapax
	[50388] = { world_id = ZN.PANDARIA, map_name = ZN.KRASARANG_WILDS, is_achievement = true, }, -- Torik-Ethis
	[50724] = { world_id = ZN.KALIMDOR, map_name = ZN.FELWOOD, is_tamable = true, }, -- Spinecrawl
	[50725] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.BURNING_STEPPES, is_tamable = true, }, -- Azelisk
	[50726] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.BADLANDS, is_tamable = true, }, -- Kalixx
	[50727] = { world_id = ZN.KALIMDOR, map_name = ZN.THOUSAND_NEEDLES, is_tamable = true, }, -- Strix the Barbed
	[50728] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.BADLANDS, is_tamable = true, }, -- Deathstrike
	[50730] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.BURNING_STEPPES, is_tamable = true, }, -- Venomspine
	[50731] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.BADLANDS, is_tamable = true, }, -- Needlefang
	[50733] = { world_id = ZN.PANDARIA, map_name = ZN.KUN_LAI_SUMMIT, is_achievement = true, }, -- Ski'thik
	[50734] = { world_id = ZN.PANDARIA, map_name = ZN.TOWNLONG_STEPPES, is_achievement = true, }, -- Lith'ik the Stalker
	[50735] = { world_id = ZN.KALIMDOR, map_name = ZN.DUSTWALLOW_MARSH, is_tamable = true, }, -- Blinkeye the Rattler
	[50737] = { world_id = ZN.KALIMDOR, map_name = ZN.SILITHUS, is_tamable = true, }, -- Acroniss
	[50738] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.SWAMP_OF_SORROWS, is_tamable = true, }, -- Shimmerscale
	[50739] = { world_id = ZN.PANDARIA, map_name = ZN.DREAD_WASTES, is_achievement = true, }, -- Gar'lok
	[50741] = { world_id = ZN.KALIMDOR, map_name = ZN.THOUSAND_NEEDLES, is_tamable = true, }, -- Kaxx
	[50742] = { world_id = ZN.KALIMDOR, map_name = ZN.SILITHUS, is_tamable = true, }, -- Qem
	[50743] = { world_id = ZN.KALIMDOR, map_name = ZN.SILITHUS, is_tamable = true, }, -- Manax
	[50744] = { world_id = ZN.KALIMDOR, map_name = ZN.SILITHUS, is_tamable = true, }, -- Qu'rik
	[50745] = { world_id = ZN.KALIMDOR, map_name = ZN.SILITHUS, is_tamable = true, }, -- Losaj
	[50746] = { world_id = ZN.KALIMDOR, map_name = ZN.SILITHUS, is_tamable = true, }, -- Bornix the Burrower
	[50747] = { world_id = ZN.KALIMDOR, map_name = ZN.AHNQIRAJ_THE_FALLEN_KINGDOM, is_tamable = true, }, -- Tix
	[50748] = { world_id = ZN.KALIMDOR, map_name = ZN.THOUSAND_NEEDLES, is_tamable = true, }, -- Nyaj
	[50749] = { world_id = ZN.PANDARIA, map_name = ZN.VALE_OF_ETERNAL_BLOSSOMS, is_achievement = true, }, -- Kal'tik the Blight
	[50750] = { world_id = ZN.PANDARIA, map_name = ZN.THE_JADE_FOREST, is_achievement = true, }, -- Aethis
	[50752] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.ELWYNN_FOREST, is_tamable = true, }, -- Tarantis
	[50759] = { world_id = ZN.KALIMDOR, map_name = ZN.STONETALON_MOUNTAINS, is_tamable = true, }, -- Iriss the Widow
	[50763] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.TIRISFAL_GLADES, is_tamable = true, }, -- Shadowstalker
	[50764] = { world_id = ZN.KALIMDOR, map_name = ZN.DUSTWALLOW_MARSH, is_tamable = true, }, -- Paraliss
	[50765] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.HILLSBRAD_FOOTHILLS, is_tamable = true, }, -- Miasmiss
	[50766] = { world_id = ZN.PANDARIA, map_name = ZN.VALLEY_OF_THE_FOUR_WINDS, is_achievement = true, }, -- Sele'na
	[50768] = { world_id = ZN.PANDARIA, map_name = ZN.KRASARANG_WILDS, is_achievement = true, }, -- Cournith Waterstrider
	[50769] = { world_id = ZN.PANDARIA, map_name = ZN.KUN_LAI_SUMMIT, is_achievement = true, }, -- Zai the Outcast
	[50770] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.HILLSBRAD_FOOTHILLS, is_tamable = true, }, -- Zorn
	[50772] = { world_id = ZN.PANDARIA, map_name = ZN.TOWNLONG_STEPPES, is_achievement = true, }, -- Eshelon
	[50775] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.EASTERN_PLAGUELANDS, is_tamable = true, }, -- Likk the Hunter
	[50776] = { world_id = ZN.PANDARIA, map_name = ZN.DREAD_WASTES, is_achievement = true, }, -- Nalash Verdantis
	[50777] = { world_id = ZN.KALIMDOR, map_name = ZN.FELWOOD, is_tamable = true, }, -- Needle
	[50778] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.WESTERN_PLAGUELANDS, is_tamable = true, }, -- Ironweb
	[50779] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.EASTERN_PLAGUELANDS, is_tamable = true, }, -- Sporeggon
	[50780] = { world_id = ZN.PANDARIA, map_name = ZN.VALE_OF_ETERNAL_BLOSSOMS, is_achievement = true, }, -- Sahn Tidehunter
	[50782] = { world_id = ZN.PANDARIA, map_name = ZN.THE_JADE_FOREST, is_achievement = true, }, -- Sarnak
	[50783] = { world_id = ZN.PANDARIA, map_name = ZN.VALLEY_OF_THE_FOUR_WINDS, is_achievement = true, }, -- Salyin Warscout
	[50784] = { world_id = ZN.KALIMDOR, map_name = ZN.DUSTWALLOW_MARSH, is_tamable = true, }, -- Anith
	[50785] = { world_id = ZN.KALIMDOR, map_name = ZN.THOUSAND_NEEDLES, is_tamable = true, }, -- Skyshadow
	[50786] = { world_id = ZN.KALIMDOR, map_name = ZN.STONETALON_MOUNTAINS, is_tamable = true, }, -- Sparkwing
	[50787] = { world_id = ZN.PANDARIA, map_name = ZN.KRASARANG_WILDS, is_achievement = true, }, -- Arness the Scale
	[50788] = { world_id = ZN.KALIMDOR, map_name = ZN.WINTERSPRING, is_tamable = true, }, -- Quetzl
	[50789] = { world_id = ZN.PANDARIA, map_name = ZN.KUN_LAI_SUMMIT, is_achievement = true, }, -- Nessos the Oracle
	[50790] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.SWAMP_OF_SORROWS, is_tamable = true, }, -- Ionis
	[50791] = { world_id = ZN.PANDARIA, map_name = ZN.TOWNLONG_STEPPES, is_achievement = true, }, -- Siltriss the Sharpener
	[50792] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.BURNING_STEPPES, is_tamable = true, }, -- Chiaa
	[50797] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.SWAMP_OF_SORROWS, is_tamable = true, }, -- Yukiko
	[50803] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.TIRISFAL_GLADES, is_tamable = true, }, -- Bonechewer
	[50804] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.ARATHI_HIGHLANDS, is_tamable = true, }, -- Ripwing
	[50805] = { world_id = ZN.PANDARIA, map_name = ZN.DREAD_WASTES, is_achievement = true, }, -- Omnis Grinlok
	[50806] = { world_id = ZN.PANDARIA, map_name = ZN.VALE_OF_ETERNAL_BLOSSOMS, is_achievement = true, }, -- Moldo One-Eye
	[50807] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.BURNING_STEPPES, is_tamable = true, }, -- Catal
	[50808] = { world_id = ZN.PANDARIA, map_name = ZN.THE_JADE_FOREST, is_achievement = true, }, -- Urobi the Walker
	[50809] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.WESTERN_PLAGUELANDS, is_tamable = true, }, -- Heress
	[50810] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.BURNING_STEPPES, is_tamable = true, }, -- Favored of Isiset
	[50811] = { world_id = ZN.PANDARIA, map_name = ZN.VALLEY_OF_THE_FOUR_WINDS, is_achievement = true, }, -- Nasra Spothide
	[50812] = { world_id = ZN.KALIMDOR, map_name = ZN.STONETALON_MOUNTAINS, is_tamable = true, }, -- Arae
	[50813] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.EASTERN_PLAGUELANDS, is_tamable = true, }, -- Fene-mal
	[50814] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.SILVERPINE_FOREST, is_tamable = true, }, -- Corpsefeeder
	[50815] = { world_id = ZN.MOLTEN_FRONT, map_name = ZN.MOLTEN_FRONT, is_tamable = true, }, -- Skarr
	[50816] = { world_id = ZN.PANDARIA, map_name = ZN.KRASARANG_WILDS, is_achievement = true, }, -- Ruun Ghostpaw
	[50817] = { world_id = ZN.PANDARIA, map_name = ZN.KUN_LAI_SUMMIT, is_achievement = true, }, -- Ahone the Wanderer
	[50818] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.HILLSBRAD_FOOTHILLS, is_tamable = true, }, -- The Dark Prowler
	[50819] = { world_id = ZN.KALIMDOR, map_name = ZN.WINTERSPRING, is_tamable = true, }, -- Iceclaw
	[50820] = { world_id = ZN.PANDARIA, map_name = ZN.TOWNLONG_STEPPES, is_achievement = true, }, -- Yul Wildpaw
	[50821] = { world_id = ZN.PANDARIA, map_name = ZN.DREAD_WASTES, is_achievement = true, }, -- Ai-Li Skymirror
	[50822] = { world_id = ZN.PANDARIA, map_name = ZN.VALE_OF_ETERNAL_BLOSSOMS, is_achievement = true, }, -- Ai-Ran the Shifting Cloud
	[50823] = { world_id = ZN.PANDARIA, map_name = ZN.THE_JADE_FOREST, is_achievement = true, }, -- Mister Ferocious
	[50825] = { world_id = ZN.KALIMDOR, map_name = ZN.STONETALON_MOUNTAINS, is_tamable = true, }, -- Feras
	[50828] = { world_id = ZN.PANDARIA, map_name = ZN.VALLEY_OF_THE_FOUR_WINDS, is_achievement = true, }, -- Bonobos
	[50830] = { world_id = ZN.PANDARIA, map_name = ZN.KRASARANG_WILDS, is_achievement = true, }, -- Spriggin
	[50831] = { world_id = ZN.PANDARIA, map_name = ZN.KUN_LAI_SUMMIT, is_achievement = true, }, -- Scritch
	[50832] = { world_id = ZN.PANDARIA, map_name = ZN.TOWNLONG_STEPPES, is_achievement = true, }, -- The Yowler
	[50833] = { world_id = ZN.KALIMDOR, map_name = ZN.FELWOOD, is_tamable = true, }, -- Duskcoat
	[50836] = { world_id = ZN.PANDARIA, map_name = ZN.DREAD_WASTES, is_achievement = true, }, -- Ik-Ik the Nimble
	[50837] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.SWAMP_OF_SORROWS, is_tamable = true, }, -- Kash
	[50838] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.BADLANDS, is_tamable = true, }, -- Tabbs
	[50839] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.BURNING_STEPPES, is_tamable = true, }, -- Chromehound
	[50840] = { world_id = ZN.PANDARIA, map_name = ZN.VALE_OF_ETERNAL_BLOSSOMS, is_achievement = true, }, -- Major Nanners
	[50842] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.BURNING_STEPPES, is_tamable = true, }, -- Magmagan
	[50843] = { world_id = ZN.PANDARIA, map_name = ZN.VALE_OF_ETERNAL_BLOSSOMS, is_tamable = true, }, -- Portent
	[50846] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.SEARING_GORGE, is_tamable = true, }, -- Slavermaw
	[50855] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.BURNING_STEPPES, is_tamable = true, }, -- Jaxx the Rabid
	[50856] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.EASTERN_PLAGUELANDS, is_tamable = true, }, -- Snark
	[50858] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.HILLSBRAD_FOOTHILLS, is_tamable = true, }, -- Dustwing
	[50864] = { world_id = ZN.KALIMDOR, map_name = ZN.FELWOOD, is_tamable = true, }, -- Thicket
	[50865] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.ARATHI_HIGHLANDS, is_tamable = true, }, -- Saurix
	[50874] = { world_id = ZN.KALIMDOR, map_name = ZN.STONETALON_MOUNTAINS, is_tamable = true, }, -- Tenok
	[50875] = { world_id = ZN.KALIMDOR, map_name = ZN.DUSTWALLOW_MARSH, is_tamable = true, }, -- Nychus
	[50876] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.SEARING_GORGE, is_tamable = true, }, -- Avis
	[50882] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.SWAMP_OF_SORROWS, is_tamable = true, }, -- Chupacabros
	[50884] = { world_id = ZN.KALIMDOR, map_name = ZN.STONETALON_MOUNTAINS, is_tamable = true, }, -- Dustflight the Cowardly
	[50886] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.SWAMP_OF_SORROWS, is_tamable = true, }, -- Seawing
	[50891] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.ARATHI_HIGHLANDS, is_tamable = true, }, -- Boros
	[50892] = { world_id = ZN.KALIMDOR, map_name = ZN.THOUSAND_NEEDLES, is_tamable = true, }, -- Cyn
	[50895] = { world_id = ZN.KALIMDOR, map_name = ZN.STONETALON_MOUNTAINS, is_tamable = true, }, -- Volux
	[50897] = { world_id = ZN.KALIMDOR, map_name = ZN.SILITHUS, is_tamable = true, }, -- Ffexk the Dunestalker
	[50901] = { world_id = ZN.KALIMDOR, map_name = ZN.DUSTWALLOW_MARSH, is_tamable = true, }, -- Teromak
	[50903] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.SWAMP_OF_SORROWS, is_tamable = true, }, -- Orlix the Swamplord
	[50905] = { world_id = ZN.KALIMDOR, map_name = ZN.FELWOOD, is_tamable = true, }, -- Cida
	[50906] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.WESTERN_PLAGUELANDS, is_tamable = true, }, -- Mutilax
	[50908] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.TIRISFAL_GLADES, is_tamable = true, }, -- Nighthowl
	[50915] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.EASTERN_PLAGUELANDS, is_tamable = true, }, -- Snort
	[50916] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.ELWYNN_FOREST, is_tamable = true, }, -- Lamepaw the Whimperer
	[50922] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.WESTERN_PLAGUELANDS, is_tamable = true, }, -- Warg
	[50925] = { world_id = ZN.KALIMDOR, map_name = ZN.FELWOOD, is_tamable = true, }, -- Grovepaw
	[50926] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.ELWYNN_FOREST, is_tamable = true, }, -- Grizzled Ben
	[50929] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.HILLSBRAD_FOOTHILLS, is_tamable = true, }, -- Little Bjorn
	[50930] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.TIRISFAL_GLADES, is_tamable = true, }, -- Hibernus the Sleeper
	[50931] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.WESTERN_PLAGUELANDS, is_tamable = true, }, -- Mange
	[50937] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.WESTERN_PLAGUELANDS, is_tamable = true, }, -- Hamhide
	[50940] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.ARATHI_HIGHLANDS, is_tamable = true, }, -- Swee
	[50942] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.ELWYNN_FOREST, is_tamable = true, }, -- Snoot the Rooter
	[50945] = { world_id = ZN.KALIMDOR, map_name = ZN.DUSTWALLOW_MARSH, is_tamable = true, }, -- Scruff
	[50946] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.SEARING_GORGE, is_tamable = true, }, -- Hogzilla
	[50947] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.EASTERN_PLAGUELANDS, is_tamable = true, }, -- Varah
	[50948] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.SEARING_GORGE, is_tamable = true, }, -- Crystalback
	[50949] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.SILVERPINE_FOREST, is_tamable = true, }, -- Finn's Gambit
	[50952] = { world_id = ZN.KALIMDOR, map_name = ZN.THOUSAND_NEEDLES, is_tamable = true, }, -- Barnacle Jim
	[50955] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.HILLSBRAD_FOOTHILLS, is_tamable = true, }, -- Carcinak
	[50957] = { world_id = ZN.KALIMDOR, map_name = ZN.DUSTWALLOW_MARSH, is_tamable = true, }, -- Hugeclaw
	[50959] = { world_id = ZN.MOLTEN_FRONT, map_name = ZN.MOLTEN_FRONT, is_tamable = true, }, -- Karkin
	[50964] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.WETLANDS, is_tamable = true, }, -- Chops
	[50967] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.HILLSBRAD_FOOTHILLS, is_tamable = true, }, -- Craw the Ravager
	[50986] = { world_id = ZN.KALIMDOR, map_name = ZN.STONETALON_MOUNTAINS, is_tamable = true, }, -- Goldenback
	[50993] = { world_id = ZN.KALIMDOR, map_name = ZN.WINTERSPRING, is_tamable = true, }, -- Gal'dorak
	[50995] = { world_id = ZN.KALIMDOR, map_name = ZN.WINTERSPRING, is_tamable = true, }, -- Bruiser
	[50997] = { world_id = ZN.KALIMDOR, map_name = ZN.WINTERSPRING, is_tamable = true, }, -- Bornak the Gorer
	[51000] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.BADLANDS, is_tamable = true, }, -- Blackshell the Impenetrable
	[51001] = { world_id = ZN.KALIMDOR, map_name = ZN.THOUSAND_NEEDLES, is_tamable = true, }, -- Venomclaw
	[51002] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.SEARING_GORGE, is_tamable = true, }, -- Scorpoxx
	[51004] = { world_id = ZN.KALIMDOR, map_name = ZN.SILITHUS, is_tamable = true, }, -- Toxx
	[51007] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.BADLANDS, is_tamable = true, }, -- Serkett
	[51008] = { world_id = ZN.KALIMDOR, map_name = ZN.THOUSAND_NEEDLES, is_tamable = true, }, -- The Barbed Horror
	[51010] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.SEARING_GORGE, is_tamable = true, }, -- Snips
	[51014] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.ELWYNN_FOREST, is_tamable = true, }, -- Terrapis
	[51017] = { world_id = ZN.KALIMDOR, map_name = ZN.FELWOOD, is_tamable = true, }, -- Gezan
	[51018] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.BADLANDS, is_tamable = true, }, -- Zormus
	[51021] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.BADLANDS, is_tamable = true, }, -- Vorticus
	[51022] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.HILLSBRAD_FOOTHILLS, is_tamable = true, }, -- Chordix
	[51025] = { world_id = ZN.KALIMDOR, map_name = ZN.FELWOOD, is_tamable = true, }, -- Dilennaa
	[51026] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.SILVERPINE_FOREST, is_tamable = true, }, -- Gnath
	[51027] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.EASTERN_PLAGUELANDS, is_tamable = true, }, -- Spirocula
	[51028] = { world_id = ZN.KALIMDOR, map_name = ZN.WINTERSPRING, is_tamable = true, }, -- The Deep Tunneler
	[51029] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.WESTERN_PLAGUELANDS, is_tamable = true, }, -- Parasitus
	[51031] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.WESTERN_PLAGUELANDS, is_tamable = true, }, -- Tracker
	[51037] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.SILVERPINE_FOREST, is_tamable = true, }, -- Lost Gilnean Wardog
	[51040] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.ARATHI_HIGHLANDS, is_tamable = true, }, -- Snuffles
	[51042] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.EASTERN_PLAGUELANDS, is_tamable = true, }, -- Bleakheart
	[51044] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.TIRISFAL_GLADES, is_tamable = true, }, -- Plague
	[51045] = { world_id = ZN.KALIMDOR, map_name = ZN.WINTERSPRING, is_tamable = true, }, -- Arcanus
	[51046] = { world_id = ZN.KALIMDOR, map_name = ZN.FELWOOD, is_tamable = true, }, -- Fidonis
	[51048] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.SEARING_GORGE, is_tamable = true, }, -- Rexxus
	[51052] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.SWAMP_OF_SORROWS, is_tamable = true, }, -- Gib the Banana-Hoarder
	[51053] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.EASTERN_PLAGUELANDS, is_tamable = true, }, -- Quirix
	[51057] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.HILLSBRAD_FOOTHILLS, is_tamable = true, }, -- Weevil
	[51058] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.WESTERN_PLAGUELANDS, is_tamable = true, }, -- Aphis
	[51059] = { world_id = ZN.PANDARIA, map_name = ZN.VALLEY_OF_THE_FOUR_WINDS, is_achievement = true, }, -- Blackhoof
	[51061] = { world_id = ZN.KALIMDOR, map_name = ZN.DUSTWALLOW_MARSH, is_tamable = true, }, -- Roth-Salam
	[51062] = { world_id = ZN.KALIMDOR, map_name = ZN.STONETALON_MOUNTAINS, is_tamable = true, }, -- Khep-Re
	[51063] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.ARATHI_HIGHLANDS, is_tamable = true, }, -- Phalanax
	[51066] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.SEARING_GORGE, is_tamable = true, }, -- Crystalfang
	[51067] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.ARATHI_HIGHLANDS, is_tamable = true, }, -- Glint
	[51069] = { world_id = ZN.KALIMDOR, map_name = ZN.DUSTWALLOW_MARSH, is_tamable = true, }, -- Scintillex
	[51071] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.SHIMMERING_EXPANSE, }, -- Captain Florence
	[51076] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.HILLSBRAD_FOOTHILLS, is_tamable = true, }, -- Lopex
	[51077] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.ELWYNN_FOREST, is_tamable = true, }, -- Bushtail
	[51078] = { world_id = ZN.PANDARIA, map_name = ZN.THE_JADE_FOREST, is_achievement = true, }, -- Ferdinand
	[51079] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.VASHJIR, }, -- Captain Foulwind
	[51401] = { world_id = ZN.KALIMDOR, map_name = ZN.ULDUM, is_tamable = true, }, -- Madexx - Red
	[51402] = { world_id = ZN.KALIMDOR, map_name = ZN.ULDUM, is_tamable = true, }, -- Madexx - Green
	[51403] = { world_id = ZN.KALIMDOR, map_name = ZN.ULDUM, is_tamable = true, }, -- Madexx - Black
	[51404] = { world_id = ZN.KALIMDOR, map_name = ZN.ULDUM, is_tamable = true, }, -- Madexx - Blue
	[51658] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.NORTHERN_STRANGLETHORN, }, -- Mogh the Dead
	[51661] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.NORTHERN_STRANGLETHORN, is_tamable = true, }, -- Tsul'Kalu
	[51662] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.NORTHERN_STRANGLETHORN, is_tamable = true, }, -- Mahamba
	[51663] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.NORTHERN_STRANGLETHORN, is_tamable = true, }, -- Pogeyan
	[52146] = { world_id = ZN.EASTERN_KINGDOMS, map_name = ZN.REDRIDGE_MOUNTAINS, is_tamable = true, }, -- Chitter
	[54318] = { world_id = ZN.KALIMDOR, map_name = ZN.MOUNT_HYJAL, is_tamable = true, }, -- Ankha
	[54319] = { world_id = ZN.KALIMDOR, map_name = ZN.MOUNT_HYJAL, is_tamable = true, }, -- Magria
	[54320] = { world_id = ZN.KALIMDOR, map_name = ZN.MOUNT_HYJAL, is_tamable = true, }, -- Ban'thalos
	[54321] = { world_id = ZN.MOLTEN_FRONT, map_name = ZN.MOLTEN_FRONT, is_tamable = true, }, -- Solix
	[54322] = { world_id = ZN.MOLTEN_FRONT, map_name = ZN.MOLTEN_FRONT, is_tamable = true, }, -- Deth'tilac
	[54323] = { world_id = ZN.MOLTEN_FRONT, map_name = ZN.MOLTEN_FRONT, is_tamable = true, }, -- Kirix
	[54324] = { world_id = ZN.MOLTEN_FRONT, map_name = ZN.MOLTEN_FRONT, is_tamable = true, }, -- Skitterflame
	[54338] = { world_id = ZN.MOLTEN_FRONT, map_name = ZN.MOLTEN_FRONT, is_tamable = true, }, -- Anthriss
	[54533] = { world_id = ZN.KALIMDOR, map_name = ZN.SILITHUS, is_tamable = true, }, -- Prince Lakma
	[56081] = { world_id = ZN.HILLSBRAD_FOOTHILLS, map_name = ZN.OLD_HILLSBRAD_FOOTHILLS, }, -- Optimistic Benj
	[58474] = { world_id = ZN.PANDARIA, map_name = ZN.VALE_OF_ETERNAL_BLOSSOMS, is_tamable = true, is_achievement = true, }, -- Bloodtip
	[58768] = { world_id = ZN.PANDARIA, map_name = ZN.VALE_OF_ETERNAL_BLOSSOMS, is_achievement = true, }, -- Cracklefang
	[58769] = { world_id = ZN.PANDARIA, map_name = ZN.VALE_OF_ETERNAL_BLOSSOMS, is_achievement = true, }, -- Vicejaw
	[58771] = { world_id = ZN.PANDARIA, map_name = ZN.VALE_OF_ETERNAL_BLOSSOMS, }, -- Quid
	[58778] = { world_id = ZN.PANDARIA, map_name = ZN.VALE_OF_ETERNAL_BLOSSOMS, }, -- Aetha
	[58817] = { world_id = ZN.PANDARIA, map_name = ZN.VALE_OF_ETERNAL_BLOSSOMS, is_achievement = true, }, -- Spirit of Lao-Fe
	[58949] = { world_id = ZN.PANDARIA, map_name = ZN.VALE_OF_ETERNAL_BLOSSOMS, is_achievement = true, }, -- Bai'Jin the Butcher
	[59369] = { world_id = ZN.SCHOLOMANCE, map_name = ZN.SCHOLOMANCE, }, -- Doctor Theolen Krastinov
	[62880] = { world_id = ZN.PANDARIA, map_name = ZN.VALE_OF_ETERNAL_BLOSSOMS, is_achievement = true, }, -- Gochao the Ironfist
	[62881] = { world_id = ZN.PANDARIA, map_name = ZN.VALE_OF_ETERNAL_BLOSSOMS, is_achievement = true, }, -- Gaohun the Soul-Severer
	[63101] = { world_id = ZN.PANDARIA, map_name = ZN.VALE_OF_ETERNAL_BLOSSOMS, is_achievement = true, }, -- General Temuja
	[63240] = { world_id = ZN.PANDARIA, map_name = ZN.VALE_OF_ETERNAL_BLOSSOMS, is_achievement = true, }, -- Shadowmaster Sydow
	[63509] = { world_id = ZN.PANDARIA, map_name = ZN.VALE_OF_ETERNAL_BLOSSOMS, is_tamable = true, is_achievement = true, }, -- Wulon
	[63510] = { world_id = ZN.PANDARIA, map_name = ZN.VALE_OF_ETERNAL_BLOSSOMS, is_tamable = true, is_achievement = true, }, -- Wulon
	[63691] = { world_id = ZN.PANDARIA, map_name = ZN.VALE_OF_ETERNAL_BLOSSOMS, is_achievement = true, }, -- Huo-Shuang
	[63695] = { world_id = ZN.PANDARIA, map_name = ZN.VALE_OF_ETERNAL_BLOSSOMS, is_achievement = true, }, -- Baolai the Immolator
	[63977] = { world_id = ZN.PANDARIA, map_name = ZN.VALE_OF_ETERNAL_BLOSSOMS, is_achievement = true, }, -- Vyraxxis
	[63978] = { world_id = ZN.PANDARIA, map_name = ZN.VALE_OF_ETERNAL_BLOSSOMS, is_achievement = true, }, -- Kri'chon
	[68317] = { world_id = ZN.PANDARIA, map_name = ZN.KRASARANG_WILDS, }, -- Mavis Harms
	[68318] = { world_id = ZN.PANDARIA, map_name = ZN.KRASARANG_WILDS, }, -- Dalan Nightbreaker
	[68319] = { world_id = ZN.PANDARIA, map_name = ZN.KRASARANG_WILDS, }, -- Disha Fearwarden
	[68320] = { world_id = ZN.PANDARIA, map_name = ZN.KRASARANG_WILDS, }, -- Ubunti the Shade
	[68321] = { world_id = ZN.PANDARIA, map_name = ZN.KRASARANG_WILDS, }, -- Kar Warmaker
	[68322] = { world_id = ZN.PANDARIA, map_name = ZN.KRASARANG_WILDS, }, -- Muerta
	[69099] = { world_id = ZN.PANDARIA, map_name = ZN.ISLE_OF_THUNDER, }, -- Nalak
	[69161] = { world_id = ZN.PANDARIA, map_name = ZN.ISLE_OF_GIANTS, }, -- Oondasta
	[69664] = { world_id = ZN.PANDARIA, map_name = ZN.ISLE_OF_THUNDER, }, -- Mumta
	[69768] = { world_id = ZN.PANDARIA, map_name = ZN.TOWNLONG_STEPPES, }, -- Zandalari Warscout
	[69769] = { world_id = ZN.PANDARIA, map_name = ZN.TOWNLONG_STEPPES, }, -- Zandalari Warbringer
	[69841] = { world_id = ZN.PANDARIA, map_name = ZN.TOWNLONG_STEPPES, }, -- Zandalari Warbringer
	[69842] = { world_id = ZN.PANDARIA, map_name = ZN.DREAD_WASTES, }, -- Zandalari Warbringer
	[69843] = { world_id = ZN.ISLE_OF_THUNDER, map_name = ZN.THRONE_OF_THUNDER, }, -- Zao'cho
	[69996] = { world_id = ZN.PANDARIA, map_name = ZN.ISLE_OF_THUNDER, is_achievement = true, }, -- Ku'lai the Skyclaw
	[69997] = { world_id = ZN.PANDARIA, map_name = ZN.ISLE_OF_THUNDER, is_achievement = true, }, -- Progenitus
	[69998] = { world_id = ZN.PANDARIA, map_name = ZN.ISLE_OF_THUNDER, is_tamable = true, is_achievement = true, }, -- Goda
	[69999] = { world_id = ZN.PANDARIA, map_name = ZN.ISLE_OF_THUNDER, is_achievement = true, }, -- God-Hulk Ramuk
	[70000] = { world_id = ZN.PANDARIA, map_name = ZN.ISLE_OF_THUNDER, is_achievement = true, }, -- Al'tabim the All-Seeing
	[70001] = { world_id = ZN.PANDARIA, map_name = ZN.ISLE_OF_THUNDER, is_achievement = true, }, -- Backbreaker Uru
	[70002] = { world_id = ZN.PANDARIA, map_name = ZN.ISLE_OF_THUNDER, is_achievement = true, }, -- Lu-Ban
	[70003] = { world_id = ZN.PANDARIA, map_name = ZN.ISLE_OF_THUNDER, is_achievement = true, }, -- Molthor
	[70096] = { world_id = ZN.PANDARIA, map_name = ZN.ISLE_OF_GIANTS, }, -- War-God Dokah
	[70126] = { world_id = ZN.PANDARIA, map_name = ZN.THE_VEILED_STAIR, }, -- Willy Wilder
	[70238] = { world_id = ZN.ISLE_OF_THUNDER, map_name = ZN.THRONE_OF_THUNDER, }, -- Unblinking Eye
	[70249] = { world_id = ZN.ISLE_OF_THUNDER, map_name = ZN.THRONE_OF_THUNDER, }, -- Focused Eye
	[70276] = { world_id = ZN.ISLE_OF_THUNDER, map_name = ZN.THRONE_OF_THUNDER, }, -- No'ku Stormsayer
	[70323] = { world_id = ZN.PANDARIA, map_name = ZN.KUN_LAI_SUMMIT, }, -- Krakkanon
	[70430] = { world_id = ZN.ISLE_OF_THUNDER, map_name = ZN.THRONE_OF_THUNDER, }, -- Rocky Horror
	[70440] = { world_id = ZN.ISLE_OF_THUNDER, map_name = ZN.THRONE_OF_THUNDER, }, -- Monara
	[70530] = { world_id = ZN.ISLE_OF_THUNDER, map_name = ZN.ISLE_OF_THUNDER, }, -- Ra'sha
	[71665] = { world_id = ZN.DRAENOR, map_name = ZN.FROSTFIRE_RIDGE, quest_id = 32918 }, -- Giant-Slayer Kul
	[71721] = { world_id = ZN.DRAENOR, map_name = ZN.FROSTFIRE_RIDGE, quest_id = 32941 }, -- Canyon Icemother
	[71864] = { world_id = ZN.PANDARIA, map_name = ZN.TIMELESS_ISLE, is_achievement = true, }, -- Spelurk
	[71919] = { world_id = ZN.PANDARIA, map_name = ZN.TIMELESS_ISLE, is_achievement = true, }, -- Zhu-Gon the Sour
	[72045] = { world_id = ZN.PANDARIA, map_name = ZN.TIMELESS_ISLE, is_achievement = true, }, -- Chelon
	[72048] = { world_id = ZN.PANDARIA, map_name = ZN.TIMELESS_ISLE, is_achievement = true, }, -- Rattleskew
	[72049] = { world_id = ZN.PANDARIA, map_name = ZN.TIMELESS_ISLE, is_achievement = true, }, -- Cranegnasher
	[72156] = { world_id = ZN.DRAENOR, map_name = ZN.FROSTFIRE_RIDGE, }, -- Borrok the Devourer
	[72193] = { world_id = ZN.PANDARIA, map_name = ZN.TIMELESS_ISLE, is_achievement = true, }, -- Karkanos
	[72245] = { world_id = ZN.PANDARIA, map_name = ZN.TIMELESS_ISLE, is_achievement = true, }, -- Zesqua
	[72294] = { world_id = ZN.DRAENOR, map_name = ZN.FROSTFIRE_RIDGE, quest_id = 33014 }, -- Cindermaw
	[72362] = { world_id = ZN.DRAENOR, map_name = ZN.SHADOWMOON_VALLEY_DRAENOR, quest_id = 33039 }, -- Ku'targ the Voidseer
	[72364] = { world_id = ZN.DRAENOR, map_name = ZN.FROSTFIRE_RIDGE, quest_id = 33512 }, -- Gorg'ak the Lava Guzzler
	[72537] = { world_id = ZN.DRAENOR, map_name = ZN.SHADOWMOON_VALLEY_DRAENOR, quest_id = 33055 }, -- Leaf-Reader Kurri
	[72606] = { world_id = ZN.DRAENOR, map_name = ZN.SHADOWMOON_VALLEY_DRAENOR, is_tamable = true, quest_id = 34068 }, -- Rockhoof
	[72769] = { world_id = ZN.PANDARIA, map_name = ZN.TIMELESS_ISLE, is_achievement = true, }, -- Spirit of Jadefire
	[72775] = { world_id = ZN.PANDARIA, map_name = ZN.TIMELESS_ISLE, is_achievement = true, }, -- Bufo
	[72808] = { world_id = ZN.PANDARIA, map_name = ZN.TIMELESS_ISLE, is_tamable = true, is_achievement = true, }, -- Tsavo'ka
	[72909] = { world_id = ZN.PANDARIA, map_name = ZN.TIMELESS_ISLE, is_achievement = true, }, -- Gu'chi the Swarmbringer
	[72970] = { world_id = ZN.PANDARIA, map_name = ZN.TIMELESS_ISLE, is_achievement = true, }, -- Golganarr
	[73157] = { world_id = ZN.PANDARIA, map_name = ZN.TIMELESS_ISLE, is_achievement = true, }, -- Rock Moss
	[73158] = { world_id = ZN.PANDARIA, map_name = ZN.TIMELESS_ISLE, is_tamable = true, is_achievement = true, }, -- Emerald Gander
	[73160] = { world_id = ZN.PANDARIA, map_name = ZN.TIMELESS_ISLE, is_achievement = true, }, -- Ironfur Steelhorn
	[73161] = { world_id = ZN.PANDARIA, map_name = ZN.TIMELESS_ISLE, is_tamable = true, is_achievement = true, }, -- Great Turtle Furyshell
	[73163] = { world_id = ZN.PANDARIA, map_name = ZN.TIMELESS_ISLE, is_achievement = true, }, -- Imperial Python
	[73166] = { world_id = ZN.PANDARIA, map_name = ZN.TIMELESS_ISLE, is_tamable = true, is_achievement = true, }, -- Monstrous Spineclaw
	[73167] = { world_id = ZN.PANDARIA, map_name = ZN.TIMELESS_ISLE, is_achievement = true, }, -- Huolon
	[73169] = { world_id = ZN.PANDARIA, map_name = ZN.TIMELESS_ISLE, is_achievement = true, }, -- Jakur of Ordon
	[73170] = { world_id = ZN.PANDARIA, map_name = ZN.TIMELESS_ISLE, is_achievement = true, }, -- Watcher Osu
	[73171] = { world_id = ZN.PANDARIA, map_name = ZN.TIMELESS_ISLE, is_achievement = true, }, -- Champion of the Black Flame
	[73172] = { world_id = ZN.PANDARIA, map_name = ZN.TIMELESS_ISLE, is_achievement = true, }, -- Flintlord Gairan
	[73173] = { world_id = ZN.PANDARIA, map_name = ZN.TIMELESS_ISLE, is_achievement = true, }, -- Urdur the Cauterizer
	[73174] = { world_id = ZN.PANDARIA, map_name = ZN.TIMELESS_ISLE, is_achievement = true, }, -- Archiereus of Flame
	[73175] = { world_id = ZN.PANDARIA, map_name = ZN.TIMELESS_ISLE, is_achievement = true, }, -- Cinderfall
	[73277] = { world_id = ZN.PANDARIA, map_name = ZN.TIMELESS_ISLE, is_achievement = true, }, -- Leafmender
	[73279] = { world_id = ZN.PANDARIA, map_name = ZN.TIMELESS_ISLE, is_achievement = true, }, -- Evermaw
	[73281] = { world_id = ZN.PANDARIA, map_name = ZN.TIMELESS_ISLE, is_achievement = true, }, -- Dread Ship Vazuvius
	[73282] = { world_id = ZN.PANDARIA, map_name = ZN.TIMELESS_ISLE, is_achievement = true, }, -- Garnia
	[73293] = { world_id = ZN.PANDARIA, map_name = ZN.TIMELESS_ISLE, }, -- Whizzig
	[73666] = { world_id = ZN.PANDARIA, map_name = ZN.TIMELESS_ISLE, is_achievement = true, }, -- Archiereus of Flame
	[73704] = { world_id = ZN.PANDARIA, map_name = ZN.TIMELESS_ISLE, is_achievement = true, }, -- Stinkbraid
	[73854] = { world_id = ZN.PANDARIA, map_name = ZN.TIMELESS_ISLE, is_achievement = true, }, -- Cranegnasher
	[74206] = { world_id = ZN.DRAENOR, map_name = ZN.SHADOWMOON_VALLEY_DRAENOR, is_tamable = true, quest_id = 33043 }, -- Killmaw
	[74613] = { world_id = ZN.DRAENOR, map_name = ZN.FROSTFIRE_RIDGE, quest_id = 33843 }, -- Broodmother Reeg'ak
	[74971] = { world_id = ZN.DRAENOR, map_name = ZN.FROSTFIRE_RIDGE, quest_id = 33504 }, -- Firefury Giant
	[75071] = { world_id = ZN.DRAENOR, map_name = ZN.SHADOWMOON_VALLEY_DRAENOR, quest_id = 33642 }, -- Mother Om'ra
	[75434] = { world_id = ZN.DRAENOR, map_name = ZN.SHADOWMOON_VALLEY_DRAENOR, quest_id = 33038 }, -- Windfang Matriarch
	[75435] = { world_id = ZN.DRAENOR, map_name = ZN.SHADOWMOON_VALLEY_DRAENOR, quest_id = 33389 }, -- Yggdrel
	[75482] = { world_id = ZN.DRAENOR, map_name = ZN.SHADOWMOON_VALLEY_DRAENOR, is_tamable = true, quest_id = 33640 }, -- Veloss
	[75492] = { world_id = ZN.DRAENOR, map_name = ZN.SHADOWMOON_VALLEY_DRAENOR, quest_id = 33643 }, -- Venomshade
	[76380] = { world_id = ZN.DRAENOR, map_name = ZN.SHADOWMOON_VALLEY_DRAENOR, quest_id = 33664 }, -- Gorum
	[76473] = { world_id = ZN.DRAENOR, map_name = ZN.GORGROND, is_tamable = true, quest_id = 34726 }, -- Mother Araneae
	[76914] = { world_id = ZN.DRAENOR, map_name = ZN.FROSTFIRE_RIDGE, is_tamable = true, quest_id = 34131 }, -- Coldtusk
	[76918] = { world_id = ZN.DRAENOR, map_name = ZN.FROSTFIRE_RIDGE, quest_id = 33938 }, -- Primalist Mur'og
	[77085] = { world_id = ZN.DRAENOR, map_name = ZN.SHADOWMOON_VALLEY_DRAENOR, quest_id = 33064 }, -- Dark Emanation
	[77140] = { world_id = ZN.DRAENOR, map_name = ZN.SHADOWMOON_VALLEY_DRAENOR, is_tamable = true, quest_id = 33061 }, -- Amaukwa
	[77310] = { world_id = ZN.DRAENOR, map_name = ZN.SHADOWMOON_VALLEY_DRAENOR, quest_id = 35906 }, -- Mad "King" Sporeon
	[77513] = { world_id = ZN.DRAENOR, map_name = ZN.FROSTFIRE_RIDGE, is_tamable = true, quest_id = 34129 }, -- Coldstomp the Griever
	[77519] = { world_id = ZN.DRAENOR, map_name = ZN.FROSTFIRE_RIDGE, is_tamable = true, }, -- Giantbane
	[77526] = { world_id = ZN.DRAENOR, map_name = ZN.FROSTFIRE_RIDGE, quest_id = 34132 }, -- Scout Goreseeker
	[77527] = { world_id = ZN.DRAENOR, map_name = ZN.FROSTFIRE_RIDGE, quest_id = 34133 }, -- The Beater
	[77529] = { world_id = ZN.DRAENOR, map_name = ZN.TALADOR, quest_id = 34135 }, -- Yazheera the Incinerator
	[77561] = { world_id = ZN.DRAENOR, map_name = ZN.TALADOR, quest_id = 34142 }, -- Dr. Gloom
	[77614] = { world_id = ZN.DRAENOR, map_name = ZN.TALADOR, quest_id = 34145 }, -- Frenzied Golem
	[77620] = { world_id = ZN.DRAENOR, map_name = ZN.TALADOR, quest_id = 34165 }, -- Cro Fleshrender
	[77626] = { world_id = ZN.DRAENOR, map_name = ZN.TALADOR, is_tamable = true, quest_id = 34167 }, -- Hen-Mother Hami
	[77634] = { world_id = ZN.DRAENOR, map_name = ZN.TALADOR, is_tamable = true, quest_id = 34171 }, -- Taladorantula
	[77664] = { world_id = ZN.DRAENOR, map_name = ZN.TALADOR, quest_id = 34182 }, -- Aarko
	[77715] = { world_id = ZN.DRAENOR, map_name = ZN.TALADOR, is_tamable = true, quest_id = 34185 }, -- Hammertooth
	[77719] = { world_id = ZN.DRAENOR, map_name = ZN.TALADOR, is_tamable = true, quest_id = 34189 }, -- Glimmerwing
	[77741] = { world_id = ZN.DRAENOR, map_name = ZN.TALADOR, is_tamable = true, quest_id = 34196 }, -- Ra'kahn
	[77750] = { world_id = ZN.DRAENOR, map_name = ZN.TALADOR, quest_id = 34199 }, -- Kaavu the Crimson Claw
	[77776] = { world_id = ZN.DRAENOR, map_name = ZN.TALADOR, quest_id = 34205 }, -- Wandering Vindicator
	[77784] = { world_id = ZN.DRAENOR, map_name = ZN.TALADOR, quest_id = 34208 }, -- Lo'marg Jawcrusher
	[77795] = { world_id = ZN.DRAENOR, map_name = ZN.TALADOR, quest_id = 34221 }, -- Echo of Murmur
	[77828] = { world_id = ZN.DRAENOR, map_name = ZN.TALADOR, }, -- Echo of Murmur
	[78128] = { world_id = ZN.DRAENOR, map_name = ZN.FROSTFIRE_RIDGE, }, -- Gronnstalker Dawarn
	[78134] = { world_id = ZN.DRAENOR, map_name = ZN.FROSTFIRE_RIDGE, }, -- Pathfinder Jalog
	[78144] = { world_id = ZN.DRAENOR, map_name = ZN.FROSTFIRE_RIDGE, }, -- Giantslayer Kimla
	[78150] = { world_id = ZN.DRAENOR, map_name = ZN.FROSTFIRE_RIDGE, }, -- Beastcarver Saramor
	[78151] = { world_id = ZN.DRAENOR, map_name = ZN.FROSTFIRE_RIDGE, quest_id = 34130 }, -- Huntmaster Kuang
	[78161] = { world_id = ZN.DRAENOR, map_name = ZN.NAGRAND_DRAENOR, quest_id = 34862 }, -- Hyperious
	[78169] = { world_id = ZN.DRAENOR, map_name = ZN.FROSTFIRE_RIDGE, }, -- Cloudspeaker Daber
	[78260] = { world_id = ZN.DRAENOR, map_name = ZN.GORGROND, quest_id = 37412 }, -- King Slime
	[78265] = { world_id = ZN.DRAENOR, map_name = ZN.FROSTFIRE_RIDGE, quest_id = 34361 }, -- The Bone Crawler
	[78269] = { world_id = ZN.DRAENOR, map_name = ZN.GORGROND, quest_id = 37413 }, -- Gnarljaw
	[78606] = { world_id = ZN.DRAENOR, map_name = ZN.FROSTFIRE_RIDGE, quest_id = 34470 }, -- Pale Fishmonger
	[78621] = { world_id = ZN.DRAENOR, map_name = ZN.FROSTFIRE_RIDGE, quest_id = 34477 }, -- Cyclonic Fury
	[78710] = { world_id = ZN.DRAENOR, map_name = ZN.TALADOR, quest_id = 35219 }, -- Kharazos the Triumphant
	[78713] = { world_id = ZN.DRAENOR, map_name = ZN.TALADOR, quest_id = 35219 }, -- Galzomar
	[78715] = { world_id = ZN.DRAENOR, map_name = ZN.TALADOR, quest_id = 35219 }, -- Sikthiss, Maiden of Slaughter
	[78867] = { world_id = ZN.DRAENOR, map_name = ZN.FROSTFIRE_RIDGE, quest_id = 34497 }, -- Breathless
	[78872] = { world_id = ZN.DRAENOR, map_name = ZN.TALADOR, is_tamable = true, quest_id = 34498 }, -- Klikixx
	[79024] = { world_id = ZN.DRAENOR, map_name = ZN.NAGRAND_DRAENOR, quest_id = 34645 }, -- Warmaster Blugthol
	[79104] = { world_id = ZN.DRAENOR, map_name = ZN.FROSTFIRE_RIDGE, quest_id = 34522 }, -- Ug'lok the Frozen
	[79145] = { world_id = ZN.DRAENOR, map_name = ZN.FROSTFIRE_RIDGE, quest_id = 34559 }, -- Yaga the Scarred
	[79334] = { world_id = ZN.DRAENOR, map_name = ZN.TALADOR, is_tamable = true, quest_id = 34859 }, -- No'losh
	[79485] = { world_id = ZN.DRAENOR, map_name = ZN.TALADOR, quest_id = 34668 }, -- Talonpriest Zorkra
	[79524] = { world_id = ZN.DRAENOR, map_name = ZN.SHADOWMOON_VALLEY_DRAENOR, quest_id = 35558 }, -- Hypnocroak
	[79543] = { world_id = ZN.DRAENOR, map_name = ZN.TALADOR, quest_id = 34671 }, -- Shirzir
	[79629] = { world_id = ZN.DRAENOR, map_name = ZN.GORGROND, quest_id = 35910 }, -- Stomper Kreego
	[79686] = { world_id = ZN.DRAENOR, map_name = ZN.SHADOWMOON_VALLEY_DRAENOR, }, -- Silverleaf Ancient
	[79692] = { world_id = ZN.DRAENOR, map_name = ZN.SHADOWMOON_VALLEY_DRAENOR, }, -- Silverleaf Ancient
	[79693] = { world_id = ZN.DRAENOR, map_name = ZN.SHADOWMOON_VALLEY_DRAENOR, }, -- Silverleaf Ancient
	[79725] = { world_id = ZN.DRAENOR, map_name = ZN.NAGRAND_DRAENOR, quest_id = 34727 }, -- Captain Ironbeard
	[79938] = { world_id = ZN.DRAENOR, map_name = ZN.SPIRES_OF_ARAK, quest_id = 36478 }, -- Shadowbark
	[80057] = { world_id = ZN.DRAENOR, map_name = ZN.NAGRAND_DRAENOR, quest_id = 36128 }, -- Soulfang
	[80122] = { world_id = ZN.DRAENOR, map_name = ZN.NAGRAND_DRAENOR, is_tamable = true, quest_id = 34725 }, -- Gaz'orda
	[80190] = { world_id = ZN.DRAENOR, map_name = ZN.FROSTFIRE_RIDGE, quest_id = 34825 }, -- Gruuk
	[80204] = { world_id = ZN.DRAENOR, map_name = ZN.TALADOR, quest_id = 35018 }, -- Felbark
	[80235] = { world_id = ZN.DRAENOR, map_name = ZN.FROSTFIRE_RIDGE, quest_id = 34839 }, -- Gurun
	[80242] = { world_id = ZN.DRAENOR, map_name = ZN.FROSTFIRE_RIDGE, is_tamable = true, quest_id = 34843 }, -- Chillfang
	[80312] = { world_id = ZN.DRAENOR, map_name = ZN.FROSTFIRE_RIDGE, quest_id = 34865 }, -- Grutush the Pillager
	[80370] = { world_id = ZN.DRAENOR, map_name = ZN.NAGRAND_DRAENOR, is_tamable = true, quest_id = 37408 }, -- Lernaea
	[80371] = { world_id = ZN.DRAENOR, map_name = ZN.GORGROND, quest_id = 37405 }, -- Typhon
	[80372] = { world_id = ZN.DRAENOR, map_name = ZN.SPIRES_OF_ARAK, is_tamable = true, quest_id = 37406 }, -- Echidna
	[80398] = { world_id = ZN.DRAENOR, map_name = ZN.TANAAN_JUNGLE, is_tamable = true, quest_id = 37407 }, -- Keravnos
	[80471] = { world_id = ZN.DRAENOR, map_name = ZN.TALADOR, is_tamable = true, quest_id = 34929 }, -- Gennadian
	[80524] = { world_id = ZN.DRAENOR, map_name = ZN.TALADOR, quest_id = 34945 }, -- Underseer Bloodmane
	[80614] = { world_id = ZN.DRAENOR, map_name = ZN.SPIRES_OF_ARAK, quest_id = 35599 }, -- Blade-Dancer Aeryx
	[80725] = { world_id = ZN.DRAENOR, map_name = ZN.GORGROND, quest_id = 36394 }, -- Sulfurious
	[80868] = { world_id = ZN.DRAENOR, map_name = ZN.GORGROND, quest_id = 36204 }, -- Glut
	[81038] = { world_id = ZN.DRAENOR, map_name = ZN.GORGROND, quest_id = 36391 }, -- Gelgor of the Blue Flame
	[81406] = { world_id = ZN.DRAENOR, map_name = ZN.SHADOWMOON_VALLEY_DRAENOR, quest_id = 35281 }, -- Bahameye
	[81639] = { world_id = ZN.DRAENOR, map_name = ZN.SHADOWMOON_VALLEY_DRAENOR, quest_id = 33383 }, -- Brambleking Fili
	[82050] = { world_id = ZN.DRAENOR, map_name = ZN.SPIRES_OF_ARAK, is_tamable = true, }, -- Varasha
	[82058] = { world_id = ZN.DRAENOR, map_name = ZN.GORGROND, is_achievement = true, quest_id = 37370 }, -- Depthroot
	[82085] = { world_id = ZN.DRAENOR, map_name = ZN.GORGROND, quest_id = 35335 }, -- Bashiok
	[82207] = { world_id = ZN.DRAENOR, map_name = ZN.SHADOWMOON_VALLEY_DRAENOR, quest_id = 35725 }, -- Faebright
	[82247] = { world_id = ZN.DRAENOR, map_name = ZN.SPIRES_OF_ARAK, quest_id = 36129 }, -- Nas Dunberlin
	[82268] = { world_id = ZN.DRAENOR, map_name = ZN.SHADOWMOON_VALLEY_DRAENOR, quest_id = 35448 }, -- Darkmaster Go'vid
	[82311] = { world_id = ZN.DRAENOR, map_name = ZN.GORGROND, quest_id = 35503 }, -- Char the Burning
	[82326] = { world_id = ZN.DRAENOR, map_name = ZN.SHADOWMOON_VALLEY_DRAENOR, quest_id = 35731 }, -- Ba'ruun
	[82362] = { world_id = ZN.DRAENOR, map_name = ZN.SHADOWMOON_VALLEY_DRAENOR, quest_id = 35523 }, -- Morva Soultwister
	[82374] = { world_id = ZN.DRAENOR, map_name = ZN.SHADOWMOON_VALLEY_DRAENOR, quest_id = 35553 }, -- Rai'vosh
	[82411] = { world_id = ZN.DRAENOR, map_name = ZN.SHADOWMOON_VALLEY_DRAENOR, quest_id = 35555 }, -- Darktalon
	[82415] = { world_id = ZN.DRAENOR, map_name = ZN.SHADOWMOON_VALLEY_DRAENOR, quest_id = 35732 }, -- Shinri
	[82486] = { world_id = ZN.DRAENOR, map_name = ZN.NAGRAND_DRAENOR, quest_id = 35623 }, -- Explorer Nozzand
	[82536] = { world_id = ZN.DRAENOR, map_name = ZN.FROSTFIRE_RIDGE, quest_id = 37388 }, -- Gorivax
	[82614] = { world_id = ZN.DRAENOR, map_name = ZN.FROSTFIRE_RIDGE, quest_id = 37387 }, -- Moltnoma
	[82616] = { world_id = ZN.DRAENOR, map_name = ZN.FROSTFIRE_RIDGE, is_tamable = true, quest_id = 37386 }, -- Jabberjaw
	[82617] = { world_id = ZN.DRAENOR, map_name = ZN.FROSTFIRE_RIDGE, is_tamable = true, quest_id = 37385 }, -- Slogtusk the Corpse-Eater
	[82618] = { world_id = ZN.DRAENOR, map_name = ZN.FROSTFIRE_RIDGE, quest_id = 37384 }, -- Tor'goroth
	[82620] = { world_id = ZN.DRAENOR, map_name = ZN.FROSTFIRE_RIDGE, quest_id = 37383 }, -- Son of Goramal
	[82676] = { world_id = ZN.DRAENOR, map_name = ZN.SHADOWMOON_VALLEY_DRAENOR, quest_id = 35688 }, -- Enavra
	[82742] = { world_id = ZN.DRAENOR, map_name = ZN.SHADOWMOON_VALLEY_DRAENOR, quest_id = 35688 }, -- Enavra
	[82755] = { world_id = ZN.DRAENOR, map_name = ZN.NAGRAND_DRAENOR, quest_id = 35712 }, -- Redclaw the Feral
	[82758] = { world_id = ZN.DRAENOR, map_name = ZN.NAGRAND_DRAENOR, is_tamable = true, quest_id = 35714 }, -- Greatfeather
	[82764] = { world_id = ZN.DRAENOR, map_name = ZN.NAGRAND_DRAENOR, quest_id = 35715 }, -- Gar'lua
	[82778] = { world_id = ZN.DRAENOR, map_name = ZN.NAGRAND_DRAENOR, is_tamable = true, quest_id = 35717 }, -- Gnarlhoof the Rabid
	[82826] = { world_id = ZN.DRAENOR, map_name = ZN.NAGRAND_DRAENOR, quest_id = 35735 }, -- Berserk T-300 Series Mark II
	[82876] = { world_id = ZN.DRAENOR, map_name = ZN.ASHRAN, }, -- Grand Marshal Tremblade
	[82877] = { world_id = ZN.DRAENOR, map_name = ZN.ASHRAN, }, -- High Warlord Volrath
	[82878] = { world_id = ZN.DRAENOR, map_name = ZN.ASHRAN, }, -- Marshal Gabriel
	[82880] = { world_id = ZN.DRAENOR, map_name = ZN.ASHRAN, }, -- Marshal Karsh Stormforge
	[82882] = { world_id = ZN.DRAENOR, map_name = ZN.ASHRAN, }, -- General Aevd
	[82883] = { world_id = ZN.DRAENOR, map_name = ZN.ASHRAN, }, -- Warlord Noktyn
	[82899] = { world_id = ZN.DRAENOR, map_name = ZN.NAGRAND_DRAENOR, quest_id = 35778 }, -- Ancient Blademaster
	[82912] = { world_id = ZN.DRAENOR, map_name = ZN.NAGRAND_DRAENOR, is_tamable = true, quest_id = 35784 }, -- Grizzlemaw
	[82920] = { world_id = ZN.DRAENOR, map_name = ZN.TALADOR, is_achievement = true, quest_id = 37345 }, -- Lord Korinak
	[82922] = { world_id = ZN.DRAENOR, map_name = ZN.TALADOR, is_achievement = true, quest_id = 37343 }, -- Xothear, the Destroyer
	[82930] = { world_id = ZN.DRAENOR, map_name = ZN.TALADOR, is_achievement = true, quest_id = 37347 }, -- Shadowflame Terrorwalker
	[82942] = { world_id = ZN.DRAENOR, map_name = ZN.TALADOR, is_achievement = true, quest_id = 37346 }, -- Lady Demlash
	[82975] = { world_id = ZN.DRAENOR, map_name = ZN.NAGRAND_DRAENOR, quest_id = 35836 }, -- Fangler
	[82988] = { world_id = ZN.DRAENOR, map_name = ZN.TALADOR, is_achievement = true, quest_id = 37348 }, -- Kurlosh Doomfang
	[82992] = { world_id = ZN.DRAENOR, map_name = ZN.TALADOR, is_achievement = true, quest_id = 37341 }, -- Felfire Consort
	[82998] = { world_id = ZN.DRAENOR, map_name = ZN.TALADOR, is_achievement = true, quest_id = 37349 }, -- Matron of Sin
	[83008] = { world_id = ZN.DRAENOR, map_name = ZN.TALADOR, is_achievement = true, quest_id = 37312 }, -- Haakun the All-Consuming
	[83019] = { world_id = ZN.DRAENOR, map_name = ZN.TALADOR, is_achievement = true, quest_id = 37340 }, -- Gug'tol
	[83385] = { world_id = ZN.DRAENOR, map_name = ZN.SHADOWMOON_VALLEY_DRAENOR, quest_id = 35847 }, -- Voidseer Kalurg
	[83401] = { world_id = ZN.DRAENOR, map_name = ZN.NAGRAND_DRAENOR, quest_id = 35865 }, -- Netherspawn
	[83409] = { world_id = ZN.DRAENOR, map_name = ZN.NAGRAND_DRAENOR, quest_id = 35875 }, -- Ophiis
	[83428] = { world_id = ZN.DRAENOR, map_name = ZN.NAGRAND_DRAENOR, quest_id = 35877 }, -- Windcaller Korast
	[83483] = { world_id = ZN.DRAENOR, map_name = ZN.NAGRAND_DRAENOR, is_tamable = true, quest_id = 35893 }, -- Flinthide
	[83509] = { world_id = ZN.DRAENOR, map_name = ZN.NAGRAND_DRAENOR, quest_id = 35898 }, -- Gorepetal
	[83522] = { world_id = ZN.DRAENOR, map_name = ZN.GORGROND, is_tamable = true, quest_id = 35908 }, -- Hive Queen Skrikka
	[83526] = { world_id = ZN.DRAENOR, map_name = ZN.NAGRAND_DRAENOR, quest_id = 35900 }, -- Ru'klaa
	[83542] = { world_id = ZN.DRAENOR, map_name = ZN.NAGRAND_DRAENOR, quest_id = 35912 }, -- Sean Whitesea
	[83553] = { world_id = ZN.DRAENOR, map_name = ZN.SHADOWMOON_VALLEY_DRAENOR, is_tamable = true, quest_id = 35909 }, -- Insha'tar
	[83591] = { world_id = ZN.DRAENOR, map_name = ZN.NAGRAND_DRAENOR, is_tamable = true, quest_id = 35920 }, -- Tura'aka
	[83603] = { world_id = ZN.DRAENOR, map_name = ZN.NAGRAND_DRAENOR, quest_id = 35923 }, -- Hunter Blacktooth
	[83634] = { world_id = ZN.DRAENOR, map_name = ZN.NAGRAND_DRAENOR, quest_id = 35931 }, -- Scout Pokhar
	[83643] = { world_id = ZN.DRAENOR, map_name = ZN.NAGRAND_DRAENOR, quest_id = 35932 }, -- Malroc Stonesunder
	[83680] = { world_id = ZN.DRAENOR, map_name = ZN.NAGRAND_DRAENOR, quest_id = 35943 }, -- Outrider Duretha
	[83683] = { world_id = ZN.DRAENOR, map_name = ZN.ASHRAN, is_achievement = true, }, -- Mandragoraster
	[83691] = { world_id = ZN.DRAENOR, map_name = ZN.ASHRAN, is_achievement = true, }, -- Panthora
	[83713] = { world_id = ZN.DRAENOR, map_name = ZN.ASHRAN, is_achievement = true, }, -- Titarus
	[83819] = { world_id = ZN.DRAENOR, map_name = ZN.ASHRAN, is_achievement = true, }, -- Brickhouse
	[83990] = { world_id = ZN.DRAENOR, map_name = ZN.SPIRES_OF_ARAK, quest_id = 37394 }, -- Solar Magnifier
	[84110] = { world_id = ZN.DRAENOR, map_name = ZN.ASHRAN, is_achievement = true, }, -- Korthall Soulgorger
	[84196] = { world_id = ZN.DRAENOR, map_name = ZN.ASHRAN, }, -- Web-wrapped Soldier
	[84263] = { world_id = ZN.DRAENOR, map_name = ZN.NAGRAND_DRAENOR, quest_id = 36159 }, -- Graveltooth
	[84374] = { world_id = ZN.DRAENOR, map_name = ZN.FROSTFIRE_RIDGE, quest_id = 37404 }, -- Kaga the Ironbender
	[84376] = { world_id = ZN.DRAENOR, map_name = ZN.FROSTFIRE_RIDGE, quest_id = 37403 }, -- Earthshaker Holar
	[84378] = { world_id = ZN.DRAENOR, map_name = ZN.FROSTFIRE_RIDGE, quest_id = 37525 }, -- Ak'ox the Slaughterer
	[84392] = { world_id = ZN.DRAENOR, map_name = ZN.FROSTFIRE_RIDGE, quest_id = 37401 }, -- Ragore Driftstalker
	[84406] = { world_id = ZN.DRAENOR, map_name = ZN.GORGROND, quest_id = 36178 }, -- Mandrakor
	[84417] = { world_id = ZN.DRAENOR, map_name = ZN.SPIRES_OF_ARAK, quest_id = 36396 }, -- Mutafen
	[84431] = { world_id = ZN.DRAENOR, map_name = ZN.GORGROND, quest_id = 36186 }, -- Greldrok the Cunning
	[84435] = { world_id = ZN.DRAENOR, map_name = ZN.NAGRAND_DRAENOR, quest_id = 36229 }, -- Mr. Pinchy Sr.
	[84465] = { world_id = ZN.DRAENOR, map_name = ZN.ASHRAN, }, -- Leaping Gorger
	[84746] = { world_id = ZN.DRAENOR, map_name = ZN.ASHRAN, }, -- Captured Gor'vosh Stoneshaper
	[84775] = { world_id = ZN.DRAENOR, map_name = ZN.SPIRES_OF_ARAK, quest_id = 36254 }, -- Tesska the Broken
	[84805] = { world_id = ZN.DRAENOR, map_name = ZN.SPIRES_OF_ARAK, is_tamable = true, quest_id = 36265 }, -- Stonespite
	[84807] = { world_id = ZN.DRAENOR, map_name = ZN.SPIRES_OF_ARAK, quest_id = 36267 }, -- Durkath Steelmaw
	[84810] = { world_id = ZN.DRAENOR, map_name = ZN.SPIRES_OF_ARAK, quest_id = 36268 }, -- Kalos the Bloodbathed
	[84833] = { world_id = ZN.DRAENOR, map_name = ZN.SPIRES_OF_ARAK, quest_id = 36276 }, -- Sangrikass
	[84836] = { world_id = ZN.DRAENOR, map_name = ZN.SPIRES_OF_ARAK, quest_id = 36278 }, -- Talonbreaker
	[84838] = { world_id = ZN.DRAENOR, map_name = ZN.SPIRES_OF_ARAK, quest_id = 36279 }, -- Poisonmaster Bortusk
	[84854] = { world_id = ZN.DRAENOR, map_name = ZN.ASHRAN, }, -- Slippery Slime
	[84856] = { world_id = ZN.DRAENOR, map_name = ZN.SPIRES_OF_ARAK, is_tamable = true, quest_id = 36283 }, -- Blightglow
	[84872] = { world_id = ZN.DRAENOR, map_name = ZN.SPIRES_OF_ARAK, quest_id = 36288 }, -- Oskiira the Vengeful
	[84875] = { world_id = ZN.DRAENOR, map_name = ZN.ASHRAN, is_achievement = true, }, -- Ancient Inferno
	[84887] = { world_id = ZN.DRAENOR, map_name = ZN.SPIRES_OF_ARAK, quest_id = 36291 }, -- Betsi Boombasket
	[84890] = { world_id = ZN.DRAENOR, map_name = ZN.SPIRES_OF_ARAK, quest_id = 36297 }, -- Festerbloom
	[84893] = { world_id = ZN.DRAENOR, map_name = ZN.ASHRAN, is_tamable = true, is_achievement = true, }, -- Goregore
	[84904] = { world_id = ZN.DRAENOR, map_name = ZN.ASHRAN, is_achievement = true, }, -- Oraggro
	[84911] = { world_id = ZN.DRAENOR, map_name = ZN.SHADOWMOON_VALLEY_DRAENOR, quest_id = 37351 }, -- Demidos
	[84912] = { world_id = ZN.DRAENOR, map_name = ZN.SPIRES_OF_ARAK, is_tamable = true, quest_id = 36298 }, -- Sunderthorn
	[84925] = { world_id = ZN.DRAENOR, map_name = ZN.SHADOWMOON_VALLEY_DRAENOR, quest_id = 37352 }, -- Quartermaster Hershak
	[84951] = { world_id = ZN.DRAENOR, map_name = ZN.SPIRES_OF_ARAK, quest_id = 36305 }, -- Gobblefin
	[84955] = { world_id = ZN.DRAENOR, map_name = ZN.SPIRES_OF_ARAK, is_tamable = true, quest_id = 36306 }, -- Jiasska the Sporegorger
	[85001] = { world_id = ZN.DRAENOR, map_name = ZN.SHADOWMOON_VALLEY_DRAENOR, quest_id = 37353 }, -- Master Sergeant Milgra
	[85026] = { world_id = ZN.DRAENOR, map_name = ZN.SPIRES_OF_ARAK, quest_id = 37358 }, -- Soul-Twister Torek
	[85029] = { world_id = ZN.DRAENOR, map_name = ZN.SHADOWMOON_VALLEY_DRAENOR, quest_id = 37354 }, -- Shadowspeaker Niir
	[85036] = { world_id = ZN.DRAENOR, map_name = ZN.SPIRES_OF_ARAK, quest_id = 37360 }, -- Formless Nightmare
	[85037] = { world_id = ZN.DRAENOR, map_name = ZN.SPIRES_OF_ARAK, quest_id = 37361 }, -- Kenos the Unraveler
	[85078] = { world_id = ZN.DRAENOR, map_name = ZN.SPIRES_OF_ARAK, quest_id = 37359 }, -- Voidreaver Urnae
	[85121] = { world_id = ZN.DRAENOR, map_name = ZN.SHADOWMOON_VALLEY_DRAENOR, quest_id = 37355 }, -- Lady Temptessa
	[85250] = { world_id = ZN.DRAENOR, map_name = ZN.GORGROND, quest_id = 36387 }, -- Fossilwood the Petrified
	[85264] = { world_id = ZN.DRAENOR, map_name = ZN.GORGROND, quest_id = 36393 }, -- Rolkor
	[85451] = { world_id = ZN.DRAENOR, map_name = ZN.SHADOWMOON_VALLEY_DRAENOR, quest_id = 37357 }, -- Malgosh Shadowkeeper
	[85504] = { world_id = ZN.DRAENOR, map_name = ZN.SPIRES_OF_ARAK, quest_id = 36470 }, -- Rotcap
	[85520] = { world_id = ZN.DRAENOR, map_name = ZN.SPIRES_OF_ARAK, quest_id = 36472 }, -- Swarmleaf
	[85555] = { world_id = ZN.DRAENOR, map_name = ZN.SHADOWMOON_VALLEY_DRAENOR, quest_id = 37409 }, -- Nagidna
	[85568] = { world_id = ZN.DRAENOR, map_name = ZN.SHADOWMOON_VALLEY_DRAENOR, quest_id = 37410 }, -- Avalanche
	[85572] = { world_id = ZN.DRAENOR, map_name = ZN.TALADOR, quest_id = 36919 }, -- Grrbrrgle
	[85763] = { world_id = ZN.DRAENOR, map_name = ZN.ASHRAN, }, -- Cursed Ravager
	[85766] = { world_id = ZN.DRAENOR, map_name = ZN.ASHRAN, }, -- Cursed Sharptalon
	[85767] = { world_id = ZN.DRAENOR, map_name = ZN.ASHRAN, }, -- Cursed Harbinger
	[85771] = { world_id = ZN.DRAENOR, map_name = ZN.ASHRAN, is_achievement = true, }, -- Elder Darkweaver Kath
	[85837] = { world_id = ZN.DRAENOR, map_name = ZN.SHADOWMOON_VALLEY_DRAENOR, quest_id = 37411 }, -- Slivermaw
	[85907] = { world_id = ZN.DRAENOR, map_name = ZN.GORGROND, is_tamable = true, quest_id = 36597 }, -- Berthora
	[85970] = { world_id = ZN.DRAENOR, map_name = ZN.GORGROND, is_tamable = true, quest_id = 36600 }, -- Riptar
	[86137] = { world_id = ZN.DRAENOR, map_name = ZN.GORGROND, quest_id = 36656 }, -- Sunclaw
	[86257] = { world_id = ZN.DRAENOR, map_name = ZN.GORGROND, is_achievement = true, quest_id = 37369 }, -- Basten
	[86258] = { world_id = ZN.DRAENOR, map_name = ZN.GORGROND, }, -- Nultra
	[86259] = { world_id = ZN.DRAENOR, map_name = ZN.GORGROND, }, -- Valstil
	[86266] = { world_id = ZN.DRAENOR, map_name = ZN.GORGROND, is_tamable = true, is_achievement = true, quest_id = 37372 }, -- Venolasix
	[86268] = { world_id = ZN.DRAENOR, map_name = ZN.GORGROND, is_achievement = true, quest_id = 37371 }, -- Alkali
	[86410] = { world_id = ZN.DRAENOR, map_name = ZN.GORGROND, quest_id = 36794 }, -- Sylldross
	[86520] = { world_id = ZN.DRAENOR, map_name = ZN.GORGROND, is_tamable = true, quest_id = 36837 }, -- Stompalupagus
	[86549] = { world_id = ZN.DRAENOR, map_name = ZN.TALADOR, quest_id = 36858 }, -- Steeltusk
	[86562] = { world_id = ZN.DRAENOR, map_name = ZN.GORGROND, is_achievement = true, quest_id = 37363 }, -- Maniacal Madgard
	[86566] = { world_id = ZN.DRAENOR, map_name = ZN.GORGROND, is_achievement = true, quest_id = 37362 }, -- Defector Dazgo
	[86571] = { world_id = ZN.DRAENOR, map_name = ZN.GORGROND, is_achievement = true, quest_id = 37366 }, -- Durp the Hated
	[86574] = { world_id = ZN.DRAENOR, map_name = ZN.GORGROND, is_achievement = true, quest_id = 37367 }, -- Inventor Blammo
	[86577] = { world_id = ZN.DRAENOR, map_name = ZN.GORGROND, is_achievement = true, quest_id = 37365 }, -- Horgg
	[86579] = { world_id = ZN.DRAENOR, map_name = ZN.GORGROND, is_achievement = true, quest_id = 37368 }, -- Blademaster Ro'gor
	[86582] = { world_id = ZN.DRAENOR, map_name = ZN.GORGROND, is_achievement = true, quest_id = 37364 }, -- Morgo Kain
	[86621] = { world_id = ZN.DRAENOR, map_name = ZN.SPIRES_OF_ARAK, is_achievement = true, }, -- Morphed Sentient
	[86689] = { world_id = ZN.DRAENOR, map_name = ZN.SHADOWMOON_VALLEY_DRAENOR, quest_id = 36880 }, -- Sneevel
	[86724] = { world_id = ZN.DRAENOR, map_name = ZN.SPIRES_OF_ARAK, quest_id = 36887 }, -- Hermit Palefur
	[86729] = { world_id = ZN.DRAENOR, map_name = ZN.NAGRAND_DRAENOR, is_tamable = true, }, -- Direhoof
	[86732] = { world_id = ZN.DRAENOR, map_name = ZN.NAGRAND_DRAENOR, is_tamable = true, }, -- Bergruu
	[86743] = { world_id = ZN.DRAENOR, map_name = ZN.NAGRAND_DRAENOR, }, -- Dekorhan
	[86750] = { world_id = ZN.DRAENOR, map_name = ZN.NAGRAND_DRAENOR, is_tamable = true, }, -- Thek'talon
	[86771] = { world_id = ZN.DRAENOR, map_name = ZN.NAGRAND_DRAENOR, }, -- Gagrog the Brutal
	[86774] = { world_id = ZN.DRAENOR, map_name = ZN.NAGRAND_DRAENOR, is_tamable = true, }, -- Aogexon
	[86835] = { world_id = ZN.DRAENOR, map_name = ZN.NAGRAND_DRAENOR, is_tamable = true, }, -- Xelganak
	[86959] = { world_id = ZN.DRAENOR, map_name = ZN.NAGRAND_DRAENOR, is_achievement = true, quest_id = 37399 }, -- Karosh Blackwind
	[86978] = { world_id = ZN.DRAENOR, map_name = ZN.SPIRES_OF_ARAK, quest_id = 36943 }, -- Gaze
	[87019] = { world_id = ZN.DRAENOR, map_name = ZN.SPIRES_OF_ARAK, is_achievement = true, quest_id = 37390 }, -- Gluttonous Giant
	[87026] = { world_id = ZN.DRAENOR, map_name = ZN.SPIRES_OF_ARAK, is_achievement = true, quest_id = 37391 }, -- Mecha Plunderer
	[87027] = { world_id = ZN.DRAENOR, map_name = ZN.SPIRES_OF_ARAK, is_achievement = true, quest_id = 37392 }, -- Shadow Hulk
	[87029] = { world_id = ZN.DRAENOR, map_name = ZN.SPIRES_OF_ARAK, is_achievement = true, quest_id = 37393 }, -- Giga Sentinel
	[87234] = { world_id = ZN.DRAENOR, map_name = ZN.NAGRAND_DRAENOR, is_achievement = true, quest_id = 37400 }, -- Brutag Grimblade
	[87239] = { world_id = ZN.DRAENOR, map_name = ZN.NAGRAND_DRAENOR, is_achievement = true, quest_id = 37473 }, -- Krahl Deadeye
	[87344] = { world_id = ZN.DRAENOR, map_name = ZN.NAGRAND_DRAENOR, is_achievement = true, quest_id = 37472 }, -- Gortag Steelgrip
	[87348] = { world_id = ZN.DRAENOR, map_name = ZN.FROSTFIRE_RIDGE, quest_id = 37382 }, -- Hoarfrost
	[87351] = { world_id = ZN.DRAENOR, map_name = ZN.FROSTFIRE_RIDGE, quest_id = 37381 }, -- Mother of Goren
	[87352] = { world_id = ZN.DRAENOR, map_name = ZN.FROSTFIRE_RIDGE, quest_id = 37380 }, -- Gibblette the Cowardly
	[87356] = { world_id = ZN.DRAENOR, map_name = ZN.FROSTFIRE_RIDGE, quest_id = 37379 }, -- Vrok the Ancient
	[87357] = { world_id = ZN.DRAENOR, map_name = ZN.FROSTFIRE_RIDGE, quest_id = 37378 }, -- Valkor
	[87362] = { world_id = ZN.DRAENOR, map_name = ZN.ASHRAN, is_tamable = true, }, -- Gibby
	[87597] = { world_id = ZN.DRAENOR, map_name = ZN.TALADOR, is_achievement = true, quest_id = 37339 }, -- Bombardier Gu'gok
	[87600] = { world_id = ZN.DRAENOR, map_name = ZN.FROSTFIRE_RIDGE, quest_id = 37556 }, -- Jaluk the Pacifist
	[87622] = { world_id = ZN.DRAENOR, map_name = ZN.FROSTFIRE_RIDGE, quest_id = 37402 }, -- Ogom the Mangler
	[87647] = { world_id = ZN.DRAENOR, map_name = ZN.NAGRAND_DRAENOR, }, -- Aogexon
	[87660] = { world_id = ZN.DRAENOR, map_name = ZN.NAGRAND_DRAENOR, }, -- Dekorhan
	[87661] = { world_id = ZN.DRAENOR, map_name = ZN.NAGRAND_DRAENOR, }, -- Bergruu
	[87666] = { world_id = ZN.DRAENOR, map_name = ZN.NAGRAND_DRAENOR, is_tamable = true, }, -- Mu'gra
	[87668] = { world_id = ZN.DRAENOR, map_name = ZN.TALADOR, is_achievement = true, quest_id = 37344 }, -- Orumo the Observer
	[87788] = { world_id = ZN.DRAENOR, map_name = ZN.NAGRAND_DRAENOR, is_achievement = true, quest_id = 37395 }, -- Durg Spinecrusher
	[87837] = { world_id = ZN.DRAENOR, map_name = ZN.NAGRAND_DRAENOR, is_achievement = true, quest_id = 37396 }, -- Bonebreaker
	[87846] = { world_id = ZN.DRAENOR, map_name = ZN.NAGRAND_DRAENOR, is_achievement = true, quest_id = 37397 }, -- Pit Slayer
	[88043] = { world_id = ZN.DRAENOR, map_name = ZN.TALADOR, is_achievement = true, quest_id = 37338 }, -- Avatar of Socrethar
	[88071] = { world_id = ZN.DRAENOR, map_name = ZN.TALADOR, is_achievement = true, quest_id = 37337 }, -- Strategist Ankor
	[88072] = { world_id = ZN.DRAENOR, map_name = ZN.TALADOR, }, -- Archmagus Tekar
	[88083] = { world_id = ZN.DRAENOR, map_name = ZN.TALADOR, }, -- Soulbinder Naylana
	[88208] = { world_id = ZN.DRAENOR, map_name = ZN.NAGRAND_DRAENOR, quest_id = 37637 }, -- Pit Beast
	[88210] = { world_id = ZN.DRAENOR, map_name = ZN.NAGRAND_DRAENOR, is_achievement = true, quest_id = 37398 }, -- Krud the Eviscerator
	[88436] = { world_id = ZN.DRAENOR, map_name = ZN.TALADOR, is_achievement = true, quest_id = 37350 }, -- Vigilant Paarthos
	[88494] = { world_id = ZN.DRAENOR, map_name = ZN.TALADOR, is_achievement = true, quest_id = 37342 }, -- Legion Vanguard
	[88580] = { world_id = ZN.DRAENOR, map_name = ZN.GORGROND, is_achievement = true, quest_id = 37373 }, -- Firestarter Grash
	[88582] = { world_id = ZN.DRAENOR, map_name = ZN.GORGROND, is_achievement = true, quest_id = 37374 }, -- Swift Onyx Flayer
	[88583] = { world_id = ZN.DRAENOR, map_name = ZN.GORGROND, is_achievement = true, quest_id = 37375 }, -- Grove Warden Yal
	[88586] = { world_id = ZN.DRAENOR, map_name = ZN.GORGROND, is_tamable = true, is_achievement = true, quest_id = 37376 }, -- Mogamago
	[88672] = { world_id = ZN.DRAENOR, map_name = ZN.GORGROND, is_achievement = true, quest_id = 37377 }, -- Hunter Bal'ra
	[88951] = { world_id = ZN.DRAENOR, map_name = ZN.NAGRAND_DRAENOR, is_tamable = true, }, -- Vileclaw
	[89675] = { world_id = ZN.DRAENOR, map_name = ZN.TANAAN_JUNGLE, is_achievement = true, quest_id = 38749 }, -- Commander Org'mok
	[90024] = { world_id = ZN.DRAENOR, map_name = ZN.TANAAN_JUNGLE, is_achievement = true, quest_id = 37953 }, -- Sergeant Mor'grak
	[90094] = { world_id = ZN.DRAENOR, map_name = ZN.TANAAN_JUNGLE, is_achievement = true, quest_id = 39046 }, -- Harbormaster Korak
	[90122] = { world_id = ZN.DRAENOR, map_name = ZN.TANAAN_JUNGLE, is_achievement = true, quest_id = 39045 }, -- Zoug the Heavy
	[90429] = { world_id = ZN.DRAENOR, map_name = ZN.TANAAN_JUNGLE, is_achievement = true, quest_id = 38026 }, -- Imp-Master Valessa
	[90434] = { world_id = ZN.DRAENOR, map_name = ZN.TANAAN_JUNGLE, is_achievement = true, quest_id = 38031 }, -- Ceraxas
	[90437] = { world_id = ZN.DRAENOR, map_name = ZN.TANAAN_JUNGLE, is_achievement = true, quest_id = 38030 }, -- Jax'zor
	[90438] = { world_id = ZN.DRAENOR, map_name = ZN.TANAAN_JUNGLE, is_achievement = true, quest_id = 38029 }, -- Lady Oran
	[90442] = { world_id = ZN.DRAENOR, map_name = ZN.TANAAN_JUNGLE, is_achievement = true, quest_id = 38032 }, -- Mistress Thavra
	[90519] = { world_id = ZN.DRAENOR, map_name = ZN.TANAAN_JUNGLE, is_achievement = true, quest_id = 37990 }, -- Cindral the Wildfire
	[90777] = { world_id = ZN.DRAENOR, map_name = ZN.TANAAN_JUNGLE, quest_id = 38028 }, -- High Priest Ikzan
	[90782] = { world_id = ZN.DRAENOR, map_name = ZN.TANAAN_JUNGLE, is_achievement = true, quest_id = 38034 }, -- Rasthe
	[90884] = { world_id = ZN.DRAENOR, map_name = ZN.TANAAN_JUNGLE, is_achievement = true, quest_id = 38262 }, -- Bilkor the Thrower
	[90885] = { world_id = ZN.DRAENOR, map_name = ZN.TANAAN_JUNGLE, is_achievement = true, quest_id = 38263 }, -- Rogond the Tracker
	[90887] = { world_id = ZN.DRAENOR, map_name = ZN.TANAAN_JUNGLE, is_achievement = true, quest_id = 38265 }, -- Dorg the Bloody
	[90888] = { world_id = ZN.DRAENOR, map_name = ZN.TANAAN_JUNGLE, is_achievement = true, quest_id = 38264 }, -- Drivnul
	[90936] = { world_id = ZN.DRAENOR, map_name = ZN.TANAAN_JUNGLE, is_achievement = true, quest_id = 38266 }, -- Bloodhunter Zulk
	[91009] = { world_id = ZN.DRAENOR, map_name = ZN.TANAAN_JUNGLE, is_achievement = true, quest_id = 38457 }, -- Putre'thar
	[91087] = { world_id = ZN.DRAENOR, map_name = ZN.TANAAN_JUNGLE, is_achievement = true, quest_id = 38207 }, -- Zeter'el
	[91093] = { world_id = ZN.DRAENOR, map_name = ZN.TANAAN_JUNGLE, is_achievement = true, quest_id = 38209 }, -- Bramblefell
	[91098] = { world_id = ZN.DRAENOR, map_name = ZN.TANAAN_JUNGLE, is_achievement = true, quest_id = 38211 }, -- Felspark
	[91227] = { world_id = ZN.DRAENOR, map_name = ZN.TANAAN_JUNGLE, quest_id = 39159 }, -- Remnant of the Blood Moon
	[91232] = { world_id = ZN.DRAENOR, map_name = ZN.TANAAN_JUNGLE, is_achievement = true, quest_id = 38746 }, -- Commander Krag'goth
	[91243] = { world_id = ZN.DRAENOR, map_name = ZN.TANAAN_JUNGLE, is_achievement = true, quest_id = 38747 }, -- Tho'gar Gorefist
	[91374] = { world_id = ZN.DRAENOR, map_name = ZN.TANAAN_JUNGLE, is_achievement = true, quest_id = 38282 }, -- Podlord Wakkawam
	[91695] = { world_id = ZN.DRAENOR, map_name = ZN.TANAAN_JUNGLE, is_achievement = true, quest_id = 38400 }, -- Grand Warlock Nethekurse
	[91727] = { world_id = ZN.DRAENOR, map_name = ZN.TANAAN_JUNGLE, is_achievement = true, quest_id = 38411 }, -- Executor Riloth
	[91871] = { world_id = ZN.DRAENOR, map_name = ZN.TANAAN_JUNGLE, is_achievement = true, quest_id = 38430 }, -- Argosh the Destroyer
	[91921] = { world_id = ZN.DRAENOR, map_name = ZN.ASHRAN, }, -- Wyrmple
	[92197] = { world_id = ZN.DRAENOR, map_name = ZN.TANAAN_JUNGLE, is_achievement = true, quest_id = 38496 }, -- Relgor
	[92274] = { world_id = ZN.DRAENOR, map_name = ZN.TANAAN_JUNGLE, is_achievement = true, quest_id = 38557 }, -- Painmistress Selora
	[92408] = { world_id = ZN.DRAENOR, map_name = ZN.TANAAN_JUNGLE, is_achievement = true, quest_id = 38579 }, -- Xanzith the Everlasting
	[92411] = { world_id = ZN.DRAENOR, map_name = ZN.TANAAN_JUNGLE, is_achievement = true, quest_id = 38580 }, -- Overlord Ma'gruth
	[92429] = { world_id = ZN.DRAENOR, map_name = ZN.TANAAN_JUNGLE, is_tamable = true, is_achievement = true, quest_id = 38589 }, -- Broodlord Ixkor
	[92451] = { world_id = ZN.DRAENOR, map_name = ZN.TANAAN_JUNGLE, is_achievement = true, quest_id = 37937 }, -- Varyx the Damned
	[92465] = { world_id = ZN.DRAENOR, map_name = ZN.TANAAN_JUNGLE, is_achievement = true, quest_id = 38597 }, -- The Blackfang
	[92495] = { world_id = ZN.DRAENOR, map_name = ZN.TANAAN_JUNGLE, is_achievement = true, quest_id = 38600 }, -- Soulslicer
	[92508] = { world_id = ZN.DRAENOR, map_name = ZN.TANAAN_JUNGLE, is_achievement = true, quest_id = 38604 }, -- Gloomtalon
	[92517] = { world_id = ZN.DRAENOR, map_name = ZN.TANAAN_JUNGLE, is_achievement = true, quest_id = 38605 }, -- Krell the Serene
	[92552] = { world_id = ZN.DRAENOR, map_name = ZN.TANAAN_JUNGLE, is_achievement = true, quest_id = 38609 }, -- Belgork
	[92574] = { world_id = ZN.DRAENOR, map_name = ZN.TANAAN_JUNGLE, is_achievement = true, quest_id = 38620 }, -- Thromma the Gutslicer
	[92606] = { world_id = ZN.DRAENOR, map_name = ZN.TANAAN_JUNGLE, is_achievement = true, quest_id = 38628 }, -- Sylissa
	[92627] = { world_id = ZN.DRAENOR, map_name = ZN.TANAAN_JUNGLE, is_tamable = true, is_achievement = true, quest_id = 38631 }, -- Rendrak
	[92636] = { world_id = ZN.DRAENOR, map_name = ZN.TANAAN_JUNGLE, is_achievement = true, quest_id = 38632 }, -- The Night Haunter
	[92645] = { world_id = ZN.DRAENOR, map_name = ZN.TANAAN_JUNGLE, }, -- The Night Haunter
	[92647] = { world_id = ZN.DRAENOR, map_name = ZN.TANAAN_JUNGLE, is_achievement = true, quest_id = 38634 }, -- Felsmith Damorka
	[92657] = { world_id = ZN.DRAENOR, map_name = ZN.TANAAN_JUNGLE, is_achievement = true, quest_id = 38696 }, -- Bleeding Hollow Horror
	[92694] = { world_id = ZN.DRAENOR, map_name = ZN.TANAAN_JUNGLE, is_tamable = true, is_achievement = true, quest_id = 38654 }, -- The Goreclaw
	[92887] = { world_id = ZN.DRAENOR, map_name = ZN.TANAAN_JUNGLE, is_tamable = true, is_achievement = true, quest_id = 38700 }, -- Steelsnout
	[92941] = { world_id = ZN.DRAENOR, map_name = ZN.TANAAN_JUNGLE, is_achievement = true, quest_id = 38709 }, -- Gorabosh
	[92977] = { world_id = ZN.DRAENOR, map_name = ZN.TANAAN_JUNGLE, is_achievement = true, quest_id = 38751 }, -- The Iron Houndmaster
	[93001] = { world_id = ZN.DRAENOR, map_name = ZN.TANAAN_JUNGLE, is_achievement = true, quest_id = 38752 }, -- Szirek the Twisted
	[93002] = { world_id = ZN.DRAENOR, map_name = ZN.TANAAN_JUNGLE, is_tamable = true, is_achievement = true, quest_id = 38726 }, -- Magwia
	[93028] = { world_id = ZN.DRAENOR, map_name = ZN.TANAAN_JUNGLE, is_achievement = true, quest_id = 38736 }, -- Driss Vile
	[93057] = { world_id = ZN.DRAENOR, map_name = ZN.TANAAN_JUNGLE, is_achievement = true, quest_id = 38750 }, -- Grannok
	[93076] = { world_id = ZN.DRAENOR, map_name = ZN.TANAAN_JUNGLE, is_achievement = true, quest_id = 38756 }, -- Captain Ironbeard
	[93125] = { world_id = ZN.DRAENOR, map_name = ZN.TANAAN_JUNGLE, is_achievement = true, quest_id = 38764 }, -- Glub'glok
	[93168] = { world_id = ZN.DRAENOR, map_name = ZN.TANAAN_JUNGLE, is_achievement = true, quest_id = 38775 }, -- Felbore
	[93236] = { world_id = ZN.DRAENOR, map_name = ZN.TANAAN_JUNGLE, is_tamable = true, is_achievement = true, quest_id = 38812 }, -- Shadowthrash
	[93264] = { world_id = ZN.DRAENOR, map_name = ZN.TANAAN_JUNGLE, is_achievement = true, quest_id = 38820 }, -- Captain Grok'mar
	[93279] = { world_id = ZN.DRAENOR, map_name = ZN.TANAAN_JUNGLE, is_achievement = true, quest_id = 38825 }, -- Kris'kar the Unredeemed
	[94113] = { world_id = ZN.DRAENOR, map_name = ZN.ASHRAN, }, -- Rukmaz
	[95044] = { world_id = ZN.DRAENOR, map_name = ZN.TANAAN_JUNGLE, is_achievement = true, quest_id = 39288 }, -- Terrorfist
	[95053] = { world_id = ZN.DRAENOR, map_name = ZN.TANAAN_JUNGLE, is_achievement = true, quest_id = 39287 }, -- Deathtalon
	[95054] = { world_id = ZN.DRAENOR, map_name = ZN.TANAAN_JUNGLE, is_achievement = true, quest_id = 39290 }, -- Vengeance
	[95056] = { world_id = ZN.DRAENOR, map_name = ZN.TANAAN_JUNGLE, is_achievement = true, quest_id = 39289 }, -- Doomroller
	[96235] = { world_id = ZN.DRAENOR, map_name = ZN.TANAAN_JUNGLE, }, -- Xemirkol
	[96323] = { world_id = ZN.DRAENOR, map_name = _G.GARRISON_LOCATION_TOOLTIP, quest_id = 39617 }, -- Arachnis
	[98198] = { world_id = ZN.DRAENOR, map_name = ZN.NAGRAND_DRAENOR, quest_id = 40075 }, -- Rukdug
	[98199] = { world_id = ZN.DRAENOR, map_name = ZN.NAGRAND_DRAENOR, quest_id = 40073 }, -- Pugg
	[98200] = { world_id = ZN.DRAENOR, map_name = ZN.NAGRAND_DRAENOR, quest_id = 40074 }, -- Guk
	[98283] = { world_id = ZN.DRAENOR, map_name = ZN.TANAAN_JUNGLE, quest_id = 40105 }, -- Drakum
	[98284] = { world_id = ZN.DRAENOR, map_name = ZN.TANAAN_JUNGLE, quest_id = 40106 }, -- Gondar
	[98285] = { world_id = ZN.DRAENOR, map_name = ZN.TANAAN_JUNGLE, quest_id = 40104 }, -- Smashum Grabb
	[98408] = { world_id = ZN.DRAENOR, map_name = ZN.TANAAN_JUNGLE, quest_id = 40107 }, -- Fel Overseer Mudlump
}

private.NPC_ID_TO_MAP_NAME = {}
private.NPC_ID_TO_NAME = {}
private.NPC_ID_TO_WORLD_NAME = {}
private.NPC_NAME_TO_ID = {}
private.NPC_ID_TO_QUEST_ID = {}


private.TAMABLE_ID_TO_MAP_NAME = {}
private.TAMABLE_ID_TO_NAME = {}
private.TAMABLE_ID_TO_WORLD_NAME = {}
private.TAMABLE_NON_ACHIEVMENT_LIST = {}


private.UNTAMABLE_ID_TO_NAME = {}
private.UNTAMABLE_ID_TO_WORLD_NAME = {}


private.CUSTOM_NPC_ID_TO_NAME = {}
private.CUSTOM_NPC_ID_TO_WORLD_NAME = {}
private.CUSTOM_NPC_NAME_TO_ID = {}


for npc_id, data in pairs(NPC_DATA) do
	private.NPC_ID_TO_MAP_NAME[npc_id] = data.map_name
	private.NPC_ID_TO_NAME[npc_id] = L.NPCs[tostring(npc_id)]
	private.NPC_ID_TO_WORLD_NAME[npc_id] = data.world_id
	private.NPC_NAME_TO_ID[L.NPCs[tostring(npc_id)]] = npc_id

	if data.quest_id then private.NPC_ID_TO_QUEST_ID[npc_id] = data.quest_id end

	if data.is_tamable then
		private.TAMABLE_ID_TO_MAP_NAME[npc_id] = data.map_name
		private.TAMABLE_ID_TO_NAME[npc_id] = L.NPCs[tostring(npc_id)]
		private.TAMABLE_ID_TO_WORLD_NAME[npc_id] = data.world_id
		--Builds a list of non achievement mobs for the Beast tab
		if not data.is_achievement then
			private.TAMABLE_NON_ACHIEVMENT_LIST[npc_id] = L.NPCs[tostring(npc_id)]
		end

	elseif not data.is_achievement then
		private.UNTAMABLE_ID_TO_NAME[npc_id] = L.NPCs[tostring(npc_id)]
		private.UNTAMABLE_ID_TO_WORLD_NAME[npc_id] = data.world_id
	end
end


--Update Database with Achievement Mobs info provided by the game.
for achievement_id, achievement in pairs(private.ACHIEVEMENTS) do
	for criteria_id, npc_id in pairs(achievement.Criteria) do

	local npc_name = _G.GetAchievementCriteriaInfoByID(achievement_id, criteria_id)
	private.NPC_ID_TO_NAME[npc_id] = npc_name
	private.NPC_NAME_TO_ID[npc_name] = npc_id
	end
end


do
	local function TableKeyFormat(input)
		if not input then
			return ""
		end

		return input:upper():gsub(" ", "_"):gsub("'", ""):gsub(":", ""):gsub("-", "_"):gsub("%(", ""):gsub("%)", "")
	end


	local function rpad(input, length)
		return (" "):rep(length - #input)
	end




	function private.DumpNPCData()
		if not private.TextDump then
			return
		end
		local output = private.TextDump
		local data = NPC_DATA
		local dump_data = {}
		local longest_world = 0
		local longest_map = 0
		local longest_id = 0

		for npc_id, data in pairs(NPC_DATA) do
			local source = NPC_DATA[npc_id]
			dump_data[npc_id] = {
				world_id = ("ZN.%s"):format(TableKeyFormat(source.world_id)),
				map_name = source.map_name and ("ZN.%s"):format(TableKeyFormat(source.map_name)) or tostring(nil),
				is_tamable = source.is_tamable,
				is_achievement = source.is_achievement,
				quest_id = source.quest_id
			}

			if #dump_data[npc_id].world_id > longest_world then
				longest_world = #dump_data[npc_id].world_id
			end

			if #dump_data[npc_id].map_name > longest_map then
				longest_map = #dump_data[npc_id].map_name
			end

			local id_str = tostring(npc_id)
			if #id_str > longest_id then
				longest_id = #id_str
			end
		end

		local npc_output = {}

		for npc_id in pairs(dump_data) do
			npc_output[#npc_output + 1] = npc_id
		end
		table.sort(npc_output)

		output:Clear()
		output:AddLine("local NPC_DATA = {")

		for index = 1, #npc_output do
			local npc_id = npc_output[index]
			local info = dump_data[npc_id]
			output:AddLine(("[%d]%s = { world_id = %s,%s map_name = %s,%s is_tamable = %s,%s is_achievement = %s,%s quest_id = %s%s }, -- %s"):format(
				npc_id,
				rpad(tostring(npc_id), longest_id),
				tostring(info.world_id),
				rpad(tostring(info.world_id), longest_world),
				tostring(info.map_name),
				rpad(tostring(info.map_name), longest_map),
				tostring(info.is_tamable),
				rpad(tostring(info.is_tamable), 5),
				tostring(info.is_achievement),
				rpad(tostring(info.is_achievement), 5),
				tostring(info.quest_id),
				rpad(tostring(info.quest_id), 5),
				private.L.NPCs[tostring(npc_id)] or "**** NO LOCALIZATION ****")
			)
		end

		output:AddLine("}")
		output:Display()
	end
end -- do-block

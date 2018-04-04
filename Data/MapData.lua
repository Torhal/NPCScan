-- ----------------------------------------------------------------------------
-- Localized Lua globals.
-- ----------------------------------------------------------------------------
-- Functions
local pairs = _G.pairs

-- Libraries
local table = _G.table

-- -- ---------------------------------------------------------------------------------
-- AddOn namespace.
-- -- ---------------------------------------------------------------------------------
local AddOnFolderName, private = ...

local LibStub = _G.LibStub
local HereBeDragons = LibStub("HereBeDragons-1.0")

local MapNPCs = {
	-- ----------------------------------------------------------------------------
	-- Durotar
	-- ----------------------------------------------------------------------------
	[4] = {
		[5809] = true, -- Sergeant Curtis
		[5822] = true, -- Felweaver Scornn
		[5823] = true, -- Death Flayer
		[5824] = true, -- Captain Flat Tusk
		[5826] = true, -- Geolord Mottle
	},
	-- ----------------------------------------------------------------------------
	-- Mulgore
	-- ----------------------------------------------------------------------------
	[9] = {
		[3058] = true, -- Arra'chea
		[3068] = true, -- Mazzranache
		[5785] = true, -- Sister Hatelash
		[5786] = true, -- Snagglespear
		[5787] = true, -- Enforcer Emilgund
		[5807] = true, -- The Rake
		[43613] = true, -- Doomsayer Wiserunner
	},
	-- ----------------------------------------------------------------------------
	-- Northern Barrens
	-- ----------------------------------------------------------------------------
	[11] = {
		[3270] = true, -- Elder Mystic Razorsnout
		[3295] = true, -- Sludge Anomaly
		[3398] = true, -- Gesharahan
		[3470] = true, -- Rathorian
		[3652] = true, -- Trigore the Lasher
		[3672] = true, -- Boahn
		[5828] = true, -- Humar the Pridelord
		[5830] = true, -- Sister Rathtalon
		[5831] = true, -- Swiftmane
		[5835] = true, -- Foreman Grills
		[5836] = true, -- Engineer Whirleygig
		[5837] = true, -- Stonearm
		[5838] = true, -- Brokespear
		[5841] = true, -- Rocklance
		[5842] = true, -- Takk the Leaper
		[5865] = true, -- Dishu
	},
	-- ----------------------------------------------------------------------------
	-- Arathi Highlands
	-- ----------------------------------------------------------------------------
	[16] = {
		[2598] = true, -- Darbel Montrose
		[2600] = true, -- Singer
		[2601] = true, -- Foulbelly
		[2602] = true, -- Ruul Onestone
		[2603] = true, -- Kovork
		[2604] = true, -- Molok the Crusher
		[2605] = true, -- Zalas Witherbark
		[2606] = true, -- Nimar the Slayer
		[2609] = true, -- Geomancer Flintdagger
		[2779] = true, -- Prince Nazjak
		[50337] = true, -- Cackle
		[50770] = true, -- Zorn
		[50804] = true, -- Ripwing
		[50865] = true, -- Saurix
		[50891] = true, -- Boros
		[50940] = true, -- Swee
		[51040] = true, -- Snuffles
		[51063] = true, -- Phalanax
		[51067] = true, -- Glint
	},
	-- ----------------------------------------------------------------------------
	-- Badlands
	-- ----------------------------------------------------------------------------
	[17] = {
		[2744] = true, -- Shadowforge Commander
		[2749] = true, -- Barricade
		[2751] = true, -- War Golem
		[2752] = true, -- Rumbler
		[2753] = true, -- Barnabus
		[2754] = true, -- Anathemus
		[2850] = true, -- Broken Tooth
		[2931] = true, -- Zaricotl
		[14224] = true, -- 7:XT
		[50726] = true, -- Kalixx
		[50728] = true, -- Deathstrike
		[50731] = true, -- Needlefang
		[50838] = true, -- Tabbs
		[51000] = true, -- Blackshell the Impenetrable
		[51007] = true, -- Serkett
		[51018] = true, -- Zormus
		[51021] = true, -- Vorticus
	},
	-- ----------------------------------------------------------------------------
	-- Blasted Lands
	-- ----------------------------------------------------------------------------
	[19] = {
		[7846] = true, -- Teremus the Devourer
		[8296] = true, -- Mojo the Twisted
		[8297] = true, -- Magronos the Unyielding
		[8298] = true, -- Akubar the Seer
		[8299] = true, -- Spiteflayer
		[8300] = true, -- Ravage
		[8301] = true, -- Clack the Reaver
		[8302] = true, -- Deatheye
		[8303] = true, -- Grunter
		[8304] = true, -- Dreadscorn
		[45257] = true, -- Mordak Nightbender
		[45258] = true, -- Cassia the Slitherqueen
		[45260] = true, -- Blackleaf
		[45262] = true, -- Narixxus the Doombringer
	},
	-- ----------------------------------------------------------------------------
	-- Tirisfal Glades
	-- ----------------------------------------------------------------------------
	[20] = {
		[1531] = true, -- Lost Soul
		[1533] = true, -- Tormented Spirit
		[1910] = true, -- Muad
		[1911] = true, -- Deeb
		[1936] = true, -- Farmer Solliden
		[10356] = true, -- Bayne
		[10357] = true, -- Ressan the Needler
		[10358] = true, -- Fellicent's Shade
		[10359] = true, -- Sri'skulk
		[50763] = true, -- Shadowstalker
		[50803] = true, -- Bonechewer
		[50908] = true, -- Nighthowl
		[50930] = true, -- Hibernus the Sleeper
		[51044] = true, -- Plague
	},
	-- ----------------------------------------------------------------------------
	-- Silverpine Forest
	-- ----------------------------------------------------------------------------
	[21] = {
		[12431] = true, -- Gorefang
		[12433] = true, -- Krethis the Shadowspinner
		[46981] = true, -- Nightlash
		[46992] = true, -- Berard the Moon-Crazed
		[47003] = true, -- Bolgaff
		[47008] = true, -- Fenwick Thatros
		[47009] = true, -- Aquarius the Unbound
		[47012] = true, -- Effritus
		[47015] = true, -- Lost Son of Arugal
		[47023] = true, -- Thule Ravenclaw
		[50330] = true, -- Kree
		[50814] = true, -- Corpsefeeder
		[50949] = true, -- Finn's Gambit
		[51026] = true, -- Gnath
		[51037] = true, -- Lost Gilnean Wardog
	},
	-- ----------------------------------------------------------------------------
	-- Western Plaguelands
	-- ----------------------------------------------------------------------------
	[22] = {
		[1837] = true, -- Scarlet Judge
		[1838] = true, -- Scarlet Interrogator
		[1839] = true, -- Scarlet High Clerist
		[1841] = true, -- Scarlet Executioner
		[1847] = true, -- Foulmane
		[1848] = true, -- Lord Maldazzar
		[1849] = true, -- Dreadwhisper
		[1850] = true, -- Putridius
		[1851] = true, -- The Husk
		[1885] = true, -- Scarlet Smith
		[50345] = true, -- Alit
		[50778] = true, -- Ironweb
		[50809] = true, -- Heress
		[50906] = true, -- Mutilax
		[50922] = true, -- Warg
		[50931] = true, -- Mange
		[50937] = true, -- Hamhide
		[51029] = true, -- Parasitus
		[51031] = true, -- Tracker
		[51058] = true, -- Aphis
		[111122] = true, -- Large Vile Slime
	},
	-- ----------------------------------------------------------------------------
	-- Eastern Plaguelands
	-- ----------------------------------------------------------------------------
	[23] = {
		[1843] = true, -- Foreman Jerris
		[1844] = true, -- Foreman Marcrid
		[10817] = true, -- Duggan Wildhammer
		[10818] = true, -- Death Knight Soulbearer
		[10819] = true, -- Baron Bloodbane
		[10820] = true, -- Duke Ragereaver
		[10821] = true, -- Hed'mush the Rotting
		[10823] = true, -- Zul'Brin Warpbranch
		[10824] = true, -- Death-Hunter Hawkspear
		[10825] = true, -- Gish the Unmoving
		[10826] = true, -- Lord Darkscythe
		[10827] = true, -- Deathspeaker Selendre
		[10828] = true, -- Lynnia Abbendis
		[16184] = true, -- Nerubian Overseer
		[50775] = true, -- Likk the Hunter
		[50779] = true, -- Sporeggon
		[50813] = true, -- Fene-mal
		[50856] = true, -- Snark
		[50915] = true, -- Snort
		[50947] = true, -- Varah
		[51027] = true, -- Spirocula
		[51042] = true, -- Bleakheart
		[51053] = true, -- Quirix
	},
	-- ----------------------------------------------------------------------------
	-- Hillsbrad Foothills
	-- ----------------------------------------------------------------------------
	[24] = {
		[2258] = true, -- Maggarrak
		[2452] = true, -- Skhowl
		[2453] = true, -- Lo'Grosh
		[14221] = true, -- Gravis Slipknot
		[14222] = true, -- Araga
		[14223] = true, -- Cranky Benj
		[14275] = true, -- Tamra Stormpike
		[14276] = true, -- Scargil
		[14277] = true, -- Lady Zephris
		[14278] = true, -- Ro'Bark
		[14279] = true, -- Creepthess
		[14280] = true, -- Big Samras
		[14281] = true, -- Jimmy the Bleeder
		[47010] = true, -- Indigos
		[50335] = true, -- Alitus
		[50765] = true, -- Miasmiss
		[50770] = true, -- Zorn
		[50818] = true, -- The Dark Prowler
		[50858] = true, -- Dustwing
		[50929] = true, -- Little Bjorn
		[50955] = true, -- Carcinak
		[50967] = true, -- Craw the Ravager
		[51022] = true, -- Chordix
		[51057] = true, -- Weevil
		[51076] = true, -- Lopex
	},
	-- ----------------------------------------------------------------------------
	-- The Hinterlands
	-- ----------------------------------------------------------------------------
	[26] = {
		[8210] = true, -- Razortalon
		[8211] = true, -- Old Cliff Jumper
		[8212] = true, -- The Reak
		[8213] = true, -- Ironback
		[8214] = true, -- Jalinde Summerdrake
		[8215] = true, -- Grimungous
		[8216] = true, -- Retherokk the Berserker
		[8217] = true, -- Mith'rethis the Enchanter
		[8218] = true, -- Witherheart the Stalker
		[8219] = true, -- Zul'arek Hatefowler
		[107617] = true, -- Ol' Muddle
	},
	-- ----------------------------------------------------------------------------
	-- Dun Morogh
	-- ----------------------------------------------------------------------------
	[27] = {
		[1119] = true, -- Hammerspine
		[1130] = true, -- Bjarn
		[1137] = true, -- Edan the Howler
		[1260] = true, -- Great Father Arctikus
	},
	-- ----------------------------------------------------------------------------
	-- Searing Gorge
	-- ----------------------------------------------------------------------------
	[28] = {
		[8277] = true, -- Rekk'tilac
		[8278] = true, -- Smoldar
		[8279] = true, -- Faulty War Golem
		[8280] = true, -- Shleipnarr
		[8281] = true, -- Scald
		[8282] = true, -- Highlord Mastrogonde
		[8283] = true, -- Slave Master Blackheart
		[8924] = true, -- The Behemoth
		[50846] = true, -- Slavermaw
		[50876] = true, -- Avis
		[50946] = true, -- Hogzilla
		[50948] = true, -- Crystalback
		[51002] = true, -- Scorpoxx
		[51010] = true, -- Snips
		[51048] = true, -- Rexxus
		[51066] = true, -- Crystalfang
	},
	-- ----------------------------------------------------------------------------
	-- Burning Steppes
	-- ----------------------------------------------------------------------------
	[29] = {
		[8924] = true, -- The Behemoth
		[8976] = true, -- Hematos
		[8978] = true, -- Thauris Balgarr
		[8979] = true, -- Gruklash
		[8981] = true, -- Malfunctioning Reaver
		[9602] = true, -- Hahk'Zor
		[9604] = true, -- Gorgon'och
		[10077] = true, -- Deathmaw
		[10078] = true, -- Terrorspark
		[10119] = true, -- Volchan
		[50357] = true, -- Sunwing
		[50361] = true, -- Ornat
		[50725] = true, -- Azelisk
		[50730] = true, -- Venomspine
		[50792] = true, -- Chiaa
		[50807] = true, -- Catal
		[50810] = true, -- Favored of Isiset
		[50839] = true, -- Chromehound
		[50842] = true, -- Magmagan
		[50855] = true, -- Jaxx the Rabid
		[51066] = true, -- Crystalfang
	},
	-- ----------------------------------------------------------------------------
	-- Elwynn Forest
	-- ----------------------------------------------------------------------------
	[30] = {
		[61] = true, -- Thuros Lightfingers
		[62] = true, -- Gug Fatcandle
		[79] = true, -- Narg the Taskmaster
		[99] = true, -- Morgaine the Sly
		[100] = true, -- Gruff Swiftbite
		[471] = true, -- Mother Fang
		[472] = true, -- Fedfennel
		[50752] = true, -- Tarantis
		[50916] = true, -- Lamepaw the Whimperer
		[50926] = true, -- Grizzled Ben
		[50942] = true, -- Snoot the Rooter
		[51014] = true, -- Terrapis
		[51077] = true, -- Bushtail
	},
	-- ----------------------------------------------------------------------------
	-- Duskwood
	-- ----------------------------------------------------------------------------
	[34] = {
		[507] = true, -- Fenros
		[521] = true, -- Lupos
		[534] = true, -- Nefaru
		[574] = true, -- Naraxis
		[45739] = true, -- The Unknown Soldier
		[45740] = true, -- Watcher Eva
		[45771] = true, -- Marus
		[45785] = true, -- Carved One
		[45801] = true, -- Eliza
		[45811] = true, -- Marina DeSirrus
		[118244] = true, -- Lightning Paw
	},
	-- ----------------------------------------------------------------------------
	-- Loch Modan
	-- ----------------------------------------------------------------------------
	[35] = {
		[1398] = true, -- Boss Galgosh
		[1399] = true, -- Magosh
		[1425] = true, -- Kubb
		[2476] = true, -- Gosh-Haldir
		[14266] = true, -- Shanda the Spinner
		[14267] = true, -- Emogg the Crusher
		[14268] = true, -- Lord Condar
		[45369] = true, -- Morick Darkbrew
		[45380] = true, -- Ashtail
		[45384] = true, -- Sagepaw
		[45398] = true, -- Grizlak
		[45399] = true, -- Optimo
		[45401] = true, -- Whitefin
		[45402] = true, -- Nix
		[45404] = true, -- Geoshaper Maren
	},
	-- ----------------------------------------------------------------------------
	-- Redridge Mountains
	-- ----------------------------------------------------------------------------
	[36] = {
		[584] = true, -- Kazon
		[616] = true, -- Chatter
		[947] = true, -- Rohh the Silent
		[14269] = true, -- Seeker Aqualon
		[14270] = true, -- Squiddic
		[14271] = true, -- Ribchaser
		[14272] = true, -- Snarlflare
		[14273] = true, -- Boulderheart
		[52146] = true, -- Chitter
	},
	-- ----------------------------------------------------------------------------
	-- Northern Stranglethorn
	-- ----------------------------------------------------------------------------
	[37] = {
		[11383] = true, -- High Priestess Hai'watna
		[14487] = true, -- Gluggl
		[14488] = true, -- Roloch
		[51658] = true, -- Mogh the Dead
		[51661] = true, -- Tsul'Kalu
		[51662] = true, -- Mahamba
		[51663] = true, -- Pogeyan
	},
	-- ----------------------------------------------------------------------------
	-- Swamp of Sorrows
	-- ----------------------------------------------------------------------------
	[38] = {
		[763] = true, -- Lost One Chieftain
		[1063] = true, -- Jade
		[1106] = true, -- Lost One Cook
		[5348] = true, -- Dreamwatcher Forktongue
		[14445] = true, -- Captain Wyrmak
		[14446] = true, -- Fingat
		[14447] = true, -- Gilmorian
		[14448] = true, -- Molt Thorn
		[50738] = true, -- Shimmerscale
		[50790] = true, -- Ionis
		[50797] = true, -- Yukiko
		[50837] = true, -- Kash
		[50882] = true, -- Chupacabros
		[50886] = true, -- Seawing
		[50903] = true, -- Orlix the Swamplord
		[51052] = true, -- Gib the Banana-Hoarder
	},
	-- ----------------------------------------------------------------------------
	-- Westfall
	-- ----------------------------------------------------------------------------
	[39] = {
		[462] = true, -- Vultros
		[506] = true, -- Sergeant Brashclaw
		[519] = true, -- Slark
		[520] = true, -- Brack
		[572] = true, -- Leprithus
		[573] = true, -- Foe Reaper 4000
		[596] = true, -- Brainwashed Noble
		[599] = true, -- Marisa du'Paige
		[1424] = true, -- Master Digger
	},
	-- ----------------------------------------------------------------------------
	-- Wetlands
	-- ----------------------------------------------------------------------------
	[40] = {
		[1112] = true, -- Leech Widow
		[1140] = true, -- Razormaw Matriarch
		[2090] = true, -- Ma'ruk Wyrmscale
		[2108] = true, -- Garneg Charskull
		[14424] = true, -- Mirelow
		[14425] = true, -- Gnawbone
		[14433] = true, -- Sludginn
		[44224] = true, -- Two-Toes
		[44225] = true, -- Rufus Darkshot
		[44226] = true, -- Sarltooth
		[44227] = true, -- Gazz the Loch-Hunter
		[50964] = true, -- Chops
	},
	-- ----------------------------------------------------------------------------
	-- Teldrassil
	-- ----------------------------------------------------------------------------
	[41] = {
		[2162] = true, -- Agal
		[3535] = true, -- Blackmoss the Fetid
		[14428] = true, -- Uruson
		[14429] = true, -- Grimmaw
		[14430] = true, -- Duskstalker
		[14431] = true, -- Fury Shelda
		[14432] = true, -- Threggil
	},
	-- ----------------------------------------------------------------------------
	-- Darkshore
	-- ----------------------------------------------------------------------------
	[42] = {
		[2172] = true, -- Strider Clutchmother
		[2175] = true, -- Shadowclaw
		[2184] = true, -- Lady Moongazer
		[2186] = true, -- Carnivous the Breaker
		[2191] = true, -- Licillin
		[2192] = true, -- Firecaller Radison
		[7015] = true, -- Flagglemurk the Cruel
		[7016] = true, -- Lady Vespira
		[7017] = true, -- Lord Sinslayer
	},
	-- ----------------------------------------------------------------------------
	-- Ashenvale
	-- ----------------------------------------------------------------------------
	[43] = {
		[3735] = true, -- Apothecary Falthis
		[3736] = true, -- Darkslayer Mordenthal
		[3773] = true, -- Akkrilus
		[3792] = true, -- Terrowulf Packlord
		[10559] = true, -- Lady Vespia
		[10639] = true, -- Rorgish Jowl
		[10640] = true, -- Oakpaw
		[10641] = true, -- Branch Snapper
		[10642] = true, -- Eck'alom
		[10644] = true, -- Mist Howler
		[10647] = true, -- Prince Raze
		[12037] = true, -- Ursol'lok
	},
	-- ----------------------------------------------------------------------------
	-- Thousand Needles
	-- ----------------------------------------------------------------------------
	[61] = {
		[4132] = true, -- Krkk'kx
		[5933] = true, -- Achellios the Banished
		[5935] = true, -- Ironeye the Invincible
		[5937] = true, -- Vile Sting
		[14426] = true, -- Harb Foulmountain
		[14427] = true, -- Gibblesnik
		[50329] = true, -- Rrakk
		[50727] = true, -- Strix the Barbed
		[50741] = true, -- Kaxx
		[50748] = true, -- Nyaj
		[50785] = true, -- Skyshadow
		[50892] = true, -- Cyn
		[50952] = true, -- Barnacle Jim
		[51001] = true, -- Venomclaw
		[51008] = true, -- The Barbed Horror
	},
	-- ----------------------------------------------------------------------------
	-- Stonetalon Mountains
	-- ----------------------------------------------------------------------------
	[81] = {
		[4015] = true, -- Pridewing Patriarch
		[4066] = true, -- Nal'taszar
		[5915] = true, -- Brother Ravenoak
		[5928] = true, -- Sorrow Wing
		[5930] = true, -- Sister Riven
		[5932] = true, -- Taskmaster Whipfang
		[50343] = true, -- Quall
		[50759] = true, -- Iriss the Widow
		[50786] = true, -- Sparkwing
		[50812] = true, -- Arae
		[50825] = true, -- Feras
		[50874] = true, -- Tenok
		[50884] = true, -- Dustflight the Cowardly
		[50895] = true, -- Volux
		[50986] = true, -- Goldenback
		[51062] = true, -- Khep-Re
	},
	-- ----------------------------------------------------------------------------
	-- Desolace
	-- ----------------------------------------------------------------------------
	[101] = {
		[11688] = true, -- Cursed Centaur
		[14225] = true, -- Prince Kellen
		[14226] = true, -- Kaskk
		[14227] = true, -- Hissperak
		[14228] = true, -- Giggler
		[14229] = true, -- Accursed Slitherblade
		[18241] = true, -- Crusty
	},
	-- ----------------------------------------------------------------------------
	-- Feralas
	-- ----------------------------------------------------------------------------
	[121] = {
		[5343] = true, -- Lady Szallah
		[5345] = true, -- Diamond Head
		[5346] = true, -- Bloodroar the Stalker
		[5347] = true, -- Antilus the Soarer
		[5349] = true, -- Arash-ethis
		[5350] = true, -- Qirot
		[5352] = true, -- Old Grizzlegut
		[5354] = true, -- Gnarl Leafbrother
		[5356] = true, -- Snarler
		[11447] = true, -- Mushgog
		[11497] = true, -- The Razza
		[11498] = true, -- Skarr the Broken
		[43488] = true, -- Mordei the Earthrender
		[54533] = true, -- Prince Lakma
		[90816] = true, -- Skystormer
	},
	-- ----------------------------------------------------------------------------
	-- Dustwallow Marsh
	-- ----------------------------------------------------------------------------
	[141] = {
		[4339] = true, -- Brimgore
		[4380] = true, -- Darkmist Widow
		[14230] = true, -- Burgle Eye
		[14231] = true, -- Drogoth the Roamer
		[14232] = true, -- Dart
		[14233] = true, -- Ripscale
		[14234] = true, -- Hayoc
		[14235] = true, -- The Rot
		[14236] = true, -- Lord Angler
		[14237] = true, -- Oozeworm
		[50342] = true, -- Heronis
		[50735] = true, -- Blinkeye the Rattler
		[50764] = true, -- Paraliss
		[50784] = true, -- Anith
		[50875] = true, -- Nychus
		[50901] = true, -- Teromak
		[50945] = true, -- Scruff
		[50957] = true, -- Hugeclaw
		[51061] = true, -- Roth-Salam
		[51069] = true, -- Scintillex
	},
	-- ----------------------------------------------------------------------------
	-- Tanaris
	-- ----------------------------------------------------------------------------
	[161] = {
		[8199] = true, -- Warleader Krazzilak
		[8200] = true, -- Jin'Zallah the Sandbringer
		[8201] = true, -- Omgorn the Lost
		[8203] = true, -- Kregg Keelhaul
		[8204] = true, -- Soriid the Devourer
		[8205] = true, -- Haarka the Ravenous
		[8207] = true, -- Emberwing
		[39183] = true, -- Scorpitar
		[39185] = true, -- Slaverjaw
		[39186] = true, -- Hellgazer
		[44714] = true, -- Fronkle the Disturbed
		[44722] = true, -- Twisted Reflection of Narain
		[44750] = true, -- Caliph Scorpidsting
		[44759] = true, -- Andre Firebeard
		[44761] = true, -- Aquementas the Unchained
		[44767] = true, -- Occulus the Corrupted
		[47386] = true, -- Ainamiss the Hive Queen
		[47387] = true, -- Harakiss the Infestor
	},
	-- ----------------------------------------------------------------------------
	-- Azshara
	-- ----------------------------------------------------------------------------
	[181] = {
		[6118] = true, -- Varo'then's Ghost
		[6648] = true, -- Antilos
		[6649] = true, -- Lady Sesspira
		[6650] = true, -- General Fangferror
		[6651] = true, -- Gatekeeper Rageroar
		[8660] = true, -- The Evalcharr
		[13896] = true, -- Scalebeard
		[107477] = true, -- N.U.T.Z.
	},
	-- ----------------------------------------------------------------------------
	-- Felwood
	-- ----------------------------------------------------------------------------
	[182] = {
		[7104] = true, -- Dessecus
		[7137] = true, -- Immolatus
		[14339] = true, -- Death Howl
		[14340] = true, -- Alshirr Banebreath
		[14342] = true, -- Ragepaw
		[14343] = true, -- Olm the Wise
		[14344] = true, -- Mongress
		[14345] = true, -- The Ongar
		[50362] = true, -- Blackbog the Fang
		[50724] = true, -- Spinecrawl
		[50777] = true, -- Needle
		[50833] = true, -- Duskcoat
		[50864] = true, -- Thicket
		[50905] = true, -- Cida
		[50925] = true, -- Grovepaw
		[51017] = true, -- Gezan
		[51025] = true, -- Dilennaa
		[51046] = true, -- Fidonis
		[107595] = true, -- Grimrot
		[107596] = true, -- Grimrot
	},
	-- ----------------------------------------------------------------------------
	-- Un'Goro Crater
	-- ----------------------------------------------------------------------------
	[201] = {
		[6581] = true, -- Ravasaur Matriarch
		[6582] = true, -- Clutchmother Zavas
		[6583] = true, -- Gruff
		[6584] = true, -- King Mosh
		[6585] = true, -- Uhk'loc
	},
	-- ----------------------------------------------------------------------------
	-- Silithus
	-- ----------------------------------------------------------------------------
	[261] = {
		[14471] = true, -- Setis
		[14472] = true, -- Gretheer
		[14473] = true, -- Lapress
		[14474] = true, -- Zora
		[14475] = true, -- Rex Ashil
		[14476] = true, -- Krellack
		[14477] = true, -- Grubthor
		[14478] = true, -- Huricanian
		[14479] = true, -- Twilight Lord Everun
		[50370] = true, -- Karapax
		[50737] = true, -- Acroniss
		[50742] = true, -- Qem
		[50743] = true, -- Manax
		[50744] = true, -- Qu'rik
		[50745] = true, -- Losaj
		[50746] = true, -- Bornix the Burrower
		[50897] = true, -- Ffexk the Dunestalker
		[51004] = true, -- Toxx
		[54533] = true, -- Prince Lakma
		[132591] = true, -- Ogmot the Mad
	},
	-- ----------------------------------------------------------------------------
	-- Winterspring
	-- ----------------------------------------------------------------------------
	[281] = {
		[10196] = true, -- General Colbatann
		[10197] = true, -- Mezzir the Howler
		[10198] = true, -- Kashoch the Reaver
		[10199] = true, -- Grizzle Snowpaw
		[10200] = true, -- Rak'shiri
		[10202] = true, -- Azurous
		[10741] = true, -- Sian-Rotam
		[50346] = true, -- Ronak
		[50348] = true, -- Norissis
		[50353] = true, -- Manas
		[50788] = true, -- Quetzl
		[50819] = true, -- Iceclaw
		[50993] = true, -- Gal'dorak
		[50995] = true, -- Bruiser
		[50997] = true, -- Bornak the Gorer
		[51028] = true, -- The Deep Tunneler
		[51045] = true, -- Arcanus
	},
	-- ----------------------------------------------------------------------------
	-- Stormwind City
	-- ----------------------------------------------------------------------------
	[301] = {
		[3581] = true, -- Sewer Beast
	},
	-- ----------------------------------------------------------------------------
	-- Eversong Woods
	-- ----------------------------------------------------------------------------
	[462] = {
		[16854] = true, -- Eldinarcus
		[16855] = true, -- Tregla
	},
	-- ----------------------------------------------------------------------------
	-- Ghostlands
	-- ----------------------------------------------------------------------------
	[463] = {
		[22062] = true, -- Dr. Whitherlimb
	},
	-- ----------------------------------------------------------------------------
	-- Azuremyst Isle
	-- ----------------------------------------------------------------------------
	[464] = {
		[17591] = true, -- Blood Elf Bandit
	},
	-- ----------------------------------------------------------------------------
	-- Hellfire Peninsula
	-- ----------------------------------------------------------------------------
	[465] = {
		[18677] = true, -- Mekthorg the Wild
		[18678] = true, -- Fulgorge
		[18679] = true, -- Vorakem Doomspeaker
	},
	-- ----------------------------------------------------------------------------
	-- Zangarmarsh
	-- ----------------------------------------------------------------------------
	[467] = {
		[18680] = true, -- Marticar
		[18681] = true, -- Coilfang Emissary
		[18682] = true, -- Bog Lurker
	},
	-- ----------------------------------------------------------------------------
	-- Shadowmoon Valley (Outland)
	-- ----------------------------------------------------------------------------
	[473] = {
		[18694] = true, -- Collidus the Warp-Watcher
		[18695] = true, -- Ambassador Jerrikar
		[18696] = true, -- Kraator
	},
	-- ----------------------------------------------------------------------------
	-- Blade's Edge Mountains
	-- ----------------------------------------------------------------------------
	[475] = {
		[18690] = true, -- Morcrush
		[18692] = true, -- Hemathion
		[18693] = true, -- Speaker Mar'grom
	},
	-- ----------------------------------------------------------------------------
	-- Bloodmyst Isle
	-- ----------------------------------------------------------------------------
	[476] = {
		[22060] = true, -- Fenissa the Assassin
	},
	-- ----------------------------------------------------------------------------
	-- Nagrand (Outland)
	-- ----------------------------------------------------------------------------
	[477] = {
		[17144] = true, -- Goretooth
		[18683] = true, -- Voidhunter Yar
		[18684] = true, -- Bro'Gaz the Clanless
	},
	-- ----------------------------------------------------------------------------
	-- Terokkar Forest
	-- ----------------------------------------------------------------------------
	[478] = {
		[18685] = true, -- Okrek
		[18686] = true, -- Doomsayer Jurim
		[18689] = true, -- Crippler
		[21724] = true, -- Hawkbane
	},
	-- ----------------------------------------------------------------------------
	-- Netherstorm
	-- ----------------------------------------------------------------------------
	[479] = {
		[18697] = true, -- Chief Engineer Lorthander
		[18698] = true, -- Ever-Core the Punisher
		[20932] = true, -- Nuramoc
	},
	-- ----------------------------------------------------------------------------
	-- Borean Tundra
	-- ----------------------------------------------------------------------------
	[486] = {
		[32357] = true, -- Old Crystalbark
		[32358] = true, -- Fumblub Gearwind
		[32361] = true, -- Icehorn
	},
	-- ----------------------------------------------------------------------------
	-- Dragonblight
	-- ----------------------------------------------------------------------------
	[488] = {
		[32400] = true, -- Tukemuth
		[32409] = true, -- Crazed Indu'le Survivor
		[32417] = true, -- Scarlet Highlord Daion
	},
	-- ----------------------------------------------------------------------------
	-- Grizzly Hills
	-- ----------------------------------------------------------------------------
	[490] = {
		[32422] = true, -- Grocklar
		[32429] = true, -- Seething Hate
		[32438] = true, -- Syreian the Bonecarver
		[38453] = true, -- Arcturis
	},
	-- ----------------------------------------------------------------------------
	-- Howling Fjord
	-- ----------------------------------------------------------------------------
	[491] = {
		[32377] = true, -- Perobas the Bloodthirster
		[32386] = true, -- Vigdis the War Maiden
		[32398] = true, -- King Ping
	},
	-- ----------------------------------------------------------------------------
	-- Icecrown
	-- ----------------------------------------------------------------------------
	[492] = {
		[32487] = true, -- Putridus the Ancient
		[32495] = true, -- Hildana Deathstealer
		[32501] = true, -- High Thane Jorfus
	},
	-- ----------------------------------------------------------------------------
	-- Sholazar Basin
	-- ----------------------------------------------------------------------------
	[493] = {
		[32481] = true, -- Aotona
		[32485] = true, -- King Krush
		[32517] = true, -- Loque'nahak
	},
	-- ----------------------------------------------------------------------------
	-- The Storm Peaks
	-- ----------------------------------------------------------------------------
	[495] = {
		[32491] = true, -- Time-Lost Proto-Drake
		[32500] = true, -- Dirkee
		[32630] = true, -- Vyragosa
		[35189] = true, -- Skoll
	},
	-- ----------------------------------------------------------------------------
	-- Zul'Drak
	-- ----------------------------------------------------------------------------
	[496] = {
		[32447] = true, -- Zul'drak Sentinel
		[32471] = true, -- Griegen
		[32475] = true, -- Terror Spinner
		[33776] = true, -- Gondria
	},
	-- ----------------------------------------------------------------------------
	-- Mount Hyjal
	-- ----------------------------------------------------------------------------
	[606] = {
		[50053] = true, -- Thartuk the Exile
		[50056] = true, -- Garr
		[50057] = true, -- Blazewing
		[50058] = true, -- Terrorpene
		[54318] = true, -- Ankha
		[54319] = true, -- Magria
		[54320] = true, -- Ban'thalos
	},
	-- ----------------------------------------------------------------------------
	-- Southern Barrens
	-- ----------------------------------------------------------------------------
	[607] = {
		[3253] = true, -- Silithid Harvester
		[5829] = true, -- Snort the Heckler
		[5832] = true, -- Thunderstomp
		[5834] = true, -- Azzere the Skyblade
		[5837] = true, -- Stonearm
		[5847] = true, -- Heggin Stonewhisker
		[5848] = true, -- Malgin Barleybrew
		[5849] = true, -- Digger Flameforge
		[5851] = true, -- Captain Gerogg Hammertoe
		[5859] = true, -- Hagg Taurenbane
		[5863] = true, -- Geopriest Gukk'rok
		[5864] = true, -- Swinegart Spearhide
	},
	-- ----------------------------------------------------------------------------
	-- Kelp'thar Forest
	-- ----------------------------------------------------------------------------
	[610] = {
		[49913] = true, -- Lady La-La
	},
	-- ----------------------------------------------------------------------------
	-- Vashj'ir
	-- ----------------------------------------------------------------------------
	[613] = {
		[51079] = true, -- Captain Foulwind
	},
	-- ----------------------------------------------------------------------------
	-- Abyssal Depths
	-- ----------------------------------------------------------------------------
	[614] = {
		[50005] = true, -- Poseidus
		[50009] = true, -- Mobus
		[50050] = true, -- Shok'sharak
		[50051] = true, -- Ghostcrawler
	},
	-- ----------------------------------------------------------------------------
	-- Shimmering Expanse
	-- ----------------------------------------------------------------------------
	[615] = {
		[50005] = true, -- Poseidus
		[50052] = true, -- Burgy Blackheart
		[51071] = true, -- Captain Florence
	},
	-- ----------------------------------------------------------------------------
	-- Deepholm
	-- ----------------------------------------------------------------------------
	[640] = {
		[3868] = true, -- Blood Seeker
		[49822] = true, -- Jadefang
		[50059] = true, -- Golgarok
		[50060] = true, -- Terborus
		[50062] = true, -- Aeonaxx
		[50061] = true, -- Xariona
	},
	-- ----------------------------------------------------------------------------
	-- The Cape of Stranglethorn
	-- ----------------------------------------------------------------------------
	[673] = {
		[1552] = true, -- Scale Belly
		[2541] = true, -- Lord Sakrasis
		[14490] = true, -- Rippa
		[14491] = true, -- Kurmokk
		[14492] = true, -- Verifonix
		[108715] = true, -- Ol' Eary
	},
	-- ----------------------------------------------------------------------------
	-- Zul'Farrak
	-- ----------------------------------------------------------------------------
	[686] = {
		[10080] = true, -- Sandarr Dunereaver
		[10081] = true, -- Dustwraith
		[10082] = true, -- Zerillis
	},
	-- ----------------------------------------------------------------------------
	-- The Temple of Atal'Hakkar
	-- ----------------------------------------------------------------------------
	[687] = {
		[14445] = true, -- Captain Wyrmak
	},
	-- ----------------------------------------------------------------------------
	-- Blackfathom Deeps
	-- ----------------------------------------------------------------------------
	[688] = {
		[12902] = true, -- Lorgus Jett
	},
	-- ----------------------------------------------------------------------------
	-- Gnomeregan
	-- ----------------------------------------------------------------------------
	[691] = {
		[6228] = true, -- Dark Iron Ambassador
	},
	-- ----------------------------------------------------------------------------
	-- Dire Maul
	-- ----------------------------------------------------------------------------
	[699] = {
		[11467] = true, -- Tsu'zee
		[14506] = true, -- Lord Hel'nurath
	},
	-- ----------------------------------------------------------------------------
	-- Twilight Highlands
	-- ----------------------------------------------------------------------------
	[700] = {
		[50085] = true, -- Overlord Sunderfury
		[50086] = true, -- Tarvus the Vile
		[50089] = true, -- Julak-Doom
		[50138] = true, -- Karoma
		[50159] = true, -- Sambas
	},
	-- ----------------------------------------------------------------------------
	-- Blackrock Depths
	-- ----------------------------------------------------------------------------
	[704] = {
		[8923] = true, -- Panzor the Invincible
	},
	-- ----------------------------------------------------------------------------
	-- Uldum
	-- ----------------------------------------------------------------------------
	[720] = {
		[50063] = true, -- Akma'hat
		[50064] = true, -- Cyrus the Black
		[50065] = true, -- Armagedillo
		[50154] = true, -- Madexx - Brown
		[51401] = true, -- Madexx - Red
		[51402] = true, -- Madexx - Green
		[51403] = true, -- Madexx - Black
		[51404] = true, -- Madexx - Blue
	},
	-- ----------------------------------------------------------------------------
	-- Blackrock Spire
	-- ----------------------------------------------------------------------------
	[721] = {
		[9217] = true, -- Spirestone Lord Magus
		[9218] = true, -- Spirestone Battle Lord
		[9219] = true, -- Spirestone Butcher
		[9596] = true, -- Bannok Grimaxe
		[9718] = true, -- Ghok Bashguud
		[9736] = true, -- Quartermaster Zigris
		[10263] = true, -- Burning Felguard
		[10376] = true, -- Crystal Fang
		[10509] = true, -- Jed Runewatcher
	},
	-- ----------------------------------------------------------------------------
	-- Old Hillsbrad Foothills
	-- ----------------------------------------------------------------------------
	[734] = {
		[56081] = true, -- Optimistic Benj
	},
	-- ----------------------------------------------------------------------------
	-- Wailing Caverns
	-- ----------------------------------------------------------------------------
	[749] = {
		[5912] = true, -- Deviate Faerie Dragon
	},
	-- ----------------------------------------------------------------------------
	-- Maraudon
	-- ----------------------------------------------------------------------------
	[750] = {
		[12237] = true, -- Meshlok the Harvester
	},
	-- ----------------------------------------------------------------------------
	-- The Deadmines
	-- ----------------------------------------------------------------------------
	[756] = {
		[596] = true, -- Brainwashed Noble
		[599] = true, -- Marisa du'Paige
	},
	-- ----------------------------------------------------------------------------
	-- Razorfen Kraul
	-- ----------------------------------------------------------------------------
	[761] = {
		[4425] = true, -- Blind Hunter
		[4842] = true, -- Earthcaller Halmgar
		[75590] = true, -- Enormous Bullfrog
	},
	-- ----------------------------------------------------------------------------
	-- Shadowfang Keep
	-- ----------------------------------------------------------------------------
	[764] = {
		[3872] = true, -- Deathsworn Captain
	},
	-- ----------------------------------------------------------------------------
	-- Stratholme
	-- ----------------------------------------------------------------------------
	[765] = {
		[10393] = true, -- Skul
		[10558] = true, -- Hearthsinger Forresten
		[10809] = true, -- Stonespine
		[10820] = true, -- Duke Ragereaver
	},
	-- ----------------------------------------------------------------------------
	-- Ahn'Qiraj: The Fallen Kingdom
	-- ----------------------------------------------------------------------------
	[772] = {
		[50747] = true, -- Tix
	},
	-- ----------------------------------------------------------------------------
	-- Molten Front
	-- ----------------------------------------------------------------------------
	[795] = {
		[50815] = true, -- Skarr
		[50959] = true, -- Karkin
		[54321] = true, -- Solix
		[54322] = true, -- Deth'tilac
		[54323] = true, -- Kirix
		[54324] = true, -- Skitterflame
		[54338] = true, -- Anthriss
	},
	-- ----------------------------------------------------------------------------
	-- Karazhan
	-- ----------------------------------------------------------------------------
	[799] = {
		[16179] = true, -- Hyakiss the Lurker
		[16180] = true, -- Shadikith the Glider
		[16181] = true, -- Rokad the Ravager
	},
	-- ----------------------------------------------------------------------------
	-- The Jade Forest
	-- ----------------------------------------------------------------------------
	[806] = {
		[50338] = true, -- Kor'nas Nightsavage
		[50350] = true, -- Morgrinn Crackfang
		[50363] = true, -- Krax'ik
		[50750] = true, -- Aethis
		[50782] = true, -- Sarnak
		[50808] = true, -- Urobi the Walker
		[50823] = true, -- Mister Ferocious
		[51078] = true, -- Ferdinand
		[69768] = true, -- Zandalari Warscout
		[69769] = true, -- Zandalari Warbringer
		[69841] = true, -- Zandalari Warbringer
		[69842] = true, -- Zandalari Warbringer
		[70323] = true, -- Krakkanon
	},
	-- ----------------------------------------------------------------------------
	-- Valley of the Four Winds
	-- ----------------------------------------------------------------------------
	[807] = {
		[50339] = true, -- Sulik'shor
		[50351] = true, -- Jonn-Dar
		[50364] = true, -- Nal'lak the Ripper
		[50766] = true, -- Sele'na
		[50783] = true, -- Salyin Warscout
		[50811] = true, -- Nasra Spothide
		[50828] = true, -- Bonobos
		[51059] = true, -- Blackhoof
	},
	-- ----------------------------------------------------------------------------
	-- Kun-Lai Summit
	-- ----------------------------------------------------------------------------
	[809] = {
		[50332] = true, -- Korda Torros
		[50341] = true, -- Borginn Darkfist
		[50354] = true, -- Havak
		[50733] = true, -- Ski'thik
		[50769] = true, -- Zai the Outcast
		[50789] = true, -- Nessos the Oracle
		[50817] = true, -- Ahone the Wanderer
		[50831] = true, -- Scritch
		[69768] = true, -- Zandalari Warscout
		[69769] = true, -- Zandalari Warbringer
		[69841] = true, -- Zandalari Warbringer
		[69842] = true, -- Zandalari Warbringer
		[70323] = true, -- Krakkanon
	},
	-- ----------------------------------------------------------------------------
	-- Townlong Steppes
	-- ----------------------------------------------------------------------------
	[810] = {
		[50333] = true, -- Lon the Bull
		[50344] = true, -- Norlaxx
		[50355] = true, -- Kah'tir
		[50734] = true, -- Lith'ik the Stalker
		[50772] = true, -- Eshelon
		[50791] = true, -- Siltriss the Sharpener
		[50820] = true, -- Yul Wildpaw
		[50832] = true, -- The Yowler
		[69768] = true, -- Zandalari Warscout
		[69769] = true, -- Zandalari Warbringer
		[69841] = true, -- Zandalari Warbringer
		[69842] = true, -- Zandalari Warbringer
		[70323] = true, -- Krakkanon
	},
	-- ----------------------------------------------------------------------------
	-- Vale of Eternal Blossoms
	-- ----------------------------------------------------------------------------
	[811] = {
		[50336] = true, -- Yorik Sharpeye
		[50349] = true, -- Kang the Soul Thief
		[50359] = true, -- Urgolax
		[50749] = true, -- Kal'tik the Blight
		[50780] = true, -- Sahn Tidehunter
		[50806] = true, -- Moldo One-Eye
		[50822] = true, -- Ai-Ran the Shifting Cloud
		[50840] = true, -- Major Nanners
		[50843] = true, -- Portent
		[58474] = true, -- Bloodtip
		[58768] = true, -- Cracklefang
		[58769] = true, -- Vicejaw
		[58771] = true, -- Quid
		[58778] = true, -- Aetha
		[58817] = true, -- Spirit of Lao-Fe
		[58949] = true, -- Bai'Jin the Butcher
		[62880] = true, -- Gochao the Ironfist
		[62881] = true, -- Gaohun the Soul-Severer
		[63101] = true, -- General Temuja
		[63240] = true, -- Shadowmaster Sydow
		[63509] = true, -- Wulon
		[63510] = true, -- Wulon
		[63691] = true, -- Huo-Shuang
		[63695] = true, -- Baolai the Immolator
		[63977] = true, -- Vyraxxis
		[63978] = true, -- Kri'chon
	},
	-- ----------------------------------------------------------------------------
	-- Darkmon Island
	-- ----------------------------------------------------------------------------
	[823] = {
		[122899] = true, -- Death Metal Knight
	},
	-- ----------------------------------------------------------------------------
	-- Krasarang Wilds
	-- ----------------------------------------------------------------------------
	[857] = {
		[50331] = true, -- Go-Kan
		[50340] = true, -- Gaarn the Toxic
		[50352] = true, -- Qu'nas
		[50388] = true, -- Torik-Ethis
		[50768] = true, -- Cournith Waterstrider
		[50787] = true, -- Arness the Scale
		[50816] = true, -- Ruun Ghostpaw
		[50830] = true, -- Spriggin
		[68317] = true, -- Mavis Harms
		[68318] = true, -- Dalan Nightbreaker
		[68319] = true, -- Disha Fearwarden
		[68320] = true, -- Ubunti the Shade
		[68321] = true, -- Kar Warmaker
		[68322] = true, -- Muerta
		[69768] = true, -- Zandalari Warscout
		[69769] = true, -- Zandalari Warbringer
		[70323] = true, -- Krakkanon
	},
	-- ----------------------------------------------------------------------------
	-- Dread Wastes
	-- ----------------------------------------------------------------------------
	[858] = {
		[50334] = true, -- Dak the Breaker
		[50347] = true, -- Karr the Darkener
		[50356] = true, -- Krol the Blade
		[50739] = true, -- Gar'lok
		[50776] = true, -- Nalash Verdantis
		[50805] = true, -- Omnis Grinlok
		[50821] = true, -- Ai-Li Skymirror
		[50836] = true, -- Ik-Ik the Nimble
		[69768] = true, -- Zandalari Warscout
		[69769] = true, -- Zandalari Warbringer
		[69841] = true, -- Zandalari Warbringer
		[69842] = true, -- Zandalari Warbringer
	},
	-- ----------------------------------------------------------------------------
	-- Northshire
	-- ----------------------------------------------------------------------------
	[864] = {
		[62] = true, -- Gug Fatcandle
	},
	-- ----------------------------------------------------------------------------
	-- The Veiled Stair
	-- ----------------------------------------------------------------------------
	[873] = {
		[70126] = true, -- Willy Wilder
	},
	-- ----------------------------------------------------------------------------
	-- Camp Narache
	-- ----------------------------------------------------------------------------
	[890] = {
		[43720] = true, -- "Pokey" Thornmantle
	},
	-- ----------------------------------------------------------------------------
	-- Deathknell
	-- ----------------------------------------------------------------------------
	[892] = {
		[50328] = true, -- Fangor
	},
	-- ----------------------------------------------------------------------------
	-- New Tinkertown
	-- ----------------------------------------------------------------------------
	[895] = {
		[1132] = true, -- Timber
		[1260] = true, -- Great Father Arctikus
		[8503] = true, -- Gibblewilt
		[107431] = true, -- Weaponized Rabbot
	},
	-- ----------------------------------------------------------------------------
	-- Scholomance
	-- ----------------------------------------------------------------------------
	[898] = {
		[1850] = true, -- Putridius
		[59369] = true, -- Doctor Theolen Krastinov
	},
	-- ----------------------------------------------------------------------------
	-- Isle of Thunder
	-- ----------------------------------------------------------------------------
	[928] = {
		[50358] = true, -- Haywire Sunreaver Construct
		[69099] = true, -- Nalak
		[69664] = true, -- Mumta
		[69996] = true, -- Ku'lai the Skyclaw
		[69997] = true, -- Progenitus
		[69998] = true, -- Goda
		[69999] = true, -- God-Hulk Ramuk
		[70000] = true, -- Al'tabim the All-Seeing
		[70001] = true, -- Backbreaker Uru
		[70002] = true, -- Lu-Ban
		[70003] = true, -- Molthor
		[70530] = true, -- Ra'sha
	},
	-- ----------------------------------------------------------------------------
	-- Isle of Giants
	-- ----------------------------------------------------------------------------
	[929] = {
		[69161] = true, -- Oondasta
		[70096] = true, -- War-God Dokah
	},
	-- ----------------------------------------------------------------------------
	-- Throne of Thunder
	-- ----------------------------------------------------------------------------
	[930] = {
		[69843] = true, -- Zao'cho
		[70238] = true, -- Unblinking Eye
		[70243] = true, -- Archritualist Kelada
		[70249] = true, -- Focused Eye
		[70276] = true, -- No'ku Stormsayer
		[70429] = true, -- Flesh'rok the Diseased
		[70430] = true, -- Rocky Horror
		[70440] = true, -- Monara
	},
	-- ----------------------------------------------------------------------------
	-- Frostfire Ridge
	-- ----------------------------------------------------------------------------
	[941] = {
		[50992] = true, -- Gorok
		[71665] = true, -- Giant-Slayer Kul
		[71721] = true, -- Canyon Icemother
		[72156] = true, -- Borrok the Devourer
		[72294] = true, -- Cindermaw
		[72364] = true, -- Gorg'ak the Lava Guzzler
		[74613] = true, -- Broodmother Reeg'ak
		[74971] = true, -- Firefury Giant
		[76914] = true, -- Coldtusk
		[76918] = true, -- Primalist Mur'og
		[77513] = true, -- Coldstomp the Griever
		[77519] = true, -- Giantbane
		[77526] = true, -- Scout Goreseeker
		[77527] = true, -- The Beater
		[78128] = true, -- Gronnstalker Dawarn
		[78134] = true, -- Pathfinder Jalog
		[78144] = true, -- Giantslayer Kimla
		[78150] = true, -- Beastcarver Saramor
		[78151] = true, -- Huntmaster Kuang
		[78169] = true, -- Cloudspeaker Daber
		[78265] = true, -- The Bone Crawler
		[78606] = true, -- Pale Fishmonger
		[78621] = true, -- Cyclonic Fury
		[78867] = true, -- Breathless
		[79104] = true, -- Ug'lok the Frozen
		[79145] = true, -- Yaga the Scarred
		[80190] = true, -- Gruuk
		[80235] = true, -- Gurun
		[80242] = true, -- Chillfang
		[80312] = true, -- Grutush the Pillager
		[81001] = true, -- Nok-Karosh
		[82536] = true, -- Gorivax
		[82614] = true, -- Moltnoma
		[82616] = true, -- Jabberjaw
		[82617] = true, -- Slogtusk the Corpse-Eater
		[82618] = true, -- Tor'goroth
		[82620] = true, -- Son of Goramal
		[84374] = true, -- Kaga the Ironbender
		[84376] = true, -- Earthshaker Holar
		[84378] = true, -- Ak'ox the Slaughterer
		[84392] = true, -- Ragore Driftstalker
		[87348] = true, -- Hoarfrost
		[87351] = true, -- Mother of Goren
		[87352] = true, -- Gibblette the Cowardly
		[87356] = true, -- Vrok the Ancient
		[87357] = true, -- Valkor
		[87600] = true, -- Jaluk the Pacifist
		[87622] = true, -- Ogom the Mangler
	},
	-- ----------------------------------------------------------------------------
	-- Tanaan Jungle
	-- ----------------------------------------------------------------------------
	[945] = {
		[80398] = true, -- Keravnos
		[89675] = true, -- Commander Org'mok
		[90024] = true, -- Sergeant Mor'grak
		[90094] = true, -- Harbormaster Korak
		[90122] = true, -- Zoug the Heavy
		[90429] = true, -- Imp-Master Valessa
		[90434] = true, -- Ceraxas
		[90437] = true, -- Jax'zor
		[90438] = true, -- Lady Oran
		[90442] = true, -- Mistress Thavra
		[90519] = true, -- Cindral the Wildfire
		[90777] = true, -- High Priest Ikzan
		[90782] = true, -- Rasthe
		[90884] = true, -- Bilkor the Thrower
		[90885] = true, -- Rogond the Tracker
		[90887] = true, -- Dorg the Bloody
		[90888] = true, -- Drivnul
		[90936] = true, -- Bloodhunter Zulk
		[91009] = true, -- Putre'thar
		[91087] = true, -- Zeter'el
		[91093] = true, -- Bramblefell
		[91098] = true, -- Felspark
		[91227] = true, -- Remnant of the Blood Moon
		[91232] = true, -- Commander Krag'goth
		[91243] = true, -- Tho'gar Gorefist
		[91374] = true, -- Podlord Wakkawam
		[91695] = true, -- Grand Warlock Nethekurse
		[91727] = true, -- Executor Riloth
		[91871] = true, -- Argosh the Destroyer
		[92197] = true, -- Relgor
		[92274] = true, -- Painmistress Selora
		[92408] = true, -- Xanzith the Everlasting
		[92411] = true, -- Overlord Ma'gruth
		[92429] = true, -- Broodlord Ixkor
		[92451] = true, -- Varyx the Damned
		[92465] = true, -- The Blackfang
		[92495] = true, -- Soulslicer
		[92508] = true, -- Gloomtalon
		[92517] = true, -- Krell the Serene
		[92552] = true, -- Belgork
		[92574] = true, -- Thromma the Gutslicer
		[92606] = true, -- Sylissa
		[92627] = true, -- Rendrak
		[92636] = true, -- The Night Haunter
		[92645] = true, -- The Night Haunter
		[92647] = true, -- Felsmith Damorka
		[92657] = true, -- Bleeding Hollow Horror
		[92694] = true, -- The Goreclaw
		[92766] = true, -- Akrrilo
		[92817] = true, -- Rendarr
		[92819] = true, -- Eyepiercer
		[92887] = true, -- Steelsnout
		[92941] = true, -- Gorabosh
		[92977] = true, -- The Iron Houndmaster
		[93001] = true, -- Szirek the Twisted
		[93002] = true, -- Magwia
		[93028] = true, -- Driss Vile
		[93057] = true, -- Grannok
		[93076] = true, -- Captain Ironbeard
		[93125] = true, -- Glub'glok
		[93168] = true, -- Felbore
		[93236] = true, -- Shadowthrash
		[93264] = true, -- Captain Grok'mar
		[93279] = true, -- Kris'kar the Unredeemed
		[95044] = true, -- Terrorfist
		[95053] = true, -- Deathtalon
		[95054] = true, -- Vengeance
		[95056] = true, -- Doomroller
		[96235] = true, -- Xemirkol
		[98283] = true, -- Drakum
		[98284] = true, -- Gondar
		[98285] = true, -- Smashum Grabb
		[98408] = true, -- Fel Overseer Mudlump
	},
	-- ----------------------------------------------------------------------------
	-- Talador
	-- ----------------------------------------------------------------------------
	[946] = {
		[51015] = true, -- Silthide
		[77529] = true, -- Yazheera the Incinerator
		[77561] = true, -- Dr. Gloom
		[77614] = true, -- Frenzied Golem
		[77620] = true, -- Cro Fleshrender
		[77626] = true, -- Hen-Mother Hami
		[77634] = true, -- Taladorantula
		[77664] = true, -- Aarko
		[77715] = true, -- Hammertooth
		[77719] = true, -- Glimmerwing
		[77741] = true, -- Ra'kahn
		[77750] = true, -- Kaavu the Crimson Claw
		[77776] = true, -- Wandering Vindicator
		[77784] = true, -- Lo'marg Jawcrusher
		[77795] = true, -- Echo of Murmur
		[77828] = true, -- Echo of Murmur
		[78710] = true, -- Kharazos the Triumphant
		[78713] = true, -- Galzomar
		[78715] = true, -- Sikthiss, Maiden of Slaughter
		[78872] = true, -- Klikixx
		[79334] = true, -- No'losh
		[79485] = true, -- Talonpriest Zorkra
		[79543] = true, -- Shirzir
		[80204] = true, -- Felbark
		[80471] = true, -- Gennadian
		[80524] = true, -- Underseer Bloodmane
		[82920] = true, -- Lord Korinak
		[82922] = true, -- Xothear, the Destroyer
		[82930] = true, -- Shadowflame Terrorwalker
		[82942] = true, -- Lady Demlash
		[82988] = true, -- Kurlosh Doomfang
		[82992] = true, -- Felfire Consort
		[82998] = true, -- Matron of Sin
		[83008] = true, -- Haakun the All-Consuming
		[83019] = true, -- Gug'tol
		[85572] = true, -- Grrbrrgle
		[86549] = true, -- Steeltusk
		[87597] = true, -- Bombardier Gu'gok
		[87668] = true, -- Orumo the Observer
		[88043] = true, -- Avatar of Socrethar
		[88071] = true, -- Strategist Ankor
		[88072] = true, -- Archmagus Tekar
		[88083] = true, -- Soulbinder Naylana
		[88436] = true, -- Vigilant Paarthos
		[88494] = true, -- Legion Vanguard
	},
	-- ----------------------------------------------------------------------------
	-- Shadowmoon Valley (Draenor)
	-- ----------------------------------------------------------------------------
	[947] = {
		[50883] = true, -- Pathrunner
		[72362] = true, -- Ku'targ the Voidseer
		[72537] = true, -- Leaf-Reader Kurri
		[72606] = true, -- Rockhoof
		[74206] = true, -- Killmaw
		[75071] = true, -- Mother Om'ra
		[75434] = true, -- Windfang Matriarch
		[75435] = true, -- Yggdrel
		[75482] = true, -- Veloss
		[75492] = true, -- Venomshade
		[76380] = true, -- Gorum
		[77085] = true, -- Dark Emanation
		[77140] = true, -- Amaukwa
		[77310] = true, -- Mad "King" Sporeon
		[79524] = true, -- Hypnocroak
		[79686] = true, -- Silverleaf Ancient
		[79692] = true, -- Silverleaf Ancient
		[79693] = true, -- Silverleaf Ancient
		[81406] = true, -- Bahameye
		[81639] = true, -- Brambleking Fili
		[82207] = true, -- Faebright
		[82268] = true, -- Darkmaster Go'vid
		[82326] = true, -- Ba'ruun
		[82362] = true, -- Morva Soultwister
		[82374] = true, -- Rai'vosh
		[82411] = true, -- Darktalon
		[82415] = true, -- Shinri
		[82676] = true, -- Enavra
		[82742] = true, -- Enavra
		[83385] = true, -- Voidseer Kalurg
		[83553] = true, -- Insha'tar
		[84911] = true, -- Demidos
		[84925] = true, -- Quartermaster Hershak
		[85001] = true, -- Master Sergeant Milgra
		[85029] = true, -- Shadowspeaker Niir
		[85121] = true, -- Lady Temptessa
		[85451] = true, -- Malgosh Shadowkeeper
		[85555] = true, -- Nagidna
		[85568] = true, -- Avalanche
		[85837] = true, -- Slivermaw
		[86213] = true, -- Aqualir
		[86689] = true, -- Sneevel
	},
	-- ----------------------------------------------------------------------------
	-- Spires of Arak
	-- ----------------------------------------------------------------------------
	[948] = {
		[79938] = true, -- Shadowbark
		[80372] = true, -- Echidna
		[80614] = true, -- Blade-Dancer Aeryx
		[82050] = true, -- Varasha
		[82247] = true, -- Nas Dunberlin
		[83990] = true, -- Solar Magnifier
		[84417] = true, -- Mutafen
		[84775] = true, -- Tesska the Broken
		[84805] = true, -- Stonespite
		[84807] = true, -- Durkath Steelmaw
		[84810] = true, -- Kalos the Bloodbathed
		[84833] = true, -- Sangrikass
		[84836] = true, -- Talonbreaker
		[84838] = true, -- Poisonmaster Bortusk
		[84856] = true, -- Blightglow
		[84872] = true, -- Oskiira the Vengeful
		[84887] = true, -- Betsi Boombasket
		[84890] = true, -- Festerbloom
		[84912] = true, -- Sunderthorn
		[84951] = true, -- Gobblefin
		[84955] = true, -- Jiasska the Sporegorger
		[85026] = true, -- Soul-Twister Torek
		[85036] = true, -- Formless Nightmare
		[85037] = true, -- Kenos the Unraveler
		[85078] = true, -- Voidreaver Urnae
		[85504] = true, -- Rotcap
		[85520] = true, -- Swarmleaf
		[86621] = true, -- Morphed Sentient
		[86724] = true, -- Hermit Palefur
		[86978] = true, -- Gaze
		[87019] = true, -- Gluttonous Giant
		[87026] = true, -- Mecha Plunderer
		[87027] = true, -- Shadow Hulk
		[87029] = true, -- Giga Sentinel
	},
	-- ----------------------------------------------------------------------------
	-- Gorgrond
	-- ----------------------------------------------------------------------------
	[949] = {
		[50985] = true, -- Poundfist
		[75207] = true, -- Biolante
		[76473] = true, -- Mother Araneae
		[77093] = true, -- Roardan the Sky Terror
		[78260] = true, -- King Slime
		[78269] = true, -- Gnarljaw
		[79629] = true, -- Stomper Kreego
		[80371] = true, -- Typhon
		[80725] = true, -- Sulfurious
		[80785] = true, -- Fungal Praetorian
		[80868] = true, -- Glut
		[81038] = true, -- Gelgor of the Blue Flame
		[81528] = true, -- Crater Lord Igneous
		[81529] = true, -- Dessicus of the Dead Pools
		[81537] = true, -- Khargax the Devourer
		[81540] = true, -- Erosian the Violent
		[81548] = true, -- Charl Doomwing
		[82058] = true, -- Depthroot
		[82085] = true, -- Bashiok
		[82311] = true, -- Char the Burning
		[83522] = true, -- Hive Queen Skrikka
		[84406] = true, -- Mandrakor
		[84431] = true, -- Greldrok the Cunning
		[85250] = true, -- Fossilwood the Petrified
		[85264] = true, -- Rolkor
		[85907] = true, -- Berthora
		[85970] = true, -- Riptar
		[86137] = true, -- Sunclaw
		[86257] = true, -- Basten
		[86258] = true, -- Nultra
		[86259] = true, -- Valstil
		[86266] = true, -- Venolasix
		[86268] = true, -- Alkali
		[86410] = true, -- Sylldross
		[86520] = true, -- Stompalupagus
		[86562] = true, -- Maniacal Madgard
		[86566] = true, -- Defector Dazgo
		[86571] = true, -- Durp the Hated
		[86574] = true, -- Inventor Blammo
		[86577] = true, -- Horgg
		[86579] = true, -- Blademaster Ro'gor
		[86582] = true, -- Morgo Kain
		[88580] = true, -- Firestarter Grash
		[88582] = true, -- Swift Onyx Flayer
		[88583] = true, -- Grove Warden Yal
		[88586] = true, -- Mogamago
		[88672] = true, -- Hunter Bal'ra
	},
	-- ----------------------------------------------------------------------------
	-- Nagrand (Draenor)
	-- ----------------------------------------------------------------------------
	[950] = {
		[50981] = true, -- Luk'hok
		[50990] = true, -- Nakk the Thunderer
		[78161] = true, -- Hyperious
		[79024] = true, -- Warmaster Blugthol
		[79725] = true, -- Captain Ironbeard
		[80057] = true, -- Soulfang
		[80122] = true, -- Gaz'orda
		[80370] = true, -- Lernaea
		[82486] = true, -- Explorer Nozzand
		[82755] = true, -- Redclaw the Feral
		[82758] = true, -- Greatfeather
		[82764] = true, -- Gar'lua
		[82778] = true, -- Gnarlhoof the Rabid
		[82826] = true, -- Berserk T-300 Series Mark II
		[82899] = true, -- Ancient Blademaster
		[82912] = true, -- Grizzlemaw
		[82975] = true, -- Fangler
		[83401] = true, -- Netherspawn
		[83409] = true, -- Ophiis
		[83428] = true, -- Windcaller Korast
		[83483] = true, -- Flinthide
		[83509] = true, -- Gorepetal
		[83526] = true, -- Ru'klaa
		[83542] = true, -- Sean Whitesea
		[83591] = true, -- Tura'aka
		[83603] = true, -- Hunter Blacktooth
		[83634] = true, -- Scout Pokhar
		[83643] = true, -- Malroc Stonesunder
		[83680] = true, -- Outrider Duretha
		[84263] = true, -- Graveltooth
		[84435] = true, -- Mr. Pinchy Sr.
		[86729] = true, -- Direhoof
		[86732] = true, -- Bergruu
		[86743] = true, -- Dekorhan
		[86750] = true, -- Thek'talon
		[86771] = true, -- Gagrog the Brutal
		[86774] = true, -- Aogexon
		[86835] = true, -- Xelganak
		[86959] = true, -- Karosh Blackwind
		[87234] = true, -- Brutag Grimblade
		[87239] = true, -- Krahl Deadeye
		[87344] = true, -- Gortag Steelgrip
		[87647] = true, -- Aogexon
		[87660] = true, -- Dekorhan
		[87661] = true, -- Bergruu
		[87666] = true, -- Mu'gra
		[87788] = true, -- Durg Spinecrusher
		[87837] = true, -- Bonebreaker
		[87846] = true, -- Pit Slayer
		[88208] = true, -- Pit Beast
		[88210] = true, -- Krud the Eviscerator
		[88951] = true, -- Vileclaw
		[98198] = true, -- Rukdug
		[98199] = true, -- Pugg
		[98200] = true, -- Guk
	},
	-- ----------------------------------------------------------------------------
	-- Timeless Isle
	-- ----------------------------------------------------------------------------
	[951] = {
		[71864] = true, -- Spelurk
		[71919] = true, -- Zhu-Gon the Sour
		[72045] = true, -- Chelon
		[72048] = true, -- Rattleskew
		[72049] = true, -- Cranegnasher
		[72193] = true, -- Karkanos
		[72245] = true, -- Zesqua
		[72769] = true, -- Spirit of Jadefire
		[72775] = true, -- Bufo
		[72808] = true, -- Tsavo'ka
		[72909] = true, -- Gu'chi the Swarmbringer
		[72970] = true, -- Golganarr
		[73157] = true, -- Rock Moss
		[73158] = true, -- Emerald Gander
		[73160] = true, -- Ironfur Steelhorn
		[73161] = true, -- Great Turtle Furyshell
		[73163] = true, -- Imperial Python
		[73166] = true, -- Monstrous Spineclaw
		[73167] = true, -- Huolon
		[73169] = true, -- Jakur of Ordon
		[73170] = true, -- Watcher Osu
		[73171] = true, -- Champion of the Black Flame
		[73172] = true, -- Flintlord Gairan
		[73173] = true, -- Urdur the Cauterizer
		[73174] = true, -- Archiereus of Flame
		[73175] = true, -- Cinderfall
		[73277] = true, -- Leafmender
		[73279] = true, -- Evermaw
		[73281] = true, -- Dread Ship Vazuvius
		[73282] = true, -- Garnia
		[73293] = true, -- Whizzig
		[73666] = true, -- Archiereus of Flame
		[73704] = true, -- Stinkbraid
		[73854] = true, -- Cranegnasher
	},
	-- ----------------------------------------------------------------------------
	-- Ashran
	-- ----------------------------------------------------------------------------
	[978] = {
		[82876] = true, -- Grand Marshal Tremblade
		[82877] = true, -- High Warlord Volrath
		[82878] = true, -- Marshal Gabriel
		[82880] = true, -- Marshal Karsh Stormforge
		[82882] = true, -- General Aevd
		[82883] = true, -- Warlord Noktyn
		[83683] = true, -- Mandragoraster
		[83691] = true, -- Panthora
		[83713] = true, -- Titarus
		[83819] = true, -- Brickhouse
		[84110] = true, -- Korthall Soulgorger
		[84196] = true, -- Web-wrapped Soldier
		[84465] = true, -- Leaping Gorger
		[84746] = true, -- Captured Gor'vosh Stoneshaper
		[84854] = true, -- Slippery Slime
		[84875] = true, -- Ancient Inferno
		[84893] = true, -- Goregore
		[84904] = true, -- Oraggro
		[84926] = true, -- Burning Power
		[85763] = true, -- Cursed Ravager
		[85765] = true, -- Cursed Kaliri
		[85766] = true, -- Cursed Sharptalon
		[85767] = true, -- Cursed Harbinger
		[85771] = true, -- Elder Darkweaver Kath
		[87362] = true, -- Gibby
		[91921] = true, -- Wyrmple
		[94113] = true, -- Rukmaz
	},
	-- ----------------------------------------------------------------------------
	-- Lunarfall
	-- ----------------------------------------------------------------------------
	[971] = {
		[96323] = true, -- Arachnis
	},
	[973] = {
		[96323] = true, -- Arachnis
	},
	[974] = {
		[96323] = true, -- Arachnis
	},
	[975] = {
		[96323] = true, -- Arachnis
	},
	[991] = {
		[96323] = true, -- Arachnis
	},
	-- ----------------------------------------------------------------------------
	-- Frostwall
	-- ----------------------------------------------------------------------------
	[976] = {
		[96323] = true, -- Arachnis
	},
	[980] = {
		[96323] = true, -- Arachnis
	},
	[981] = {
		[96323] = true, -- Arachnis
	},
	[982] = {
		[96323] = true, -- Arachnis
	},
	[990] = {
		[96323] = true, -- Arachnis
	},
	-- ----------------------------------------------------------------------------
	-- Upper Blackrock Spire
	-- ----------------------------------------------------------------------------
	[995] = {
		[77081] = true, -- The Lanticore
	},
	-- ----------------------------------------------------------------------------
	-- Azsuna
	-- ----------------------------------------------------------------------------
	[1015] = {
		[89016] = true, -- Ravyn-Drath
		[89650] = true, -- Valiyaka the Stormbringer
		[89816] = true, -- Golza the Iron Fin
		[89846] = true, -- Captain Volo'ren
		[89850] = true, -- The Oracle
		[89865] = true, -- Mrrgrl the Tide Reaver
		[89884] = true, -- Flog the Captain-Eater
		[90057] = true, -- Daggerbeak
		[90164] = true, -- Warbringer Mox'na
		[90173] = true, -- Arcana Stalker
		[90217] = true, -- Normantis the Deposed
		[90244] = true, -- Arcavellus
		[90505] = true, -- Syphonus
		[90803] = true, -- Infernal Lord
		[90901] = true, -- Pridelord Meowl
		[91100] = true, -- Brogozog
		[91113] = true, -- Tide Behemoth
		[91114] = true, -- Tide Behemoth
		[91115] = true, -- Tide Behemoth
		[91187] = true, -- Beacher
		[91289] = true, -- Cailyn Paledoom
		[91579] = true, -- Doomlord Kazrok
		[93622] = true, -- Mortiferous
		[99846] = true, -- Raging Earth
		[99886] = true, -- Pacified Earth
		[101596] = true, -- Charfeather
		[102064] = true, -- Torrentius
		[102075] = true, -- Withered J'im
		[103975] = true, -- Jade Darkhaven
		[105938] = true, -- Felwing
		[106990] = true, -- Chief Bitterbrine
		[107105] = true, -- Broodmother Lizax
		[107113] = true, -- Vorthax
		[107127] = true, -- Brawlgoth
		[107136] = true, -- Houndmaster Stroxis
		[107169] = true, -- Horux
		[107170] = true, -- Zorux
		[107266] = true, -- Commander Soraax
		[107269] = true, -- Inquisitor Tivos
		[107327] = true, -- Bilebrain
		[107657] = true, -- Arcanist Shal'iman
		[108136] = true, -- The Muscle
		[108174] = true, -- Bilgerat
		[108255] = true, -- Coura, Mistress of Arcana
		[108829] = true, -- Levantus
		[109331] = true, -- Calamir
		[109504] = true, -- Ragemaw
		[109575] = true, -- Valakar the Thirsty
		[109584] = true, -- Fjordun
		[109594] = true, -- Stormfeather
		[109620] = true, -- The Whisperer
		[109630] = true, -- Immolian
		[109641] = true, -- Arcanor Prime
		[109653] = true, -- Marblub the Massive
		[109677] = true, -- Chief Treasurer Jabrill
		[109702] = true, -- Deepclaw
		[110824] = true, -- Tideclaw
		[111434] = true, -- Sea King Tidross
		[111454] = true, -- Bestrix
		[111674] = true, -- Cinderwing
		[111939] = true, -- Lysanis Shadesoul
		[112636] = true, -- Sinister Leyrunner
		[112637] = true, -- Devious Sunrunner
	},
	-- ----------------------------------------------------------------------------
	-- Stormheim
	-- ----------------------------------------------------------------------------
	[1017] = {
		[90139] = true, -- Inquisitor Ernstenbok
		[91529] = true, -- Glimar Ironfist
		[91780] = true, -- Mother Clacker
		[91795] = true, -- Stormwing Matriarch
		[91803] = true, -- Fathnyr
		[91874] = true, -- Bladesquall
		[91892] = true, -- Thane Irglov the Merciless
		[92152] = true, -- Whitewater Typhoon
		[92590] = true, -- Hook
		[92591] = true, -- Sinker
		[92599] = true, -- Bloodstalker Alpha
		[92604] = true, -- Champion Elodie
		[92609] = true, -- Tracker Jack
		[92611] = true, -- Ambusher Daggerfang
		[92613] = true, -- Priestess Liza
		[92626] = true, -- Deathguard Adams
		[92631] = true, -- Dark Ranger Jess
		[92633] = true, -- Assassin Huwe
		[92634] = true, -- Apothecary Perez
		[92682] = true, -- Helmouth Raider
		[92685] = true, -- Captain Brvet
		[92703] = true, -- Helmouth Raider
		[92751] = true, -- Ivory Sentinel
		[92763] = true, -- The Nameless King
		[92951] = true, -- Houndmaster Ely
		[93166] = true, -- Tiptog the Lost
		[93371] = true, -- Mordvigbjorn
		[93401] = true, -- Urgev the Flayer
		[94313] = true, -- Daniel "Boomer" Vorick
		[94347] = true, -- Dread-Rider Cortis
		[94413] = true, -- Isel the Hammer
		[98188] = true, -- Egyl the Enduring
		[98268] = true, -- Tarben
		[98421] = true, -- Kottr Vondyr
		[98503] = true, -- Grrvrgull the Conqueror
		[99886] = true, -- Pacified Earth
		[100223] = true, -- Vrykul Earthshaper Spirit
		[100224] = true, -- Vrykul Earthmaiden Spirit
		[107023] = true, -- Nithogg
		[107487] = true, -- Starbuck
		[107544] = true, -- Nithogg
		[107926] = true, -- Hannval the Butcher
		[108790] = true, -- Den Mother Ylva
		[108822] = true, -- Huntress Estrid
		[108823] = true, -- Halfdan
		[108827] = true, -- Fjorlag, the Grave's Chill
		[108885] = true, -- Aegir Wavecrusher
		[109015] = true, -- Lagertha
		[109113] = true, -- Boulderfall, the Eroded
		[109195] = true, -- Soulbinder Halldora
		[109317] = true, -- Rulf Bonesnapper
		[109318] = true, -- Runeseer Sigvid
		[109994] = true, -- Stormtalon
		[110363] = true, -- Roteye
		[111463] = true, -- Bulvinkel
		[117850] = true, -- Simone the Seductress
	},
	-- ----------------------------------------------------------------------------
	-- Val'Sharah
	-- ----------------------------------------------------------------------------
	[1018] = {
		[92104] = true, -- Thistleleaf Rascal
		[92117] = true, -- Gorebeak,
		[92180] = true, -- Seersei
		[92423] = true, -- Theryssia
		[92965] = true, -- Darkshade
		[93030] = true, -- Ironbranch
		[93205] = true, -- Thondrax
		[93654] = true, -- Skul'vrax
		[93679] = true, -- Gathenak the Subjugator
		[93686] = true, -- Jinikki the Puncturer
		[93758] = true, -- Antydas Nightcaller
		[94414] = true, -- Kiranys Duskwhisper
		[94485] = true, -- Pollous the Fetid
		[95123] = true, -- Grelda the Hag
		[95221] = true, -- Mad Henryk
		[95318] = true, -- Perrexx
		[97504] = true, -- Wraithtalon
		[97517] = true, -- Dreadbog
		[98241] = true, -- Lyrath Moonfeather
		[99846] = true, -- Raging Earth
		[99886] = true, -- Pacified Earth
		[103785] = true, -- Well-Fed Bear
		[104523] = true, -- Shalas'aman
		[106042] = true, -- Kalazzius the Guileful
		[107924] = true, -- Darkfiend Tormentor
		[108678] = true, -- Shar'thos
		[108879] = true, -- Humongris
		[109125] = true, -- Kathaw the Savage
		[109281] = true, -- Malisandra
		[109648] = true, -- Witchdoctor Grgl-Brgl
		[109692] = true, -- Lytheron
		[109708] = true, -- Undergrell Ringleader
		[109990] = true, -- Nylaathria the Forgotten
		[110342] = true, -- Rabxach
		[110346] = true, -- Aodh Witherpetal
		[110361] = true, -- Harbinger of Screams
		[110367] = true, -- Ealdis
		[110562] = true, -- Bahagar
	},
	-- ----------------------------------------------------------------------------
	-- Broken Shore
	-- ----------------------------------------------------------------------------
	[1021] = {
		[116166] = true, -- Eye of Gurgh
		[116953] = true, -- Corrupted Bonebreaker
		[117086] = true, -- Emberfire
		[117089] = true, -- Inquisitor Chillbane
		[117090] = true, -- Xorogun the Flamecarver
		[117091] = true, -- Felmaw Emberfiend
		[117093] = true, -- Felbringer Xar'thok
		[117094] = true, -- Malorus the Soulkeeper
		[117095] = true, -- Dreadblade Annihilator
		[117096] = true, -- Potionmaster Gloop
		[117103] = true, -- Felcaller Zelthae
		[117136] = true, -- Doombringer Zar'thoz
		[117140] = true, -- Salethan the Broodwalker
		[117141] = true, -- Malgrazoth
		[117239] = true, -- Brutallus
		[117303] = true, -- Malificus
		[117470] = true, -- Si'vash
		[118993] = true, -- Dreadeye
		[119629] = true, -- Lord Hel'Nurath
		[119718] = true, -- Imp Mother Bruva
		[120583] = true, -- Than'otalion
		[120641] = true, -- Skulguloth
		[120665] = true, -- Force-Commander Xillious
		[120675] = true, -- An'thyna
		[120681] = true, -- Fel Obliterator
		[120686] = true, -- Illisthyndria
		[120998] = true, -- Flllurlokkr
		[121016] = true, -- Aqueux
		[121029] = true, -- Brood Mother Nix
		[121037] = true, -- Grossir
		[121046] = true, -- Brother Badatin
		[121049] = true, -- Baleful Knight-Captain
		[121051] = true, -- Unstable Abyssal
		[121056] = true, -- Malformed Terrorguard
		[121068] = true, -- Volatile Imp
		[121073] = true, -- Deranged Succubus
		[121077] = true, -- Lambent Felhunter
		[121088] = true, -- Warped Voidlord
		[121090] = true, -- Demented Shivarra
		[121092] = true, -- Anomalous Observer
		[121107] = true, -- Lady Eldrathe
		[121108] = true, -- Ruinous Overfiend
		[121112] = true, -- Somber Dawn
		[121124] = true, -- Apocron
		[121134] = true, -- Duke Sithizi
	},
	-- ----------------------------------------------------------------------------
	-- Helheim
	-- ----------------------------------------------------------------------------
	[1022] = {
		[92040] = true, -- Fenri
		[97630] = true, -- Soulthirster
		[109163] = true, -- Captain Dargun
	},
	-- ----------------------------------------------------------------------------
	-- Highmountain
	-- ----------------------------------------------------------------------------
	[1024] = {
		[94877] = true, -- Brogrul the Mighty
		[95204] = true, -- Oubdob da Smasher
		[95872] = true, -- Skullhat
		[96072] = true, -- Durguth
		[96410] = true, -- Majestic Elderhorn
		[96590] = true, -- Gurbog da Basher
		[96621] = true, -- Mellok, Son of Torok
		[97093] = true, -- Shara Felbreath
		[97102] = true, -- Ram'Pag
		[97203] = true, -- Tenpak Flametotem
		[97220] = true, -- Arru
		[97326] = true, -- Hartli the Snatcher
		[97345] = true, -- Crawshuk the Hungry
		[97449] = true, -- Bristlemaul
		[97593] = true, -- Mynta Talonscreech
		[97653] = true, -- Taurson
		[97793] = true, -- Flamescale
		[97928] = true, -- Tamed Coralback
		[97933] = true, -- Crab Rider Grmlrml
		[98024] = true, -- Luggut the Eggeater
		[98299] = true, -- Bodash the Hoarder
		[98311] = true, -- Mrrklr
		[98890] = true, -- Slumber
		[99846] = true, -- Raging Earth
		[99886] = true, -- Pacified Earth
		[99929] = true, -- Flotsam
		[100230] = true, -- "Sure-Shot" Arnie
		[100231] = true, -- Dargok Thunderuin
		[100232] = true, -- Ryael Dawndrifter
		[100302] = true, -- Puck
		[100303] = true, -- Zenobia
		[100495] = true, -- Devouring Darkness
		[101077] = true, -- Sekhan
		[101649] = true, -- Frostshard
		[102863] = true, -- Bruiser
		[104481] = true, -- Ala'washte
		[104484] = true, -- Olokk the Shipbreaker
		[104513] = true, -- Defilia
		[104517] = true, -- Mawat'aki
		[104524] = true, -- Ormagrogg
		[107924] = true, -- Darkfiend Tormentor
		[109498] = true, -- Xaander
		[109500] = true, -- Jak
		[109501] = true, -- Darkful
		[110378] = true, -- Drugon the Frostblood
		[125951] = true, -- Obsidian Deathwarder
	},
	-- ----------------------------------------------------------------------------
	-- Mardum, the Shattered Abyss
	-- ----------------------------------------------------------------------------
	[1028] = {
		[97057] = true, -- Overseer Brutarg
		[97058] = true, -- Count Nefarious
		[97059] = true, -- King Voras
		[97370] = true, -- General Volroth
	},
	-- ----------------------------------------------------------------------------
	-- Vault of the Wardens
	-- ----------------------------------------------------------------------------
	[1032] = {
		[96997] = true, -- Kethrazor
		[97069] = true, -- Wrath-Lord Lekos
	},
	-- ----------------------------------------------------------------------------
	-- Suramar
	-- ----------------------------------------------------------------------------
	[1033] = {
		[99610] = true, -- Garvrulg
		[99792] = true, -- Elfbane
		[99899] = true, -- Vicious Whale Shark
		[100864] = true, -- Cora'kar
		[102303] = true, -- Lieutenant Strathmar
		[103183] = true, -- Rok'nash
		[103203] = true, -- Jetsam
		[103214] = true, -- Har'kess the Insatiable
		[103223] = true, -- Hertha Grimdottir
		[103575] = true, -- Reef Lord Raj'his
		[103787] = true, -- Baconlisk
		[103827] = true, -- King Morgalash
		[103841] = true, -- Shadowquill
		[104519] = true, -- Colerian
		[104521] = true, -- Alteria
		[104522] = true, -- Selenyi
		[104698] = true, -- Colerian
		[105547] = true, -- Rauren
		[105632] = true, -- Broodmother Shu'malis
		[105728] = true, -- Scythemaster Cil'raman
		[105739] = true, -- Sanaar
		[105899] = true, -- Oglok the Furious
		[106351] = true, -- Artificer Lothaire
		[106526] = true, -- Lady Rivantas
		[106532] = true, -- Inquisitor Volitix
		[107846] = true, -- Pinchshank
		[109054] = true, -- Shal'an
		[109943] = true, -- Ana-Mouz
		[109954] = true, -- Magister Phaedris
		[110024] = true, -- Mal'Dreth the Corruptor
		[110321] = true, -- Na'zak the Fiend
		[110340] = true, -- Myonix
		[110438] = true, -- Siegemaster Aedrin
		[110577] = true, -- Oreth the Vile
		[110656] = true, -- Arcanist Lylandre
		[110726] = true, -- Cadraeus
		[110824] = true, -- Tideclaw
		[110832] = true, -- Gorgroth
		[110870] = true, -- Apothecary Faldren
		[110944] = true, -- Guardian Thor'el
		[111007] = true, -- Randril
		[111197] = true, -- Anax
		[111329] = true, -- Matron Hagatha
		[111649] = true, -- Ambassador D'vwinn
		[111651] = true, -- Degren
		[111653] = true, -- Miasu
		[112497] = true, -- Maia the White
		[112705] = true, -- Achronos
		[112756] = true, -- Sorallus
		[112757] = true, -- Magistrix Vilessa
		[112758] = true, -- Auditor Esiel
		[112759] = true, -- Az'jatar
		[112760] = true, -- Volshax, Breaker of Will
		[112802] = true, -- Mar'tura
		[113368] = true, -- Llorian
		[113694] = true, -- Pashya
	},
	-- ----------------------------------------------------------------------------
	-- Halls of Valor
	-- ----------------------------------------------------------------------------
	[1041] = {
		[96647] = true, -- Earlnoc the Beastbreaker
		[99802] = true, -- Arthfael
	},
	-- ----------------------------------------------------------------------------
	-- Eye of Azshara
	-- ----------------------------------------------------------------------------
	[1046] = {
		[91788] = true, -- Shellmaw
		[108543] = true, -- Dread Captain Thedon
		[101411] = true, -- Gom Crabbar
		[101467] = true, -- Jaggen-Ra
		[108541] = true, -- Dread Corsair
		[111573] = true, -- Kosumoth the Hungering
	},
	-- ----------------------------------------------------------------------------
	-- Darkheart Thicket
	-- ----------------------------------------------------------------------------
	[1067] = {
		[99362] = true, -- Kudzilla
		[101660] = true, -- Rage Rot
	},
	-- ----------------------------------------------------------------------------
	-- Thunder Totem
	-- ----------------------------------------------------------------------------
	[1080] = {
		[101077] = true, -- Sekhan
	},
	-- ----------------------------------------------------------------------------
	-- The Exodar
	-- ----------------------------------------------------------------------------
	[1091] = {
		[110486] = true, -- Huk'roth the Huntmaster
	},
	-- ----------------------------------------------------------------------------
	-- Krokuun
	-- ----------------------------------------------------------------------------
	[1135] = {
		[120393] = true, -- Siegemaster Voraan
		[122911] = true, -- Commander Vecaya
		[122912] = true, -- Commander Sathrenael
		[123464] = true, -- Sister Subversia
		[123689] = true, -- Talestra the Vile
		[124775] = true, -- Commander Endaxis
		[124804] = true, -- Tereck the Selector
		[125388] = true, -- Vagath the Betrayed
		[125479] = true, -- Tar Spitter
		[125820] = true, -- Imp Mother Laglath
		[125824] = true, -- Khazaduum
		[126419] = true, -- Naroua
	},
	-- ----------------------------------------------------------------------------
	-- Mac'Aree
	-- ----------------------------------------------------------------------------
	[1170] = {
		[122838] = true, -- Shadowcaster Voruun
		[126815] = true, -- Soultwisted Monstrosity
		[126852] = true, -- Wrangler Kravos
		[126860] = true, -- Kaara the Pale
		[126862] = true, -- Baruut the Bloodthirsty
		[126864] = true, -- Feasel the Muffin Thief
		[126865] = true, -- Vigilant Thanos
		[126866] = true, -- Vigilant Kuro
		[126867] = true, -- Venomtail Skyfin
		[126868] = true, -- Turek the Lucid
		[126869] = true, -- Captain Faruq
		[126885] = true, -- Umbraliss
		[126887] = true, -- Ataxon
		[126889] = true, -- Sorolis the Ill-Fated
		[126896] = true, -- Herald of Chaos
		[126898] = true, -- Sabuul
		[126899] = true, -- Jed'hin Champion Vorusk
		[124440] = true, -- Overseer Y'Beda
		[125497] = true, -- Overseer Y'Sorna
		[125498] = true, -- Overseer Y'Morna
		[126887] = true, -- Ataxon
		[126900] = true, -- Instructor Tarahna
		[126908] = true, -- Zul'tan the Numerous
		[126910] = true, -- Commander Xethgar
		[126912] = true, -- Skreeg the Devourer
		[126913] = true, -- Slithon the Last
	},
	-- ----------------------------------------------------------------------------
	-- Antoran Wastes
	-- ----------------------------------------------------------------------------
	[1171] = {
		[122947] = true, -- Mistress Il'thendra
		[122958] = true, -- Blistermaw
		[122999] = true, -- Gar'zoth
		[126040] = true, -- Puscilla
		[126115] = true, -- Ven'orn
		[126199] = true, -- Vrax'thul
		[126208] = true, -- Varga
		[126254] = true, -- Lieutenant Xakaar
		[126338] = true, -- Wrath-Lord Yarez
		[126946] = true, -- Inquisitor Vethroz
		[127084] = true, -- Commander Texlaz
		[127090] = true, -- Admiral Rel'var
		[127096] = true, -- All-Seer Xanarian
		[127118] = true, -- Worldsplitter Skuul
		[127288] = true, -- Houndmaster Kerrax
		[127291] = true, -- Watcher Aival
		[127300] = true, -- Void Warden Valsuran
		[127376] = true, -- Chief Alchemist Munculus
		[127581] = true, -- The Many-Faced Devourer
		[127700] = true, -- Squadron Commander Vishax
		[127703] = true, -- Doomcaster Suprax
		[127705] = true, -- Mother Rosula
		[127706] = true, -- Rezira the Seer
	},
}

private.MapNPCs = MapNPCs

local ContinentIDByDungeonMapID = {
	[686] = private.ContinentID.Kalimdor, -- Zul'Farrak
	[687] = private.ContinentID.EasternKingdoms, -- The Temple of Atal'Hakkar
	[688] = private.ContinentID.Kalimdor, -- Blackfathom Deeps
	[691] = private.ContinentID.EasternKingdoms, -- Gnomeregan
	[699] = private.ContinentID.Kalimdor, -- Dire Maul
	[704] = private.ContinentID.EasternKingdoms, -- Blackrock Depths
	[721] = private.ContinentID.EasternKingdoms, -- Blackrock Spire
	[734] = private.ContinentID.Kalimdor, -- Old Hillsbrad Foothills
	[749] = private.ContinentID.Kalimdor, -- Wailing Caverns
	[750] = private.ContinentID.Kalimdor, -- Maraudon
	[756] = private.ContinentID.EasternKingdoms, -- The Deadmines
	[761] = private.ContinentID.Kalimdor, -- Razorfen Kraul
	[764] = private.ContinentID.EasternKingdoms, -- Shadowfang Keep
	[765] = private.ContinentID.EasternKingdoms, -- Stratholme
	[795] = private.ContinentID.Kalimdor, -- Molten Front
	[799] = private.ContinentID.EasternKingdoms, -- Karazhan
	[898] = private.ContinentID.EasternKingdoms, -- Scholomance
	[930] = private.ContinentID.Pandaria, -- Throne of Thunder
	[995] = private.ContinentID.EasternKingdoms, -- Upper Blackrock Spire
	[1022] = private.ContinentID.BrokenIsles, -- Helheim
	[1028] = private.ContinentID.BrokenIsles, -- Mardum, the Shattered Abyss
	[1032] = private.ContinentID.BrokenIsles, -- Vault of the Wardens
	[1041] = private.ContinentID.BrokenIsles, -- Halls of Valor
	[1046] = private.ContinentID.BrokenIsles, -- Eye of Azshara
	[1067] = private.ContinentID.BrokenIsles, -- Darkheart Thicket
	[1091] = private.ContinentID.Kalimdor, -- The Exodar (Scenario version)
}

private.ContinentIDByDungeonMapID = ContinentIDByDungeonMapID

local AlphabeticalMapIDs = {}
private.AlphabeticalMapIDs = AlphabeticalMapIDs

local ContinentMaps = {}
private.ContinentMaps = ContinentMaps

local AlphabeticalContinentMaps = {}
private.AlphabeticalContinentMaps = AlphabeticalContinentMaps

local ContinentIDByMapID = {}
private.ContinentIDByMapID = ContinentIDByMapID

local MapNameByID = {}
private.MapNameByID = MapNameByID

for mapID in pairs(MapNPCs) do
	AlphabeticalMapIDs[#AlphabeticalMapIDs + 1] = mapID

	local continentID = HereBeDragons:GetCZFromMapID(mapID)
	if continentID < 1 then
		continentID = ContinentIDByDungeonMapID[mapID] or continentID
	end

	ContinentMaps[continentID] = ContinentMaps[continentID] or {}
	ContinentMaps[continentID][mapID] = true

	AlphabeticalContinentMaps[continentID] = AlphabeticalContinentMaps[continentID] or {}
	AlphabeticalContinentMaps[continentID][#AlphabeticalContinentMaps[continentID] + 1] = mapID

	ContinentIDByMapID[mapID] = continentID
	MapNameByID[mapID] = HereBeDragons:GetLocalizedMap(mapID)
end

local function SortByMapNameThenByID(a, b)
	local mapNameA = MapNameByID[a]
	local mapNameB = MapNameByID[b]

	if mapNameA == mapNameB then
		return a < b
	end

	return mapNameA < mapNameB
end

private.SortByMapNameThenByID = SortByMapNameThenByID

for index = 1, #AlphabeticalContinentMaps do
	table.sort(AlphabeticalContinentMaps[index], SortByMapNameThenByID)
end

table.sort(AlphabeticalMapIDs, SortByMapNameThenByID)


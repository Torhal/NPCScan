-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local AddOnFolderName, private = ...

-- ----------------------------------------------------------------------------
-- What we're really here for.
-- ----------------------------------------------------------------------------
local NPCData = {
	[462] = { -- Vultros
		isTameable = true,
	},
	[471] = { -- Mother Fang
		isTameable = true,
	},
	[521] = { -- Lupos
		isTameable = true,
	},
	[574] = { -- Naraxis
		isTameable = true,
	},
	[616] = { -- Chatter
		isTameable = true,
	},
	[1112] = { -- Leech Widow
		isTameable = true,
	},
	[1130] = { -- Bjarn
		isTameable = true,
	},
	[1132] = { -- Timber
		isTameable = true,
	},
	[1140] = { -- Razormaw Matriarch
		isTameable = true,
	},
	[1552] = { -- Scale Belly
		isTameable = true,
	},
	[2172] = { -- Strider Clutchmother
		isTameable = true,
	},
	[2175] = { -- Shadowclaw
		isTameable = true,
	},
	[2476] = { -- Gosh-Haldir
		isTameable = true,
	},
	[2753] = { -- Barnabus
		isTameable = true,
	},
	[2850] = { -- Broken Tooth
		isTameable = true,
	},
	[2931] = { -- Zaricotl
		isTameable = true,
	},
	[3068] = { -- Mazzranache
		isTameable = true,
	},
	[3253] = { -- Silithid Harvester
		isTameable = true,
	},
	[3581] = { -- Sewer Beast
		isTameable = true,
	},
	[4132] = { -- Krkk'kx
		isTameable = true,
	},
	[4380] = { -- Darkmist Widow
		isTameable = true,
	},
	[4425] = { -- Blind Hunter
		isTameable = true,
	},
	[5349] = { -- Arash-ethis
		isTameable = true,
	},
	[5350] = { -- Qirot
		isTameable = true,
	},
	[5352] = { -- Old Grizzlegut
		isTameable = true,
	},
	[5356] = { -- Snarler
		isTameable = true,
	},
	[5807] = { -- The Rake
		isTameable = true,
	},
	[5823] = { -- Death Flayer
		isTameable = true,
	},
	[5828] = { -- Humar the Pridelord
		isTameable = true,
	},
	[5829] = { -- Snort the Heckler
		isTameable = true,
	},
	[5834] = { -- Azzere the Skyblade
		isTameable = true,
	},
	[5842] = { -- Takk the Leaper
		isTameable = true,
	},
	[5865] = { -- Dishu
		isTameable = true,
	},
	[5937] = { -- Vile Sting
		isTameable = true,
	},
	[6581] = { -- Ravasaur Matriarch
		isTameable = true,
	},
	[6582] = { -- Clutchmother Zavas
		isTameable = true,
	},
	[6584] = { -- King Mosh
		isTameable = true,
	},
	[6585] = { -- Uhk'loc
		isTameable = true,
	},
	[8204] = { -- Soriid the Devourer
		isTameable = true,
	},
	[8205] = { -- Haarka the Ravenous
		isTameable = true,
	},
	[8207] = { -- Emberwing
		isTameable = true,
	},
	[8211] = { -- Old Cliff Jumper
		isTameable = true,
	},
	[8213] = { -- Ironback
		isTameable = true,
	},
	[8277] = { -- Rekk'tilac
		isTameable = true,
	},
	[8299] = { -- Spiteflayer
		isTameable = true,
	},
	[8300] = { -- Ravage
		isTameable = true,
	},
	[8301] = { -- Clack the Reaver
		isTameable = true,
	},
	[8303] = { -- Grunter
		isTameable = true,
	},
	[8660] = { -- The Evalcharr
		isTameable = true,
	},
	[10077] = { -- Deathmaw
		isTameable = true,
	},
	[10200] = { -- Rak'shiri
		isTameable = true,
	},
	[10356] = { -- Bayne
		isTameable = true,
	},
	[10357] = { -- Ressan the Needler
		isTameable = true,
	},
	[10359] = { -- Sri'skulk
		isTameable = true,
	},
	[10376] = { -- Crystal Fang
		isTameable = true,
	},
	[10644] = { -- Mist Howler
		isTameable = true,
	},
	[10741] = { -- Sian-Rotam
		isTameable = true,
	},
	[11497] = { -- The Razza
		isTameable = true,
	},
	[12037] = { -- Ursol'lok
		isTameable = true,
	},
	[12431] = { -- Gorefang
		isTameable = true,
	},
	[12433] = { -- Krethis the Shadowspinner
		isTameable = true,
	},
	[14222] = { -- Araga
		isTameable = true,
	},
	[14223] = { -- Cranky Benj
		isTameable = true,
	},
	[14228] = { -- Giggler
		isTameable = true,
	},
	[14232] = { -- Dart
		isTameable = true,
	},
	[14233] = { -- Ripscale
		isTameable = true,
	},
	[14234] = { -- Hayoc
		isTameable = true,
	},
	[14237] = { -- Oozeworm
		isTameable = true,
	},
	[14266] = { -- Shanda the Spinner
		isTameable = true,
	},
	[14268] = { -- Lord Condar
		isTameable = true,
	},
	[14279] = { -- Creepthess
		isTameable = true,
	},
	[14280] = { -- Big Samras
		isTameable = true,
	},
	[14339] = { -- Death Howl
		isTameable = true,
	},
	[14343] = { -- Olm the Wise
		isTameable = true,
	},
	[14344] = { -- Mongress
		isTameable = true,
	},
	[14430] = { -- Duskstalker
		isTameable = true,
	},
	[14472] = { -- Gretheer
		isTameable = true,
	},
	[14473] = { -- Lapress
		isTameable = true,
	},
	[14474] = { -- Zora
		isTameable = true,
	},
	[14475] = { -- Rex Ashil
		isTameable = true,
	},
	[14476] = { -- Krellack
		isTameable = true,
	},
	[14477] = { -- Grubthor
		isTameable = true,
	},
	[14491] = { -- Kurmokk
		isTameable = true,
	},
	[16180] = { -- Shadikith the Glider
		isTameable = true,
	},
	[16181] = { -- Rokad the Ravager
		isTameable = true,
	},
	[17144] = { -- Goretooth
		isTameable = true,
	},
	[18241] = { -- Crusty
		isTameable = true,
	},
	[18680] = { -- Marticar
		isTameable = true,
	},
	[20932] = { -- Nuramoc
		isTameable = true,
	},
	[21724] = { -- Hawkbane
		isTameable = true,
	},
	[32361] = { -- Icehorn
		isTameable = true,
	},
	[32475] = { -- Terror Spinner
		isTameable = true,
	},
	[32481] = { -- Aotona
		isTameable = true,
	},
	[32485] = { -- King Krush
		isTameable = true,
	},
	[32517] = { -- Loque'nahak
		isTameable = true,
	},
	[33776] = { -- Gondria
		isTameable = true,
	},
	[35189] = { -- Skoll
		isTameable = true,
	},
	[38453] = { -- Arcturis
		isTameable = true,
	},
	[39183] = { -- Scorpitar
		isTameable = true,
	},
	[39185] = { -- Slaverjaw
		isTameable = true,
	},
	[45380] = { -- Ashtail
		isTameable = true,
	},
	[45402] = { -- Nix
		isTameable = true,
	},
	[47386] = { -- Ainamiss the Hive Queen
		isTameable = true,
	},
	[47387] = { -- Harakiss the Infestor
		isTameable = true,
	},
	[49822] = { -- Jadefang
		isTameable = true,
	},
	[50051] = { -- Ghostcrawler
		isTameable = true,
	},
	[50058] = { -- Terrorpene
		isTameable = true,
	},
	[50138] = { -- Karoma
		isTameable = true,
	},
	[50154] = { -- Madexx
		isTameable = true,
	},
	[50159] = { -- Sambas
		isTameable = true,
	},
	[50328] = { -- Fangor
		isTameable = true,
	},
	[50329] = { -- Rrakk
		isTameable = true,
	},
	[50330] = { -- Kree
		isTameable = true,
	},
	[50335] = { -- Alitus
		isTameable = true,
	},
	[50337] = { -- Cackle
		isTameable = true,
	},
	[50342] = { -- Heronis
		isTameable = true,
	},
	[50343] = { -- Quall
		isTameable = true,
	},
	[50345] = { -- Alit
		isTameable = true,
	},
	[50346] = { -- Ronak
		isTameable = true,
	},
	[50348] = { -- Norissis
		isTameable = true,
	},
	[50353] = { -- Manas
		isTameable = true,
	},
	[50357] = { -- Sunwing
		isTameable = true,
	},
	[50361] = { -- Ornat
		isTameable = true,
	},
	[50362] = { -- Blackbog the Fang
		isTameable = true,
	},
	[50370] = { -- Karapax
		isTameable = true,
	},
	[50724] = { -- Spinecrawl
		isTameable = true,
	},
	[50725] = { -- Azelisk
		isTameable = true,
	},
	[50726] = { -- Kalixx
		isTameable = true,
	},
	[50727] = { -- Strix the Barbed
		isTameable = true,
	},
	[50728] = { -- Deathstrike
		isTameable = true,
	},
	[50730] = { -- Venomspine
		isTameable = true,
	},
	[50731] = { -- Needlefang
		isTameable = true,
	},
	[50735] = { -- Blinkeye the Rattler
		isTameable = true,
	},
	[50737] = { -- Acroniss
		isTameable = true,
	},
	[50738] = { -- Shimmerscale
		isTameable = true,
	},
	[50741] = { -- Kaxx
		isTameable = true,
	},
	[50742] = { -- Qem
		isTameable = true,
	},
	[50743] = { -- Manax
		isTameable = true,
	},
	[50744] = { -- Qu'rik
		isTameable = true,
	},
	[50745] = { -- Losaj
		isTameable = true,
	},
	[50746] = { -- Bornix the Burrower
		isTameable = true,
	},
	[50747] = { -- Tix
		isTameable = true,
	},
	[50748] = { -- Nyaj
		isTameable = true,
	},
	[50752] = { -- Tarantis
		isTameable = true,
	},
	[50759] = { -- Iriss the Widow
		isTameable = true,
	},
	[50763] = { -- Shadowstalker
		isTameable = true,
	},
	[50764] = { -- Paraliss
		isTameable = true,
	},
	[50765] = { -- Miasmiss
		isTameable = true,
	},
	[50770] = { -- Zorn
		isTameable = true,
	},
	[50775] = { -- Likk the Hunter
		isTameable = true,
	},
	[50777] = { -- Needle
		isTameable = true,
	},
	[50778] = { -- Ironweb
		isTameable = true,
	},
	[50779] = { -- Sporeggon
		isTameable = true,
	},
	[50784] = { -- Anith
		isTameable = true,
	},
	[50785] = { -- Skyshadow
		isTameable = true,
	},
	[50786] = { -- Sparkwing
		isTameable = true,
	},
	[50788] = { -- Quetzl
		isTameable = true,
	},
	[50790] = { -- Ionis
		isTameable = true,
	},
	[50792] = { -- Chiaa
		isTameable = true,
	},
	[50797] = { -- Yukiko
		isTameable = true,
	},
	[50803] = { -- Bonechewer
		isTameable = true,
	},
	[50804] = { -- Ripwing
		isTameable = true,
	},
	[50807] = { -- Catal
		isTameable = true,
	},
	[50809] = { -- Heress
		isTameable = true,
	},
	[50810] = { -- Favored of Isiset
		isTameable = true,
	},
	[50812] = { -- Arae
		isTameable = true,
	},
	[50813] = { -- Fene-mal
		isTameable = true,
	},
	[50814] = { -- Corpsefeeder
		isTameable = true,
	},
	[50815] = { -- Skarr
		isTameable = true,
	},
	[50818] = { -- The Dark Prowler
		isTameable = true,
	},
	[50819] = { -- Iceclaw
		isTameable = true,
	},
	[50825] = { -- Feras
		isTameable = true,
	},
	[50833] = { -- Duskcoat
		isTameable = true,
	},
	[50837] = { -- Kash
		isTameable = true,
	},
	[50838] = { -- Tabbs
		isTameable = true,
	},
	[50839] = { -- Chromehound
		isTameable = true,
	},
	[50842] = { -- Magmagan
		isTameable = true,
	},
	[50843] = { -- Portent
		isTameable = true,
	},
	[50846] = { -- Slavermaw
		isTameable = true,
	},
	[50855] = { -- Jaxx the Rabid
		isTameable = true,
	},
	[50856] = { -- Snark
		isTameable = true,
	},
	[50858] = { -- Dustwing
		isTameable = true,
	},
	[50864] = { -- Thicket
		isTameable = true,
	},
	[50865] = { -- Saurix
		isTameable = true,
	},
	[50874] = { -- Tenok
		isTameable = true,
	},
	[50875] = { -- Nychus
		isTameable = true,
	},
	[50876] = { -- Avis
		isTameable = true,
	},
	[50882] = { -- Chupacabros
		isTameable = true,
	},
	[50884] = { -- Dustflight the Cowardly
		isTameable = true,
	},
	[50886] = { -- Seawing
		isTameable = true,
	},
	[50891] = { -- Boros
		isTameable = true,
	},
	[50892] = { -- Cyn
		isTameable = true,
	},
	[50895] = { -- Volux
		isTameable = true,
	},
	[50897] = { -- Ffexk the Dunestalker
		isTameable = true,
	},
	[50901] = { -- Teromak
		isTameable = true,
	},
	[50903] = { -- Orlix the Swamplord
		isTameable = true,
	},
	[50905] = { -- Cida
		isTameable = true,
	},
	[50906] = { -- Mutilax
		isTameable = true,
	},
	[50908] = { -- Nighthowl
		isTameable = true,
	},
	[50915] = { -- Snort
		isTameable = true,
	},
	[50916] = { -- Lamepaw the Whimperer
		isTameable = true,
	},
	[50922] = { -- Warg
		isTameable = true,
	},
	[50925] = { -- Grovepaw
		isTameable = true,
	},
	[50926] = { -- Grizzled Ben
		isTameable = true,
	},
	[50929] = { -- Little Bjorn
		isTameable = true,
	},
	[50930] = { -- Hibernus the Sleeper
		isTameable = true,
	},
	[50931] = { -- Mange
		isTameable = true,
	},
	[50937] = { -- Hamhide
		isTameable = true,
	},
	[50940] = { -- Swee
		isTameable = true,
	},
	[50942] = { -- Snoot the Rooter
		isTameable = true,
	},
	[50945] = { -- Scruff
		isTameable = true,
	},
	[50946] = { -- Hogzilla
		isTameable = true,
	},
	[50947] = { -- Varah
		isTameable = true,
	},
	[50948] = { -- Crystalback
		isTameable = true,
	},
	[50949] = { -- Finn's Gambit
		isTameable = true,
	},
	[50952] = { -- Barnacle Jim
		isTameable = true,
	},
	[50955] = { -- Carcinak
		isTameable = true,
	},
	[50957] = { -- Hugeclaw
		isTameable = true,
	},
	[50959] = { -- Karkin
		isTameable = true,
	},
	[50964] = { -- Chops
		isTameable = true,
	},
	[50967] = { -- Craw the Ravager
		isTameable = true,
	},
	[50986] = { -- Goldenback
		isTameable = true,
	},
	[50993] = { -- Gal'dorak
		isTameable = true,
	},
	[50995] = { -- Bruiser
		isTameable = true,
	},
	[50997] = { -- Bornak the Gorer
		isTameable = true,
	},
	[51000] = { -- Blackshell the Impenetrable
		isTameable = true,
	},
	[51001] = { -- Venomclaw
		isTameable = true,
	},
	[51002] = { -- Scorpoxx
		isTameable = true,
	},
	[51004] = { -- Toxx
		isTameable = true,
	},
	[51007] = { -- Serkett
		isTameable = true,
	},
	[51008] = { -- The Barbed Horror
		isTameable = true,
	},
	[51010] = { -- Snips
		isTameable = true,
	},
	[51014] = { -- Terrapis
		isTameable = true,
	},
	[51017] = { -- Gezan
		isTameable = true,
	},
	[51018] = { -- Zormus
		isTameable = true,
	},
	[51021] = { -- Vorticus
		isTameable = true,
	},
	[51022] = { -- Chordix
		isTameable = true,
	},
	[51025] = { -- Dilennaa
		isTameable = true,
	},
	[51026] = { -- Gnath
		isTameable = true,
	},
	[51027] = { -- Spirocula
		isTameable = true,
	},
	[51028] = { -- The Deep Tunneler
		isTameable = true,
	},
	[51029] = { -- Parasitus
		isTameable = true,
	},
	[51031] = { -- Tracker
		isTameable = true,
	},
	[51037] = { -- Lost Gilnean Wardog
		isTameable = true,
	},
	[51040] = { -- Snuffles
		isTameable = true,
	},
	[51042] = { -- Bleakheart
		isTameable = true,
	},
	[51044] = { -- Plague
		isTameable = true,
	},
	[51045] = { -- Arcanus
		isTameable = true,
	},
	[51046] = { -- Fidonis
		isTameable = true,
	},
	[51048] = { -- Rexxus
		isTameable = true,
	},
	[51052] = { -- Gib the Banana-Hoarder
		isTameable = true,
	},
	[51053] = { -- Quirix
		isTameable = true,
	},
	[51057] = { -- Weevil
		isTameable = true,
	},
	[51058] = { -- Aphis
		isTameable = true,
	},
	[51061] = { -- Roth-Salam
		isTameable = true,
	},
	[51062] = { -- Khep-Re
		isTameable = true,
	},
	[51063] = { -- Phalanax
		isTameable = true,
	},
	[51066] = { -- Crystalfang
		isTameable = true,
	},
	[51067] = { -- Glint
		isTameable = true,
	},
	[51069] = { -- Scintillex
		isTameable = true,
	},
	[51071] = { -- Captain Florence
		factionGroup = "Alliance",
	},
	[51076] = { -- Lopex
		isTameable = true,
	},
	[51077] = { -- Bushtail
		isTameable = true,
	},
	[51079] = { -- Captain Foulwind
		factionGroup = "Horde",
	},
	[51401] = { -- Madexx
		isTameable = true,
	},
	[51402] = { -- Madexx
		isTameable = true,
	},
	[51403] = { -- Madexx
		isTameable = true,
	},
	[51404] = { -- Madexx
		isTameable = true,
	},
	[51661] = { -- Tsul'Kalu
		isTameable = true,
	},
	[51662] = { -- Mahamba
		isTameable = true,
	},
	[51663] = { -- Pogeyan
		isTameable = true,
	},
	[52146] = { -- Chitter
		isTameable = true,
	},
	[54318] = { -- Ankha
		isTameable = true,
	},
	[54319] = { -- Magria
		isTameable = true,
	},
	[54320] = { -- Ban'thalos
		isTameable = true,
	},
	[54321] = { -- Solix
		isTameable = true,
	},
	[54322] = { -- Deth'tilac
		isTameable = true,
	},
	[54323] = { -- Kirix
		isTameable = true,
	},
	[54324] = { -- Skitterflame
		isTameable = true,
	},
	[54338] = { -- Anthriss
		isTameable = true,
	},
	[54533] = { -- Prince Lakma
		isTameable = true,
	},
	[58474] = { -- Bloodtip
		isTameable = true,
	},
	[63509] = { -- Wulon
		isTameable = true,
	},
	[63510] = { -- Wulon
		isTameable = true,
	},
	[68317] = { -- Mavis Harms
		factionGroup = "Alliance",
	},
	[68318] = { -- Dalan Nightbreaker
		factionGroup = "Alliance",
	},
	[68319] = { -- Disha Fearwarden
		factionGroup = "Alliance",
	},
	[68320] = { -- Ubunti the Shade
		factionGroup = "Horde",
	},
	[68321] = { -- Kar Warmaker
		factionGroup = "Horde",
	},
	[68322] = { -- Muerta
		factionGroup = "Horde",
	},
	[69998] = { -- Goda
		isTameable = true,
	},
	[71665] = { -- Giant-Slayer Kul
		questID = 32918,
	},
	[71721] = { -- Canyon Icemother
		isTameable = true,
		questID = 32941,
		vignetteName = "Oasis Icemother",
	},
	[72294] = { -- Cindermaw
		questID = 33014,
	},
	[72362] = { -- Ku'targ the Voidseer
		questID = 33039,
	},
	[72364] = { -- Gorg'ak the Lava Guzzler
		questID = 33512,
		vignetteName = "Lava-Gorged Goren",
	},
	[72537] = { -- Leaf-Reader Kurri
		questID = 33055,
	},
	[72606] = { -- Rockhoof
		isTameable = true,
		questID = 34068,
	},
	[72808] = { -- Tsavo'ka
		isTameable = true,
	},
	[73158] = { -- Emerald Gander
		isTameable = true,
	},
	[73161] = { -- Great Turtle Furyshell
		isTameable = true,
	},
	[73166] = { -- Monstrous Spineclaw
		isTameable = true,
	},
	[74206] = { -- Killmaw
		isTameable = true,
		questID = 33043,
	},
	[74613] = { -- Broodmother Reeg'ak
		questID = 33843,
	},
	[74971] = { -- Firefury Giant
		questID = 33504,
		vignetteName = "Shaman Fire Stone",
	},
	[75071] = { -- Mother Om'ra
		questID = 33642,
	},
	[75434] = { -- Windfang Matriarch
		questID = 33038,
	},
	[75435] = { -- Yggdrel
		questID = 33389,
	},
	[75482] = { -- Veloss
		isTameable = true,
		questID = 33640,
	},
	[75492] = { -- Venomshade
		questID = 33643,
	},
	[76380] = { -- Gorum
		questID = 33664,
	},
	[76473] = { -- Mother Araneae
		isTameable = true,
		questID = 34726,
	},
	[76914] = { -- Coldtusk
		isTameable = true,
		questID = 34131,
	},
	[76918] = { -- Primalist Mur'og
		questID = 33938,
		vignetteName = "Ogre Primalist",
	},
	[77085] = { -- Dark Emanation
		questID = 33064,
	},
	[77140] = { -- Amaukwa
		isTameable = true,
		questID = 33061,
	},
	[77310] = { -- Mad "King" Sporeon
		questID = 35906,
	},
	[77513] = { -- Coldstomp the Griever
		isTameable = true,
		questID = 34129,
		vignetteName = "Coldstomp",
	},
	[77519] = { -- Giantbane
		isTameable = true,
	},
	[77526] = { -- Scout Goreseeker
		questID = 34132,
	},
	[77527] = { -- The Beater
		questID = 34133,
	},
	[77529] = { -- Yazheera the Incinerator
		questID = 34135,
	},
	[77561] = { -- Dr. Gloom
		questID = 34142,
	},
	[77614] = { -- Frenzied Golem
		questID = 34145,
	},
	[77620] = { -- Cro Fleshrender
		questID = 34165,
	},
	[77626] = { -- Hen-Mother Hami
		isTameable = true,
		questID = 34167,
	},
	[77634] = { -- Taladorantula
		isTameable = true,
		questID = 34171,
	},
	[77664] = { -- Aarko
		questID = 34182,
	},
	[77715] = { -- Hammertooth
		isTameable = true,
		questID = 34185,
	},
	[77719] = { -- Glimmerwing
		isTameable = true,
		questID = 34189,
	},
	[77741] = { -- Ra'kahn
		isTameable = true,
		questID = 34196,
	},
	[77750] = { -- Kaavu the Crimson Claw
		questID = 34199,
	},
	[77776] = { -- Wandering Vindicator
		questID = 34205,
	},
	[77784] = { -- Lo'marg Jawcrusher
		questID = 34208,
	},
	[77795] = { -- Echo of Murmur
		questID = 34221,
	},
	[77828] = { -- Echo of Murmur
		questID = 34220,
	},
	[78151] = { -- Huntmaster Kuang
		questID = 34130,
		vignetteName = "Giantstalker Hunting Party",
	},
	[78161] = { -- Hyperious
		questID = 34862,
	},
	[78260] = { -- King Slime
		questID = 37412,
	},
	[78265] = { -- The Bone Crawler
		questID = 34361,
	},
	[78269] = { -- Gnarljaw
		questID = 37413,
	},
	[78606] = { -- Pale Fishmonger
		questID = 34470,
		vignetteName = "Pale Gone Fishin'",
	},
	[78621] = { -- Cyclonic Fury
		questID = 34477,
	},
	[78710] = { -- Kharazos the Triumphant
		questID = 35219,
	},
	[78713] = { -- Galzomar
		questID = 35219,
	},
	[78715] = { -- Sikthiss, Maiden of Slaughter
		questID = 35219,
	},
	[78867] = { -- Breathless
		questID = 34497,
	},
	[78872] = { -- Klikixx
		isTameable = true,
		questID = 34498,
	},
	[79024] = { -- Warmaster Blugthol
		questID = 34645,
	},
	[79104] = { -- Ug'lok the Frozen
		questID = 34522,
	},
	[79145] = { -- Yaga the Scarred
		questID = 34559,
	},
	[79334] = { -- No'losh
		isTameable = true,
		questID = 34859,
	},
	[79485] = { -- Talonpriest Zorkra
		questID = 34668,
	},
	[79524] = { -- Hypnocroak
		questID = 35558,
	},
	[79543] = { -- Shirzir
		questID = 34671,
	},
	[79629] = { -- Stomper Kreego
		questID = 35910,
	},
	[79725] = { -- Captain Ironbeard
		questID = 34727,
	},
	[79938] = { -- Shadowbark
		questID = 36478,
	},
	[80057] = { -- Soulfang
		questID = 36128,
	},
	[80122] = { -- Gaz'orda
		isTameable = true,
		questID = 34725,
	},
	[80190] = { -- Gruuk
		questID = 34825,
	},
	[80204] = { -- Felbark
		questID = 35018,
	},
	[80235] = { -- Gurun
		questID = 34839,
	},
	[80242] = { -- Chillfang
		isTameable = true,
		questID = 34843,
	},
	[80312] = { -- Grutush the Pillager
		questID = 34865,
	},
	[80370] = { -- Lernaea
		isTameable = true,
		questID = 37408,
	},
	[80371] = { -- Typhon
		questID = 37405,
	},
	[80372] = { -- Echidna
		isTameable = true,
		questID = 37406,
	},
	[80398] = { -- Keravnos
		isTameable = true,
		questID = 37407,
	},
	[80471] = { -- Gennadian
		isTameable = true,
		questID = 34929,
	},
	[80524] = { -- Underseer Bloodmane
		questID = 34945,
	},
	[80614] = { -- Blade-Dancer Aeryx
		questID = 35599,
	},
	[80725] = { -- Sulfurious
		questID = 36394,
	},
	[80868] = { -- Glut
		questID = 36204,
	},
	[81038] = { -- Gelgor of the Blue Flame
		questID = 36391,
	},
	[81406] = { -- Bahameye
		questID = 35281,
	},
	[81639] = { -- Brambleking Fili
		questID = 33383,
	},
	[82050] = { -- Varasha
		isTameable = true,
	},
	[82058] = { -- Depthroot
		questID = 37370,
	},
	[82085] = { -- Bashiok
		questID = 35335,
	},
	[82207] = { -- Faebright
		questID = 35725,
	},
	[82247] = { -- Nas Dunberlin
		questID = 36129,
	},
	[82268] = { -- Darkmaster Go'vid
		questID = 35448,
	},
	[82311] = { -- Char the Burning
		questID = 35503,
	},
	[82326] = { -- Ba'ruun
		questID = 35731,
	},
	[82362] = { -- Morva Soultwister
		questID = 35523,
	},
	[82374] = { -- Rai'vosh
		questID = 35553,
	},
	[82411] = { -- Darktalon
		questID = 35555,
	},
	[82415] = { -- Shinri
		questID = 35732,
	},
	[82486] = { -- Explorer Nozzand
		questID = 35623,
	},
	[82536] = { -- Gorivax
		questID = 37388,
	},
	[82614] = { -- Moltnoma
		questID = 37387,
	},
	[82616] = { -- Jabberjaw
		isTameable = true,
		questID = 37386,
	},
	[82617] = { -- Slogtusk the Corpse-Eater
		isTameable = true,
		questID = 37385,
		vignetteName = "Slogtusk the Corpse Eater",
	},
	[82618] = { -- Tor'goroth
		questID = 37384,
	},
	[82620] = { -- Son of Goramal
		questID = 37383,
	},
	[82676] = { -- Enavra
		questID = 35688,
	},
	[82742] = { -- Enavra
		questID = 35688,
	},
	[82755] = { -- Redclaw the Feral
		questID = 35712,
	},
	[82758] = { -- Greatfeather
		isTameable = true,
		questID = 35714,
	},
	[82764] = { -- Gar'lua
		questID = 35715,
	},
	[82778] = { -- Gnarlhoof the Rabid
		isTameable = true,
		questID = 35717,
	},
	[82826] = { -- Berserk T-300 Series Mark II
		questID = 35735,
	},
	[82876] = { -- Grand Marshal Tremblade
		factionGroup = "Alliance",
	},
	[82877] = { -- High Warlord Volrath
		factionGroup = "Horde",
	},
	[82878] = { -- Marshal Gabriel
		factionGroup = "Alliance",
	},
	[82880] = { -- Marshal Karsh Stormforge
		factionGroup = "Alliance",
	},
	[82882] = { -- General Aevd
		factionGroup = "Horde",
	},
	[82883] = { -- Warlord Noktyn
		factionGroup = "Horde",
	},
	[82899] = { -- Ancient Blademaster
		questID = 35778,
	},
	[82912] = { -- Grizzlemaw
		isTameable = true,
		questID = 35784,
	},
	[82920] = { -- Lord Korinak
		questID = 37345,
	},
	[82922] = { -- Xothear, the Destroyer
		questID = 37343,
	},
	[82930] = { -- Shadowflame Terrorwalker
		questID = 37347,
	},
	[82942] = { -- Lady Demlash
		questID = 37346,
	},
	[82975] = { -- Fangler
		questID = 35836,
	},
	[82988] = { -- Kurlosh Doomfang
		questID = 37348,
	},
	[82992] = { -- Felfire Consort
		questID = 37341,
	},
	[82998] = { -- Matron of Sin
		questID = 37349,
	},
	[83008] = { -- Haakun the All-Consuming
		questID = 37312,
	},
	[83019] = { -- Gug'tol
		questID = 37340,
	},
	[83385] = { -- Voidseer Kalurg
		questID = 35847,
	},
	[83401] = { -- Netherspawn
		questID = 35865,
	},
	[83409] = { -- Ophiis
		questID = 35875,
	},
	[83428] = { -- Windcaller Korast
		questID = 35877,
	},
	[83483] = { -- Flinthide
		isTameable = true,
		questID = 35893,
	},
	[83509] = { -- Gorepetal
		questID = 35898,
	},
	[83522] = { -- Hive Queen Skrikka
		isTameable = true,
		questID = 35908,
	},
	[83526] = { -- Ru'klaa
		questID = 35900,
	},
	[83542] = { -- Sean Whitesea
		questID = 35912,
	},
	[83553] = { -- Insha'tar
		isTameable = true,
		questID = 35909,
	},
	[83591] = { -- Tura'aka
		isTameable = true,
		questID = 35920,
	},
	[83603] = { -- Hunter Blacktooth
		questID = 35923,
	},
	[83634] = { -- Scout Pokhar
		questID = 35931,
	},
	[83643] = { -- Malroc Stonesunder
		questID = 35932,
	},
	[83680] = { -- Outrider Duretha
		questID = 35943,
	},
	[83990] = { -- Solar Magnifier
		questID = 37394,
	},
	[84263] = { -- Graveltooth
		questID = 36159,
	},
	[84374] = { -- Kaga the Ironbender
		questID = 37404,
	},
	[84376] = { -- Earthshaker Holar
		questID = 37403,
	},
	[84378] = { -- Ak'ox the Slaughterer
		questID = 37525,
	},
	[84392] = { -- Ragore Driftstalker
		questID = 37401,
	},
	[84406] = { -- Mandrakor
		questID = 36178,
	},
	[84417] = { -- Mutafen
		questID = 36396,
	},
	[84431] = { -- Greldrok the Cunning
		questID = 36186,
	},
	[84435] = { -- Mr. Pinchy Sr.
		questID = 36229,
	},
	[84775] = { -- Tesska the Broken
		questID = 36254,
	},
	[84805] = { -- Stonespite
		isTameable = true,
		questID = 36265,
	},
	[84807] = { -- Durkath Steelmaw
		questID = 36267,
	},
	[84810] = { -- Kalos the Bloodbathed
		questID = 36268,
	},
	[84833] = { -- Sangrikass
		questID = 36276,
	},
	[84836] = { -- Talonbreaker
		questID = 36278,
	},
	[84838] = { -- Poisonmaster Bortusk
		questID = 36279,
	},
	[84856] = { -- Blightglow
		isTameable = true,
		questID = 36283,
	},
	[84872] = { -- Oskiira the Vengeful
		questID = 36288,
	},
	[84887] = { -- Betsi Boombasket
		questID = 36291,
	},
	[84890] = { -- Festerbloom
		questID = 36297,
	},
	[84893] = { -- Goregore
		isTameable = true,
	},
	[84911] = { -- Demidos
		questID = 37351,
	},
	[84912] = { -- Sunderthorn
		isTameable = true,
		questID = 36298,
	},
	[84925] = { -- Quartermaster Hershak
		questID = 37352,
	},
	[84951] = { -- Gobblefin
		questID = 36305,
	},
	[84955] = { -- Jiasska the Sporegorger
		isTameable = true,
		questID = 36306,
	},
	[85001] = { -- Master Sergeant Milgra
		questID = 37353,
	},
	[85026] = { -- Soul-Twister Torek
		questID = 37358,
	},
	[85029] = { -- Shadowspeaker Niir
		questID = 37354,
	},
	[85036] = { -- Formless Nightmare
		questID = 37360,
	},
	[85037] = { -- Kenos the Unraveler
		questID = 37361,
	},
	[85078] = { -- Voidreaver Urnae
		questID = 37359,
	},
	[85121] = { -- Lady Temptessa
		questID = 37355,
	},
	[85250] = { -- Fossilwood the Petrified
		questID = 36387,
	},
	[85264] = { -- Rolkor
		questID = 36393,
	},
	[85451] = { -- Malgosh Shadowkeeper
		questID = 37357,
	},
	[85504] = { -- Rotcap
		questID = 36470,
	},
	[85520] = { -- Swarmleaf
		questID = 36472,
	},
	[85555] = { -- Nagidna
		questID = 37409,
	},
	[85568] = { -- Avalanche
		questID = 37410,
	},
	[85572] = { -- Grrbrrgle
		questID = 36919,
	},
	[85837] = { -- Slivermaw
		questID = 37411,
	},
	[85907] = { -- Berthora
		isTameable = true,
		questID = 36597,
	},
	[85970] = { -- Riptar
		isTameable = true,
		questID = 36600,
	},
	[86137] = { -- Sunclaw
		questID = 36656,
	},
	[86257] = { -- Basten
		questID = 37369,
	},
	[86266] = { -- Venolasix
		isTameable = true,
		questID = 37372,
	},
	[86268] = { -- Alkali
		questID = 37371,
	},
	[86410] = { -- Sylldross
		questID = 36794,
	},
	[86520] = { -- Stompalupagus
		isTameable = true,
		questID = 36837,
	},
	[86549] = { -- Steeltusk
		questID = 36858,
	},
	[86562] = { -- Maniacal Madgard
		questID = 37363,
	},
	[86566] = { -- Defector Dazgo
		questID = 37362,
	},
	[86571] = { -- Durp the Hated
		questID = 37366,
	},
	[86574] = { -- Inventor Blammo
		questID = 37367,
	},
	[86577] = { -- Horgg
		questID = 37365,
	},
	[86579] = { -- Blademaster Ro'gor
		questID = 37368,
	},
	[86582] = { -- Morgo Kain
		questID = 37364,
	},
	[86689] = { -- Sneevel
		questID = 36880,
	},
	[86724] = { -- Hermit Palefur
		questID = 36887,
	},
	[86729] = { -- Direhoof
		isTameable = true,
	},
	[86732] = { -- Bergruu
		isTameable = true,
	},
	[86750] = { -- Thek'talon
		isTameable = true,
	},
	[86774] = { -- Aogexon
		isTameable = true,
	},
	[86835] = { -- Xelganak
		isTameable = true,
	},
	[86959] = { -- Karosh Blackwind
		questID = 37399,
	},
	[86978] = { -- Gaze
		questID = 36943,
	},
	[87019] = { -- Gluttonous Giant
		questID = 37390,
	},
	[87026] = { -- Mecha Plunderer
		questID = 37391,
	},
	[87027] = { -- Shadow Hulk
		questID = 37392,
	},
	[87029] = { -- Giga Sentinel
		questID = 37393,
	},
	[87234] = { -- Brutag Grimblade
		questID = 37400,
	},
	[87239] = { -- Krahl Deadeye
		questID = 37473,
	},
	[87344] = { -- Gortag Steelgrip
		questID = 37472,
	},
	[87348] = { -- Hoarfrost
		questID = 37382,
	},
	[87351] = { -- Mother of Goren
		questID = 37381,
	},
	[87352] = { -- Gibblette the Cowardly
		questID = 37380,
		vignetteName = "Giblette the Cowardly",
	},
	[87356] = { -- Vrok the Ancient
		questID = 37379,
	},
	[87357] = { -- Valkor
		questID = 37378,
	},
	[87362] = { -- Gibby
		isTameable = true,
	},
	[87597] = { -- Bombardier Gu'gok
		questID = 37339,
	},
	[87600] = { -- Jaluk the Pacifist
		questID = 37556,
	},
	[87622] = { -- Ogom the Mangler
		questID = 37402,
	},
	[87666] = { -- Mu'gra
		isTameable = true,
	},
	[87668] = { -- Orumo the Observer
		questID = 37344,
	},
	[87788] = { -- Durg Spinecrusher
		questID = 37395,
	},
	[87837] = { -- Bonebreaker
		questID = 37396,
	},
	[87846] = { -- Pit Slayer
		questID = 37397,
	},
	[88043] = { -- Avatar of Socrethar
		questID = 37338,
	},
	[88071] = { -- Strategist Ankor
		questID = 37337,
	},
	[88208] = { -- Pit Beast
		questID = 37637,
	},
	[88210] = { -- Krud the Eviscerator
		questID = 37398,
	},
	[88436] = { -- Vigilant Paarthos
		questID = 37350,
	},
	[88494] = { -- Legion Vanguard
		questID = 37342,
	},
	[88580] = { -- Firestarter Grash
		questID = 37373,
	},
	[88582] = { -- Swift Onyx Flayer
		questID = 37374,
	},
	[88583] = { -- Grove Warden Yal
		questID = 37375,
	},
	[88586] = { -- Mogamago
		isTameable = true,
		questID = 37376,
	},
	[88672] = { -- Hunter Bal'ra
		questID = 37377,
	},
	[88951] = { -- Vileclaw
		isTameable = true,
	},
	[89016] = { -- Ravyn-Drath
		questID = 37537,
	},
	[89650] = { -- Valiyaka the Stormbringer
		questID = 37726,
	},
	[89675] = { -- Commander Org'mok
		questID = 38749,
	},
	[89816] = { -- Golza the Iron Fin
		questID = 37820,
		vignetteName = "Horn of the Siren",
	},
	[89846] = { -- Captain Volo'ren
		questID = 37821,
	},
	[89850] = { -- The Oracle
		questID = 37822,
	},
	[89865] = { -- Mrrgrl the Tide Reaver
		questID = 37823,
	},
	[89884] = { -- Flog the Captain-Eater
		questID = 37824,
	},
	[90024] = { -- Sergeant Mor'grak
		questID = 37953,
	},
	[90057] = { -- Daggerbeak
		questID = 37869,
	},
	[90094] = { -- Harbormaster Korak
		questID = 39046,
	},
	[90122] = { -- Zoug the Heavy
		questID = 39045,
		vignetteName = "Zoug",
	},
	[90139] = { -- Inquisitor Ernstenbok
		questID = 37908,
	},
	[90164] = { -- Warbringer Mox'na
		questID = 37909,
		vignetteName = "Seek & Destroy Squad",
	},
	[90173] = { -- Arcana Stalker
		questID = 37909,
		vignetteName = "Seek & Destroy Squad",
	},
	[90244] = { -- Arcavellus
		questID = 37932,
	},
	[90429] = { -- Imp-Master Valessa
		questID = 38026,
	},
	[90434] = { -- Ceraxas
		questID = 38031,
	},
	[90437] = { -- Jax'zor
		questID = 38030,
		vignetteName = "Houndmaster Jax'zor",
	},
	[90438] = { -- Lady Oran
		questID = 38029,
	},
	[90442] = { -- Mistress Thavra
		questID = 38032,
	},
	[90505] = { -- Syphonus
		questID = 37989,
		vignetteName = "Syphonus & Leodrath",
	},
	[90519] = { -- Cindral the Wildfire
		questID = 37990,
		vignetteName = "Cindral",
	},
	[90777] = { -- High Priest Ikzan
		questID = 38028,
	},
	[90782] = { -- Rasthe
		questID = 38034,
	},
	[90803] = { -- Infernal Lord
		questID = 38037,
		vignetteName = "Cache of Infernals",
	},
	[90884] = { -- Bilkor the Thrower
		questID = 38262,
	},
	[90885] = { -- Rogond the Tracker
		questID = 38263,
		vignetteName = "Rogond",
	},
	[90887] = { -- Dorg the Bloody
		questID = 38265,
		vignetteName = "Dorg",
	},
	[90888] = { -- Drivnul
		questID = 38264,
	},
	[90901] = { -- Pridelord Meowl
		questID = 38061,
	},
	[90936] = { -- Bloodhunter Zulk
		questID = 38266,
		vignetteName = "Zulk",
	},
	[91009] = { -- Putre'thar
		questID = 38457,
	},
	[91087] = { -- Zeter'el
		questID = 38207,
	},
	[91093] = { -- Bramblefell
		questID = 38209,
	},
	[91098] = { -- Felspark
		questID = 38211,
	},
	[91100] = { -- Brogozog
		questID = 38212,
	},
	[91113] = { -- Tide Behemoth
		questID = 38217,
	},
	[91114] = { -- Tide Behemoth
		questID = 38217,
	},
	[91115] = { -- Tide Behemoth
		questID = 38217,
	},
	[91187] = { -- Beacher
		questID = 38238,
	},
	[91227] = { -- Remnant of the Blood Moon
		questID = 39159,
		vignetteName = "Blood Moon Boss",
	},
	[91232] = { -- Commander Krag'goth
		questID = 38746,
		vignetteName = "Iron Front Captain 1",
	},
	[91243] = { -- Tho'gar Gorefist
		questID = 38747,
		vignetteName = "Iron Front Captain 2",
	},
	[91374] = { -- Podlord Wakkawam
		questID = 38282,
		vignetteName = "Wakkawam",
	},
	[91529] = { -- Glimar Ironfist
		questID = 38333,
	},
	[91579] = { -- Doomlord Kazrok
		questID = 38352,
	},
	[91695] = { -- Grand Warlock Nethekurse
		questID = 38400,
	},
	[91727] = { -- Executor Riloth
		questID = 38411,
	},
	[91795] = { -- Stormwing Matriarch
		questID = 38423,
		vignetteName = "Stormdrake Matriarch",
	},
	[91803] = { -- Fathnyr
		questID = 38425,
	},
	[91871] = { -- Argosh the Destroyer
		questID = 38430,
	},
	[91874] = { -- Bladesquall
		questID = 38431,
	},
	[91892] = { -- Thane Irglov the Merciless
		questID = 38424,
		vignetteName = "Thane's Mead Hall",
	},
	[92040] = { -- Fenri
		questID = 38461,
	},
	[92117] = { -- Gorebeak
		isTameable = true,
		questID = 38468,
	},
	[92152] = { -- Whitewater Typhoon
		questID = 38472,
	},
	[92180] = { -- Seersei
		questID = 38479,
	},
	[92197] = { -- Relgor
		questID = 38496,
		vignetteName = "BH Master Scout",
	},
	[92274] = { -- Painmistress Selora
		questID = 38557,
		vignetteName = "Invasion Point: Devastation",
	},
	[92408] = { -- Xanzith the Everlasting
		questID = 38579,
	},
	[92411] = { -- Overlord Ma'gruth
		questID = 38580,
	},
	[92429] = { -- Broodlord Ixkor
		isTameable = true,
		questID = 38589,
		vignetteName = "Ravager Broodlord",
	},
	[92451] = { -- Varyx the Damned
		questID = 37937,
	},
	[92465] = { -- The Blackfang
		questID = 38597,
		vignetteName = "Panther Saberon Boss",
	},
	[92495] = { -- Soulslicer
		questID = 38600,
		vignetteName = "Fel Saberon Shaman",
	},
	[92508] = { -- Gloomtalon
		questID = 38604,
		vignetteName = "Saberon Shaman",
	},
	[92517] = { -- Krell the Serene
		questID = 38605,
		vignetteName = "Saberon Blademaster",
	},
	[92552] = { -- Belgork
		questID = 38609,
		vignetteName = "Iron Tunnel Foreman",
	},
	[92574] = { -- Thromma the Gutslicer
		questID = 38620,
		vignetteName = "Pale Assassin",
	},
	[92590] = { -- Hook
		factionGroup = "Horde",
		questID = 38625,
		vignetteName = "Hook & Sinker",
	},
	[92591] = { -- Sinker
		factionGroup = "Horde",
		questID = 38625,
		vignetteName = "Hook & Sinker",
	},
	[92599] = { -- Bloodstalker Alpha
		isTameable = true,
		questID = 38626,
		vignetteName = "Worg Pack",
	},
	[92604] = { -- Champion Elodie
		factionGroup = "Alliance",
		questID = 38627,
		vignetteName = "Worgen Stalkers",
	},
	[92606] = { -- Sylissa
		questID = 38628,
		vignetteName = "Giant Python",
	},
	[92609] = { -- Tracker Jack
		factionGroup = "Alliance",
		questID = 38627,
		vignetteName = "Worgen Stalkers",
	},
	[92611] = { -- Ambusher Daggerfang
		factionGroup = "Alliance",
	},
	[92613] = { -- Priestess Liza
		factionGroup = "Alliance",
		questID = 38627,
		vignetteName = "Worgen Stalkers",
	},
	[92626] = { -- Deathguard Adams
		factionGroup = "Horde",
		questID = 38630,
		vignetteName = "Forsaken Deathsquad",
	},
	[92627] = { -- Rendrak
		isTameable = true,
		questID = 38631,
		vignetteName = "Alpha Bat",
	},
	[92631] = { -- Dark Ranger Jess
		factionGroup = "Horde",
		questID = 38630,
		vignetteName = "Forsaken Deathsquad",
	},
	[92634] = { -- Apothecary Perez
		factionGroup = "Horde",
		questID = 38630,
		vignetteName = "Forsaken Deathsquad",
	},
	[92636] = { -- The Night Haunter
		questID = 38632,
		vignetteName = "Night Haunter",
	},
	[92645] = { -- The Night Haunter
		questID = 38632,
	},
	[92647] = { -- Felsmith Damorka
		questID = 38634,
	},
	[92657] = { -- Bleeding Hollow Horror
		questID = 38696,
	},
	[92682] = { -- Helmouth Raider
		questID = 38642,
		vignetteName = "Helmouth Raiders",
	},
	[92685] = { -- Captain Brvet
		questID = 38642,
		vignetteName = "Helmouth Raiders",
	},
	[92694] = { -- The Goreclaw
		isTameable = true,
		questID = 38654,
		vignetteName = "Giant Raptor",
	},
	[92703] = { -- Helmouth Raider
		questID = 38642,
		vignetteName = "Helmouth Raiders",
	},
	[92751] = { -- Ivory Sentinel
		questID = 39031,
	},
	[92763] = { -- The Nameless King
		questID = 38685,
	},
	[92887] = { -- Steelsnout
		isTameable = true,
		questID = 38700,
	},
	[92941] = { -- Gorabosh
		questID = 38709,
		vignetteName = "Cave Keeper",
	},
	[92951] = { -- Houndmaster Ely
		factionGroup = "Alliance",
		questID = 38712,
	},
	[92965] = { -- Darkshade
		questID = 38767,
	},
	[92977] = { -- The Iron Houndmaster
		questID = 38751,
		vignetteName = "Iron Houndmaster",
	},
	[93001] = { -- Szirek the Twisted
		questID = 38752,
		vignetteName = "Szirek",
	},
	[93002] = { -- Magwia
		isTameable = true,
		questID = 38726,
	},
	[93028] = { -- Driss Vile
		questID = 38736,
		vignetteName = "IH Elite Sniper",
	},
	[93030] = { -- Ironbranch
		questID = 40080,
	},
	[93057] = { -- Grannok
		questID = 38750,
		vignetteName = "Iron Front Captain 3",
	},
	[93076] = { -- Captain Ironbeard
		questID = 38756,
		vignetteName = "Dead Orc Captain",
	},
	[93125] = { -- Glub'glok
		questID = 38764,
		vignetteName = "Murktide Alpha",
	},
	[93166] = { -- Tiptog the Lost
		questID = 38774,
		vignetteName = "Lost Ettin",
	},
	[93168] = { -- Felbore
		questID = 38775,
	},
	[93205] = { -- Thondrax
		questID = 38780,
	},
	[93236] = { -- Shadowthrash
		isTameable = true,
		questID = 38812,
	},
	[93264] = { -- Captain Grok'mar
		questID = 38820,
	},
	[93279] = { -- Kris'kar the Unredeemed
		questID = 38825,
	},
	[93371] = { -- Mordvigbjorn
		questID = 38837,
	},
	[93401] = { -- Urgev the Flayer
		questID = 38847,
	},
	[93654] = { -- Skul'vrax
		questID = 38887,
	},
	[93679] = { -- Gathenak the Subjugator
		questID = 44070,
	},
	[93686] = { -- Jinikki the Puncturer
		questID = 38889,
		vignetteName = "Shivering Ashmaw Cub",
	},
	[93758] = { -- Antydas Nightcaller
		questID = 38900,
	},
	[94313] = { -- Daniel "Boomer" Vorick
		factionGroup = "Alliance",
	},
	[94347] = { -- Dread-Rider Cortis
		questID = 43343,
	},
	[94413] = { -- Isel the Hammer
		questID = 39120,
	},
	[94414] = { -- Kiranys Duskwhisper
		questID = 39121,
	},
	[94485] = { -- Pollous the Fetid
		questID = 39130,
		vignetteName = "Purging the River",
	},
	[94877] = { -- Brogrul the Mighty
		questID = 39235,
	},
	[95044] = { -- Terrorfist
		questID = 39288,
	},
	[95053] = { -- Deathtalon
		questID = 39287,
	},
	[95054] = { -- Vengeance
		questID = 39290,
	},
	[95056] = { -- Doomroller
		questID = 39289,
	},
	[95123] = { -- Grelda the Hag
		questID = 40126,
	},
	[95204] = { -- Oubdob da Smasher
		questID = 39435,
	},
	[95221] = { -- Mad Henryk
		questID = 39357,
	},
	[95318] = { -- Perrexx
		questID = 39596,
		vignetteName = "Perrexx the Corruptor",
	},
	[95872] = { -- Skullhat
		questID = 39465,
	},
	[96323] = { -- Arachnis
		questID = 39617,
	},
	[96410] = { -- Majestic Elderhorn
		isTameable = true,
		questID = 39646,
	},
	[96590] = { -- Gurbog da Basher
		questID = 40347,
	},
	[96621] = { -- Mellok, Son of Torok
		questID = 40242,
	},
	[97093] = { -- Shara Felbreath
		questID = 39762,
	},
	[97102] = { -- Ram'Pag
		questID = 39766,
	},
	[97203] = { -- Tenpak Flametotem
		questID = 39782,
	},
	[97220] = { -- Arru
		isTameable = true,
		questID = 39784,
		vignetteName = "Beastmaster Pao'lek",
	},
	[97326] = { -- Hartli the Snatcher
		questID = 39802,
	},
	[97345] = { -- Crawshuk the Hungry
		questID = 39806,
	},
	[97449] = { -- Bristlemaul
		isTameable = true,
		questID = 40405,
	},
	[97504] = { -- Wraithtalon
		questID = 39856,
	},
	[97517] = { -- Dreadbog
		questID = 39858,
	},
	[97593] = { -- Mynta Talonscreech
		questID = 39866,
	},
	[97630] = { -- Soulthirster
		questID = 39870,
	},
	[97653] = { -- Taurson
		questID = 39872,
		vignetteName = "The Beastly Boxer",
	},
	[97793] = { -- Flamescale
		questID = 39963,
		vignetteName = "Abandoned Fishing Pole",
	},
	[97928] = { -- Tamed Coralback
		isTameable = true,
	},
	[97933] = { -- Crab Rider Grmlrml
		questID = 39994,
	},
	[98024] = { -- Luggut the Eggeater
		questID = 40406,
	},
	[98188] = { -- Egyl the Enduring
		questID = 40068,
	},
	[98198] = { -- Rukdug
		questID = 40075,
	},
	[98199] = { -- Pugg
		questID = 40073,
	},
	[98200] = { -- Guk
		questID = 40074,
	},
	[98241] = { -- Lyrath Moonfeather
		questID = 40079,
	},
	[98268] = { -- Tarben
		questID = 40081,
	},
	[98283] = { -- Drakum
		questID = 40105,
	},
	[98284] = { -- Gondar
		questID = 40106,
	},
	[98285] = { -- Smashum Grabb
		questID = 40104,
	},
	[98299] = { -- Bodash the Hoarder
		questID = 40084,
	},
	[98311] = { -- Mrrklr
		questID = 40096,
	},
	[98408] = { -- Fel Overseer Mudlump
		questID = 40107,
	},
	[98421] = { -- Kottr Vondyr
		questID = 40109,
	},
	[98503] = { -- Grrvrgull the Conqueror
		questID = 40113,
	},
	[98890] = { -- Slumber
		isTameable = true,
		questID = 40175,
	},
	[99610] = { -- Garvrulg
		questID = 40897,
	},
	[99792] = { -- Elfbane
		questID = 41319,
	},
	[100230] = { -- "Sure-Shot" Arnie
		questID = 40413,
		vignetteName = "Amateur Hunters",
	},
	[100231] = { -- Dargok Thunderuin
		questID = 40413,
		vignetteName = "Amateur Hunters",
	},
	[100232] = { -- Ryael Dawndrifter
		questID = 40413,
		vignetteName = "Amateur Hunters",
	},
	[100302] = { -- Puck
		questID = 40423,
	},
	[100303] = { -- Zenobia
		questID = 40423,
	},
	[100495] = { -- Devouring Darkness
		questID = 40414,
	},
	[100864] = { -- Cora'kar
		questID = 41135,
	},
	[101077] = { -- Sekhan
		isTameable = true,
		questID = 40681,
	},
	[101649] = { -- Frostshard
		questID = 40773,
	},
	[102303] = { -- Lieutenant Strathmar
		questID = 40905,
	},
	[102863] = { -- Bruiser
		isTameable = true,
	},
	[103183] = { -- Rok'nash
		questID = 40680,
	},
	[103214] = { -- Har'kess the Insatiable
		questID = 41136,
	},
	[103223] = { -- Hertha Grimdottir
		questID = 43993,
	},
	[103575] = { -- Reef Lord Raj'his
		questID = 44003,
	},
	[103785] = { -- Well-Fed Bear
		isTameable = true,
	},
	[103787] = { -- Baconlisk
		isTameable = true,
	},
	[103827] = { -- King Morgalash
		questID = 41786,
		vignetteName = "Sea Giant King",
	},
	[103841] = { -- Shadowquill
		isTameable = true,
		questID = 43996,
	},
	[105547] = { -- Rauren
		questID = 43484,
	},
	[105938] = { -- Felwing
		questID = 42069,
	},
	[106351] = { -- Artificer Lothaire
		questID = 43717,
	},
	[106526] = { -- Lady Rivantas
		questID = 44675,
	},
	[106532] = { -- Inquisitor Volitix
		questID = 44569,
	},
	[106990] = { -- Chief Bitterbrine
		questID = 42221,
	},
	[107105] = { -- Broodmother Lizax
		questID = 44670,
	},
	[107113] = { -- Vorthax
		questID = 42280,
	},
	[107127] = { -- Brawlgoth
		questID = 42450,
	},
	[107136] = { -- Houndmaster Stroxis
		questID = 42286,
	},
	[107169] = { -- Horux
		questID = 42286,
	},
	[107170] = { -- Zorux
		questID = 42286,
	},
	[107269] = { -- Inquisitor Tivos
		questID = 42376,
	},
	[107327] = { -- Bilebrain
		questID = 42417,
	},
	[107487] = { -- Starbuck
		isTameable = true,
		questID = 42437,
	},
	[107657] = { -- Arcanist Shal'iman
		questID = 42505,
	},
	[107846] = { -- Pinchshank
		isTameable = true,
		questID = 43968,
	},
	[107926] = { -- Hannval the Butcher
		questID = 42591,
	},
	[108255] = { -- Coura, Mistress of Arcana
		questID = 42699,
		vignetteName = "Coura, Master of Arcana",
	},
	[108829] = { -- Levantus
		questID = 43192,
	},
	[109054] = { -- Shal'an
		questID = 42831,
	},
	[109163] = { -- Captain Dargun
		questID = 42864,
	},
	[109331] = { -- Calamir
		questID = 43193,
	},
	[109498] = { -- Xaander
		questID = 40423,
	},
	[109500] = { -- Jak
		questID = 40423,
	},
	[109501] = { -- Darkful
		questID = 40423,
	},
	[109504] = { -- Ragemaw
		questID = 44108,
	},
	[109708] = { -- Undergrell Ringleader
		questID = 43176,
		vignetteName = "Undgrell Attack",
	},
	[109954] = { -- Magister Phaedris
		questID = 43348,
	},
	[110024] = { -- Mal'Dreth the Corruptor
		questID = 43351,
	},
	[110340] = { -- Myonix
		isTameable = true,
		questID = 43358,
	},
	[110363] = { -- Roteye
		questID = 43342,
	},
	[110438] = { -- Siegemaster Aedrin
		questID = 43369,
	},
	[110562] = { -- Bahagar
		isTameable = true,
		questID = 43446,
	},
	[110577] = { -- Oreth the Vile
		questID = 43449,
	},
	[110656] = { -- Arcanist Lylandre
		questID = 43481,
	},
	[110726] = { -- Cadraeus
		questID = 43495,
	},
	[110824] = { -- Tideclaw
		isTameable = true,
		questID = 43542,
	},
	[110832] = { -- Gorgroth
		questID = 43992,
	},
	[110870] = { -- Apothecary Faldren
		questID = 43580,
	},
	[110944] = { -- Guardian Thor'el
		questID = 43597,
	},
	[111007] = { -- Randril
		questID = 43603,
	},
	[111197] = { -- Anax
		questID = 43954,
	},
	[111329] = { -- Matron Hagatha
		questID = 43718,
	},
	[111463] = { -- Bulvinkel
		isTameable = true,
	},
	[111649] = { -- Ambassador D'vwinn
		questID = 43794,
	},
	[111651] = { -- Degren
		questID = 43792,
	},
	[111653] = { -- Miasu
		questID = 43793,
	},
	[112497] = { -- Maia the White
		isTameable = true,
		questID = 44072,
	},
	[112636] = { -- Sinister Leyrunner
		questID = 44081,
		vignetteName = "Trecherous Stallions",
	},
	[112637] = { -- Devious Sunrunner
		questID = 44081,
		vignetteName = "Trecherous Stallions",
	},
	[112802] = { -- Mar'tura
		isTameable = true,
		questID = 44124,
	},
	[113368] = { -- Llorian
		questID = 44676,
	},
	[113694] = { -- Pashya
		isTameable = true,
	},
}

private.NPCData = NPCData

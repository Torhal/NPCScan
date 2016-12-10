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
	[3058] = { -- Arra'chea
		isTameable = true,
	},
	[3068] = { -- Mazzranache
		isTameable = true,
	},
	[3253] = { -- Silithid Harvester
		isTameable = true,
	},
	[3398] = { -- Gesharahan
		isTameable = true,
	},
	[3581] = { -- Sewer Beast
		isTameable = true,
	},
	[3652] = { -- Trigore the Lasher
		isTameable = true,
	},
	[3868] = { -- Blood Seeker
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
	[5832] = { -- Thunderstomp
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
	[5935] = { -- Ironeye the Invincible
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
	[6583] = { -- Gruff
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
	[8302] = { -- Deatheye
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
	[13896] = { -- Scalebeard
		isTameable = true,
	},
	[14222] = { -- Araga
		isTameable = true,
	},
	[14223] = { -- Cranky Benj
		isTameable = true,
	},
	[14227] = { -- Hissperak
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
	[16179] = { -- Hyakiss the Lurker
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
	[39186] = { -- Hellgazer
		isTameable = true,
	},
	[45380] = { -- Ashtail
		isTameable = true,
	},
	[45399] = { -- Optimo
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
	[50990] = { -- Nakk the Thunderer
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
	[58768] = { -- Cracklefang
		isTameable = true,
	},
	[63509] = { -- Wulon
		isTameable = true,
	},
	[63510] = { -- Wulon
		isTameable = true,
	},
	[63978] = { -- Kri'chon
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
		questID = 32918, -- Giant-Slayer Kul
	},
	[71721] = { -- Canyon Icemother
		isTameable = true,
		questID = 32941, -- Oasis Icemother
		vignetteName = "Oasis Icemother",
	},
	[72294] = { -- Cindermaw
		questID = 33014, -- Cindermaw
	},
	[72362] = { -- Ku'targ the Voidseer
		questID = 33039, -- The Voidseer
		vignetteName = "The Voidseer",
	},
	[72364] = { -- Gorg'ak the Lava Guzzler
		questID = 33512, -- Lava-Gorged Goren
		vignetteName = "Lava-Gorged Goren",
	},
	[72537] = { -- Leaf-Reader Kurri
		questID = 33055, -- Foreling Worship Circle
		vignetteName = "Leaf-Reader Kurri",
	},
	[72606] = { -- Rockhoof
		isTameable = true,
		questID = 34068, -- Rockhoof
	},
	[72808] = { -- Tsavo'ka
		isTameable = true,
	},
	[73158] = { -- Emerald Gander
		isTameable = true,
	},
	[73160] = { -- Ironfur Steelhorn
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
		questID = 33043, -- Killmaw
	},
	[74613] = { -- Broodmother Reeg'ak
		questID = 33843, -- Broodmother Reeg'ak
	},
	[74971] = { -- Firefury Giant
		questID = 33504, -- Shaman Fire Stone
		vignetteName = "Shaman Fire Stone",
	},
	[75071] = { -- Mother Om'ra
		questID = 33642, -- Mother Om'ra
		vignetteName = "Mother Om'ra",
	},
	[75434] = { -- Windfang Matriarch
		questID = 33038, -- Embaari Defense Crystal
		vignetteName = "Embaari Defense Crystal",
	},
	[75435] = { -- Yggdrel
		questID = 33389, -- Yggdrel the Corrupted
		vignetteName = "Yggdrel",
	},
	[75482] = { -- Veloss
		isTameable = true,
		questID = 33640, -- Veloss
	},
	[75492] = { -- Venomshade
		questID = 33643, -- Venomshade (Plant Hydra)
		vignetteName = "Venomshade (Plant Hydra)",
	},
	[76380] = { -- Gorum
		questID = 33664, -- Gorum
	},
	[76473] = { -- Mother Araneae
		isTameable = true,
		questID = 34726, -- Pale Spider Broodmother
		vignetteName = "Pale Spider Broodmother",
	},
	[76914] = { -- Coldtusk
		isTameable = true,
		questID = 34131, -- Coldtusk
	},
	[76918] = { -- Primalist Mur'og
		questID = 33938, -- Ogre Primalist
		vignetteName = "Ogre Primalist",
	},
	[77085] = { -- Dark Emanation
		questID = 33064, -- Shadowmoon Cultist Ritual
		vignetteName = "Shadowmoon Cultist Ritual",
	},
	[77140] = { -- Amaukwa
		isTameable = true,
		questID = 33061, -- Amaukwa
	},
	[77310] = { -- Mad "King" Sporeon
		questID = 35906, -- Mad "King" Sporeon
		vignetteName = "Mad \"King\" Sporeon",
	},
	[77513] = { -- Coldstomp the Griever
		isTameable = true,
		questID = 34129, -- Coldstomp
		vignetteName = "Coldstomp",
	},
	[77519] = { -- Giantbane
		isTameable = true,
	},
	[77526] = { -- Scout Goreseeker
		questID = 34132, -- Scout Goreseeker
	},
	[77527] = { -- The Beater
		questID = 34133, -- The Beater
	},
	[77529] = { -- Yazheera the Incinerator
		questID = 34135, -- Yazheera the Incinerator
	},
	[77561] = { -- Dr. Gloom
		questID = 34142, -- Dr. Gloom
	},
	[77614] = { -- Frenzied Golem
		questID = 34145, -- Frenzied Animus
		vignetteName = "Frenzied Animus",
	},
	[77620] = { -- Cro Fleshrender
		questID = 34165, -- Cro Fleshrender
	},
	[77626] = { -- Hen-Mother Hami
		isTameable = true,
		questID = 34167, -- Hen-Mother Hami
	},
	[77634] = { -- Taladorantula
		isTameable = true,
		questID = 34171, -- Taladorantula
	},
	[77664] = { -- Aarko
		questID = 34182, -- Aarkos - Looted Treasure
		vignetteName = "Aarkos - Looted Treasure",
	},
	[77715] = { -- Hammertooth
		isTameable = true,
		questID = 34185, -- Hammertooth
	},
	[77719] = { -- Glimmerwing
		isTameable = true,
		questID = 34189, -- Glimmerwing
	},
	[77741] = { -- Ra'kahn
		isTameable = true,
		questID = 34196, -- Ra'kahn
	},
	[77750] = { -- Kaavu the Crimson Claw
		questID = 34199, -- Anchorite's Sojourn
		vignetteName = "Anchorite's Sojourn",
	},
	[77776] = { -- Wandering Vindicator
		questID = 34205, -- Wandering Vindicator - Looted Treasure
		vignetteName = "Wandering Vindicator - Looted Treasure",
	},
	[77784] = { -- Lo'marg Jawcrusher
		questID = 34208, -- Lo'marg Jawcrusher
	},
	[77795] = { -- Echo of Murmur
		questID = 34221, -- Echo of Murmur
		vignetteName = "Echo of Murmur",
	},
	[77828] = { -- Echo of Murmur
		questID = 34220, -- Echo of Murmur
	},
	[78151] = { -- Huntmaster Kuang
		questID = 34130, -- Giantstalker Hunting Party
		vignetteName = "Giantstalker Hunting Party",
	},
	[78161] = { -- Hyperious
		questID = 34862, -- Light the Braziers
		vignetteName = "Light the Braziers",
	},
	[78260] = { -- King Slime
		questID = 37412, -- King Slime
	},
	[78265] = { -- The Bone Crawler
		questID = 34361, -- The Bone Crawler
	},
	[78269] = { -- Gnarljaw
		questID = 37413, -- Gnarljaw
	},
	[78606] = { -- Pale Fishmonger
		questID = 34470, -- Pale Gone Fishin'
		vignetteName = "Pale Gone Fishin'",
	},
	[78621] = { -- Cyclonic Fury
		questID = 34477, -- Cyclonic Fury
	},
	[78710] = { -- Kharazos the Triumphant
		questID = 35219, -- Burning Front
		vignetteName = "Kharazos the Triumphant",
	},
	[78713] = { -- Galzomar
		questID = 35219, -- Burning Front
		vignetteName = "Galzomar",
	},
	[78715] = { -- Sikthiss, Maiden of Slaughter
		questID = 35219, -- Burning Front
		vignetteName = "Sikthiss, Maiden of Slaughter",
	},
	[78867] = { -- Breathless
		questID = 34497, -- Breathless
	},
	[78872] = { -- Klikixx
		isTameable = true,
		questID = 34498, -- Klikixx
		vignetteName = "Klikixx",
	},
	[79024] = { -- Warmaster Blugthol
		questID = 34645, -- Warmaster Blugthol
	},
	[79104] = { -- Ug'lok the Frozen
		questID = 34522, -- Ug'lok the Frozen
	},
	[79145] = { -- Yaga the Scarred
		questID = 34559, -- Yaga the Scarred
	},
	[79334] = { -- No'losh
		isTameable = true,
		questID = 34859, -- No'losh
		vignetteName = "No'losh",
	},
	[79485] = { -- Talonpriest Zorkra
		questID = 34668, -- Talonpriest Zorkra
	},
	[79524] = { -- Hypnocroak
		questID = 35558, -- Hypnocroak
	},
	[79543] = { -- Shirzir
		questID = 34671, -- Shirzir
	},
	[79629] = { -- Stomper Kreego
		questID = 35910, -- Stomper Kreego
		vignetteName = "Stomper Kreego",
	},
	[79725] = { -- Captain Ironbeard
		questID = 34727, -- Sea Lord Torglork
		vignetteName = "Sea Lord Torglork",
	},
	[79938] = { -- Shadowbark
		questID = 36478, -- Spires - Vignette 020 - Shadowbark
	},
	[80057] = { -- Soulfang
		questID = 36128, -- Sabermaw - Saberon Vignette Boss
		vignetteName = "Soulfang",
	},
	[80122] = { -- Gaz'orda
		isTameable = true,
		questID = 34725, -- Sea Hydra
		vignetteName = "Sea Hydra",
	},
	[80190] = { -- Gruuk
		questID = 34825, -- Gruuk
	},
	[80204] = { -- Felbark
		questID = 35018, -- Felbark
	},
	[80235] = { -- Gurun
		questID = 34839, -- Skog
		vignetteName = "Skog",
	},
	[80242] = { -- Chillfang
		isTameable = true,
		questID = 34843, -- Chillfang
	},
	[80312] = { -- Grutush the Pillager
		questID = 34865, -- Skog
	},
	[80370] = { -- Lernaea
		isTameable = true,
		questID = 37408, -- Lernaea
	},
	[80371] = { -- Typhon
		questID = 37405, -- Typhon
	},
	[80372] = { -- Echidna
		isTameable = true,
		questID = 37406, -- Echidna
	},
	[80398] = { -- Keravnos
		isTameable = true,
		questID = 37407, -- Keravnos
	},
	[80471] = { -- Gennadian
		isTameable = true,
		questID = 34929, -- Gennadian
		vignetteName = "Gennadian",
	},
	[80524] = { -- Underseer Bloodmane
		questID = 34945, -- Tracking Flag - Underseer Bloodmane Vignette
	},
	[80614] = { -- Blade-Dancer Aeryx
		questID = 35599, -- Blade-Dancer Aeryx
	},
	[80725] = { -- Sulfurious
		questID = 36394, -- Sulfurious
	},
	[80868] = { -- Glut
		questID = 36204, -- Gorger the Hungry
		vignetteName = "Gorger the Hungry",
	},
	[81001] = { -- Nok-Karosh
		isTameable = true,
	},
	[81038] = { -- Gelgor of the Blue Flame
		questID = 36391, -- The Blue Flame
	},
	[81406] = { -- Bahameye
		questID = 35281, -- Bahameye
	},
	[81639] = { -- Brambleking Fili
		questID = 33383, -- Brambleking Fili
	},
	[82050] = { -- Varasha
		isTameable = true,
		questID = 35334, -- The Egg of Varasha
	},
	[82058] = { -- Depthroot
		questID = 37370, -- Depthroot
	},
	[82085] = { -- Bashiok
		questID = 35335, -- Bashiok
	},
	[82207] = { -- Faebright
		questID = 35725, -- Faebright
		vignetteName = "Faebright",
	},
	[82247] = { -- Nas Dunberlin
		questID = 36129, -- Nas Dunberlin
		vignetteName = "Nas Dunberlin",
	},
	[82268] = { -- Darkmaster Go'vid
		questID = 35448, -- Darkmaster Go'vid
	},
	[82311] = { -- Char the Burning
		questID = 35503, -- Char the Burning
	},
	[82326] = { -- Ba'ruun
		questID = 35731, -- Ba'ruun
		vignetteName = "Ba'ruun",
	},
	[82362] = { -- Morva Soultwister
		questID = 35523, -- Morva Soultwister
	},
	[82374] = { -- Rai'vosh
		questID = 35553, -- Rai'vosh
	},
	[82411] = { -- Darktalon
		questID = 35555, -- Darktalon
	},
	[82415] = { -- Shinri
		questID = 35732, -- Shinri
		vignetteName = "Shinri",
	},
	[82486] = { -- Explorer Nozzand
		questID = 35623, -- Nagrand - Vignette Boss - Explorer Rixak
	},
	[82536] = { -- Gorivax
		questID = 37388, -- Gorivax
	},
	[82614] = { -- Moltnoma
		questID = 37387, -- Moltnoma
	},
	[82616] = { -- Jabberjaw
		isTameable = true,
		questID = 37386, -- Jabberjaw
	},
	[82617] = { -- Slogtusk the Corpse-Eater
		isTameable = true,
		questID = 37385, -- Slogtusk the Corpse Eater
		vignetteName = "Slogtusk",
	},
	[82618] = { -- Tor'goroth
		questID = 37384, -- Tor'goroth
	},
	[82620] = { -- Son of Goramal
		questID = 37383, -- Son of Goramal
	},
	[82676] = { -- Enavra
		questID = 35688, -- Enavra Varandi
		vignetteName = "Enavra Varandi",
	},
	[82742] = { -- Enavra
		questID = 35688, -- Enavra Varandi
		vignetteName = "Enavra Varandi",
	},
	[82755] = { -- Redclaw the Feral
		questID = 35712, -- Nagrand - Vignette Boss 012 - Redclaw the Feral
	},
	[82758] = { -- Greatfeather
		isTameable = true,
		questID = 35714, -- Nagrand - Vignette Boss 001 - Greatfeather
	},
	[82764] = { -- Gar'lua
		questID = 35715, -- Nagrand - Vignette Boss 002 - Gar'lua the Wolfmother
	},
	[82778] = { -- Gnarlhoof the Rabid
		isTameable = true,
		questID = 35717, -- Nagrand - Vignette Boss 015 - Gnarlhoof the Rabid
	},
	[82826] = { -- Berserk T-300 Series Mark II
		questID = 35735, -- Nagrand - Vignette Boss 021 - Berserk Shredder
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
		questID = 35778, -- Nagrand - Vignette Boss 020 - Ancient Blademaster - TSH
	},
	[82912] = { -- Grizzlemaw
		isTameable = true,
		questID = 35784, -- Vignette Boss
	},
	[82920] = { -- Lord Korinak
		questID = 37345, -- Lord Korinak
	},
	[82922] = { -- Xothear, the Destroyer
		questID = 37343, -- Xothear, The Destroyer
		vignetteName = "Xothear, The Destroyer",
	},
	[82930] = { -- Shadowflame Terrorwalker
		questID = 37347, -- Shadowflame Terror
		vignetteName = "Shadowflame Terror",
	},
	[82942] = { -- Lady Demlash
		questID = 37346, -- Lady Demlash
	},
	[82975] = { -- Fangler
		questID = 35836, -- Nagrand - Vignette Boss 008 - The Lunker
	},
	[82988] = { -- Kurlosh Doomfang
		questID = 37348, -- Kurlosh Doomfang
	},
	[82992] = { -- Felfire Consort
		questID = 37341, -- Felfire Consort
	},
	[82998] = { -- Matron of Sin
		questID = 37349, -- Matron of Sin
	},
	[83008] = { -- Haakun the All-Consuming
		questID = 37312, -- Haakun, The All-Consuming
		vignetteName = "Haakun, The All-Consuming",
	},
	[83019] = { -- Gug'tol
		questID = 37340, -- Gug'tol
	},
	[83385] = { -- Voidseer Kalurg
		questID = 35847, -- Voidseer Kalurg
	},
	[83401] = { -- Netherspawn
		questID = 35865, -- Nagrand - Vignette Boss 018 - Void Ooze
	},
	[83409] = { -- Ophiis
		questID = 35875, -- Nagrand - Vignette Boss 024 - Ophiis
	},
	[83428] = { -- Windcaller Korast
		questID = 35877, -- Nagrand - Vignette Boss 005 - Windcaller Korast
	},
	[83483] = { -- Flinthide
		isTameable = true,
		questID = 35893, -- Nagrand - Vignette Boss 011 - Flinthide
	},
	[83509] = { -- Gorepetal
		questID = 35898, -- Nagrand - Vignette Boss 005 - Gorepetal
	},
	[83522] = { -- Hive Queen Skrikka
		isTameable = true,
		questID = 35908, -- Stoneshard Broodmother
		vignetteName = "Stoneshard Broodmother",
	},
	[83526] = { -- Ru'klaa
		questID = 35900, -- Nagrand - Vignette Boss 013 - Ru'klaa
	},
	[83542] = { -- Sean Whitesea
		questID = 35912, -- Nagrand - Vignette Boss 017 - Swindler Whitesea
	},
	[83553] = { -- Insha'tar
		isTameable = true,
		questID = 35909, -- Insha'tar
	},
	[83591] = { -- Tura'aka
		isTameable = true,
		questID = 35920, -- Nagrand - Vignette Boss 019 - Tura'aka
	},
	[83603] = { -- Hunter Blacktooth
		questID = 35923, -- Nagrand - Vignette Boss 006 - Hunter Blacktooth
	},
	[83634] = { -- Scout Pokhar
		questID = 35931, -- Nagrand - Vignette Boss 016 - Warsong Scout
	},
	[83643] = { -- Malroc Stonesunder
		questID = 35932, -- Nagrand - Vignette Boss 026 - Warsong Tactician
	},
	[83680] = { -- Outrider Duretha
		questID = 35943, -- Nagrand - Vignette Boss 026 - Duretha
	},
	[83990] = { -- Solar Magnifier
		questID = 37394, -- Solar Magnifier
	},
	[84263] = { -- Graveltooth
		questID = 36159, -- Nagrand - Vignette Boss 004 - Graveltooth
	},
	[84374] = { -- Kaga the Ironbender
		questID = 37404, -- Kaga the Ironbender
	},
	[84376] = { -- Earthshaker Holar
		questID = 37403, -- Earthshaker Holar
	},
	[84378] = { -- Ak'ox the Slaughterer
		questID = 37525, -- Ak'ox the Slaughterer
	},
	[84392] = { -- Ragore Driftstalker
		questID = 37401, -- Ragore Driftstalker
	},
	[84406] = { -- Mandrakor
		questID = 36178, -- Mandrakor the Night Hunter
		vignetteName = "Mandrakor the Night Hunter",
	},
	[84417] = { -- Mutafen
		questID = 36396, -- Spires - Vignette Boss - Mutafen
	},
	[84431] = { -- Greldrok the Cunning
		questID = 36186, -- Greldrok the Cunning
	},
	[84435] = { -- Mr. Pinchy Sr.
		questID = 36229, -- Nagrand - Vignette Boss - Mr. Pinchy Sr.
	},
	[84775] = { -- Tesska the Broken
		questID = 36254, -- Spires - Vignette Boss 002 - Tesska the Broken
	},
	[84805] = { -- Stonespite
		isTameable = true,
		questID = 36265, -- Spires - Vignette Boss 001 - Stonespite
	},
	[84807] = { -- Durkath Steelmaw
		questID = 36267, -- Spires - Vignette 005 - Durkath Steelmaw
	},
	[84810] = { -- Kalos the Bloodbathed
		questID = 36268, -- Spires - Vignette Boss 007 - Kalos the Bloodbathed
	},
	[84833] = { -- Sangrikass
		questID = 36276, -- Spires - Vignette Boss 008 - Spawn of Sethe
	},
	[84836] = { -- Talonbreaker
		questID = 36278, -- Spires - Vignette Boss 009 - Talonbreaker
	},
	[84838] = { -- Poisonmaster Bortusk
		questID = 36279, -- Spires - Vignette 010 - Poisonmaster Bortusk
	},
	[84856] = { -- Blightglow
		isTameable = true,
		questID = 36283, -- Spires - Vignette Boss 011 - Blightglow
	},
	[84872] = { -- Oskiira the Vengeful
		questID = 36288, -- Spires - Vignette Boss 012 - Oskiira
	},
	[84887] = { -- Betsi Boombasket
		questID = 36291, -- Spires - Vignette Boss 014 -  Betsi Boombasket
	},
	[84890] = { -- Festerbloom
		questID = 36297, -- Spires - Vignette Boss 016 - Festerbloom
	},
	[84893] = { -- Goregore
		isTameable = true,
	},
	[84911] = { -- Demidos
		questID = 37351, -- Demidos
	},
	[84912] = { -- Sunderthorn
		isTameable = true,
		questID = 36298, -- Spires - Vignette Boss 017 - Sunderthorn
	},
	[84925] = { -- Quartermaster Hershak
		questID = 37352, -- Quartermaster Hershak
	},
	[84951] = { -- Gobblefin
		questID = 36305, -- Spires - Vignette Boss 023 - Gobblefin
	},
	[84955] = { -- Jiasska the Sporegorger
		isTameable = true,
		questID = 36306, -- Spires - Vignette Boss 024 - Jiasska the Sporegorger
	},
	[85001] = { -- Master Sergeant Milgra
		questID = 37353, -- Master Sergeant Milgra
	},
	[85026] = { -- Soul-Twister Torek
		questID = 37358, -- Soul-Twister Torek
	},
	[85029] = { -- Shadowspeaker Niir
		questID = 37354, -- Shadowspeaker Niir
	},
	[85036] = { -- Formless Nightmare
		questID = 37360, -- Formless Nightmare
	},
	[85037] = { -- Kenos the Unraveler
		questID = 37361, -- Kenos the Unraveller
		vignetteName = "Kenos the Unraveller",
	},
	[85078] = { -- Voidreaver Urnae
		questID = 37359, -- Voidreaver Urnae
	},
	[85121] = { -- Lady Temptessa
		questID = 37355, -- Lady Temptessa
	},
	[85250] = { -- Fossilwood the Petrified
		questID = 36387, -- Fossil the Petrified
	},
	[85264] = { -- Rolkor
		questID = 36393, -- Rolkor the Ironbreaker
	},
	[85451] = { -- Malgosh Shadowkeeper
		questID = 37357, -- Malgosh Shadowkeeper
	},
	[85504] = { -- Rotcap
		questID = 36470, -- Spires - Vignette Boss 006 - Rotcap
	},
	[85520] = { -- Swarmleaf
		questID = 36472, -- Spires - Vignette Boss 028 - Wasp Ancient
	},
	[85555] = { -- Nagidna
		questID = 37409, -- Nagidna
	},
	[85568] = { -- Avalanche
		questID = 37410, -- Avalanche
	},
	[85572] = { -- Grrbrrgle
		questID = 36919, -- Talador - Shore Vignette - Murloc Boss
	},
	[85837] = { -- Slivermaw
		questID = 37411, -- Slivermaw
	},
	[85907] = { -- Berthora
		isTameable = true,
		questID = 36597, -- Berthora
	},
	[85970] = { -- Riptar
		isTameable = true,
		questID = 36600, -- Riptar
	},
	[86137] = { -- Sunclaw
		questID = 36656, -- Sunclaw
	},
	[86213] = { -- Aqualir
		questID = 37356, -- Aqualir
	},
	[86257] = { -- Basten
		questID = 37369, -- Protectors of the Grove
		vignetteName = "Protectors of the Grove",
	},
	[86258] = { -- Nultra
		questID = 37369, -- Protectors of the Grove
		vignetteName = "Protectors of the Grove",
	},
	[86259] = { -- Valstil
		questID = 37369, -- Protectors of the Grove
		vignetteName = "Protectors of the Grove",
	},
	[86266] = { -- Venolasix
		isTameable = true,
		questID = 37372, -- Venolasix
	},
	[86268] = { -- Alkali
		questID = 37371, -- Alkali
	},
	[86410] = { -- Sylldross
		questID = 36794, -- Sylldross
	},
	[86520] = { -- Stompalupagus
		isTameable = true,
		questID = 36837, -- Stompalupagus
	},
	[86549] = { -- Steeltusk
		questID = 36858, -- Steeltusk
	},
	[86562] = { -- Maniacal Madgard
		questID = 37363, -- Maniacal Madgard
	},
	[86566] = { -- Defector Dazgo
		questID = 37362, -- Defector Dazgo
	},
	[86571] = { -- Durp the Hated
		questID = 37366, -- Durp the Hated
	},
	[86574] = { -- Inventor Blammo
		questID = 37367, -- Inventor Blammo
	},
	[86577] = { -- Horgg
		questID = 37365, -- Horgg
	},
	[86579] = { -- Blademaster Ro'gor
		questID = 37368, -- Blademaster Ro'gor
	},
	[86582] = { -- Morgo Kain
		questID = 37364, -- Morgo Kain
	},
	[86621] = { -- Morphed Sentient
		questID = 37493, -- Morphed Sentient
	},
	[86689] = { -- Sneevel
		questID = 36880, -- Sneevel
	},
	[86724] = { -- Hermit Palefur
		questID = 36887, -- Spires - Vignette 029 - Hermit Palefur
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
		questID = 37399, -- Karosh Blackwind
	},
	[86978] = { -- Gaze
		questID = 36943, -- Spires - Vignette 030 - Gaze
	},
	[87019] = { -- Gluttonous Giant
		questID = 37390, -- Gluttonous Giant
	},
	[87026] = { -- Mecha Plunderer
		questID = 37391, -- Mecha Plunderer
	},
	[87027] = { -- Shadow Hulk
		questID = 37392, -- Shadow Hulk
	},
	[87029] = { -- Giga Sentinel
		questID = 37393, -- Giga Sentinel
	},
	[87234] = { -- Brutag Grimblade
		questID = 37400, -- Brutag Grimblade
	},
	[87239] = { -- Krahl Deadeye
		questID = 37473, -- Krahl Deathwind
		vignetteName = "Krahl Deathwind",
	},
	[87344] = { -- Gortag Steelgrip
		questID = 37472, -- Gortag Steelgrip
	},
	[87348] = { -- Hoarfrost
		questID = 37382, -- Hoarfrost
	},
	[87351] = { -- Mother of Goren
		questID = 37381, -- Mother of Goren
	},
	[87352] = { -- Gibblette the Cowardly
		questID = 37380, -- Giblette the Cowardly
		vignetteName = "Giblette the Cowardly",
	},
	[87356] = { -- Vrok the Ancient
		questID = 37379, -- Vrok the Ancient
	},
	[87357] = { -- Valkor
		questID = 37378, -- Valkor
	},
	[87362] = { -- Gibby
		isTameable = true,
	},
	[87597] = { -- Bombardier Gu'gok
		questID = 37339, -- Bombardier Gu'gok
	},
	[87600] = { -- Jaluk the Pacifist
		questID = 37556, -- Jaluk the Pacifist
		vignetteName = "Jaluk the Pacifist",
	},
	[87622] = { -- Ogom the Mangler
		questID = 37402, -- Ogom the Mangler
	},
	[87666] = { -- Mu'gra
		isTameable = true,
	},
	[87668] = { -- Orumo the Observer
		questID = 37344, -- Orumo the Observer
	},
	[87788] = { -- Durg Spinecrusher
		questID = 37395, -- Durg Spinecrusher
	},
	[87837] = { -- Bonebreaker
		questID = 37396, -- Bonebreaker
	},
	[87846] = { -- Pit Slayer
		questID = 37397, -- Pit-Slayer
		vignetteName = "Pit-Slayer",
	},
	[88043] = { -- Avatar of Socrethar
		questID = 37338, -- Avatar of Sothrecar
		vignetteName = "Avatar of Sothrecar",
	},
	[88071] = { -- Strategist Ankor
		questID = 37337, -- Strategist Ankor
	},
	[88208] = { -- Pit Beast
		questID = 37637, -- Pit Beast
	},
	[88210] = { -- Krud the Eviscerator
		questID = 37398, -- Krud the Eviscerator
	},
	[88436] = { -- Vigilant Paarthos
		questID = 37350, -- Vigilant Paarthos
	},
	[88494] = { -- Legion Vanguard
		questID = 37342, -- Legion Vanguard
	},
	[88580] = { -- Firestarter Grash
		questID = 37373, -- Firestarter Grash
	},
	[88582] = { -- Swift Onyx Flayer
		questID = 37374, -- Swift Onyx Flayer
	},
	[88583] = { -- Grove Warden Yal
		questID = 37375, -- Grove Warden Yal
	},
	[88586] = { -- Mogamago
		isTameable = true,
		questID = 37376, -- Mogamago
	},
	[88672] = { -- Hunter Bal'ra
		questID = 37377, -- Hunter Bal'ra
	},
	[88951] = { -- Vileclaw
		isTameable = true,
	},
	[89016] = { -- Ravyn-Drath
		questID = 37537, -- Ravyn-Drath
		vignetteName = "Ravyn-Drath",
	},
	[89650] = { -- Valiyaka the Stormbringer
		questID = 37726, -- Valiyaka the Stormbringer
		vignetteName = "Valiyaka the Stormbringer",
	},
	[89675] = { -- Commander Org'mok
		questID = 38749, -- Commander Org'mok
	},
	[89816] = { -- Golza the Iron Fin
		questID = 37820, -- Hatecoil Reinforcements
		vignetteName = "Horn of the Siren",
	},
	[89846] = { -- Captain Volo'ren
		questID = 37821, -- Captain Volo'ren
		vignetteName = "Captain Volo'ren",
	},
	[89850] = { -- The Oracle
		questID = 37822, -- The Oracle
		vignetteName = "The Oracle",
	},
	[89865] = { -- Mrrgrl the Tide Reaver
		questID = 37823, -- Mrrgrl the Tide Reaver
		vignetteName = "Mrrgrl the Tide Reaver",
	},
	[89884] = { -- Flog the Captain-Eater
		questID = 37824, -- Flog the Captain-Eater
		vignetteName = "Flog the Captain-Eater",
	},
	[90024] = { -- Sergeant Mor'grak
		questID = 37953, -- Sergeant Mor'grak
	},
	[90057] = { -- Daggerbeak
		questID = 37869, -- Daggerbeak
		vignetteName = "Daggerbeak",
	},
	[90094] = { -- Harbormaster Korak
		questID = 39046, -- Harbormaster Korak
	},
	[90122] = { -- Zoug the Heavy
		questID = 39045, -- Zoug
		vignetteName = "Zoug",
	},
	[90139] = { -- Inquisitor Ernstenbok
		questID = 37908, -- Inquisitor Ernstenbok
		vignetteName = "Inquisitor Ernstenbok",
	},
	[90164] = { -- Warbringer Mox'na
		questID = 37909, -- Warbringer Mox'na
		vignetteName = "Seek & Destroy Squad",
	},
	[90173] = { -- Arcana Stalker
		questID = 37909, -- Warbringer Mox'na
		vignetteName = "Seek & Destroy Squad",
	},
	[90217] = { -- Normantis the Deposed
		questID = 37928, -- Normantis the Deposed
		vignetteName = "Normantis the Deposed",
	},
	[90244] = { -- Arcavellus
		questID = 37932, -- Unbound Rift
		vignetteName = "Unbound Rift",
	},
	[90429] = { -- Imp-Master Valessa
		questID = 38026, -- Imp-Master Valessa
	},
	[90434] = { -- Ceraxas
		questID = 38031, -- Ceraxas
	},
	[90437] = { -- Jax'zor
		questID = 38030, -- Houndmaster Jax'zor
		vignetteName = "Houndmaster Jax'zor",
	},
	[90438] = { -- Lady Oran
		questID = 38029, -- Lady Oran
	},
	[90442] = { -- Mistress Thavra
		questID = 38032, -- Mistress Thavra
	},
	[90505] = { -- Syphonus
		questID = 37989, -- Syphonus
		vignetteName = "Syphonus & Leodrath",
	},
	[90519] = { -- Cindral the Wildfire
		questID = 37990, -- Cindral
		vignetteName = "Cindral",
	},
	[90777] = { -- High Priest Ikzan
		questID = 38028, -- High Priest Ikzan
	},
	[90782] = { -- Rasthe
		questID = 38034, -- Rasthe
	},
	[90803] = { -- Infernal Lord
		questID = 38037, -- Cache of Infernals
		vignetteName = "Cache of Infernals",
	},
	[90884] = { -- Bilkor the Thrower
		questID = 38262, -- Bilkor the Thrower
	},
	[90885] = { -- Rogond the Tracker
		questID = 38263, -- Rogond
		vignetteName = "Rogond",
	},
	[90887] = { -- Dorg the Bloody
		questID = 38265, -- Dorg
		vignetteName = "Dorg",
	},
	[90888] = { -- Drivnul
		questID = 38264, -- Drivnul
	},
	[90901] = { -- Pridelord Meowl
		questID = 38061, -- Pridelord Meowl
		vignetteName = "Pridelord Meowl",
	},
	[90936] = { -- Bloodhunter Zulk
		questID = 38266, -- Zulk
		vignetteName = "Zulk",
	},
	[91009] = { -- Putre'thar
		questID = 38457, -- Putre'thar
	},
	[91087] = { -- Zeter'el
		questID = 38207, -- Zeter'el
	},
	[91093] = { -- Bramblefell
		questID = 38209, -- Bramblefell
	},
	[91098] = { -- Felspark
		questID = 38211, -- Felspark
	},
	[91100] = { -- Brogozog
		questID = 38212, -- Brogozog
		vignetteName = "Marius & Tehd",
	},
	[91113] = { -- Tide Behemoth
		questID = 38217, -- Tide Behemoth
	},
	[91114] = { -- Tide Behemoth
		questID = 38217, -- Tide Behemoth
	},
	[91115] = { -- Tide Behemoth
		questID = 38217, -- Tide Behemoth
		vignetteName = "Tide Behemoth",
	},
	[91187] = { -- Beacher
		questID = 38238, -- Beacher
		vignetteName = "Beacher",
	},
	[91227] = { -- Remnant of the Blood Moon
		questID = 39159, -- Blood Moon Boss
		vignetteName = "Remnant of the Blood Moon",
	},
	[91232] = { -- Commander Krag'goth
		questID = 38746, -- Iron Front Captain 1
		vignetteName = "Iron Front Captain 1",
	},
	[91243] = { -- Tho'gar Gorefist
		questID = 38747, -- Iron Front Captain 2
		vignetteName = "Iron Front Captain 2",
	},
	[91289] = { -- Cailyn Paledoom
		questID = 38268, -- Darkbane
		vignetteName = "Cailyn Paledoom",
	},
	[91374] = { -- Podlord Wakkawam
		questID = 38282, -- Wakkawam
		vignetteName = "Wakkawam",
	},
	[91529] = { -- Glimar Ironfist
		questID = 38333, -- Drake Wrestler
		vignetteName = "Glimar Ironfist",
	},
	[91579] = { -- Doomlord Kazrok
		questID = 38352, -- Kazrok
		vignetteName = "Marius & Tehd",
	},
	[91695] = { -- Grand Warlock Nethekurse
		questID = 38400, -- Grand Warlock Nethekurse
	},
	[91727] = { -- Executor Riloth
		questID = 38411, -- Executor Riloth
	},
	[91780] = { -- Mother Clacker
		questID = 38422, -- Makrura Wave Event
		vignetteName = "The Blightcaller",
	},
	[91795] = { -- Stormwing Matriarch
		questID = 38423, -- Stormdrake Matriarch
		vignetteName = "Stormwing Matriarch",
	},
	[91803] = { -- Fathnyr
		questID = 38425, -- Fel Thorignir
		vignetteName = "Fathnyr",
	},
	[91871] = { -- Argosh the Destroyer
		questID = 38430, -- Argosh the Destroyer
	},
	[91874] = { -- Bladesquall
		questID = 38431, -- Bladesquall
		vignetteName = "Bladesquall",
	},
	[91892] = { -- Thane Irglov the Merciless
		questID = 38424, -- Thane's Mead Hall
		vignetteName = "Thane's Mead Hall",
	},
	[92040] = { -- Fenri
		questID = 38461, -- Guarms Mate (Fenri)
		vignetteName = "Fenri",
	},
	[92117] = { -- Gorebeak
		isTameable = true,
		questID = 38468, -- Gorebeak
		vignetteName = "Gorebeak",
	},
	[92152] = { -- Whitewater Typhoon
		questID = 38472, -- Whitewater Typhoon
		vignetteName = "Whitewater Typhoon",
	},
	[92180] = { -- Seersei
		questID = 38479, -- Seersei
		vignetteName = "Seersei",
	},
	[92197] = { -- Relgor
		questID = 38496, -- BH Master Scout
		vignetteName = "BH Master Scout",
	},
	[92274] = { -- Painmistress Selora
		questID = 38557, -- Invasion Point: Devastation
		vignetteName = "Invasion Point: Devastation",
	},
	[92408] = { -- Xanzith the Everlasting
		questID = 38579, -- Xanzith the Everlasting
	},
	[92411] = { -- Overlord Ma'gruth
		questID = 38580, -- Overlord Ma'gruth
	},
	[92423] = { -- Theryssia
		questID = 38772, -- Banshee Boss
		vignetteName = "Theryssia",
	},
	[92429] = { -- Broodlord Ixkor
		isTameable = true,
		questID = 38589, -- Ravager Broodlord
		vignetteName = "Ravager Broodlord",
	},
	[92451] = { -- Varyx the Damned
		questID = 37937, -- Varyx the Damned
	},
	[92465] = { -- The Blackfang
		questID = 38597, -- Panther Saberon Boss
		vignetteName = "Panther Saberon Boss",
	},
	[92495] = { -- Soulslicer
		questID = 38600, -- Fel Saberon Shaman
		vignetteName = "Fel Saberon Shaman",
	},
	[92508] = { -- Gloomtalon
		questID = 38604, -- Saberon Shaman
		vignetteName = "Saberon Shaman",
	},
	[92517] = { -- Krell the Serene
		questID = 38605, -- Saberon Blademaster
		vignetteName = "Saberon Blademaster",
	},
	[92552] = { -- Belgork
		questID = 38609, -- Iron Tunnel Foreman
		vignetteName = "Iron Tunnel Foreman",
	},
	[92574] = { -- Thromma the Gutslicer
		questID = 38620, -- Pale Assassin
		vignetteName = "Pale Assassin",
	},
	[92590] = { -- Hook
		factionGroup = "Horde",
		questID = 38625, -- Hook & Sinker
		vignetteName = "Hook & Sinker",
	},
	[92591] = { -- Sinker
		factionGroup = "Horde",
		questID = 38625, -- Hook & Sinker
		vignetteName = "Hook & Sinker",
	},
	[92599] = { -- Bloodstalker Alpha
		isTameable = true,
		questID = 38626, -- Worg Pack
		vignetteName = "Worg Pack",
	},
	[92604] = { -- Champion Elodie
		factionGroup = "Alliance",
		questID = 38627, -- Worgen Stalkers (Horde Only)
		vignetteName = "Worgen Stalkers",
	},
	[92606] = { -- Sylissa
		questID = 38628, -- Giant Python
		vignetteName = "Giant Python",
	},
	[92609] = { -- Tracker Jack
		factionGroup = "Alliance",
		questID = 38627, -- Worgen Stalkers (Horde Only)
		vignetteName = "Worgen Stalkers",
	},
	[92611] = { -- Ambusher Daggerfang
		factionGroup = "Alliance",
	},
	[92613] = { -- Priestess Liza
		factionGroup = "Alliance",
		questID = 38627, -- Worgen Stalkers (Horde Only)
		vignetteName = "Worgen Stalkers",
	},
	[92626] = { -- Deathguard Adams
		factionGroup = "Horde",
		questID = 38630, -- Horde Kill Squad (Alliance Only)
		vignetteName = "Forsaken Deathsquad",
	},
	[92627] = { -- Rendrak
		isTameable = true,
		questID = 38631, -- Alpha Bat
		vignetteName = "Alpha Bat",
	},
	[92631] = { -- Dark Ranger Jess
		factionGroup = "Horde",
		questID = 38630, -- Horde Kill Squad (Alliance Only)
		vignetteName = "Forsaken Deathsquad",
	},
	[92633] = { -- Assassin Huwe
		factionGroup = "Horde",
	},
	[92634] = { -- Apothecary Perez
		factionGroup = "Horde",
		questID = 38630, -- Horde Kill Squad (Alliance Only)
		vignetteName = "Forsaken Deathsquad",
	},
	[92636] = { -- The Night Haunter
		questID = 38632, -- Night Haunter
		vignetteName = "Night Haunter",
	},
	[92645] = { -- The Night Haunter
		questID = 38632, -- Night Haunter
	},
	[92647] = { -- Felsmith Damorka
		questID = 38634, -- Felsmith Damorka
	},
	[92657] = { -- Bleeding Hollow Horror
		questID = 38696, -- Bleeding Hollow Horror
	},
	[92682] = { -- Helmouth Raider
		questID = 38642, -- Vrykul Longboat
		vignetteName = "Helmouth Raiders",
	},
	[92685] = { -- Captain Brvet
		questID = 38642, -- Vrykul Longboat
		vignetteName = "Helmouth Raiders",
	},
	[92694] = { -- The Goreclaw
		isTameable = true,
		questID = 38654, -- Giant Raptor
		vignetteName = "Giant Raptor",
	},
	[92703] = { -- Helmouth Raider
		questID = 38642, -- Vrykul Longboat
		vignetteName = "Helmouth Raiders",
	},
	[92751] = { -- Ivory Sentinel
		questID = 39031, -- Ivory Sentinel
		vignetteName = "Ivory Sentinel",
	},
	[92763] = { -- The Nameless King
		questID = 38685, -- The Nameless King
		vignetteName = "The Nameless King",
	},
	[92887] = { -- Steelsnout
		isTameable = true,
		questID = 38700, -- Steelsnout
	},
	[92941] = { -- Gorabosh
		questID = 38709, -- Cave Keeper
		vignetteName = "Cave Keeper",
	},
	[92951] = { -- Houndmaster Ely
		factionGroup = "Alliance",
		questID = 38712, -- Houndmaster Ely
		vignetteName = "Houndmaster Ely",
	},
	[92965] = { -- Darkshade
		questID = 38767, -- Nightmaul
		vignetteName = "Darkshade, Saber Matriarch",
	},
	[92977] = { -- The Iron Houndmaster
		questID = 38751, -- Iron Houndmaster
		vignetteName = "Iron Houndmaster",
	},
	[93001] = { -- Szirek the Twisted
		questID = 38752, -- Szirek
		vignetteName = "Szirek",
	},
	[93002] = { -- Magwia
		isTameable = true,
		questID = 38726, -- Magwia
	},
	[93028] = { -- Driss Vile
		questID = 38736, -- IH Elite Sniper
		vignetteName = "IH Elite Sniper",
	},
	[93030] = { -- Ironbranch
		questID = 40080, -- Ironbrancch
		vignetteName = "Ironbranch",
	},
	[93057] = { -- Grannok
		questID = 38750, -- Iron Front Captain 3
		vignetteName = "Iron Front Captain 3",
	},
	[93076] = { -- Captain Ironbeard
		questID = 38756, -- Dead Orc Captain
		vignetteName = "Dead Orc Captain",
	},
	[93125] = { -- Glub'glok
		questID = 38764, -- Murktide Alpha
		vignetteName = "Murktide Alpha",
	},
	[93166] = { -- Tiptog the Lost
		questID = 38774, -- Lost Ettin
		vignetteName = "Lost Ettin",
	},
	[93168] = { -- Felbore
		questID = 38775, -- Felbore
	},
	[93205] = { -- Thondrax
		questID = 38780, -- 7.0 Val'sharah - River - Thondrax - TRACKING - twh
		vignetteName = "Thondrax",
	},
	[93236] = { -- Shadowthrash
		isTameable = true,
		questID = 38812, -- Shadowthrash
	},
	[93264] = { -- Captain Grok'mar
		questID = 38820, -- Captain Grok'mar
	},
	[93279] = { -- Kris'kar the Unredeemed
		questID = 38825, -- Blazing Crusader
	},
	[93371] = { -- Mordvigbjorn
		questID = 38837, -- Mordvigbjorn
		vignetteName = "Mordvigbjorn",
	},
	[93401] = { -- Urgev the Flayer
		questID = 38847, -- Berserker
		vignetteName = "Urgev the Flayer",
	},
	[93654] = { -- Skul'vrax
		questID = 38887, -- 7.0 Val'sharah - Bluffs - Swiftflight - TRACKING - twh
		vignetteName = "Elindya Featherlight",
	},
	[93679] = { -- Gathenak the Subjugator
		questID = 44070, -- Gathenak
		vignetteName = "Marius & Tehd",
	},
	[93686] = { -- Jinikki the Puncturer
		questID = 38889, -- Adopting the Adorable
		vignetteName = "Shivering Ashmaw Cub",
	},
	[93758] = { -- Antydas Nightcaller
		questID = 38900, -- 7.0 Val'sharah - Bluffs - Nightcaller - TRACKING - twh
		vignetteName = "Antydas Nightcaller's Hideaway",
	},
	[94313] = { -- Daniel "Boomer" Vorick
		factionGroup = "Alliance",
		questID = 39048, -- Demolitionist
		vignetteName = "Sapper Vorick",
	},
	[94347] = { -- Dread-Rider Cortis
		factionGroup = "Horde",
		questID = 43343, -- Dread-Rider Cortis
		vignetteName = "Dread-Rider Cortis",
	},
	[94413] = { -- Isel the Hammer
		questID = 39120, -- Shield Forger
		vignetteName = "Isel the Hammer",
	},
	[94414] = { -- Kiranys Duskwhisper
		questID = 39121, -- Haunted Manor
		vignetteName = "Haunted Manor",
	},
	[94485] = { -- Pollous the Fetid
		questID = 39130, -- 7.0 Val'sharah - River: Purging the River - TRACKING - twh
		vignetteName = "Purging the River",
	},
	[94877] = { -- Brogrul the Mighty
		questID = 39235, -- Buba
		vignetteName = "Brogrul the Mighty",
	},
	[95044] = { -- Terrorfist
		questID = 39288, -- Terrorfist
	},
	[95053] = { -- Deathtalon
		questID = 39287, -- Deathtalon
	},
	[95054] = { -- Vengeance
		questID = 39290, -- Vengeance
	},
	[95056] = { -- Doomroller
		questID = 39289, -- Doomroller
	},
	[95123] = { -- Grelda the Hag
		questID = 40126, -- Grelda
		vignetteName = "Grelda the Hag",
	},
	[95204] = { -- Oubdob da Smasher
		questID = 39435, -- Oubdob da Smasher
		vignetteName = "Oubdob da Smasher",
	},
	[95221] = { -- Mad Henryk
		questID = 39357, -- 7.0 Val'sharah - Grove - Eileen - TRACKING - twh
		vignetteName = "Old Bear Trap",
	},
	[95318] = { -- Perrexx
		questID = 39596, -- 7.0 Val'sharah - Vale - Perrexx - TRACKING - twh
		vignetteName = "Perrexx the Corruptor",
	},
	[95872] = { -- Skullhat
		questID = 39465, -- Skywhisker Taskmaster
		vignetteName = "Skywhisker Taskmaster",
	},
	[96323] = { -- Arachnis
		questID = 39617, -- Vignette Tracking Quest
	},
	[96410] = { -- Majestic Elderhorn
		isTameable = true,
		questID = 39646, -- Albino Elderhorn
		vignetteName = "Majestic Elderhorn",
	},
	[96590] = { -- Gurbog da Basher
		questID = 40347, -- Gurbog da Basher
		vignetteName = "Gurbog da Basher",
	},
	[96621] = { -- Mellok, Son of Torok
		questID = 40242, -- Mellok, Son of Torok
		vignetteName = "Mellok, Son of Torok",
	},
	[96997] = { -- Kethrazor
		questID = 40251, -- Kethrazor
		vignetteName = "Kethrazor",
	},
	[97057] = { -- Overseer Brutarg
		questID = 40233, -- The Brood Queen's Court: Overseer Brutarg
		vignetteName = "The Brood Queen's Court: Overseer Brutarg",
	},
	[97058] = { -- Count Nefarious
		questID = 40231, -- The Brood Queen's Court: Count Nefarious
		vignetteName = "The Brood Queen's Court: Count Nefarious",
	},
	[97059] = { -- King Voras
		questID = 40232, -- The Brood Queen's Court: King Voras
		vignetteName = "The Brood Queen's Court: King Voras",
	},
	[97069] = { -- Wrath-Lord Lekos
		questID = 40301, -- Phalanx Captain
		vignetteName = "Wrath-Lord Lekos",
	},
	[97093] = { -- Shara Felbreath
		questID = 39762, -- Feltotem Warlock
		vignetteName = "Shara Felbreath",
	},
	[97102] = { -- Ram'Pag
		questID = 39766, -- Treasure Worm
		vignetteName = "Totally Safe Treasure Chest",
	},
	[97203] = { -- Tenpak Flametotem
		questID = 39782, -- The Exiled Shaman
		vignetteName = "The Exiled Shaman",
	},
	[97220] = { -- Arru
		isTameable = true,
		questID = 39784, -- Beastmaster Pao'lek
		vignetteName = "Beastmaster Pao'lek",
	},
	[97326] = { -- Hartli the Snatcher
		questID = 39802, -- Hartli the Snatcher
		vignetteName = "Hartli the Snatcher",
	},
	[97345] = { -- Crawshuk the Hungry
		questID = 39806, -- Crawshuk the Hungry
		vignetteName = "Crawshuk the Hungry",
	},
	[97370] = { -- General Volroth
		questID = 40234, -- The Brood Queen's Court: General Volroth
		vignetteName = "The Brood Queen's Court: General Volroth",
	},
	[97449] = { -- Bristlemaul
		isTameable = true,
		questID = 40405, -- Bristlemaul
		vignetteName = "Bristlemaul",
	},
	[97504] = { -- Wraithtalon
		questID = 39856, -- Wraithtalon
		vignetteName = "Wraithtalon",
	},
	[97517] = { -- Dreadbog
		questID = 39858, -- Dreadbog
		vignetteName = "Dreadbog",
	},
	[97593] = { -- Mynta Talonscreech
		questID = 39866, -- Scout Harefoot
		vignetteName = "Scout Harefoot",
	},
	[97630] = { -- Soulthirster
		questID = 39870, -- Soulthirster
		vignetteName = "Soulthirster",
	},
	[97653] = { -- Taurson
		questID = 39872, -- The Beastly Boxer
		vignetteName = "The Beastly Boxer",
	},
	[97793] = { -- Flamescale
		questID = 39963, -- Abandoned Fishing Pole
		vignetteName = "Abandoned Fishing Pole",
	},
	[97928] = { -- Tamed Coralback
		isTameable = true,
	},
	[97933] = { -- Crab Rider Grmlrml
		questID = 39994, -- Crab Rider Grmlrml
		vignetteName = "Crab Rider Grmlrml",
	},
	[98024] = { -- Luggut the Eggeater
		questID = 40406, -- Luggut the Eggeater
		vignetteName = "Luggut the Eggeater",
	},
	[98188] = { -- Egyl the Enduring
		questID = 40068, -- 7.0 Stormheim - Egyl the Enduring - twh
		vignetteName = "Egyl the Enduring",
	},
	[98198] = { -- Rukdug
		questID = 40075, -- Rukdug
	},
	[98199] = { -- Pugg
		questID = 40073, -- Pugg
	},
	[98200] = { -- Guk
		questID = 40074, -- Guk
	},
	[98241] = { -- Lyrath Moonfeather
		questID = 40079, -- Lyrath Moonfeather
		vignetteName = "Lyrath Moonfeather",
	},
	[98268] = { -- Tarben
		questID = 40081, -- 7.0 Stormheim - Tarben - twh
		vignetteName = "Tarben",
	},
	[98283] = { -- Drakum
		questID = 40105, -- Drakum
	},
	[98284] = { -- Gondar
		questID = 40106, -- Gondar
	},
	[98285] = { -- Smashum Grabb
		questID = 40104, -- Smashum Grabb
	},
	[98299] = { -- Bodash the Hoarder
		questID = 40084, -- Zugdug the Hoarder
		vignetteName = "Bodash the Hoarder",
	},
	[98311] = { -- Mrrklr
		questID = 40096, -- Mrrklr
		vignetteName = "Captured Survivor",
	},
	[98408] = { -- Fel Overseer Mudlump
		questID = 40107, -- Mudlump
	},
	[98421] = { -- Kottr Vondyr
		questID = 40109, -- Vignette - Kottr Vondyr
		vignetteName = "Kottr Vondyr",
	},
	[98503] = { -- Grrvrgull the Conqueror
		questID = 40113, -- Grrvrgull the Conquerer
		vignetteName = "Grrvrgull the Conquerer",
	},
	[98890] = { -- Slumber
		isTameable = true,
		questID = 40175, -- Sleeping Bear
		vignetteName = "Slumbering Bear",
	},
	[99610] = { -- Garvrulg
		questID = 40897, -- Garvrulg
		vignetteName = "Garvrulg",
	},
	[99792] = { -- Elfbane
		questID = 41319, -- Elfbane
		vignetteName = "Elfbane",
	},
	[99899] = { -- Vicious Whale Shark
		questID = 44669, -- Vicious Whale Shark
		vignetteName = "Vicious Whale Shark",
	},
	[99929] = { -- Flotsam
		questID = 41126, -- 7.0 Suramar - Flotsam - twh
		vignetteName = "Flotsam",
	},
	[100230] = { -- "Sure-Shot" Arnie
		questID = 40413, -- Amateur Hunters
		vignetteName = "Amateur Hunters",
	},
	[100231] = { -- Dargok Thunderuin
		questID = 40413, -- Amateur Hunters
		vignetteName = "Amateur Hunters",
	},
	[100232] = { -- Ryael Dawndrifter
		questID = 40413, -- Amateur Hunters
		vignetteName = "Amateur Hunters",
	},
	[100302] = { -- Puck
		questID = 40423, -- Unethical Adventurers
	},
	[100303] = { -- Zenobia
		questID = 40423, -- Unethical Adventurers
	},
	[100495] = { -- Devouring Darkness
		questID = 40414, -- Devouring Darkness
		vignetteName = "Devouring Darkness",
	},
	[100864] = { -- Cora'kar
		questID = 41135, -- 7.0 Suramar - Cora'kar - twh
		vignetteName = "Cora'kar",
	},
	[101077] = { -- Sekhan
		isTameable = true,
		questID = 40681, -- Snarf
		vignetteName = "Sekhan",
	},
	[101411] = { -- Gom Crabbar
		vignetteName = "Gom Crabbar",
	},
	[101596] = { -- Charfeather
		questID = 40766, -- Charfeather
		vignetteName = "Charfeather",
	},
	[101649] = { -- Frostshard
		questID = 40773, -- Bloodshard
		vignetteName = "Frostshard",
	},
	[102064] = { -- Torrentius
		questID = 44035, -- Torrentius
		vignetteName = "Torrentius",
	},
	[102303] = { -- Lieutenant Strathmar
		questID = 40905, -- Lieutenant Strathmar
		vignetteName = "Lieutenant Strathmar",
	},
	[102863] = { -- Bruiser
		isTameable = true,
		questID = 41042, -- Champion Chomper
		vignetteName = "Champion Chomper",
	},
	[103183] = { -- Rok'nash
		questID = 40680, -- 7.0 Suramar - Rok'nash - twh
		vignetteName = "Rok'nash",
	},
	[103203] = { -- Jetsam
		questID = 41134, -- 7.0 Suramar - Jetsam - twh
		vignetteName = "Jetsam",
	},
	[103214] = { -- Har'kess the Insatiable
		questID = 41136, -- 7.0 Suramar - Har'kess - twh
		vignetteName = "Har'kess the Insatiable",
	},
	[103223] = { -- Hertha Grimdottir
		questID = 43993, -- Hertha Grimdottir
		vignetteName = "Hertha Grimdottir",
	},
	[103575] = { -- Reef Lord Raj'his
		questID = 44003, -- Reef Lord Raj'his
		vignetteName = "Reef Lord Raj'his",
	},
	[103785] = { -- Well-Fed Bear
		isTameable = true,
	},
	[103787] = { -- Baconlisk
		isTameable = true,
	},
	[103827] = { -- King Morgalash
		questID = 41786, -- 7.0 Suramar - Sea Giant King - twh
		vignetteName = "Sea Giant King",
	},
	[103841] = { -- Shadowquill
		isTameable = true,
		questID = 43996, -- Shadowquill
		vignetteName = "Shadowquill",
	},
	[103975] = { -- Jade Darkhaven
		questID = 43957, -- Jade Darkhaven
		vignetteName = "Jade Darkhaven",
	},
	[104523] = { -- Shalas'aman
		questID = 45500, -- Shalas'aman
	},
	[105547] = { -- Rauren
		questID = 43484, -- Rauren
		vignetteName = "Rauren",
	},
	[105938] = { -- Felwing
		questID = 42069, -- Felbats
		vignetteName = "Marius & Tehd",
	},
	[106351] = { -- Artificer Lothaire
		questID = 43717, -- Artificer Lothaire
		vignetteName = "Artificer Lothaire",
	},
	[106526] = { -- Lady Rivantas
		questID = 44675, -- Lady Rivantas
		vignetteName = "Lady Rivantas",
	},
	[106532] = { -- Inquisitor Volitix
		questID = 44569, -- Inquisitor Volitix
		vignetteName = "Inquisitor Volitix",
	},
	[106990] = { -- Chief Bitterbrine
		questID = 42221, -- Chief Bitterbrine
		vignetteName = "Chief Bitterbrine",
	},
	[107105] = { -- Broodmother Lizax
		questID = 44670, -- Broodmother Lizax
		vignetteName = "Broodmother Lizax",
	},
	[107113] = { -- Vorthax
		questID = 42280, -- Vorthax
		vignetteName = "Vorthax",
	},
	[107127] = { -- Brawlgoth
		questID = 42450, -- Brawlgoth
		vignetteName = "Brawlgoth",
	},
	[107136] = { -- Houndmaster Stroxis
		questID = 42286, -- Houndmaster Stroxis
		vignetteName = "Houndmaster Stroxis",
	},
	[107169] = { -- Horux
		questID = 42286, -- Houndmaster Stroxis
	},
	[107170] = { -- Zorux
		questID = 42286, -- Houndmaster Stroxis
	},
	[107266] = { -- Commander Soraax
		questID = 44673, -- Commander Soraax
	},
	[107269] = { -- Inquisitor Tivos
		questID = 42376, -- Inquisitor Tivos
		vignetteName = "Inquisitor Tivos",
	},
	[107327] = { -- Bilebrain
		questID = 42417, -- Bilebrain
		vignetteName = "Bilebrain",
	},
	[107431] = { -- Weaponized Rabbot
		isTameable = true,
	},
	[107477] = { -- N.U.T.Z.
		isTameable = true,
	},
	[107487] = { -- Starbuck
		isTameable = true,
		questID = 42437, -- Starbuck
		vignetteName = "Starbuck",
	},
	[107595] = { -- Grimrot
		isTameable = true,
	},
	[107596] = { -- Grimrot
		isTameable = true,
	},
	[107617] = { -- Ol' Muddle
		isTameable = true,
	},
	[107657] = { -- Arcanist Shal'iman
		questID = 42505, -- Arcanist Shal'iman
		vignetteName = "Arcanist Shal'iman",
	},
	[107846] = { -- Pinchshank
		isTameable = true,
		questID = 43968, -- Pinchshank
		vignetteName = "Pinchshank",
	},
	[107926] = { -- Hannval the Butcher
		questID = 42591, -- Vignette - Hannval the Butcher
		vignetteName = "Hannval the Butcher",
	},
	[108136] = { -- The Muscle
		questID = 44671, -- The Muscle
		vignetteName = "The Muscle",
	},
	[108255] = { -- Coura, Mistress of Arcana
		questID = 42699, -- Coura, Master of Arcana
		vignetteName = "Coura, Master of Arcana",
	},
	[108827] = { -- Fjorlag, the Grave's Chill
		questID = 45507, -- Fjorlag, the Grave's Chill
	},
	[109054] = { -- Shal'an
		questID = 42831, -- Shal'an
		vignetteName = "Shal'an",
	},
	[109113] = { -- Boulderfall, the Eroded
		questID = 40067, -- 7.0 Stormheim - Boulderfall - twh
	},
	[109281] = { -- Malisandra
		questID = 45501, -- Malisandra
	},
	[109498] = { -- Xaander
		questID = 40423, -- Unethical Adventurers
	},
	[109500] = { -- Jak
		questID = 40423, -- Unethical Adventurers
	},
	[109501] = { -- Darkful
		questID = 40423, -- Unethical Adventurers
	},
	[109504] = { -- Ragemaw
		questID = 44108, -- Ragemaw
		vignetteName = "Ragemaw",
	},
	[109575] = { -- Valakar the Thirsty
		questID = 45515, -- Valakar the Thirsty
	},
	[109594] = { -- Stormfeather
		questID = 45497, -- Stormfeather
	},
	[109620] = { -- The Whisperer
		questID = 45496, -- The Whisperer
	},
	[109648] = { -- Witchdoctor Grgl-Brgl
		questID = 45493, -- Witchdoctor Grgl-Brgl
	},
	[109653] = { -- Marblub the Massive
		questID = 45492, -- Marblub the Massive
	},
	[109708] = { -- Undergrell Ringleader
		questID = 43176, -- Grell Waves Tracking Flag
		vignetteName = "Undgrell Attack",
	},
	[109954] = { -- Magister Phaedris
		questID = 43348, -- Magister Phaedris
	},
	[109990] = { -- Nylaathria the Forgotten
		questID = 45488, -- Nylaathria the Forgotten
	},
	[110024] = { -- Mal'Dreth the Corruptor
		questID = 43351, -- Mal'Dreth the Corrupter
		vignetteName = "Magister Phaedris",
	},
	[110340] = { -- Myonix
		isTameable = true,
		questID = 43358, -- Myonix
		vignetteName = "Myonix",
	},
	[110342] = { -- Rabxach
		questID = 45487, -- Rabxach
	},
	[110363] = { -- Roteye
		questID = 43342, -- Vignette - Roteye
		vignetteName = "Roteye",
	},
	[110367] = { -- Ealdis
		questID = 45483, -- Ealdis
	},
	[110438] = { -- Siegemaster Aedrin
		questID = 43369, -- Siegemaster Aedrin
		vignetteName = "Siegemaster Aedrin",
	},
	[110486] = { -- Huk'roth the Huntmaster
		questID = 43480, -- Huk'roth the Houndmaster
		vignetteName = "Huk'roth the Houndmaster",
	},
	[110562] = { -- Bahagar
		isTameable = true,
		questID = 43446, -- Bahagar
		vignetteName = "Bahagar",
	},
	[110577] = { -- Oreth the Vile
		questID = 43449, -- Oreth the Vile
		vignetteName = "Oreth the Vile",
	},
	[110656] = { -- Arcanist Lylandre
		questID = 43481, -- Arcanist Lylandre
		vignetteName = "Arcanist Lylandre",
	},
	[110726] = { -- Cadraeus
		questID = 43495, -- Cadraeus
		vignetteName = "Cadraeus",
	},
	[110824] = { -- Tideclaw
		isTameable = true,
		questID = 43542, -- Tideclaw
		vignetteName = "Tideclaw",
	},
	[110832] = { -- Gorgroth
		questID = 43992, -- Gorgroth
		vignetteName = "Gorgroth",
	},
	[110870] = { -- Apothecary Faldren
		questID = 43580, -- Apothecary Faldren
		vignetteName = "Apothecary Faldren",
	},
	[110944] = { -- Guardian Thor'el
		questID = 43597, -- Guardian Thor'el
		vignetteName = "Guardian Thor'el",
	},
	[111007] = { -- Randril
		questID = 43603, -- Randril
		vignetteName = "Randril",
	},
	[111197] = { -- Anax
		questID = 43954, -- Anax
		vignetteName = "Anax",
	},
	[111329] = { -- Matron Hagatha
		questID = 43718, -- Matron Hagatha
		vignetteName = "Matron Hagatha",
	},
	[111434] = { -- Sea King Tidross
		questID = 44039, -- Sea King Tidross
		vignetteName = "Sea King Tidross",
	},
	[111463] = { -- Bulvinkel
		isTameable = true,
	},
	[111573] = { -- Kosumoth the Hungering
		questID = 45479, -- Kosumoth the Hungering
	},
	[111649] = { -- Ambassador D'vwinn
		questID = 43794, -- Ambassador D'vwinn
		vignetteName = "Ambassador D'vwinn",
	},
	[111651] = { -- Degren
		questID = 43792, -- Degren
		vignetteName = "Noble Blademaster",
	},
	[111653] = { -- Miasu
		questID = 43793, -- Miasu
		vignetteName = "Miasu",
	},
	[111939] = { -- Lysanis Shadesoul
		questID = 43956, -- Lysanis Shadesoul
	},
	[112497] = { -- Maia the White
		isTameable = true,
		questID = 44072, -- Maia the White
		vignetteName = "Maia the White",
	},
	[112636] = { -- Sinister Leyrunner
		questID = 44081, -- Treacherous Leyrunners
		vignetteName = "Trecherous Stallions",
	},
	[112637] = { -- Devious Sunrunner
		questID = 44081, -- Treacherous Leyrunners
		vignetteName = "Trecherous Stallions",
	},
	[112705] = { -- Achronos
		questID = 45478, -- Achronos
	},
	[112758] = { -- Auditor Esiel
		questID = 45475, -- Auditor Esiel
	},
	[112759] = { -- Az'jatar
		questID = 45471, -- Az'jatar
	},
	[112802] = { -- Mar'tura
		isTameable = true,
		questID = 44124, -- Mar'tura
		vignetteName = "Mar'tura",
	},
	[113368] = { -- Llorian
		questID = 44676, -- Llorian
		vignetteName = "Llorian",
	},
	[113694] = { -- Pashya
		isTameable = true,
	},
}

private.NPCData = NPCData

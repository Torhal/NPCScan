-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local AddOnFolderName, private = ...

-- ----------------------------------------------------------------------------
-- What we're really here for.
-- ----------------------------------------------------------------------------
local NPCData = {
	[462] = { isTameable = true, }, -- Vultros
	[471] = { isTameable = true, }, -- Mother Fang
	[521] = { isTameable = true, }, -- Lupos
	[574] = { isTameable = true, }, -- Naraxis
	[616] = { isTameable = true, }, -- Chatter
	[1112] = { isTameable = true, }, -- Leech Widow
	[1130] = { isTameable = true, }, -- Bjarn
	[1132] = { isTameable = true, }, -- Timber
	[1140] = { isTameable = true, }, -- Razormaw Matriarch
	[1552] = { isTameable = true, }, -- Scale Belly
	[2172] = { isTameable = true, }, -- Strider Clutchmother
	[2175] = { isTameable = true, }, -- Shadowclaw
	[2476] = { isTameable = true, }, -- Gosh-Haldir
	[2753] = { isTameable = true, }, -- Barnabus
	[2850] = { isTameable = true, }, -- Broken Tooth
	[2931] = { isTameable = true, }, -- Zaricotl
	[3068] = { isTameable = true, }, -- Mazzranache
	[3253] = { isTameable = true, }, -- Silithid Harvester
	[3581] = { isTameable = true, }, -- Sewer Beast
	[4132] = { isTameable = true, }, -- Krkk'kx
	[4380] = { isTameable = true, }, -- Darkmist Widow
	[4425] = { isTameable = true, }, -- Blind Hunter
	[5349] = { isTameable = true, }, -- Arash-ethis
	[5350] = { isTameable = true, }, -- Qirot
	[5352] = { isTameable = true, }, -- Old Grizzlegut
	[5356] = { isTameable = true, }, -- Snarler
	[5807] = { isTameable = true, }, -- The Rake
	[5823] = { isTameable = true, }, -- Death Flayer
	[5828] = { isTameable = true, }, -- Humar the Pridelord
	[5829] = { isTameable = true, }, -- Snort the Heckler
	[5834] = { isTameable = true, }, -- Azzere the Skyblade
	[5842] = { isTameable = true, }, -- Takk the Leaper
	[5865] = { isTameable = true, }, -- Dishu
	[5937] = { isTameable = true, }, -- Vile Sting
	[6581] = { isTameable = true, }, -- Ravasaur Matriarch
	[6582] = { isTameable = true, }, -- Clutchmother Zavas
	[6584] = { isTameable = true, }, -- King Mosh
	[6585] = { isTameable = true, }, -- Uhk'loc
	[8204] = { isTameable = true, }, -- Soriid the Devourer
	[8205] = { isTameable = true, }, -- Haarka the Ravenous
	[8207] = { isTameable = true, }, -- Emberwing
	[8211] = { isTameable = true, }, -- Old Cliff Jumper
	[8213] = { isTameable = true, }, -- Ironback
	[8277] = { isTameable = true, }, -- Rekk'tilac
	[8299] = { isTameable = true, }, -- Spiteflayer
	[8300] = { isTameable = true, }, -- Ravage
	[8301] = { isTameable = true, }, -- Clack the Reaver
	[8303] = { isTameable = true, }, -- Grunter
	[8660] = { isTameable = true, }, -- The Evalcharr
	[10077] = { isTameable = true, }, -- Deathmaw
	[10200] = { isTameable = true, }, -- Rak'shiri
	[10356] = { isTameable = true, }, -- Bayne
	[10357] = { isTameable = true, }, -- Ressan the Needler
	[10359] = { isTameable = true, }, -- Sri'skulk
	[10376] = { isTameable = true, }, -- Crystal Fang
	[10644] = { isTameable = true, }, -- Mist Howler
	[10741] = { isTameable = true, }, -- Sian-Rotam
	[11497] = { isTameable = true, }, -- The Razza
	[12037] = { isTameable = true, }, -- Ursol'lok
	[12431] = { isTameable = true, }, -- Gorefang
	[12433] = { isTameable = true, }, -- Krethis the Shadowspinner
	[14222] = { isTameable = true, }, -- Araga
	[14223] = { isTameable = true, }, -- Cranky Benj
	[14228] = { isTameable = true, }, -- Giggler
	[14232] = { isTameable = true, }, -- Dart
	[14233] = { isTameable = true, }, -- Ripscale
	[14234] = { isTameable = true, }, -- Hayoc
	[14237] = { isTameable = true, }, -- Oozeworm
	[14266] = { isTameable = true, }, -- Shanda the Spinner
	[14268] = { isTameable = true, }, -- Lord Condar
	[14279] = { isTameable = true, }, -- Creepthess
	[14280] = { isTameable = true, }, -- Big Samras
	[14339] = { isTameable = true, }, -- Death Howl
	[14343] = { isTameable = true, }, -- Olm the Wise
	[14344] = { isTameable = true, }, -- Mongress
	[14430] = { isTameable = true, }, -- Duskstalker
	[14472] = { isTameable = true, }, -- Gretheer
	[14473] = { isTameable = true, }, -- Lapress
	[14474] = { isTameable = true, }, -- Zora
	[14475] = { isTameable = true, }, -- Rex Ashil
	[14476] = { isTameable = true, }, -- Krellack
	[14477] = { isTameable = true, }, -- Grubthor
	[14491] = { isTameable = true, }, -- Kurmokk
	[16180] = { isTameable = true, }, -- Shadikith the Glider
	[16181] = { isTameable = true, }, -- Rokad the Ravager
	[17144] = { isTameable = true, }, -- Goretooth
	[18241] = { isTameable = true, }, -- Crusty
	[18680] = { isTameable = true, }, -- Marticar
	[20932] = { isTameable = true, }, -- Nuramoc
	[21724] = { isTameable = true, }, -- Hawkbane
	[32361] = { isTameable = true, }, -- Icehorn
	[32475] = { isTameable = true, }, -- Terror Spinner
	[32481] = { isTameable = true, }, -- Aotona
	[32485] = { isTameable = true, }, -- King Krush
	[32517] = { isTameable = true, }, -- Loque'nahak
	[33776] = { isTameable = true, }, -- Gondria
	[35189] = { isTameable = true, }, -- Skoll
	[38453] = { isTameable = true, }, -- Arcturis
	[39183] = { isTameable = true, }, -- Scorpitar
	[39185] = { isTameable = true, }, -- Slaverjaw
	[45380] = { isTameable = true, }, -- Ashtail
	[45402] = { isTameable = true, }, -- Nix
	[47386] = { isTameable = true, }, -- Ainamiss the Hive Queen
	[47387] = { isTameable = true, }, -- Harakiss the Infestor
	[49822] = { isTameable = true, }, -- Jadefang
	[50051] = { isTameable = true, }, -- Ghostcrawler
	[50058] = { isTameable = true, }, -- Terrorpene
	[50138] = { isTameable = true, }, -- Karoma
	[50154] = { isTameable = true, }, -- Madexx - Brown
	[50159] = { isTameable = true, }, -- Sambas
	[50328] = { isTameable = true, }, -- Fangor
	[50329] = { isTameable = true, }, -- Rrakk
	[50330] = { isTameable = true, }, -- Kree
	[50335] = { isTameable = true, }, -- Alitus
	[50337] = { isTameable = true, }, -- Cackle
	[50342] = { isTameable = true, }, -- Heronis
	[50343] = { isTameable = true, }, -- Quall
	[50345] = { isTameable = true, }, -- Alit
	[50346] = { isTameable = true, }, -- Ronak
	[50348] = { isTameable = true, }, -- Norissis
	[50353] = { isTameable = true, }, -- Manas
	[50357] = { isTameable = true, }, -- Sunwing
	[50361] = { isTameable = true, }, -- Ornat
	[50362] = { isTameable = true, }, -- Blackbog the Fang
	[50370] = { isTameable = true, }, -- Karapax
	[50724] = { isTameable = true, }, -- Spinecrawl
	[50725] = { isTameable = true, }, -- Azelisk
	[50726] = { isTameable = true, }, -- Kalixx
	[50727] = { isTameable = true, }, -- Strix the Barbed
	[50728] = { isTameable = true, }, -- Deathstrike
	[50730] = { isTameable = true, }, -- Venomspine
	[50731] = { isTameable = true, }, -- Needlefang
	[50735] = { isTameable = true, }, -- Blinkeye the Rattler
	[50737] = { isTameable = true, }, -- Acroniss
	[50738] = { isTameable = true, }, -- Shimmerscale
	[50741] = { isTameable = true, }, -- Kaxx
	[50742] = { isTameable = true, }, -- Qem
	[50743] = { isTameable = true, }, -- Manax
	[50744] = { isTameable = true, }, -- Qu'rik
	[50745] = { isTameable = true, }, -- Losaj
	[50746] = { isTameable = true, }, -- Bornix the Burrower
	[50747] = { isTameable = true, }, -- Tix
	[50748] = { isTameable = true, }, -- Nyaj
	[50752] = { isTameable = true, }, -- Tarantis
	[50759] = { isTameable = true, }, -- Iriss the Widow
	[50763] = { isTameable = true, }, -- Shadowstalker
	[50764] = { isTameable = true, }, -- Paraliss
	[50765] = { isTameable = true, }, -- Miasmiss
	[50770] = { isTameable = true, }, -- Zorn
	[50775] = { isTameable = true, }, -- Likk the Hunter
	[50777] = { isTameable = true, }, -- Needle
	[50778] = { isTameable = true, }, -- Ironweb
	[50779] = { isTameable = true, }, -- Sporeggon
	[50784] = { isTameable = true, }, -- Anith
	[50785] = { isTameable = true, }, -- Skyshadow
	[50786] = { isTameable = true, }, -- Sparkwing
	[50788] = { isTameable = true, }, -- Quetzl
	[50790] = { isTameable = true, }, -- Ionis
	[50792] = { isTameable = true, }, -- Chiaa
	[50797] = { isTameable = true, }, -- Yukiko
	[50803] = { isTameable = true, }, -- Bonechewer
	[50804] = { isTameable = true, }, -- Ripwing
	[50807] = { isTameable = true, }, -- Catal
	[50809] = { isTameable = true, }, -- Heress
	[50810] = { isTameable = true, }, -- Favored of Isiset
	[50812] = { isTameable = true, }, -- Arae
	[50813] = { isTameable = true, }, -- Fene-mal
	[50814] = { isTameable = true, }, -- Corpsefeeder
	[50815] = { isTameable = true, }, -- Skarr
	[50818] = { isTameable = true, }, -- The Dark Prowler
	[50819] = { isTameable = true, }, -- Iceclaw
	[50825] = { isTameable = true, }, -- Feras
	[50833] = { isTameable = true, }, -- Duskcoat
	[50837] = { isTameable = true, }, -- Kash
	[50838] = { isTameable = true, }, -- Tabbs
	[50839] = { isTameable = true, }, -- Chromehound
	[50842] = { isTameable = true, }, -- Magmagan
	[50843] = { isTameable = true, }, -- Portent
	[50846] = { isTameable = true, }, -- Slavermaw
	[50855] = { isTameable = true, }, -- Jaxx the Rabid
	[50856] = { isTameable = true, }, -- Snark
	[50858] = { isTameable = true, }, -- Dustwing
	[50864] = { isTameable = true, }, -- Thicket
	[50865] = { isTameable = true, }, -- Saurix
	[50874] = { isTameable = true, }, -- Tenok
	[50875] = { isTameable = true, }, -- Nychus
	[50876] = { isTameable = true, }, -- Avis
	[50882] = { isTameable = true, }, -- Chupacabros
	[50884] = { isTameable = true, }, -- Dustflight the Cowardly
	[50886] = { isTameable = true, }, -- Seawing
	[50891] = { isTameable = true, }, -- Boros
	[50892] = { isTameable = true, }, -- Cyn
	[50895] = { isTameable = true, }, -- Volux
	[50897] = { isTameable = true, }, -- Ffexk the Dunestalker
	[50901] = { isTameable = true, }, -- Teromak
	[50903] = { isTameable = true, }, -- Orlix the Swamplord
	[50905] = { isTameable = true, }, -- Cida
	[50906] = { isTameable = true, }, -- Mutilax
	[50908] = { isTameable = true, }, -- Nighthowl
	[50915] = { isTameable = true, }, -- Snort
	[50916] = { isTameable = true, }, -- Lamepaw the Whimperer
	[50922] = { isTameable = true, }, -- Warg
	[50925] = { isTameable = true, }, -- Grovepaw
	[50926] = { isTameable = true, }, -- Grizzled Ben
	[50929] = { isTameable = true, }, -- Little Bjorn
	[50930] = { isTameable = true, }, -- Hibernus the Sleeper
	[50931] = { isTameable = true, }, -- Mange
	[50937] = { isTameable = true, }, -- Hamhide
	[50940] = { isTameable = true, }, -- Swee
	[50942] = { isTameable = true, }, -- Snoot the Rooter
	[50945] = { isTameable = true, }, -- Scruff
	[50946] = { isTameable = true, }, -- Hogzilla
	[50947] = { isTameable = true, }, -- Varah
	[50948] = { isTameable = true, }, -- Crystalback
	[50949] = { isTameable = true, }, -- Finn's Gambit
	[50952] = { isTameable = true, }, -- Barnacle Jim
	[50955] = { isTameable = true, }, -- Carcinak
	[50957] = { isTameable = true, }, -- Hugeclaw
	[50959] = { isTameable = true, }, -- Karkin
	[50964] = { isTameable = true, }, -- Chops
	[50967] = { isTameable = true, }, -- Craw the Ravager
	[50986] = { isTameable = true, }, -- Goldenback
	[50993] = { isTameable = true, }, -- Gal'dorak
	[50995] = { isTameable = true, }, -- Bruiser
	[50997] = { isTameable = true, }, -- Bornak the Gorer
	[51000] = { isTameable = true, }, -- Blackshell the Impenetrable
	[51001] = { isTameable = true, }, -- Venomclaw
	[51002] = { isTameable = true, }, -- Scorpoxx
	[51004] = { isTameable = true, }, -- Toxx
	[51007] = { isTameable = true, }, -- Serkett
	[51008] = { isTameable = true, }, -- The Barbed Horror
	[51010] = { isTameable = true, }, -- Snips
	[51014] = { isTameable = true, }, -- Terrapis
	[51017] = { isTameable = true, }, -- Gezan
	[51018] = { isTameable = true, }, -- Zormus
	[51021] = { isTameable = true, }, -- Vorticus
	[51022] = { isTameable = true, }, -- Chordix
	[51025] = { isTameable = true, }, -- Dilennaa
	[51026] = { isTameable = true, }, -- Gnath
	[51027] = { isTameable = true, }, -- Spirocula
	[51028] = { isTameable = true, }, -- The Deep Tunneler
	[51029] = { isTameable = true, }, -- Parasitus
	[51031] = { isTameable = true, }, -- Tracker
	[51037] = { isTameable = true, }, -- Lost Gilnean Wardog
	[51040] = { isTameable = true, }, -- Snuffles
	[51042] = { isTameable = true, }, -- Bleakheart
	[51044] = { isTameable = true, }, -- Plague
	[51045] = { isTameable = true, }, -- Arcanus
	[51046] = { isTameable = true, }, -- Fidonis
	[51048] = { isTameable = true, }, -- Rexxus
	[51052] = { isTameable = true, }, -- Gib the Banana-Hoarder
	[51053] = { isTameable = true, }, -- Quirix
	[51057] = { isTameable = true, }, -- Weevil
	[51058] = { isTameable = true, }, -- Aphis
	[51061] = { isTameable = true, }, -- Roth-Salam
	[51062] = { isTameable = true, }, -- Khep-Re
	[51063] = { isTameable = true, }, -- Phalanax
	[51066] = { isTameable = true, }, -- Crystalfang
	[51067] = { isTameable = true, }, -- Glint
	[51069] = { isTameable = true, }, -- Scintillex
	[51071] = { factionGroup = "Alliance", }, -- Captain Florence
	[51076] = { isTameable = true, }, -- Lopex
	[51077] = { isTameable = true, }, -- Bushtail
	[51079] = { factionGroup = "Horde", }, -- Captain Foulwind
	[51401] = { isTameable = true, }, -- Madexx - Red
	[51402] = { isTameable = true, }, -- Madexx - Green
	[51403] = { isTameable = true, }, -- Madexx - Black
	[51404] = { isTameable = true, }, -- Madexx - Blue
	[51661] = { isTameable = true, }, -- Tsul'Kalu
	[51662] = { isTameable = true, }, -- Mahamba
	[51663] = { isTameable = true, }, -- Pogeyan
	[52146] = { isTameable = true, }, -- Chitter
	[54318] = { isTameable = true, }, -- Ankha
	[54319] = { isTameable = true, }, -- Magria
	[54320] = { isTameable = true, }, -- Ban'thalos
	[54321] = { isTameable = true, }, -- Solix
	[54322] = { isTameable = true, }, -- Deth'tilac
	[54323] = { isTameable = true, }, -- Kirix
	[54324] = { isTameable = true, }, -- Skitterflame
	[54338] = { isTameable = true, }, -- Anthriss
	[54533] = { isTameable = true, }, -- Prince Lakma
	[58474] = { isTameable = true, }, -- Bloodtip
	[63509] = { isTameable = true, }, -- Wulon
	[63510] = { isTameable = true, }, -- Wulon
	[68317] = { factionGroup = "Alliance", }, -- Mavis Harms
	[68318] = { factionGroup = "Alliance", }, -- Dalan Nightbreaker
	[68319] = { factionGroup = "Alliance", }, -- Disha Fearwarden
	[68320] = { factionGroup = "Horde", }, -- Ubunti the Shade
	[68321] = { factionGroup = "Horde", }, -- Kar Warmaker
	[68322] = { factionGroup = "Horde", }, -- Muerta
	[69998] = { isTameable = true, }, -- Goda
	[71665] = { questID = 32918, }, -- Giant-Slayer Kul
	[71721] = { questID = 32941, }, -- Canyon Icemother
	[72294] = { questID = 33014, }, -- Cindermaw
	[72362] = { questID = 33039, }, -- Ku'targ the Voidseer
	[72364] = { questID = 33512, }, -- Gorg'ak the Lava Guzzler
	[72537] = { questID = 33055, }, -- Leaf-Reader Kurri
	[72606] = { questID = 34068, isTameable = true, }, -- Rockhoof
	[72808] = { isTameable = true, }, -- Tsavo'ka
	[73158] = { isTameable = true, }, -- Emerald Gander
	[73161] = { isTameable = true, }, -- Great Turtle Furyshell
	[73166] = { isTameable = true, }, -- Monstrous Spineclaw
	[74206] = { questID = 33043, isTameable = true, }, -- Killmaw
	[74613] = { questID = 33843, }, -- Broodmother Reeg'ak
	[74971] = { questID = 33504, }, -- Firefury Giant
	[75071] = { questID = 33642, }, -- Mother Om'ra
	[75434] = { questID = 33038, }, -- Windfang Matriarch
	[75435] = { questID = 33389, }, -- Yggdrel
	[75482] = { questID = 33640, isTameable = true, }, -- Veloss
	[75492] = { questID = 33643, }, -- Venomshade
	[76380] = { questID = 33664, }, -- Gorum
	[76473] = { questID = 34726, isTameable = true, }, -- Mother Araneae
	[76914] = { questID = 34131, isTameable = true, }, -- Coldtusk
	[76918] = { questID = 33938, }, -- Primalist Mur'og
	[77085] = { questID = 33064, }, -- Dark Emanation
	[77140] = { questID = 33061, isTameable = true, }, -- Amaukwa
	[77310] = { questID = 35906, }, -- Mad "King" Sporeon
	[77513] = { questID = 34129, isTameable = true, }, -- Coldstomp the Griever
	[77519] = { isTameable = true, }, -- Giantbane
	[77526] = { questID = 34132, }, -- Scout Goreseeker
	[77527] = { questID = 34133, }, -- The Beater
	[77529] = { questID = 34135, }, -- Yazheera the Incinerator
	[77561] = { questID = 34142, }, -- Dr. Gloom
	[77614] = { questID = 34145, }, -- Frenzied Golem
	[77620] = { questID = 34165, }, -- Cro Fleshrender
	[77626] = { questID = 34167, isTameable = true, }, -- Hen-Mother Hami
	[77634] = { questID = 34171, isTameable = true, }, -- Taladorantula
	[77664] = { questID = 34182, }, -- Aarko
	[77715] = { questID = 34185, isTameable = true, }, -- Hammertooth
	[77719] = { questID = 34189, isTameable = true, }, -- Glimmerwing
	[77741] = { questID = 34196, isTameable = true, }, -- Ra'kahn
	[77750] = { questID = 34199, }, -- Kaavu the Crimson Claw
	[77776] = { questID = 34205, }, -- Wandering Vindicator
	[77784] = { questID = 34208, }, -- Lo'marg Jawcrusher
	[77795] = { questID = 34221, }, -- Echo of Murmur
	[77828] = { questID = 34220, }, -- Echo of Murmur
	[78151] = { questID = 34130, }, -- Huntmaster Kuang
	[78161] = { questID = 34862, }, -- Hyperious
	[78260] = { questID = 37412, }, -- King Slime
	[78265] = { questID = 34361, }, -- The Bone Crawler
	[78269] = { questID = 37413, }, -- Gnarljaw
	[78606] = { questID = 34470, }, -- Pale Fishmonger
	[78621] = { questID = 34477, }, -- Cyclonic Fury
	[78710] = { questID = 35219, }, -- Kharazos the Triumphant
	[78713] = { questID = 35219, }, -- Galzomar
	[78715] = { questID = 35219, }, -- Sikthiss, Maiden of Slaughter
	[78867] = { questID = 34497, }, -- Breathless
	[78872] = { questID = 34498, isTameable = true, }, -- Klikixx
	[79024] = { questID = 34645, }, -- Warmaster Blugthol
	[79104] = { questID = 34522, }, -- Ug'lok the Frozen
	[79145] = { questID = 34559, }, -- Yaga the Scarred
	[79334] = { questID = 34859, isTameable = true, }, -- No'losh
	[79485] = { questID = 34668, }, -- Talonpriest Zorkra
	[79524] = { questID = 35558, }, -- Hypnocroak
	[79543] = { questID = 34671, }, -- Shirzir
	[79629] = { questID = 35910, }, -- Stomper Kreego
	[79725] = { questID = 34727, }, -- Captain Ironbeard
	[79938] = { questID = 36478, }, -- Shadowbark
	[80057] = { questID = 36128, }, -- Soulfang
	[80122] = { questID = 34725, isTameable = true, }, -- Gaz'orda
	[80190] = { questID = 34825, }, -- Gruuk
	[80204] = { questID = 35018, }, -- Felbark
	[80235] = { questID = 34839, }, -- Gurun
	[80242] = { questID = 34843, isTameable = true, }, -- Chillfang
	[80312] = { questID = 34865, }, -- Grutush the Pillager
	[80370] = { questID = 37408, isTameable = true, }, -- Lernaea
	[80371] = { questID = 37405, }, -- Typhon
	[80372] = { questID = 37406, isTameable = true, }, -- Echidna
	[80398] = { questID = 37407, isTameable = true, }, -- Keravnos
	[80471] = { questID = 34929, isTameable = true, }, -- Gennadian
	[80524] = { questID = 34945, }, -- Underseer Bloodmane
	[80614] = { questID = 35599, }, -- Blade-Dancer Aeryx
	[80725] = { questID = 36394, }, -- Sulfurious
	[80868] = { questID = 36204, }, -- Glut
	[81038] = { questID = 36391, }, -- Gelgor of the Blue Flame
	[81406] = { questID = 35281, }, -- Bahameye
	[81639] = { questID = 33383, }, -- Brambleking Fili
	[82050] = { isTameable = true, }, -- Varasha
	[82058] = { questID = 37370, }, -- Depthroot
	[82085] = { questID = 35335, }, -- Bashiok
	[82207] = { questID = 35725, }, -- Faebright
	[82247] = { questID = 36129, }, -- Nas Dunberlin
	[82268] = { questID = 35448, }, -- Darkmaster Go'vid
	[82311] = { questID = 35503, }, -- Char the Burning
	[82326] = { questID = 35731, }, -- Ba'ruun
	[82362] = { questID = 35523, }, -- Morva Soultwister
	[82374] = { questID = 35553, }, -- Rai'vosh
	[82411] = { questID = 35555, }, -- Darktalon
	[82415] = { questID = 35732, }, -- Shinri
	[82486] = { questID = 35623, }, -- Explorer Nozzand
	[82536] = { questID = 37388, }, -- Gorivax
	[82614] = { questID = 37387, }, -- Moltnoma
	[82616] = { questID = 37386, isTameable = true, }, -- Jabberjaw
	[82617] = { questID = 37385, isTameable = true, }, -- Slogtusk the Corpse-Eater
	[82618] = { questID = 37384, }, -- Tor'goroth
	[82620] = { questID = 37383, }, -- Son of Goramal
	[82676] = { questID = 35688, }, -- Enavra
	[82742] = { questID = 35688, }, -- Enavra
	[82755] = { questID = 35712, }, -- Redclaw the Feral
	[82758] = { questID = 35714, isTameable = true, }, -- Greatfeather
	[82764] = { questID = 35715, }, -- Gar'lua
	[82778] = { questID = 35717, isTameable = true, }, -- Gnarlhoof the Rabid
	[82826] = { questID = 35735, }, -- Berserk T-300 Series Mark II
	[82876] = { factionGroup = "Alliance", }, -- Grand Marshal Tremblade
	[82877] = { factionGroup = "Horde", }, -- High Warlord Volrath
	[82878] = { factionGroup = "Alliance", }, -- Marshal Gabriel
	[82880] = { factionGroup = "Alliance", }, -- Marshal Karsh Stormforge
	[82882] = { factionGroup = "Horde", }, -- General Aevd
	[82883] = { factionGroup = "Horde", }, -- Warlord Noktyn
	[82899] = { questID = 35778, }, -- Ancient Blademaster
	[82912] = { questID = 35784, isTameable = true, }, -- Grizzlemaw
	[82920] = { questID = 37345, }, -- Lord Korinak
	[82922] = { questID = 37343, }, -- Xothear, the Destroyer
	[82930] = { questID = 37347, }, -- Shadowflame Terrorwalker
	[82942] = { questID = 37346, }, -- Lady Demlash
	[82975] = { questID = 35836, }, -- Fangler
	[82988] = { questID = 37348, }, -- Kurlosh Doomfang
	[82992] = { questID = 37341, }, -- Felfire Consort
	[82998] = { questID = 37349, }, -- Matron of Sin
	[83008] = { questID = 37312, }, -- Haakun the All-Consuming
	[83019] = { questID = 37340, }, -- Gug'tol
	[83385] = { questID = 35847, }, -- Voidseer Kalurg
	[83401] = { questID = 35865, }, -- Netherspawn
	[83409] = { questID = 35875, }, -- Ophiis
	[83428] = { questID = 35877, }, -- Windcaller Korast
	[83483] = { questID = 35893, isTameable = true, }, -- Flinthide
	[83509] = { questID = 35898, }, -- Gorepetal
	[83522] = { questID = 35908, isTameable = true, }, -- Hive Queen Skrikka
	[83526] = { questID = 35900, }, -- Ru'klaa
	[83542] = { questID = 35912, }, -- Sean Whitesea
	[83553] = { questID = 35909, isTameable = true, }, -- Insha'tar
	[83591] = { questID = 35920, isTameable = true, }, -- Tura'aka
	[83603] = { questID = 35923, }, -- Hunter Blacktooth
	[83634] = { questID = 35931, }, -- Scout Pokhar
	[83643] = { questID = 35932, }, -- Malroc Stonesunder
	[83680] = { questID = 35943, }, -- Outrider Duretha
	[83990] = { questID = 37394, }, -- Solar Magnifier
	[84263] = { questID = 36159, }, -- Graveltooth
	[84374] = { questID = 37404, }, -- Kaga the Ironbender
	[84376] = { questID = 37403, }, -- Earthshaker Holar
	[84378] = { questID = 37525, }, -- Ak'ox the Slaughterer
	[84392] = { questID = 37401, }, -- Ragore Driftstalker
	[84406] = { questID = 36178, }, -- Mandrakor
	[84417] = { questID = 36396, }, -- Mutafen
	[84431] = { questID = 36186, }, -- Greldrok the Cunning
	[84435] = { questID = 36229, }, -- Mr. Pinchy Sr.
	[84775] = { questID = 36254, }, -- Tesska the Broken
	[84805] = { questID = 36265, isTameable = true, }, -- Stonespite
	[84807] = { questID = 36267, }, -- Durkath Steelmaw
	[84810] = { questID = 36268, }, -- Kalos the Bloodbathed
	[84833] = { questID = 36276, }, -- Sangrikass
	[84836] = { questID = 36278, }, -- Talonbreaker
	[84838] = { questID = 36279, }, -- Poisonmaster Bortusk
	[84856] = { questID = 36283, isTameable = true, }, -- Blightglow
	[84872] = { questID = 36288, }, -- Oskiira the Vengeful
	[84887] = { questID = 36291, }, -- Betsi Boombasket
	[84890] = { questID = 36297, }, -- Festerbloom
	[84893] = { isTameable = true, }, -- Goregore
	[84911] = { questID = 37351, }, -- Demidos
	[84912] = { questID = 36298, isTameable = true, }, -- Sunderthorn
	[84925] = { questID = 37352, }, -- Quartermaster Hershak
	[84951] = { questID = 36305, }, -- Gobblefin
	[84955] = { questID = 36306, isTameable = true, }, -- Jiasska the Sporegorger
	[85001] = { questID = 37353, }, -- Master Sergeant Milgra
	[85026] = { questID = 37358, }, -- Soul-Twister Torek
	[85029] = { questID = 37354, }, -- Shadowspeaker Niir
	[85036] = { questID = 37360, }, -- Formless Nightmare
	[85037] = { questID = 37361, }, -- Kenos the Unraveler
	[85078] = { questID = 37359, }, -- Voidreaver Urnae
	[85121] = { questID = 37355, }, -- Lady Temptessa
	[85250] = { questID = 36387, }, -- Fossilwood the Petrified
	[85264] = { questID = 36393, }, -- Rolkor
	[85451] = { questID = 37357, }, -- Malgosh Shadowkeeper
	[85504] = { questID = 36470, }, -- Rotcap
	[85520] = { questID = 36472, }, -- Swarmleaf
	[85555] = { questID = 37409, }, -- Nagidna
	[85568] = { questID = 37410, }, -- Avalanche
	[85572] = { questID = 36919, }, -- Grrbrrgle
	[85837] = { questID = 37411, }, -- Slivermaw
	[85907] = { questID = 36597, isTameable = true, }, -- Berthora
	[85970] = { questID = 36600, isTameable = true, }, -- Riptar
	[86137] = { questID = 36656, }, -- Sunclaw
	[86257] = { questID = 37369, }, -- Basten
	[86266] = { questID = 37372, isTameable = true, }, -- Venolasix
	[86268] = { questID = 37371, }, -- Alkali
	[86410] = { questID = 36794, }, -- Sylldross
	[86520] = { questID = 36837, isTameable = true, }, -- Stompalupagus
	[86549] = { questID = 36858, }, -- Steeltusk
	[86562] = { questID = 37363, }, -- Maniacal Madgard
	[86566] = { questID = 37362, }, -- Defector Dazgo
	[86571] = { questID = 37366, }, -- Durp the Hated
	[86574] = { questID = 37367, }, -- Inventor Blammo
	[86577] = { questID = 37365, }, -- Horgg
	[86579] = { questID = 37368, }, -- Blademaster Ro'gor
	[86582] = { questID = 37364, }, -- Morgo Kain
	[86689] = { questID = 36880, }, -- Sneevel
	[86724] = { questID = 36887, }, -- Hermit Palefur
	[86729] = { isTameable = true, }, -- Direhoof
	[86732] = { isTameable = true, }, -- Bergruu
	[86750] = { isTameable = true, }, -- Thek'talon
	[86774] = { isTameable = true, }, -- Aogexon
	[86835] = { isTameable = true, }, -- Xelganak
	[86959] = { questID = 37399, }, -- Karosh Blackwind
	[86978] = { questID = 36943, }, -- Gaze
	[87019] = { questID = 37390, }, -- Gluttonous Giant
	[87026] = { questID = 37391, }, -- Mecha Plunderer
	[87027] = { questID = 37392, }, -- Shadow Hulk
	[87029] = { questID = 37393, }, -- Giga Sentinel
	[87234] = { questID = 37400, }, -- Brutag Grimblade
	[87239] = { questID = 37473, }, -- Krahl Deadeye
	[87344] = { questID = 37472, }, -- Gortag Steelgrip
	[87348] = { questID = 37382, }, -- Hoarfrost
	[87351] = { questID = 37381, }, -- Mother of Goren
	[87352] = { questID = 37380, }, -- Gibblette the Cowardly
	[87356] = { questID = 37379, }, -- Vrok the Ancient
	[87357] = { questID = 37378, }, -- Valkor
	[87362] = { isTameable = true, }, -- Gibby
	[87597] = { questID = 37339, }, -- Bombardier Gu'gok
	[87600] = { questID = 37556, }, -- Jaluk the Pacifist
	[87622] = { questID = 37402, }, -- Ogom the Mangler
	[87666] = { isTameable = true, }, -- Mu'gra
	[87668] = { questID = 37344, }, -- Orumo the Observer
	[87788] = { questID = 37395, }, -- Durg Spinecrusher
	[87837] = { questID = 37396, }, -- Bonebreaker
	[87846] = { questID = 37397, }, -- Pit Slayer
	[88043] = { questID = 37338, }, -- Avatar of Socrethar
	[88071] = { questID = 37337, }, -- Strategist Ankor
	[88208] = { questID = 37637, }, -- Pit Beast
	[88210] = { questID = 37398, }, -- Krud the Eviscerator
	[88436] = { questID = 37350, }, -- Vigilant Paarthos
	[88494] = { questID = 37342, }, -- Legion Vanguard
	[88580] = { questID = 37373, }, -- Firestarter Grash
	[88582] = { questID = 37374, }, -- Swift Onyx Flayer
	[88583] = { questID = 37375, }, -- Grove Warden Yal
	[88586] = { questID = 37376, isTameable = true, }, -- Mogamago
	[89650] = { questID = 37726, }, -- Valiyaka the Stormbringer
	[88672] = { questID = 37377, }, -- Hunter Bal'ra
	[88951] = { isTameable = true, }, -- Vileclaw
	[89016] = { questID = 37537, }, -- Ravyn-Drath
	[89675] = { questID = 38749, }, -- Commander Org'mok
	[89816] = { questID = 37820, vignetteName = "Horn of the Siren" }, -- Golza the Iron Fin
	[89846] = { questID = 37821, }, -- Captain Volo'ren
	[89850] = { questID = 37822, }, -- The Oracle
	[89865] = { questID = 37823, }, -- Mrrgrl the Tide Reaver
	[89884] = { questID = 37824, }, -- Flog the Captain-Eater
	[90024] = { questID = 37953, }, -- Sergeant Mor'grak
	[90094] = { questID = 39046, }, -- Harbormaster Korak
	[90057] = { questID = 37869, }, -- Daggerbeak
	[90122] = { questID = 39045, }, -- Zoug the Heavy
	[90139] = { questID = 37908, }, -- Inquisitor Ernstenbok
	[90164] = { questID = 37909, vignetteName = "Seek & Destroy Squad" }, -- Warbringer Mox'na
	[90173] = { questID = 37909, vignetteName = "Seek & Destroy Squad" }, -- Arcana Stalker
	[90244] = { questID = 37932, }, -- Arcavellus
	[90429] = { questID = 38026, }, -- Imp-Master Valessa
	[90434] = { questID = 38031, }, -- Ceraxas
	[90437] = { questID = 38030, }, -- Jax'zor
	[90438] = { questID = 38029, }, -- Lady Oran
	[90442] = { questID = 38032, }, -- Mistress Thavra
	[90505] = { questID = 37989, vignetteName = "Syphonus & Leodrath" }, -- Syphonus
	[90519] = { questID = 37990, }, -- Cindral the Wildfire
	[90777] = { questID = 38028, }, -- High Priest Ikzan
	[90782] = { questID = 38034, }, -- Rasthe
	[90803] = { questID = 38037, vignetteName = "Cache of Infernals" }, -- Infernal Lord
	[90884] = { questID = 38262, }, -- Bilkor the Thrower
	[90885] = { questID = 38263, }, -- Rogond the Tracker
	[90887] = { questID = 38265, }, -- Dorg the Bloody
	[90888] = { questID = 38264, }, -- Drivnul
	[90901] = { questID = 38061, }, -- Pridelord Meowl
	[90936] = { questID = 38266, }, -- Bloodhunter Zulk
	[91100] = { questID = 38212, }, -- Brogozog
	[91009] = { questID = 38457, }, -- Putre'thar
	[91087] = { questID = 38207, }, -- Zeter'el
	[91093] = { questID = 38209, }, -- Bramblefell
	[91098] = { questID = 38211, }, -- Felspark
	[91187] = { questID = 38238, }, -- Beacher
	[91113] = { questID = 38217, }, -- Tide Behemoth
	[91114] = { questID = 38217, }, -- Tide Behemoth
	[91115] = { questID = 38217, }, -- Tide Behemoth
	[91227] = { questID = 39159, }, -- Remnant of the Blood Moon
	[91232] = { questID = 38746, }, -- Commander Krag'goth
	[91243] = { questID = 38747, }, -- Tho'gar Gorefist
	[91374] = { questID = 38282, }, -- Podlord Wakkawam
	[91529] = { questID = 38333, }, -- Glimar Ironfist
	[91579] = { questID = 38352, }, -- Doomlord Kazrok
	[91695] = { questID = 38400, }, -- Grand Warlock Nethekurse
	[91727] = { questID = 38411, }, -- Executor Riloth
	[91795] = { questID = 38423, vignetteName = "Stormdrake Matriarch" }, -- Stormwing Matriarch
	[91803] = { questID = 38425, }, -- Fathnyr
	[91871] = { questID = 38430, }, -- Argosh the Destroyer
	[91874] = { questID = 38431, }, -- Bladesquall
	[91892] = { questID = 38424, vignetteName = "Thane's Mead Hall" }, -- Thane Irglov the Merciless
	[92040] = { questID = 38461, }, -- Fenri
	[92117] = { questID = 38468, isTameable = true, }, -- Gorebeak,
	[92152] = { questID = 38472, }, -- Whitewater Typhoon
	[92180] = { questID = 38479, }, -- Seersei
	[92197] = { questID = 38496, }, -- Relgor
	[92274] = { questID = 38557, vignetteName = "Invasion Point: Devastation" }, -- Painmistress Selora
	[92408] = { questID = 38579, }, -- Xanzith the Everlasting
	[92411] = { questID = 38580, }, -- Overlord Ma'gruth
	[92429] = { questID = 38589, isTameable = true, }, -- Broodlord Ixkor
	[92451] = { questID = 37937, }, -- Varyx the Damned
	[92465] = { questID = 38597, }, -- The Blackfang
	[92495] = { questID = 38600, }, -- Soulslicer
	[92508] = { questID = 38604, }, -- Gloomtalon
	[92517] = { questID = 38605, }, -- Krell the Serene
	[92552] = { questID = 38609, }, -- Belgork
	[92574] = { questID = 38620, }, -- Thromma the Gutslicer
	[92590] = { questID = 38625, factionGroup = "Horde", vignetteName = "Hook & Sinker" }, -- Hook
	[92591] = { questID = 38625, factionGroup = "Horde", vignetteName = "Hook & Sinker" }, -- Sinker
	[92599] = { questID = 38626, isTameable = true, vignetteName = "Worg Pack" }, -- Bloodstalker Alpha
	[92604] = { questID = 38627, factionGroup = "Alliance", vignetteName = "Worgen Stalkers" }, -- Champion Elodie
	[92606] = { questID = 38628, }, -- Sylissa
	[92609] = { questID = 38627, factionGroup = "Alliance", vignetteName = "Worgen Stalkers" }, -- Tracker Jack
	[92611] = { factionGroup = "Alliance", }, -- Ambusher Daggerfang
	[92613] = { questID = 38627, factionGroup = "Alliance", vignetteName = "Worgen Stalkers" }, -- Priestess Liza
	[92626] = { questID = 38630, factionGroup = "Horde", vignetteName = "Forsaken Deathsquad" }, -- Deathguard Adams
	[92627] = { questID = 38631, isTameable = true, }, -- Rendrak
	[92631] = { questID = 38630, factionGroup = "Horde", vignetteName = "Forsaken Deathsquad" }, -- Dark Ranger Jess
	[92634] = { questID = 38630, factionGroup = "Horde", vignetteName = "Forsaken Deathsquad" }, -- Apothecary Perez
	[92636] = { questID = 38632, }, -- The Night Haunter
	[92645] = { questID = 38632, }, -- The Night Haunter
	[92647] = { questID = 38634, }, -- Felsmith Damorka
	[92657] = { questID = 38696, }, -- Bleeding Hollow Horror
	[92682] = { questID = 38642, vignetteName = "Helmouth Raiders" }, -- Helmouth Raider
	[92685] = { questID = 38642, vignetteName = "Helmouth Raiders" }, -- Captain Brvet
	[92694] = { questID = 38654, isTameable = true, }, -- The Goreclaw
	[92703] = { questID = 38642, vignetteName = "Helmouth Raiders" }, -- Helmouth Raider
	[92751] = { questID = 39031, }, -- Ivory Sentinel
	[92763] = { questID = 38685, }, -- The Nameless King
	[92887] = { questID = 38700, isTameable = true, }, -- Steelsnout
	[92941] = { questID = 38709, }, -- Gorabosh
	[92951] = { questID = 38712, factionGroup = "Alliance", }, -- Houndmaster Ely
	[92965] = { questID = 38767, }, -- Darkshade
	[92977] = { questID = 38751, }, -- The Iron Houndmaster
	[93001] = { questID = 38752, }, -- Szirek the Twisted
	[93002] = { questID = 38726, isTameable = true, }, -- Magwia
	[93030] = { questID = 40080, }, -- Ironbranch
	[93028] = { questID = 38736, }, -- Driss Vile
	[93057] = { questID = 38750, }, -- Grannok
	[93076] = { questID = 38756, }, -- Captain Ironbeard
	[93125] = { questID = 38764, }, -- Glub'glok
	[93166] = { questID = 38774, vignetteName = "Lost Ettin" }, -- Tiptog the Lost
	[93168] = { questID = 38775, }, -- Felbore
	[93236] = { questID = 38812, isTameable = true, }, -- Shadowthrash
	[93264] = { questID = 38820, }, -- Captain Grok'mar
	[93279] = { questID = 38825, }, -- Kris'kar the Unredeemed
	[93371] = { questID = 38837, }, -- Mordvigbjorn
	[93401] = { questID = 38847, }, -- Urgev the Flayer
	[93654] = { questID = 38887, }, -- Skul'vrax
	[93679] = { questID = 44070, }, -- Gathenak the Subjugator
	[93686] = { questID = 38889, vignetteName = "Shivering Ashmaw Cub" }, -- Jinikki the Puncturer
	[93758] = { questID = 38900, }, -- Antydas Nightcaller
	[94313] = { factionGroup = "Alliance", }, -- Daniel "Boomer" Vorick
	[94347] = { questID = 43343, }, -- Dread-Rider Cortis
	[94413] = { questID = 39120, }, -- Isel the Hammer
	[94414] = { questID = 39121, }, -- Kiranys Duskwhisper
	[94485] = { questID = 39130, }, -- Pollous the Fetid
	[94877] = { questID = 39235, }, -- Brogrul the Mighty
	[95044] = { questID = 39288, }, -- Terrorfist
	[95053] = { questID = 39287, }, -- Deathtalon
	[95054] = { questID = 39290, }, -- Vengeance
	[95056] = { questID = 39289, }, -- Doomroller
	[95123] = { questID = 40126, }, -- Grelda the Hag
	[95204] = { questID = 39435, }, -- Oubdob da Smasher
	[95221] = { questID = 39357, }, -- Mad Henryk
	[95318] = { questID = 39596, vignetteName = "Perrexx the Corruptor" }, -- Perrexx
	[95872] = { questID = 39465, }, -- Skullhat
	[96323] = { questID = 39617, }, -- Arachnis
	[96410] = { questID = 39646, isTameable = true, }, -- Majestic Elderhorn
	[96590] = { questID = 40347, }, -- Gurbog da Basher
	[96621] = { questID = 40242, }, -- Mellok, Son of Torok
	[97093] = { questID = 39762, }, -- Shara Felbreath
	[97102] = { questID = 39766, }, -- Ram'Pag
	[97203] = { questID = 39782, }, -- Tenpak Flametotem
	[97220] = { questID = 39784, isTameable = true, vignetteName = "Beastmaster Pao'lek" }, -- Arru
	[97326] = { questID = 39802, }, -- Hartli the Snatcher
	[97345] = { questID = 39806, }, -- Crawshuk the Hungry
	[97449] = { questID = 40405, isTameable = true, }, -- Bristlemaul
	[97504] = { questID = 39856, }, -- Wraithtalon
	[97517] = { questID = 39858, }, -- Dreadbog
	[97593] = { questID = 39866, }, -- Mynta Talonscreech
	[97630] = { questID = 39870, }, -- Soulthirster
	[97653] = { questID = 39872, vignetteName = "The Beastly Boxer" }, -- Taurson
	[97793] = { questID = 39963, vignetteName = "Abandoned Fishing Pole" }, -- Flamescale
	[97928] = { isTameable = true, }, -- Tamed Coralback
	[97933] = { questID = 39994, }, -- Crab Rider Grmlrml
	[98024] = { questID = 40406, }, -- Luggut the Eggeater
	[98188] = { questID = 40068, }, -- Egyl the Enduring
	[98198] = { questID = 40075, }, -- Rukdug
	[98199] = { questID = 40073, }, -- Pugg
	[98200] = { questID = 40074, }, -- Guk
	[98241] = { questID = 40079, }, -- Lyrath Moonfeather
	[98268] = { questID = 40081, }, -- Tarben
	[98283] = { questID = 40105, }, -- Drakumd
	[98284] = { questID = 40106, }, -- Gondar
	[98285] = { questID = 40104, }, -- Smashum Grabb
	[98299] = { questID = 40084, }, -- Bodash the Hoarder
	[98311] = { questID = 40096, }, -- Mrrklr
	[98408] = { questID = 40107, }, -- Fel Overseer Mudlump
	[98421] = { questID = 40109, }, -- Kottr Vondyr
	[98503] = { questID = 40113, }, -- Grrvrgull the Conqueror
	[98890] = { questID = 40175, isTameable = true, }, -- Slumber
	[99610] = { questID = 40897, }, -- Garvrulg
	[99792] = { questID = 41319, }, -- Elfbane
	[100230] = { questID = 40413, vignetteName = "Amateur Hunters" }, -- "Sure-Shot" Arnie
	[100231] = { questID = 40413, vignetteName = "Amateur Hunters" }, -- Dargok Thunderuin
	[100232] = { questID = 40413, vignetteName = "Amateur Hunters" }, -- Ryael Dawndrifter
	[100302] = { questID = 40423, }, -- Puck
	[100303] = { questID = 40423, }, -- Zenobia
	[100495] = { questID = 40414, }, -- Devouring Darkness
	[100864] = { questID = 41135, }, -- Cora'kar
	[101077] = { questID = 40681, isTameable = true, }, -- Sekhan
	[101649] = { questID = 40773, }, -- Frostshard
	[102303] = { questID = 40905, }, -- Lieutenant Strathmar
	[102863] = { isTameable = true, }, -- Bruiser
	[103183] = { questID = 40680, }, -- Rok'nash
	[103214] = { questID = 41136, }, -- Har'kess the Insatiable
	[103223] = { questID = 43993, }, -- Hertha Grimdottir
	[103575] = { questID = 44003, }, -- Reef Lord Raj'his
	[103785] = { isTameable = true, }, -- Well-Fed Bear
	[103787] = { isTameable = true, }, -- Baconlisk
	[103827] = { questID = 41786, vignetteName = "Sea Giant King" }, -- King Morgalash
	[103841] = { questID = 43996, isTameable = true, }, -- Shadowquill
	[105547] = { questID = 43484, }, -- Rauren
	[105938] = { questID = 42069, }, -- Felwing
	[106351] = { questID = 43717, }, -- Artificer Lothaire
	[106526] = { questID = 44675, }, -- Lady Rivantas
	[106532] = { questID = 44569, }, -- Inquisitor Volitix
	[106990] = { questID = 42221, }, -- Chief Bitterbrine
	[107105] = { questID = 44670, }, -- Broodmother Lizax
	[107113] = { questID = 42280, }, -- Vorthax
	[107127] = { questID = 42450, }, -- Brawlgoth
	[107136] = { questID = 42286, }, -- Houndmaster Stroxis
	[107169] = { questID = 42286, }, -- Horux
	[107170] = { questID = 42286, }, -- Zorux
	[107269] = { questID = 42376, }, -- Inquisitor Tivos
	[107327] = { questID = 42417, }, -- Bilebrain
	[107487] = { questID = 42437, isTameable = true, }, -- Starbuck
	[107657] = { questID = 42505, }, -- Arcanist Shal'iman
	[107846] = { questID = 43968, isTameable = true, }, -- Pinchshank
	[107926] = { questID = 42591, }, -- Hannval the Butcher
	[108255] = { questID = 42699, vignetteName = "Coura, Master of Arcana" }, -- Coura, Mistress of Arcana
	[108829] = { questID = 43192, }, -- Levantus
	[109054] = { questID = 42831, }, -- Shal'an
	[109163] = { questID = 42864, }, -- Captain Dargun
	[109331] = { questID = 43193, }, -- Calamir
	[109498] = { questID = 40423, }, -- Xaander
	[109500] = { questID = 40423, }, -- Jak
	[109501] = { questID = 40423, }, -- Darkful
	[109504] = { questID = 44108, }, -- Ragemaw
	[109708] = { questID = 43176, vignetteName = "Undgrell Attack" }, -- Undergrell Ringleader
	[109954] = { questID = 43348, }, -- Magister Phaedris
	[110024] = { questID = 43351, }, -- Mal'Dreth the Corruptor
	[110340] = { questID = 43358, isTameable = true, }, -- Myonix
	[110363] = { questID = 43342, }, -- Roteye
	[110438] = { questID = 43369, }, -- Siegemaster Aedrin
	[110562] = { questID = 43446, isTameable = true, }, -- Bahagar
	[110577] = { questID = 43449, }, -- Oreth the Vile
	[110656] = { questID = 43481, }, -- Arcanist Lylandre
	[110726] = { questID = 43495, }, -- Cadraeus
	[110824] = { questID = 43542, isTameable = true, }, -- Tideclaw
	[110832] = { questID = 43992, }, -- Gorgroth
	[110870] = { questID = 43580, }, -- Apothecary Faldren
	[110944] = { questID = 43597, }, -- Guardian Thor'el
	[111007] = { questID = 43603, }, -- Randril
	[111197] = { questID = 43954, }, -- Anax
	[111329] = { questID = 43718, }, -- Matron Hagatha
	[111463] = { isTameable = true, }, -- Bulvinkel
	[111649] = { questID = 43794, }, -- Ambassador D'vwinn
	[111651] = { questID = 43792, }, -- Degren
	[111653] = { questID = 43793, }, -- Miasu
	[112497] = { questID = 44072, isTameable = true, }, -- Maia the White
	[112636] = { questID = 44081, vignetteName = "Trecherous Stallions" }, -- Sinister Leyrunner
	[112637] = { questID = 44081, vignetteName = "Trecherous Stallions" }, -- Devious Sunrunner
	[112802] = { questID = 44124, isTameable = true, }, -- Mar'tura
	[113368] = { questID = 44676, }, -- Llorian
	[113694] = { isTameable = true, }, -- Pashya
}

private.NPCData = NPCData

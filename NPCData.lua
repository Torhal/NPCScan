-------------------------------------------------------------------------------
-- Localized Lua globals.
-------------------------------------------------------------------------------
local _G = getfenv(0)

-- Functions
local pairs = _G.pairs
local tonumber = _G.tonumber
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

local NPCData = {
	[462] = { isTamable = true, }, -- Vultros
	[471] = { isTamable = true, }, -- Mother Fang
	[521] = { isTamable = true, }, -- Lupos
	[574] = { isTamable = true, }, -- Naraxis
	[616] = { isTamable = true, }, -- Chatter
	[1112] = { isTamable = true, }, -- Leech Widow
	[1130] = { isTamable = true, }, -- Bjarn
	[1132] = { isTamable = true, }, -- Timber
	[1140] = { isTamable = true, }, -- Razormaw Matriarch
	[1552] = { isTamable = true, }, -- Scale Belly
	[2172] = { isTamable = true, }, -- Strider Clutchmother
	[2175] = { isTamable = true, }, -- Shadowclaw
	[2476] = { isTamable = true, }, -- Gosh-Haldir
	[2753] = { isTamable = true, }, -- Barnabus
	[2850] = { isTamable = true, }, -- Broken Tooth
	[2931] = { isTamable = true, }, -- Zaricotl
	[3068] = { isTamable = true, }, -- Mazzranache
	[3253] = { isTamable = true, }, -- Silithid Harvester
	[3581] = { isTamable = true, }, -- Sewer Beast
	[4132] = { isTamable = true, }, -- Krkk'kx
	[4380] = { isTamable = true, }, -- Darkmist Widow
	[4425] = { isTamable = true, }, -- Blind Hunter
	[5349] = { isTamable = true, }, -- Arash-ethis
	[5350] = { isTamable = true, }, -- Qirot
	[5352] = { isTamable = true, }, -- Old Grizzlegut
	[5356] = { isTamable = true, }, -- Snarler
	[5807] = { isTamable = true, }, -- The Rake
	[5823] = { isTamable = true, }, -- Death Flayer
	[5828] = { isTamable = true, }, -- Humar the Pridelord
	[5829] = { isTamable = true, }, -- Snort the Heckler
	[5834] = { isTamable = true, }, -- Azzere the Skyblade
	[5842] = { isTamable = true, }, -- Takk the Leaper
	[5865] = { isTamable = true, }, -- Dishu
	[5937] = { isTamable = true, }, -- Vile Sting
	[6581] = { isTamable = true, }, -- Ravasaur Matriarch
	[6582] = { isTamable = true, }, -- Clutchmother Zavas
	[6584] = { isTamable = true, }, -- King Mosh
	[6585] = { isTamable = true, }, -- Uhk'loc
	[8204] = { isTamable = true, }, -- Soriid the Devourer
	[8205] = { isTamable = true, }, -- Haarka the Ravenous
	[8207] = { isTamable = true, }, -- Emberwing
	[8211] = { isTamable = true, }, -- Old Cliff Jumper
	[8213] = { isTamable = true, }, -- Ironback
	[8277] = { isTamable = true, }, -- Rekk'tilac
	[8299] = { isTamable = true, }, -- Spiteflayer
	[8300] = { isTamable = true, }, -- Ravage
	[8301] = { isTamable = true, }, -- Clack the Reaver
	[8303] = { isTamable = true, }, -- Grunter
	[8660] = { isTamable = true, }, -- The Evalcharr
	[10077] = { isTamable = true, }, -- Deathmaw
	[10200] = { isTamable = true, }, -- Rak'shiri
	[10356] = { isTamable = true, }, -- Bayne
	[10357] = { isTamable = true, }, -- Ressan the Needler
	[10359] = { isTamable = true, }, -- Sri'skulk
	[10376] = { isTamable = true, }, -- Crystal Fang
	[10644] = { isTamable = true, }, -- Mist Howler
	[10741] = { isTamable = true, }, -- Sian-Rotam
	[11497] = { isTamable = true, }, -- The Razza
	[12037] = { isTamable = true, }, -- Ursol'lok
	[12431] = { isTamable = true, }, -- Gorefang
	[12433] = { isTamable = true, }, -- Krethis the Shadowspinner
	[14222] = { isTamable = true, }, -- Araga
	[14223] = { isTamable = true, }, -- Cranky Benj
	[14228] = { isTamable = true, }, -- Giggler
	[14232] = { isTamable = true, }, -- Dart
	[14233] = { isTamable = true, }, -- Ripscale
	[14234] = { isTamable = true, }, -- Hayoc
	[14237] = { isTamable = true, }, -- Oozeworm
	[14266] = { isTamable = true, }, -- Shanda the Spinner
	[14268] = { isTamable = true, }, -- Lord Condar
	[14279] = { isTamable = true, }, -- Creepthess
	[14280] = { isTamable = true, }, -- Big Samras
	[14339] = { isTamable = true, }, -- Death Howl
	[14343] = { isTamable = true, }, -- Olm the Wise
	[14344] = { isTamable = true, }, -- Mongress
	[14430] = { isTamable = true, }, -- Duskstalker
	[14472] = { isTamable = true, }, -- Gretheer
	[14473] = { isTamable = true, }, -- Lapress
	[14474] = { isTamable = true, }, -- Zora
	[14475] = { isTamable = true, }, -- Rex Ashil
	[14476] = { isTamable = true, }, -- Krellack
	[14477] = { isTamable = true, }, -- Grubthor
	[14491] = { isTamable = true, }, -- Kurmokk
	[16180] = { isTamable = true, }, -- Shadikith the Glider
	[16181] = { isTamable = true, }, -- Rokad the Ravager
	[17144] = { hasAchievement = true, isTamable = true, }, -- Goretooth
	[18241] = { isTamable = true, }, -- Crusty
	[18677] = { hasAchievement = true, }, -- Mekthorg the Wild
	[18678] = { hasAchievement = true, }, -- Fulgorge
	[18679] = { hasAchievement = true, }, -- Vorakem Doomspeaker
	[18680] = { hasAchievement = true, isTamable = true, }, -- Marticar
	[18681] = { hasAchievement = true, }, -- Coilfang Emissary
	[18682] = { hasAchievement = true, }, -- Bog Lurker
	[18683] = { hasAchievement = true, }, -- Voidhunter Yar
	[18685] = { hasAchievement = true, }, -- Okrek
	[18686] = { hasAchievement = true, }, -- Doomsayer Jurim
	[18689] = { hasAchievement = true, }, -- Crippler
	[18690] = { hasAchievement = true, }, -- Morcrush
	[18692] = { hasAchievement = true, }, -- Hemathion
	[18693] = { hasAchievement = true, }, -- Speaker Mar'grom
	[18694] = { hasAchievement = true, }, -- Collidus the Warp-Watcher
	[18695] = { hasAchievement = true, }, -- Ambassador Jerrikar
	[18696] = { hasAchievement = true, }, -- Kraator
	[18697] = { hasAchievement = true, }, -- Chief Engineer Lorthander
	[18698] = { hasAchievement = true, }, -- Ever-Core the Punisher
	[20932] = { hasAchievement = true, isTamable = true, }, -- Nuramoc
	[21724] = { isTamable = true, }, -- Hawkbane
	[32357] = { hasAchievement = true, }, -- Old Crystalbark
	[32358] = { hasAchievement = true, }, -- Fumblub Gearwind
	[32361] = { hasAchievement = true, isTamable = true, }, -- Icehorn
	[32377] = { hasAchievement = true, }, -- Perobas the Bloodthirster
	[32386] = { hasAchievement = true, }, -- Vigdis the War Maiden
	[32398] = { hasAchievement = true, }, -- King Ping
	[32400] = { hasAchievement = true, }, -- Tukemuth
	[32409] = { hasAchievement = true, }, -- Crazed Indu'le Survivor
	[32417] = { hasAchievement = true, }, -- Scarlet Highlord Daion
	[32422] = { hasAchievement = true, }, -- Grocklar
	[32429] = { hasAchievement = true, }, -- Seething Hate
	[32438] = { hasAchievement = true, }, -- Syreian the Bonecarver
	[32447] = { hasAchievement = true, }, -- Zul'drak Sentinel
	[32471] = { hasAchievement = true, }, -- Griegen
	[32475] = { hasAchievement = true, isTamable = true, }, -- Terror Spinner
	[32481] = { hasAchievement = true, isTamable = true, }, -- Aotona
	[32485] = { hasAchievement = true, isTamable = true, }, -- King Krush
	[32487] = { hasAchievement = true, }, -- Putridus the Ancient
	[32495] = { hasAchievement = true, }, -- Hildana Deathstealer
	[32500] = { hasAchievement = true, }, -- Dirkee
	[32501] = { hasAchievement = true, }, -- High Thane Jorfus
	[32517] = { hasAchievement = true, isTamable = true, }, -- Loque'nahak
	[32630] = { hasAchievement = true, }, -- Vyragosa
	[33776] = { isTamable = true, }, -- Gondria
	[35189] = { isTamable = true, }, -- Skoll
	[38453] = { isTamable = true, }, -- Arcturis
	[39183] = { isTamable = true, }, -- Scorpitar
	[39185] = { isTamable = true, }, -- Slaverjaw
	[45380] = { isTamable = true, }, -- Ashtail
	[45402] = { isTamable = true, }, -- Nix
	[47386] = { isTamable = true, }, -- Ainamiss the Hive Queen
	[47387] = { isTamable = true, }, -- Harakiss the Infestor
	[49822] = { isTamable = true, }, -- Jadefang
	[50051] = { isTamable = true, }, -- Ghostcrawler
	[50058] = { isTamable = true, }, -- Terrorpene
	[50138] = { isTamable = true, }, -- Karoma
	[50154] = { isTamable = true, }, -- Madexx - Brown
	[50159] = { isTamable = true, }, -- Sambas
	[50328] = { isTamable = true, }, -- Fangor
	[50329] = { isTamable = true, }, -- Rrakk
	[50330] = { isTamable = true, }, -- Kree
	[50331] = { hasAchievement = true, }, -- Go-Kan
	[50332] = { hasAchievement = true, }, -- Korda Torros
	[50333] = { hasAchievement = true, }, -- Lon the Bull
	[50334] = { hasAchievement = true, }, -- Dak the Breaker
	[50335] = { isTamable = true, }, -- Alitus
	[50336] = { hasAchievement = true, }, -- Yorik Sharpeye
	[50337] = { isTamable = true, }, -- Cackle
	[50338] = { hasAchievement = true, }, -- Kor'nas Nightsavage
	[50339] = { hasAchievement = true, }, -- Sulik'shor
	[50340] = { hasAchievement = true, }, -- Gaarn the Toxic
	[50341] = { hasAchievement = true, }, -- Borginn Darkfist
	[50342] = { isTamable = true, }, -- Heronis
	[50343] = { isTamable = true, }, -- Quall
	[50344] = { hasAchievement = true, }, -- Norlaxx
	[50345] = { isTamable = true, }, -- Alit
	[50346] = { isTamable = true, }, -- Ronak
	[50347] = { hasAchievement = true, }, -- Karr the Darkener
	[50348] = { isTamable = true, }, -- Norissis
	[50349] = { hasAchievement = true, }, -- Kang the Soul Thief
	[50350] = { hasAchievement = true, }, -- Morgrinn Crackfang
	[50351] = { hasAchievement = true, }, -- Jonn-Dar
	[50352] = { hasAchievement = true, }, -- Qu'nas
	[50353] = { isTamable = true, }, -- Manas
	[50354] = { hasAchievement = true, }, -- Havak
	[50355] = { hasAchievement = true, }, -- Kah'tir
	[50356] = { hasAchievement = true, }, -- Krol the Blade
	[50357] = { isTamable = true, }, -- Sunwing
	[50358] = { hasAchievement = true, }, -- Haywire Sunreaver Construct
	[50359] = { hasAchievement = true, }, -- Urgolax
	[50361] = { isTamable = true, }, -- Ornat
	[50362] = { isTamable = true, }, -- Blackbog the Fang
	[50363] = { hasAchievement = true, }, -- Krax'ik
	[50364] = { hasAchievement = true, }, -- Nal'lak the Ripper
	[50370] = { isTamable = true, }, -- Karapax
	[50388] = { hasAchievement = true, }, -- Torik-Ethis
	[50724] = { isTamable = true, }, -- Spinecrawl
	[50725] = { isTamable = true, }, -- Azelisk
	[50726] = { isTamable = true, }, -- Kalixx
	[50727] = { isTamable = true, }, -- Strix the Barbed
	[50728] = { isTamable = true, }, -- Deathstrike
	[50730] = { isTamable = true, }, -- Venomspine
	[50731] = { isTamable = true, }, -- Needlefang
	[50733] = { hasAchievement = true, }, -- Ski'thik
	[50734] = { hasAchievement = true, }, -- Lith'ik the Stalker
	[50735] = { isTamable = true, }, -- Blinkeye the Rattler
	[50737] = { isTamable = true, }, -- Acroniss
	[50738] = { isTamable = true, }, -- Shimmerscale
	[50739] = { hasAchievement = true, }, -- Gar'lok
	[50741] = { isTamable = true, }, -- Kaxx
	[50742] = { isTamable = true, }, -- Qem
	[50743] = { isTamable = true, }, -- Manax
	[50744] = { isTamable = true, }, -- Qu'rik
	[50745] = { isTamable = true, }, -- Losaj
	[50746] = { isTamable = true, }, -- Bornix the Burrower
	[50747] = { isTamable = true, }, -- Tix
	[50748] = { isTamable = true, }, -- Nyaj
	[50749] = { hasAchievement = true, }, -- Kal'tik the Blight
	[50750] = { hasAchievement = true, }, -- Aethis
	[50752] = { isTamable = true, }, -- Tarantis
	[50759] = { isTamable = true, }, -- Iriss the Widow
	[50763] = { isTamable = true, }, -- Shadowstalker
	[50764] = { isTamable = true, }, -- Paraliss
	[50765] = { isTamable = true, }, -- Miasmiss
	[50766] = { hasAchievement = true, }, -- Sele'na
	[50768] = { hasAchievement = true, }, -- Cournith Waterstrider
	[50769] = { hasAchievement = true, }, -- Zai the Outcast
	[50770] = { isTamable = true, }, -- Zorn
	[50772] = { hasAchievement = true, }, -- Eshelon
	[50775] = { isTamable = true, }, -- Likk the Hunter
	[50776] = { hasAchievement = true, }, -- Nalash Verdantis
	[50777] = { isTamable = true, }, -- Needle
	[50778] = { isTamable = true, }, -- Ironweb
	[50779] = { isTamable = true, }, -- Sporeggon
	[50780] = { hasAchievement = true, }, -- Sahn Tidehunter
	[50782] = { hasAchievement = true, }, -- Sarnak
	[50783] = { hasAchievement = true, }, -- Salyin Warscout
	[50784] = { isTamable = true, }, -- Anith
	[50785] = { isTamable = true, }, -- Skyshadow
	[50786] = { isTamable = true, }, -- Sparkwing
	[50787] = { hasAchievement = true, }, -- Arness the Scale
	[50788] = { isTamable = true, }, -- Quetzl
	[50789] = { hasAchievement = true, }, -- Nessos the Oracle
	[50790] = { isTamable = true, }, -- Ionis
	[50791] = { hasAchievement = true, }, -- Siltriss the Sharpener
	[50792] = { isTamable = true, }, -- Chiaa
	[50797] = { isTamable = true, }, -- Yukiko
	[50803] = { isTamable = true, }, -- Bonechewer
	[50804] = { isTamable = true, }, -- Ripwing
	[50805] = { hasAchievement = true, }, -- Omnis Grinlok
	[50806] = { hasAchievement = true, }, -- Moldo One-Eye
	[50807] = { isTamable = true, }, -- Catal
	[50808] = { hasAchievement = true, }, -- Urobi the Walker
	[50809] = { isTamable = true, }, -- Heress
	[50810] = { isTamable = true, }, -- Favored of Isiset
	[50811] = { hasAchievement = true, }, -- Nasra Spothide
	[50812] = { isTamable = true, }, -- Arae
	[50813] = { isTamable = true, }, -- Fene-mal
	[50814] = { isTamable = true, }, -- Corpsefeeder
	[50815] = { isTamable = true, }, -- Skarr
	[50816] = { hasAchievement = true, }, -- Ruun Ghostpaw
	[50817] = { hasAchievement = true, }, -- Ahone the Wanderer
	[50818] = { isTamable = true, }, -- The Dark Prowler
	[50819] = { isTamable = true, }, -- Iceclaw
	[50820] = { hasAchievement = true, }, -- Yul Wildpaw
	[50821] = { hasAchievement = true, }, -- Ai-Li Skymirror
	[50822] = { hasAchievement = true, }, -- Ai-Ran the Shifting Cloud
	[50823] = { hasAchievement = true, }, -- Mister Ferocious
	[50825] = { isTamable = true, }, -- Feras
	[50828] = { hasAchievement = true, }, -- Bonobos
	[50830] = { hasAchievement = true, }, -- Spriggin
	[50831] = { hasAchievement = true, }, -- Scritch
	[50832] = { hasAchievement = true, }, -- The Yowler
	[50833] = { isTamable = true, }, -- Duskcoat
	[50836] = { hasAchievement = true, }, -- Ik-Ik the Nimble
	[50837] = { isTamable = true, }, -- Kash
	[50838] = { isTamable = true, }, -- Tabbs
	[50839] = { isTamable = true, }, -- Chromehound
	[50840] = { hasAchievement = true, }, -- Major Nanners
	[50842] = { isTamable = true, }, -- Magmagan
	[50843] = { isTamable = true, }, -- Portent
	[50846] = { isTamable = true, }, -- Slavermaw
	[50855] = { isTamable = true, }, -- Jaxx the Rabid
	[50856] = { isTamable = true, }, -- Snark
	[50858] = { isTamable = true, }, -- Dustwing
	[50864] = { isTamable = true, }, -- Thicket
	[50865] = { isTamable = true, }, -- Saurix
	[50874] = { isTamable = true, }, -- Tenok
	[50875] = { isTamable = true, }, -- Nychus
	[50876] = { isTamable = true, }, -- Avis
	[50882] = { isTamable = true, }, -- Chupacabros
	[50884] = { isTamable = true, }, -- Dustflight the Cowardly
	[50886] = { isTamable = true, }, -- Seawing
	[50891] = { isTamable = true, }, -- Boros
	[50892] = { isTamable = true, }, -- Cyn
	[50895] = { isTamable = true, }, -- Volux
	[50897] = { isTamable = true, }, -- Ffexk the Dunestalker
	[50901] = { isTamable = true, }, -- Teromak
	[50903] = { isTamable = true, }, -- Orlix the Swamplord
	[50905] = { isTamable = true, }, -- Cida
	[50906] = { isTamable = true, }, -- Mutilax
	[50908] = { isTamable = true, }, -- Nighthowl
	[50915] = { isTamable = true, }, -- Snort
	[50916] = { isTamable = true, }, -- Lamepaw the Whimperer
	[50922] = { isTamable = true, }, -- Warg
	[50925] = { isTamable = true, }, -- Grovepaw
	[50926] = { isTamable = true, }, -- Grizzled Ben
	[50929] = { isTamable = true, }, -- Little Bjorn
	[50930] = { isTamable = true, }, -- Hibernus the Sleeper
	[50931] = { isTamable = true, }, -- Mange
	[50937] = { isTamable = true, }, -- Hamhide
	[50940] = { isTamable = true, }, -- Swee
	[50942] = { isTamable = true, }, -- Snoot the Rooter
	[50945] = { isTamable = true, }, -- Scruff
	[50946] = { isTamable = true, }, -- Hogzilla
	[50947] = { isTamable = true, }, -- Varah
	[50948] = { isTamable = true, }, -- Crystalback
	[50949] = { isTamable = true, }, -- Finn's Gambit
	[50952] = { isTamable = true, }, -- Barnacle Jim
	[50955] = { isTamable = true, }, -- Carcinak
	[50957] = { isTamable = true, }, -- Hugeclaw
	[50959] = { isTamable = true, }, -- Karkin
	[50964] = { isTamable = true, }, -- Chops
	[50967] = { isTamable = true, }, -- Craw the Ravager
	[50986] = { isTamable = true, }, -- Goldenback
	[50993] = { isTamable = true, }, -- Gal'dorak
	[50995] = { isTamable = true, }, -- Bruiser
	[50997] = { isTamable = true, }, -- Bornak the Gorer
	[51000] = { isTamable = true, }, -- Blackshell the Impenetrable
	[51001] = { isTamable = true, }, -- Venomclaw
	[51002] = { isTamable = true, }, -- Scorpoxx
	[51004] = { isTamable = true, }, -- Toxx
	[51007] = { isTamable = true, }, -- Serkett
	[51008] = { isTamable = true, }, -- The Barbed Horror
	[51010] = { isTamable = true, }, -- Snips
	[51014] = { isTamable = true, }, -- Terrapis
	[51017] = { isTamable = true, }, -- Gezan
	[51018] = { isTamable = true, }, -- Zormus
	[51021] = { isTamable = true, }, -- Vorticus
	[51022] = { isTamable = true, }, -- Chordix
	[51025] = { isTamable = true, }, -- Dilennaa
	[51026] = { isTamable = true, }, -- Gnath
	[51027] = { isTamable = true, }, -- Spirocula
	[51028] = { isTamable = true, }, -- The Deep Tunneler
	[51029] = { isTamable = true, }, -- Parasitus
	[51031] = { isTamable = true, }, -- Tracker
	[51037] = { isTamable = true, }, -- Lost Gilnean Wardog
	[51040] = { isTamable = true, }, -- Snuffles
	[51042] = { isTamable = true, }, -- Bleakheart
	[51044] = { isTamable = true, }, -- Plague
	[51045] = { isTamable = true, }, -- Arcanus
	[51046] = { isTamable = true, }, -- Fidonis
	[51048] = { isTamable = true, }, -- Rexxus
	[51052] = { isTamable = true, }, -- Gib the Banana-Hoarder
	[51053] = { isTamable = true, }, -- Quirix
	[51057] = { isTamable = true, }, -- Weevil
	[51058] = { isTamable = true, }, -- Aphis
	[51059] = { hasAchievement = true, }, -- Blackhoof
	[51061] = { isTamable = true, }, -- Roth-Salam
	[51062] = { isTamable = true, }, -- Khep-Re
	[51063] = { isTamable = true, }, -- Phalanax
	[51066] = { isTamable = true, }, -- Crystalfang
	[51067] = { isTamable = true, }, -- Glint
	[51069] = { isTamable = true, }, -- Scintillex
	[51076] = { isTamable = true, }, -- Lopex
	[51077] = { isTamable = true, }, -- Bushtail
	[51078] = { hasAchievement = true, }, -- Ferdinand
	[51401] = { isTamable = true, }, -- Madexx - Red
	[51402] = { isTamable = true, }, -- Madexx - Green
	[51403] = { isTamable = true, }, -- Madexx - Black
	[51404] = { isTamable = true, }, -- Madexx - Blue
	[51661] = { isTamable = true, }, -- Tsul'Kalu
	[51662] = { isTamable = true, }, -- Mahamba
	[51663] = { isTamable = true, }, -- Pogeyan
	[52146] = { isTamable = true, }, -- Chitter
	[54318] = { isTamable = true, }, -- Ankha
	[54319] = { isTamable = true, }, -- Magria
	[54320] = { isTamable = true, }, -- Ban'thalos
	[54321] = { isTamable = true, }, -- Solix
	[54322] = { isTamable = true, }, -- Deth'tilac
	[54323] = { isTamable = true, }, -- Kirix
	[54324] = { isTamable = true, }, -- Skitterflame
	[54338] = { isTamable = true, }, -- Anthriss
	[54533] = { isTamable = true, }, -- Prince Lakma
	[58474] = { hasAchievement = true, isTamable = true, }, -- Bloodtip
	[58768] = { hasAchievement = true, }, -- Cracklefang
	[58769] = { hasAchievement = true, }, -- Vicejaw
	[58817] = { hasAchievement = true, }, -- Spirit of Lao-Fe
	[58949] = { hasAchievement = true, }, -- Bai'Jin the Butcher
	[62880] = { hasAchievement = true, }, -- Gochao the Ironfist
	[62881] = { hasAchievement = true, }, -- Gaohun the Soul-Severer
	[63101] = { hasAchievement = true, }, -- General Temuja
	[63240] = { hasAchievement = true, }, -- Shadowmaster Sydow
	[63509] = { hasAchievement = true, isTamable = true, }, -- Wulon
	[63510] = { hasAchievement = true, isTamable = true, }, -- Wulon
	[63691] = { hasAchievement = true, }, -- Huo-Shuang
	[63695] = { hasAchievement = true, }, -- Baolai the Immolator
	[63977] = { hasAchievement = true, }, -- Vyraxxis
	[63978] = { hasAchievement = true, }, -- Kri'chon
	[69996] = { hasAchievement = true, }, -- Ku'lai the Skyclaw
	[69997] = { hasAchievement = true, }, -- Progenitus
	[69998] = { hasAchievement = true, isTamable = true, }, -- Goda
	[69999] = { hasAchievement = true, }, -- God-Hulk Ramuk
	[70000] = { hasAchievement = true, }, -- Al'tabim the All-Seeing
	[70001] = { hasAchievement = true, }, -- Backbreaker Uru
	[70002] = { hasAchievement = true, }, -- Lu-Ban
	[70003] = { hasAchievement = true, }, -- Molthor
	[71665] = { questID = 32918, }, -- Giant-Slayer Kul
	[71721] = { questID = 32941, }, -- Canyon Icemother
	[71864] = { hasAchievement = true, }, -- Spelurk
	[71919] = { hasAchievement = true, }, -- Zhu-Gon the Sour
	[72045] = { hasAchievement = true, }, -- Chelon
	[72048] = { hasAchievement = true, }, -- Rattleskew
	[72049] = { hasAchievement = true, }, -- Cranegnasher
	[72193] = { hasAchievement = true, }, -- Karkanos
	[72245] = { hasAchievement = true, }, -- Zesqua
	[72294] = { questID = 33014, }, -- Cindermaw
	[72362] = { questID = 33039, }, -- Ku'targ the Voidseer
	[72364] = { questID = 33512, }, -- Gorg'ak the Lava Guzzler
	[72537] = { questID = 33055, }, -- Leaf-Reader Kurri
	[72606] = { questID = 34068, isTamable = true, }, -- Rockhoof
	[72769] = { hasAchievement = true, }, -- Spirit of Jadefire
	[72775] = { hasAchievement = true, }, -- Bufo
	[72808] = { hasAchievement = true, isTamable = true, }, -- Tsavo'ka
	[72909] = { hasAchievement = true, }, -- Gu'chi the Swarmbringer
	[72970] = { hasAchievement = true, }, -- Golganarr
	[73157] = { hasAchievement = true, }, -- Rock Moss
	[73158] = { hasAchievement = true, isTamable = true, }, -- Emerald Gander
	[73160] = { hasAchievement = true, }, -- Ironfur Steelhorn
	[73161] = { hasAchievement = true, isTamable = true, }, -- Great Turtle Furyshell
	[73163] = { hasAchievement = true, }, -- Imperial Python
	[73166] = { hasAchievement = true, isTamable = true, }, -- Monstrous Spineclaw
	[73167] = { hasAchievement = true, }, -- Huolon
	[73169] = { hasAchievement = true, }, -- Jakur of Ordon
	[73170] = { hasAchievement = true, }, -- Watcher Osu
	[73171] = { hasAchievement = true, }, -- Champion of the Black Flame
	[73172] = { hasAchievement = true, }, -- Flintlord Gairan
	[73173] = { hasAchievement = true, }, -- Urdur the Cauterizer
	[73174] = { hasAchievement = true, }, -- Archiereus of Flame
	[73175] = { hasAchievement = true, }, -- Cinderfall
	[73277] = { hasAchievement = true, }, -- Leafmender
	[73279] = { hasAchievement = true, }, -- Evermaw
	[73281] = { hasAchievement = true, }, -- Dread Ship Vazuvius
	[73282] = { hasAchievement = true, }, -- Garnia
	[73666] = { hasAchievement = true, }, -- Archiereus of Flame
	[73704] = { hasAchievement = true, }, -- Stinkbraid
	[73854] = { hasAchievement = true, }, -- Cranegnasher
	[74206] = { questID = 33043, isTamable = true, }, -- Killmaw
	[74613] = { questID = 33843, }, -- Broodmother Reeg'ak
	[74971] = { questID = 33504, }, -- Firefury Giant
	[75071] = { questID = 33642, }, -- Mother Om'ra
	[75434] = { questID = 33038, }, -- Windfang Matriarch
	[75435] = { questID = 33389, }, -- Yggdrel
	[75482] = { questID = 33640, isTamable = true, }, -- Veloss
	[75492] = { questID = 33643, }, -- Venomshade
	[76380] = { questID = 33664, }, -- Gorum
	[76473] = { questID = 34726, isTamable = true, }, -- Mother Araneae
	[76914] = { questID = 34131, isTamable = true, }, -- Coldtusk
	[76918] = { questID = 33938, }, -- Primalist Mur'og
	[77085] = { questID = 33064, }, -- Dark Emanation
	[77140] = { questID = 33061, isTamable = true, }, -- Amaukwa
	[77310] = { questID = 35906, }, -- Mad "King" Sporeon
	[77513] = { questID = 34129, isTamable = true, }, -- Coldstomp the Griever
	[77519] = { isTamable = true, }, -- Giantbane
	[77526] = { questID = 34132, }, -- Scout Goreseeker
	[77527] = { questID = 34133, }, -- The Beater
	[77529] = { questID = 34135, }, -- Yazheera the Incinerator
	[77561] = { questID = 34142, }, -- Dr. Gloom
	[77614] = { questID = 34145, }, -- Frenzied Golem
	[77620] = { questID = 34165, }, -- Cro Fleshrender
	[77626] = { questID = 34167, isTamable = true, }, -- Hen-Mother Hami
	[77634] = { questID = 34171, isTamable = true, }, -- Taladorantula
	[77664] = { questID = 34182, }, -- Aarko
	[77715] = { questID = 34185, isTamable = true, }, -- Hammertooth
	[77719] = { questID = 34189, isTamable = true, }, -- Glimmerwing
	[77741] = { questID = 34196, isTamable = true, }, -- Ra'kahn
	[77750] = { questID = 34199, }, -- Kaavu the Crimson Claw
	[77776] = { questID = 34205, }, -- Wandering Vindicator
	[77784] = { questID = 34208, }, -- Lo'marg Jawcrusher
	[77795] = { questID = 34221, }, -- Echo of Murmur
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
	[78872] = { questID = 34498, isTamable = true, }, -- Klikixx
	[79024] = { questID = 34645, }, -- Warmaster Blugthol
	[79104] = { questID = 34522, }, -- Ug'lok the Frozen
	[79145] = { questID = 34559, }, -- Yaga the Scarred
	[79334] = { questID = 34859, isTamable = true, }, -- No'losh
	[79485] = { questID = 34668, }, -- Talonpriest Zorkra
	[79524] = { questID = 35558, }, -- Hypnocroak
	[79543] = { questID = 34671, }, -- Shirzir
	[79629] = { questID = 35910, }, -- Stomper Kreego
	[79725] = { questID = 34727, }, -- Captain Ironbeard
	[79938] = { questID = 36478, }, -- Shadowbark
	[80057] = { questID = 36128, }, -- Soulfang
	[80122] = { questID = 34725, isTamable = true, }, -- Gaz'orda
	[80190] = { questID = 34825, }, -- Gruuk
	[80204] = { questID = 35018, }, -- Felbark
	[80235] = { questID = 34839, }, -- Gurun
	[80242] = { questID = 34843, isTamable = true, }, -- Chillfang
	[80312] = { questID = 34865, }, -- Grutush the Pillager
	[80370] = { questID = 37408, isTamable = true, }, -- Lernaea
	[80371] = { questID = 37405, }, -- Typhon
	[80372] = { questID = 37406, isTamable = true, }, -- Echidna
	[80398] = { questID = 37407, isTamable = true, }, -- Keravnos
	[80471] = { questID = 34929, isTamable = true, }, -- Gennadian
	[80524] = { questID = 34945, }, -- Underseer Bloodmane
	[80614] = { questID = 35599, }, -- Blade-Dancer Aeryx
	[80725] = { questID = 36394, }, -- Sulfurious
	[80868] = { questID = 36204, }, -- Glut
	[81038] = { questID = 36391, }, -- Gelgor of the Blue Flame
	[81406] = { questID = 35281, }, -- Bahameye
	[81639] = { questID = 33383, }, -- Brambleking Fili
	[82050] = { isTamable = true, }, -- Varasha
	[82058] = { questID = 37370, hasAchievement = true, }, -- Depthroot
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
	[82616] = { questID = 37386, isTamable = true, }, -- Jabberjaw
	[82617] = { questID = 37385, isTamable = true, }, -- Slogtusk the Corpse-Eater
	[82618] = { questID = 37384, }, -- Tor'goroth
	[82620] = { questID = 37383, }, -- Son of Goramal
	[82676] = { questID = 35688, }, -- Enavra
	[82742] = { questID = 35688, }, -- Enavra
	[82755] = { questID = 35712, }, -- Redclaw the Feral
	[82758] = { questID = 35714, isTamable = true, }, -- Greatfeather
	[82764] = { questID = 35715, }, -- Gar'lua
	[82778] = { questID = 35717, isTamable = true, }, -- Gnarlhoof the Rabid
	[82826] = { questID = 35735, }, -- Berserk T-300 Series Mark II
	[82899] = { questID = 35778, }, -- Ancient Blademaster
	[82912] = { questID = 35784, isTamable = true, }, -- Grizzlemaw
	[82920] = { questID = 37345, hasAchievement = true, }, -- Lord Korinak
	[82922] = { questID = 37343, hasAchievement = true, }, -- Xothear, the Destroyer
	[82930] = { questID = 37347, hasAchievement = true, }, -- Shadowflame Terrorwalker
	[82942] = { questID = 37346, hasAchievement = true, }, -- Lady Demlash
	[82975] = { questID = 35836, }, -- Fangler
	[82988] = { questID = 37348, hasAchievement = true, }, -- Kurlosh Doomfang
	[82992] = { questID = 37341, hasAchievement = true, }, -- Felfire Consort
	[82998] = { questID = 37349, hasAchievement = true, }, -- Matron of Sin
	[83008] = { questID = 37312, hasAchievement = true, }, -- Haakun the All-Consuming
	[83019] = { questID = 37340, hasAchievement = true, }, -- Gug'tol
	[83385] = { questID = 35847, }, -- Voidseer Kalurg
	[83401] = { questID = 35865, }, -- Netherspawn
	[83409] = { questID = 35875, }, -- Ophiis
	[83428] = { questID = 35877, }, -- Windcaller Korast
	[83483] = { questID = 35893, isTamable = true, }, -- Flinthide
	[83509] = { questID = 35898, }, -- Gorepetal
	[83522] = { questID = 35908, isTamable = true, }, -- Hive Queen Skrikka
	[83526] = { questID = 35900, }, -- Ru'klaa
	[83542] = { questID = 35912, }, -- Sean Whitesea
	[83553] = { questID = 35909, isTamable = true, }, -- Insha'tar
	[83591] = { questID = 35920, isTamable = true, }, -- Tura'aka
	[83603] = { questID = 35923, }, -- Hunter Blacktooth
	[83634] = { questID = 35931, }, -- Scout Pokhar
	[83643] = { questID = 35932, }, -- Malroc Stonesunder
	[83680] = { questID = 35943, }, -- Outrider Duretha
	[83683] = { hasAchievement = true, }, -- Mandragoraster
	[83691] = { hasAchievement = true, }, -- Panthora
	[83713] = { hasAchievement = true, }, -- Titarus
	[83819] = { hasAchievement = true, }, -- Brickhouse
	[83990] = { questID = 37394, }, -- Solar Magnifier
	[84110] = { hasAchievement = true, }, -- Korthall Soulgorger
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
	[84805] = { questID = 36265, isTamable = true, }, -- Stonespite
	[84807] = { questID = 36267, }, -- Durkath Steelmaw
	[84810] = { questID = 36268, }, -- Kalos the Bloodbathed
	[84833] = { questID = 36276, }, -- Sangrikass
	[84836] = { questID = 36278, }, -- Talonbreaker
	[84838] = { questID = 36279, }, -- Poisonmaster Bortusk
	[84856] = { questID = 36283, isTamable = true, }, -- Blightglow
	[84872] = { questID = 36288, }, -- Oskiira the Vengeful
	[84875] = { hasAchievement = true, }, -- Ancient Inferno
	[84887] = { questID = 36291, }, -- Betsi Boombasket
	[84890] = { questID = 36297, }, -- Festerbloom
	[84893] = { hasAchievement = true, isTamable = true, }, -- Goregore
	[84904] = { hasAchievement = true, }, -- Oraggro
	[84911] = { questID = 37351, }, -- Demidos
	[84912] = { questID = 36298, isTamable = true, }, -- Sunderthorn
	[84925] = { questID = 37352, }, -- Quartermaster Hershak
	[84951] = { questID = 36305, }, -- Gobblefin
	[84955] = { questID = 36306, isTamable = true, }, -- Jiasska the Sporegorger
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
	[85771] = { hasAchievement = true, }, -- Elder Darkweaver Kath
	[85837] = { questID = 37411, }, -- Slivermaw
	[85907] = { questID = 36597, isTamable = true, }, -- Berthora
	[85970] = { questID = 36600, isTamable = true, }, -- Riptar
	[86137] = { questID = 36656, }, -- Sunclaw
	[86257] = { questID = 37369, hasAchievement = true, }, -- Basten
	[86266] = { questID = 37372, hasAchievement = true, isTamable = true, }, -- Venolasix
	[86268] = { questID = 37371, hasAchievement = true, }, -- Alkali
	[86410] = { questID = 36794, }, -- Sylldross
	[86520] = { questID = 36837, isTamable = true, }, -- Stompalupagus
	[86549] = { questID = 36858, }, -- Steeltusk
	[86562] = { questID = 37363, hasAchievement = true, }, -- Maniacal Madgard
	[86566] = { questID = 37362, hasAchievement = true, }, -- Defector Dazgo
	[86571] = { questID = 37366, hasAchievement = true, }, -- Durp the Hated
	[86574] = { questID = 37367, hasAchievement = true, }, -- Inventor Blammo
	[86577] = { questID = 37365, hasAchievement = true, }, -- Horgg
	[86579] = { questID = 37368, hasAchievement = true, }, -- Blademaster Ro'gor
	[86582] = { questID = 37364, hasAchievement = true, }, -- Morgo Kain
	[86621] = { hasAchievement = true, }, -- Morphed Sentient
	[86689] = { questID = 36880, }, -- Sneevel
	[86724] = { questID = 36887, }, -- Hermit Palefur
	[86729] = { isTamable = true, }, -- Direhoof
	[86732] = { isTamable = true, }, -- Bergruu
	[86750] = { isTamable = true, }, -- Thek'talon
	[86774] = { isTamable = true, }, -- Aogexon
	[86835] = { isTamable = true, }, -- Xelganak
	[86959] = { questID = 37399, hasAchievement = true, }, -- Karosh Blackwind
	[86978] = { questID = 36943, }, -- Gaze
	[87019] = { questID = 37390, hasAchievement = true, }, -- Gluttonous Giant
	[87026] = { questID = 37391, hasAchievement = true, }, -- Mecha Plunderer
	[87027] = { questID = 37392, hasAchievement = true, }, -- Shadow Hulk
	[87029] = { questID = 37393, hasAchievement = true, }, -- Giga Sentinel
	[87234] = { questID = 37400, hasAchievement = true, }, -- Brutag Grimblade
	[87239] = { questID = 37473, hasAchievement = true, }, -- Krahl Deadeye
	[87344] = { questID = 37472, hasAchievement = true, }, -- Gortag Steelgrip
	[87348] = { questID = 37382, }, -- Hoarfrost
	[87351] = { questID = 37381, }, -- Mother of Goren
	[87352] = { questID = 37380, }, -- Gibblette the Cowardly
	[87356] = { questID = 37379, }, -- Vrok the Ancient
	[87357] = { questID = 37378, }, -- Valkor
	[87362] = { isTamable = true, }, -- Gibby
	[87597] = { questID = 37339, hasAchievement = true, }, -- Bombardier Gu'gok
	[87600] = { questID = 37556, }, -- Jaluk the Pacifist
	[87622] = { questID = 37402, }, -- Ogom the Mangler
	[87666] = { isTamable = true, }, -- Mu'gra
	[87668] = { questID = 37344, hasAchievement = true, }, -- Orumo the Observer
	[87788] = { questID = 37395, hasAchievement = true, }, -- Durg Spinecrusher
	[87837] = { questID = 37396, hasAchievement = true, }, -- Bonebreaker
	[87846] = { questID = 37397, hasAchievement = true, }, -- Pit Slayer
	[88043] = { questID = 37338, hasAchievement = true, }, -- Avatar of Socrethar
	[88071] = { questID = 37337, hasAchievement = true, }, -- Strategist Ankor
	[88208] = { questID = 37637, }, -- Pit Beast
	[88210] = { questID = 37398, hasAchievement = true, }, -- Krud the Eviscerator
	[88436] = { questID = 37350, hasAchievement = true, }, -- Vigilant Paarthos
	[88494] = { questID = 37342, hasAchievement = true, }, -- Legion Vanguard
	[88580] = { questID = 37373, hasAchievement = true, }, -- Firestarter Grash
	[88582] = { questID = 37374, hasAchievement = true, }, -- Swift Onyx Flayer
	[88583] = { questID = 37375, hasAchievement = true, }, -- Grove Warden Yal
	[88586] = { questID = 37376, hasAchievement = true, isTamable = true, }, -- Mogamago
	[88672] = { questID = 37377, hasAchievement = true, }, -- Hunter Bal'ra
	[88951] = { isTamable = true, }, -- Vileclaw
	[89675] = { questID = 38749, hasAchievement = true, }, -- Commander Org'mok
	[90024] = { questID = 37953, hasAchievement = true, }, -- Sergeant Mor'grak
	[90094] = { questID = 39046, hasAchievement = true, }, -- Harbormaster Korak
	[90122] = { questID = 39045, hasAchievement = true, }, -- Zoug the Heavy
	[90429] = { questID = 38026, hasAchievement = true, }, -- Imp-Master Valessa
	[90434] = { questID = 38031, hasAchievement = true, }, -- Ceraxas
	[90437] = { questID = 38030, hasAchievement = true, }, -- Jax'zor
	[90438] = { questID = 38029, hasAchievement = true, }, -- Lady Oran
	[90442] = { questID = 38032, hasAchievement = true, }, -- Mistress Thavra
	[90519] = { questID = 37990, hasAchievement = true, }, -- Cindral the Wildfire
	[90777] = { questID = 38028, }, -- High Priest Ikzan
	[90782] = { questID = 38034, hasAchievement = true, }, -- Rasthe
	[90884] = { questID = 38262, hasAchievement = true, }, -- Bilkor the Thrower
	[90885] = { questID = 38263, hasAchievement = true, }, -- Rogond the Tracker
	[90887] = { questID = 38265, hasAchievement = true, }, -- Dorg the Bloody
	[90888] = { questID = 38264, hasAchievement = true, }, -- Drivnul
	[90936] = { questID = 38266, hasAchievement = true, }, -- Bloodhunter Zulk
	[91009] = { questID = 38457, hasAchievement = true, }, -- Putre'thar
	[91087] = { questID = 38207, hasAchievement = true, }, -- Zeter'el
	[91093] = { questID = 38209, hasAchievement = true, }, -- Bramblefell
	[91098] = { questID = 38211, hasAchievement = true, }, -- Felspark
	[91227] = { questID = 39159, }, -- Remnant of the Blood Moon
	[91232] = { questID = 38746, hasAchievement = true, }, -- Commander Krag'goth
	[91243] = { questID = 38747, hasAchievement = true, }, -- Tho'gar Gorefist
	[91374] = { questID = 38282, hasAchievement = true, }, -- Podlord Wakkawam
	[91695] = { questID = 38400, hasAchievement = true, }, -- Grand Warlock Nethekurse
	[91727] = { questID = 38411, hasAchievement = true, }, -- Executor Riloth
	[91871] = { questID = 38430, hasAchievement = true, }, -- Argosh the Destroyer
	[92197] = { questID = 38496, hasAchievement = true, }, -- Relgor
	[92274] = { questID = 38557, hasAchievement = true, }, -- Painmistress Selora
	[92408] = { questID = 38579, hasAchievement = true, }, -- Xanzith the Everlasting
	[92411] = { questID = 38580, hasAchievement = true, }, -- Overlord Ma'gruth
	[92429] = { questID = 38589, hasAchievement = true, isTamable = true, }, -- Broodlord Ixkor
	[92451] = { questID = 37937, hasAchievement = true, }, -- Varyx the Damned
	[92465] = { questID = 38597, hasAchievement = true, }, -- The Blackfang
	[92495] = { questID = 38600, hasAchievement = true, }, -- Soulslicer
	[92508] = { questID = 38604, hasAchievement = true, }, -- Gloomtalon
	[92517] = { questID = 38605, hasAchievement = true, }, -- Krell the Serene
	[92552] = { questID = 38609, hasAchievement = true, }, -- Belgork
	[92574] = { questID = 38620, hasAchievement = true, }, -- Thromma the Gutslicer
	[92606] = { questID = 38628, hasAchievement = true, }, -- Sylissa
	[92627] = { questID = 38631, hasAchievement = true, isTamable = true, }, -- Rendrak
	[92636] = { questID = 38632, hasAchievement = true, }, -- The Night Haunter
	[92647] = { questID = 38634, hasAchievement = true, }, -- Felsmith Damorka
	[92657] = { questID = 38696, hasAchievement = true, }, -- Bleeding Hollow Horror
	[92694] = { questID = 38654, hasAchievement = true, isTamable = true, }, -- The Goreclaw
	[92887] = { questID = 38700, hasAchievement = true, isTamable = true, }, -- Steelsnout
	[92941] = { questID = 38709, hasAchievement = true, }, -- Gorabosh
	[92977] = { questID = 38751, hasAchievement = true, }, -- The Iron Houndmaster
	[93001] = { questID = 38752, hasAchievement = true, }, -- Szirek the Twisted
	[93002] = { questID = 38726, hasAchievement = true, isTamable = true, }, -- Magwia
	[93028] = { questID = 38736, hasAchievement = true, }, -- Driss Vile
	[93057] = { questID = 38750, hasAchievement = true, }, -- Grannok
	[93076] = { questID = 38756, hasAchievement = true, }, -- Captain Ironbeard
	[93125] = { questID = 38764, hasAchievement = true, }, -- Glub'glok
	[93168] = { questID = 38775, hasAchievement = true, }, -- Felbore
	[93236] = { questID = 38812, hasAchievement = true, isTamable = true, }, -- Shadowthrash
	[93264] = { questID = 38820, hasAchievement = true, }, -- Captain Grok'mar
	[93279] = { questID = 38825, hasAchievement = true, }, -- Kris'kar the Unredeemed
	[95044] = { questID = 39288, hasAchievement = true, }, -- Terrorfist
	[95053] = { questID = 39287, hasAchievement = true, }, -- Deathtalon
	[95054] = { questID = 39290, hasAchievement = true, }, -- Vengeance
	[95056] = { questID = 39289, hasAchievement = true, }, -- Doomroller
	[96323] = { questID = 39617, }, -- Arachnis
	[98198] = { questID = 40075, }, -- Rukdug
	[98199] = { questID = 40073, }, -- Pugg
	[98200] = { questID = 40074, }, -- Guk
	[98283] = { questID = 40105, }, -- Drakumd
	[98284] = { questID = 40106, }, -- Gondar
	[98285] = { questID = 40104, }, -- Smashum Grabb
	[98408] = { questID = 40107, }, -- Fel Overseer Mudlump
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
for achievementID, achievement in pairs(private.ACHIEVEMENTS) do
	for criteriaID, npcID in pairs(achievement.Criteria) do
		local npcName = _G.GetAchievementCriteriaInfoByID(achievementID, criteriaID)
		private.NPC_ID_TO_NAME[npcID] = npcName
		private.NPC_NAME_TO_ID[npcName] = npcID
	end
end


do
	local function TableKeyFormat(input)
		return input and input:upper():gsub(" ", "_"):gsub("'", ""):gsub(":", ""):gsub("-", "_"):gsub("%(", ""):gsub("%)", "") or ""
	end


	local function NumericSortString(a, b)
		local x, y = tonumber(a), tonumber(b)

		if x and y then
			return x < y
		end

		return a < b
	end

	function private.DumpNewTables()
		if not private.TextDump then
			return
		end

		local npcData = {}
		local mapNPCs = {}
		local npcIDs = {}
		local mapIDs = {}
		local mapIDRegistry = {}
		local mapLabels = {}

		for npcID, source in pairs(NPC_DATA) do
			local zoneLabel = TableKeyFormat(source.map_name)
			local mapID = private.ZONE_IDS[zoneLabel]

			if mapID then
				mapID = tostring(mapID)
			else
				mapID = ("%s_%s"):format(source.map_name, private.LOCALIZED_CONTINENT_IDS[source.world_id] or source.world_id)
			end

			mapLabels[mapID] = source.map_name

			if not mapIDRegistry[mapID] then
				mapIDRegistry[mapID] = true
				mapIDs[#mapIDs + 1] = mapID
			end

			mapNPCs[mapID] = mapNPCs[mapID] or {}
			mapNPCs[mapID][#mapNPCs[mapID] + 1] = npcID

			if source.is_tamable or source.is_achievement or source.quest_id then
				npcIDs[#npcIDs + 1] = npcID

				npcData[npcID] = {
					hasAchievement = source.is_achievement or nil,
					isTamable = source.is_tamable or nil,
					questID = source.quest_id or nil
				}
			end
		end

		table.sort(mapIDs, NumericSortString)

		local output = private.TextDump
		output:Clear()
		output:AddLine("local MapNPCs = {")

		for index = 1, #mapIDs do
			local mapID = mapIDs[index]
			table.sort(mapNPCs[mapID])

			output:AddLine("        -------------------------------------------------------------------------------")
			output:AddLine(("        -- %s"):format(mapLabels[mapID]))
			output:AddLine("        -------------------------------------------------------------------------------")

			output:AddLine(("        [%s] = {"):format(mapID))

			for index = 1, #mapNPCs[mapID] do
				local npcID = mapNPCs[mapID][index]
				output:AddLine(("                [%s] = true, -- %s"):format(npcID, private.L.NPCs[tostring(npcID)] or "**** NO LOCALIZATION ****"))
			end

			output:AddLine("        },")
		end

		output:AddLine("}")
		output:AddLine(" ")

		table.sort(npcIDs)

		output:AddLine("local NPCData = {")

		for index = 1, #npcIDs do
			local npcID = npcIDs[index]


			local valueString = ""

			for key, value in pairs(npcData[npcID]) do
				valueString = ("%s %s = %s,"):format(valueString, tostring(key), tostring(value))
			end

			output:AddLine(("        [%s] = {%s }, -- %s"):format(tostring(npcID), valueString, private.L.NPCs[tostring(npcID)] or "**** NO LOCALIZATION ****"))
		end

		output:AddLine("}")

		output:Display()
	end
end -- do-block

-- ----------------------------------------------------------------------------
-- AddOn namespace
-- ----------------------------------------------------------------------------
local AddOnFolderName, private = ...
local Maps = private.Data.Maps
local MapID = private.Enum.MapID

-- ----------------------------------------------------------------------------
-- Bloodmyst Isle
-- ----------------------------------------------------------------------------
Maps[MapID.BloodmystIsle].NPCs = {
    [22060] = true -- Fenissa the Assassin
}

-- ----------------------------------------------------------------------------
-- Durotar
-- ----------------------------------------------------------------------------
Maps[MapID.Durotar].NPCs = {
    [5809] = true, -- Sergeant Curtis
    [5822] = true, -- Felweaver Scornn
    [5823] = true, -- Death Flayer
    [5824] = true, -- Captain Flat Tusk
    [5826] = true -- Geolord Mottle
}

-- ----------------------------------------------------------------------------
-- Mulgore
-- ----------------------------------------------------------------------------
Maps[MapID.Mulgore].NPCs = {
    [3058] = true, -- Arra'chea
    [3068] = true, -- Mazzranache
    [5785] = true, -- Sister Hatelash
    [5786] = true, -- Snagglespear
    [5787] = true, -- Enforcer Emilgund
    [5807] = true, -- The Rake
    [43613] = true -- Doomsayer Wiserunner
}

-- ----------------------------------------------------------------------------
-- Northern Barrens
-- ----------------------------------------------------------------------------
Maps[MapID.NorthernBarrens].NPCs = {
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
    [5865] = true -- Dishu
}

-- ----------------------------------------------------------------------------
-- Teldrassil
-- ----------------------------------------------------------------------------
Maps[MapID.Teldrassil].NPCs = {
    [2162] = true, -- Agal
    [3535] = true, -- Blackmoss the Fetid
    [14428] = true, -- Uruson
    [14429] = true, -- Grimmaw
    [14430] = true, -- Duskstalker
    [14431] = true, -- Fury Shelda
    [14432] = true -- Threggil
}

-- ----------------------------------------------------------------------------
-- Darkshore
-- ----------------------------------------------------------------------------
Maps[MapID.Darkshore].NPCs = {
    [2172] = true, -- Strider Clutchmother
    [2175] = true, -- Shadowclaw
    [2184] = true, -- Lady Moongazer
    [2186] = true, -- Carnivous the Breaker
    [2191] = true, -- Licillin
    [2192] = true, -- Firecaller Radison
    [7015] = true, -- Flagglemurk the Cruel
    [7016] = true, -- Lady Vespira
    [7017] = true, -- Lord Sinslayer
    [144946] = true, -- Ivus the Forest Lord
    [147240] = true, -- Hydrath
    [147241] = true, -- Cyclarus
    [147260] = true, -- Conflagros
    [147261] = true, -- Granokk
    [147332] = true, -- Stonebinder Ssra'vess
    [147435] = true, -- Thelar Moonstrike
    [147664] = true, -- Zim'kaga
    [147701] = true, -- Moxo the Beheader
    [147708] = true, -- Athrikus Narassin
    [147744] = true, -- Amberclaw
    [147751] = true, -- Shattershard
    [147758] = true, -- Onu
    [147845] = true, -- Commander Drald
    [147897] = true, -- Soggoth the Slitherer
    [147942] = true, -- Twilight Prophet Graeme
    [147966] = true, -- Aman
    [147970] = true, -- Mrggr'marr
    [148025] = true, -- Commander Ral'esh
    [148031] = true, -- Gren Tornfur
    [148037] = true, -- Athil Dewfire
    [148103] = true, -- Sapper Odette
    [148295] = true, -- Ivus the Decayed
    [148787] = true, -- Alash'anir
    [148790] = true, -- Frightened Kodo
    [149141] = true, -- Burninator Mark V
    [149517] = true, -- Agathe Wyrmwood
    [149651] = true, -- Blackpaw
    [149652] = true, -- Agathe Wyrmwood
    [149654] = true, -- Glimmerspine
    [149655] = true, -- Croz Bloodrage
    [149656] = true, -- Grimhorn
    [149657] = true, -- Madfeather
    [149658] = true, -- Shadowclaw
    [149659] = true, -- Orwell Stevenson
    [149660] = true, -- Blackpaw
    [149661] = true, -- Croz Bloodrage
    [149662] = true, -- Grimhorn
    [149663] = true, -- Shadowclaw
    [149664] = true, -- Orwell Stevenson
    [149665] = true, -- Scalefiend   
}

-- ----------------------------------------------------------------------------
-- Ashenvale
-- ----------------------------------------------------------------------------
Maps[MapID.Ashenvale].NPCs = {
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
    [12037] = true -- Ursol'lok
}

-- ----------------------------------------------------------------------------
-- Thousand Needles
-- ----------------------------------------------------------------------------
Maps[MapID.ThousandNeedles].NPCs = {
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
    [51008] = true -- The Barbed Horror
}

-- ----------------------------------------------------------------------------
-- Stonetalon Mountains
-- ----------------------------------------------------------------------------
Maps[MapID.StonetalonMountains].NPCs = {
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
    [51062] = true -- Khep-Re
}

-- ----------------------------------------------------------------------------
-- Desolace
-- ----------------------------------------------------------------------------
Maps[MapID.Desolace].NPCs = {
    [11688] = true, -- Cursed Centaur
    [14225] = true, -- Prince Kellen
    [14226] = true, -- Kaskk
    [14227] = true, -- Hissperak
    [14228] = true, -- Giggler
    [14229] = true, -- Accursed Slitherblade
    [18241] = true -- Crusty
}

-- ----------------------------------------------------------------------------
-- Feralas
-- ----------------------------------------------------------------------------
Maps[MapID.Feralas].NPCs = {
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
	[39384] = true, -- Noxious Whelp
    [43488] = true, -- Mordei the Earthrender
    [54533] = true, -- Prince Lakma
    [90816] = true -- Skystormer
}

-- ----------------------------------------------------------------------------
-- Dustwallow Marsh
-- ----------------------------------------------------------------------------
Maps[MapID.DustwallowMarsh].NPCs = {
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
    [51069] = true -- Scintillex
}

-- ----------------------------------------------------------------------------
-- Tanaris
-- ----------------------------------------------------------------------------
Maps[MapID.Tanaris].NPCs = {
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
    [47387] = true -- Harakiss the Infestor
}

-- ----------------------------------------------------------------------------
-- Azshara
-- ----------------------------------------------------------------------------
Maps[MapID.Azshara].NPCs = {
    [6118] = true, -- Varo'then's Ghost
    [6648] = true, -- Antilos
    [6649] = true, -- Lady Sesspira
    [6650] = true, -- General Fangferror
    [6651] = true, -- Gatekeeper Rageroar
    [8660] = true, -- The Evalcharr
    [13896] = true, -- Scalebeard
    [107477] = true -- N.U.T.Z.
}

-- ----------------------------------------------------------------------------
-- Felwood
-- ----------------------------------------------------------------------------
Maps[MapID.Felwood].NPCs = {
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
    [107596] = true -- Grimrot
}

-- ----------------------------------------------------------------------------
-- Un'Goro Crater
-- ----------------------------------------------------------------------------
Maps[MapID.UnGoroCrater].NPCs = {
    [6581] = true, -- Ravasaur Matriarch
    [6582] = true, -- Clutchmother Zavas
    [6583] = true, -- Gruff
    [6584] = true, -- King Mosh
    [6585] = true -- Uhk'loc
}

-- ----------------------------------------------------------------------------
-- Silithus
-- ----------------------------------------------------------------------------
Maps[MapID.Silithus].NPCs = {
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
	[132578] = true, -- Qroshekx
	[132584] = true, -- Xaarshej
	[132580] = true, -- Ssinkrix
	[132591] = true, -- Ogmot the Mad
}

-- ----------------------------------------------------------------------------
-- Winterspring
-- ----------------------------------------------------------------------------
Maps[MapID.Winterspring].NPCs = {
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
    [51045] = true -- Arcanus
}

-- ----------------------------------------------------------------------------
-- Azuremyst Isle
-- ----------------------------------------------------------------------------
Maps[MapID.AzuremystIsle].NPCs = {
    [17591] = true -- Blood Elf Bandit
}

-- ----------------------------------------------------------------------------
-- Mount Hyjal
-- ----------------------------------------------------------------------------
Maps[MapID.MountHyjal].NPCs = {
    [50053] = true, -- Thartuk the Exile
    [50056] = true, -- Garr
    [50057] = true, -- Blazewing
    [50058] = true, -- Terrorpene
    [54318] = true, -- Ankha
    [54319] = true, -- Magria
    [54320] = true -- Ban'thalos
}

-- ----------------------------------------------------------------------------
-- Southern Barrens
-- ----------------------------------------------------------------------------
Maps[MapID.SouthernBarrens].NPCs = {
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
    [5864] = true -- Swinegart Spearhide
}

-- ----------------------------------------------------------------------------
-- Zul'Farrak
-- ----------------------------------------------------------------------------
Maps[MapID.ZulFarrak].NPCs = {
    [10080] = true, -- Sandarr Dunereaver
    [10081] = true, -- Dustwraith
    [10082] = true -- Zerillis
}

-- ----------------------------------------------------------------------------
-- Blackfathom Deeps
-- ----------------------------------------------------------------------------
Maps[MapID.BlackfathomDeeps].NPCs = {
    [12902] = true -- Lorgus Jett
}

-- ----------------------------------------------------------------------------
-- Dire Maul
-- ----------------------------------------------------------------------------
Maps[MapID.DireMaul].NPCs = {
    [11467] = true, -- Tsu'zee
    [14506] = true -- Lord Hel'nurath
}

-- ----------------------------------------------------------------------------
-- Uldum (249)
-- ----------------------------------------------------------------------------
Maps[MapID.Uldum].NPCs = {
    [50063] = true, -- Akma'hat
    [50064] = true, -- Cyrus the Black
    [50065] = true, -- Armagedillo
    [50154] = true, -- Madexx - Brown
    [51401] = true, -- Madexx - Red
    [51402] = true, -- Madexx - Green
    [51403] = true, -- Madexx - Black
    [51404] = true -- Madexx - Blue
}

-- ----------------------------------------------------------------------------
-- Uldum (1527)
-- ----------------------------------------------------------------------------
Maps[MapID.UldumBFA].NPCs = {
    [151609] = true, -- Sun Prophet Epaphos
    [151852] = true, -- Watcher Rehu
    [151878] = true, -- Sun King Nahkotep
    [151883] = true, -- Anaua
    [151897] = true, -- Sun Priestess Nubitt
    [151948] = true, -- Senbu the Pridefather
    [151995] = true, -- Hik-ten the Taskmaster
    [152040] = true, -- Scoutmaster Moswen
    [152431] = true, -- Kaneb-ti
    [152657] = true, -- Tat the Bonechewer
    [152677] = true, -- Nebet the Ascended
    [152757] = true, -- Atekhramun
    [152788] = true, -- Uat-ka the Sun's Wrath
    [154576] = true, -- Aqir Titanus
    [154578] = true, -- Aqir Flayer
    [154604] = true, -- Lord Aj'qirai
    [155531] = true, -- Infested Wastewander Captain
    [155703] = true, -- Anq'uri the Titanic
    [156078] = true, -- Magus Rehleth
    [156299] = true, -- R'khuzj the Unfathomable
    [156654] = true, -- Shol'thoss the Doomspeaker
    [156655] = true, -- Korzaran the Slaughterer
    [157120] = true, -- Fangtaker Orsa
    [157134] = true, -- Ishak of the Four Winds
    [157146] = true, -- Rotfeaster
    [157157] = true, -- Muminah the Incandescent
    [157164] = true, -- Zealot Tekem
    [157167] = true, -- Champion Sen-mat
    [157170] = true, -- Acolyte Taspu
    [157188] = true, -- The Tomb Widow
    [157390] = true, -- R'oyolok the Reality Eater
    [157469] = true, -- Zoth'rum the Intellect Pillager
    [157470] = true, -- R'aas the Anima Devourer
    [157472] = true, -- Aphrom the Guise of Madness
    [157473] = true, -- Yiphrim the Will Ravager
    [157476] = true, -- Shugshul the Flesh Gorger
    [157593] = true, -- Amalgamation of Flesh
    [158491] = true, -- Falconer Amenophis
    [158528] = true, -- High Guard Reshef
    [158531] = true, -- Corrupted Neferset Guard
    [158557] = true, -- Actiss the Deceiver
    [158594] = true, -- Doomsayer Vathiris
    [158595] = true, -- Thoughtstealer Vos
    [158597] = true, -- High Executor Yothrim
    [158632] = true, -- Corrupted Fleshbeast
    [158633] = true, -- Gaze of N'Zoth
    [158636] = true, -- The Grand Executor
    [159087] = true, -- Corrupted Bonestripper
    [160532] = true, -- Shoth the Darkened
    [160623] = true, -- Hungering Miasma
    [160631] = true, -- Hungering Miasma
    [161033] = true, -- Shadowmaw
    [162140] = true, -- Skikx'traz
    [162141] = true, -- Zuythiz
    [162142] = true, -- Qho
    [162147] = true, -- Corpse Eater
    [162163] = true, -- High Priest Ytaessis
    [162170] = true, -- Warcaster Xeshro
    [162171] = true, -- Captain Dunewalker
    [162172] = true, -- Aqir Warcaster
    [162173] = true, -- R'krox the Runt
    [162196] = true, -- Obsidian Annihilator
    [162254] = true, -- Corrupted Observer
    [162352] = true, -- Spirit of Dark Ritualist Zakahn
    [162370] = true, -- Armagedillo
    [162372] = true, -- Spirit of Cyrus the Black
    [162765] = true, -- Friendly Alpaca
}

-- ----------------------------------------------------------------------------
-- Old Hillsbrad Foothills
-- ----------------------------------------------------------------------------
Maps[MapID.OldHillsbradFoothills].NPCs = {
    [56081] = true -- Optimistic Benj
}

-- ----------------------------------------------------------------------------
-- Wailing Caverns
-- ----------------------------------------------------------------------------
Maps[MapID.WailingCaverns].NPCs = {
    [5912] = true -- Deviate Faerie Dragon
}

-- ----------------------------------------------------------------------------
-- Maraudon
-- ----------------------------------------------------------------------------
Maps[MapID.Maraudon].NPCs = {
    [12237] = true -- Meshlok the Harvester
}

-- ----------------------------------------------------------------------------
-- Razorfen Kraul
-- ----------------------------------------------------------------------------
Maps[MapID.RazorfenKraul].NPCs = {
    [4425] = true, -- Blind Hunter
    [4842] = true, -- Earthcaller Halmgar
    [75590] = true -- Enormous Bullfrog
}

-- ----------------------------------------------------------------------------
-- Ahn'Qiraj: The Fallen Kingdom
-- ----------------------------------------------------------------------------
Maps[MapID.AhnQirajTheFallenKingdom].NPCs = {
    [50747] = true -- Tix
}

-- ----------------------------------------------------------------------------
-- Molten Front
-- ----------------------------------------------------------------------------
Maps[MapID.MoltenFront].NPCs = {
    [50815] = true, -- Skarr
    [50959] = true, -- Karkin
    [54321] = true, -- Solix
    [54322] = true, -- Deth'tilac
    [54323] = true, -- Kirix
    [54324] = true, -- Skitterflame
    [54338] = true -- Anthriss
}

-- ----------------------------------------------------------------------------
-- Camp Narache
-- ----------------------------------------------------------------------------
Maps[MapID.CampNarache].NPCs = {
    [43720] = true -- "Pokey" Thornmantle
}

-- ----------------------------------------------------------------------------
-- The Exodar
-- ----------------------------------------------------------------------------
Maps[MapID.TheExodar].NPCs = {
    [110486] = true -- Huk'roth the Huntmaster
}

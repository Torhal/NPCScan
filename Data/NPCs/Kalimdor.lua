--------------------------------------------------------------------------------
---- AddOn Namespace
--------------------------------------------------------------------------------
local AddOnFolderName = ... ---@type string
local private = select(2, ...) ---@class PrivateNamespace

local NPCs = private.Data.NPCs
local NPCClassification = private.Enum.NPCClassification

--------------------------------------------------------------------------------
---- Ahn'Qiraj: The Fallen Kingdom (327)
--------------------------------------------------------------------------------
NPCs[50747] = {
    -- Tix
    classification = NPCClassification.Rare,
    isTameable = true,
}

--------------------------------------------------------------------------------
---- Ashenvale (63)
--------------------------------------------------------------------------------
NPCs[3735] = {
    -- Apothecary Falthis
    classification = NPCClassification.Rare,
    factionGroup = "Horde",
}

NPCs[3736] = {
    -- Darkslayer Mordenthal
    classification = NPCClassification.Rare,
    factionGroup = "Horde",
}

NPCs[10644] = {
    -- Mist Howler
    classification = NPCClassification.Rare,
    isTameable = true,
}

NPCs[12037] = {
    -- Ursol'lok
    classification = NPCClassification.Rare,
    isTameable = true,
}

--------------------------------------------------------------------------------
---- Azshara (76)
--------------------------------------------------------------------------------
NPCs[8660] = {
    -- The Evalcharr
    classification = NPCClassification.Rare,
    isTameable = true,
}

NPCs[13896] = {
    -- Scalebeard
    classification = NPCClassification.Rare,
    isTameable = true,
}

NPCs[107477] = {
    -- N.U.T.Z.
    classification = NPCClassification.Rare,
    isTameable = true,
}

--------------------------------------------------------------------------------
---- Darkshore (62)
--------------------------------------------------------------------------------
NPCs[2172] = {
    -- Strider Clutchmother
    classification = NPCClassification.Rare,
    isTameable = true,
}

NPCs[2175] = {
    -- Shadowclaw
    classification = NPCClassification.Rare,
    isTameable = true,
}

NPCs[144946] = {
    -- Ivus the Forest Lord
    classification = NPCClassification.RareElite,
    worldQuestID = 54896, -- Ivus the Forest Lord
}

NPCs[147240] = {
    -- Hydrath
    classification = NPCClassification.RareElite,
    pets = {
        {
            itemID = 166452, -- Bottled Essence of Hydrath
            npcID = 148841, -- Hydrath Droplet
        },
    },
    questID = 54228, -- Unknown
    vignetteID = 3351, -- Hydrath
}

NPCs[147241] = {
    -- Cyclarus
    classification = NPCClassification.RareElite,
    pets = {
        {
            itemID = 166448, -- Binding of Cyclarus
            npcID = 148784, -- Gust of Cyclarus
        },
    },
    questID = 54230, -- Unknown
    vignetteID = 3352, -- Cyclarus
}

NPCs[147260] = {
    -- Conflagros
    classification = NPCClassification.RareElite,
    pets = {
        {
            itemID = 166451, -- Rattling Bones
            npcID = 148825, -- Detective Ray
        },
    },
    questID = 54233, -- Unknown
    vignetteID = 3353, -- Conflagros
}

NPCs[147435] = {
    -- Thelar Moonstrike
    questID = 54252, -- Unknown
}

NPCs[147664] = {
    -- Zim'kaga
    questID = 54274, -- Unknown
}

NPCs[147701] = {
    -- Moxo the Beheader
    questID = 54277, -- Unknown
}

NPCs[147758] = {
    -- Onu
    questID = 54291, -- Unknown
}

NPCs[147845] = {
    -- Commander Drald
    questID = 54309, -- Unknown
}

NPCs[148037] = {
    -- Athil Dewfire
    questID = 54431, -- Unknown
}

NPCs[148103] = {
    -- Sapper Odette
    questID = 54452, -- Unknown
}

NPCs[148295] = {
    -- Ivus the Decayed
    questID = 54895, -- Ivus the Decayed
}

NPCs[148787] = {
    -- Alash'anir
    classification = NPCClassification.RareElite,
    isTameable = true,
    mounts = {
        {
            itemID = 166432, -- Ashenvale Chimaera
            spellID = 288495, -- Ashenvale Chimaera
        },
    },
    questID = 54696,
    vignetteID = 3392, -- Alash'anir
}

NPCs[148790] = {
    -- Frightened Kodo
    classification = NPCClassification.Normal,
    mounts = {
        {
            itemID = 166433, -- Frightened Kodo
            spellID = 288499, -- Frightened Kodo
        },
    },
}

NPCs[149141] = {
    -- Burninator Mark V
    questID = 54768, -- Unknown
}

NPCs[149517] = {
    -- Agathe Wyrmwood
    questID = 54883, -- Unknown
}

NPCs[149651] = {
    -- Blackpaw
    questID = 54890, -- Unknown
}

NPCs[149652] = {
    -- Agathe Wyrmwood
    questID = 54883, -- Unknown
}

NPCs[149655] = {
    -- Croz Bloodrage
    questID = 54886, -- Unknown
}

NPCs[149656] = {
    -- Grimhorn
    questID = 54891, -- Unknown
}

NPCs[149658] = {
    -- Shadowclaw
    questID = 54892, -- Unknown
}

NPCs[149659] = {
    -- Orwell Stevenson
    questID = 54889, -- Unknown
}

NPCs[149660] = {
    -- Blackpaw
    questID = 54890, -- Unknown
}

NPCs[149661] = {
    -- Croz Bloodrage
    questID = 54886, -- Unknown
}

NPCs[149662] = {
    -- Grimhorn
    questID = 54891, -- Unknown
}

NPCs[149663] = {
    -- Shadowclaw
    questID = 54892, -- Unknown
}

NPCs[149664] = {
    -- Orwell Stevenson
    questID = 54889, -- Unknown
}

--------------------------------------------------------------------------------
---- Desolace (66)
--------------------------------------------------------------------------------
NPCs[14227] = {
    -- Hissperak
    isTameable = true,
}

NPCs[14228] = {
    -- Giggler
    isTameable = true,
}

NPCs[18241] = {
    -- Crusty
    isTameable = true,
}

--------------------------------------------------------------------------------
---- Durotar (1)
--------------------------------------------------------------------------------
NPCs[5809] = {
    -- Sergeant Curtis
    factionGroup = "Alliance",
}

NPCs[5823] = {
    -- Death Flayer
    isTameable = true,
}

--------------------------------------------------------------------------------
---- Dustwallow Marsh (70)
--------------------------------------------------------------------------------
NPCs[4380] = {
    -- Darkmist Widow
    isTameable = true,
}

NPCs[14232] = {
    -- Dart
    isTameable = true,
}

NPCs[14233] = {
    -- Ripscale
    isTameable = true,
}

NPCs[14234] = {
    -- Hayoc
    isTameable = true,
}

NPCs[14237] = {
    -- Oozeworm
    isTameable = true,
}

NPCs[50342] = {
    -- Heronis
    isTameable = true,
}

NPCs[50735] = {
    -- Blinkeye the Rattler
    isTameable = true,
}

NPCs[50764] = {
    -- Paraliss
    isTameable = true,
}

NPCs[50784] = {
    -- Anith
    isTameable = true,
}

NPCs[50875] = {
    -- Nychus
    isTameable = true,
}

NPCs[50901] = {
    -- Teromak
    isTameable = true,
}

NPCs[50945] = {
    -- Scruff
    isTameable = true,
}

NPCs[50957] = {
    -- Hugeclaw
    isTameable = true,
}

NPCs[51061] = {
    -- Roth-Salam
    isTameable = true,
}

NPCs[51069] = {
    -- Scintillex
    isTameable = true,
}

--------------------------------------------------------------------------------
---- Felwood (77)
--------------------------------------------------------------------------------
NPCs[14339] = {
    -- Death Howl
    isTameable = true,
}

NPCs[14343] = {
    -- Olm the Wise
    isTameable = true,
}

NPCs[14344] = {
    -- Mongress
    isTameable = true,
}

NPCs[50362] = {
    -- Blackbog the Fang
    isTameable = true,
}

NPCs[50724] = {
    -- Spinecrawl
    isTameable = true,
}

NPCs[50777] = {
    -- Needle
    isTameable = true,
}

NPCs[50833] = {
    -- Duskcoat
    isTameable = true,
}

NPCs[50864] = {
    -- Thicket
    isTameable = true,
}

NPCs[50905] = {
    -- Cida
    isTameable = true,
}

NPCs[50925] = {
    -- Grovepaw
    isTameable = true,
}

NPCs[51017] = {
    -- Gezan
    isTameable = true,
}

NPCs[51025] = {
    -- Dilennaa
    isTameable = true,
}

NPCs[51046] = {
    -- Fidonis
    isTameable = true,
}

NPCs[107595] = {
    -- Grimrot
    isTameable = true,
}

NPCs[107596] = {
    -- Grimrot
    isTameable = true,
}

--------------------------------------------------------------------------------
---- Feralas (69)
--------------------------------------------------------------------------------
NPCs[5349] = {
    -- Arash-ethis
    isTameable = true,
}

NPCs[5350] = {
    -- Qirot
    isTameable = true,
}

NPCs[5352] = {
    -- Old Grizzlegut
    isTameable = true,
}

NPCs[5356] = {
    -- Snarler
    isTameable = true,
}

NPCs[11497] = {
    -- The Razza
    isTameable = true,
}

NPCs[39384] = {
    -- Noxious Whelp
    classification = NPCClassification.Normal,
    pets = {
        itemID = 8498, -- Emerald Whelpling
        npcID = 7545, -- Emerald Whelpling
    },
}

NPCs[54533] = {
    -- Prince Lakma
    isTameable = true,
}

NPCs[90816] = {
    -- Skystormer
    isTameable = true,
}

--------------------------------------------------------------------------------
---- Molten Front (338)
--------------------------------------------------------------------------------
NPCs[50815] = {
    -- Skarr
    isTameable = true,
}

NPCs[50959] = {
    -- Karkin
    isTameable = true,
}

NPCs[54321] = {
    -- Solix
    isTameable = true,
}

NPCs[54322] = {
    -- Deth'tilac
    isTameable = true,
}

NPCs[54323] = {
    -- Kirix
    isTameable = true,
}

NPCs[54324] = {
    -- Skitterflame
    isTameable = true,
}

NPCs[54338] = {
    -- Anthriss
    isTameable = true,
}

--------------------------------------------------------------------------------
---- Mount Hyjal (198)
--------------------------------------------------------------------------------
NPCs[50058] = {
    -- Terrorpene
    isTameable = true,
}

NPCs[54318] = {
    -- Ankha
    isTameable = true,
}

NPCs[54319] = {
    -- Magria
    isTameable = true,
}

NPCs[54320] = {
    -- Ban'thalos
    isTameable = true,
}

--------------------------------------------------------------------------------
---- Mulgore (7)
--------------------------------------------------------------------------------
NPCs[3058] = {
    -- Arra'chea
    isTameable = true,
}

NPCs[3068] = {
    -- Mazzranache
    isTameable = true,
}

NPCs[5807] = {
    -- The Rake
    isTameable = true,
}

--------------------------------------------------------------------------------
---- Northern Barrens (10)
--------------------------------------------------------------------------------
NPCs[3398] = {
    -- Gesharahan
    isTameable = true,
}

NPCs[3652] = {
    -- Trigore the Lasher
    isTameable = true,
}

NPCs[5828] = {
    -- Humar the Pridelord
    isTameable = true,
}

NPCs[5842] = {
    -- Takk the Leaper
    isTameable = true,
}

NPCs[5865] = {
    -- Dishu
    isTameable = true,
}

--------------------------------------------------------------------------------
---- Razorfen Kraul (301)
--------------------------------------------------------------------------------
NPCs[4425] = {
    -- Blind Hunter
    isTameable = true,
}

--------------------------------------------------------------------------------
---- Silithus (81)
--------------------------------------------------------------------------------
NPCs[14472] = {
    -- Gretheer
    isTameable = true,
}

NPCs[14473] = {
    -- Lapress
    isTameable = true,
}

NPCs[14474] = {
    -- Zora
    isTameable = true,
}

NPCs[14475] = {
    -- Rex Ashil
    isTameable = true,
}

NPCs[14476] = {
    -- Krellack
    isTameable = true,
}

NPCs[14477] = {
    -- Grubthor
    isTameable = true,
}

NPCs[50370] = {
    -- Karapax
    isTameable = true,
}

NPCs[50737] = {
    -- Acroniss
    isTameable = true,
}

NPCs[50742] = {
    -- Qem
    isTameable = true,
}

NPCs[50743] = {
    -- Manax
    isTameable = true,
}

NPCs[50744] = {
    -- Qu'rik
    isTameable = true,
}

NPCs[50745] = {
    -- Losaj
    isTameable = true,
}

NPCs[50746] = {
    -- Bornix the Burrower
    isTameable = true,
}

NPCs[50897] = {
    -- Ffexk the Dunestalker
    isTameable = true,
}

NPCs[51004] = {
    -- Toxx
    isTameable = true,
}

NPCs[54533] = {
    -- Prince Lakma
    isTameable = true,
}

NPCs[132578] = {
    -- Qroshekx
    questID = 50255, -- Unknown
}

NPCs[132580] = {
    -- Ssinkrix
    questID = 50223, -- Unknown
}

NPCs[132584] = {
    -- Xaarshej
    questID = 50224, -- Unknown
}

NPCs[132591] = {
    -- Ogmot the Mad
    questID = 50334, -- Unknown
}

--------------------------------------------------------------------------------
---- Southern Barrens (199)
--------------------------------------------------------------------------------
NPCs[3253] = {
    -- Silithid Harvester
    isTameable = true,
}

NPCs[5829] = {
    -- Snort the Heckler
    isTameable = true,
}

NPCs[5832] = {
    -- Thunderstomp
    isTameable = true,
}

NPCs[5834] = {
    -- Azzere the Skyblade
    isTameable = true,
}

NPCs[5847] = {
    -- Heggin Stonewhisker
    factionGroup = "Alliance",
}

NPCs[5848] = {
    -- Malgin Barleybrew
    factionGroup = "Alliance",
}

NPCs[5849] = {
    -- Digger Flameforge
    factionGroup = "Alliance",
}

NPCs[5851] = {
    -- Captain Gerogg Hammertoe
    factionGroup = "Alliance",
}

--------------------------------------------------------------------------------
---- Stonetalon Mountains (65)
--------------------------------------------------------------------------------
NPCs[50343] = {
    -- Quall
    isTameable = true,
}

NPCs[50759] = {
    -- Iriss the Widow
    isTameable = true,
}

NPCs[50786] = {
    -- Sparkwing
    isTameable = true,
}

NPCs[50812] = {
    -- Arae
    isTameable = true,
}

NPCs[50825] = {
    -- Feras
    isTameable = true,
}

NPCs[50874] = {
    -- Tenok
    isTameable = true,
}

NPCs[50884] = {
    -- Dustflight the Cowardly
    isTameable = true,
}

NPCs[50895] = {
    -- Volux
    isTameable = true,
}

NPCs[50986] = {
    -- Goldenback
    isTameable = true,
}

NPCs[51062] = {
    -- Khep-Re
    isTameable = true,
}

--------------------------------------------------------------------------------
---- Tanaris (71)
--------------------------------------------------------------------------------
NPCs[8204] = {
    -- Soriid the Devourer
    isTameable = true,
}

NPCs[8205] = {
    -- Haarka the Ravenous
    isTameable = true,
}

NPCs[8207] = {
    -- Emberwing
    isTameable = true,
}

NPCs[39183] = {
    -- Scorpitar
    isTameable = true,
}

NPCs[39185] = {
    -- Slaverjaw
    isTameable = true,
}

NPCs[39186] = {
    -- Hellgazer
    isTameable = true,
}

NPCs[47386] = {
    -- Ainamiss the Hive Queen
    isTameable = true,
}

NPCs[47387] = {
    -- Harakiss the Infestor
    isTameable = true,
}

--------------------------------------------------------------------------------
---- Teldrassil (57)
--------------------------------------------------------------------------------
NPCs[14430] = {
    -- Duskstalker
    isTameable = true,
}

--------------------------------------------------------------------------------
---- The Exodar (775)
--------------------------------------------------------------------------------
NPCs[110486] = {
    -- Huk'roth the Huntmaster
    questID = 43480, -- Huk'roth the Houndmaster
    vignetteID = 1506,
}

--------------------------------------------------------------------------------
---- Thousand Needles (64)
--------------------------------------------------------------------------------
NPCs[4132] = {
    -- Krkk'kx
    isTameable = true,
}

NPCs[5935] = {
    -- Ironeye the Invincible
    isTameable = true,
}

NPCs[5937] = {
    -- Vile Sting
    isTameable = true,
}

NPCs[50329] = {
    -- Rrakk
    isTameable = true,
}

NPCs[50727] = {
    -- Strix the Barbed
    isTameable = true,
}

NPCs[50741] = {
    -- Kaxx
    isTameable = true,
}

NPCs[50748] = {
    -- Nyaj
    isTameable = true,
}

NPCs[50785] = {
    -- Skyshadow
    isTameable = true,
}

NPCs[50892] = {
    -- Cyn
    isTameable = true,
}

NPCs[50952] = {
    -- Barnacle Jim
    isTameable = true,
}

NPCs[51001] = {
    -- Venomclaw
    isTameable = true,
}

NPCs[51008] = {
    -- The Barbed Horror
    isTameable = true,
}

--------------------------------------------------------------------------------
---- Uldum (249)
--------------------------------------------------------------------------------
NPCs[50154] = {
    -- Madexx
    isTameable = true,
}

NPCs[51401] = {
    -- Madexx
    isTameable = true,
}

NPCs[51402] = {
    -- Madexx
    isTameable = true,
}

NPCs[51403] = {
    -- Madexx
    isTameable = true,
}

NPCs[51404] = {
    -- Madexx
    isTameable = true,
}

--------------------------------------------------------------------------------
---- Uldum (1527)
--------------------------------------------------------------------------------
NPCs[151609] = {
    -- Sun Prophet Epaphos
    questID = 55353, -- Unknown
}

NPCs[151852] = {
    -- Watcher Rehu
    questID = 55461, -- Unknown
}

NPCs[151878] = {
    -- Sun King Nahkotep
    questID = 58613, -- Unknown
}

NPCs[151883] = {
    -- Anaua
    questID = 55468, -- Unknown
}

NPCs[151897] = {
    -- Sun Priestess Nubitt
    questID = 55479, -- Unknown
}

NPCs[151948] = {
    -- Senbu the Pridefather
    questID = 55496, -- Unknown
}

NPCs[151995] = {
    -- Hik-ten the Taskmaster
    questID = 55502, -- Unknown
}

NPCs[152040] = {
    -- Scoutmaster Moswen
    questID = 55518, -- Unknown
}

NPCs[152431] = {
    -- Kaneb-ti
    questID = 55629, -- Unknown
}

NPCs[152657] = {
    -- Tat the Bonechewer
    questID = 55682, -- Unknown
}

NPCs[152677] = {
    -- Nebet the Ascended
    questID = 55684, -- Unknown
}

NPCs[152757] = {
    -- Atekhramun
    questID = 55710, -- Unknown
}

NPCs[152788] = {
    -- Uat-ka the Sun's Wrath
    questID = 55716, -- Unknown
}

NPCs[154576] = {
    -- Aqir Titanus
    questID = 58614, -- Unknown
}

NPCs[154578] = {
    -- Aqir Flayer
    questID = 58612, -- Unknown
}

NPCs[154604] = {
    -- Lord Aj'qirai
    questID = 56340, -- Unknown
}

NPCs[155531] = {
    -- Infested Wastewander Captain
    questID = 56823, -- Unknown
}

NPCs[155703] = {
    -- Anq'uri the Titanic
    questID = 56834, -- Unknown
}

NPCs[156078] = {
    -- Magus Rehleth
    questID = 56952, -- Unknown
}

NPCs[156299] = {
    -- R'khuzj the Unfathomable
    questID = 57430, -- Unknown
}

NPCs[156654] = {
    -- Shol'thoss the Doomspeaker
    questID = 57432, -- Unknown
}

NPCs[156655] = {
    -- Korzaran the Slaughterer
    questID = 57433, -- Unknown
}

NPCs[157120] = {
    -- Fangtaker Orsa
    questID = 57258, -- Unknown
}

NPCs[157134] = {
    -- Ishak of the Four Winds
    questID = 57259, -- Unknown
}

NPCs[157146] = {
    -- Rotfeaster
    questID = 57273, -- Unknown
}

NPCs[157157] = {
    -- Muminah the Incandescent
    questID = 57277, -- Unknown
}

NPCs[157164] = {
    -- Zealot Tekem
    questID = 57279, -- Unknown
}

NPCs[157167] = {
    -- Champion Sen-mat
    questID = 57280, -- Unknown
}

NPCs[157170] = {
    -- Acolyte Taspu
    questID = 57281, -- Unknown
}

NPCs[157188] = {
    -- The Tomb Widow
    questID = 57285, -- Unknown
}

NPCs[157390] = {
    -- R'oyolok the Reality Eater
    questID = 57434, -- Unknown
}

NPCs[157469] = {
    -- Zoth'rum the Intellect Pillager
    questID = 57435, -- Unknown
}

NPCs[157470] = {
    -- R'aas the Anima Devourer
    questID = 57436, -- Unknown
}

NPCs[157472] = {
    -- Aphrom the Guise of Madness
    questID = 57437, -- Unknown
}

NPCs[157473] = {
    -- Yiphrim the Will Ravager
    questID = 57438, -- Unknown
}

NPCs[157476] = {
    -- Shugshul the Flesh Gorger
    questID = 57439, -- Unknown
}

NPCs[157593] = {
    -- Amalgamation of Flesh
    questID = 58330, -- Unknown
}

NPCs[158491] = {
    -- Falconer Amenophis
    questID = 57662, -- Unknown
}

NPCs[158528] = {
    -- High Guard Reshef
    questID = 57664, -- Unknown
}

NPCs[158531] = {
    -- Corrupted Neferset Guard
    questID = 57665, -- Unknown
}

NPCs[158557] = {
    -- Actiss the Deceiver
    questID = 57669, -- Unknown
}

NPCs[158594] = {
    -- Doomsayer Vathiris
    questID = 57672, -- Unknown
}

NPCs[158595] = {
    -- Thoughtstealer Vos
    questID = 57673, -- Unknown
}

NPCs[158597] = {
    -- High Executor Yothrim
    questID = 57675, -- Unknown
}

NPCs[158632] = {
    -- Corrupted Fleshbeast
    questID = 58691, -- Unknown
}

NPCs[158633] = {
    -- Gaze of N'Zoth
    questID = 57680, -- Unknown
}

NPCs[158636] = {
    -- The Grand Executor
    questID = 57688, -- Unknown
}

NPCs[159087] = {
    -- Corrupted Bonestripper
    questID = 57834, -- Unknown
}

NPCs[160532] = {
    -- Shoth the Darkened
    questID = 58169, -- Unknown
}

NPCs[160623] = {
    -- Hungering Miasma
    questID = 58206, -- Unknown
}

NPCs[160631] = {
    -- Hungering Miasma
    questID = 58206, -- Unknown
}

NPCs[161033] = {
    -- Shadowmaw
    questID = 58333, -- Unknown
}

NPCs[162140] = {
    -- Skikx'traz
    questID = 58697, -- Unknown
}

NPCs[162141] = {
    -- Zuythiz
    questID = 58695, -- Unknown
}

NPCs[162142] = {
    -- Qho
    questID = 58693, -- Unknown
}

NPCs[162147] = {
    -- Corpse Eater
    questID = 58696, -- Unknown
}

NPCs[162163] = {
    -- High Priest Ytaessis
    questID = 58701, -- Unknown
}

NPCs[162170] = {
    -- Warcaster Xeshro
    questID = 58702, -- Unknown
}

NPCs[162171] = {
    -- Captain Dunewalker
    questID = 58699, -- Unknown
}

NPCs[162172] = {
    -- Aqir Warcaster
    questID = 58694, -- Unknown
}

NPCs[162173] = {
    -- R'krox the Runt
    questID = 58864, -- Unknown
}

NPCs[162196] = {
    -- Obsidian Annihilator
    questID = 58681, -- Unknown
}

NPCs[162254] = {
    -- Corrupted Observer
    questID = 58691, -- Unknown
}

NPCs[162352] = {
    -- Spirit of Dark Ritualist Zakahn
    questID = 58716, -- Unknown
}

NPCs[162370] = {
    -- Armagedillo
    questID = 58718, -- Unknown
}

NPCs[162372] = {
    -- Spirit of Cyrus the Black
    questID = 58715, -- Unknown
}

NPCs[162765] = {
    -- Friendly Alpaca
    questID = 58879, -- Alpaca It Up
}

--------------------------------------------------------------------------------
---- Un'Goro Crater (78)
--------------------------------------------------------------------------------
NPCs[6581] = {
    -- Ravasaur Matriarch
    isTameable = true,
}

NPCs[6582] = {
    -- Clutchmother Zavas
    isTameable = true,
}

NPCs[6583] = {
    -- Gruff
    isTameable = true,
}

NPCs[6584] = {
    -- King Mosh
    isTameable = true,
}

NPCs[6585] = {
    -- Uhk'loc
    isTameable = true,
}

--------------------------------------------------------------------------------
---- Winterspring (83)
--------------------------------------------------------------------------------
NPCs[10200] = {
    -- Rak'shiri
    isTameable = true,
}

NPCs[10741] = {
    -- Sian-Rotam
    isTameable = true,
}

NPCs[50346] = {
    -- Ronak
    isTameable = true,
}

NPCs[50348] = {
    -- Norissis
    isTameable = true,
}

NPCs[50353] = {
    -- Manas
    isTameable = true,
}

NPCs[50788] = {
    -- Quetzl
    isTameable = true,
}

NPCs[50819] = {
    -- Iceclaw
    isTameable = true,
}

NPCs[50993] = {
    -- Gal'dorak
    isTameable = true,
}

NPCs[50995] = {
    -- Bruiser
    isTameable = true,
}

NPCs[50997] = {
    -- Bornak the Gorer
    isTameable = true,
}

NPCs[51028] = {
    -- The Deep Tunneler
    isTameable = true,
}

NPCs[51045] = {
    -- Arcanus
    isTameable = true,
}

--------------------------------------------------------------------------------
---- AddOn Namespace
--------------------------------------------------------------------------------

local AddOnFolderName = ... ---@type string
local private = select(2, ...) ---@class PrivateNamespace

local Maps = private.Data.Maps
local MapID = private.Enum.MapID

--------------------------------------------------------------------------------
---- Ardenweald (1565)
--------------------------------------------------------------------------------

Maps[MapID.Ardenweald].NPCs = {
    [160448] = true, -- Hunter Vivanna
    [161481] = true, -- Vinyeti
    [163229] = true, -- Dustbrawl
    [163370] = true, -- Gormbore
    [164093] = true, -- Macabre
    [164107] = true, -- Gormtamer Tizo
    [164112] = true, -- Humon'gozz
    [164147] = true, -- Wrigglemortis
    [164238] = true, -- Deifir the Untamed
    [164391] = true, -- Old Ardeite
    [164415] = true, -- Skuld Vit
    [164477] = true, -- Deathbinder Hroth
    [164547] = true, -- Mystic Rainbowhorn
    [165053] = true, -- Mymaen
    [167721] = true, -- The Slumbering Emperor
    [167724] = true, -- Rotbriar Changeling
    [167726] = true, -- Rootwrithe
    [167851] = true, -- Egg-Tender Leh'go
    [168135] = true, -- Night Mare
    [168647] = true, -- Valfir the Unrelenting
    [171206] = true, -- Playful Vulpin
    [171451] = true, -- Soultwister Cero
    [171688] = true, -- Faeflayer
}

--------------------------------------------------------------------------------
---- Bastion (1533)
--------------------------------------------------------------------------------

Maps[MapID.Bastion].NPCs = {
    [156339] = true, -- Eliminator Sotiros
    [156340] = true, -- Larionrider Orstus
    [158659] = true, -- Herculon
    [160629] = true, -- Baedos
    [160721] = true, -- Fallen Acolyte Erisne
    [160882] = true, -- Nikara Blackheart
    [160985] = true, -- Nikara the Reborn
    [161527] = true, -- Sigilback
    [161528] = true, -- Aethon
    [161529] = true, -- Nemaeus
    [161530] = true, -- Cloudtail
    [163460] = true, -- Dionae
    [167078] = true, -- Wingflayer the Cruel
    [170548] = true, -- Sundancer
    [170623] = true, -- Dark Watcher
    [170659] = true, -- Basilofos, King of the Hill
    [170832] = true, -- Champion of Loyalty
    [170833] = true, -- Champion of Wisdom
    [170834] = true, -- Champion of Purity
    [170835] = true, -- Champion of Courage
    [170836] = true, -- Champion of Humility
    [170932] = true, -- Cloudfeather Patriarch
    [171008] = true, -- Unstable Memory
    [171009] = true, -- Enforcer Aegeon
    [171010] = true, -- Corrupted Clawguard
    [171011] = true, -- Demi the Relic Hoarder
    [171013] = true, -- Embodied Hunger
    [171014] = true, -- Collector Astorestes
    [171040] = true, -- Xixin the Ravening
    [171041] = true, -- Worldfeaster Chronn
    [171189] = true, -- Bookkeeper Mnemis
    [171211] = true, -- Aspirant Eolis
    [171255] = true, -- Echo of Aella
    [171327] = true, -- Reekmonger
}

--------------------------------------------------------------------------------
---- Gromit Hollow (2007)
--------------------------------------------------------------------------------

Maps[MapID.GromitHollow].NPCs = {
    [177336] = true, -- Zelnithop
}

--------------------------------------------------------------------------------
---- Korthia (1961)
--------------------------------------------------------------------------------

Maps[MapID.Korthia].NPCs = {
    [177336] = true, -- Zelnithop
    [177903] = true, -- Dominated Protector
    [179108] = true, -- Kroke the Tormented
    [179472] = true, -- Konthrogz the Obliterator
    [179565] = true, -- Relic Gorger
    [179608] = true, -- Screaming Shade
    [179684] = true, -- Malbog
    [179755] = true, -- Consumption
    [179760] = true, -- Towering Exterminator
    [179768] = true, -- Consumption
    [179769] = true, -- Consumption
    [179802] = true, -- Yarxhov the Pillager
    [179859] = true, -- Xyraxz the Unknowable
    [179911] = true, -- Silent Soulstalker
    [179912] = true, -- Maelie the Wanderer
    [179913] = true, -- Deadsoul Hatcher
    [179914] = true, -- Observer Yorik
    [179931] = true, -- Relic Breaker Krelva
    [179974] = true, -- Drippy
    [179985] = true, -- Stygian Stonecrusher
    [180014] = true, -- Escaped Wilderling
    [180032] = true, -- Wild Worldcracker
    [180042] = true, -- Fleshwing
    [180160] = true, -- Reliwik the Defiant
    [180162] = true, -- Ve'rayn
    [180246] = true, -- Carriage Crusher
}

--------------------------------------------------------------------------------
---- Maldraxxus (1536)
--------------------------------------------------------------------------------

Maps[MapID.Maldraxxus].NPCs = {
    [157058] = true, -- Corspecutter Moroc
    [157125] = true, -- Zargox the Reborn
    [157294] = true, -- Pulsing Leech
    [157307] = true, -- Gelloh
    [157308] = true, -- Corrupted Sediment
    [157309] = true, -- Violet Mistake
    [157310] = true, -- Boneslurp
    [157311] = true, -- Burnblister
    [157312] = true, -- Oily Invertebrate
    [158406] = true, -- Scunner
    [159105] = true, -- Collector Kash
    [159753] = true, -- Ravenomous
    [159886] = true, -- Sister Chelicerae
    [160059] = true, -- Taskmaster Xox
    [161105] = true, -- Indomitable Schmitd
    [161857] = true, -- Nirvaska the Summoner
    [162180] = true, -- Thread Mistress Leeda
    [162528] = true, -- Smorgas the Feaster
    [162586] = true, -- Tahonta
    [162588] = true, -- Gristlebeak
    [162669] = true, -- Devour'us
    [162690] = true, -- Nerissa Heartless
    [162711] = true, -- Deadly Dapperling
    [162727] = true, -- Bubbleblood
    [162741] = true, -- Gieger
    [162767] = true, -- Pesticide
    [162797] = true, -- Deepscar
    [162819] = true, -- Warbringer Mal'Korak
    [168147] = true, -- Sabreil the Bonecleaver
    [168148] = true, -- Drolkrad
    [174108] = true, -- Necromantic Anomaly
}

--------------------------------------------------------------------------------
---- Revendreth (1525)
--------------------------------------------------------------------------------

Maps[MapID.Revendreth].NPCs = {
    [155779] = true, -- Tomb Burster
    [156916] = true, -- Inquisitor Sorin
    [156918] = true, -- Inquisitor Otilia
    [156919] = true, -- Inquisitor Petre
    [157726] = true, -- Scorched Scavenger
    [157727] = true, -- Scorched Outcast
    [157733] = true, -- Crazed Ash Ghoul
    [159151] = true, -- Inquisitor Traian
    [159152] = true, -- High Inquisitor Gabi
    [159153] = true, -- High Inquisitor Radu
    [159154] = true, -- High Inquisitor Magda
    [159155] = true, -- High Inquisitor Dacian
    [159156] = true, -- Grand Inquisitor Nicu
    [159157] = true, -- Grand Inquisitor Aurica
    [159496] = true, -- Forgemaster Madalav
    [159503] = true, -- Stonefist
    [160385] = true, -- Soulstalker Doina
    [160392] = true, -- Soulstalker Doina
    [160393] = true, -- Soulstalker Doina
    [160640] = true, -- Innervus
    [160675] = true, -- Scrivener Lenua
    [160821] = true, -- Worldedge Gorger
    [160857] = true, -- Sire Ladinas
    [161310] = true, -- Executioner Adrastia
    [161891] = true, -- Lord Mortegore
    [162481] = true, -- Sinstone Hoarder
    [164388] = true, -- Amalgamation of Light
    [165152] = true, -- Leeched Soul
    [165175] = true, -- Prideful Hulk
    [165206] = true, -- Endlurker
    [165253] = true, -- Tollkeeper Varaboss
    [165290] = true, -- Harika the Horrid
    [166292] = true, -- Bog Beast
    [166393] = true, -- Amalgamation of Filth
    [166521] = true, -- Famu the Infinite
    [166576] = true, -- Azgar
    [166679] = true, -- Hopecrusher
    [166710] = true, -- Executioner Aatron
    [166726] = true, -- Blistering Ash Ghoul
    [166993] = true, -- Huntmaster Petrus
    [167464] = true, -- Grand Arcanist Dimitri
    [170048] = true, -- Manifestation of Wrath
    [170434] = true, -- Amalgamation of Sin
    [173468] = true, -- Dead Blanchy
    [173499] = true, -- Loyal Gorger
}

--------------------------------------------------------------------------------
---- The Maw (1543)
--------------------------------------------------------------------------------

Maps[MapID.TheMaw].NPCs = {
    [154330] = true, -- Eternas the Tormentor
    [156203] = true, -- Stygian Incinerator
    [157833] = true, -- Borr-Geth
    [157964] = true, -- Adjutant Dekaris
    [158025] = true, -- Darklord Taraxis
    [158278] = true, -- Nascent Devourer
    [158314] = true, -- Drifting Sorrow
    [160770] = true, -- Darithis the Bleak
    [162452] = true, -- Dartanos
    [162829] = true, -- Razkazzar
    [162844] = true, -- Dath Rezara
    [162845] = true, -- Orrholyn
    [162849] = true, -- Morguliax
    [162965] = true, -- Huwerath
    [164064] = true, -- Obolos
    [165047] = true, -- Soulsmith Yol-Mattar
    [166398] = true, -- Soulforger Rhovus
    [168693] = true, -- Cyrixia
    [169102] = true, -- Agonix
    [169827] = true, -- Ekphoras, Herald of Grief
    [170301] = true, -- Apholeias, Herald of Loss
    [170302] = true, -- Talaporas, Herald of Pain
    [170303] = true, -- Exos, Herald of Domination
    [170634] = true, -- Shadeweaver Zeris
    [170692] = true, -- Krala
    [170711] = true, -- Dolos
    [170731] = true, -- Thanassos
    [170774] = true, -- Eketra
    [170787] = true, -- Akros
    [171316] = true, -- Malevolent Stygia
    [171317] = true, -- Conjured Death
    [172207] = true, -- Odalrik
    [172521] = true, -- Sanngror the Torturer
    [172523] = true, -- Houndmaster Vasanok
    [172524] = true, -- Skittering Broodmother
    [172577] = true, -- Orophea
    [172862] = true, -- Yero the Skittish
    [173086] = true, -- Valis the Cruel
    [174827] = true, -- Gorged Shadehound
    [175012] = true, -- Ikras the Devourer
    [175821] = true, -- Ratgusher
    [177444] = true, -- Ylva
    [179460] = true, -- Fallen Charger
    [179735] = true, -- Torglluun
    [179779] = true, -- Deomen the Vortex
    [179805] = true, -- Traitor Balthier
    [179851] = true, -- Guard Orguluus
    [179853] = true, -- Blinding Shadow
    [180246] = true, -- Carriage Crusher
}

--------------------------------------------------------------------------------
---- Zereth Mortis (1970)
--------------------------------------------------------------------------------

Maps[MapID.ZerethMortis].NPCs = {
    [178229] = true, -- Feasting
    [178508] = true, -- Mother Phestis
    [178563] = true, -- Hadeon the Stonebreaker
    [178778] = true, -- Gluttonous Overgrowth
    [178963] = true, -- Gorkek
    [179006] = true, -- Akkaris
    [179043] = true, -- Orixal
    [180746] = true, -- Protector of the First Ones
    [180917] = true, -- Destabilized Core
    [180924] = true, -- Garudeon
    [180978] = true, -- Hirukon
    [181249] = true, -- Tethos
    [181360] = true, -- Vexis
    [182114] = true, -- Iska, Outrider of Ruin
    [182155] = true, -- High Reaver Damaris
    [182158] = true, -- Reanimatrox Marzan
    [182318] = true, -- General Zarathura
    [183516] = true, -- The Engulfer
    [183596] = true, -- Chitali the Eldest
    [183646] = true, -- Furidian
    [183722] = true, -- Sorranos
    [183737] = true, -- Xy'rath the Covetous
    [183746] = true, -- Otiosen
    [183747] = true, -- Vitiane
    [183748] = true, -- Helmix
    [183764] = true, -- Zatojin
    [183814] = true, -- Otaris the Provoked
    [183925] = true, -- Tahkwitz
    [183927] = true, -- Sand Matriarch Ileus
    [183953] = true, -- Corrupted Architect
    [184409] = true, -- Euv'ouk
    [184413] = true, -- Shifting Stargorger
}

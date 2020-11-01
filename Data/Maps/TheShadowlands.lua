-- ----------------------------------------------------------------------------
-- AddOn namespace
-- ----------------------------------------------------------------------------
local AddOnFolderName, private = ...
local Maps = private.Data.Maps
local MapID = private.Enum.MapID

-- ----------------------------------------------------------------------------
-- Ardenweald
-- ----------------------------------------------------------------------------
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
    [171451] = true, -- Soultwister Cero
    [171688] = true, -- Faeflayer
}

-- ----------------------------------------------------------------------------
-- Bastion
-- ----------------------------------------------------------------------------
Maps[MapID.Bastion].NPCs = {
    [156339] = true, -- Eliminator Sotiros
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
    [170833] = true, -- Champion of Wisdom
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

-- ----------------------------------------------------------------------------
-- Maldraxxus
-- ----------------------------------------------------------------------------
Maps[MapID.Maldraxxus].NPCs = {
    [157058] = true, -- Corspecutter Moroc
    [157294] = true, -- Pulsing Leech
    [157308] = true, -- Corrupted Sediment
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

-- ----------------------------------------------------------------------------
-- Revendreth
-- ----------------------------------------------------------------------------
Maps[MapID.Revendreth].NPCs = {
    [155779] = true, -- Tomb Burster
    [156916] = true, -- Inquisitor Sorin
    [156919] = true, -- Inquisitor Petre
    [159151] = true, -- Inquisitor Traian
    [159152] = true, -- High Inquisitor Gabi
    [159153] = true, -- High Inquisitor Radu
    [159155] = true, -- High Inquisitor Dacian
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
    [166993] = true, -- Huntmaster Petrus
    [167464] = true, -- Grand Arcanist Dimitri
    [170048] = true, -- Manifestation of Wrath
    [170434] = true, -- Amalgamation of Sin
}

-- ----------------------------------------------------------------------------
-- The Maw
-- ----------------------------------------------------------------------------
Maps[MapID.TheMaw].NPCs = {
    [154330] = true, -- Eternas the Tormentor
    [157833] = true, -- Borr-Geth
    [157964] = true, -- Adjutant Dekaris
    [158025] = true, -- Darklord Taraxis
    [158278] = true, -- Nascent Devourer
    [160770] = true, -- Darithis the Bleak
    [162849] = true, -- Morguliax
    [164064] = true, -- Obolos
    [166398] = true, -- Soulforger Rhovus
    [168693] = true, -- Cyrixia
    [169827] = true, -- Ekphoras, Herald of Grief
    [170301] = true, -- Apholeias, Herald of Loss
    [170302] = true, -- Talaporas, Herald of Pain
    [170303] = true, -- Exos, Herald of Domination
    [170634] = true, -- Shadeweaver Zeris
    [170711] = true, -- Dolos
    [170731] = true, -- Thanassos
    [170774] = true, -- Eketra
    [171317] = true, -- Conjured Death
    [172577] = true, -- Orophea
    [172862] = true, -- Yero the Skittish
}

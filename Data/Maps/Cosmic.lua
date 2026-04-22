--------------------------------------------------------------------------------
---- AddOn Namespace
--------------------------------------------------------------------------------

local AddOnFolderName = ... ---@type string
local private = select(2, ...) ---@class PrivateNamespace

local Maps = private.Data.Maps
local MapID = private.Enum.MapID

--------------------------------------------------------------------------------
---- Atal'Aman (2536)
--------------------------------------------------------------------------------

Maps[MapID.AtalAman].NPCs = {
    [247976] = true, -- Poacher Rav'ik
}

--------------------------------------------------------------------------------
---- Eversong Woods (2395)
--------------------------------------------------------------------------------

Maps[MapID.EversongWoodsMidnight].NPCs = {
    [240129] = true, -- Overfester Hydra
    [244762] = true, -- Lu'ashal
    [246332] = true, -- Warden of Weeds
    [246633] = true, -- Harried Hawkstrider
    [250582] = true, -- Bloated Snapdragon
    [250683] = true, -- Coralfang
    [250719] = true, -- Cre'van
    [250754] = true, -- Lady Liminus
    [250780] = true, -- Waverly
    [250806] = true, -- Lost Guardian
    [250826] = true, -- Banuran
    [250841] = true, -- Bad Zed
    [250876] = true, -- Terrinor
    [255302] = true, -- Duskburn
    [255329] = true, -- Malfunctioning Construct
    [255348] = true, -- Dame Bloodshed
}

--------------------------------------------------------------------------------
---- Exile's Reach (1409)
--------------------------------------------------------------------------------

Maps[MapID.ExilesReach].NPCs = {
    [156676] = true, -- Ogre Overseer
    [156986] = true, -- Ogre Taskmaster
}

--------------------------------------------------------------------------------
---- Harandar (2413)
--------------------------------------------------------------------------------

Maps[MapID.Harandar].NPCs = {
    [248741] = true, -- Rhazul
    [249776] = true, -- Thorm'belan
    [249844] = true, -- Chironex
    [249849] = true, -- Ha'kalawe
    [249902] = true, -- Tallcap the Truthspreader
    [249962] = true, -- Queen Lashtongue
    [249997] = true, -- Chlorokyll
    [250086] = true, -- Stumpy
    [250180] = true, -- Serrasa
    [250226] = true, -- Mindrot
    [250231] = true, -- Dracaena
    [250246] = true, -- Treetop
    [250317] = true, -- Oro'ohna
    [250321] = true, -- Pterrock
    [250347] = true, -- Ahl'ua'huhi
    [250358] = true, -- Annulus the Worldshaker
}

--------------------------------------------------------------------------------
---- Isle of Quel'Danas (2424)
--------------------------------------------------------------------------------

Maps[MapID.IsleOfQuelDanas].NPCs = {
    [239864] = true, -- Dripping Shadow
    [252465] = true, -- Tarhu the Ransacker
}

--------------------------------------------------------------------------------
---- Slayer's Rise (2444)
--------------------------------------------------------------------------------

Maps[MapID.SlayersRise].NPCs = {
    [245182] = true, -- Eruundi
    [257027] = true, -- Rakshur the Bonegrinder
    [257199] = true, -- Hardin Steellock
    [257231] = true, -- Gar'chak Skullcleave
}

--------------------------------------------------------------------------------
---- Torghast - Entrance (1705)
--------------------------------------------------------------------------------

Maps[MapID.TorghastEntrance].NPCs = {
    [152500] = true, -- Deadsoul Amalgam
    [152508] = true, -- Dusky Tremorbeast
    [152517] = true, -- Deadsoul Lifetaker
    [152612] = true, -- Subjugator Klontzas
    [156134] = true, -- Ghastly Charger
    [156142] = true, -- Seeker of Souls
    [156158] = true, -- Adjutant Felipos
    [156237] = true, -- Imperator Dara
    [170228] = true, -- Bone Husk
    [170385] = true, -- Writhing Misery
    [170414] = true, -- Howling Spectre
    [170417] = true, -- Animated Stygia
    [173051] = true, -- Suppressor Xelors
    [173080] = true, -- Wandering Death
    [173134] = true, -- Darksworn Goliath
    [173191] = true, -- Soulstalker V'lara
    [173238] = true, -- Deadsoul Strider
}

--------------------------------------------------------------------------------
---- Uncharted Island (1022)
--------------------------------------------------------------------------------

Maps[MapID.UnchartedIsland].NPCs = {
    [138948] = true, -- Akakakoo
}

--------------------------------------------------------------------------------
---- Voidstorm (2405)
--------------------------------------------------------------------------------

Maps[MapID.Voidstorm].NPCs = {
    [238498] = true, -- Territorial Voidscythe
    [241443] = true, -- Tremora
    [244272] = true, -- Sundereth the Caller
    [245044] = true, -- Nightbrood
    [245182] = true, -- Eruundi
    [248068] = true, -- Nullspiral
    [248459] = true, -- The Many-Broken
    [248700] = true, -- Abysslick
    [248791] = true, -- Voidseer Orivane
    [248823] = true, -- Blackcore
    [248864] = true, -- Predaxas
    [256770] = true, -- Bilemaw the Gluttonous
    [256808] = true, -- Ravengerus
    [256821] = true, -- Far'thana the Mad
    [256922] = true, -- Screammaxa the Matriarch
    [256923] = true, -- Bane of the Vilebloods
    [256924] = true, -- Aeonelle Blackstar
    [256925] = true, -- Lotus Darkblossom
    [256926] = true, -- Queen o' War
    [257027] = true, -- Rakshur the Bonegrinder
    [257199] = true, -- Hardin Steellock
    [257231] = true, -- Gar'chak Skullcleave
}

--------------------------------------------------------------------------------
---- Zul'Aman (2437)
--------------------------------------------------------------------------------

Maps[MapID.ZulAman].NPCs = {
    [242023] = true, -- Necrohexxer Raz'ka
    [242024] = true, -- The Snapping Scourge
    [242025] = true, -- Skullcrusher Harak
    [242026] = true, -- Elder Oaktalon
    [242027] = true, -- Depthborn Eelamental
    [242028] = true, -- Lightwood Borer
    [242031] = true, -- Spinefrill
    [242032] = true, -- Oophaga
    [242033] = true, -- Tiny Vermin
    [242034] = true, -- Voidtouched Crustacean
    [242035] = true, -- The Devouring Invader
    [244424] = true, -- Cragpine
    [245691] = true, -- The Decaying Diamondback
    [245692] = true, -- Ash'an the Empowered
    [245975] = true, -- Mrrlokk
    [247976] = true, -- Poacher Rav'ik
}

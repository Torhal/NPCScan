--------------------------------------------------------------------------------
---- AddOn Namespace
--------------------------------------------------------------------------------

local AddOnFolderName = ... ---@type string
local private = select(2, ...) ---@class PrivateNamespace

local Maps = private.Data.Maps
local MapID = private.Enum.MapID

--------------------------------------------------------------------------------
---- Exile's Reach (1409)
--------------------------------------------------------------------------------

Maps[MapID.ExilesReach].NPCs = {
    [156676] = true, -- Gork the Basher
    [156986] = true, -- Ogre Taskmaster
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

--------------------------------------------------------------------------------
---- AddOn Namespace
--------------------------------------------------------------------------------

local AddOnFolderName = ... ---@type string
local private = select(2, ...) ---@class PrivateNamespace

local Maps = private.Data.Maps
local MapID = private.Enum.MapID

--------------------------------------------------------------------------------
---- Blade's Edge Mountains (105)
--------------------------------------------------------------------------------

Maps[MapID.BladesEdgeMountains].NPCs = {
    [18690] = true, -- Morcrush
    [18692] = true, -- Hemathion
    [18693] = true, -- Speaker Mar'grom
}

--------------------------------------------------------------------------------
---- Hellfire Peninsula (100)
--------------------------------------------------------------------------------

Maps[MapID.HellfirePeninsula].NPCs = {
    [18677] = true, -- Mekthorg the Wild
    [18678] = true, -- Fulgorge
    [18679] = true, -- Vorakem Doomspeaker
}

--------------------------------------------------------------------------------
---- Nagrand (107)
--------------------------------------------------------------------------------

Maps[MapID.NagrandOutland].NPCs = {
    [17144] = true, -- Goretooth
    [18683] = true, -- Voidhunter Yar
    [18684] = true, -- Bro'Gaz the Clanless
}

--------------------------------------------------------------------------------
---- Netherstorm (109)
--------------------------------------------------------------------------------

Maps[MapID.Netherstorm].NPCs = {
    [18697] = true, -- Chief Engineer Lorthander
    [18698] = true, -- Ever-Core the Punisher
    [20932] = true, -- Nuramoc
}

--------------------------------------------------------------------------------
---- Shadowmoon Valley (104)
--------------------------------------------------------------------------------

Maps[MapID.ShadowmoonValleyOutland].NPCs = {
    [18694] = true, -- Collidus the Warp-Watcher
    [18695] = true, -- Ambassador Jerrikar
    [18696] = true, -- Kraator
}

--------------------------------------------------------------------------------
---- Terokkar Forest (108)
--------------------------------------------------------------------------------

Maps[MapID.TerokkarForest].NPCs = {
    [18685] = true, -- Okrek
    [18686] = true, -- Doomsayer Jurim
    [18689] = true, -- Crippler
    [21724] = true, -- Hawkbane
}

--------------------------------------------------------------------------------
---- Zangarmarsh (102)
--------------------------------------------------------------------------------

Maps[MapID.Zangarmarsh].NPCs = {
    [18680] = true, -- Marticar
    [18681] = true, -- Coilfang Emissary
    [18682] = true, -- Bog Lurker
}

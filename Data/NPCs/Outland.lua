--------------------------------------------------------------------------------
---- AddOn Namespace
--------------------------------------------------------------------------------
local AddOnFolderName = ... ---@type string
local private = select(2, ...) ---@class PrivateNamespace

local NPCs = private.Data.NPCs

--------------------------------------------------------------------------------
---- Zangarmarsh
--------------------------------------------------------------------------------
NPCs[18680] = {
    -- Marticar
    isTameable = true,
}

--------------------------------------------------------------------------------
---- Nagrand
--------------------------------------------------------------------------------
NPCs[17144] = {
    -- Goretooth
    isTameable = true,
}

--------------------------------------------------------------------------------
---- Terokkar Forest
--------------------------------------------------------------------------------
NPCs[21724] = {
    -- Hawkbane
    isTameable = true,
}

--------------------------------------------------------------------------------
---- Netherstorm
--------------------------------------------------------------------------------
NPCs[20932] = {
    -- Nuramoc
    isTameable = true,
}

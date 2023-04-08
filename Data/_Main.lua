--------------------------------------------------------------------------------
---- Lua globals
--------------------------------------------------------------------------------
local rawset = _G.rawset
local setmetatable = _G.setmetatable

--------------------------------------------------------------------------------
---- AddOn Namespace
--------------------------------------------------------------------------------
local AddOnFolderName = ... ---@type string
local private = select(2, ...) ---@class PrivateNamespace

--------------------------------------------------------------------------------
---- Constants
--------------------------------------------------------------------------------
local addTableMeta = {
    __index = function(t, mapID)
        if mapID < 0 then
            return
        end

        local new = {}
        rawset(t, mapID, new)

        return new
    end,
}

private.Data = {
    Continents = {},
    Maps = setmetatable({}, addTableMeta),
    NPCs = {},
    Scanner = {
        continentID = nil,
        mapID = nil,
        NPCCount = 0,
        NPCs = {},
    },
}

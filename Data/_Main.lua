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
    Maps = setmetatable({}, addTableMeta), ---@type table<integer, MapData>
    NPCs = {}, ---@type table<integer, NPCData>
    Scanner = {
        continentID = nil,
        mapID = nil,
        NPCCount = 0,
        NPCs = {}, ---@type table<integer, NPCData>
    },
}

--------------------------------------------------------------------------------
---- Data Types
--------------------------------------------------------------------------------

---@class MapData
---@field continentID integer
---@field ID integer
---@field isDungeon? boolean
---@field name string
---@field NPCs table<integer, NPCData>

--------------------------------------------------------------------------------
---- AddOn Namespace
--------------------------------------------------------------------------------

local AddOnFolderName = ... ---@type string
local private = select(2, ...) ---@class PrivateNamespace

--------------------------------------------------------------------------------
---- Constants
--------------------------------------------------------------------------------

local addTableMeta = {
    __index = function(t, input)
        local mapID = tonumber(input) or -1
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

    ---@type table<integer, MapData>
    Maps = setmetatable({}, addTableMeta),

    ---@type table<integer, NPCData>
    NPCs = {},

    ---@type ScannerData
    Scanner = {
        continentID = nil,
        mapID = nil,
        NPCCount = 0,
        NPCs = {},
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
---@field NPCs table<integer, NPCData | boolean>

---@class ScannerData
---@field continentID? integer
---@field mapID? integer
---@field NPCCount integer
---@field NPCs table<integer, NPCData>

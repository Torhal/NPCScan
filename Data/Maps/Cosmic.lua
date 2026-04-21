--------------------------------------------------------------------------------
---- AddOn Namespace
--------------------------------------------------------------------------------

local AddOnFolderName = ... ---@type string
local private = select(2, ...) ---@class PrivateNamespace

local Maps = private.Data.Maps
local MapID = private.Enum.MapID

--------------------------------------------------------------------------------
---- Uncharted Island (1022)
--------------------------------------------------------------------------------

Maps[MapID.UnchartedIsland].NPCs = {
    [138948] = true, -- Akakakoo
}

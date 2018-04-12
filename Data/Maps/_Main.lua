-- ----------------------------------------------------------------------------
-- Localized Lua globals.
-- ----------------------------------------------------------------------------
-- Functions
local pairs = _G.pairs

-- Libraries
local table = _G.table

-- -- ---------------------------------------------------------------------------------
-- AddOn namespace.
-- -- ---------------------------------------------------------------------------------
local AddOnFolderName, private = ...
local Data = private.Data

local function SortByMapNameThenByID(a, b)
	local mapNameA = Data.Maps[a].name
	local mapNameB = Data.Maps[b].name

	if mapNameA == mapNameB then
		return a < b
	end

	return mapNameA < mapNameB
end

private.SortByMapNameThenByID = SortByMapNameThenByID

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

-- TODO: Nuke this.
local AlphabeticalContinentMaps = {}
private.AlphabeticalContinentMaps = AlphabeticalContinentMaps

for mapID, mapData in pairs(Data.Maps) do
	local continentID = mapData.continentID

	AlphabeticalContinentMaps[continentID] = AlphabeticalContinentMaps[continentID] or {}
	AlphabeticalContinentMaps[continentID][#AlphabeticalContinentMaps[continentID] + 1] = mapID
end

local function SortByMapNameThenByID(a, b)
	local mapNameA = Data.Maps[a].name
	local mapNameB = Data.Maps[b].name

	if mapNameA == mapNameB then
		return a < b
	end

	return mapNameA < mapNameB
end

private.SortByMapNameThenByID = SortByMapNameThenByID

for index = 1, #AlphabeticalContinentMaps do
	table.sort(AlphabeticalContinentMaps[index], SortByMapNameThenByID)
end



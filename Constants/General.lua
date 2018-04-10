-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local AddOnFolderName, private = ...
local ContinentID = private.Enum.ContinentID

-- ----------------------------------------------------------------------------
-- General constants.
-- ----------------------------------------------------------------------------
private.DEFAULT_OS_SPAWN_POINT = _G.IsMacClient() and "TOPRIGHT" or "BOTTOMRIGHT"
private.NUM_RAID_ICONS = 8

private.ContinentIDByDungeonMapID = {
	[686] = ContinentID.Kalimdor, -- Zul'Farrak
	[687] = ContinentID.EasternKingdoms, -- The Temple of Atal'Hakkar
	[688] = ContinentID.Kalimdor, -- Blackfathom Deeps
	[691] = ContinentID.EasternKingdoms, -- Gnomeregan
	[699] = ContinentID.Kalimdor, -- Dire Maul
	[704] = ContinentID.EasternKingdoms, -- Blackrock Depths
	[721] = ContinentID.EasternKingdoms, -- Blackrock Spire
	[734] = ContinentID.Kalimdor, -- Old Hillsbrad Foothills
	[749] = ContinentID.Kalimdor, -- Wailing Caverns
	[750] = ContinentID.Kalimdor, -- Maraudon
	[756] = ContinentID.EasternKingdoms, -- The Deadmines
	[761] = ContinentID.Kalimdor, -- Razorfen Kraul
	[764] = ContinentID.EasternKingdoms, -- Shadowfang Keep
	[765] = ContinentID.EasternKingdoms, -- Stratholme
	[795] = ContinentID.Kalimdor, -- Molten Front
	[799] = ContinentID.EasternKingdoms, -- Karazhan
	[898] = ContinentID.EasternKingdoms, -- Scholomance
	[930] = ContinentID.Pandaria, -- Throne of Thunder
	[995] = ContinentID.EasternKingdoms, -- Upper Blackrock Spire
	[1022] = ContinentID.BrokenIsles, -- Helheim
	[1028] = ContinentID.BrokenIsles, -- Mardum, the Shattered Abyss
	[1032] = ContinentID.BrokenIsles, -- Vault of the Wardens
	[1041] = ContinentID.BrokenIsles, -- Halls of Valor
	[1046] = ContinentID.BrokenIsles, -- Eye of Azshara
	[1067] = ContinentID.BrokenIsles, -- Darkheart Thicket
	[1091] = ContinentID.Kalimdor, -- The Exodar (Scenario version)
}

-- ----------------------------------------------------------------------------
-- Preferences.
-- ----------------------------------------------------------------------------
private.DetectionGroupStatusLabels = {
	_G.ENABLE,
	_G.CUSTOM,
	_G.DISABLE,
}

private.DetectionGroupStatusColors = {
	_G.GREEN_FONT_COLOR_CODE,
	_G.NORMAL_FONT_COLOR_CODE,
	_G.RED_FONT_COLOR_CODE,
}

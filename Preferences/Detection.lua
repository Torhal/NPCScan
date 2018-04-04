-- ----------------------------------------------------------------------------
-- Localized Lua globals.
-- ----------------------------------------------------------------------------
-- Functions
local pairs = _G.pairs

-- Libraries
local table = _G.table

-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local AddOnFolderName, private = ...

local LibStub = _G.LibStub
local NPCScan = LibStub("AceAddon-3.0"):GetAddon(AddOnFolderName)
local L = LibStub("AceLocale-3.0"):GetLocale(AddOnFolderName)

local AceConfigRegistry = LibStub("AceConfigRegistry-3.0")

-- ----------------------------------------------------------------------------
-- Constants.
-- ----------------------------------------------------------------------------
local ContinentIDs = {}

for index = 1, #private.ContinentMapID do
	ContinentIDs[#ContinentIDs + 1] = index
end

table.sort(ContinentIDs, function(a, b)
	return private.ContinentNameByID[a] < private.ContinentNameByID[b]
end)

-- ----------------------------------------------------------------------------
-- Variables.
-- ----------------------------------------------------------------------------
local profile

-- ----------------------------------------------------------------------------
-- Helpers.
-- ----------------------------------------------------------------------------
-- ----------------------------------------------------------------------------
-- Ignored continent options.
-- ----------------------------------------------------------------------------
local ContinentAndMapOptions = {}

local function UpdateContinentAndMapOptions()
	table.wipe(ContinentAndMapOptions)

	for continentIndex = 1, #ContinentIDs do
		local continentID = ContinentIDs[continentIndex]
		local continentStatus = profile.detection.continentIDs[continentID]

		local continentOptionsTable = {
			order = continentIndex,
			name = ("%s%s|r"):format(private.DetectionGroupStatusColors[continentStatus], private.ContinentNameByID[continentID]),
			descStyle = "inline",
			type = "group",
			childGroups = "tab",
			args = {
				status = {
					order = 1,
					name = _G.STATUS,
					type = "select",
					values = private.DetectionGroupStatusLabels,
					get = function(info)
						return profile.detection.continentIDs[continentID]
					end,
					set = function(info, value)
						profile.detection.continentIDs[continentID] = value

						if value ~= private.DetectionGroupStatus.UserDefined then
							for mapID in pairs(private.ContinentMaps[continentID]) do
								profile.blacklist.mapIDs[mapID] = nil
							end
						end

						UpdateContinentAndMapOptions()

						private.UpdateRareNPCOptions()
						private.UpdateTameableRareNPCOptions()

						if continentID == private.scannerData.continentID then
							NPCScan:UpdateScanList()
						end
					end,
				},
				zoneMapIDs = {
					order = 2,
					name = _G.ZONE,
					type = "group",
					args = {},
				},
			},
		}

		for mapIDIndex = 1, #private.AlphabeticalContinentMaps[continentID] do
			local mapID = private.AlphabeticalContinentMaps[continentID][mapIDIndex]
			local dungeonContinentID = private.ContinentIDByDungeonMapID[mapID]

			local mapOptions = {
				order = mapIDIndex,
				name = private.GetMapOptionName(mapID),
				desc = ("%s %s"):format(_G.ID, mapID),
				type = "toggle",
				width = "full",
				descStyle = "inline",
				disabled = function()
					return profile.detection.continentIDs[continentID] ~= private.DetectionGroupStatus.UserDefined
				end,
				get = function(info)
					return not profile.blacklist.mapIDs[mapID]
				end,
				set = function(info, value)
					profile.blacklist.mapIDs[mapID] = not profile.blacklist.mapIDs[mapID] and true or nil

					UpdateContinentAndMapOptions()

					private.UpdateRareNPCOptions()
					private.UpdateTameableRareNPCOptions()

					AceConfigRegistry:NotifyChange(AddOnFolderName)

					if mapID == private.scannerData.mapID then
						NPCScan:UpdateScanList()
					end
				end,
			}

			if dungeonContinentID then
				local dungeonOptionsTable = continentOptionsTable.args.dungeonMapIDs

				if not dungeonOptionsTable then
					dungeonOptionsTable = {
						order = 3,
						name = _G.DUNGEONS,
						type = "group",
						args = {},
					}

					continentOptionsTable.args.dungeonMapIDs = dungeonOptionsTable
				end

				dungeonOptionsTable.args["mapID" .. mapID] = mapOptions
			else
				continentOptionsTable.args.zoneMapIDs.args["mapID" .. mapID] = mapOptions
			end
		end

		ContinentAndMapOptions["continentID" .. continentID] = continentOptionsTable
	end

	AceConfigRegistry:NotifyChange(AddOnFolderName)
end

-- ----------------------------------------------------------------------------
-- Initialization.
-- ----------------------------------------------------------------------------
local DetectionOptions

local function GetDetectionOptions()
	profile = private.db.profile

	DetectionOptions = DetectionOptions or {
		name = L["Detection"],
		order = 2,
		type = "group",
		childGroups = "tab",
		args = {
			general = {
				order = 1,
				name = _G.GENERAL_LABEL,
				type = "group",
				args = {
					interval = {
						order = 1,
						name = L["Interval"],
						desc = L["The number of minutes before an NPC will be detected again."],
						type = "range",
						width = "full",
						min = 0.5,
						max = 60,
						get = function(info)
							return profile.detection.intervalSeconds / 60
						end,
						set = function(info, value)
							profile.detection.intervalSeconds = value * 60
						end,
					},
					ignore = {
						order = 2,
						name = _G.IGNORE,
						type = "group",
						guiInline = true,
						args = {
							completedAchievementCriteria = {
								order = 1,
								type = "toggle",
								name = L["Completed Achievement Criteria"],
								descStyle = "inline",
								width = "full",
								get = function(info)
									return profile.detection.ignoreCompletedAchievementCriteria
								end,
								set = function(info, value)
									profile.detection.ignoreCompletedAchievementCriteria = value
									NPCScan:UpdateScanList()
								end,
							},
							completedQuestObjectives = {
								order = 2,
								type = "toggle",
								name = L["Completed Quest Objectives"],
								descStyle = "inline",
								width = "full",
								get = function(info)
									return profile.detection.ignoreCompletedQuestObjectives
								end,
								set = function(info, value)
									profile.detection.ignoreCompletedQuestObjectives = value
									NPCScan:UpdateScanList()
								end,
							},
							deadNPCs = {
								order = 3,
								type = "toggle",
								name = L["Dead NPCs"],
								descStyle = "inline",
								width = "full",
								get = function(info)
									return profile.detection.ignoreDeadNPCs
								end,
								set = function(info, value)
									profile.detection.ignoreDeadNPCs = value
									NPCScan:UpdateScanList()
								end,
							},
							miniMap = {
								order = 4,
								type = "toggle",
								name = _G.MINIMAP_LABEL,
								descStyle = "inline",
								width = "full",
								get = function(info)
									return profile.detection.ignoreMiniMap
								end,
								set = function(info, value)
									profile.detection.ignoreMiniMap = value
									NPCScan:UpdateScanList()
								end,
							},
							worldMap = {
								order = 5,
								type = "toggle",
								name = _G.WORLD_MAP,
								descStyle = "inline",
								width = "full",
								get = function(info)
									return profile.detection.ignoreWorldMap
								end,
								set = function(info, value)
									profile.detection.ignoreWorldMap = value
									NPCScan:UpdateScanList()
								end,
							}
						},
					},
				},
			},
			continentsAndMaps = {
				order = 2,
				name = _G.CONTINENT,
				type = "group",
				childGroups = "tree",
				args = ContinentAndMapOptions,
			},
		},
	}

	UpdateContinentAndMapOptions()

	return DetectionOptions
end

private.GetDetectionOptions = GetDetectionOptions

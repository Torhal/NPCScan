-- ----------------------------------------------------------------------------
-- Localized Lua globals.
-- ----------------------------------------------------------------------------
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
-- Variables.
-- ----------------------------------------------------------------------------
local profile

-- ----------------------------------------------------------------------------
-- Helpers.
-- ----------------------------------------------------------------------------
local function SortByContinentName(a, b)
	return private.ContinentNameByID[a] < private.ContinentNameByID[b]
end

-- ----------------------------------------------------------------------------
-- Ignored continent options.
-- ----------------------------------------------------------------------------
local IgnoredContinentOptions = {}

local function UpdateIgnoredContinentOptions()
	table.wipe(IgnoredContinentOptions)

	local continentIDs = {}
	for index = 1, #private.ContinentMapID do
		continentIDs[#continentIDs + 1] = index
	end

	table.sort(continentIDs, SortByContinentName)

	for index = 1, #continentIDs do
		local continentID = continentIDs[index]

		IgnoredContinentOptions["continentEntry" .. index] = {
			order = index,
			name = private.ContinentNameByID[continentID],
			descStyle = "inline",
			type = "toggle",
			get = function(info)
				return profile.blacklist.continentIDs[continentID]
			end,
			set = function(info, value)
				profile.blacklist.continentIDs[continentID] = value or nil

				if continentID == private.currentContinentID then
					NPCScan:UpdateScanList()
				end
			end,
		}
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
		descStyle = "inline",
		args = {
			interval = {
				order = 10,
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
			type = {
				order = 20,
				name = _G.TYPE,
				type = "group",
				guiInline = true,
				args = {
					rares = {
						order = 10,
						type = "toggle",
						name = _G.BATTLE_PET_BREED_QUALITY4,
						descStyle = "inline",
						get = function(info)
							return profile.detection.rares
						end,
						set = function(info, value)
							profile.detection.rares = value
						end,
					},
					tameables = {
						order = 20,
						type = "toggle",
						name = ("%s %s"):format(_G.TAMEABLE, _G.PARENS_TEMPLATE:format(_G.BATTLE_PET_BREED_QUALITY4)),
						descStyle = "inline",
						get = function(info)
							return profile.detection.tameables
						end,
						set = function(info, value)
							profile.detection.tameables = value
						end,
					},
				},
			},
			headerIgnore = {
				order = 30,
				name = _G.IGNORE,
				type = "header"
			},
			ignoreGeneral = {
				order = 40,
				name = _G.GENERAL,
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
				},
			},
			ignoreContinent = {
				order = 50,
				name = _G.CONTINENT,
				type = "group",
				guiInline = true,
				args = IgnoredContinentOptions,
			},
		},
	}

	UpdateIgnoredContinentOptions()

	return DetectionOptions
end

private.GetDetectionOptions = GetDetectionOptions

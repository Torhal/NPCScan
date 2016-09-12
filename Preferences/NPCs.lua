-- ----------------------------------------------------------------------------
-- Localized Lua globals.
-- ----------------------------------------------------------------------------
-- Functions
local pairs = _G.pairs
local tonumber = _G.tonumber

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
local HereBeDragons = LibStub("HereBeDragons-1.0")

-- ----------------------------------------------------------------------------
-- Constants.
-- ----------------------------------------------------------------------------
local AchievementStatusLabels = {
	_G.ENABLE,
	_G.CUSTOM,
	_G.DISABLE,
}

local AchievementStatusColors = {
	_G.GREEN_FONT_COLOR_CODE,
	_G.NORMAL_FONT_COLOR_CODE,
	_G.RED_FONT_COLOR_CODE,
}

local EmptyListOption = {
	order = 1,
	name = _G.EMPTY,
	type = "header"
}

-- ----------------------------------------------------------------------------
-- Variables.
-- ----------------------------------------------------------------------------
local npcIDs = {}
local npcNames = {}
local profile

-- ----------------------------------------------------------------------------
-- Helpers.
-- ----------------------------------------------------------------------------
local UpdateBlacklistedNPCOptions

local function GetAchievementNPCOptionsName(npcID)
	local npcData = private.NPCData[npcID]
	local colorCode = npcData.isCriteriaCompleted and _G.GREEN_FONT_COLOR_CODE or _G.RED_FONT_COLOR_CODE
	return ("%s%s|r"):format(colorCode, npcData.name)
end

local function SortByAchievementName(a, b)
	return private.AchievementNameByID[a] < private.AchievementNameByID[b]
end

local function SortByNPCNameThenByID(a, b)
	local nameA = npcNames[a]
	local nameB = npcNames[b]

	if nameA == nameB then
		return a < b
	end

	return nameA < nameB
end

local function SetNPCDataFromList(savedNPCIDs)
	table.wipe(npcIDs)
	table.wipe(npcNames)

	for npcID in pairs(savedNPCIDs) do
		npcNames[npcID] = NPCScan:GetNPCNameFromID(npcID)
		npcIDs[#npcIDs + 1] = npcID
	end

	table.sort(npcIDs, SortByNPCNameThenByID)
end

-- ----------------------------------------------------------------------------
-- Achievement options
-- ----------------------------------------------------------------------------
local AchievementOptions = {}

local function UpdateAchievementOptions()
	table.wipe(AchievementOptions)
	local achievementIDs = {}

	for achievementID in pairs(private.AchievementData) do
		achievementIDs[#achievementIDs + 1] = achievementID
	end

	table.sort(achievementIDs, SortByAchievementName)

	for index = 1, #achievementIDs do
		local achievementID = achievementIDs[index]
		local achievementStatus = profile.detection.achievements[achievementID]

		local achievementOptionsTable = {
			order = index,
			name = ("%s%s|r"):format(AchievementStatusColors[achievementStatus], private.AchievementNameByID[achievementID]),
			desc = private.AchievementDescriptionByID[achievementID],
			type = "group",
			args = {
				status = {
					order = 1,
					name = _G.STATUS,
					type = "select",
					values = AchievementStatusLabels,
					get = function(info)
						return profile.detection.achievements[achievementID]
					end,
					set = function(info, value)
						profile.detection.achievements[achievementID] = value

						if value ~= private.AchievementStatus.UserDefined then
							for npcID in pairs(private.AchievementData[achievementID].criteriaNPCs) do
								profile.blacklist.npcIDs[npcID] = nil
							end
						end

						UpdateAchievementOptions()
						UpdateBlacklistedNPCOptions()

						NPCScan:UpdateScanList()
					end,
				},
				npcs = {
					order = 2,
					name = " ",
					type = "group",
					guiInline = true,
					args = {},
				},
			}
		}

		table.wipe(npcNames)

		local npcIDs = {}
		for npcID in pairs(private.AchievementData[achievementID].criteriaNPCs) do
			local npcData = private.NPCData[npcID]

			if npcData.unitFactionGroup ~= private.playerFactionGroup then
				npcNames[npcID] = npcData.name
				npcIDs[#npcIDs + 1] = npcID
			end
		end

		table.sort(npcIDs, SortByNPCNameThenByID)

		for index = 1, #npcIDs do
			local npcID = npcIDs[index]

			achievementOptionsTable.args.npcs.args["npc" .. index] = {
				order = index + 1,
				name = GetAchievementNPCOptionsName(npcID),
				desc = ("%s %s %s"):format(_G.ID, npcID, HereBeDragons:GetLocalizedMap(private.NPCData[npcID].mapID)),
				type = "toggle",
				disabled = function()
					return profile.detection.achievements[achievementID] ~= private.AchievementStatus.UserDefined
				end,
				width = "full",
				descStyle = "inline",
				get = function(info)
					return not profile.blacklist.npcIDs[npcID]
				end,
				set = function(info, value)
					profile.blacklist.npcIDs[npcID] = not profile.blacklist.npcIDs[npcID] and true or nil

					UpdateAchievementOptions()
					UpdateBlacklistedNPCOptions()

					NPCScan:UpdateScanList()
					NPCScan:SendMessage("NPCScan_RemoveNPCFromScanList", npcID)
				end,
			}
		end

		AchievementOptions["achievement" .. achievementID] = achievementOptionsTable
	end

	AceConfigRegistry:NotifyChange(AddOnFolderName)
end

-- ----------------------------------------------------------------------------
-- Rare options.
-- ----------------------------------------------------------------------------

-- ----------------------------------------------------------------------------
-- Tameable rare options.
-- ----------------------------------------------------------------------------

-- ----------------------------------------------------------------------------
-- User defined NPC options.
-- ----------------------------------------------------------------------------
local UserDefinedNPCOptions = {}

local function UpdateUserDefinedNPCOptions()
	table.wipe(UserDefinedNPCOptions)

	local savedNPCIDs = profile.userDefined.npcIDs
	SetNPCDataFromList(savedNPCIDs)

	if #npcIDs > 0 then
		for index = 1, #npcIDs do
			local npcID = npcIDs[index]

			UserDefinedNPCOptions["npc" .. index] = {
				order = index,
				name = ("%s: %d"):format(NPCScan:GetNPCNameFromID(npcID), npcID),
				descStyle = "inline",
				type = "toggle",
				width = "full",
				get = function()
					return true
				end,
				set = function()
					savedNPCIDs[npcID] = nil

					UpdateUserDefinedNPCOptions()

					NPCScan:UpdateScanList()
					NPCScan:SendMessage("NPCScan_RemoveNPCFromScanList", npcID)
				end,
			}
		end
	else
		UserDefinedNPCOptions["npc0"] = EmptyListOption
	end

	AceConfigRegistry:NotifyChange(AddOnFolderName)
end

-- ----------------------------------------------------------------------------
-- Blacklisted NPC options.
-- ----------------------------------------------------------------------------
local BlacklistedNPCOptions = {}

function UpdateBlacklistedNPCOptions()
	table.wipe(BlacklistedNPCOptions)

	local savedNPCIDs = profile.blacklist.npcIDs
	SetNPCDataFromList(savedNPCIDs)

	if #npcIDs > 0 then
		for index = 1, #npcIDs do
			local npcID = npcIDs[index]

			BlacklistedNPCOptions["npc" .. index] = {
				order = index,
				name = ("%s: %d"):format(NPCScan:GetNPCNameFromID(npcID), npcID),
				descStyle = "inline",
				type = "toggle",
				width = "full",
				get = function()
					return true
				end,
				set = function()
					savedNPCIDs[npcID] = nil

					UpdateAchievementOptions()
					UpdateBlacklistedNPCOptions()

					NPCScan:UpdateScanList()
				end,
			}
		end
	else
		BlacklistedNPCOptions["npc0"] = EmptyListOption
	end

	AceConfigRegistry:NotifyChange(AddOnFolderName)
end

-- ----------------------------------------------------------------------------
-- Initialization.
-- ----------------------------------------------------------------------------
local NPCOptions

local function GetNPCOptions()
	profile = private.db.profile

	NPCOptions = NPCOptions or {
		name = L["NPCs"],
		order = 1,
		type = "group",
		childGroups = "tab",
		args = {
			achievements = {
				name = _G.ACHIEVEMENTS,
				order = 1,
				type = "group",
				childGroups = "tree",
				args = AchievementOptions,
			},
			userDefined = {
				name = _G.CUSTOM,
				order = 4,
				type = "group",
				args = {
					isEnabled = {
						order = 1,
						type = "toggle",
						name = _G.ENABLE,
						descStyle = "inline",
						get = function(info)
							return profile.detection.userDefined
						end,
						set = function(info, value)
							profile.detection.userDefined = value

							NPCScan:UpdateScanList()
						end,
					},
					npcID = {
						order = 2,
						name = ("%s %s"):format(_G.ADD, _G.PARENS_TEMPLATE:format(_G.ID)),
						descStyle = "inline",
						type = "input",
						disabled = function()
							return not profile.detection.userDefined
						end,
						validate = function(info, value)
							if value == "mouseover" or value == "target" then
								value = private.UnitTokenToCreatureID(value)
							end

							if tonumber(value) then
								return true
							end
						end,
						get = function()
							return ""
						end,
						set = function(info, value)
							if value == "mouseover" or value == "target" then
								value = private.UnitTokenToCreatureID(value)
							end

							profile.userDefined.npcIDs[tonumber(value)] = true

							UpdateUserDefinedNPCOptions()
							NPCScan:UpdateScanList()
						end,
					},
					npcIDs = {
						order = 3,
						name = _G.ASSIGNED_COLON,
						type = "group",
						inline = true,
						disabled = function()
							return not profile.detection.userDefined
						end,
						args = UserDefinedNPCOptions,
					},
				},
			},
			blacklisted = {
				order = 5,
				name = _G.IGNORED,
				type = "group",
				args = {
					npcIDs = {
						order = 1,
						name = _G.ASSIGNED_COLON,
						type = "group",
						inline = true,
						args = BlacklistedNPCOptions,
					},
				},
			},
		},
	}

	UpdateAchievementOptions()
	UpdateUserDefinedNPCOptions()
	UpdateBlacklistedNPCOptions()

	return NPCOptions
end

private.GetNPCOptions = GetNPCOptions

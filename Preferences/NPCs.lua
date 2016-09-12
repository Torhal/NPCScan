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

-- ----------------------------------------------------------------------------
-- Constants.
-- ----------------------------------------------------------------------------
local AchievementIDs = {}

for achievementID in pairs(private.AchievementData) do
	AchievementIDs[#AchievementIDs + 1] = achievementID
end

table.sort(AchievementIDs, function(a, b)
	return private.AchievementNameByID[a] < private.AchievementNameByID[b]
end)

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

local function GetRareNPCOptionsName(npcID)
	local npcData = private.NPCData[npcID]

	local colorCode = _G.NORMAL_FONT_COLOR_CODE
	if npcData.questID then
		colorCode = private.IsNPCQuestComplete(npcID) and _G.GREEN_FONT_COLOR_CODE or _G.RED_FONT_COLOR_CODE
	end

	return ("%s%s|r"):format(colorCode, npcData.name)
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
local AchievementNPCOptions = {}

local function UpdateAchievementNPCOptions()
	table.wipe(AchievementNPCOptions)

	for achievementIDIndex = 1, #AchievementIDs do
		local achievementID = AchievementIDs[achievementIDIndex]
		local achievementStatus = profile.detection.achievementIDs[achievementID]

		local achievementOptionsTable = {
			order = achievementIDIndex,
			name = ("%s%s|r"):format(private.DetectionGroupStatusColors[achievementStatus], private.AchievementNameByID[achievementID]),
			desc = private.AchievementDescriptionByID[achievementID],
			type = "group",
			args = {
				status = {
					order = 1,
					name = _G.STATUS,
					type = "select",
					values = private.DetectionGroupStatusLabels,
					get = function(info)
						return profile.detection.achievementIDs[achievementID]
					end,
					set = function(info, value)
						profile.detection.achievementIDs[achievementID] = value

						if value ~= private.DetectionGroupStatus.UserDefined then
							for npcID in pairs(private.AchievementData[achievementID].criteriaNPCs) do
								profile.blacklist.npcIDs[npcID] = nil
							end
						end

						UpdateAchievementNPCOptions()
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

		table.wipe(npcIDs)
		table.wipe(npcNames)

		for npcID in pairs(private.AchievementData[achievementID].criteriaNPCs) do
			local npcData = private.NPCData[npcID]

			if npcData.factionGroup ~= private.PlayerFactionGroup then
				npcNames[npcID] = npcData.name
				npcIDs[#npcIDs + 1] = npcID
			end
		end

		table.sort(npcIDs, SortByNPCNameThenByID)

		for npcIDIndex = 1, #npcIDs do
			local npcID = npcIDs[npcIDIndex]

			achievementOptionsTable.args.npcs.args["npcID" .. npcID] = {
				order = npcIDIndex,
				name = GetAchievementNPCOptionsName(npcID),
				desc = ("%s %s %s"):format(_G.ID, npcID, private.MapNameByID[private.NPCData[npcID].mapID]),
				type = "toggle",
				width = "full",
				descStyle = "inline",
				disabled = function()
					return profile.detection.achievementIDs[achievementID] ~= private.DetectionGroupStatus.UserDefined
				end,
				get = function(info)
					return not profile.blacklist.npcIDs[npcID]
				end,
				set = function(info, value)
					local isBlacklisted = not profile.blacklist.npcIDs[npcID] and true or nil
					profile.blacklist.npcIDs[npcID] = isBlacklisted

					UpdateAchievementNPCOptions()
					UpdateBlacklistedNPCOptions()

					NPCScan:UpdateScanList()

					if isBlacklisted then
						NPCScan:SendMessage("NPCScan_RemoveNPCFromScanList", npcID)
					end
				end,
			}
		end

		AchievementNPCOptions["achievementID" .. achievementID] = achievementOptionsTable
	end

	AceConfigRegistry:NotifyChange(AddOnFolderName)
end

-- ----------------------------------------------------------------------------
-- Rare options.
-- ----------------------------------------------------------------------------
local DungeonRareNPCOptions = {}
local ZoneRareNPCOptions = {}

local function UpdateRareNPCOptions()
	table.wipe(DungeonRareNPCOptions)
	table.wipe(ZoneRareNPCOptions)

	for mapIDIndex = 1, #private.AlphabeticalMapIDs do
		local mapID = private.AlphabeticalMapIDs[mapIDIndex]

		table.wipe(npcIDs)
		table.wipe(npcNames)

		for npcID in pairs(private.MapNPCs[mapID]) do
			local npcData = private.NPCData[npcID]

			if not npcData.isTameable and not npcData.achievementID and npcData.factionGroup ~= private.PlayerFactionGroup then
				npcNames[npcID] = npcData.name
				npcIDs[#npcIDs + 1] = npcID
			end
		end

		if #npcIDs > 0 then
			local dungeonContinentID = private.ContinentIDByDungeonMapID[mapID]

			table.sort(npcIDs, SortByNPCNameThenByID)

			local mapOptionsTable = {
				order = mapIDIndex,
				name = private.GetMapOptionName(mapID),
				desc = ("%s %s%s"):format(_G.ID, mapID, dungeonContinentID and (" %s"):format(private.ContinentNameByID[dungeonContinentID]) or ""),
				type = "group",
				args = {
					npcs = {
						order = 1,
						name = " ",
						type = "group",
						guiInline = true,
						args = {},
					},
				},
			}

			for npcIDIndex = 1, #npcIDs do
				local npcID = npcIDs[npcIDIndex]

				if npcID then
					mapOptionsTable.args.npcs.args["npc" .. npcID] = {
						order = npcIDIndex,
						name = GetRareNPCOptionsName(npcID),
						desc = ("%s %s"):format(_G.ID, npcID),
						descStyle = "inline",
						type = "toggle",
						width = "full",
						disabled = function()
							return not profile.detection.rares
						end,
						get = function(info)
							return not profile.blacklist.npcIDs[npcID]
						end,
						set = function(info, value)
							local isBlacklisted = not profile.blacklist.npcIDs[npcID] and true or nil
							profile.blacklist.npcIDs[npcID] = isBlacklisted

							UpdateRareNPCOptions()
							UpdateBlacklistedNPCOptions()

							NPCScan:UpdateScanList()

							if isBlacklisted then
								NPCScan:SendMessage("NPCScan_RemoveNPCFromScanList", npcID)
							end
						end,
					}
				end
			end

			if dungeonContinentID then
				DungeonRareNPCOptions["map" .. mapID] = mapOptionsTable
			else
				ZoneRareNPCOptions["map" .. mapID] = mapOptionsTable
			end
		end
	end

	AceConfigRegistry:NotifyChange(AddOnFolderName)
end

private.UpdateRareNPCOptions = UpdateRareNPCOptions

-- ----------------------------------------------------------------------------
-- Tameable rare options.
-- ----------------------------------------------------------------------------
local DungeonTameableRareNPCOptions = {}
local ZoneTameableRareNPCOptions = {}

local function UpdateTameableRareNPCOptions()
	table.wipe(DungeonTameableRareNPCOptions)
	table.wipe(ZoneTameableRareNPCOptions)

	for mapIDIndex = 1, #private.AlphabeticalMapIDs do
		local mapID = private.AlphabeticalMapIDs[mapIDIndex]

		table.wipe(npcIDs)
		table.wipe(npcNames)

		for npcID in pairs(private.MapNPCs[mapID]) do
			local npcData = private.NPCData[npcID]

			if npcData.isTameable and not npcData.achievementID and npcData.factionGroup ~= private.PlayerFactionGroup then
				npcNames[npcID] = npcData.name
				npcIDs[#npcIDs + 1] = npcID
			end
		end

		if #npcIDs > 0 then
			local dungeonContinentID = private.ContinentIDByDungeonMapID[mapID]

			table.sort(npcIDs, SortByNPCNameThenByID)

			local mapOptionsTable = {
				order = mapIDIndex,
				name = private.GetMapOptionName(mapID),
				desc = ("%s %s%s"):format(_G.ID, mapID, dungeonContinentID and (" %s"):format(private.ContinentNameByID[dungeonContinentID]) or ""),
				type = "group",
				args = {
					npcs = {
						order = 1,
						name = " ",
						type = "group",
						guiInline = true,
						args = {},
					},
				},
			}

			for npcIDIndex = 1, #npcIDs do
				local npcID = npcIDs[npcIDIndex]

				if npcID then
					mapOptionsTable.args.npcs.args["npc" .. npcID] = {
						order = npcIDIndex,
						name = GetRareNPCOptionsName(npcID),
						desc = ("%s %s"):format(_G.ID, npcID),
						descStyle = "inline",
						type = "toggle",
						width = "full",
						disabled = function()
							return not profile.detection.tameables
						end,
						get = function(info)
							return not profile.blacklist.npcIDs[npcID]
						end,
						set = function(info, value)
							local isBlacklisted = not profile.blacklist.npcIDs[npcID] and true or nil
							profile.blacklist.npcIDs[npcID] = isBlacklisted

							UpdateTameableRareNPCOptions()
							UpdateBlacklistedNPCOptions()

							NPCScan:UpdateScanList()

							if isBlacklisted then
								NPCScan:SendMessage("NPCScan_RemoveNPCFromScanList", npcID)
							end
						end,
					}
				end
			end

			if dungeonContinentID then
				DungeonTameableRareNPCOptions["map" .. mapID] = mapOptionsTable
			else
				ZoneTameableRareNPCOptions["map" .. mapID] = mapOptionsTable
			end
		end
	end

	AceConfigRegistry:NotifyChange(AddOnFolderName)
end

private.UpdateTameableRareNPCOptions = UpdateTameableRareNPCOptions

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

					UpdateAchievementNPCOptions()
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
				order = 1,
				name = _G.ACHIEVEMENTS,
				type = "group",
				childGroups = "tree",
				args = AchievementNPCOptions,
			},
			rare = {
				order = 2,
				name = _G.BATTLE_PET_BREED_QUALITY4,
				type = "group",
				childGroups = "tab",
				args = {
					isEnabled = {
						order = 1,
						type = "toggle",
						name = _G.ENABLE,
						descStyle = "inline",
						get = function(info)
							return profile.detection.rares
						end,
						set = function(info, value)
							profile.detection.rares = value

							NPCScan:UpdateScanList()
						end,
					},
					zoneNPCOptions = {
						order = 2,
						name = _G.ZONE,
						descStyle = "inline",
						type = "group",
						args = ZoneRareNPCOptions
					},
					dungeonNPCOptions = {
						order = 3,
						name = _G.DUNGEONS,
						descStyle = "inline",
						type = "group",
						args = DungeonRareNPCOptions
					},
				},
			},
			tameableRare = {
				order = 3,
				name = _G.TAMEABLE,
				type = "group",
				childGroups = "tab",
				args = {
					isEnabled = {
						order = 1,
						type = "toggle",
						name = _G.ENABLE,
						descStyle = "inline",
						get = function(info)
							return profile.detection.tameables
						end,
						set = function(info, value)
							profile.detection.tameables = value

							NPCScan:UpdateScanList()
						end,
					},
					zoneNPCOptions = {
						order = 2,
						name = _G.ZONE,
						descStyle = "inline",
						type = "group",
						args = ZoneTameableRareNPCOptions
					},
					dungeonNPCOptions = {
						order = 3,
						name = _G.DUNGEONS,
						descStyle = "inline",
						type = "group",
						args = DungeonTameableRareNPCOptions
					},
				},
			},
			userDefined = {
				order = 4,
				name = _G.CUSTOM,
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

	UpdateAchievementNPCOptions()
	UpdateRareNPCOptions()
	UpdateTameableRareNPCOptions()
	UpdateUserDefinedNPCOptions()
	UpdateBlacklistedNPCOptions()

	return NPCOptions
end

private.GetNPCOptions = GetNPCOptions

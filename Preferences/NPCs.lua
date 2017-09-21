-- ----------------------------------------------------------------------------
-- Localized Lua globals.
-- ----------------------------------------------------------------------------
-- Functions
local pairs = _G.pairs
local tonumber = _G.tonumber
local type = _G.type

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

local function ValidateUserDefinedNPCInput(input, operationType)
	local value = type(input) == "string" and input:gsub("\"", "") or input

	if value == "mouseover" or value == "target" then
		value = private.UnitTokenToCreatureID(value)
	end

	local npcID = tonumber(value)

	if npcID then
		if private.NPCData[npcID] then
			NPCScan:Print(L["Predefined NPCs cannot be added to or removed from the user-defined NPC list."])
			return false
		end

		if profile.userDefined.npcIDs[npcID] then
			if operationType == "add" then
				NPCScan:Printf(L["%1$s (%2$d) is already on the user-defined NPC list."], NPCScan:GetNPCNameFromID(npcID), npcID)
				return false
			end
		else
			if operationType == "remove" then
				NPCScan:Printf(L["%1$s (%2$d) is not on the user-defined NPC list."], NPCScan:GetNPCNameFromID(npcID), npcID)
				return false
			end
		end

		return true, npcID
	end

	NPCScan:Print(L["Valid values are a numeric NPC ID, the word \"mouseover\" while you have your mouse cursor over an NPC, or the word \"target\" while you have an NPC set as your target."])

	return false
end

local function AddUserDefinedNPC(input)
	local isValid, npcID = ValidateUserDefinedNPCInput(input, "add")

	if isValid then
		profile.userDefined.npcIDs[npcID] = true

		private.UpdateUserDefinedNPCOptions()

		NPCScan:UpdateScanList()
		NPCScan:Printf(L["Added %1$s (%2$d) to the user-defined NPC list."], NPCScan:GetNPCNameFromID(npcID), npcID)
	end
end

private.AddUserDefinedNPC = AddUserDefinedNPC

local function RemoveUserDefinedNPC(input)
	local isValid, npcID = ValidateUserDefinedNPCInput(input, "remove")

	if isValid then
		profile.userDefined.npcIDs[npcID] = nil

		private.UpdateUserDefinedNPCOptions()

		NPCScan:UpdateScanList()
		NPCScan:SendMessage("NPCScan_RemoveNPCFromScanList", npcID)
		NPCScan:Printf(L["Removed %1$s (%2$d) from the user-defined NPC list."], NPCScan:GetNPCNameFromID(npcID), npcID)
	end
end

private.RemoveUserDefinedNPC = RemoveUserDefinedNPC

local function GetNPCOptionsDescription(npcID)
	local npcData = private.NPCData[npcID]
	local mapNames = {}

	for mapIDIndex = 1, #npcData.mapIDs do
		mapNames[#mapNames + 1] = private.MapNameByID[npcData.mapIDs[mapIDIndex]]
	end

	return ("%s %s %s"):format(_G.ID, npcID, table.concat(mapNames, ", "))
end

local function GetNPCOptionsName(npcID)
	local colorCode = _G.NORMAL_FONT_COLOR_CODE
	local npcData = private.NPCData[npcID]

	if npcData.achievementID then
		colorCode = npcData.isCriteriaCompleted and _G.GREEN_FONT_COLOR_CODE or _G.RED_FONT_COLOR_CODE
	elseif npcData.questID then
		colorCode = private.IsNPCQuestComplete(npcID) and _G.GREEN_FONT_COLOR_CODE or _G.RED_FONT_COLOR_CODE
	end

	local npcName = NPCScan:GetNPCNameFromID(npcID)
	local vignetteName = npcData.vignetteName
	local label = ""

	if vignetteName and vignetteName ~= npcName then
		label = (" %s"):format(_G.PARENS_TEMPLATE:format(vignetteName))
	end

	return ("%s%s%s|r"):format(colorCode, npcName, label)
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
				npcNames[npcID] = NPCScan:GetNPCNameFromID(npcID)
				npcIDs[#npcIDs + 1] = npcID
			end
		end

		table.sort(npcIDs, SortByNPCNameThenByID)

		for npcIDIndex = 1, #npcIDs do
			local npcID = npcIDs[npcIDIndex]

			achievementOptionsTable.args.npcs.args["npcID" .. npcID] = {
				order = npcIDIndex,
				name = GetNPCOptionsName(npcID),
				desc = GetNPCOptionsDescription(npcID),
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

			if not npcData.isTameable and npcData.factionGroup ~= private.PlayerFactionGroup then
				npcNames[npcID] = NPCScan:GetNPCNameFromID(npcID)
				npcIDs[#npcIDs + 1] = npcID
			end
		end

		if #npcIDs > 0 then
			local dungeonContinentID = private.ContinentIDByDungeonMapID[mapID]

			table.sort(npcIDs, SortByNPCNameThenByID)

			local mapOptionsTable = {
				order = mapIDIndex,
				name = private.GetMapOptionName(mapID),
				desc = private.GetMapOptionDescription(mapID),
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
						name = GetNPCOptionsName(npcID),
						desc = GetNPCOptionsDescription(npcID),
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

			if npcData.isTameable and npcData.factionGroup ~= private.PlayerFactionGroup then
				npcNames[npcID] = NPCScan:GetNPCNameFromID(npcID)
				npcIDs[#npcIDs + 1] = npcID
			end
		end

		if #npcIDs > 0 then
			local dungeonContinentID = private.ContinentIDByDungeonMapID[mapID]

			table.sort(npcIDs, SortByNPCNameThenByID)

			local mapOptionsTable = {
				order = mapIDIndex,
				name = private.GetMapOptionName(mapID),
				desc = private.GetMapOptionDescription(mapID),
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
						name = GetNPCOptionsName(npcID),
						desc = GetNPCOptionsDescription(npcID),
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
-- Search options.
-- ----------------------------------------------------------------------------
local NPCSearchOptions = {}

local function AddApplicableSearchID(npcID)
	if private.NPCData[npcID].factionGroup ~= private.PlayerFactionGroup then
		npcNames[npcID] = NPCScan:GetNPCNameFromID(npcID)
		npcIDs[#npcIDs + 1] = npcID
	end
end

local function UpdateNPCSearchOptions()
	table.wipe(NPCSearchOptions)

	table.sort(npcIDs, SortByNPCNameThenByID)

	if #npcIDs > 0 then
		for npcIDIndex = 1, #npcIDs do
			local npcID = npcIDs[npcIDIndex]
			local npcData = private.NPCData[npcID]

			local achievementText = ""
			if npcData.achievementID then
				achievementText = _G.PARENS_TEMPLATE:format(private.AchievementNameByID[npcData.achievementID])
			end

			NPCSearchOptions["npc" .. npcID] = {
				order = npcIDIndex,
				name = GetNPCOptionsName(npcID),
				desc = ("%s %s"):format(GetNPCOptionsDescription(npcID), achievementText),
				descStyle = "inline",
				type = "toggle",
				width = "full",
				disabled = function()
					if npcData.achievementID and profile.detection.achievementIDs[npcData.achievementID] ~= private.DetectionGroupStatus.UserDefined then
						return true
					end
				end,
				get = function(info)
					return not profile.blacklist.npcIDs[npcID]
				end,
				set = function(info, value)
					local isBlacklisted = not profile.blacklist.npcIDs[npcID] and true or nil
					profile.blacklist.npcIDs[npcID] = isBlacklisted

					UpdateRareNPCOptions()
					UpdateTameableRareNPCOptions()
					UpdateBlacklistedNPCOptions()

					NPCScan:UpdateScanList()

					if isBlacklisted then
						NPCScan:SendMessage("NPCScan_RemoveNPCFromScanList", npcID)
					end
				end,
			}
		end
	else
		NPCSearchOptions["npc0"] = EmptyListOption
	end

	AceConfigRegistry:NotifyChange(AddOnFolderName)
end

local function PerformNPCSearch(searchString)
	searchString = searchString:lower():trim()

	table.wipe(npcIDs)
	table.wipe(npcNames)

	for continentID = 1, #private.ContinentNameByID do
		if private.ContinentNameByID[continentID]:lower() == searchString then
			for mapID in pairs(private.ContinentMaps[continentID]) do
				for npcID in pairs(private.MapNPCs[mapID]) do
					AddApplicableSearchID(npcID)
				end
			end

			UpdateNPCSearchOptions()

			return
		end
	end

	for mapID in pairs(private.MapNPCs) do
		if private.MapNameByID[mapID]:lower() == searchString then
			for npcID in pairs(private.MapNPCs[mapID]) do
				AddApplicableSearchID(npcID)
			end

			UpdateNPCSearchOptions()

			return
		end
	end

	for npcID in pairs(private.NPCData) do
		if NPCScan:GetNPCNameFromID(npcID):lower():find(searchString) then
			AddApplicableSearchID(npcID)
		end
	end

	UpdateNPCSearchOptions()
end

private.PerformNPCSearch = PerformNPCSearch

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
					RemoveUserDefinedNPC(npcID)
				end,
			}
		end
	else
		UserDefinedNPCOptions["npc0"] = EmptyListOption
	end

	AceConfigRegistry:NotifyChange(AddOnFolderName)
end

private.UpdateUserDefinedNPCOptions = UpdateUserDefinedNPCOptions

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

			BlacklistedNPCOptions["npc" .. npcID] = {
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

local function GetOrUpdateNPCOptions()
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
			search = {
				order = 4,
				name = _G.SEARCH,
				type = "group",
				args = {
					description = {
						order = 1,
						type = "description",
						name = L["Type the name of a Continent, Dungeon, or Zone, or the partial name of an NPC. Accepts Lua patterns."],
					},
					entryBox = {
						order = 2,
						name = " ",
						descStyle = "inline",
						type = "input",
						get = function()
							return ""
						end,
						set = function(info, value)
							PerformNPCSearch(value)
						end,
					},
					results = {
						order = 3,
						name = _G.KBASE_SEARCH_RESULTS,
						type = "group",
						inline = true,
						args = NPCSearchOptions,
					},
				},
			},
			userDefined = {
				order = 5,
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
						name = _G.ADD,
						desc = L["Valid values are a numeric NPC ID, the word \"mouseover\" while you have your mouse cursor over an NPC, or the word \"target\" while you have an NPC set as your target."],
						type = "input",
						disabled = function()
							return not profile.detection.userDefined
						end,
						get = function()
							return ""
						end,
						set = function(info, value)
							AddUserDefinedNPC(value)
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
				order = 6,
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

private.GetOrUpdateNPCOptions = GetOrUpdateNPCOptions

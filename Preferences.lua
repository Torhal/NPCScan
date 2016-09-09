-- ----------------------------------------------------------------------------
-- Localized Lua globals.
-- ----------------------------------------------------------------------------
-- Functions
local pairs = _G.pairs
local tonumber = _G.tonumber
local tostring = _G.tostring

-- Libraries
local math = _G.math
local table = _G.table

-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local AddOnFolderName, private = ...

local LibStub = _G.LibStub
local NPCScan = LibStub("AceAddon-3.0"):GetAddon(AddOnFolderName)
local L = LibStub("AceLocale-3.0"):GetLocale(AddOnFolderName)

local AceConfigDialog = LibStub("AceConfigDialog-3.0")
local AceConfigRegistry = LibStub("AceConfigRegistry-3.0")
local HereBeDragons = LibStub("HereBeDragons-1.0")
local LibWindow = LibStub("LibWindow-1.1")
local LibSharedMedia = LibStub("LibSharedMedia-3.0")

-- ----------------------------------------------------------------------------
-- Constants.
-- ----------------------------------------------------------------------------
local SPAWN_POINTS = {
	"CENTER",
	"BOTTOM",
	"BOTTOMLEFT",
	"BOTTOMRIGHT",
	"LEFT",
	"RIGHT",
	"TOP",
	"TOPLEFT",
	"TOPRIGHT",
}

local SPAWN_INDICES = {}
local LOCALIZED_SPAWN_POINTS = {}

for index = 1, #SPAWN_POINTS do
	LOCALIZED_SPAWN_POINTS[index] = L[SPAWN_POINTS[index]]
	SPAWN_INDICES[SPAWN_POINTS[index]] = index
end

-- ----------------------------------------------------------------------------
-- Variables.
-- ----------------------------------------------------------------------------
local anchorFrame
local profile

-- ----------------------------------------------------------------------------
-- Helpers.
-- ----------------------------------------------------------------------------
local function round(num, idp)
	local mult = 10 ^ (idp or 0)
	return math.floor(num * mult + 0.5) / mult
end

local function CreateAnchorFrame()
	local anchorFrame = _G.CreateFrame("Frame", nil, _G.UIParent)
	anchorFrame:SetSize(302, 119)
	anchorFrame:SetFrameStrata("DIALOG")
	anchorFrame:SetBackdrop({
		bgFile = [[Interface\FriendsFrame\UI-Toast-Background]],
		edgeFile = [[Interface\FriendsFrame\UI-Toast-Border]],
		tile = true,
		tileSize = 12,
		edgeSize = 12,
		insets = {
			left = 5,
			right = 5,
			top = 5,
			bottom = 5,
		},
	})

	anchorFrame:EnableMouse(true)
	anchorFrame:RegisterForDrag("LeftButton")
	anchorFrame:SetClampedToScreen(true)
	anchorFrame:Hide()

	local title = anchorFrame:CreateFontString(nil, "BORDER", "FriendsFont_Normal")
	title:SetJustifyH("CENTER")
	title:SetJustifyV("MIDDLE")
	title:SetWordWrap(true)
	title:SetPoint("TOPLEFT", anchorFrame, "TOPLEFT", 15, -10)
	title:SetPoint("RIGHT", anchorFrame, "RIGHT", -20, 10)
	title:SetText(AddOnFolderName)
	title:SetWidth(anchorFrame:GetWidth())

	local text = anchorFrame:CreateFontString(nil, "BORDER", "FriendsFont_Normal")
	text:SetSize(anchorFrame:GetWidth() - 20, 32)
	text:SetJustifyH("LEFT")
	text:SetJustifyV("MIDDLE")
	text:SetWordWrap(true)
	text:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -4)
	text:SetText(L["Drag to set the spawn point for targeting buttons."])

	local dismissButton = _G.CreateFrame("Button", nil, anchorFrame)
	dismissButton:SetSize(18, 18)
	dismissButton:SetPoint("TOPRIGHT", anchorFrame, "TOPRIGHT", -4, -4)
	dismissButton:SetFrameStrata("DIALOG")
	dismissButton:SetFrameLevel(anchorFrame:GetFrameLevel() + 2)
	dismissButton:SetNormalTexture([[Interface\FriendsFrame\UI-Toast-CloseButton-Up]])
	dismissButton:SetPushedTexture([[Interface\FriendsFrame\UI-Toast-CloseButton-Down]])
	dismissButton:SetHighlightTexture([[Interface\FriendsFrame\UI-Toast-CloseButton-Highlight]])
	dismissButton:SetScript("OnClick", function()
		anchorFrame:Hide()
	end)

	anchorFrame:SetHeight(text:GetStringHeight() + title:GetStringHeight() + 25)

	LibWindow.RegisterConfig(anchorFrame, profile.targetButtonGroup)
	LibWindow.RestorePosition(anchorFrame)
	LibWindow.MakeDraggable(anchorFrame)

	anchorFrame:HookScript("OnDragStop", function()
		AceConfigRegistry:NotifyChange(AddOnFolderName)
	end)

	return anchorFrame
end

-- ----------------------------------------------------------------------------
-- Configuration.
-- ----------------------------------------------------------------------------
local TrackingOptions, UpdateAchievementOptions, UpdateUserDefinedNPCOptions
do
	local npcNames = {}

	local function SortByNPCNameThenByID(a, b)
		local nameA = npcNames[a]
		local nameB = npcNames[b]

		if nameA == nameB then
			return a < b
		end

		return nameA < nameB
	end

	-- ----------------------------------------------------------------------------
	-- Achievement options
	-- ----------------------------------------------------------------------------
	local AchievementOptions = {}
	do
		local function SortAchievementsByName(a, b)
			return private.AchievementNameByID[a] < private.AchievementNameByID[b]
		end

		local function GetAchievementNPCOptionsName(npcID)
			local npcData = private.NPCData[npcID]
			local colorCode = npcData.isCriteriaCompleted and _G.GREEN_FONT_COLOR_CODE or _G.RED_FONT_COLOR_CODE
			return ("%s%s|r"):format(colorCode, npcData.name)
		end

		function UpdateAchievementOptions()
			table.wipe(AchievementOptions)
			local achievementIDs = {}

			for achievementID in pairs(private.ACHIEVEMENTS) do
				achievementIDs[#achievementIDs + 1] = achievementID
			end

			table.sort(achievementIDs, SortAchievementsByName)

			for index = 1, #achievementIDs do
				local achievementID = achievementIDs[index]

				local achievementOptionsTable = {
					order = index,
					name = private.AchievementNameByID[achievementID],
					desc = private.AchievementDescriptionByID[achievementID],
					type = "group",
					args = {}
				}

				table.wipe(npcNames)

				local npcIDs = {}
				for npcID in pairs(private.ACHIEVEMENTS[achievementID].criteriaNPCs) do
					local npcData = private.NPCData[npcID]

					if npcData.unitFactionGroup ~= private.playerFactionGroup then
						npcNames[npcID] = npcData.name
						npcIDs[#npcIDs + 1] = npcID
					end
				end

				table.sort(npcIDs, SortByNPCNameThenByID)

				for index = 1, #npcIDs do
					local npcID = npcIDs[index]

					achievementOptionsTable.args["npc" .. index] = {
						order = index,
						name = GetAchievementNPCOptionsName(npcID),
						desc = ("%s %s\n%s"):format(_G.ID, npcID, HereBeDragons:GetLocalizedMap(private.NPCData[npcID].mapID)),
						type = "toggle",
						width = "full",
						get = function(info)
							return not profile.blacklist.npcIDs[npcID]
						end,
						set = function(info, value)
							profile.blacklist.npcIDs[npcID] = not profile.blacklist.npcIDs[npcID] and true or nil

							UpdateAchievementOptions()

							NPCScan:UpdateScanList()
							NPCScan:SendMessage("NPCScan_RemoveNPCFromScanList", npcID)
						end,
					}
				end

				AchievementOptions["achievement" .. achievementID] = achievementOptionsTable
			end

			AceConfigRegistry:NotifyChange(AddOnFolderName)
		end
	end

	-- ----------------------------------------------------------------------------
	-- User defined options.
	-- ----------------------------------------------------------------------------
	local UserDefinedNPCOptions = {}

	function UpdateUserDefinedNPCOptions()
		table.wipe(UserDefinedNPCOptions)
		table.wipe(npcNames)

		local npcIDs = {}

		local savedNpcIDs = profile.userDefined.npcIDs
		for npcID in pairs(savedNpcIDs) do
			npcNames[npcID] = NPCScan:GetNPCNameFromID(npcID)
			npcIDs[#npcIDs + 1] = npcID
		end

		table.sort(npcIDs, SortByNPCNameThenByID)

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
					savedNpcIDs[npcID] = nil

					UpdateUserDefinedNPCOptions()

					NPCScan:UpdateScanList()
					NPCScan:SendMessage("NPCScan_RemoveNPCFromScanList", npcID)
				end,
			}
		end

		AceConfigRegistry:NotifyChange(AddOnFolderName)
	end

	TrackingOptions = {
		name = _G.TRACKING,
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
				order = 2,
				type = "group",
				args = {
					npcID = {
						order = 10,
						name = ("%s %s"):format(_G.ADD, _G.PARENS_TEMPLATE:format(_G.ID)),
						descStyle = "inline",
						type = "input",
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
						order = 20,
						name = _G.ASSIGNED_COLON,
						type = "group",
						inline = true,
						args = UserDefinedNPCOptions,
					},
				},
			},
		},
	}
end -- do-block

local DetectionOptions = {
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
				userDefined = {
					order = 30,
					type = "toggle",
					name = _G.CUSTOM,
					descStyle = "inline",
					get = function(info)
						return profile.detection.userDefined
					end,
					set = function(info, value)
						profile.detection.userDefined = value
					end,
				},
			},
		},
		ignore = {
			order = 30,
			name = _G.IGNORE,
			type = "group",
			guiInline = true,
			args = {
				completedAchievementCriteria = {
					order = 10,
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
					order = 20,
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
	},
}

local TargetingOptions = {
	name = _G.BINDING_HEADER_TARGETING,
	order = 3,
	type = "group",
	descStyle = "inline",
	args = {
		duration = {
			order = 1,
			name = L["Duration"],
			desc = L["The number of minutes a targeting button will exist before fading out."],
			type = "range",
			width = "full",
			min = 0.5,
			max = 5,
			get = function(info)
				return profile.targetButtonGroup.durationSeconds / 60
			end,
			set = function(info, value)
				profile.targetButtonGroup.durationSeconds = value * 60
			end,
		},
		scale = {
			order = 2,
			name = _G.UI_SCALE,
			type = "range",
			width = "full",
			min = 0.5,
			max = 2,
			get = function(info)
				return profile.targetButtonGroup.scale
			end,
			set = function(info, value)
				profile.targetButtonGroup.scale = value
				LibWindow.SetScale(anchorFrame, value)

				NPCScan:SendMessage("NPCScan_TargetButtonScaleChanged")
			end,
		},
		targetButtons = {
			order = 3,
			name = L["Screen Location"],
			type = "group",
			guiInline = true,
			args = {
				spawnPoint = {
					order = 60,
					type = "select",
					name = L["Spawn Point"],
					descStyle = "inline",
					get = function()
						return SPAWN_INDICES[profile.targetButtonGroup.point]
					end,
					set = function(info, value)
						profile.targetButtonGroup.point = SPAWN_POINTS[value]
						LibWindow.RestorePosition(anchorFrame)
					end,
					values = LOCALIZED_SPAWN_POINTS,
				},
				x = {
					order = 70,
					type = "input",
					name = L["X Offset"],
					desc = L["Horizontal offset from the anchor point."],
					get = function()
						return tostring(round(profile.targetButtonGroup.x))
					end,
					set = function(info, value)
						profile.targetButtonGroup.x = tonumber(value)
						LibWindow.RestorePosition(anchorFrame)
					end,
					dialogControl = "EditBox",
				},
				y = {
					order = 80,
					type = "input",
					name = L["Y Offset"],
					desc = L["Vertical offset from the anchor point."],
					get = function()
						return tostring(round(profile.targetButtonGroup.y))
					end,
					set = function(info, value)
						profile.targetButtonGroup.y = tonumber(value)
						LibWindow.RestorePosition(anchorFrame)
					end,
					dialogControl = "EditBox",
				},
				empty_4 = {
					order = 81,
					type = "description",
					width = "full",
					name = " ",
				},
				reset = {
					order = 90,
					type = "execute",
					name = L["Reset Position"],
					descStyle = "inline",
					func = function()
						profile.targetButtonGroup = _G.copyTable(private.DatabaseDefaults.profile.targetButtonGroup)
						LibWindow.RegisterConfig(anchorFrame, profile.targetButtonGroup)
						LibWindow.RestorePosition(anchorFrame)
					end,
				},
				showAnchor = {
					order = 100,
					type = "execute",
					descStyle = "inline",
					name = function()
						return anchorFrame:IsShown() and L["Hide Anchor"] or L["Show Anchor"]
					end,
					func = function()
						anchorFrame[anchorFrame:IsShown() and "Hide" or "Show"](anchorFrame)
						AceConfigRegistry:NotifyChange(AddOnFolderName)
					end,
				},
			},
		},
	},
}


local AlertOptions, UpdateAlertNamesOptions
do
	local AlertNamesOptions = {}

	function UpdateAlertNamesOptions()
		table.wipe(AlertNamesOptions)

		local soundNames = profile.alert.sound.sharedMediaNames
		for index = 1, #soundNames do
			AlertNamesOptions[soundNames[index] .. index] = {
				order = index,
				name = soundNames[index],
				descStyle = "inline",
				type = "toggle",
				width = "full",
				get = function()
					return true
				end,
				set = function()
					table.remove(soundNames, index)
					UpdateAlertNamesOptions()
				end,
			}
		end

		AceConfigRegistry:NotifyChange(AddOnFolderName)
	end

	local SOUND_CHANNELS = {
		"Ambience",
		"Master",
		"Music",
		"SFX",
	}

	local LOCALIZED_SOUND_CHANNELS = {
		_G.AMBIENCE_VOLUME,
		_G.MASTER,
		_G.MUSIC_VOLUME,
		_G.SOUND_VOLUME,
	}

	local SOUND_CHANNEL_INDICES = {}

	for index = 1, #SOUND_CHANNELS do
		SOUND_CHANNEL_INDICES[SOUND_CHANNELS[index]] = index
	end

	local function IsSoundDisabled()
		return not profile.alert.sound.isEnabled
	end

	AlertOptions = {
		order = 4,
		name = L["Alerts"],
		descStyle = "inline",
		type = "group",
		args = {
			screenFlash = {
				type = "group",
				order = 1,
				name = L["Screen Flash"],
				inline = true,
				args = {
					isEnabled = {
						order = 1,
						name = _G.ENABLE,
						descStyle = "inline",
						type = "toggle",
						width = "full",
						get = function(info)
							return profile.alert.screenFlash.isEnabled
						end,
						set = function(info, value)
							profile.alert.screenFlash.isEnabled = value
						end,
					},
					texture = {
						order = 2,
						name = _G.TEXTURES_SUBHEADER,
						descStyle = "inline",
						type = "select",
						dialogControl = 'LSM30_Background',
						values = _G.AceGUIWidgetLSMlists.background,
						disabled = function()
							return not profile.alert.screenFlash.isEnabled
						end,
						get = function(info)
							return profile.alert.screenFlash.texture
						end,
						set = function(info, value)
							profile.alert.screenFlash.texture = value
						end,
					},
					color = {
						order = 3,
						name = _G.COLOR,
						descStyle = "inline",
						hasAlpha = true,
						type = "color",
						disabled = function()
							return not profile.alert.screenFlash.isEnabled
						end,
						get = function(info)
							local color = profile.alert.screenFlash.color

							if color then
								return color.r, color.g, color.b, color.a else return 0, 0, 0, 1
							end
						end,
						set = function(info, r, g, b, a)
							local color = profile.alert.screenFlash.color

							if not color then
								profile.alert.screenFlash.color = {
									r = r,
									g = g,
									b = b,
									a = a
								}
							else
								color.r = r
								color.g = g
								color.b = b
								color.a = a
							end
						end,
					},
					preview = {
						order = 4,
						name = _G.PREVIEW,
						descStyle = "inline",
						type = "execute",
						width = "normal",
						disabled = function()
							return not profile.alert.screenFlash.isEnabled
						end,
						func = function()
							local alert = profile.alert
							NPCScan:PlayFlashAnimation(alert.screenFlash.texture, alert.screenFlash.color)
						end,
					},
				},
			},
			sound = {
				order = 2,
				name = _G.SOUND,
				descStyle = "inline",
				type = "group",
				guiInline = true,
				args = {
					isEnabled = {
						order = 10,
						name = _G.ENABLE,
						descStyle = "inline",
						type = "toggle",
						get = function(info)
							return profile.alert.sound.isEnabled
						end,
						set = function(info, value)
							profile.alert.sound.isEnabled = value
						end,
					},
					ignoreMute = {
						order = 20,
						name = L["Ignore Mute"],
						desc = L["Play alert sounds when sound is muted."],
						type = "toggle",
						width = "double",
						disabled = IsSoundDisabled,
						get = function(info)
							return profile.alert.sound.ignoreMute
						end,
						set = function(info, value)
							profile.alert.sound.ignoreMute = value
						end,
					},
					channel = {
						order = 30,
						name = _G.SOUND_CHANNELS,
						descStyle = "inline",
						type = "select",
						values = LOCALIZED_SOUND_CHANNELS,
						disabled = IsSoundDisabled,
						get = function(info)
							return SOUND_CHANNEL_INDICES[profile.alert.sound.channel]
						end,
						set = function(info, value)
							profile.alert.sound.channel = SOUND_CHANNELS[value]
						end,
					},
					addAlertSound = {
						order = 40,
						name = _G.ADD,
						descStyle = "inline",
						type = "select",
						dialogControl = "LSM30_Sound",
						values = _G.AceGUIWidgetLSMlists.sound,
						disabled = IsSoundDisabled,
						get = function(info)
							-- Intentionally empty, since there can be multiple sounds.
						end,
						set = function(info, value)
							table.insert(profile.alert.sound.sharedMediaNames, value)
							UpdateAlertNamesOptions()
						end,
					},
					sharedMediaNames = {
						order = 50,
						name = _G.ASSIGNED_COLON,
						type = "group",
						inline = true,
						disabled = IsSoundDisabled,
						args = AlertNamesOptions,
					},
					preview = {
						order = 60,
						name = _G.PREVIEW,
						descStyle = "inline",
						type = "execute",
						width = "normal",
						disabled = IsSoundDisabled,
						func = function()
							local alert = profile.alert
							local soundNames = alert.sound.sharedMediaNames

							NPCScan:OverrideSoundCVars()

							for index = 1, #soundNames do
								_G.PlaySoundFile(LibSharedMedia:Fetch("sound", soundNames[index]), alert.sound.channel)
							end
						end,
					},
				},
			},
		}
	}
end -- do-block

local Options
do
	local options

	function Options()
		if not options then
			options = {
				name = AddOnFolderName,
				type = "group",
				childGroups = "tab",
				args = {
					trackingOptions = TrackingOptions,
					detectionOptions = DetectionOptions,
					alertOptions = AlertOptions,
					targetingOptions = TargetingOptions,
					profileOptions = LibStub("AceDBOptions-3.0"):GetOptionsTable(private.db),
				}
			}
		end
		return options
	end
end

local function SetupSuboptions(label, optionsTable)
	local optionsName = AddOnFolderName .. ":" .. label
	AceConfigRegistry:RegisterOptionsTable(optionsName, optionsTable)
	return AceConfigDialog:AddToBlizOptions(optionsName, optionsTable.name or label, AddOnFolderName)
end

function NPCScan:SetupOptions()
	profile = private.db.profile
	anchorFrame = CreateAnchorFrame()

	private.TargetButtonAnchor = anchorFrame

	CreateAnchorFrame = nil

	LibSharedMedia:Register("sound", "NPCScan Killed", [[Sound\Interface\RaidBossWarning.ogg]])
	LibSharedMedia:Register("sound", "NPCScan Chimes", [[Sound\Interface\UI_Legendary_Item_Toast.ogg]])
	LibSharedMedia:Register("sound", "NPCScan Gruntling Horn", [[Sound\Events\gruntling_horn_bb.ogg]])
	LibSharedMedia:Register("sound", "NPCScan Ogre War Drums", [[Sound\Event Sounds\Event_wardrum_ogre.ogg]])
	LibSharedMedia:Register("sound", "NPCScan Scourge Horn", [[Sound\Events\scourge_horn.ogg]])

	local options = Options()

	AceConfigRegistry:RegisterOptionsTable(AddOnFolderName, options)
	self.OptionsFrame = AceConfigDialog:AddToBlizOptions(AddOnFolderName)

	UpdateAchievementOptions()
	UpdateAlertNamesOptions()
	UpdateUserDefinedNPCOptions()
end

--------------------------------------------------------------------------------
-- Localized Lua globals.
--------------------------------------------------------------------------------
local _G = getfenv(0)

-- Functions
local tonumber = _G.tonumber
local tostring = _G.tostring

-- Libraries
local math = _G.math
local table = _G.table

--------------------------------------------------------------------------------
-- AddOn namespace.
--------------------------------------------------------------------------------
local AddOnFolderName, private = ...

local LibStub = _G.LibStub
local NPCScan = LibStub("AceAddon-3.0"):GetAddon(AddOnFolderName)
local L = LibStub("AceLocale-3.0"):GetLocale(AddOnFolderName)
local AceConfigDialog = LibStub("AceConfigDialog-3.0")
local AceConfigRegistry = LibStub("AceConfigRegistry-3.0")
local LibWindow = LibStub("LibWindow-1.1")
local LibSharedMedia = LibStub("LibSharedMedia-3.0")

-------------------------------------------------------------------------------
-- Constants.
-------------------------------------------------------------------------------
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

--------------------------------------------------------------------------------
-- Variables.
--------------------------------------------------------------------------------
local anchorFrame
local profile

--------------------------------------------------------------------------------
-- Helpers.
--------------------------------------------------------------------------------
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
	title:SetJustifyH("LEFT")
	title:SetJustifyV("MIDDLE")
	title:SetWordWrap(true)
	title:SetPoint("TOPLEFT", anchorFrame, "TOPLEFT", 15, -10)
	title:SetPoint("RIGHT", anchorFrame, "RIGHT", -20, 10)
	title:SetText(AddOnFolderName)
	title:SetWidth(anchorFrame:GetWidth())

	local text = anchorFrame:CreateFontString(nil, "BORDER", "FriendsFont_Normal")
	text:SetJustifyH("LEFT")
	text:SetJustifyV("MIDDLE")
	text:SetWordWrap(true)
	text:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -4)
	text:SetText(L["Drag to set the spawn point for targeting buttons."])
	text:SetWidth(anchorFrame:GetWidth())

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

--------------------------------------------------------------------------------
-- Configuration.
--------------------------------------------------------------------------------
local DetectionOptions = {
	name = L["Detection"],
	order = 1,
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
					end,
				},
			},
		},
	},
}

local TargetingOptions = {
	name = _G.BINDING_HEADER_TARGETING,
	order = 2,
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
			get = function()
				return profile.targetButtonGroup.durationSeconds / 60
			end,
			set = function(info, value)
				profile.targetButtonGroup.durationSeconds = value * 60
			end,
		},
		targetButtons = {
			order = 2,
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

		local soundNames = profile.alert.sharedMediaSoundNames
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

	AlertOptions = {
		order = 3,
		name = L["Alerts"],
		descStyle = "inline",
		type = "group",
		args = {
			screenEdgeFlash = {
				order = 1,
				name = _G.SHOW_FULLSCREEN_STATUS_TEXT,
				descStyle = "inline",
				type = "toggle",
				get = function(info)
					return profile.alert.screenEdgeFlash
				end,
				set = function(info, value)
					profile.alert.screenEdgeFlash = value
				end,
			},
			soundOptions = {
				order = 2,
				name = _G.SOUND,
				descStyle = "inline",
				type = "group",
				guiInline = true,
				args = {
					soundIsEnabled = {
						order = 10,
						name = _G.ENABLE,
						descStyle = "inline",
						type = "toggle",
						width = "full",
						get = function(info)
							return profile.alert.soundIsEnabled
						end,
						set = function(info, value)
							profile.alert.soundIsEnabled = value
						end,
					},
					soundChannel = {
						order = 20,
						name = _G.SOUND_CHANNELS,
						descStyle = "inline",
						type = "select",
						values = LOCALIZED_SOUND_CHANNELS,
						disabled = function()
							return not profile.alert.soundIsEnabled
						end,
						get = function(info)
							return SOUND_CHANNEL_INDICES[profile.alert.soundChannel]
						end,
						set = function(info, value)
							profile.alert.soundChannel = SOUND_CHANNELS[value]
						end,
					},
					addAlertSound = {
						order = 30,
						name = _G.ADD,
						descStyle = "inline",
						type = "select",
						dialogControl = "LSM30_Sound",
						values = _G.AceGUIWidgetLSMlists.sound,
						disabled = function()
							return not profile.alert.soundIsEnabled
						end,
						get = function(info)
							-- Intentionally empty, since there can be multiple sounds.
						end,
						set = function(info, value)
							table.insert(profile.alert.sharedMediaSoundNames, value)
							UpdateAlertNamesOptions()
						end,
					},
					sharedMediaSoundNames = {
						order = 40,
						name = _G.ASSIGNED_COLON,
						type = "group",
						inline = true,
						disabled = function()
							return not profile.alert.soundIsEnabled
						end,
						args = AlertNamesOptions,
					},
					preview = {
						order = 50,
						name = _G.PREVIEW,
						descStyle = "inline",
						type = "execute",
						width = "normal",
						disabled = function()
							return not profile.alert.soundIsEnabled
						end,
						func = function()
							local alert = profile.alert
							local soundNames = alert.sharedMediaSoundNames

							for index = 1, #soundNames do
								_G.PlaySoundFile(LibSharedMedia:Fetch("sound", soundNames[index]), alert.soundChannel)
							end
						end,
					},
				},
			},
		}
	}
end -- do-block

local TrackingOptions = {
	name = _G.TRACKING,
	order = 1,
	type = "group",
	childGroups = "tab",
	args = {
		foofroo = {
			name = "NotYetAdded",
			order = 1,
			type = "input",
			dialogControl = "MyNewWidgetName",
		},
	},
}

local UserDefinedOptions = {
	name = _G.CUSTOM,
	order = 2,
	type = "group",
	childGroups = "tree",
	args = {},
}

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
					detectionOptions = DetectionOptions,
					AlertOptions = AlertOptions,
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

	CreateAnchorFrame = nil

	LibSharedMedia:Register("sound", "NPCScan Killed", [[Sound\Interface\RaidBossWarning.ogg]])
	LibSharedMedia:Register("sound", "NPCScan Chimes", [[Sound\Interface\UI_Legendary_Item_Toast.ogg]])
	LibSharedMedia:Register("sound", "NPCScan Gruntling Horn", [[Sound\Events\gruntling_horn_bb.ogg]])
	LibSharedMedia:Register("sound", "NPCScan Ogre War Drums", [[Sound\Event Sounds\Event_wardrum_ogre.ogg]])
	LibSharedMedia:Register("sound", "NPCScan Scourge Horn", [[Sound\Events\scourge_horn.ogg]])

	local options = Options()

	AceConfigRegistry:RegisterOptionsTable(AddOnFolderName, options)
	self.OptionsFrame = AceConfigDialog:AddToBlizOptions(AddOnFolderName)

	UpdateAlertNamesOptions()
end

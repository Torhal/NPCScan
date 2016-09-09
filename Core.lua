-- ----------------------------------------------------------------------------
-- Upvalued Lua API.
-- ----------------------------------------------------------------------------
-- Functions
local pairs = _G.pairs

-- Libraries
local string = _G.string

-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local AddOnFolderName, private = ...

local LibStub = _G.LibStub
local NPCScan = LibStub("AceAddon-3.0"):NewAddon(AddOnFolderName, "AceConsole-3.0", "AceEvent-3.0", "AceTimer-3.0", "AceBucket-3.0")
local VL = LibStub("AceLocale-3.0"):GetLocale(AddOnFolderName .. "Vignette")

local HereBeDragons = LibStub("HereBeDragons-1.0")

-- ----------------------------------------------------------------------------
-- Debugger.
-- ----------------------------------------------------------------------------
do
	local TextDump = LibStub("LibTextDump-1.0")

	local DEBUGGER_WIDTH = 750
	local DEBUGGER_HEIGHT = 800

	local debugger

	function private.Debug(...)
		if not debugger then
			debugger = TextDump:New(("%s Debug Output"):format(AddOnFolderName), DEBUGGER_WIDTH, DEBUGGER_HEIGHT)
		end

		local message = string.format(...)
		debugger:AddLine(message, "%X")

		return message
	end

	function private.GetDebugger()
		if not debugger then
			debugger = TextDump:New(("%s Debug Output"):format(AddOnFolderName), DEBUGGER_WIDTH, DEBUGGER_HEIGHT)
		end

		return debugger
	end
end

-- ----------------------------------------------------------------------------
-- Variables.
-- ----------------------------------------------------------------------------
local NPCIDFromName = {}
private.NPCIDFromName = NPCIDFromName

local QuestNPCs = {}
private.QuestNPCs = QuestNPCs

local QuestIDFromName = {}
private.QuestIDFromName = QuestIDFromName

local VignetteNPCs = {}
private.VignetteNPCs = VignetteNPCs

-- ----------------------------------------------------------------------------
-- AddOn Methods.
-- ----------------------------------------------------------------------------
function NPCScan:OnInitialize()
	local db = LibStub("AceDB-3.0"):New("NPCScanDB", private.DatabaseDefaults, "Default")
	db.RegisterCallback(self, "OnProfileChanged", "RefreshPreferences")
	db.RegisterCallback(self, "OnProfileCopied", "RefreshPreferences")
	db.RegisterCallback(self, "OnProfileReset", "RefreshPreferences")

	private.db = db

	-- ----------------------------------------------------------------------------
	-- Build lookup tables.
	-- ----------------------------------------------------------------------------
	for mapID, npcs in pairs(private.MapNPCs) do
		for npcID in pairs(npcs) do
			local npcData = private.NPCData[npcID]
			if not npcData then
				npcData = {}
				private.NPCData[npcID] = npcData
			end

			npcData.mapID = mapID

			local npcName = self:GetNPCNameFromID(npcID)
			if not npcName then
				private.Debug("NPC ID %d not found in localization table.", npcID)

				npcName = ("%s_%d"):format(_G.UNKNOWN, npcID)
			end

			npcData.name = npcName

			NPCIDFromName[npcName] = npcID
		end
	end

	for npcID, data in pairs(private.NPCData) do
		if data.questID then
			local npcIDs = QuestNPCs[data.questID]
			if not npcIDs then
				npcIDs = {}
				QuestNPCs[data.questID] = npcIDs
			end

			npcIDs[npcID] = true

			local questName = NPCScan:GetQuestNameFromID(data.questID)
			if questName and questName ~= _G.UNKNOWN then
				QuestIDFromName[questName] = data.questID
			end
		end

		if data.vignetteName then
			local vignetteName = VL[data.vignetteName]

			local npcIDs = VignetteNPCs[vignetteName]
			if not npcIDs then
				npcIDs = {}
				VignetteNPCs[vignetteName] = npcIDs
			end

			npcIDs[npcID] = true
		end
	end

	-- ----------------------------------------------------------------------------
	-- Assign Achievement ID to appropriate NPCData entry.
	-- ----------------------------------------------------------------------------
	local CriteriaType = {
		NPCKill = 0,
		Quest = 27,
		Spell = 28,
	}

	for achievementID, achievement in pairs(private.ACHIEVEMENTS) do
		achievement.ID = achievementID

		for criteriaIndex = 1, _G.GetAchievementNumCriteria(achievementID) do
			local assetName, criteriaType, isCriteriaCompleted, _, _, _, _, assetID, _, criteriaID = _G.GetAchievementCriteriaInfo(achievementID, criteriaIndex)
			local _, _, _, isAchievementCompleted = _G.GetAchievementInfo(achievementID)

			achievement.isCompleted = isAchievementCompleted

			if criteriaType == CriteriaType.NPCKill then
				if assetID > 0 then
					local found
					for mapID, npcIDs in pairs(private.MapNPCs) do
						if npcIDs[assetID] then
							found = true
							break;
						end
					end

					if found then
						local npcData = private.NPCData[assetID]
						npcData.achievementID = achievementID
						npcData.achievementCriteriaID = criteriaID
						npcData.isCriteriaCompleted = isCriteriaCompleted

						achievement.criteriaNPCs[assetID] = true
					else
						private.Debug("***** AchievementID.%s: Missing MapNPCs entry.", private.AchievementLabel[achievementID])
						private.Debug("[%s] = true, -- %s", assetID, assetName)
						private.Debug("*****")
					end
				end
			elseif criteriaType == CriteriaType.Quest then
				if QuestNPCs[assetID] then
					for npcID in pairs(QuestNPCs[assetID]) do
						local npcData = private.NPCData[npcID]
						npcData.achievementID = achievementID
						npcData.achievementCriteriaID = criteriaID
						npcData.isCriteriaCompleted = isCriteriaCompleted
					end
				else
					private.Debug("***** AchievementID.%s: Quest %s with assetID %d", private.AchievementLabel[achievementID], assetName, assetID)
				end
			elseif criteriaType == CriteriaType.Spell then
				-- Ignore this for now.
			else
				private.Debug("***** AchievementID.%s: Unknown criteria type %d, assetID %d", private.AchievementLabel[achievementID], criteriaType, assetID)
			end
		end
	end

	for mapID, npcs in pairs(private.MapNPCs) do
		local mapHeaderPrinted

		for npcID in pairs(npcs) do
			if mapID >= 1015 then
				local npcData = private.NPCData[npcID]

				if not npcData.questID and not npcData.achievementID then
					if not mapHeaderPrinted then
						mapHeaderPrinted = true
						private.Debug("-- ----------------------------------------------------------------------------")
						private.Debug("-- %s (%d)", HereBeDragons:GetLocalizedMap(mapID), mapID)
						private.Debug("-- ----------------------------------------------------------------------------")
					end

					private.Debug("NPC %d (%s) has no questID.", npcID, npcData.name)
				end
			end
		end
	end

	-- Handle custom additions.
	for npcID, npcName in pairs(db.locale.npcNames) do
		NPCIDFromName[npcName] = npcID
	end

	self:SetupOptions()
	self:InitializeTargetButton()
	self:RegisterChatCommand("npcscan", "ChatCommand")
end

function NPCScan:OnEnable()
	self:RegisterBucketEvent("CRITERIA_UPDATE", 5)
	self:RegisterEvent("LOOT_CLOSED")
	self:RegisterEvent("NAME_PLATE_UNIT_ADDED")
	self:RegisterEvent("PLAYER_TARGET_CHANGED")
	self:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
	self:RegisterEvent("VIGNETTE_ADDED")
	self:RegisterBucketEvent("WORLD_MAP_UPDATE", 0.5)

	HereBeDragons.RegisterCallback(NPCScan, "PlayerZoneChanged", "UpdateScanList")

	self:UpdateScanList()
	private.Overlays.Register()
end

function NPCScan:RefreshPreferences()
end

do
	local DatamineTooltip = _G.CreateFrame("GameTooltip", "NPCScanDatamineTooltip", _G.UIParent, "GameTooltipTemplate")
	DatamineTooltip:SetOwner(_G.WorldFrame, "ANCHOR_NONE")

	function NPCScan:GetNPCNameFromID(npcID)
		local npcName = private.db.locale.npcNames[npcID]

		if not npcName then
			DatamineTooltip:SetHyperlink(("unit:Creature-0-0-0-0-%d"):format(npcID))

			npcName = _G['NPCScanDatamineTooltipTextLeft1']:GetText()

			if npcName and npcName ~= "" then
				private.db.locale.npcNames[npcID] = npcName
				NPCIDFromName[npcName] = npcID
			else
				npcName = _G.UNKNOWN
			end
		end

		return npcName
	end

	function NPCScan:GetQuestNameFromID(questID)
		local questName = private.db.locale.questNames[questID]

		if not questName then
			DatamineTooltip:SetHyperlink(("quest:%d"):format(questID))

			questName = _G['NPCScanDatamineTooltipTextLeft1']:GetText()

			if questName and questName ~= "" then
				private.db.locale.questNames[questID] = questName
				private.QuestIDFromName[questName] = questID
			else
				questName = _G.UNKNOWN
			end
		end

		return questName:gsub("Vignette: ", "")
	end
end

do
	local SUBCOMMAND_FUNCS = {
		--@debug@
		DEBUG = function()
			local debugger = private.GetDebugger()

			if debugger:Lines() == 0 then
				debugger:AddLine("Nothing to report.")
				debugger:Display()
				debugger:Clear()
				return
			end

			debugger:Display()
		end,
		DUMP = function(arguments)
			local dumpType, arguments = NPCScan:GetArgs(arguments, 2)

			local func = private.DUMP_COMMANDS[dumpType]

			if func then
				private.TextDump = private.TextDump or _G.LibStub("LibTextDump-1.0"):New(AddOnFolderName)
				func(arguments)
			else
				NPCScan:Print("Unknown dump command. Valid commands:")

				for command in pairs(private.DUMP_COMMANDS) do
					NPCScan:Printf("     %s", command)
				end
			end
		end,
		--@end-debug@
	}

	function NPCScan:ChatCommand(input)
		local subcommand, arguments = self:GetArgs(input, 2)

		if subcommand then
			local func = SUBCOMMAND_FUNCS[subcommand:upper()]

			if func then
				func(arguments or "")
			end
		else
			local optionsFrame = _G.InterfaceOptionsFrame

			if optionsFrame:IsVisible() then
				optionsFrame:Hide()
			else
				_G.InterfaceOptionsFrame_OpenToCategory(self.OptionsFrame)
			end
		end
	end
end -- do-block

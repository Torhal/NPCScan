-----------------------------------------------------------------------
-- Localized Lua globals.
-----------------------------------------------------------------------
local _G = getfenv(0)

-- Functions
local pairs = _G.pairs
local tostring = _G.tostring
local time = _G.time

-- Libraries
local table = _G.table

-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local AddOnFolderName, private = ...

local LibStub = _G.LibStub
local NPCScan = LibStub("AceAddon-3.0"):GetAddon(AddOnFolderName)

local HereBeDragons = LibStub("HereBeDragons-1.0")
local LibSharedMedia = LibStub("LibSharedMedia-3.0")

-----------------------------------------------------------------------
-- Constants.
-----------------------------------------------------------------------
local npcScanList = {}

local playerFactionGroup = _G.UnitFactionGroup("player")

-----------------------------------------------------------------------
-- Variables.
-----------------------------------------------------------------------
local currentContinentID
local currentMapID

-----------------------------------------------------------------------
-- Helpers.
-----------------------------------------------------------------------
local function IsNPCQuestComplete(npcID)
	local npcData = private.NPCData[npcID]
	local questID = npcData and npcData.questID

	return questID and _G.IsQuestFlaggedCompleted(questID) or false
end

private.IsNPCQuestComplete = IsNPCQuestComplete

local function UnitTokenToCreatureID(unitToken)
	if unitToken then
		local GUID = _G.UnitGUID(unitToken)
		if not GUID then
			return
		end

		return private.GUIDToCreatureID(GUID)
	end
end

-- These functions are used for situations where an npcID needs to be removed from the npcScanList while iterating it.
local QueueNPCForUntracking, UntrackQueuedNPCs
do
	local npcRemoveList = {}

	function QueueNPCForUntracking(npcID)
		npcRemoveList[#npcRemoveList] = npcID
	end

	function UntrackQueuedNPCs()
		for index = 1, #npcRemoveList do
			local npcID = npcRemoveList[index]

			npcScanList[npcID] = nil
			private.Overlays.Remove(npcID)
		end

		table.wipe(npcRemoveList)
	end
end

local ProcessDetection
do
	local throttledNPCs = {}

	function ProcessDetection(data)
		local npcID = data.npcID
		local profile = private.db.profile
		local detection = profile.detection
		local throttleTime = throttledNPCs[npcID]
		local now = time()

		if not npcScanList[npcID] or (throttleTime and now < throttleTime + detection.intervalSeconds) or (not detection.whileOnTaxi and _G.UnitOnTaxi("player")) then
			return
		end

		throttledNPCs[npcID] = now

		data.npcName = data.npcName or NPCScan:GetNPCNameFromID(npcID)
		data.unitClassification = data.unitClassification or "rareelite"

		NPCScan:SendMessage("NPCScan_DetectedNPC", data)

		-- TODO: Make the Overlays object listen for the NPCScan_DetectedNPC message and run its own methods
		private.Overlays.Found(npcID)
		private.Overlays.Remove(npcID)
	end
end

local function ProcessUnit(unitToken, sourceText)
	if _G.UnitIsUnit("player", unitToken) or _G.UnitIsDeadOrGhost(unitToken) then
		return
	end

	local npcID = UnitTokenToCreatureID(unitToken)
	if npcID then
		local detectionData = {
			npcID = npcID,
			npcName = _G.UnitName(unitToken),
			sourceText = sourceText,
			unitClassification = _G.UnitClassification(unitToken),
			unitCreatureType = _G.UnitCreatureType(unitToken),
			unitLevel = _G.UnitLevel(unitToken),
			unitToken = unitToken,
		}

		ProcessDetection(detectionData)

		NPCScan:SendMessage("NPCScan_UnitInformationAvailable", detectionData)
	end
end

local function CanAddToScanList(npcID)
	local profile = private.db.profile

	if profile.blacklist.npcIDs[npcID] then
		private.Debug("Skipping %s (%d) - blacklisted.", NPCScan:GetNPCNameFromID(npcID), npcID)
		return false
	end

	local npcData = private.NPCData[npcID]

	if npcData and npcData.factionGroup == playerFactionGroup then
		private.Debug("Skipping %s (%d) - same faction group.", NPCScan:GetNPCNameFromID(npcID), npcID)
		return false
	end

	local isTameable = npcData and npcData.isTameable
	local detection = profile.detection

	if isTameable and not detection.tameables then
		private.Debug("Skipping %s (%d) - not tracking tameables.", NPCScan:GetNPCNameFromID(npcID), npcID)
		return false
	end

	if not isTameable and not detection.rares then
		private.Debug("Skipping %s (%d) - not tracking rares.", NPCScan:GetNPCNameFromID(npcID), npcID)
		return false
	end

	local achievementID = npcData and npcData.achievementID

	if achievementID then
		if not detection.achievements[achievementID] then
			private.Debug("Skipping %s (%d) - not tracking the achievement.", NPCScan:GetNPCNameFromID(npcID), npcID)
			return false
		end

		if detection.ignoreCompletedAchievementCriteria and (private.ACHIEVEMENTS[achievementID].isCompleted or npcData.isCriteriaCompleted) then
			private.Debug("Skipping %s (%d) - criteria already met or achievement completed.", NPCScan:GetNPCNameFromID(npcID), npcID)
			return false
		end
	end

	if detection.ignoreCompletedQuestObjectives and IsNPCQuestComplete(npcID) then
		private.Debug("Skipping %s (%d) - already killed.", NPCScan:GetNPCNameFromID(npcID), npcID)
		return false
	end

	return true
end

local function MergeUserDefinedWithScanList(npcList)
	if npcList then
		local blacklist = private.db.profile.blacklist

		for npcID in pairs(npcList) do
			if not blacklist.npcIDs[npcID] then
				npcScanList[npcID] = true
				private.Overlays.Add(npcID)
			end
		end
	end
end

function NPCScan:UpdateScanList(eventName, mapID)
	currentMapID = mapID or currentMapID
	currentContinentID = mapID and HereBeDragons:GetCZFromMapID(mapID) or currentMapID

	private.Debug("currentMapID: %d", currentMapID)

	for npcID in pairs(npcScanList) do
		private.Overlays.Remove(npcID)
	end

	table.wipe(npcScanList)

	local profile = private.db.profile
	local userDefined = profile.userDefined

	-- No zone or continent specified, so always look for these.
	MergeUserDefinedWithScanList(userDefined.npcIDs)

	if profile.blacklist.continentIDs[currentContinentID] or profile.blacklist.mapIDs[currentMapID] then
		_G.NPCScan_SearchMacroButton:ResetMacroText()
		return
	end

	local npcList = private.MapNPCs[currentMapID]
	if npcList then
		for npcID in pairs(npcList) do
			if CanAddToScanList(npcID) then
				npcScanList[npcID] = true
				private.Overlays.Add(npcID)
			end
		end
	end

	MergeUserDefinedWithScanList(userDefined.continentNPCs[currentContinentID])
	MergeUserDefinedWithScanList(userDefined.mapNPCs[currentMapID])

	_G.NPCScan_SearchMacroButton:UpdateMacroText(npcScanList)
end

HereBeDragons.RegisterCallback(NPCScan, "PlayerZoneChanged", "UpdateScanList")

-----------------------------------------------------------------------
-- Events.
-----------------------------------------------------------------------
local function UpdateScanListAchievementCriteria()
	for npcID in pairs(npcScanList) do
		local npcData = private.NPCData[npcID]

		if npcData and npcData.achievementID and npcData.achievementCriteriaID and not npcData.isCriteriaCompleted then
			local _, _, isCompleted = _G.GetAchievementCriteriaInfoByID(npcData.achievementID, npcData.achievementCriteriaID)

			if isCompleted then
				npcData.isCriteriaCompleted = isCompleted

				if private.db.profile.detection.ignoreCompletedAchievementCriteria then
					QueueNPCForUntracking(npcID)
				end
			end
		end
	end

	UntrackQueuedNPCs()
end

function NPCScan:ACHIEVEMENT_EARNED(_, achievementID)
	if private.ACHIEVEMENTS[achievementID] then
		private.ACHIEVEMENTS[achievementID].isCompleted = true

		if private.db.profile.detection.ignoreCompletedAchievementCriteria then
			-- Disable tracking for the achievement, since the above setting implies it.
			private.db.profile.detection.achievements[achievementID] = false
		end

		UpdateScanListAchievementCriteria()
	end
end

function NPCScan:CRITERIA_UPDATE()
	UpdateScanListAchievementCriteria()
end

function NPCScan:LOOT_CLOSED()
	-- Apparently some vignette NPC daily quests are only flagged as complete after looting...
	if private.db.profile.detection.ignoreCompletedQuestObjectives then
		for npcID in pairs(npcScanList) do
			if IsNPCQuestComplete(npcID) then
				QueueNPCForUntracking(npcID)
			end
		end

		UntrackQueuedNPCs()
	end
end

function NPCScan:NAME_PLATE_UNIT_ADDED(eventName, unitToken)
	ProcessUnit(unitToken, _G.UNIT_NAMEPLATES)
end

function NPCScan:PLAYER_TARGET_CHANGED(eventName)
	ProcessUnit("target", _G.TARGET)
end

function NPCScan:UPDATE_MOUSEOVER_UNIT()
	local mouseoverID = UnitTokenToCreatureID("mouseover")

	if mouseoverID ~= UnitTokenToCreatureID("target") then
		ProcessUnit("mouseover", _G.MOUSE_LABEL)
	end
end

local function ProcessQuestDetection(questID, sourceText)
	for npcID in pairs(private.QuestNPCs[questID]) do
		ProcessDetection({
			npcID = npcID,
			sourceText = sourceText
		})
	end
end

function NPCScan:VIGNETTE_ADDED(eventName, instanceID)
	local x, y, vignetteName, iconID = _G.C_Vignettes.GetVignetteInfoFromInstanceID(instanceID)
	local npcID = private.NPCIDFromName[vignetteName]

	if npcID then
		ProcessDetection({
			npcID = npcID,
			sourceText = _G.MINIMAP_LABEL
		})
	else
		local questID = private.QuestIDFromName[vignetteName]

		if questID then
			ProcessQuestDetection(questID, _G.MINIMAP_LABEL)
		else
			private.Debug("Unknown vignette: %s with iconID %s", vignetteName, tostring(iconID))
		end
	end
end

function NPCScan:WORLD_MAP_UPDATE()
	for landmarkIndex = 1, _G.GetNumMapLandmarks() do
		local landmarkType, landmarkName = _G.GetMapLandmarkInfo(landmarkIndex)

		if landmarkType == _G.LE_MAP_LANDMARK_TYPE_VIGNETTE and landmarkName then
			local npcID = private.NPCIDFromName[landmarkName]

			if npcID then
				ProcessDetection({
					npcID = npcID,
					sourceText = _G.WORLD_MAP
				})
			else
				local questID = private.QuestIDFromName[landmarkName]

				if questID then
					ProcessQuestDetection(questID, _G.WORLD_MAP)
				end
			end
		end
	end
end

-----------------------------------------------------------------------
-- Sensory cues.
-----------------------------------------------------------------------
do
	local MAX_FLASH_LOOPS = 3

	local flashFrame = _G.CreateFrame("Frame")
	flashFrame:Hide()
	flashFrame:SetAllPoints()
	flashFrame:SetAlpha(0)
	flashFrame:SetFrameStrata("FULLSCREEN_DIALOG")

	local flashTexture = flashFrame:CreateTexture()
	flashTexture:SetBlendMode("ADD")
	flashTexture:SetAllPoints()

	local fadeAnimationGroup = flashFrame:CreateAnimationGroup()
	fadeAnimationGroup:SetLooping("BOUNCE")

	fadeAnimationGroup:SetScript("OnLoop", function(self, loopState)
		if loopState == "FORWARD" then
			self.LoopCount = self.LoopCount + 1

			if self.LoopCount >= MAX_FLASH_LOOPS then
				self:Stop()
				flashFrame:Hide()
			end
		end
	end)

	fadeAnimationGroup:SetScript("OnPlay", function(self)
		self.LoopCount = 0
	end)

	local fadeAnimIn = private.CreateAlphaAnimation(fadeAnimationGroup, 0, 1, 0.5)
	fadeAnimIn:SetEndDelay(0.25)

	local SOUND_INTERVAL_SECONDS = 2
	local lastSoundTime = time()

	function NPCScan:DispatchSensoryCues(eventName)
		local alert = private.db.profile.alert

		if alert.screenFlash.isEnabled then
			local color = alert.screenFlash.color
			flashTexture:SetTexture(LibSharedMedia:Fetch("background", alert.screenFlash.texture))
			flashTexture:SetVertexColor(color.r, color.g, color.b, color.a)
			flashFrame:Show()

			fadeAnimationGroup:Pause() -- Forces OnPlay to fire again if it was already playing
			fadeAnimationGroup:Play()
		end

		if alert.soundIsEnabled and time() > lastSoundTime + SOUND_INTERVAL_SECONDS then
			local soundNames = alert.sharedMediaSoundNames

			for index = 1, #soundNames do
				_G.PlaySoundFile(LibSharedMedia:Fetch("sound", soundNames[index]), alert.soundChannel)
			end
		end
	end

	NPCScan:RegisterMessage("NPCScan_TargetButtonActivated", "DispatchSensoryCues")
end

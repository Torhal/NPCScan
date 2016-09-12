-- ----------------------------------------------------------------------------
-- Localized Lua globals.
-- ----------------------------------------------------------------------------
-- Functions
local pairs = _G.pairs
local tostring = _G.tostring
local time = _G.time

-- Libraries
local table = _G.table

-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local AddOnFolderName, private = ...

local LibStub = _G.LibStub
local NPCScan = LibStub("AceAddon-3.0"):GetAddon(AddOnFolderName)

local HereBeDragons = LibStub("HereBeDragons-1.0")
local LibSharedMedia = LibStub("LibSharedMedia-3.0")

-- ----------------------------------------------------------------------------
-- Constants.
-- ----------------------------------------------------------------------------
local npcScanList = {}

-- ----------------------------------------------------------------------------
-- Variables.
-- ----------------------------------------------------------------------------
local currentContinentID
local currentMapID

-- ----------------------------------------------------------------------------
-- Helpers.
-- ----------------------------------------------------------------------------
-- These functions are used for situations where an npcID needs to be removed from the npcScanList while iterating it.
local QueueNPCForUntracking, UntrackQueuedNPCs
do
	local npcRemoveList = {}

	function QueueNPCForUntracking(npcID)
		npcRemoveList[#npcRemoveList + 1] = npcID
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
		data.unitClassification = data.unitClassification or "rare"

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

	local npcID = private.UnitTokenToCreatureID(unitToken)
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
	if npcData then
		if npcData.factionGroup == private.PlayerFactionGroup then
			private.Debug("Skipping %s (%d) - same faction group.", NPCScan:GetNPCNameFromID(npcID), npcID)
			return false
		end

		local isTameable = npcData.isTameable
		local detection = profile.detection

		if isTameable and not detection.tameables then
			private.Debug("Skipping %s (%d) - not tracking tameables.", NPCScan:GetNPCNameFromID(npcID), npcID)
			return false
		end

		if not isTameable and not detection.rares then
			private.Debug("Skipping %s (%d) - not tracking rares.", NPCScan:GetNPCNameFromID(npcID), npcID)
			return false
		end


		local achievementID = npcData.achievementID
		if achievementID then
			if detection.achievementIDs[achievementID] == private.DetectionGroupStatus.Disabled then
				private.Debug("Skipping %s (%d) - not tracking the achievement.", NPCScan:GetNPCNameFromID(npcID), npcID)
				return false
			end

			if detection.ignoreCompletedAchievementCriteria and (private.AchievementData[achievementID].isCompleted or npcData.isCriteriaCompleted) then
				private.Debug("Skipping %s (%d) - criteria already met or achievement completed.", NPCScan:GetNPCNameFromID(npcID), npcID)
				return false
			end
		end

		if detection.ignoreCompletedQuestObjectives and private.IsNPCQuestComplete(npcID) then
			private.Debug("Skipping %s (%d) - already killed.", NPCScan:GetNPCNameFromID(npcID), npcID)
			return false
		end
	end

	return true
end

local function MergeUserDefinedWithScanList(npcList)
	if npcList and private.db.profile.detection.userDefined then
		for npcID in pairs(npcList) do
			npcScanList[npcID] = true
		end
	end
end

function NPCScan:UpdateScanList(eventName, mapID)
	if mapID then
		currentMapID = mapID
		private.currentMapID = currentMapID

		currentContinentID = HereBeDragons:GetCZFromMapID(mapID)
		private.currentContinentID = currentContinentID
	end

	if not currentMapID and currentContinentID then
		private.Debug("No mapID or no continentID.")
		return
	end

	private.Debug("currentMapID: %d currentContinentID: %d", currentMapID, currentContinentID)

	for npcID in pairs(npcScanList) do
		private.Overlays.Remove(npcID)
	end

	table.wipe(npcScanList)

	local profile = private.db.profile
	local userDefined = profile.userDefined

	-- No zone or continent specified, so always look for these.
	MergeUserDefinedWithScanList(userDefined.npcIDs)

	if profile.blacklist.mapIDs[currentMapID] or profile.detection.continentIDs[currentContinentID] == private.DetectionGroupStatus.Disabled  then
		private.Debug("continentID or mapID is blacklisted; terminating update.")
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

-- ----------------------------------------------------------------------------
-- Events.
-- ----------------------------------------------------------------------------
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

private.UpdateScanListAchievementCriteria = UpdateScanListAchievementCriteria

local function UpdateScanListQuestObjectives()
	if private.db.profile.detection.ignoreCompletedQuestObjectives then
		for npcID in pairs(npcScanList) do
			if private.IsNPCQuestComplete(npcID) then
				QueueNPCForUntracking(npcID)
			end
		end

		UntrackQueuedNPCs()
	end
end

private.UpdateScanListQuestObjectives = UpdateScanListQuestObjectives

function NPCScan:ACHIEVEMENT_EARNED(_, achievementID)
	if private.AchievementData[achievementID] then
		private.AchievementData[achievementID].isCompleted = true

		if private.db.profile.detection.ignoreCompletedAchievementCriteria then
			-- Disable tracking for the achievement, since the above setting implies it.
			private.db.profile.detection.achievementIDs[achievementID] = private.DetectionGroupStatus.Disabled
		end

		UpdateScanListAchievementCriteria()
	end
end

function NPCScan:CRITERIA_UPDATE()
	UpdateScanListAchievementCriteria()
end

-- Apparently some vignette NPC daily quests are only flagged as complete after looting...
function NPCScan:LOOT_CLOSED()
	UpdateScanListQuestObjectives()
end

function NPCScan:NAME_PLATE_UNIT_ADDED(eventName, unitToken)
	ProcessUnit(unitToken, _G.UNIT_NAMEPLATES)
end

function NPCScan:PLAYER_TARGET_CHANGED(eventName)
	ProcessUnit("target", _G.TARGET)
end

function NPCScan:UPDATE_MOUSEOVER_UNIT()
	local mouseoverID = private.UnitTokenToCreatureID("mouseover")

	if mouseoverID ~= private.UnitTokenToCreatureID("target") then
		ProcessUnit("mouseover", _G.MOUSE_LABEL)
	end
end

do
	local function ProcessQuestDetection(questID, sourceText)
		for npcID in pairs(private.QuestNPCs[questID]) do
			ProcessDetection({
				npcID = npcID,
				sourceText = sourceText
			})
		end
	end

	local function ProcessVignetteNameDetection(vignetteName, sourceText)
		for npcID in pairs(private.VignetteNPCs[vignetteName]) do
			ProcessDetection({
				npcID = npcID,
				sourceText = sourceText
			})
		end
	end

	local function ProcessVignette(vignetteName, sourceText)
		local questID = private.QuestIDFromName[vignetteName]
		if questID then
			ProcessQuestDetection(questID, sourceText)
			return true
		end

		if private.VignetteNPCs[vignetteName] then
			ProcessVignetteNameDetection(vignetteName, sourceText)
			return true
		end

		local npcID = private.NPCIDFromName[vignetteName]
		if npcID then
			ProcessDetection({
				npcID = npcID,
				sourceText = sourceText
			})

			return true
		end

		return false
	end

	function NPCScan:VIGNETTE_ADDED(eventName, instanceID)
		local x, y, vignetteName, iconID = _G.C_Vignettes.GetVignetteInfoFromInstanceID(instanceID)

		if not ProcessVignette(vignetteName, _G.MINIMAP_LABEL) then
			private.Debug("Unknown vignette: %s with iconID %s", vignetteName, tostring(iconID))
		end
	end

	function NPCScan:WORLD_MAP_UPDATE()
		for landmarkIndex = 1, _G.GetNumMapLandmarks() do
			local landmarkType, landmarkName = _G.GetMapLandmarkInfo(landmarkIndex)

			ProcessVignette(landmarkName, _G.WORLD_MAP)
		end
	end
end -- do-block

-- ----------------------------------------------------------------------------
-- Sensory cues.
-- ----------------------------------------------------------------------------
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

	local ALERT_SOUND_THROTTLE_INTERVAL_SECONDS = 2
	local SOUND_RESTORE_INTERVAL_SECONDS = 5
	local lastSoundTime = time()

	function NPCScan:PlayFlashAnimation(texturePath, color)
		flashTexture:SetTexture(LibSharedMedia:Fetch("background", texturePath))
		flashTexture:SetVertexColor(color.r, color.g, color.b, color.a)
		flashFrame:Show()

		fadeAnimationGroup:Pause() -- Forces OnPlay to fire again if it was already playing
		fadeAnimationGroup:Play()
	end

	local SoundCVars = {
		Sound_EnableAllSound = 1,
		Sound_EnableSFX = 1,
		Sound_EnableSoundWhenGameIsInBG = 1,
	}

	local StoredSoundCVars = {}

	local function ResetStoredSoundCVars()
		for cvar, value in pairs(StoredSoundCVars) do
			_G.SetCVar(cvar, value)
		end
	end

	function NPCScan:OverrideSoundCVars()
		for cvar, value in pairs(SoundCVars) do
			StoredSoundCVars[cvar] = _G.GetCVar(cvar)

			_G.SetCVar(cvar, value)
		end

		self:ScheduleTimer(ResetStoredSoundCVars, SOUND_RESTORE_INTERVAL_SECONDS)
	end

	function NPCScan:DispatchSensoryCues(eventName)
		local alert = private.db.profile.alert
		local now = time()

		if alert.screenFlash.isEnabled then
			self:PlayFlashAnimation(alert.screenFlash.texture, alert.screenFlash.color)
		end

		if alert.sound.isEnabled and now > lastSoundTime + ALERT_SOUND_THROTTLE_INTERVAL_SECONDS then
			if alert.sound.ignoreMute then
				self:OverrideSoundCvars()
			end

			local soundNames = alert.sound.sharedMediaNames

			for index = 1, #soundNames do
				_G.PlaySoundFile(LibSharedMedia:Fetch("sound", soundNames[index]), alert.sound.channel)
			end

			lastSoundTime = now
		end
	end

	NPCScan:RegisterMessage("NPCScan_TargetButtonActivated", "DispatchSensoryCues")
end

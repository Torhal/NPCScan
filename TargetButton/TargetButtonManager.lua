-----------------------------------------------------------------------
-- Localized Lua globals.
-----------------------------------------------------------------------
local _G = getfenv(0)

-- Functions
local tonumber = _G.tonumber

-- Libraries
local table = _G.table

-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local AddOnFolderName, private = ...

local LibStub = _G.LibStub

local TargetButtonManager = LibStub("AceEvent-3.0"):Embed({})

local LibToast = LibStub("LibToast-1.0")
LibToast:Register("NPCScanAlertToast", function(toast, ...)
	toast:SetTitle(AddOnFolderName)
	toast:SetFormattedText("%s%s|r", _G.GREEN_FONT_COLOR_CODE, ...)
	toast:SetIconTexture([[Interface\LFGFRAME\BattlenetWorking0]])
end)

-----------------------------------------------------------------------
-- Constants.
-----------------------------------------------------------------------
local ActiveTargetButtons = {}
local QueuedData = {}
local TargetButtonHeap = {}

local ActiveTargetButtonByNPCID = {}

local POINT_TRANSLATION = {
	CENTER = private.DEFAULT_OS_SPAWN_POINT,
	BOTTOM = "BOTTOMRIGHT",
	BOTTOMLEFT = "BOTTOMLEFT",
	BOTTOMRIGHT = "BOTTOMRIGHT",
	LEFT = "TOPLEFT",
	RIGHT = "TOPRIGHT",
	TOP = "TOPRIGHT",
	TOPLEFT = "TOPLEFT",
	TOPRIGHT = "TOPRIGHT",
}

local SIBLING_ANCHORS = {
	TOPRIGHT = "BOTTOMRIGHT",
	TOPLEFT = "BOTTOMLEFT",
	BOTTOMRIGHT = "TOPRIGHT",
	BOTTOMLEFT = "TOPLEFT",
}

local OFFSET_X = {
	TOPRIGHT = -20,
	TOPLEFT = 20,
	BOTTOMRIGHT = -20,
	BOTTOMLEFT = 20,
}

local OFFSET_Y = {
	TOPRIGHT = -30,
	TOPLEFT = -30,
	BOTTOMRIGHT = 30,
	BOTTOMLEFT = 30,
}

local SIBLING_OFFSET_Y = {
	TOPRIGHT = -10,
	TOPLEFT = -10,
	BOTTOMRIGHT = 10,
	BOTTOMLEFT = 10,
}

-----------------------------------------------------------------------
-- Helpers.
-----------------------------------------------------------------------
local function GetAnchorData()
	local anchorConfig = private.db.profile.targetButtonGroup
	local spawnPoint = anchorConfig.point

	return spawnPoint, anchorConfig.x or OFFSET_X[spawnPoint], anchorConfig.y or OFFSET_Y[spawnPoint]
end

local function ResetTargetButtonPoints()
	local spawnPoint, offsetX, offsetY = GetAnchorData()

	for index = 1, #ActiveTargetButtons do
		local indexedButton = ActiveTargetButtons[index]
		indexedButton:ClearAllPoints()

		if index == 1 then
			indexedButton:SetPoint(spawnPoint, _G.UIParent, spawnPoint, offsetX, offsetY)
		else
			spawnPoint = POINT_TRANSLATION[ActiveTargetButtons[1]:GetEffectiveSpawnPoint()]
			indexedButton:SetPoint(spawnPoint, ActiveTargetButtons[index - 1], SIBLING_ANCHORS[spawnPoint], 0, SIBLING_OFFSET_Y[spawnPoint])
		end
	end
end

local function AcquireTargetButton(unitClassification)
	local heap = TargetButtonHeap[unitClassification]
	if not heap then
		heap = {}
		TargetButtonHeap[unitClassification] = heap
	end

	local button = table.remove(heap)
	if not button then
		button = private.CreateTargetButton(unitClassification)
	end

	return button
end

-----------------------------------------------------------------------
-- TargetButtonManager methods.
-----------------------------------------------------------------------
function TargetButtonManager:DismissAll()
	for index = 1, #ActiveTargetButtons do
		ActiveTargetButtons[index].dismissAnimationGroup:Play()
	end
end

LibStub("HereBeDragons-1.0").RegisterCallback(TargetButtonManager, "PlayerZoneChanged", "DismissAll")

function TargetButtonManager:ProcessQueue(eventName)
	if #ActiveTargetButtons < _G.NUM_RAID_ICONS and not _G.InCombatLockdown() then
		local buttonData = table.remove(QueuedData, 1)

		if buttonData then
			self:Spawn(eventName, _G.unpack(buttonData))
		end
	end
end

TargetButtonManager:RegisterEvent("PLAYER_REGEN_ENABLED", "ProcessQueue")

function TargetButtonManager:Reclaim(eventName, button)
	ActiveTargetButtonByNPCID[button.npcID] = nil

	button:Deactivate()

	table.insert(TargetButtonHeap[button.__classification], button)

	local removalIndex
	for index = 1, #ActiveTargetButtons do
		if ActiveTargetButtons[index] == button then
			removalIndex = index
			break
		end
	end

	if removalIndex then
		table.remove(ActiveTargetButtons, removalIndex):ClearAllPoints()
	end

	ResetTargetButtonPoints()

	self:ProcessQueue("Reclaim")

	if #ActiveTargetButtons == 0 then
		_G.NPCScan_RecentTargetButton:ResetMacroText()
	end
end

TargetButtonManager:RegisterMessage("NPCScan_TargetButtonDismissed", "Reclaim")

function TargetButtonManager:RespawnAsClassification(eventName, targetButton, unitClassification, unitToken)
	local targetButtonIndex
	for index = 1, #ActiveTargetButtons do
		if ActiveTargetButtons[index] == targetButton then
			targetButtonIndex = index
			break
		end
	end

	local npcID = targetButton.npcID
	local npcName = targetButton.npcName
	local detectionSource = targetButton.detectionSource
	local unitLevel = targetButton.unitLevel
	local unitCreatureType = targetButton.unitLevel

	targetButton:Deactivate()

	table.insert(TargetButtonHeap[targetButton.__classification], targetButton)
	table.remove(ActiveTargetButtons, targetButtonIndex):ClearAllPoints()

	local newButton = AcquireTargetButton(unitClassification)
	table.insert(ActiveTargetButtons, targetButtonIndex, newButton)

	ResetTargetButtonPoints()

	newButton:Activate(npcID, npcName, detectionSource, unitLevel, unitCreatureType, unitToken, true, false)
	newButton.needsUnitData = nil
end

TargetButtonManager:RegisterMessage("NPCScan_TargetButtonNeedsReclassified", "RespawnAsClassification")

function TargetButtonManager:Spawn(eventName, npcID, detectionSource, npcName, unitClassification, unitLevel, unitCreatureType, unitToken)
	if ActiveTargetButtonByNPCID[npcID] then
		return
	end

	if #ActiveTargetButtons >= _G.NUM_RAID_ICONS or _G.InCombatLockdown() then
		LibToast:Spawn("NPCScanAlertToast", ("%s %s"):format(npcName, _G.PARENS_TEMPLATE:format(detectionSource)))

		table.insert(QueuedData, {
			npcID,
			("%s %s"):format(detectionSource, _G.PARENS_TEMPLATE:format(_G.QUEUED_STATUS_QUEUED)),
			npcName,
			unitClassification,
			unitLevel,
			unitCreatureType
		})

		return
	end

	local button = AcquireTargetButton(unitClassification)
	local spawnPoint, offsetX, offsetY = GetAnchorData()

	if #ActiveTargetButtons > 0 then
		spawnPoint = POINT_TRANSLATION[ActiveTargetButtons[1]:GetEffectiveSpawnPoint()]
		button:SetPoint(spawnPoint, ActiveTargetButtons[#ActiveTargetButtons], SIBLING_ANCHORS[spawnPoint], 0, SIBLING_OFFSET_Y[spawnPoint])
	else
		button:SetPoint(spawnPoint, _G.UIParent, spawnPoint, offsetX, offsetY)
	end

	ActiveTargetButtons[#ActiveTargetButtons + 1] = button
	ActiveTargetButtonByNPCID[npcID] = true

	button:Activate(npcID, npcName, detectionSource, unitLevel, unitCreatureType, unitToken, false, eventName == "Reclaim")
end

TargetButtonManager:RegisterMessage("NPCScan_DetectedNPC", "Spawn")

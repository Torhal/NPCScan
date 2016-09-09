-- ----------------------------------------------------------------------------
-- Localized Lua globals.
-- ----------------------------------------------------------------------------
-- Functions

-- Libraries
local table = _G.table

-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local AddOnFolderName, private = ...

local LibStub = _G.LibStub

local TargetButtonManager = LibStub("AceEvent-3.0"):Embed({})

local LibToast = LibStub("LibToast-1.0")
LibToast:Register("NPCScanAlertToast", function(toast, ...)
	toast:SetTitle(AddOnFolderName)
	toast:SetFormattedText("%s%s|r", _G.GREEN_FONT_COLOR_CODE, ...)
	toast:SetIconTexture([[Interface\LFGFRAME\BattlenetWorking0]])
end)

-- ----------------------------------------------------------------------------
-- Constants.
-- ----------------------------------------------------------------------------
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

-- ----------------------------------------------------------------------------
-- Helpers.
-- ----------------------------------------------------------------------------
local function ResetTargetButtonPoints()
	for index = 1, #ActiveTargetButtons do
		local indexedButton = ActiveTargetButtons[index]
		indexedButton:ClearAllPoints()

		if index == 1 then
			indexedButton:SetPoint("CENTER", private.TargetButtonAnchor, "CENTER")
		else
			local spawnPoint = POINT_TRANSLATION[ActiveTargetButtons[1]:GetEffectiveSpawnPoint()]
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

-- ----------------------------------------------------------------------------
-- TargetButtonManager methods.
-- ----------------------------------------------------------------------------
function TargetButtonManager:DismissAll()
	for index = 1, #ActiveTargetButtons do
		ActiveTargetButtons[index].dismissAnimationGroup:Play()
	end
end

LibStub("HereBeDragons-1.0").RegisterCallback(TargetButtonManager, "PlayerZoneChanged", "DismissAll")

function TargetButtonManager:ProcessQueue(eventName)
	if #ActiveTargetButtons < private.NUM_RAID_ICONS and not _G.InCombatLockdown() then
		local buttonData = table.remove(QueuedData, 1)

		if buttonData then
			self:Spawn(eventName, buttonData)
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

TargetButtonManager:RegisterMessage("NPCScan_TargetButtonRequestDeactivate", "Reclaim")

function TargetButtonManager:ReclaimByNPCID(eventName, npcID)
	for index = 1, #ActiveTargetButtons do
		local targetButton = ActiveTargetButtons[index]

		if targetButton.npcID == npcID then
			targetButton.dismissAnimationGroup:Play()
		end
	end
end

TargetButtonManager:RegisterMessage("NPCScan_RemoveNPCFromScanList", "ReclaimByNPCID")

function TargetButtonManager:RespawnAsClassification(eventName, targetButton, data)
	local targetButtonIndex
	for index = 1, #ActiveTargetButtons do
		if ActiveTargetButtons[index] == targetButton then
			targetButtonIndex = index
			break
		end
	end

	targetButton:Deactivate()

	table.insert(TargetButtonHeap[targetButton.__classification], targetButton)
	table.remove(ActiveTargetButtons, targetButtonIndex):ClearAllPoints()

	local newButton = AcquireTargetButton(data.unitClassification)
	table.insert(ActiveTargetButtons, targetButtonIndex, newButton)

	ResetTargetButtonPoints()

	data.isSilent = true

	newButton:Activate(data)
	newButton.needsUnitData = nil
end

TargetButtonManager:RegisterMessage("NPCScan_TargetButtonNeedsReclassified", "RespawnAsClassification")

function TargetButtonManager:SetScale(eventName)
	for index = 1, #ActiveTargetButtons do
		ActiveTargetButtons[index]:SetScale(private.db.profile.targetButtonGroup.scale)
	end
end

TargetButtonManager:RegisterMessage("NPCScan_TargetButtonScaleChanged", "SetScale")

function TargetButtonManager:Spawn(eventName, data)
	if ActiveTargetButtonByNPCID[data.npcID] then
		return
	end

	if #ActiveTargetButtons >= private.NUM_RAID_ICONS or _G.InCombatLockdown() then
		LibToast:Spawn("NPCScanAlertToast", ("%s %s"):format(data.npcName, _G.PARENS_TEMPLATE:format(data.sourceText)))

		data.sourceText = ("%s %s"):format(data.sourceText, _G.PARENS_TEMPLATE:format(_G.QUEUED_STATUS_QUEUED))
		table.insert(QueuedData, data)

		return
	end

	local button = AcquireTargetButton(data.unitClassification)

	if #ActiveTargetButtons == 0 then
		button:SetPoint("CENTER", private.TargetButtonAnchor, "CENTER")
	else
		local spawnPoint = POINT_TRANSLATION[ActiveTargetButtons[1]:GetEffectiveSpawnPoint()]
		button:SetPoint(spawnPoint, ActiveTargetButtons[#ActiveTargetButtons], SIBLING_ANCHORS[spawnPoint], 0, SIBLING_OFFSET_Y[spawnPoint])
	end

	ActiveTargetButtons[#ActiveTargetButtons + 1] = button
	ActiveTargetButtonByNPCID[data.npcID] = true

	data.isFromQueue = eventName == "Reclaim"
	button:Activate(data)
end

TargetButtonManager:RegisterMessage("NPCScan_DetectedNPC", "Spawn")

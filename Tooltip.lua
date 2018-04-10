-- ----------------------------------------------------------------------------
-- Localized globals.
-- ----------------------------------------------------------------------------
-- Lua Functions
local pairs = _G.pairs

-- Lua Libraries
local table = _G.table

-- WoW UI
local GameTooltip = _G.GameTooltip

-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local AddOnFolderName, private = ...
local Data = private.Data
local EventMessage = private.EventMessage

local LibStub = _G.LibStub
local LibQTip = LibStub("LibQTip-1.0")
local NPCScan = LibStub("AceAddon-3.0"):GetAddon(AddOnFolderName)

-- ----------------------------------------------------------------------------
-- Constants
-- ----------------------------------------------------------------------------
local DataObjectProperties = {
	icon = [[Interface\LFGFRAME\BattlenetWorking0]],
	text = " ",
	type = "data source"
}

local DataObject = LibStub("LibDataBroker-1.1"):NewDataObject(AddOnFolderName, DataObjectProperties)

local npcAchievementNames = {}
local npcDisplayNames = {}
local npcIDs = {}
local npcNames = {}

local TitleFont = _G.CreateFont("NPCScanTitleFont")
TitleFont:SetTextColor(1, 0.82, 0)
TitleFont:SetFontObject("QuestTitleFont")

-- ----------------------------------------------------------------------------
-- Helpers
-- ----------------------------------------------------------------------------
local function SortByNPCNameThenByID(a, b)
	local nameA = npcNames[a]
	local nameB = npcNames[b]

	if nameA == nameB then
		return a < b
	end

	return nameA < nameB
end

local function SortByNPCAchievementNameThenByNameThenByID(a, b)
	local achievementNameA = npcAchievementNames[a]
	local achievementNameB = npcAchievementNames[b]

	if achievementNameA == achievementNameB then
		return SortByNPCNameThenByID(a, b)
	end

	return achievementNameA < achievementNameB
end

-- ----------------------------------------------------------------------------
-- Tooltip achievement headers.
-- ----------------------------------------------------------------------------
local achievementProvider, achievementPrototype, baseCellPrototype = LibQTip:CreateCellProvider(LibQTip.LabelProvider)

function achievementPrototype:getContentHeight()
	return 16
end

function achievementPrototype:InitializeCell()
	baseCellPrototype.InitializeCell(self)

	if not self.atlas then
		local background = self:CreateTexture(nil, "TOOLTIP")
		background:SetBlendMode("ADD")
		background:SetAtlas("Objective-Header", true)
		background:SetPoint("CENTER", 0, -17)

		self.atlas = background
	end

	self.r, self.g, self.b = 1, 0.82, 0
	self.fontString:SetTextColor(self.r, self.g, self.b, 1)
end

function achievementPrototype:ReleaseCell()
	self.r, self.g, self.b = 1, 1, 1
end

function achievementPrototype:SetupCell(tooltip, value, justification, font, r, g, b)
	local width, height = baseCellPrototype.SetupCell(self, tooltip, value, justification, font, r, g, b)

	self.r, self.g, self.b = 1, 0.82, 0

	return width, height
end

-- ----------------------------------------------------------------------------
-- DataBroker Tooltip.
-- ----------------------------------------------------------------------------
local NUM_TOOLTIP_COLUMNS = 2
local ICON_PATH_TAMEABLE = [[Interface\ICONS\Ability_Hunter_BeastTaming]]

local Tooltip

local function OpenToAchievement(_, achievementID)
	if not _G.AchievementFrame or not _G.AchievementFrame:IsShown() then
		_G.ToggleAchievementFrame()
	end

	_G.AchievementFrameBaseTab_OnClick(1)
	_G.AchievementFrame_SelectAchievement(achievementID)

	local categoryID = _G.GetAchievementCategory(achievementID)
	local _, parentCategoryID = _G.GetCategoryInfo(categoryID)

	if parentCategoryID == -1 then
		for _, entry in pairs(_G.ACHIEVEMENTUI_CATEGORIES) do
			if entry.id == categoryID then
				entry.collapsed = false
			elseif entry.parent == categoryID then
				entry.hidden = false
			end
		end

		_G.AchievementFrameCategories_Update()
	end
end

local function ShowAchievementTooltip(cell, achievementID)
	GameTooltip:SetOwner(cell, "ANCHOR_PRESERVE")
	GameTooltip:SetText(Data.Achievements[achievementID].description, 1, 1, 1, 1, true)
	GameTooltip:Show()
end

local function HideAchievementTooltip()
	GameTooltip:Hide()
end

local function Tooltip_OnRelease()
	Tooltip = nil
end

local function DrawTooltip(anchorFrame)
	if not anchorFrame then
		return
	end

	if not Tooltip then
		Tooltip = LibQTip:Acquire(AddOnFolderName, NUM_TOOLTIP_COLUMNS)
		Tooltip:SetAutoHideDelay(0.25, anchorFrame)
		Tooltip:SmartAnchorTo(anchorFrame)
		Tooltip:SetBackdropColor(0.05, 0.05, 0.05, 1)

		Tooltip.OnRelease = Tooltip_OnRelease
	end

	Tooltip:Clear()

	Tooltip:SetCell(Tooltip:AddLine(), 1, AddOnFolderName, TitleFont, "CENTER", 0)
	Tooltip:AddSeparator(1, 0, 0, 0)

	if DataObject.scannerData.NPCCount == 0 then
		Tooltip:AddSeparator(1, 0, 0, 0)
		Tooltip:AddSeparator(1, 1, 0.82, 0)
		Tooltip:SetCell(Tooltip:AddLine(), 1, _G.BROWSE_NO_RESULTS, "CENTER", 0)

		return
	end

	table.wipe(npcIDs)
	table.wipe(npcNames)

	for npcID in pairs(DataObject.scannerData.NPCs) do
		local npc = Data.NPCs[npcID]

		npcAchievementNames[npcID] = npc.achievementID and Data.Achievements[npc.achievementID].name or "ZZZZZ"
		npcDisplayNames[npcID] = private.GetNPCOptionsName(npcID)
		npcNames[npcID] = NPCScan:GetNPCNameFromID(npcID)
		npcIDs[#npcIDs + 1] = npcID
	end

	table.sort(npcIDs, SortByNPCAchievementNameThenByNameThenByID)

	local currentAchievementID

	for index = 1, #npcIDs do
		local npcID = npcIDs[index]
		local npc = Data.NPCs[npcID]

		if npc.achievementID then
			if npc.achievementID ~= currentAchievementID then
				currentAchievementID = npc.achievementID

				Tooltip:AddSeparator(1, 0, 0, 0)
				Tooltip:AddSeparator(1, 1, 0.82, 0)

				local achievementData = Data.Achievements[npc.achievementID]
				local achievementLine = Tooltip:AddLine()

				Tooltip:SetCell(achievementLine, 1, ("|T%s:0|t %s"):format(achievementData.iconTexturePath, achievementData.name), "CENTER", 0, achievementProvider)
				Tooltip:SetLineScript(achievementLine, "OnMouseUp", OpenToAchievement, npc.achievementID)
				Tooltip:SetLineScript(achievementLine, "OnEnter", ShowAchievementTooltip, npc.achievementID)
				Tooltip:SetLineScript(achievementLine, "OnLeave", HideAchievementTooltip)
				Tooltip:AddSeparator(1, 1, 0.82, 0)
			end
		elseif not currentAchievementID then
			-- No achievement section before this, and it's the first entry
			currentAchievementID = -1

			Tooltip:AddSeparator(1, 0, 0, 0)
			Tooltip:AddSeparator(1, 1, 0.82, 0)
		elseif currentAchievementID >= 0 then
			-- End of achievements.
			currentAchievementID = -1

			Tooltip:AddSeparator(1, 0, 0, 0)
			Tooltip:AddSeparator(1, 1, 0.82, 0)
			Tooltip:SetCell(Tooltip:AddLine(), 1, _G.MISCELLANEOUS, "CENTER", 0)
			Tooltip:AddSeparator(1, 1, 0.82, 0)
		end

		local line = Tooltip:AddLine()

		Tooltip:SetCell(line, 1, npcDisplayNames[npcID])

		if npc.isTameable then
			Tooltip:SetCell(line, 2, ("|T%s:0|t"):format(ICON_PATH_TAMEABLE))
		end
	end
end

-- ----------------------------------------------------------------------------
-- DataObject methods.
-- ----------------------------------------------------------------------------
function DataObject:OnClick()
	LibStub("AceConfigDialog-3.0"):Open(AddOnFolderName)
end

function DataObject:OnEnter()
	if not Tooltip or not Tooltip:IsShown() then
		DrawTooltip(self)
		Tooltip:UpdateScrolling()
		Tooltip:Show()
	end
end

function DataObject:OnLeave()
	-- Null operation: Some LDB displays get cranky if this method is missing.
end

function DataObject:Update(_, scannerData)
	self.text = ("%s %s"):format(_G.ZONE_COLON, scannerData.NPCCount)
	self.scannerData = scannerData

	if Tooltip and Tooltip:IsShown() then
		DrawTooltip(self)
	end
end

LibStub("AceEvent-3.0"):Embed(DataObject)
DataObject:RegisterMessage(EventMessage.ScannerDataUpdated, "Update")

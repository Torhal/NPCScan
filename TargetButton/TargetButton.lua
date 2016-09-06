-----------------------------------------------------------------------
-- Localized Lua globals.
-----------------------------------------------------------------------
local _G = getfenv(0)

-- Functions
local pairs = _G.pairs
local type = _G.type

-- Libraries
local math = _G.math
local table = _G.table

-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local AddOnFolderName, private = ...

local LibStub = _G.LibStub
local NPCScan = LibStub("AceAddon-3.0"):GetAddon(AddOnFolderName)

local AceEvent = LibStub("AceEvent-3.0")
local LibSharedMedia = LibStub("LibSharedMedia-3.0")

_G.BINDING_HEADER_NPCSCAN = AddOnFolderName
_G["BINDING_NAME_CLICK NPCScan_RecentTargetButton:LeftButton"] = "Target latest NPC"
_G["BINDING_NAME_CLICK NPCScan_SearchMacroButton:LeftButton"] = "Targeting Macro"

-----------------------------------------------------------------------
-- Constants.
-----------------------------------------------------------------------
local LEFT_CLICK_TEXTURE = [[|TInterface\TUTORIALFRAME\UI-TUTORIAL-FRAME:19:11:-1:0:512:512:9:67:227:306|t]]
local RIGHT_CLICK_TEXTURE = [[|TInterface\TUTORIALFRAME\UI-TUTORIAL-FRAME:20:12:0:-1:512:512:9:66:332:411|t]]

local TOOLTIP_ANCHORS = {
	CENTER = "ANCHOR_LEFT",
	BOTTOM = "ANCHOR_RIGHT",
	BOTTOMLEFT = "AMCHOR_RIGHT",
	BOTTOMRIGHT = "ANCHOR_LEFT",
	LEFT = "ANCHOR_RIGHT",
	RIGHT = "ANCHOR_LEFT",
	TOP = "ANCHOR_LEFT",
	TOPLEFT = "ANCHOR_RIGHT",
	TOPRIGHT = "ANCHOR_LEFT",
}

-----------------------------------------------------------------------
-- Variables.
-----------------------------------------------------------------------
local RaidIconIDs = {}

for index = 1, _G.NUM_RAID_ICONS do
	RaidIconIDs[#RaidIconIDs + 1] = index
end

-----------------------------------------------------------------------
-- Prototype.
-----------------------------------------------------------------------
local TargetButton = _G.CreateFrame("Button")
local TargetButtonMetatable = {
	__index = TargetButton
}

-----------------------------------------------------------------------
-- Helpers.
-----------------------------------------------------------------------
local function AnimationGroup_HideParent(self)
	self:GetParent():Hide()
end

local function AnimationGroup_DismissGrandParent(self)
	self:GetParent():GetParent():DismissByAnimationGroup(self)
end

local function AnimationGroup_DismissParent(self)
	self:GetParent():DismissByAnimationGroup(self)
end

-----------------------------------------------------------------------
-- Scripts.
-----------------------------------------------------------------------
local function TargetButton_OnClick(self, mouseButton)
	if mouseButton == "RightButton" then
		self.dismissAnimationGroup:Play()
	end
end

local function TargetButton_OnEnter(self)
	local tooltip = _G.GameTooltip
	tooltip:SetOwner(self, TOOLTIP_ANCHORS[self:GetEffectiveSpawnPoint()], 0, -50)
	tooltip:AddLine(LEFT_CLICK_TEXTURE .. " " .. _G.TARGET, 0.5, 0.8, 1)
	tooltip:AddLine(RIGHT_CLICK_TEXTURE .. " " .. _G.REMOVE, 0.5, 0.8, 1)
	tooltip:Show()

	self.durationFadeAnimationGroup:Stop()
	self.durationFadeAnimationGroup.animOut:SetStartDelay(private.db.profile.targetButtonGroup.durationSeconds)
end

local function TargetButton_OnLeave(self)
	_G.GameTooltip:Hide()

	self.durationFadeAnimationGroup:Play()
end

-----------------------------------------------------------------------
-- Event and message handlers.
-----------------------------------------------------------------------
function TargetButton:COMBAT_LOG_EVENT_UNFILTERED(eventName, _, subEvent, _, _, _, _, _, destGUID)
	if subEvent == "UNIT_DIED" and destGUID and private.GUIDToCreatureID(destGUID) == self.npcID then
		self.isDead = true
	end
end

function TargetButton:PLAYER_REGEN_ENABLED()
	if self.isDead then
		self.isDead = nil

		if private.db.profile.alert.soundIsEnabled then
			_G.PlaySoundFile(LibSharedMedia:Fetch("sound", "NPCScan Killed"), private.db.profile.alert.soundChannel)
		end

		self.shineTexture:Show()
		self.shineTexture.animIn:Play()

		self.killedTexture:Show()
		self.killedTexture.animIn:Play()
	elseif self.pausedAnimations then
		for index = 1, #self.pausedAnimations do
			self.pausedAnimations[index]:Play()
		end
	end

	self.pausedAnimations = nil
end

function TargetButton:UpdateData(eventName, data)
	if data.npcID == self.npcID then
		if data.unitClassification and self.__classification ~= data.unitClassification and not _G.InCombatLockdown() then
			self:SendMessage("NPCScan_TargetButtonNeedsReclassified", self, data)
			return
		end

		local hasUpdated = false

		if self.needsRaidTarget then
			hasUpdated = self:SetRaidTarget(data.unitToken)
		end

		if self.needsUnitData then
			if data.sourceText then
				self.SourceText:SetText(data.sourceText)
			end

			self.PortraitModel:SetUnit(data.unitToken)
			self:SetUnitData(data)

			hasUpdated = true
		end


		if hasUpdated then
			self.shineTexture:Show()
			self.shineTexture.animIn:Play()
		end
	end
end

-----------------------------------------------------------------------
-- Methods.
-----------------------------------------------------------------------
function TargetButton:Activate(data)
	if self.SpecialText then
		local npcData = private.NPCData[data.npcID]
		if npcData and npcData.achievementID then
			local _, achievementName = _G.GetAchievementInfo(npcData.achievementID)
			self.SpecialText:SetFormattedText("%s%s|r", npcData.isCriteriaCompleted and _G.GREEN_FONT_COLOR_CODE or _G.RED_FONT_COLOR_CODE, achievementName)
		end
	end

	self.npcID = data.npcID
	self.npcName = data.npcName

	self.SourceText:SetText(data.sourceText)

	if data.unitToken then
		self.PortraitModel:SetUnit(data.unitToken)
	else
		self.PortraitModel:SetCreature(data.npcID)
	end

	self.PortraitModel:SetPortraitZoom(1)

	self:SetRaidTarget(data.unitToken)
	self:SetUnitData(data)

	if data.isFromQueue then
		self.needsRaidTarget = true
	end

	local macroText = ("/cleartarget\n/targetexact %s"):format(data.npcName)
	_G.NPCScan_RecentTargetButton:SetAttribute("macrotext", macroText)
	self:SetAttribute("macrotext", macroText)

	self:Show()

	if self.PreAnimateIn then
		self:PreAnimateIn()
	end

	self.animIn:Play()

	self.glowTexture:Show()
	self.glowTexture.animIn:Play()

	self.shineTexture:Show()
	self.shineTexture.animIn:Play()

	if self:IsMouseOver() then
		self.durationFadeAnimationGroup.animOut:SetStartDelay(1)
	else
		self.durationFadeAnimationGroup.animOut:SetStartDelay(private.db.profile.targetButtonGroup.durationSeconds)
	end

	self.durationFadeAnimationGroup:Play()

	self.__isActive = true

	self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	self:RegisterEvent("PLAYER_REGEN_ENABLED")
	self:RegisterMessage("NPCScan_UnitInformationAvailable", "UpdateData")

	if not data.isSilent then
		self:SendMessage("NPCScan_TargetButtonActivated", self)
	end
end

function TargetButton:Deactivate()
	self:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	self:UnregisterEvent("PLAYER_REGEN_ENABLED")
	self:UnregisterMessage("NPCScan_UnitInformationAvailable")

	self.__isActive = nil

	-- Make certain these are stopped, else they may finish soon after Activate is called again.
	self.dismissAnimationGroup:Stop()
	self.durationFadeAnimationGroup:Stop()
	self.killedTexture.animIn:Stop()

	self.killedTexture:Hide()
	self:Hide()

	table.insert(RaidIconIDs, self.raidIconID)
	self.raidIconID = nil

	self.Classification:SetText("")
	self.RaidIcon:Hide()
	self.PortraitModel:ClearModel()

	if self.SpecialText then
		self.SpecialText:SetText("")
	end

	self.npcID = nil
	self.npcName = nil

	self.needsUnitData = nil
	self.isDead = nil
end

function TargetButton:DismissByAnimationGroup(animationGroup)
	if self.__isActive then
		if _G.InCombatLockdown() then
			self.pausedAnimations = self.pausedAnimations or {}
			table.insert(self.pausedAnimations, animationGroup)

			animationGroup:Pause()
			return
		end

		self:SendMessage("NPCScan_TargetButtonDismissed", self)
	end
end

function TargetButton:GetEffectiveSpawnPoint()
	local x, y = self:GetCenter()
	if not x or not y then
		return private.DEFAULT_OS_SPAWN_POINT
	end

	local horizontalName = (x > _G.UIParent:GetWidth() * 2 / 3) and "RIGHT" or (x < _G.UIParent:GetWidth() / 3) and "LEFT" or ""
	local verticalName = (y > _G.UIParent:GetHeight() / 2) and "TOP" or "BOTTOM"
	return verticalName .. horizontalName
end

function TargetButton:SetRaidTarget(unitToken)
	if unitToken and not self.raidIconID and #RaidIconIDs > 0 then
		self.raidIconID = table.remove(RaidIconIDs)
		_G.SetRaidTargetIconTexture(self.RaidIcon, self.raidIconID)

		self.RaidIcon:Show()

		local raidMarker = private.db.profile.detection.raidMarker
		if raidMarker.add and (raidMarker.addInGroup or not _G.IsInGroup()) and _G.GetRaidTargetIndex(unitToken) ~= self.raidIconID then
			_G.SetRaidTarget(unitToken, self.raidIconID)
		end

		self.needsRaidTarget = nil
	else
		self.needsRaidTarget = true
	end

	return not self.needsRaidTarget
end

function TargetButton:SetUnitData(data)
	if data.unitCreatureType then
		if data.unitLevel then
			local template = (self.__classification == "elite" or self.__classification == "rareelite") and _G.UNIT_TYPE_PLUS_LEVEL_TEMPLATE or _G.UNIT_TYPE_LEVEL_TEMPLATE
			self.Classification:SetText(template:format(data.unitLevel, data.unitCreatureType))

			local color = _G.GetRelativeDifficultyColor(_G.UnitLevel("player"), data.unitLevel)
			self.UnitName:SetFormattedText("|cff%02x%02x%02x%s|r", color.r * 255, color.g * 255, color.b * 255, data.npcName)
		else
			self.Classification:SetText(_G.UNIT_TYPE_LETHAL_LEVEL_TEMPLATE:format(data.unitCreatureType))
			self.UnitName:SetFormattedText("%s%s|r", _G.RED_FONT_COLOR_CODE, data.npcName)
		end

		self.needsUnitData = nil
	else
		self.UnitName:SetText(data.npcName)
		self.needsUnitData = true
	end
end

-----------------------------------------------------------------------
-- Initialization.
-----------------------------------------------------------------------
local ClassificationDecorators

do
	local macroLines = {}

	local function ResetMacroText(self)
		self:SetAttribute("macrotext", ("/print \"%s\""):format(_G.ERR_GENERIC_NO_TARGET))
	end

	function NPCScan:InitializeTargetButton()
		local recentButton = _G.CreateFrame("Button", "NPCScan_RecentTargetButton", nil, "SecureActionButtonTemplate")
		recentButton:SetAttribute("type", "macro")
		recentButton:Hide()

		recentButton.ResetMacroText = ResetMacroText
		recentButton:ResetMacroText()

		local macroButton = AceEvent:Embed(_G.CreateFrame("Button", "NPCScan_SearchMacroButton", nil, "SecureActionButtonTemplate"))
		macroButton:SetAttribute("type", "macro")
		macroButton:Hide()

		macroButton.ResetMacroText = ResetMacroText
		macroButton:ResetMacroText()

		function macroButton:PLAYER_REGEN_ENABLED()
			if self.needsUpdate then
				self:UpdateMacroText(self.npcScanList)

				self.needsUpdate = nil
				self.npcScanList = nil
			end
		end

		macroButton:RegisterEvent("PLAYER_REGEN_ENABLED")

		function macroButton:UpdateMacroText(npcScanList)
			if _G.InCombatLockdown() then
				self.npcScanList = npcScanList
				self.needsUpdate = true
				return
			end

			local addedCount = 0

			table.wipe(macroLines)

			for npcID in pairs(npcScanList) do
				table.insert(macroLines, ("/targetexact %s"):format(NPCScan:GetNPCNameFromID(npcID)))
				addedCount = addedCount + 1
			end

			if addedCount == 0 then
				self:ResetMacroText()
				return
			end

			self:SetAttribute("macrotext", table.concat(macroLines, "\n"))
		end

		ClassificationDecorators = {
			elite = private.DecorateEliteTargetButton,
			minus = private.DecorateNormalTargetButton,
			normal = private.DecorateNormalTargetButton,
			rare = private.DecorateRareTargetButton,
			rareelite = private.DecorateEliteTargetButton,
			worldboss = private.DecorateEliteTargetButton,
		}
	end
end -- do-block

local function CreateTargetButton(unitClassification)
	local CreateAlphaAnimation = private.CreateAlphaAnimation

	local button = _G.CreateFrame("Button", nil, _G.UIParent, "SecureActionButtonTemplate, SecureHandlerShowHideTemplate")
	button:SetFrameStrata("DIALOG")
	button:SetAttribute("type", "macro")
	button:SetAttribute("_onshow", "self:Enable()")
	button:SetAttribute("_onhide", "self:Disable()")
	button:RegisterForClicks("AnyUp")

	button:HookScript("OnClick", TargetButton_OnClick)
	button:SetScript("OnEnter", TargetButton_OnEnter)
	button:SetScript("OnLeave", TargetButton_OnLeave)

	button:Hide()

	AceEvent:Embed(_G.setmetatable(button, TargetButtonMetatable))

	-----------------------------------------------------------------------
	-- Textures.
	-----------------------------------------------------------------------
	local raidIcon = button:CreateTexture(nil, "ARTWORK")
	raidIcon:Hide()
	raidIcon:SetTexture([[Interface\TargetingFrame\UI-RaidTargetingIcons]])
	raidIcon:SetSize(16, 16)
	button.RaidIcon = raidIcon

	local portrait = button:CreateTexture(nil, "BORDER")
	portrait:SetTexture([[Interface\FrameGeneral\UI-Background-Marble]])
	portrait:SetSize(52, 52)
	button.Portrait = portrait

	local background = button:CreateTexture(nil, "BORDER", nil, 1)
	background:SetAlpha(0)
	background:SetBlendMode("BLEND")
	button.Background = background

	local glowTexture = button:CreateTexture(nil, "OVERLAY")
	glowTexture:SetBlendMode("ADD")
	glowTexture:SetAtlas("loottoast-glow")
	button.glowTexture = glowTexture

	local shineTexture = button:CreateTexture(nil, "OVERLAY")
	shineTexture:SetBlendMode("ADD")
	shineTexture:SetAtlas("loottoast-sheen")
	button.shineTexture = shineTexture

	local killedTexture = button:CreateTexture(nil, "OVERLAY")
	killedTexture:Hide()
	killedTexture:SetBlendMode("ADD")
	killedTexture:SetTexture([[Interface\FullScreenTextures\LowHealth]])
	button.killedTexture = killedTexture

	-----------------------------------------------------------------------
	-- FontStrings.
	-----------------------------------------------------------------------
	local sourceText = button:CreateFontString(nil, "ARTWORK", 1)
	sourceText:SetFontObject("GameFontNormalSmall")
	button.SourceText = sourceText

	local unitName = button:CreateFontString(nil, "ARTWORK", 1)
	unitName:SetSize(165, 33)
	unitName:SetFontObject("GameFontNormalMed3")
	unitName:SetJustifyH("LEFT")
	unitName:SetJustifyV("MIDDLE")
	button.UnitName = unitName

	local classification = button:CreateFontString(nil, "ARTWORK", 1)
	classification:SetFontObject("GameFontNormalSmall")
	button.Classification = classification

	-----------------------------------------------------------------------
	-- Animations.
	-----------------------------------------------------------------------
	local buttonAnimIn = button:CreateAnimationGroup()
	buttonAnimIn:SetToFinalAlpha(true)
	button.animIn = buttonAnimIn

	-- Glow
	local glowAnimationGroup = glowTexture:CreateAnimationGroup()
	glowTexture.animIn = glowAnimationGroup

	glowAnimationGroup:SetScript("OnFinished", AnimationGroup_HideParent)

	local glowAnimInShow = CreateAlphaAnimation(glowAnimationGroup, 0, 1, 0.2, nil, 1)
	local glowAnimInHide = CreateAlphaAnimation(glowAnimationGroup, 1, 0, 0.5, nil, 2)

	-- Shine
	local shineAnimationGroup = shineTexture:CreateAnimationGroup()
	shineTexture.animIn = shineAnimationGroup

	shineAnimationGroup:SetScript("OnFinished", AnimationGroup_HideParent)

	local shineAnimateIn = CreateAlphaAnimation(shineAnimationGroup, 0, 1, 0.1, nil, 1)

	local shineOffset = shineAnimationGroup:CreateAnimation("Translation")
	shineOffset:SetOffset(165, 0)
	shineOffset:SetDuration(0.425)
	shineOffset:SetOrder(2)

	local shineAnimateOut = CreateAlphaAnimation(shineAnimationGroup, 1, 0, 0.25, 0.175, 2)

	-- Killed
	local killedAnimationGroup = killedTexture:CreateAnimationGroup()
	killedTexture.animIn = killedAnimationGroup

	killedAnimationGroup:SetScript("OnFinished", AnimationGroup_DismissGrandParent)
	killedAnimationGroup.name = "killedAnimationGroup"

	local killedAnimInShow = CreateAlphaAnimation(killedAnimationGroup, 0, 1, 0.2, nil, 1)
	local killedAnimInHide = CreateAlphaAnimation(killedAnimationGroup, 1, 0, 0.5, nil, 2)

	-- Background
	local backgroundAnimIn = CreateAlphaAnimation(buttonAnimIn, 0, 1, 0.4, nil, 1)
	backgroundAnimIn:SetTarget(button)
	backgroundAnimIn:SetChildKey("Background")

	-- Portrait
	local portraitAnimIn = CreateAlphaAnimation(buttonAnimIn, 0, 1, 0.4, nil, 1)
	portraitAnimIn:SetTarget(button)
	portraitAnimIn:SetChildKey("Portrait")

	-- RaidIcon
	local raidIconAnimIn = CreateAlphaAnimation(buttonAnimIn, 0, 1, 0.4, nil, 1)
	raidIconAnimIn:SetTarget(button)
	raidIconAnimIn:SetChildKey("RaidIcon")

	-- Model
	local modelAnimIn = CreateAlphaAnimation(buttonAnimIn, 0, 1, 0.4, nil, 1)
	modelAnimIn:SetTarget(button)
	modelAnimIn:SetChildKey("PortraitModel")

	-- Dismissed
	local dismissAnimationGroup = button:CreateAnimationGroup()
	local dismissAnim = private.CreateAlphaAnimation(dismissAnimationGroup, 1, 0, 0.5, 0.5)
	dismissAnimationGroup:SetScript("OnFinished", AnimationGroup_DismissParent)
	button.dismissAnimationGroup = dismissAnimationGroup
	dismissAnimationGroup.name = "dismissAnimationGroup"

	-- Duration
	local durationFadeAnimationGroup = button:CreateAnimationGroup()
	durationFadeAnimationGroup:SetScript("OnFinished", AnimationGroup_DismissParent)
	button.durationFadeAnimationGroup = durationFadeAnimationGroup
	durationFadeAnimationGroup.name = "durationFadeAnimationGroup"

	local durationFadeAnim = private.CreateAlphaAnimation(durationFadeAnimationGroup, 1, 0, 1.5, private.db.profile.targetButtonGroup.durationSeconds)
	durationFadeAnimationGroup.animOut = durationFadeAnim

	-----------------------------------------------------------------------
	-- Etcetera.
	-----------------------------------------------------------------------
	ClassificationDecorators[unitClassification](button)
	button.__classification = unitClassification

	return button
end

private.CreateTargetButton = CreateTargetButton

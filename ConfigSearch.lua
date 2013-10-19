--[[****************************************************************************
  * _NPCScan by Saiket                                                         *
  * ConfigSearch.lua - Adds a configuration pane to add/remove NPCs and        *
  * achievements to search for.                                                *
  ****************************************************************************]]


local FOLDER_NAME, private = ...
local L = private.L
local NS = CreateFrame("Frame")
private.Config.Search = NS

NS.AddFoundCheckbox = CreateFrame("CheckButton", "_NPCScanSearchAchievementAddFoundCheckbox", NS, "InterfaceOptionsCheckButtonTemplate")
NS.BlockFlightScanCheckbox = CreateFrame("CheckButton", "_NPCScannerBlockFlightScanCheckbox", NS, "InterfaceOptionsCheckButtonTemplate")

NS.TableContainer = CreateFrame("Frame", nil, NS)

NS.NPCControls = CreateFrame("Frame", nil, NS.TableContainer)
NS.NPCName = CreateFrame("EditBox", "_NPCScanSearchNpcName", NS.NPCControls, "InputBoxTemplate")
NS.NPCNpcID = CreateFrame("EditBox", "_NPCScanSearchNpcID", NS.NPCControls, "InputBoxTemplate")
NS.NPCWorld = CreateFrame("EditBox", "_NPCScanSearchNpcWorld", NS.NPCControls, "InputBoxTemplate")
NS.NPCWorldButton = CreateFrame("Button", nil, NS.NPCWorld)
NS.NPCWorldButton.Dropdown = CreateFrame("Frame", "_NPCScanSearchNPCWorldDropdown", NS.NPCWorldButton)
NS.NPCAdd = CreateFrame("Button", nil, NS.NPCControls, "UIPanelButtonTemplate")
NS.NPCRemove = CreateFrame("Button", nil, NS.NPCControls, "UIPanelButtonTemplate")

NS.InactiveAlpha = 0.5

local TEXTURE_NOT_READY = [[|TInterface\RaidFrame\ReadyCheck-NotReady:0|t]]
local TEXTURE_READY = [[|TInterface\RaidFrame\ReadyCheck-Ready:0|t]]


-- Sets the search for found achievement mobs option when its checkbox is clicked.
function NS.AddFoundCheckbox.setFunc(Enable)
	if private.SetAchievementsAddFound(Enable == "1") then
		private.CacheListPrint(true)
	end
end

--FlightSupress
function NS.BlockFlightScanCheckbox.setFunc(Enable)
	if private.OptionsCharacter.FlightSupress then
		private.OptionsCharacter.FlightSupress = false
		NS.BlockFlightScanCheckbox:SetChecked(false)
	else
		private.OptionsCharacter.FlightSupress = true

		NS.BlockFlightScanCheckbox:SetChecked(true)
	end
end


-- Converts a localized world name into a WorldID.
local function GetWorldID(World)
	if World ~= "" then
		return private.LOCALIZED_CONTINENT_IDS[World] or World
	end
end

-- Converts a WorldID into a localized world name.
local function GetWorldIDName(WorldID)
	return type(WorldID) == "number" and private.LOCALIZED_CONTINENT_NAMES[WorldID] or WorldID
end


-- Selects the given table tab.
function NS.TabSelect(NewTab)
	local OldTab = NS.TabSelected
	if NewTab ~= OldTab then
		if OldTab then
			if OldTab.Deactivate then
				OldTab:Deactivate()
			end
			PanelTemplates_DeselectTab(OldTab)
		end

		for _, Row in ipairs(NS.Table.Rows) do
			Row:SetAlpha(1.0)
		end
		NS.Table:Clear()

		NS.TabSelected = NewTab
		PanelTemplates_SelectTab(NewTab)
		if NewTab.Activate then
			NewTab:Activate()
		end
		NewTab:Update()
	end
end


-- Selects a tab's table view when clicked.
function NS:TabOnClick()
	PlaySound("igCharacterInfoTab")
	NS.TabSelect(self)
end


-- Displays a tooltip for a table tab when moused over.
function NS:TabOnEnter()
	GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, -8)
	if self.AchievementID then
		local _, Name, _, _, _, _, _, Description = GetAchievementInfo(self.AchievementID)
		local WorldID = private.ACHIEVEMENTS[self.AchievementID].WorldID
		local Highlight = HIGHLIGHT_FONT_COLOR
		if WorldID then
			GameTooltip:ClearLines()
			local Gray = GRAY_FONT_COLOR
			GameTooltip:AddDoubleLine(Name, L.SEARCH_WORLD_FORMAT:format(GetWorldIDName(WorldID)),
				Highlight.r, Highlight.g, Highlight.b, Gray.r, Gray.g, Gray.b)
		else
			GameTooltip:SetText(Name, Highlight.r, Highlight.g, Highlight.b)
		end
		GameTooltip:AddLine(Description, nil, nil, nil, true)

		if not private.OptionsCharacter.Achievements[self.AchievementID] then
			local Color = RED_FONT_COLOR
			GameTooltip:AddLine(L.SEARCH_ACHIEVEMENT_DISABLED, Color.r, Color.g, Color.b)
		end
	elseif self.AchievementID == "BEASTS" then
		GameTooltip:SetText(L.SEARCH_TAMEBEAST_DECS, nil, nil, nil, nil, true)
	else
		GameTooltip:SetText(L.SEARCH_NPCS_DESC, nil, nil, nil, nil, true)
	end
	GameTooltip:Show()
end


-- Enables or disables tracking an achievement when its tab checkbox is clicked.
function NS:TabCheckOnClick()
	local Enable = self:GetChecked()
	PlaySound(Enable and "igMainMenuOptionCheckBoxOn" or "igMainMenuOptionCheckBoxOff")

	local AchievementID = self:GetParent().AchievementID
	NS.AchievementSetEnabled(AchievementID, Enable)
	if not Enable then
		private.AchievementRemove(AchievementID)
	elseif private.AchievementAdd(AchievementID) then -- Cache might have changed
		private.CacheListPrint(true)
	end
end


-- Show's the tab's tooltip when mousing over the tab's checkbox.
function NS:TabCheckOnEnter()
	NS.TabOnEnter(self:GetParent())
end


function NS:RareTabCheckOnClick()
	local Enable = self:GetChecked()
	PlaySound(Enable and "igMainMenuOptionCheckBoxOn" or "igMainMenuOptionCheckBoxOff")
	local TabID = self:GetParent().TabID
	local Tab = self:GetParent()
	NS.AchievementSetEnabled(TabID, Enable)

	if TabID == "BEASTS" then
		private.OptionsCharacter.TrackBeasts = Enable or nil
	elseif TabID == "RARENPC" then
		private.OptionsCharacter.TrackRares = Enable or nil
	end
	private.RareMobToggle(TabID, Enable)
	NS.UpdateTab(TabID)
	private.CacheListPrint(true)
end


local Tabs = {} -- [ "NPC" or AchievementID ] = Tab


-- Validates ability to use add and remove buttons for NPCs.
function NS.NPCValidate()
	local NpcID, Name, WorldID = NS.NPCNpcID:GetNumber(), NS.NPCName:GetText(), GetWorldID(NS.NPCWorld:GetText())

	local OldName = private.Options.NPCs[NpcID]
	local OldWorldID = private.Options.NPCWorldIDs[NpcID]
	local CanAdd = NpcID and Name ~= ""
		and NpcID >= 1 and NpcID <= private.NPC_ID_MAX
		and (Name ~= OldName or WorldID ~= OldWorldID)

	-- Color world name orange if not a standard continent
	local WorldColor = type(WorldID) == "string" and ORANGE_FONT_COLOR or HIGHLIGHT_FONT_COLOR
	NS.NPCWorld:SetTextColor(WorldColor.r, WorldColor.g, WorldColor.b)

	if NS.Table then
		NS.Table:SetSelectionByKey(OldName and NpcID or nil)
	end
	NS.NPCAdd[CanAdd and "Enable" or "Disable"](NS.NPCAdd)
	NS.NPCRemove[OldName and "Enable" or "Disable"](NS.NPCRemove)
end


-- Clears the NPC controls.
function NS.NPCClear()
	NS.NPCNpcID:SetText("")
	NS.NPCName:SetText("")
	NS.NPCWorld:SetText("")
end


-- Adds a Custom NPC list element.
function NS.NPCAdd:OnClick()
	local NpcID, Name, WorldID = NS.NPCNpcID:GetNumber(), NS.NPCName:GetText(), GetWorldID(NS.NPCWorld:GetText())
	if private.TamableIDs[NpcID] then
		private.Print(L.SEARCH_ADD_TAMABLE_FORMAT:format(Name))
	end
	private.NPCRemove(NpcID)
	if private.NPCAdd(NpcID, Name, WorldID) then
		private.CacheListPrint(true)
	end
	NS.NPCClear()
end


-- Removes a Custom NPC list element.
function NS.NPCRemove:OnClick()
	private.NPCRemove(NS.NPCNpcID:GetNumber())
	NS.NPCClear()
end


-- Cycles through edit box controls.
function NS:NPCOnTabPressed()
	self.NextEditBox:SetFocus()
end


-- Attempts to add the entered NPC when enter is pressed in any edit box.
function NS:NPCOnEnterPressed()
	self:ClearFocus()
	NS.NPCAdd:Click()
end


-- Fills in the edit boxes when a table row is selected.
function NS:NPCOnSelect(NpcID)
	if NpcID ~= nil then
		NS.NPCNpcID:SetNumber(NpcID)
		NS.NPCName:SetText(private.Options.NPCs[NpcID])
		NS.NPCWorld:SetText(GetWorldIDName(private.Options.NPCWorldIDs[NpcID]) or "")
	end
end


-- Builds a dropdown of continent names.
function NS.NPCWorldButton.Dropdown:initialize()
	local Info = UIDropDownMenu_CreateInfo()
	Info.notCheckable = true
	Info.func = self.OnSelect
	for Index = 1, select("#", GetMapContinents()) do
		local World = private.LOCALIZED_CONTINENT_NAMES[Index]
		if World then -- Not an excluded virtual continent
			Info.text, Info.arg1 = World, World
			UIDropDownMenu_AddButton(Info)
		end
	end
	local CurrentWorld = GetInstanceInfo()
	if not private.LOCALIZED_CONTINENT_IDS[CurrentWorld] then -- Add current instance name
		-- Spacer
		Info = UIDropDownMenu_CreateInfo()
		Info.notCheckable = true
		Info.disabled = true
		UIDropDownMenu_AddButton(Info)
		-- Current instance
		Info.disabled = nil
		Info.text, Info.arg1 = CurrentWorld, CurrentWorld
		Info.colorCode = ORANGE_FONT_COLOR_CODE
		Info.func = self.OnSelect
		UIDropDownMenu_AddButton(Info)
	end
end


-- Selects a preset world name from the dropdown.
function NS.NPCWorldButton.Dropdown:OnSelect(Name)
	NS.NPCWorld:SetText(Name)
end


-- Opens a dropdown with world name presets.
function NS.NPCWorldButton:OnClick()
	local Parent = self:GetParent()
	Parent:ClearFocus()
	ToggleDropDownMenu(nil, nil, self.Dropdown)
	PlaySound("igMainMenuOptionCheckBoxOn")
end


-- Hides the dropdown if its button is hidden.
function NS.NPCWorldButton:OnHide()
	CloseDropDownMenus()
end


local function GeneralNPCUpdate(world_ids, map_ids, npc_data)
	NS.NPCValidate()

	for npc_id, npc_name in pairs(npc_data) do
		local map_id = map_ids[npc_id]

		if type(map_id) == "boolean" then
			map_id = nil
		end

		local new_row = NS.Table:AddRow(
			npc_id,
			private.NPCNameFromCache(npc_id) and TEXTURE_NOT_READY or "",
			npc_name,
			npc_id,
			GetWorldIDName(world_ids[npc_id]) or "",
			map_id and (_G.GetMapNameByID(map_id) or map_id) or ""
		)

		if not private.NPCIsActive(npc_id) then
			new_row:SetAlpha(NS.InactiveAlpha)
		end
	end
end


function NS:NPCUpdate()
	GeneralNPCUpdate(private.Options.NPCWorldIDs, private.RareMobData.NPCMapIDs, private.Options.NPCs)
end


function NS:RareNPCUpdate()
	GeneralNPCUpdate(private.RareMobData.NPCWorldIDs, private.RareMobData.NPCMapIDs, private.RareMobData.RareNPCs)
end


function NS:TameableNPCUpdate()
	GeneralNPCUpdate(private.RareMobData.NPCWorldIDs, private.TamableIDs, private.TamableNames)
end


-- Customizes the table when the NPCs tab is selected.
function NS:CustomNPCActivate()
	NS.Table:SetHeader(L.SEARCH_CACHED, L.SEARCH_NAME, L.SEARCH_ID, L.SEARCH_WORLD, L.SEARCH_MAP)
	NS.Table:SetSortHandlers(true, true, true, true, true)
	NS.Table:SetSortColumn(2) -- Default by name

	NS.NPCClear()
	NS.NPCControls:Show()
	NS.TableContainer:SetPoint("BOTTOM", NS.NPCControls, "TOP", 0, 4)
	NS.Table.OnSelect = NS.NPCOnSelect
end


-- Customizes the table when the NPCs tab is selected.
function NS:DefultNPCActivate()
	NS.Table:SetHeader(L.SEARCH_CACHED, L.SEARCH_NAME, L.SEARCH_ID, L.SEARCH_WORLD, L.SEARCH_MAP)
	NS.Table:SetSortHandlers(true, true, true, true, true)
	NS.Table:SetSortColumn(2) -- Default by name

	NS.NPCClear()
	--NS.NPCControls:Show()
	NS.TableContainer:SetPoint("BOTTOM", NS.NPCControls, "TOP", 0, 4)
	--NS.Table.OnSelect = NS.NPCOnSelect
end


-- Undoes customization to the table when leaving the NPCs tab.
function NS:NPCDeactivate()
	NS.NPCControls:Hide()
	NS.TableContainer:SetPoint("BOTTOM", NS.NPCControls)
	NS.Table.OnSelect = nil
end


-- Enables/disables the achievement related to a tab.
function NS.AchievementSetEnabled(AchievementID, Enable)
	local Tab = Tabs[AchievementID]
	Tab.Checkbox:SetChecked(Enable)
	local Texture = Tab.Checkbox:GetCheckedTexture()
	Texture:SetTexture(Enable
		and [[Interface\Buttons\UI-CheckBox-Check]]
		or [[Interface\RAIDFRAME\ReadyCheck-NotReady]])
	Texture:Show()

	-- Update tooltip if shown
	if GameTooltip:GetOwner() == Tab then
		NS.TabOnEnter(Tab)
	end

	if NS.TabSelected == Tab then
		NS.Table.Header:SetAlpha(Enable and 1.0 or NS.InactiveAlpha)
	end
end


-- Fills the search table with achievement NPCs.
function NS:AchievementUpdate()
	local Achievement = private.ACHIEVEMENTS[self.AchievementID]
	local Overlay = IsAddOnLoaded("_NPCScan.Overlay") and private.Overlay
	for CriteriaID, NpcID in pairs(Achievement.Criteria) do
		if NpcID > 1 then
			local Name, _, Completed = GetAchievementCriteriaInfoByID(self.AchievementID, CriteriaID)
			local Map = private.RareMobData.NPCMapIDs[NpcID]
			--local Map = Overlay and Overlay.GetNPCMapID( NpcID )
			local Row = NS.Table:AddRow(NpcID,
				private.NPCNameFromCache(NpcID) and TEXTURE_NOT_READY or "",
				Name, NpcID,
				Completed and TEXTURE_READY or "",
				Map and (GetMapNameByID(Map) or Map) or "")

			if not private.AchievementNPCIsActive(Achievement, NpcID) then
				Row:SetAlpha(NS.InactiveAlpha)
			end
		end
	end
end


-- Customizes the table when an achievement tab is selected.
function NS:AchievementActivate()

	NS.Table:SetHeader(L.SEARCH_CACHED, L.SEARCH_NAME, L.SEARCH_ID, L.SEARCH_COMPLETED, L.SEARCH_MAP)
	NS.Table:SetSortHandlers(true, true, true, true, true)
	NS.Table:SetSortColumn(2) -- Default by name

	NS.Table.Header:SetAlpha(private.OptionsCharacter.Achievements[self.AchievementID] and 1.0 or NS.InactiveAlpha)
end


-- Undoes customization to the table when leaving an achievement tab.
function NS:AchievementDeactivate()
	NS.Table.Header:SetAlpha(1.0)
end


do
	-- Recreates table data at most once per frame.
	local function OnUpdate(self)
		self:SetScript("OnUpdate", nil)

		for _, Row in ipairs(NS.Table.Rows) do
			Row:SetAlpha(1.0)
		end
		NS.Table:Clear()
		NS.TabSelected:Update()
	end

	--- Updates the table for a given tab if it is displayed.
	function NS.UpdateTab(ID)
		if not ID or Tabs[ID] == NS.TabSelected then
			NS.TableContainer:SetScript("OnUpdate", OnUpdate)
		end
	end
end


do
	local CreateRowBackup


	-- Creates the NPC table when first shown, and selects the Custom NPCs tab.
	function NS:OnShow()
		if not NS.Table then
			NS.Table = LibStub("LibTextTable-1.1").New(nil, NS.TableContainer)
			NS.Table:SetAllPoints()
		end

		if NS.TabSelected then
			NS.UpdateTab()
		else
			NS.TabSelect(Tabs["NPC"])
		end
	end
end


-- Reverts to default options.
function NS:default()
	private.Synchronize(private.Options) -- Resets only character settings
end


NS.name = L.SEARCH_TITLE
NS.parent = L.CONFIG_TITLE
NS:Hide()
NS:SetScript("OnShow", NS.OnShow)

-- Pane title
local Title = NS:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
Title:SetPoint("TOPLEFT", 16, -16)
Title:SetText(L.SEARCH_TITLE)
local SubText = NS:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
SubText:SetPoint("TOPLEFT", Title, "BOTTOMLEFT", 0, -8)
SubText:SetPoint("RIGHT", -32, 0)
SubText:SetHeight(32)
SubText:SetJustifyH("LEFT")
SubText:SetJustifyV("TOP")
SubText:SetText(L.SEARCH_DESC)


-- Settings checkboxes
NS.AddFoundCheckbox:SetPoint("TOPLEFT", SubText, "BOTTOMLEFT", -2, -8)
NS.AddFoundCheckbox.tooltipText = L.SEARCH_ACHIEVEMENTADDFOUND_DESC
local Label = _G[NS.AddFoundCheckbox:GetName() .. "Text"]
Label:SetText(L.SEARCH_ACHIEVEMENTADDFOUND)
NS.AddFoundCheckbox:SetHitRectInsets(4, 4 - Label:GetStringWidth(), 4, 4)

-- Flight alert supression checkboxes
NS.BlockFlightScanCheckbox:SetPoint("BOTTOMLEFT", NS.AddFoundCheckbox, "TOPLEFT", 0, 0)
NS.BlockFlightScanCheckbox.tooltipText = L.BLOCKFLIGHTSCAN_DESC
local Label = _G[NS.BlockFlightScanCheckbox:GetName() .. "Text"]
Label:SetText(L.BLOCKFLIGHTSCAN)
NS.BlockFlightScanCheckbox:SetHitRectInsets(4, 4 - Label:GetStringWidth(), 4, 4)


-- Controls for NPCs table
NS.NPCControls:Hide()

-- Create add and remove buttons
NS.NPCRemove:SetSize(16, 20)
NS.NPCRemove:SetPoint("BOTTOMRIGHT", NS, -16, 16)
NS.NPCRemove:SetText(L.SEARCH_REMOVE)
NS.NPCRemove:SetScript("OnClick", NS.NPCRemove.OnClick)
NS.NPCAdd:SetSize(16, 20)
NS.NPCAdd:SetPoint("BOTTOMRIGHT", NS.NPCRemove, "TOPRIGHT", 0, 4)
NS.NPCAdd:SetText(L.SEARCH_ADD)
NS.NPCAdd:SetScript("OnClick", NS.NPCAdd.OnClick)
NS.NPCAdd:SetScript("OnEnter", private.Config.ControlOnEnter)
NS.NPCAdd:SetScript("OnLeave", GameTooltip_Hide)
NS.NPCAdd.tooltipText = L.SEARCH_ADD_DESC

-- Create edit boxes
local NameLabel = NS.NPCControls:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
NameLabel:SetPoint("LEFT", NS, 16, 0)
NameLabel:SetPoint("TOP", NS.NPCRemove)
NameLabel:SetPoint("BOTTOM", NS.NPCRemove)
NameLabel:SetText(L.SEARCH_NAME)
local NpcIDLabel = NS.NPCControls:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
NpcIDLabel:SetPoint("LEFT", NameLabel)
NpcIDLabel:SetPoint("TOP", NS.NPCAdd)
NpcIDLabel:SetPoint("BOTTOM", NS.NPCAdd)
NpcIDLabel:SetText(L.SEARCH_ID)


local function EditBoxSetup(self)
	self:SetAutoFocus(false)
	self:SetScript("OnTabPressed", NS.NPCOnTabPressed)
	self:SetScript("OnEnterPressed", NS.NPCOnEnterPressed)
	self:SetScript("OnTextChanged", NS.NPCValidate)
	self:SetScript("OnEnter", private.Config.ControlOnEnter)
	self:SetScript("OnLeave", GameTooltip_Hide)
	return self
end


local NpcID, Name, World = EditBoxSetup(NS.NPCNpcID), EditBoxSetup(NS.NPCName), EditBoxSetup(NS.NPCWorld)
Name:SetPoint("LEFT", -- Attach to longest label
	NameLabel:GetStringWidth() > NpcIDLabel:GetStringWidth() and NameLabel or NpcIDLabel,
	"RIGHT", 8, 0)
Name:SetPoint("RIGHT", NS.NPCRemove, "LEFT", -4, 0)
Name:SetPoint("TOP", NameLabel)
Name:SetPoint("BOTTOM", NameLabel)
Name.NextEditBox, Name.tooltipText = NpcID, L.SEARCH_NAME_DESC

NpcID:SetPoint("LEFT", Name)
NpcID:SetPoint("TOP", NpcIDLabel)
NpcID:SetPoint("BOTTOM", NpcIDLabel)
NpcID:SetWidth(64)
NpcID:SetNumeric(true)
NpcID:SetMaxLetters(floor(log10(private.NPC_ID_MAX)) + 1)
NpcID.NextEditBox, NpcID.tooltipText = World, L.SEARCH_ID_DESC

local WorldLabel = NS.NPCControls:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
WorldLabel:SetPoint("LEFT", NpcID, "RIGHT", 8, 0)
WorldLabel:SetPoint("TOP", NpcIDLabel)
WorldLabel:SetPoint("BOTTOM", NpcIDLabel)
WorldLabel:SetText(L.SEARCH_WORLD)

World:SetPoint("LEFT", WorldLabel, "RIGHT", 8, 0)
World:SetPoint("RIGHT", Name)
World:SetPoint("TOP", NpcIDLabel)
World:SetPoint("BOTTOM", NpcIDLabel)
World.NextEditBox, World.tooltipText = Name, L.SEARCH_WORLD_DESC

local WorldButton = NS.NPCWorldButton
WorldButton:SetPoint("RIGHT", World, 3, 1)
WorldButton:SetSize(24, 24)
WorldButton:SetNormalTexture([[Interface\ChatFrame\UI-ChatIcon-ScrollDown-Up]])
WorldButton:SetPushedTexture([[Interface\ChatFrame\UI-ChatIcon-ScrollDown-Down]])
WorldButton:SetHighlightTexture([[Interface\Buttons\UI-Common-MouseHilight]], "ADD")
WorldButton:SetScript("OnClick", WorldButton.OnClick)
WorldButton:SetScript("OnHide", WorldButton.OnHide)
UIDropDownMenu_SetAnchor(WorldButton.Dropdown, 0, 0, "TOPRIGHT", WorldButton, "BOTTOMRIGHT")

NS.NPCControls:SetPoint("BOTTOMRIGHT", NS.NPCRemove)
NS.NPCControls:SetPoint("LEFT", NpcIDLabel)
NS.NPCControls:SetPoint("TOP", NS.NPCAdd)


-- Place table
NS.TableContainer:SetPoint("TOP", NS.AddFoundCheckbox, "BOTTOM", 0, -28)
NS.TableContainer:SetPoint("LEFT", SubText, -2, 0)
NS.TableContainer:SetPoint("RIGHT", -16, 0)
NS.TableContainer:SetPoint("BOTTOM", NS.NPCControls)
NS.TableContainer:SetBackdrop({ bgFile = [[Interface\DialogFrame\UI-DialogBox-Background]] })

-- Add all tabs
local FirstTab
local LastTab
local TabCount = 0
local TabRow = 0


local function AddTab(ID, Update, Activate, Deactivate)
	TabCount = TabCount + 1
	local Tab = CreateFrame("Button", "_NPCScanSearchTab" .. TabCount, NS.TableContainer, "TabButtonTemplate")
	Tabs[ID] = Tab

	Tab:SetHitRectInsets(6, 6, 6, 0)
	Tab:SetScript("OnClick", NS.TabOnClick)
	Tab:SetScript("OnEnter", NS.TabOnEnter)
	Tab:SetScript("OnLeave", GameTooltip_Hide)
	Tab:SetMotionScriptsWhileDisabled(true) -- Allow tooltip while active

	if type(ID) == "number" then -- AchievementID
		Tab:SetText((select(2, GetAchievementInfo(ID))))
		Tab:GetFontString():SetPoint("RIGHT", -12, 0)
		local Checkbox = CreateFrame("CheckButton", nil, Tab, "UICheckButtonTemplate")
		Tab.AchievementID, Tab.Checkbox = ID, Checkbox
		Checkbox:SetSize(20, 20)
		Checkbox:SetPoint("BOTTOMLEFT", 8, 0)
		Checkbox:SetHitRectInsets(4, 4, 4, 4)
		Checkbox:SetScript("OnClick", NS.TabCheckOnClick)
		--Checkbox:SetScript( "OnEnter", NS.TabCheckOnEnter )
		Checkbox:SetScript("OnLeave", GameTooltip_Hide)
		NS.AchievementSetEnabled(ID, false) -- Initialize the custom "unchecked" texture
		PanelTemplates_TabResize(Tab, Checkbox:GetWidth() - 12)
	elseif ID == "BEASTS" then
		Tab:SetText(L.TAMEDBEASTS)
		Tab:GetFontString():SetPoint("RIGHT", -12, 0)
		local Checkbox = CreateFrame("CheckButton", nil, Tab, "UICheckButtonTemplate")
		Tab.TabID, Tab.Checkbox = ID, Checkbox
		Checkbox:SetSize(20, 20)
		Checkbox:SetPoint("BOTTOMLEFT", 8, 0)
		Checkbox:SetHitRectInsets(4, 4, 4, 4)
		Checkbox:SetScript("OnClick", NS.RareTabCheckOnClick)
		--Checkbox:SetScript( "OnEnter", NS.TabCheckOnEnter )
		Checkbox:SetScript("OnLeave", GameTooltip_Hide)
		NS.AchievementSetEnabled(ID, false) -- Initialize the custom "unchecked" texture
		PanelTemplates_TabResize(Tab, Checkbox:GetWidth() - 12)

	elseif ID == "RARENPC" then
		Tab:SetText("Rare Mobs")
		Tab:GetFontString():SetPoint("RIGHT", -12, 0)
		local Checkbox = CreateFrame("CheckButton", nil, Tab, "UICheckButtonTemplate")
		Tab.TabID, Tab.Checkbox = ID, Checkbox
		Checkbox:SetSize(20, 20)
		Checkbox:SetPoint("BOTTOMLEFT", 8, 0)
		Checkbox:SetHitRectInsets(4, 4, 4, 4)
		Checkbox:SetScript("OnClick", NS.RareTabCheckOnClick)
		--Checkbox:SetScript( "OnEnter", NS.TabCheckOnEnter )
		Checkbox:SetScript("OnLeave", GameTooltip_Hide)
		NS.AchievementSetEnabled(ID, false) -- Initialize the custom "unchecked" texture
		PanelTemplates_TabResize(Tab, Checkbox:GetWidth() - 12)

	else
		Tab:SetText(L.SEARCH_NPCS)
		PanelTemplates_TabResize(Tab, -8)
	end

	Tab.Update = Update
	Tab.Activate, Tab.Deactivate = Activate, Deactivate

	PanelTemplates_DeselectTab(Tab)
	if LastTab then
		if TabCount > 5 and TabRow == 0 then
			Tab:SetPoint("BOTTOMLEFT", FirstTab, "TOPLEFT", 0, -10)
			NS.TableContainer:SetPoint("TOP", NS.AddFoundCheckbox, "BOTTOM", 0, -60)
			TabRow = 1
		else
			Tab:SetPoint("LEFT", LastTab, "RIGHT", -4, 0)
		end
	else
		Tab:SetPoint("BOTTOMLEFT", NS.TableContainer, "TOPLEFT")
	end
	if TabCount == 1 then FirstTab = Tab end
	LastTab = Tab
end

AddTab("NPC", NS.NPCUpdate, NS.CustomNPCActivate, NS.NPCDeactivate)
AddTab("RARENPC", NS.RareNPCUpdate, NS.DefultNPCActivate, NS.NPCDeactivate)
AddTab("BEASTS", NS.TameableNPCUpdate, NS.DefultNPCActivate, NS.NPCDeactivate)

for AchievementID in pairs(private.ACHIEVEMENTS) do
	AddTab(AchievementID, NS.AchievementUpdate, NS.AchievementActivate, NS.AchievementDeactivate)
end


InterfaceOptions_AddCategory(NS)


function NS:UpdateTabNames()
	for AchievementID in pairs(private.ACHIEVEMENTS) do
		Tabs[AchievementID]:SetText((select(2, GetAchievementInfo(AchievementID))))
		Tabs[AchievementID]:GetFontString():SetPoint("RIGHT", -12, 0)
		PanelTemplates_TabResize(Tabs[AchievementID], 20 - 12)
	end
end

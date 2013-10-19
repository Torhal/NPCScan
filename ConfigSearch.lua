-------------------------------------------------------------------------------
-- Localized Lua globals.
-------------------------------------------------------------------------------
local _G = getfenv(0)

-- Functions
local pairs = _G.pairs
local select = _G.select
local type = _G.type


-------------------------------------------------------------------------------
-- AddOn namespace.
-------------------------------------------------------------------------------
local FOLDER_NAME, private = ...
local L = private.L
local NS = _G.CreateFrame("Frame")
private.Config.Search = NS

NS.AddFoundCheckbox = _G.CreateFrame("CheckButton", "_NPCScanSearchAchievementAddFoundCheckbox", NS, "InterfaceOptionsCheckButtonTemplate")
NS.BlockFlightScanCheckbox = _G.CreateFrame("CheckButton", "_NPCScannerBlockFlightScanCheckbox", NS, "InterfaceOptionsCheckButtonTemplate")

NS.TableContainer = _G.CreateFrame("Frame", nil, NS)

NS.NPCControls = _G.CreateFrame("Frame", nil, NS.TableContainer)
NS.NPCName = _G.CreateFrame("EditBox", "_NPCScanSearchNpcName", NS.NPCControls, "InputBoxTemplate")
NS.NPCNpcID = _G.CreateFrame("EditBox", "_NPCScanSearchNpcID", NS.NPCControls, "InputBoxTemplate")
NS.NPCWorld = _G.CreateFrame("EditBox", "_NPCScanSearchNpcWorld", NS.NPCControls, "InputBoxTemplate")
NS.NPCWorldButton = _G.CreateFrame("Button", nil, NS.NPCWorld)
NS.NPCWorldButton.Dropdown = _G.CreateFrame("Frame", "_NPCScanSearchNPCWorldDropdown", NS.NPCWorldButton)
NS.NPCAdd = _G.CreateFrame("Button", nil, NS.NPCControls, "UIPanelButtonTemplate")
NS.NPCRemove = _G.CreateFrame("Button", nil, NS.NPCControls, "UIPanelButtonTemplate")

NS.InactiveAlpha = 0.5

local TEXTURE_NOT_READY = [[|TInterface\RaidFrame\ReadyCheck-NotReady:0|t]]
local TEXTURE_READY = [[|TInterface\RaidFrame\ReadyCheck-Ready:0|t]]


-- Sets the search for found achievement mobs option when its checkbox is clicked.
function NS.AddFoundCheckbox.setFunc(Enable)
	if private.SetAchievementsAddFound(Enable == "1") then
		private.CacheListPrint(true)
	end
end

--FlightSuppress
function NS.BlockFlightScanCheckbox.setFunc(Enable)
	if private.OptionsCharacter.FlightSupress then
		private.OptionsCharacter.FlightSupress = false
		NS.BlockFlightScanCheckbox:SetChecked(false)
	else
		private.OptionsCharacter.FlightSupress = true

		NS.BlockFlightScanCheckbox:SetChecked(true)
	end
end


local function GetWorldID(localized_name)
	if localized_name ~= "" then
		return private.LOCALIZED_CONTINENT_IDS[localized_name] or localized_name
	end
end

-- Converts a WorldID into a localized world name.
local function GetWorldIDName(world_id)
	return type(world_id) == "number" and private.LOCALIZED_CONTINENT_NAMES[world_id] or world_id
end


-- Selects the given table tab.
function NS.TabSelect(new_tab)
	local old_tab = NS.TabSelected

	if new_tab == old_tab then
		return
	end

	if old_tab then
		if old_tab.Deactivate then
			old_tab:Deactivate()
		end
		_G.PanelTemplates_DeselectTab(old_tab)
	end

	for _, row in ipairs(NS.Table.Rows) do
		row:SetAlpha(1.0)
	end
	NS.Table:Clear()

	NS.TabSelected = new_tab
	_G.PanelTemplates_SelectTab(new_tab)
	if new_tab.Activate then
		new_tab:Activate()
	end
	new_tab:Update()
end


-- Selects a tab's table view when clicked.
function NS:TabOnClick()
	_G.PlaySound("igCharacterInfoTab")
	NS.TabSelect(self)
end


-- Displays a tooltip for a table tab when moused over.
function NS:TabOnEnter()
	local tooltip = _G.GameTooltip
	tooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, -8)

	if self.AchievementID then
		local _, name, _, _, _, _, _, description = _G.GetAchievementInfo(self.AchievementID)
		local world_id = private.ACHIEVEMENTS[self.AchievementID].WorldID
		local highlight = _G.HIGHLIGHT_FONT_COLOR

		if world_id then
			local gray = _G.GRAY_FONT_COLOR

			tooltip:ClearLines()
			tooltip:AddDoubleLine(name, L.SEARCH_WORLD_FORMAT:format(GetWorldIDName(world_id)), highlight.r, highlight.g, highlight.b, gray.r, gray.g, gray.b)
		else
			tooltip:SetText(name, highlight.r, highlight.g, highlight.b)
		end
		tooltip:AddLine(description, nil, nil, nil, true)

		if not private.OptionsCharacter.Achievements[self.AchievementID] then
			local color = _G.RED_FONT_COLOR
			tooltip:AddLine(L.SEARCH_ACHIEVEMENT_DISABLED, color.r, color.g, color.b)
		end
	elseif self.AchievementID == "BEASTS" then
		tooltip:SetText(L.SEARCH_TAMEBEAST_DECS, nil, nil, nil, nil, true)
	else
		tooltip:SetText(L.SEARCH_NPCS_DESC, nil, nil, nil, nil, true)
	end
	tooltip:Show()
end


-- Enables or disables tracking an achievement when its tab checkbox is clicked.
function NS:TabCheckOnClick()
	local is_enabled = self:GetChecked()
	_G.PlaySound(is_enabled and "igMainMenuOptionCheckBoxOn" or "igMainMenuOptionCheckBoxOff")

	local achievement_id = self:GetParent().AchievementID
	NS.AchievementSetEnabled(achievement_id, is_enabled)

	if not is_enabled then
		private.AchievementRemove(achievement_id)
	elseif private.AchievementAdd(achievement_id) then -- Cache might have changed
		private.CacheListPrint(true)
	end
end


-- Shows the tab's tooltip when mousing over the tab's checkbox.
function NS:TabCheckOnEnter()
	NS.TabOnEnter(self:GetParent())
end


function NS:RareTabCheckOnClick()
	local is_enabled = self:GetChecked()
	_G.PlaySound(is_enabled and "igMainMenuOptionCheckBoxOn" or "igMainMenuOptionCheckBoxOff")

	local tab_id = self:GetParent().TabID
	NS.AchievementSetEnabled(tab_id, is_enabled)

	if tab_id == "BEASTS" then
		private.OptionsCharacter.TrackBeasts = is_enabled or nil
	elseif tab_id == "RARENPC" then
		private.OptionsCharacter.TrackRares = is_enabled or nil
	end
	private.RareMobToggle(tab_id, is_enabled)
	NS.UpdateTab(tab_id)
	private.CacheListPrint(true)
end


local Tabs = {} -- [ "NPC" or AchievementID ] = Tab


-- Validates ability to use add and remove buttons for NPCs.
function NS.NPCValidate()
	local npc_id = NS.NPCNpcID:GetNumber()
	local npc_name = NS.NPCName:GetText()
	local world_id = GetWorldID(NS.NPCWorld:GetText())
	local old_name = private.Options.NPCs[npc_id]
	local old_world_id = private.Options.NPCWorldIDs[npc_id]
	local can_add = npc_id and npc_id >= 1 and npc_id <= private.NPC_ID_MAX and npc_name ~= "" and (npc_name ~= old_name or world_id ~= old_world_id)

	-- Color world name orange if not a continent
	local world_color = type(world_id) == "string" and _G.ORANGE_FONT_COLOR or _G.HIGHLIGHT_FONT_COLOR
	NS.NPCWorld:SetTextColor(world_color.r, world_color.g, world_color.b)

	if NS.Table then
		NS.Table:SetSelectionByKey(old_name and npc_id or nil)
	end
	NS.NPCAdd[can_add and "Enable" or "Disable"](NS.NPCAdd)
	NS.NPCRemove[old_name and "Enable" or "Disable"](NS.NPCRemove)
end


function NS.NPCClear()
	NS.NPCNpcID:SetText("")
	NS.NPCName:SetText("")
	NS.NPCWorld:SetText("")
end


-- Adds a Custom NPC list element.
function NS.NPCAdd:OnClick()
	local npc_id = NS.NPCNpcID:GetNumber()
	local npc_name = NS.NPCName:GetText()
	local world_id = GetWorldID(NS.NPCWorld:GetText())

	if private.TamableIDs[npc_id] then
		private.Print(L.SEARCH_ADD_TAMABLE_FORMAT:format(npc_name))
	end
	private.NPCRemove(npc_id)

	if private.NPCAdd(npc_id, npc_name, world_id) then
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
function NS:NPCOnSelect(npc_id)
	if not npc_id then
		return
	end
	NS.NPCNpcID:SetNumber(npc_id)
	NS.NPCName:SetText(private.Options.NPCs[npc_id])
	NS.NPCWorld:SetText(GetWorldIDName(private.Options.NPCWorldIDs[npc_id]) or "")
end


function NS.NPCWorldButton.Dropdown:initialize()
	local info = _G.UIDropDownMenu_CreateInfo()
	info.notCheckable = true
	info.func = self.OnSelect

	for index = 1, select("#", _G.GetMapContinents()) do
		local continent_name = private.LOCALIZED_CONTINENT_NAMES[index]

		if continent_name then
			info.text = continent_name
			info.arg1 = continent_name
			_G.UIDropDownMenu_AddButton(info)
		end
	end
	local instance_name = _G.GetInstanceInfo()

	if not private.LOCALIZED_CONTINENT_IDS[instance_name] then -- Add current instance name
		info = _G.UIDropDownMenu_CreateInfo()
		info.notCheckable = true
		info.disabled = true
		_G.UIDropDownMenu_AddButton(info)

		info.disabled = nil
		info.text = instance_name
		info.arg1 = instance_name
		info.colorCode = _G.ORANGE_FONT_COLOR_CODE
		info.func = self.OnSelect
		_G.UIDropDownMenu_AddButton(info)
	end
end


function NS.NPCWorldButton.Dropdown:OnSelect(world_name)
	NS.NPCWorld:SetText(world_name)
end


function NS.NPCWorldButton:OnClick()
	self:GetParent():ClearFocus()
	_G.ToggleDropDownMenu(nil, nil, self.Dropdown)
	_G.PlaySound("igMainMenuOptionCheckBoxOn")
end


function NS.NPCWorldButton:OnHide()
	_G.CloseDropDownMenus()
end


local function GeneralNPCUpdate(world_ids, map_ids, npc_data)
	NS.NPCValidate()

	for npc_id, npc_name in pairs(npc_data) do
		local map_id = map_ids[npc_id]

		if type(map_id) == "boolean" then
			map_id = nil
		end

		local new_row = NS.Table:AddRow(npc_id,
			private.NPCNameFromCache(npc_id) and TEXTURE_NOT_READY or "",
			npc_name,
			npc_id,
			GetWorldIDName(world_ids[npc_id]) or "",
			map_id and (_G.GetMapNameByID(map_id) or map_id) or "")

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
	NS.TableContainer:SetPoint("BOTTOM", NS.NPCControls, "TOP", 0, 4)
end


-- Undoes customization to the table when leaving the NPCs tab.
function NS:NPCDeactivate()
	NS.NPCControls:Hide()
	NS.TableContainer:SetPoint("BOTTOM", NS.NPCControls)
	NS.Table.OnSelect = nil
end


-- Enables/disables the achievement related to a tab.
function NS.AchievementSetEnabled(achievement_id, is_enabled)
	local current_tab = Tabs[achievement_id]
	current_tab.Checkbox:SetChecked(is_enabled)

	local checked_texture = current_tab.Checkbox:GetCheckedTexture()
	checked_texture:SetTexture(is_enabled and [[Interface\Buttons\UI-CheckBox-Check]] or [[Interface\RAIDFRAME\ReadyCheck-NotReady]])
	checked_texture:Show()

	if _G.GameTooltip:GetOwner() == current_tab then
		NS.TabOnEnter(current_tab)
	end

	if NS.TabSelected == current_tab then
		NS.Table.Header:SetAlpha(is_enabled and 1 or NS.InactiveAlpha)
	end
end


-- Fills the search table with achievement NPCs.
function NS:AchievementUpdate()
	local achievement = private.ACHIEVEMENTS[self.AchievementID]

	for criteria_id, npc_id in pairs(achievement.Criteria) do
		if npc_id > 1 then
			local npc_name, _, is_completed = _G.GetAchievementCriteriaInfoByID(self.AchievementID, criteria_id)
			local map_id = private.RareMobData.NPCMapIDs[npc_id]
			local new_row = NS.Table:AddRow(npc_id,
				private.NPCNameFromCache(npc_id) and TEXTURE_NOT_READY or "",
				npc_name,
				npc_id,
				is_completed and TEXTURE_READY or "",
				map_id and (_G.GetMapNameByID(map_id) or map_id) or "")

			if not private.AchievementNPCIsActive(achievement, npc_id) then
				new_row:SetAlpha(NS.InactiveAlpha)
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

		for _, row in ipairs(NS.Table.Rows) do
			row:SetAlpha(1.0)
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
			NS.Table = _G.LibStub("LibTextTable-1.1").New(nil, NS.TableContainer)
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

-- Flight alert suppression checkboxes
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
NS.NPCAdd:SetScript("OnLeave", _G.GameTooltip_Hide)
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
	self:SetScript("OnLeave", _G.GameTooltip_Hide)
	return self
end


local NpcID, Name, World = EditBoxSetup(NS.NPCNpcID), EditBoxSetup(NS.NPCName), EditBoxSetup(NS.NPCWorld)
Name:SetPoint("LEFT", NameLabel:GetStringWidth() > NpcIDLabel:GetStringWidth() and NameLabel or NpcIDLabel, "RIGHT", 8, 0)
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
_G.UIDropDownMenu_SetAnchor(WorldButton.Dropdown, 0, 0, "TOPRIGHT", WorldButton, "BOTTOMRIGHT")

NS.NPCControls:SetPoint("BOTTOMRIGHT", NS.NPCRemove)
NS.NPCControls:SetPoint("LEFT", NpcIDLabel)
NS.NPCControls:SetPoint("TOP", NS.NPCAdd)


-- Place table
NS.TableContainer:SetPoint("TOP", NS.AddFoundCheckbox, "BOTTOM", 0, -28)
NS.TableContainer:SetPoint("LEFT", SubText, -2, 0)
NS.TableContainer:SetPoint("RIGHT", -16, 0)
NS.TableContainer:SetPoint("BOTTOM", NS.NPCControls)
NS.TableContainer:SetBackdrop({ bgFile = [[Interface\DialogFrame\UI-DialogBox-Background]] })


local AddTab
do
	local first_tab
	local last_tab
	local num_tabs = 0
	local tab_row = 0


	local function CreateTabCheckBox(tab, onclick_script)
		local checkbox = _G.CreateFrame("CheckButton", nil, tab, "UICheckButtonTemplate")
		checkbox:SetSize(20, 20)
		checkbox:SetPoint("BOTTOMLEFT", 8, 0)
		checkbox:SetHitRectInsets(4, 4, 4, 4)
		checkbox:SetScript("OnClick", onclick_script)
		--Checkbox:SetScript( "OnEnter", NS.TabCheckOnEnter )
		checkbox:SetScript("OnLeave", _G.GameTooltip_Hide)

		tab.Checkbox = checkbox
	end


	function AddTab(achievement_id, update_func, activate_func, deactivate_func)
		num_tabs = num_tabs + 1

		local tab = _G.CreateFrame("Button", "_NPCScanSearchTab" .. num_tabs, NS.TableContainer, "TabButtonTemplate")
		tab:SetHitRectInsets(6, 6, 6, 0)
		tab:SetScript("OnClick", NS.TabOnClick)
		tab:SetScript("OnEnter", NS.TabOnEnter)
		tab:SetScript("OnLeave", _G.GameTooltip_Hide)
		tab:SetMotionScriptsWhileDisabled(true) -- Allow tooltip while active

		Tabs[achievement_id] = tab

		if type(achievement_id) == "number" then
			local _, achievement_name = _G.GetAchievementInfo(achievement_id)
			tab.AchievementID = achievement_id
			tab:SetText(achievement_name)
			tab:GetFontString():SetPoint("RIGHT", -12, 0)

			CreateTabCheckBox(tab, NS.TabCheckOnClick)
		elseif achievement_id == "BEASTS" then
			tab.TabID = achievement_id
			tab:SetText(L.TAMEDBEASTS)
			tab:GetFontString():SetPoint("RIGHT", -12, 0)

			CreateTabCheckBox(tab, NS.RareTabCheckOnClick)
		elseif achievement_id == "RARENPC" then
			tab.TabID = achievement_id
			tab:SetText("Rare Mobs")
			tab:GetFontString():SetPoint("RIGHT", -12, 0)

			CreateTabCheckBox(tab, NS.RareTabCheckOnClick)
		end

		if tab.Checkbox then
			NS.AchievementSetEnabled(achievement_id, false)
			_G.PanelTemplates_TabResize(tab, tab.Checkbox:GetWidth() - 12)
		else
			tab:SetText(L.SEARCH_NPCS)
			_G.PanelTemplates_TabResize(tab, -8)
		end
		tab.Update = update_func
		tab.Activate = activate_func
		tab.Deactivate = deactivate_func

		_G.PanelTemplates_DeselectTab(tab)

		if last_tab then
			if num_tabs > 5 and tab_row == 0 then
				tab:SetPoint("BOTTOMLEFT", first_tab, "TOPLEFT", 0, -10)
				NS.TableContainer:SetPoint("TOP", NS.AddFoundCheckbox, "BOTTOM", 0, -60)
				tab_row = 1
			else
				tab:SetPoint("LEFT", last_tab, "RIGHT", -4, 0)
			end
		else
			tab:SetPoint("BOTTOMLEFT", NS.TableContainer, "TOPLEFT")
		end

		if num_tabs == 1 then
			first_tab = tab
		end
		last_tab = tab
	end
end -- do-block


AddTab("NPC", NS.NPCUpdate, NS.CustomNPCActivate, NS.NPCDeactivate)
AddTab("RARENPC", NS.RareNPCUpdate, NS.DefultNPCActivate, NS.NPCDeactivate)
AddTab("BEASTS", NS.TameableNPCUpdate, NS.DefultNPCActivate, NS.NPCDeactivate)


for achievement_id in pairs(private.ACHIEVEMENTS) do
	AddTab(achievement_id, NS.AchievementUpdate, NS.AchievementActivate, NS.AchievementDeactivate)
end


_G.InterfaceOptions_AddCategory(NS)


function NS:UpdateTabNames()
	for achievement_id in pairs(private.ACHIEVEMENTS) do
		local _, achievement_name = _G.GetAchievementInfo(achievement_id)

		Tabs[achievement_id]:SetText(achievement_name)
		Tabs[achievement_id]:GetFontString():SetPoint("RIGHT", -12, 0)
		_G.PanelTemplates_TabResize(Tabs[achievement_id], 20 - 12)
	end
end

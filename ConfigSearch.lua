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

local panel = _G.CreateFrame("Frame")


-------------------------------------------------------------------------------
-- Constants.
-------------------------------------------------------------------------------
local ALPHA_ACTIVE = 1
local ALPHA_INACTIVE = 0.5
local TEXTURE_NOT_READY = [[|TInterface\RaidFrame\ReadyCheck-NotReady:0|t]]
local TEXTURE_READY = [[|TInterface\RaidFrame\ReadyCheck-Ready:0|t]]


-------------------------------------------------------------------------------
-- Variables.
-------------------------------------------------------------------------------
local panel_tabs = {}


-------------------------------------------------------------------------------
-- Helpers.
-------------------------------------------------------------------------------
local function GetWorldID(localized_name)
	if localized_name ~= "" then
		return private.LOCALIZED_CONTINENT_IDS[localized_name] or localized_name
	end
end


local function GetWorldIDName(world_id)
	return type(world_id) == "number" and private.LOCALIZED_CONTINENT_NAMES[world_id] or world_id
end


-- Validates ability to use, add, and remove buttons for NPCs.
local function UpdateButtonStates()
	local npc_id = panel.npc_id_editbox:GetNumber()
	local npc_name = panel.npc_name_editbox:GetText()
	local world_id = GetWorldID(panel.npc_world_editbox:GetText())
	local old_npc_name = private.Options.NPCs[npc_id]
	local old_world_id = private.Options.NPCWorldIDs[npc_id]
	local can_add = npc_id and npc_id >= 1 and npc_id <= private.NPC_ID_MAX and npc_name ~= "" and (npc_name ~= old_npc_name or world_id ~= old_world_id)

	-- Color world name orange if not a continent
	local world_color = type(world_id) == "string" and _G.ORANGE_FONT_COLOR or _G.HIGHLIGHT_FONT_COLOR
	panel.npc_world_editbox:SetTextColor(world_color.r, world_color.g, world_color.b)

	if panel.table then
		panel.table:SetSelectionByKey(old_npc_name and npc_id or nil)
	end
	panel.npc_add_button[can_add and "Enable" or "Disable"](panel.npc_add_button)
	panel.npc_remove_button[old_npc_name and "Enable" or "Disable"](panel.npc_remove_button)
end


local InitializeEditBox
do
	local function EditBox_OnEnterPressed(self)
		self:ClearFocus()
		panel.npc_add_button:Click()
	end


	local function EditBox_OnTabPressed(self)
		panel[self.next_editbox]:SetFocus()
	end


	function InitializeEditBox(editbox)
		editbox:SetAutoFocus(false)
		editbox:SetScript("OnTabPressed", EditBox_OnTabPressed)
		editbox:SetScript("OnEnterPressed", EditBox_OnEnterPressed)
		editbox:SetScript("OnTextChanged", UpdateButtonStates)
		editbox:SetScript("OnEnter", private.Config.ControlOnEnter)
		editbox:SetScript("OnLeave", _G.GameTooltip_Hide)
	end
end -- do-block


-------------------------------------------------------------------------------
-- Config UI.
-------------------------------------------------------------------------------
panel.name = L.SEARCH_TITLE
panel.parent = L.CONFIG_TITLE
panel:Hide()

panel:SetScript("OnShow", function(self)
	if not self.table then
		self.table = _G.LibStub("LibTextTable-1.1").New(nil, self.table_container)
		self.table:SetAllPoints()
	end

	if self.selected_tab then
		self.UpdateTab()
	else
		self:SelectTab(panel_tabs.NPC)
	end
end)


private.Config.Search = panel


local panel_title = panel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
panel_title:SetPoint("TOPLEFT", 16, -16)
panel_title:SetText(L.SEARCH_TITLE)


local panel_subtext = panel:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
panel_subtext:SetPoint("TOPLEFT", panel_title, "BOTTOMLEFT", 0, -8)
panel_subtext:SetPoint("RIGHT", -32, 0)
panel_subtext:SetHeight(32)
panel_subtext:SetJustifyH("LEFT")
panel_subtext:SetJustifyV("TOP")
panel_subtext:SetText(L.SEARCH_DESC)


local add_found_checkbox = _G.CreateFrame("CheckButton", "_NPCScanSearchAchievementAddFoundCheckbox", panel, "InterfaceOptionsCheckButtonTemplate")
add_found_checkbox:SetPoint("TOPLEFT", panel_subtext, "BOTTOMLEFT", -2, -8)
add_found_checkbox.tooltipText = L.SEARCH_ACHIEVEMENTADDFOUND_DESC

panel.add_found_checkbox = add_found_checkbox

local add_found_label = _G[add_found_checkbox:GetName() .. "Text"]
add_found_label:SetText(L.SEARCH_ACHIEVEMENTADDFOUND)
add_found_checkbox:SetHitRectInsets(4, 4 - add_found_label:GetStringWidth(), 4, 4)

function add_found_checkbox.setFunc(is_enabled)
	if private.SetAchievementsAddFound(is_enabled == "1") then
		private.CacheListPrint(true)
	end
end


local block_flight_scan_checkbox = _G.CreateFrame("CheckButton", "_NPCScannerBlockFlightScanCheckbox", panel, "InterfaceOptionsCheckButtonTemplate")
block_flight_scan_checkbox:SetPoint("BOTTOMLEFT", add_found_checkbox, "TOPLEFT", 0, 0)
block_flight_scan_checkbox.tooltipText = L.BLOCKFLIGHTSCAN_DESC

panel.block_flight_scan_checkbox = block_flight_scan_checkbox

local block_flight_scan_label = _G[block_flight_scan_checkbox:GetName() .. "Text"]
block_flight_scan_label:SetText(L.BLOCKFLIGHTSCAN)
block_flight_scan_checkbox:SetHitRectInsets(4, 4 - block_flight_scan_label:GetStringWidth(), 4, 4)

function block_flight_scan_checkbox.setFunc()
	if private.OptionsCharacter.FlightSupress then
		private.OptionsCharacter.FlightSupress = false
		panel.block_flight_scan_checkbox:SetChecked(false)
	else
		private.OptionsCharacter.FlightSupress = true
		panel.block_flight_scan_checkbox:SetChecked(true)
	end
end


local table_container = _G.CreateFrame("Frame", nil, panel)
table_container:SetBackdrop({
	bgFile = [[Interface\DialogFrame\UI-DialogBox-Background]]
})

panel.table_container = table_container


local npc_controls = _G.CreateFrame("Frame", nil, table_container)
npc_controls:Hide()

panel.npc_controls = npc_controls


-- Anchor table_container - must be done here since its anchoring depends on the existence of npc_controls. TODO: Fix this insanity.
table_container:SetPoint("TOP", add_found_checkbox, "BOTTOM", 0, -28)
table_container:SetPoint("LEFT", panel_subtext, -2, 0)
table_container:SetPoint("RIGHT", -16, 0)
table_container:SetPoint("BOTTOM", npc_controls)


local npc_world_editbox = _G.CreateFrame("EditBox", "_NPCScanSearchNpcWorldEditBox", npc_controls, "InputBoxTemplate")
npc_world_editbox.next_editbox = "npc_name_editbox"
npc_world_editbox.tooltipText = L.SEARCH_WORLD_DESC

InitializeEditBox(npc_world_editbox)
panel.npc_world_editbox = npc_world_editbox


local npc_world_button = _G.CreateFrame("Button", nil, npc_world_editbox)
npc_world_button:SetPoint("RIGHT", npc_world_editbox, 3, 1)
npc_world_button:SetSize(24, 24)
npc_world_button:SetNormalTexture([[Interface\ChatFrame\UI-ChatIcon-ScrollDown-Up]])
npc_world_button:SetPushedTexture([[Interface\ChatFrame\UI-ChatIcon-ScrollDown-Down]])
npc_world_button:SetHighlightTexture([[Interface\Buttons\UI-Common-MouseHilight]], "ADD")

npc_world_button:SetScript("OnClick", function(self)
	self:GetParent():ClearFocus()
	_G.ToggleDropDownMenu(nil, nil, self.dropdown)
	_G.PlaySound("igMainMenuOptionCheckBoxOn")
end)

npc_world_button:SetScript("OnHide", function(self)
	_G.CloseDropDownMenus()
end)

panel.npc_world_button = npc_world_button


local npc_world_button_dropdown = _G.CreateFrame("Frame", "_NPCScanSearchNPCWorldButtonDropdown", npc_world_button)
_G.UIDropDownMenu_SetAnchor(npc_world_button_dropdown, 0, 0, "TOPRIGHT", npc_world_button, "BOTTOMRIGHT")

panel.npc_world_button.dropdown = npc_world_button_dropdown

function npc_world_button_dropdown:initialize()
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


function npc_world_button_dropdown:OnSelect(world_name)
	npc_world_editbox:SetText(world_name)
end


local npc_remove_button = _G.CreateFrame("Button", nil, npc_controls, "UIPanelButtonTemplate")
npc_remove_button:SetSize(16, 20)
npc_remove_button:SetPoint("BOTTOMRIGHT", panel, -16, 16)
npc_remove_button:SetText(L.SEARCH_REMOVE)
npc_remove_button:SetScript("OnClick", function(self)
	private.NPCRemove(panel.npc_id_editbox:GetNumber())
	panel:ClearEditBoxes()
end)

panel.npc_remove_button = npc_remove_button


local npc_name_editbox_label = npc_controls:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
npc_name_editbox_label:SetPoint("LEFT", panel, 16, 0)
npc_name_editbox_label:SetPoint("TOP", npc_remove_button)
npc_name_editbox_label:SetPoint("BOTTOM", npc_remove_button)
npc_name_editbox_label:SetText(L.SEARCH_NAME)


local npc_add_button = _G.CreateFrame("Button", nil, npc_controls, "UIPanelButtonTemplate")
npc_add_button:SetSize(16, 20)
npc_add_button:SetPoint("BOTTOMRIGHT", npc_remove_button, "TOPRIGHT", 0, 4)
npc_add_button:SetText(L.SEARCH_ADD)
npc_add_button.tooltipText = L.SEARCH_ADD_DESC
npc_add_button:SetScript("OnEnter", private.Config.ControlOnEnter)
npc_add_button:SetScript("OnLeave", _G.GameTooltip_Hide)
npc_add_button:SetScript("OnClick", function(self)
	local npc_id = panel.npc_id_editbox:GetNumber()
	local npc_name = panel.npc_name_editbox:GetText()
	local world_id = GetWorldID(panel.npc_world_editbox:GetText())

	if private.TamableIDs[npc_id] then
		private.Print(L.SEARCH_ADD_TAMABLE_FORMAT:format(npc_name))
	end
	private.NPCRemove(npc_id)

	if private.NPCAdd(npc_id, npc_name, world_id) then
		private.CacheListPrint(true)
	end
	panel:ClearEditBoxes()
end)

panel.npc_add_button = npc_add_button


local npc_id_editbox_label = npc_controls:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
npc_id_editbox_label:SetPoint("LEFT", npc_name_editbox_label)
npc_id_editbox_label:SetPoint("TOP", panel.npc_add_button)
npc_id_editbox_label:SetPoint("BOTTOM", panel.npc_add_button)
npc_id_editbox_label:SetText(L.SEARCH_ID)


-- More delayed anchoring due to existential constraints. TODO: Determine if fixing is possible.
npc_controls:SetPoint("BOTTOMRIGHT", npc_remove_button)
npc_controls:SetPoint("LEFT", npc_id_editbox_label)
npc_controls:SetPoint("TOP", npc_add_button)


local npc_name_editbox = _G.CreateFrame("EditBox", "_NPCScanSearchNpcNameEditBox", npc_controls, "InputBoxTemplate")
npc_name_editbox:SetPoint("LEFT", npc_name_editbox_label:GetStringWidth() > npc_id_editbox_label:GetStringWidth() and npc_name_editbox_label or npc_id_editbox_label, "RIGHT", 8, 0)
npc_name_editbox:SetPoint("RIGHT", npc_remove_button, "LEFT", -4, 0)
npc_name_editbox:SetPoint("TOP", npc_name_editbox_label)
npc_name_editbox:SetPoint("BOTTOM", npc_name_editbox_label)
npc_name_editbox.next_editbox = "npc_id_editbox"
npc_name_editbox.tooltipText = L.SEARCH_NAME_DESC

InitializeEditBox(npc_name_editbox)
panel.npc_name_editbox = npc_name_editbox


local npc_id_editbox = _G.CreateFrame("EditBox", "_NPCScanSearchNpcIDEditBox", npc_controls, "InputBoxTemplate")
npc_id_editbox:SetPoint("LEFT", npc_name_editbox)
npc_id_editbox:SetPoint("TOP", npc_id_editbox_label)
npc_id_editbox:SetPoint("BOTTOM", npc_id_editbox_label)
npc_id_editbox:SetWidth(64)
npc_id_editbox:SetNumeric(true)
npc_id_editbox:SetMaxLetters(floor(log10(private.NPC_ID_MAX)) + 1)
npc_id_editbox.next_editbox = "npc_world_editbox"
npc_id_editbox.tooltipText = L.SEARCH_ID_DESC

InitializeEditBox(npc_id_editbox)
panel.npc_id_editbox = npc_id_editbox


local world_editbox_label = npc_controls:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
world_editbox_label:SetPoint("LEFT", npc_id_editbox, "RIGHT", 8, 0)
world_editbox_label:SetPoint("TOP", npc_id_editbox_label)
world_editbox_label:SetPoint("BOTTOM", npc_id_editbox_label)
world_editbox_label:SetText(L.SEARCH_WORLD)


-- More delayed anchoring. TODO: See about fixing this.
npc_world_editbox:SetPoint("LEFT", world_editbox_label, "RIGHT", 8, 0)
npc_world_editbox:SetPoint("RIGHT", npc_name_editbox)
npc_world_editbox:SetPoint("TOP", npc_id_editbox_label)
npc_world_editbox:SetPoint("BOTTOM", npc_id_editbox_label)


-------------------------------------------------------------------------------
-- Panel methods.
-------------------------------------------------------------------------------
function panel:SelectTab(new_tab)
	local old_tab = self.selected_tab

	if new_tab == old_tab then
		return
	end

	if old_tab then
		if old_tab.Deactivate then
			old_tab:Deactivate()
		end
		_G.PanelTemplates_DeselectTab(old_tab)
	end

	for index = 1, #self.table.Rows do
		self.table.Rows[index]:SetAlpha(ALPHA_ACTIVE)
	end

	self.selected_tab = new_tab
	self.table:Clear()
	_G.PanelTemplates_SelectTab(new_tab)

	if new_tab.Activate then
		new_tab:Activate()
	end
	new_tab:Update()
end


function panel:ClearEditBoxes()
	self.npc_id_editbox:SetText("")
	self.npc_name_editbox:SetText("")
	self.npc_world_editbox:SetText("")
end


-- Fills in the edit boxes when a table row is selected.
function panel:NPCOnSelect(npc_id)
	if not npc_id then
		return
	end
	panel.npc_id_editbox:SetNumber(npc_id)
	panel.npc_name_editbox:SetText(private.Options.NPCs[npc_id])
	panel.npc_world_editbox:SetText(GetWorldIDName(private.Options.NPCWorldIDs[npc_id]) or "")
end


do
	local function GeneralNPCUpdate(world_ids, map_ids, npc_data)
		UpdateButtonStates()

		for npc_id, npc_name in pairs(npc_data) do
			local map_id = map_ids[npc_id]

			if type(map_id) == "boolean" then
				map_id = nil
			end

			local new_row = panel.table:AddRow(npc_id,
				private.NPCNameFromCache(npc_id) and TEXTURE_NOT_READY or "",
				npc_name,
				npc_id,
				GetWorldIDName(world_ids[npc_id]) or "",
				map_id and (_G.GetMapNameByID(map_id) or map_id) or "")

			if not private.NPCIsActive(npc_id) then
				new_row:SetAlpha(ALPHA_INACTIVE)
			end
		end
	end


	function panel:NPCUpdate()
		GeneralNPCUpdate(private.Options.NPCWorldIDs, private.RareMobData.NPCMapIDs, private.Options.NPCs)
	end


	function panel:RareNPCUpdate()
		GeneralNPCUpdate(private.RareMobData.NPCWorldIDs, private.RareMobData.NPCMapIDs, private.RareMobData.RareNPCs)
	end


	function panel:TameableNPCUpdate()
		GeneralNPCUpdate(private.RareMobData.NPCWorldIDs, private.TamableIDs, private.TamableNames)
	end
end -- do-block


-- Customizes the table when the NPCs tab is selected.
function panel:CustomNPCActivate()
	panel.table:SetHeader(L.SEARCH_CACHED, L.SEARCH_NAME, L.SEARCH_ID, L.SEARCH_WORLD, L.SEARCH_MAP)
	panel.table:SetSortHandlers(true, true, true, true, true)
	panel.table:SetSortColumn(2) -- Default by name

	panel:ClearEditBoxes()
	panel.npc_controls:Show()
	panel.table_container:SetPoint("BOTTOM", panel.npc_controls, "TOP", 0, 4)
	panel.table.OnSelect = panel.NPCOnSelect
end


-- Customizes the table when the NPCs tab is selected.
function panel:DefultNPCActivate()
	panel.table:SetHeader(L.SEARCH_CACHED, L.SEARCH_NAME, L.SEARCH_ID, L.SEARCH_WORLD, L.SEARCH_MAP)
	panel.table:SetSortHandlers(true, true, true, true, true)
	panel.table:SetSortColumn(2) -- Default by name

	panel:ClearEditBoxes()
	panel.table_container:SetPoint("BOTTOM", panel.npc_controls, "TOP", 0, 4)
end


-- Undoes customization to the table when leaving the NPCs tab.
function panel:NPCDeactivate()
	panel.npc_controls:Hide()
	panel.table_container:SetPoint("BOTTOM", panel.npc_controls)
	panel.table.OnSelect = nil
end


-- Enables/disables the achievement related to a tab.
function panel.AchievementSetEnabled(achievement_id, is_enabled)
	local tab = panel_tabs[achievement_id]
	tab.Checkbox:SetChecked(is_enabled)

	local checked_texture = tab.Checkbox:GetCheckedTexture()
	checked_texture:SetTexture(is_enabled and [[Interface\Buttons\UI-CheckBox-Check]] or [[Interface\RAIDFRAME\ReadyCheck-NotReady]])
	checked_texture:Show()

	if _G.GameTooltip:GetOwner() == tab then
		tab:GetScript("OnEnter")(tab)
	end

	if panel.selected_tab == tab then
		panel.table.Header:SetAlpha(is_enabled and ALPHA_ACTIVE or ALPHA_INACTIVE)
	end
end


-- Fills the search table with achievement NPCs.
function panel:AchievementUpdate()
	local achievement = private.ACHIEVEMENTS[self.AchievementID]

	for criteria_id, npc_id in pairs(achievement.Criteria) do
		if npc_id > 1 then
			local npc_name, _, is_completed = _G.GetAchievementCriteriaInfoByID(self.AchievementID, criteria_id)
			local map_id = private.RareMobData.NPCMapIDs[npc_id]
			local new_row = panel.table:AddRow(npc_id,
				private.NPCNameFromCache(npc_id) and TEXTURE_NOT_READY or "",
				npc_name,
				npc_id,
				is_completed and TEXTURE_READY or "",
				map_id and (_G.GetMapNameByID(map_id) or map_id) or "")

			if not private.AchievementNPCIsActive(achievement, npc_id) then
				new_row:SetAlpha(ALPHA_INACTIVE)
			end
		end
	end
end


-- Customizes the table when an achievement tab is selected.
function panel:AchievementActivate()

	panel.table:SetHeader(L.SEARCH_CACHED, L.SEARCH_NAME, L.SEARCH_ID, L.SEARCH_COMPLETED, L.SEARCH_MAP)
	panel.table:SetSortHandlers(true, true, true, true, true)
	panel.table:SetSortColumn(2) -- Default by name

	panel.table.Header:SetAlpha(private.OptionsCharacter.Achievements[self.AchievementID] and ALPHA_ACTIVE or ALPHA_INACTIVE)
end


-- Undoes customization to the table when leaving an achievement tab.
function panel:AchievementDeactivate()
	panel.table.Header:SetAlpha(ALPHA_ACTIVE)
end


do
	-- Recreates table data at most once per frame.
	local function OnUpdate(self)
		self:SetScript("OnUpdate", nil)

		for index = 1, #panel.table.Rows do
			panel.table.Rows[index]:SetAlpha(ALPHA_ACTIVE)
		end
		panel.table:Clear()
		panel.selected_tab:Update()
	end

	-- Updates the table for a given tab if it is displayed.
	function panel.UpdateTab(tab_id)
		if not tab_id or panel_tabs[tab_id] == panel.selected_tab then
			panel.table_container:SetScript("OnUpdate", OnUpdate)
		end
	end
end


-- Reverts to default options.
function panel:default()
	private.Synchronize(private.Options) -- Resets only character settings
end


local AddTab
do
	local function Tab_OnEnter(tab)
		local tooltip = _G.GameTooltip
		tooltip:SetOwner(tab, "ANCHOR_TOPLEFT", 0, -8)

		if tab.AchievementID then
			local _, name, _, _, _, _, _, description = _G.GetAchievementInfo(tab.AchievementID)
			local world_id = private.ACHIEVEMENTS[tab.AchievementID].WorldID
			local highlight = _G.HIGHLIGHT_FONT_COLOR

			if world_id then
				local gray = _G.GRAY_FONT_COLOR

				tooltip:ClearLines()
				tooltip:AddDoubleLine(name, L.SEARCH_WORLD_FORMAT:format(GetWorldIDName(world_id)), highlight.r, highlight.g, highlight.b, gray.r, gray.g, gray.b)
			else
				tooltip:SetText(name, highlight.r, highlight.g, highlight.b)
			end
			tooltip:AddLine(description, nil, nil, nil, true)

			if not private.OptionsCharacter.Achievements[tab.AchievementID] then
				local color = _G.RED_FONT_COLOR
				tooltip:AddLine(L.SEARCH_ACHIEVEMENT_DISABLED, color.r, color.g, color.b)
			end
		elseif tab.AchievementID == "BEASTS" then
			tooltip:SetText(L.SEARCH_TAMEBEAST_DECS, nil, nil, nil, nil, true)
		else
			tooltip:SetText(L.SEARCH_NPCS_DESC, nil, nil, nil, nil, true)
		end
		tooltip:Show()
	end


	local function Tab_OnClick(tab)
		_G.PlaySound("igCharacterInfoTab")
		panel:SelectTab(tab)
	end


	local function CheckBox_OnEnter(checkbox)
		Tab_OnEnter(checkbox:GetParent())
	end


	local function CheckBoxAchievement_OnClick(checkbox)
		local is_enabled = checkbox:GetChecked()
		_G.PlaySound(is_enabled and "igMainMenuOptionCheckBoxOn" or "igMainMenuOptionCheckBoxOff")

		local achievement_id = checkbox:GetParent().AchievementID
		panel.AchievementSetEnabled(achievement_id, is_enabled)

		if not is_enabled then
			private.AchievementRemove(achievement_id)
		elseif private.AchievementAdd(achievement_id) then -- Cache might have changed
			private.CacheListPrint(true)
		end
	end


	local function CheckBoxID_OnClick(checkbox)
		local is_enabled = checkbox:GetChecked()
		_G.PlaySound(is_enabled and "igMainMenuOptionCheckBoxOn" or "igMainMenuOptionCheckBoxOff")

		local tab_id = checkbox:GetParent().TabID
		panel.AchievementSetEnabled(tab_id, is_enabled)

		if tab_id == "BEASTS" then
			private.OptionsCharacter.TrackBeasts = is_enabled or nil
		elseif tab_id == "RARENPC" then
			private.OptionsCharacter.TrackRares = is_enabled or nil
		end
		private.RareMobToggle(tab_id, is_enabled)
		panel.UpdateTab(tab_id)
		private.CacheListPrint(true)
	end


	local function CreateTabCheckBox(tab, onclick_script)
		local checkbox = _G.CreateFrame("CheckButton", nil, tab, "UICheckButtonTemplate")
		checkbox:SetSize(20, 20)
		checkbox:SetPoint("BOTTOMLEFT", 8, 0)
		checkbox:SetHitRectInsets(4, 4, 4, 4)
		checkbox:SetScript("OnClick", onclick_script)
		checkbox:SetScript("OnEnter", CheckBox_OnEnter)
		checkbox:SetScript("OnLeave", _G.GameTooltip_Hide)

		tab.Checkbox = checkbox
	end


	local first_tab
	local last_tab
	local num_tabs = 0
	local tab_row = 0


	function AddTab(achievement_id, update_func, activate_func, deactivate_func)
		num_tabs = num_tabs + 1

		local tab = _G.CreateFrame("Button", "_NPCScanSearchTab" .. num_tabs, panel.table_container, "TabButtonTemplate")
		tab:SetHitRectInsets(6, 6, 6, 0)
		tab:SetScript("OnClick", Tab_OnClick)
		tab:SetScript("OnEnter", Tab_OnEnter)
		tab:SetScript("OnLeave", _G.GameTooltip_Hide)
		tab:SetMotionScriptsWhileDisabled(true) -- Allow tooltip while active

		panel_tabs[achievement_id] = tab

		if type(achievement_id) == "number" then
			local _, achievement_name = _G.GetAchievementInfo(achievement_id)
			tab.AchievementID = achievement_id
			tab:SetText(achievement_name)
			tab:GetFontString():SetPoint("RIGHT", -12, 0)

			CreateTabCheckBox(tab, CheckBoxAchievement_OnClick)
		elseif achievement_id == "BEASTS" then
			tab.TabID = achievement_id
			tab:SetText(L.TAMEDBEASTS)
			tab:GetFontString():SetPoint("RIGHT", -12, 0)

			CreateTabCheckBox(tab, CheckBoxID_OnClick)
		elseif achievement_id == "RARENPC" then
			tab.TabID = achievement_id
			tab:SetText("Rare Mobs")
			tab:GetFontString():SetPoint("RIGHT", -12, 0)

			CreateTabCheckBox(tab, CheckBoxID_OnClick)
		end

		if tab.Checkbox then
			panel.AchievementSetEnabled(achievement_id, false)
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
				panel.table_container:SetPoint("TOP", panel.add_found_checkbox, "BOTTOM", 0, -60)
				tab_row = 1
			else
				tab:SetPoint("LEFT", last_tab, "RIGHT", -4, 0)
			end
		else
			tab:SetPoint("BOTTOMLEFT", panel.table_container, "TOPLEFT")
		end

		if num_tabs == 1 then
			first_tab = tab
		end
		last_tab = tab
	end
end -- do-block


AddTab("NPC", panel.NPCUpdate, panel.CustomNPCActivate, panel.NPCDeactivate)
AddTab("RARENPC", panel.RareNPCUpdate, panel.DefultNPCActivate, panel.NPCDeactivate)
AddTab("BEASTS", panel.TameableNPCUpdate, panel.DefultNPCActivate, panel.NPCDeactivate)


for achievement_id in pairs(private.ACHIEVEMENTS) do
	AddTab(achievement_id, panel.AchievementUpdate, panel.AchievementActivate, panel.AchievementDeactivate)
end


_G.InterfaceOptions_AddCategory(panel)


function panel:UpdateTabNames()
	for achievement_id in pairs(private.ACHIEVEMENTS) do
		local _, achievement_name = _G.GetAchievementInfo(achievement_id)

		panel_tabs[achievement_id]:SetText(achievement_name)
		panel_tabs[achievement_id]:GetFontString():SetPoint("RIGHT", -12, 0)
		_G.PanelTemplates_TabResize(panel_tabs[achievement_id], 20 - 12)
	end
end

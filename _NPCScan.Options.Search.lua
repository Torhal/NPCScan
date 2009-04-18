--[[****************************************************************************
  * _NPCScan by Saiket                                                         *
  * _NPCScan.Options.Search.lua - Adds a configuration pane to add/remove NPCs *
  *   and achievements to search for.                                          *
  ****************************************************************************]]


local _NPCScan = _NPCScan;
local L = _NPCScanLocalization;
local me = CreateFrame( "Frame" );
_NPCScan.Options.Search = me;

me.TableContainer = CreateFrame( "Frame", nil, me );

me.Tabs = {};
me.TabSelected = nil;
me.UpdateRequested = nil;

me.AchievementDisabledAlpha = 0.5;

local SortedNames = {}; -- Used to sort text tables




--[[****************************************************************************
  * Function: _NPCScan.Options.Search.TabSelect                                *
  * Description: Selects the given tab.                                        *
  ****************************************************************************]]
function me.TabSelect ( NewTab )
	local OldTab = me.TabSelected;
	if ( NewTab ~= OldTab ) then
		if ( OldTab ) then
			if ( OldTab.Deactivate ) then
				OldTab:Deactivate();
			end
			PanelTemplates_DeselectTab( OldTab );
		end

		me.TabSelected = NewTab;
		PanelTemplates_SelectTab( NewTab );
		if ( NewTab.Activate ) then
			NewTab:Activate();
		end
		NewTab:Update();
	end
end
--[[****************************************************************************
  * Function: _NPCScan.Options.Search:TabOnClick                               *
  ****************************************************************************]]
function me:TabOnClick ()
	PlaySound( "igCharacterInfoTab" );
	me.TabSelect( self );
end
--[[****************************************************************************
  * Function: _NPCScan.Options.Search:TabCheckOnClick                          *
  ****************************************************************************]]
function me:TabCheckOnClick ()
	local Enable = not not self:GetChecked();
	PlaySound( Enable and "igMainMenuOptionCheckBoxOn" or "igMainMenuOptionCheckBoxOff" );
	me.AchievementSetEnabled( self:GetParent().AchievementID, Enable );
end
--[[****************************************************************************
  * Function: _NPCScan.Options.Search:TabCheckOnEnter                          *
  ****************************************************************************]]
function me:TabCheckOnEnter ()
	local _, Name, _, _, _, _, _, Description = GetAchievementInfo( self:GetParent().AchievementID );
	GameTooltip:SetOwner( self, "ANCHOR_TOPLEFT" );
	GameTooltip:SetText( Name );
	local Color = HIGHLIGHT_FONT_COLOR;
	GameTooltip:AddLine( Description, Color.r, Color.g, Color.b, true );
	GameTooltip:Show();
end




--[[****************************************************************************
  * Function: _NPCScan.Options.Search:NPCOnSelect                              *
  * Description: Updates the edit boxes when a table row is selected.          *
  ****************************************************************************]]
function me:NPCOnSelect ( Name )
	if ( Name ~= nil ) then
		me.SetEditBoxText( Name, _NPCScan.NPCs[ Name ] );
	end
end
--[[****************************************************************************
  * Function: _NPCScan.Options.Search:NPCUpdate                                *
  ****************************************************************************]]
function me:NPCUpdate ()
	me.SetEditBoxText();

	for Name in pairs( _NPCScan.NPCs ) do
		SortedNames[ #SortedNames + 1 ] = Name;
	end
	sort( SortedNames );

	me.Table:Clear();
	for _, Name in ipairs( SortedNames ) do
		me.Table:AddRow( Name,
			L[ _NPCScan.TestID( _NPCScan.NPCs[ Name ] ) and "SEARCH_CACHED_YES" or "SEARCH_CACHED_NO" ],
			Name, _NPCScan.NPCs[ Name ] );
	end
	wipe( SortedNames );
end
--[[****************************************************************************
  * Function: _NPCScan.Options.Search:NPCActivate                              *
  ****************************************************************************]]
function me:NPCActivate ()
	me.Table:SetHeader( L.SEARCH_CACHED, L.SEARCH_NAME, L.SEARCH_ID );
	me.NPCControls:Show();
	me.TableContainer:SetPoint( "BOTTOM", me.NPCControls, "TOP", 0, 4 );
	me.Table.OnSelect = me.NPCOnSelect;
end
--[[****************************************************************************
  * Function: _NPCScan.Options.Search:NPCDeactivate                            *
  ****************************************************************************]]
function me:NPCDeactivate ()
	me.NPCControls:Hide();
	me.TableContainer:SetPoint( "BOTTOM", me.NPCControls );
	me.Table.OnSelect = nil;
end


--[[****************************************************************************
  * Function: _NPCScan.Options.Search.AchievementSetEnabled                    *
  * Description: Enables/disables the achievement related to a tab.            *
  ****************************************************************************]]
function me.AchievementSetEnabled ( AchievementID, Enable )
	local Tab = me.Tabs[ AchievementID ];
	Tab.Checkbox:SetChecked( Enable );

	_NPCScan[ Enable and "AchievementAdd" or "AchievementRemove" ]( AchievementID );
	if ( me.TabSelected == Tab ) then
		me.Table:SetAlpha( Enable and 1.0 or me.AchievementDisabledAlpha );
	end
end
--[[****************************************************************************
  * Function: _NPCScan.Options.Search:AchievementUpdate                        *
  ****************************************************************************]]
do
	local CriteriaNames = {};
	local CriteriaCompleted = {};
	local function SortFunc ( Criteria1, Criteria2 )
		return CriteriaNames[ Criteria1 ] < CriteriaNames[ Criteria2 ];
	end
	function me:AchievementUpdate ()
		local Criteria = _NPCScan.Achievements[ self.AchievementID ].Criteria;
		for CriteriaID in pairs( Criteria ) do
			CriteriaNames[ CriteriaID ], _, CriteriaCompleted[ CriteriaID ] = GetAchievementCriteriaInfo( CriteriaID );
			SortedNames[ #SortedNames + 1 ] = CriteriaID;
		end
		sort( SortedNames, SortFunc );

		me.Table:Clear();
		for _, CriteriaID in ipairs( SortedNames ) do
			me.Table:AddRow( nil, L[ _NPCScan.TestID( Criteria[ CriteriaID ] ) and "SEARCH_CACHED_YES" or "SEARCH_CACHED_NO" ],
				CriteriaNames[ CriteriaID ], Criteria[ CriteriaID ],
				L[ CriteriaCompleted[ CriteriaID ] and "SEARCH_COMPLETED_YES" or "SEARCH_COMPLETED_NO" ] );
		end
		wipe( CriteriaNames );
		wipe( CriteriaCompleted );
		wipe( SortedNames );
	end
end
--[[****************************************************************************
  * Function: _NPCScan.Options.Search:AchievementActivate                      *
  ****************************************************************************]]
function me:AchievementActivate ()
	me.Table:SetHeader( L.SEARCH_CACHED, L.SEARCH_NAME, L.SEARCH_ID, L.SEARCH_COMPLETED );
	me.Table:SetAlpha( _NPCScan.Achievements[ self.AchievementID ].Enabled and 1.0 or me.AchievementDisabledAlpha );
end
--[[****************************************************************************
  * Function: _NPCScan.Options.Search:AchievementDeactivate                    *
  ****************************************************************************]]
function me:AchievementDeactivate ()
	me.Table:SetAlpha( 1.0 );
end




--[[****************************************************************************
  * Function: _NPCScan.Options.Search.SetEditBoxText                           *
  * Description: Sets the edit boxes' text.                                    *
  ****************************************************************************]]
function me.SetEditBoxText ( Name, ID )
	me.EditBoxName:SetText( Name or "" );
	me.EditBoxID:SetText( ID or "" );
end
--[[****************************************************************************
  * Function: _NPCScan.Options.Search:EditBoxNameGetText                       *
  * Description: Returns the name field without leading or trailing spaces.    *
  ****************************************************************************]]
function me:EditBoxNameGetText ( ... )
	return self:GetTextBackup( ... ):trim();
end
--[[****************************************************************************
  * Function: _NPCScan.Options.Search.ValidateButtons                          *
  * Description: Validates ability to use add and remove buttons.              *
  ****************************************************************************]]
function me.ValidateButtons ()
	local Name = me.EditBoxName:GetText():lower();
	local ID = me.EditBoxID:GetText() ~= "" and me.EditBoxID:GetNumber() or nil;
	Name = Name ~= "" and Name or nil;

	local CanRemove = _NPCScan.NPCs[ Name ];
	local CanAdd = Name and ID and ID ~= CanRemove and ID >= 1 and ID <= _NPCScan.IDMax;

	if ( me.Table ) then
		me.Table:SetSelectionByKey( CanRemove and Name or nil );
	end
	me.AddButton[ CanAdd and "Enable" or "Disable" ]( me.AddButton );
	me.RemoveButton[ CanRemove and "Enable" or "Disable" ]( me.RemoveButton );
end
--[[****************************************************************************
  * Function: _NPCScan.Options.Search.Add                                      *
  * Description: Adds a Custom NPC list element.                               *
  ****************************************************************************]]
function me.Add ()
	local Name = me.EditBoxName:GetText();
	_NPCScan.NPCRemove( Name );
	local Success, FoundName = _NPCScan.NPCAdd( Name, me.EditBoxID:GetNumber() );
	if ( Success and FoundName ) then
		_NPCScan.Message( L.ALREADY_CACHED_FORMAT:format( L.NAME_FORMAT:format( FoundName ) ), RED_FONT_COLOR );
	end
end
--[[****************************************************************************
  * Function: _NPCScan.Options.Search.Remove                                   *
  * Description: Removes a Custom NPC list element.                            *
  ****************************************************************************]]
function me.Remove ()
	_NPCScan.NPCRemove( me.EditBoxName:GetText() );
end


--[[****************************************************************************
  * Function: _NPCScan.Options.Search.UpdateTab                                *
  * Description: Updates the table for a given tab if it is displayed.         *
  ****************************************************************************]]
function me.UpdateTab ( ID )
	if ( not ID or me.Tabs[ ID ] == me.TabSelected ) then
		me.UpdateRequested = true; -- Update executed in next OnUpdate
	end;
end
--[[****************************************************************************
  * Function: _NPCScan.Options.Search:OnUpdate                                 *
  ****************************************************************************]]
function me:OnUpdate ()
	if ( me.UpdateRequested ) then
		me.UpdateRequested = nil;

		me.TabSelected:Update();
	end
end
--[[****************************************************************************
  * Function: _NPCScan.Options.Search:OnShow                                   *
  ****************************************************************************]]
function me:OnShow ()
	if ( not me.Table ) then
		me.Table = LibStub( "LibTextTable-1.0" ).New( nil, me.TableContainer );
		me.Table:SetAllPoints();
	end

	if ( me.TabSelected ) then
		me.UpdateTab();
	else
		me.TabSelect( me.Tabs[ "NPC" ] );
	end
end
--[[****************************************************************************
  * Function: _NPCScan.Options.Search:default                                  *
  ****************************************************************************]]
function me:default ()
	_NPCScan.LoadDefaults(); -- Only per-character

	_NPCScan.Synchronize();
end




--------------------------------------------------------------------------------
-- Function Hooks / Execution
-----------------------------

do
	me.name = L.SEARCH_TITLE;
	me.parent = L.OPTIONS_TITLE;
	me:Hide();
	me:SetScript( "OnShow", me.OnShow );
	me:SetScript( "OnUpdate", me.OnUpdate );

	-- Pane title
	me.Title = me:CreateFontString( nil, "ARTWORK", "GameFontNormalLarge" );
	me.Title:SetPoint( "TOPLEFT", 16, -16 );
	me.Title:SetText( L.SEARCH_TITLE );
	local SubText = me:CreateFontString( nil, "ARTWORK", "GameFontHighlightSmall" );
	me.SubText = SubText;
	SubText:SetPoint( "TOPLEFT", me.Title, "BOTTOMLEFT", 0, -8 );
	SubText:SetPoint( "RIGHT", -32, 0 );
	SubText:SetHeight( 32 );
	SubText:SetJustifyH( "LEFT" );
	SubText:SetJustifyV( "TOP" );
	SubText:SetText( L.SEARCH_DESC );


	-- Controls for NPCs table
	local NPCControls = CreateFrame( "Frame", nil, me );
	me.NPCControls = NPCControls;
	NPCControls:Hide();

	-- Create add and remove buttons
	local RemoveButton = CreateFrame( "Button", nil, NPCControls, "GameMenuButtonTemplate" );
	me.RemoveButton = RemoveButton;
	RemoveButton:SetWidth( 16 );
	RemoveButton:SetHeight( 20 );
	RemoveButton:SetPoint( "BOTTOMRIGHT", me, "BOTTOMRIGHT", -16, 16 );
	RemoveButton:SetText( L.SEARCH_REMOVE );
	RemoveButton:SetScript( "OnClick", me.Remove );
	local AddButton = CreateFrame( "Button", nil, NPCControls, "GameMenuButtonTemplate" );
	me.AddButton = AddButton;
	AddButton:SetWidth( 16 );
	AddButton:SetHeight( 20 );
	AddButton:SetPoint( "BOTTOMRIGHT", RemoveButton, "TOPRIGHT", 0, 4 );
	AddButton:SetText( L.SEARCH_ADD );
	AddButton:SetScript( "OnClick", me.Add );


	-- Create edit boxes
	local LabelID = NPCControls:CreateFontString( nil, "ARTWORK", "GameFontHighlight" );
	me.LabelID = LabelID;
	LabelID:SetPoint( "BOTTOMLEFT", me, "BOTTOMLEFT", 16, 16 );
	LabelID:SetPoint( "TOP", RemoveButton );
	LabelID:SetText( L.SEARCH_ID );
	local LabelName = NPCControls:CreateFontString( nil, "ARTWORK", "GameFontHighlight" );
	me.LabelName = LabelName;
	LabelName:SetPoint( "BOTTOMLEFT", LabelID, "TOPLEFT", 0, 4 );
	LabelName:SetPoint( "TOP", AddButton );
	LabelName:SetText( L.SEARCH_NAME );

	local EditBoxName = CreateFrame( "EditBox", "_NPCScanOptionsName", NPCControls, "InputBoxTemplate" );
	me.EditBoxName = EditBoxName;
	local EditBoxID = CreateFrame( "EditBox", "_NPCScanOptionsID", NPCControls, "InputBoxTemplate" );
	me.EditBoxID = EditBoxID;

	EditBoxID:SetPoint( "TOP", LabelID );
	EditBoxID:SetPoint( "BOTTOMRIGHT", RemoveButton, "BOTTOMLEFT", -4, 0 );
	EditBoxID:SetAutoFocus( false );
	EditBoxID:SetNumeric( true );
	EditBoxID:SetMaxLetters( floor( log10( _NPCScan.IDMax ) ) + 1 );
	EditBoxID:SetScript( "OnTabPressed", function () EditBoxName:SetFocus(); end );
	EditBoxID:SetScript( "OnEnterPressed", me.Add );
	EditBoxID:SetScript( "OnTextChanged", me.ValidateButtons );
	EditBoxID:SetScript( "OnEnter", _NPCScan.Options.ControlOnEnter );
	EditBoxID:SetScript( "OnLeave", _NPCScan.Options.ControlOnLeave );
	EditBoxID.tooltipText = L.SEARCH_ID_DESC;

	EditBoxName:SetPoint( "TOP", LabelName );
	EditBoxName:SetPoint( "LEFT", EditBoxID );
	EditBoxName:SetPoint( "BOTTOMRIGHT", EditBoxID, "TOPRIGHT" );
	EditBoxName:SetAutoFocus( false );
	EditBoxName:SetScript( "OnTabPressed", function () EditBoxID:SetFocus(); end );
	EditBoxName:SetScript( "OnEnterPressed", me.Add );
	EditBoxName:SetScript( "OnTextChanged", me.ValidateButtons );
	EditBoxName:SetScript( "OnEnter", _NPCScan.Options.ControlOnEnter );
	EditBoxName:SetScript( "OnLeave", _NPCScan.Options.ControlOnLeave );
	EditBoxName.GetTextBackup = EditBoxName.GetText;
	EditBoxName.GetText = me.EditBoxNameGetText;
	EditBoxName.tooltipText = L.SEARCH_NAME_DESC;

	EditBoxID:SetPoint( "LEFT",
		LabelName:GetStringWidth() > LabelID:GetStringWidth() and LabelName or LabelID,
		"RIGHT", 8, 0 );

	NPCControls:SetPoint( "BOTTOMRIGHT", RemoveButton );
	NPCControls:SetPoint( "LEFT", LabelID );
	NPCControls:SetPoint( "TOP", AddButton );

	me.TableContainer:SetPoint( "TOPLEFT", SubText, "BOTTOMLEFT", -2, -32 );
	me.TableContainer:SetPoint( "RIGHT", -16, 0 );
	me.TableContainer:SetPoint( "BOTTOM", NPCControls );
	me.TableContainer:SetBackdrop( { bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background"; } );

	-- Add all tabs
	local LastTab;
	local TabCount = 0;
	local function AddTab ( ID, Update, Activate, Deactivate )
		TabCount = TabCount + 1;
		local Tab = CreateFrame( "Button", "_NPCScanSearchTab"..TabCount, me.TableContainer, "TabButtonTemplate" );
		me.Tabs[ ID ] = Tab;

		Tab:SetHitRectInsets( 6, 6, 6, 0 );
		Tab:SetScript( "OnClick", me.TabOnClick );

		if ( type( ID ) == "number" ) then -- AchievementID
			Tab:SetText( select( 2, GetAchievementInfo( ID ) ) );
			Tab.AchievementID = ID;
			local Checkbox = CreateFrame( "CheckButton", nil, Tab, "UICheckButtonTemplate" );
			Tab.Checkbox = Checkbox;
			Checkbox:SetWidth( 14 );
			Checkbox:SetHeight( 14 );
			Checkbox:SetPoint( "RIGHT", _G[ Tab:GetName().."Text" ], "LEFT", 2, -2 );
			Checkbox:SetHitRectInsets( 4, 4, 4, 4 );
			Checkbox:SetScript( "OnClick", me.TabCheckOnClick );
			Checkbox:SetScript( "OnEnter", me.TabCheckOnEnter );
			Checkbox:SetScript( "OnLeave", _NPCScan.Options.ControlOnLeave );
		else
			Tab:SetText( L.SEARCH_NPCS );
		end
		PanelTemplates_TabResize( Tab, 0 );

		Tab.Update = Update;
		Tab.Activate = Activate;
		Tab.Deactivate = Deactivate;

		PanelTemplates_DeselectTab( Tab );
		if ( LastTab ) then
			Tab:SetPoint( "LEFT", LastTab, "RIGHT", -4, 0 );
		else
			Tab:SetPoint( "BOTTOMLEFT", me.TableContainer, "TOPLEFT" );
		end
		LastTab = Tab;
	end
	AddTab( "NPC", me.NPCUpdate, me.NPCActivate, me.NPCDeactivate );
	for AchievementID in pairs( _NPCScan.Achievements ) do
		AddTab( AchievementID, me.AchievementUpdate, me.AchievementActivate, me.AchievementDeactivate );
	end


	InterfaceOptions_AddCategory( me );
end

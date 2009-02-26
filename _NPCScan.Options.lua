--[[****************************************************************************
  * _NPCScan by Saiket                                                         *
  * _NPCScan.Options.lua - Adds an options pane to the Interface Options menu. *
  ****************************************************************************]]


local _NPCScan = _NPCScan;
local L = _NPCScanLocalization;
local me = CreateFrame( "Frame" );
_NPCScan.Options = me;

me.TableContainer = CreateFrame( "Frame", nil, me );




--[[****************************************************************************
  * Function: _NPCScan.Options.Test                                            *
  * Description: Plays a fake found alert and shows the target button.         *
  ****************************************************************************]]
function me.Test ()
	local Name = L.OPTIONS_TEST_NAME;
	_NPCScan.Alert( L.FOUND_FORMAT:format( Name ), GREEN_FONT_COLOR );
	_NPCScan.Message( L.OPTIONS_TEST_HELP_FORMAT:format( GetModifiedClick( "_NPCSCAN_BUTTONDRAG" ) ) );

	_NPCScan.Button.SetNPC( UnitName( "player" ), 0 );
	_NPCScan.Button:SetText( Name );
	local Model = _NPCScan.Button.Model;
	Model:SetUnit( "player" );
	Model:SetScale( 0.75 );
end


--[[****************************************************************************
  * Function: _NPCScan.Options.SetEditBoxText                                  *
  * Description: Sets the edit boxes' text.                                    *
  ****************************************************************************]]
function me.SetEditBoxText ( Name, ID )
	me.EditBoxName:SetText( Name or "" );
	me.EditBoxID:SetText( ID or "" );
end
--[[****************************************************************************
  * Function: _NPCScan.Options.ValidateButtons                                 *
  * Description: Validates ability to use add and remove buttons.              *
  ****************************************************************************]]
function me.ValidateButtons ()
	local Name = me.EditBoxName:GetText():lower();
	local ID = #me.EditBoxID:GetText() > 0 and me.EditBoxID:GetNumber() or nil;
	Name = #Name > 0 and Name or nil;

	local CanRemove = _NPCScanOptions.IDs[ Name ];
	local CanAdd = Name and ID and ID ~= CanRemove and ID >= 1 and ID <= _NPCScan.IDMax;

	if ( me.Table ) then
		me.Table:SetSelectionByKey( CanRemove and Name or nil );
	end
	me.AddButton[ CanAdd and "Enable" or "Disable" ]( me.AddButton );
	me.RemoveButton[ CanRemove and "Enable" or "Disable" ]( me.RemoveButton );
end
--[[****************************************************************************
  * Function: _NPCScan.Options.Add                                             *
  * Description: Adds a list element.                                          *
  ****************************************************************************]]
function me.Add ()
	local Name = me.EditBoxName:GetText():lower();
	if ( not _NPCScanOptions.IDs[ Name ] or _NPCScan.Remove( Name ) ) then
		if ( _NPCScan.Add( Name, me.EditBoxID:GetNumber() ) ) then
			me.SetEditBoxText();
			me.Update();
		end
	end
end
--[[****************************************************************************
  * Function: _NPCScan.Options.Remove                                          *
  * Description: Removes a list element.                                       *
  ****************************************************************************]]
function me.Remove ()
	if ( _NPCScan.Remove( me.EditBoxName:GetText():lower() ) ) then
		me.SetEditBoxText();
		me.Update();
	end
end


--[[****************************************************************************
  * Function: _NPCScan.Options:ControlOnEnter                                  *
  ****************************************************************************]]
function me:ControlOnEnter ()
	GameTooltip:SetOwner( self, "ANCHOR_TOPRIGHT" );
	GameTooltip:SetText( self.tooltipText, nil, nil, nil, nil, 1 );
end
--[[****************************************************************************
  * Function: _NPCScan.Options:ControlOnLeave                                  *
  ****************************************************************************]]
function me:ControlOnLeave ()
	GameTooltip:Hide();
end

--[[****************************************************************************
  * Function: _NPCScan.Options.Update                                          *
  * Description: Fills in the NPC table.                                       *
  ****************************************************************************]]
do
	local SortedNames = {};
	function me.Update ()
		me.SetEditBoxText();

		me.Table:Clear();
		local IDs = _NPCScanOptions.IDs;
		for Name in pairs( IDs ) do
			SortedNames[ #SortedNames + 1 ] = Name;
		end
		sort( SortedNames );

		for _, Name in ipairs( SortedNames ) do
			me.Table:AddRow( Name,
				L[ _NPCScan.TestID( IDs[ Name ] ) and "OPTIONS_CACHED_YES" or "OPTIONS_CACHED_NO" ],
				Name, IDs[ Name ] );
		end
		wipe( SortedNames );
	end
end
--[[****************************************************************************
  * Function: _NPCScan.Options:TableOnSelect                                   *
  * Description: Updates the edit boxes when a table row is selected.          *
  ****************************************************************************]]
function me:TableOnSelect ( Key )
	if ( Key ~= nil ) then
		me.SetEditBoxText( Key, _NPCScanOptions.IDs[ Key ] );
	end
end
--[[****************************************************************************
  * Function: _NPCScan.Options:OnShow                                          *
  * Description: Creates the NPC table when displayed.                         *
  ****************************************************************************]]
function me:OnShow ()
	if ( not me.Table ) then
		me.Table = LibStub( "LibTextTable-1.0" ).New( nil, me.TableContainer );
		me.Table.OnSelect = me.TableOnSelect;
		me.Table:SetAllPoints();
		me.Table:SetHeader( L.OPTIONS_CACHED, L.OPTIONS_NAME, L.OPTIONS_ID );
	end
	me.Update();
end


--[[****************************************************************************
  * Function: _NPCScan.Options.SlashCommand                                    *
  * Description: Slash command chat handler to open the options pane.          *
  ****************************************************************************]]
function me.SlashCommand ()
	InterfaceOptionsFrame_OpenToCategory( me );
end




--------------------------------------------------------------------------------
-- Function Hooks / Execution
-----------------------------

do
	me.name = L.OPTIONS_TITLE;
	me:SetScript( "OnShow", me.OnShow );

	-- Pane title
	me.Title = me:CreateFontString( nil, "ARTWORK", "GameFontNormalLarge" );
	me.Title:SetPoint( "TOPLEFT", 16, -16 );
	me.Title:SetText( L.OPTIONS_TITLE );
	local SubText = me:CreateFontString( nil, "ARTWORK", "GameFontHighlightSmall" );
	me.SubText = SubText;
	SubText:SetPoint( "TOPLEFT", me.Title, "BOTTOMLEFT", 0, -8 );
	SubText:SetPoint( "RIGHT", -32, 0 );
	SubText:SetHeight( 32 );
	SubText:SetJustifyH( "LEFT" );
	SubText:SetJustifyV( "TOP" );
	SubText:SetText( L.OPTIONS_DESC );


	-- Add test button
	local TestButton = CreateFrame( "Button", "_NPCScanTest", me, "GameMenuButtonTemplate" );
	me.TestButton = TestButton;
	TestButton:SetPoint( "TOPLEFT", SubText, "BOTTOMLEFT", -2, -12 );
	TestButton:SetText( L.OPTIONS_TEST );
	TestButton:SetScript( "OnClick", me.Test );
	TestButton:SetScript( "OnEnter", me.ControlOnEnter );
	TestButton:SetScript( "OnLeave", me.ControlOnLeave );
	TestButton.tooltipText = L.OPTIONS_TEST_DESC;


	-- Create add and remove buttons
	local RemoveButton = CreateFrame( "Button", nil, me, "GameMenuButtonTemplate" );
	me.RemoveButton = RemoveButton;
	RemoveButton:SetWidth( 16 );
	RemoveButton:SetHeight( 20 );
	RemoveButton:SetPoint( "BOTTOMRIGHT", -16, 16 );
	RemoveButton:SetText( L.OPTIONS_REMOVE );
	RemoveButton:SetScript( "OnClick", me.Remove );
	local AddButton = CreateFrame( "Button", nil, me, "GameMenuButtonTemplate" );
	me.AddButton = AddButton;
	AddButton:SetWidth( 16 );
	AddButton:SetHeight( 20 );
	AddButton:SetPoint( "BOTTOMRIGHT", RemoveButton, "TOPRIGHT", 0, 4 );
	AddButton:SetText( L.OPTIONS_ADD );
	AddButton:SetScript( "OnClick", me.Add );


	-- Create edit boxes
	local LabelID = me:CreateFontString( nil, "ARTWORK", "GameFontHighlight" );
	me.LabelID = LabelID;
	LabelID:SetPoint( "BOTTOMLEFT", 16, 16 );
	LabelID:SetPoint( "TOP", RemoveButton );
	LabelID:SetText( L.OPTIONS_ID );
	local LabelName = me:CreateFontString( nil, "ARTWORK", "GameFontHighlight" );
	me.LabelName = LabelName;
	LabelName:SetPoint( "BOTTOMLEFT", LabelID, "TOPLEFT", 0, 4 );
	LabelName:SetPoint( "TOP", AddButton );
	LabelName:SetText( L.OPTIONS_NAME );

	local EditBoxName = CreateFrame( "EditBox", "_NPCScanOptionsName", me, "InputBoxTemplate" );
	me.EditBoxName = EditBoxName;
	local EditBoxID = CreateFrame( "EditBox", "_NPCScanOptionsID", me, "InputBoxTemplate" );
	me.EditBoxID = EditBoxID;

	EditBoxID:SetPoint( "TOP", LabelID );
	EditBoxID:SetPoint( "BOTTOMRIGHT", RemoveButton, "BOTTOMLEFT", -4, 0 );
	EditBoxID:SetAutoFocus( false );
	EditBoxID:SetNumeric( true );
	EditBoxID:SetMaxLetters( floor( log10( _NPCScan.IDMax ) ) + 1 );
	EditBoxID:SetScript( "OnTabPressed", function () EditBoxName:SetFocus(); end );
	EditBoxID:SetScript( "OnEnterPressed", me.Add );
	EditBoxID:SetScript( "OnTextChanged", me.ValidateButtons );
	EditBoxID:SetScript( "OnEnter", me.ControlOnEnter );
	EditBoxID:SetScript( "OnLeave", me.ControlOnLeave );
	EditBoxID.tooltipText = L.OPTIONS_ID_DESC;

	EditBoxName:SetPoint( "TOP", LabelName );
	EditBoxName:SetPoint( "LEFT", EditBoxID );
	EditBoxName:SetPoint( "BOTTOMRIGHT", EditBoxID, "TOPRIGHT" );
	EditBoxName:SetAutoFocus( false );
	EditBoxName:SetScript( "OnTabPressed", function () EditBoxID:SetFocus(); end );
	EditBoxName:SetScript( "OnEnterPressed", me.Add );
	EditBoxName:SetScript( "OnTextChanged", me.ValidateButtons );
	EditBoxName:SetScript( "OnEnter", me.ControlOnEnter );
	EditBoxName:SetScript( "OnLeave", me.ControlOnLeave );
	EditBoxName.tooltipText = L.OPTIONS_NAME_DESC;

	EditBoxID:SetPoint( "LEFT",
		LabelName:GetStringWidth() > LabelID:GetStringWidth() and LabelName or LabelID,
		"RIGHT", 8, 0 );

	me.TableContainer:SetPoint( "TOPLEFT", TestButton, "BOTTOMLEFT", 0, -8 );
	me.TableContainer:SetPoint( "RIGHT", -16, 0 );
	me.TableContainer:SetPoint( "BOTTOM", AddButton, "TOP", 0, 4 );
	me.TableContainer:SetBackdrop( { bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background"; } );


	InterfaceOptions_AddCategory( me );
	SlashCmdList[ "_NPCSCAN" ] = me.SlashCommand;
end

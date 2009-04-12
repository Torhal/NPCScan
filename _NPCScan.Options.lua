--[[****************************************************************************
  * _NPCScan by Saiket                                                         *
  * _NPCScan.Options.lua - Adds an options pane to the Interface Options menu. *
  ****************************************************************************]]


local _NPCScan = _NPCScan;
local L = _NPCScanLocalization;
local me = CreateFrame( "Frame" );
_NPCScan.Options = me;




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
	Model:SetModelScale( 0.75 );
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
  * Function: _NPCScan.Options:default                                         *
  ****************************************************************************]]
function me:default ()
	_NPCScan.LoadDefaults( true );

	_NPCScan.ScanSynchronize();
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
	me:Hide();

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


	InterfaceOptions_AddCategory( me );
	SlashCmdList[ "_NPCSCAN" ] = me.SlashCommand;
end

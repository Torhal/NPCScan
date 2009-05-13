--[[****************************************************************************
  * _NPCScan by Saiket                                                         *
  * _NPCScan.Config.lua - Adds an options pane to the Interface Options menu.  *
  ****************************************************************************]]


local _NPCScan = _NPCScan;
local L = _NPCScanLocalization;
local me = CreateFrame( "Frame" );
_NPCScan.Config = me;




--[[****************************************************************************
  * Function: _NPCScan.Config.Test                                             *
  * Description: Plays a fake found alert and shows the target button.         *
  ****************************************************************************]]
function me.Test ()
	local Name = L.CONFIG_TEST_NAME;
	_NPCScan.Alert( L.FOUND_FORMAT:format( Name ), GREEN_FONT_COLOR );
	_NPCScan.Message( L.CONFIG_TEST_HELP_FORMAT:format( GetModifiedClick( "_NPCSCAN_BUTTONDRAG" ) ) );

	_NPCScan.Button.SetNPC( Name, "player" );
end


--[[****************************************************************************
  * Function: _NPCScan.Config:ControlOnEnter                                   *
  ****************************************************************************]]
function me:ControlOnEnter ()
	GameTooltip:SetOwner( self, "ANCHOR_TOPRIGHT" );
	GameTooltip:SetText( self.tooltipText, nil, nil, nil, nil, 1 );
end
--[[****************************************************************************
  * Function: _NPCScan.Config:ControlOnLeave                                   *
  ****************************************************************************]]
function me:ControlOnLeave ()
	GameTooltip:Hide();
end


--[[****************************************************************************
  * Function: _NPCScan.Config.CacheWarningsOnClick                             *
  ****************************************************************************]]
function me.CacheWarningsOnClick ( Enable )
	_NPCScan.SetCacheWarnings( Enable == "1" );
end


--[[****************************************************************************
  * Function: _NPCScan.Config:default                                          *
  ****************************************************************************]]
function me:default ()
	_NPCScan.Synchronize(); -- Resets all
end




--------------------------------------------------------------------------------
-- Function Hooks / Execution
-----------------------------

do
	me.name = L.CONFIG_TITLE;
	me:Hide();

	-- Pane title
	me.Title = me:CreateFontString( nil, "ARTWORK", "GameFontNormalLarge" );
	me.Title:SetPoint( "TOPLEFT", 16, -16 );
	me.Title:SetText( L.CONFIG_TITLE );
	local SubText = me:CreateFontString( nil, "ARTWORK", "GameFontHighlightSmall" );
	me.SubText = SubText;
	SubText:SetPoint( "TOPLEFT", me.Title, "BOTTOMLEFT", 0, -8 );
	SubText:SetPoint( "RIGHT", -32, 0 );
	SubText:SetHeight( 32 );
	SubText:SetJustifyH( "LEFT" );
	SubText:SetJustifyV( "TOP" );
	SubText:SetText( L.CONFIG_DESC );


	-- Add test button
	local TestButton = CreateFrame( "Button", "_NPCScanTest", me, "GameMenuButtonTemplate" );
	me.TestButton = TestButton;
	TestButton:SetPoint( "TOPLEFT", SubText, "BOTTOMLEFT", -2, -12 );
	TestButton:SetText( L.CONFIG_TEST );
	TestButton:SetScript( "OnClick", me.Test );
	TestButton:SetScript( "OnEnter", me.ControlOnEnter );
	TestButton:SetScript( "OnLeave", me.ControlOnLeave );
	TestButton.tooltipText = L.CONFIG_TEST_DESC;


	-- Miscellaneous checkboxes
	local CacheWarningsCheckbox = CreateFrame( "CheckButton", "_NPCScanConfigCacheWarningsCheckbox", me, "InterfaceOptionsCheckButtonTemplate" );
	me.CacheWarningsCheckbox = CacheWarningsCheckbox;
	CacheWarningsCheckbox:SetPoint( "TOPLEFT", TestButton, "BOTTOMLEFT", 0, -16 );
	CacheWarningsCheckbox.setFunc = me.CacheWarningsOnClick;
	CacheWarningsCheckbox.tooltipText = L.CONFIG_CACHEWARNINGS_DESC;
	_G[ CacheWarningsCheckbox:GetName().."Text" ]:SetText( L.CONFIG_CACHEWARNINGS );


	InterfaceOptions_AddCategory( me );
end

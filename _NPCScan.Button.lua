--[[****************************************************************************
  * _NPCScan by Saiket                                                         *
  * _NPCScan.Button.lua - Displays a button to target found NPCs.              *
  ****************************************************************************]]


local _NPCScan = _NPCScan;
local L = _NPCScanLocalization;
local me = CreateFrame( "Button", "_NPCScanButton", _NPCScan, "SecureActionButtonTemplate" );
_NPCScan.Button = me;

me.PendingName = nil;
me.PendingID = nil;

me.RotationRate = math.pi / 4;




--[[****************************************************************************
  * Function: _NPCScan.Button.SetNPC                                           *
  * Description: Sets the button to a given NPC and shows it.                  *
  ****************************************************************************]]
function me.SetNPC ( Name, ID )
	if ( InCombatLockdown() ) then
		me.PendingName = Name;
		me.PendingID = ID;
	else
		me.Update( Name, ID );
	end
end
--[[****************************************************************************
  * Function: _NPCScan.Button.Update                                           *
  * Description: Updates the button based on its Name and ID fields.           *
  ****************************************************************************]]
function me.Update ( Name, ID )
	me:SetAttribute( "macrotext", "/cleartarget\n/targetexact "..Name );
	me:Enable();
	me:Show();

	me:SetText( Name );
	UIFrameFadeRemoveFrame( me.Glow );
	UIFrameFlashRemoveFrame( me.Glow );
	if ( UIParent:IsVisible() ) then -- Only flash when animating frame is shown
		UIFrameFlash( me.Glow, 0.1, 0.7, 0.8 );
	end

	me.Model:SetCreature( ID );
	me.Model:SetPosition( 1, 0, -0.5 );
	me.Model:SetFacing( 0 );
end


--[[****************************************************************************
  * Function: _NPCScan.Button.EnableDrag                                       *
  * Description: Enables or disables dragging the button.                      *
  ****************************************************************************]]
function me.EnableDrag ( Enable )
	local Drag = me.Drag;
	Drag:ClearAllPoints();
	if ( Enable ) then
		Drag:SetAllPoints();
	else -- Position offscreen
		Drag:SetPoint( "TOP", UIParent, 0, math.huge );
	end
end


--[[****************************************************************************
  * Function: _NPCScan.Button:OnEnter                                          *
  * Description: Highlights the button.                                        *
  ****************************************************************************]]
function me:OnEnter ()
	me:SetBackdropBorderColor( 1, 1, 0.15 ); -- Yellow
end
--[[****************************************************************************
  * Function: _NPCScan.Button:OnLeave                                          *
  * Description: Removes highlighting.                                         *
  ****************************************************************************]]
function me:OnLeave ()
	me:SetBackdropBorderColor( 0.7, 0.15, 0.05 ); -- Brown
end

--[[****************************************************************************
  * Function: _NPCScan.Button:PLAYER_REGEN_ENABLED                             *
  ****************************************************************************]]
function me:PLAYER_REGEN_ENABLED ()
	-- Update button after leaving combat
	if ( me.PendingName and me.PendingID ) then
		me.Update( me.PendingName, me.PendingID );
		me.PendingName = nil;
		me.PendingID = nil;
	end
end
--[[****************************************************************************
  * Function: _NPCScan.Button:MODIFIER_STATE_CHANGED                           *
  ****************************************************************************]]
function me:MODIFIER_STATE_CHANGED ( _, Modifier, State )
	Modifier = Modifier:sub( 2 );
	if ( GetModifiedClick( "_NPCSCAN_BUTTONDRAG" ):find( Modifier, 1, true ) ) then
		me.EnableDrag( State == 1 );
	end
end
--[[****************************************************************************
  * Function: _NPCScan.Button:OnEvent                                          *
  * Description: Global event handler.                                         *
  ****************************************************************************]]
me.OnEvent = _NPCScan.OnEvent;




--------------------------------------------------------------------------------
-- Function Hooks / Execution
-----------------------------

do
	me:Hide();
	me:SetWidth( 150 );
	me:SetHeight( 42 );
	me:SetPoint( "BOTTOM", UIParent, 0, 128 );
	me:SetMovable( true );
	me:SetUserPlaced( true );
	me:SetClampedToScreen( true );
	me:SetFrameStrata( "FULLSCREEN_DIALOG" );
	me:SetNormalTexture( "Interface\\AchievementFrame\\UI-Achievement-Parchment-Horizontal" );
	local Background = me:GetNormalTexture();
	Background:SetDrawLayer( "BACKGROUND" );
	Background:ClearAllPoints();
	Background:SetPoint( "BOTTOMLEFT", 3, 3 );
	Background:SetPoint( "TOPRIGHT", -3, -3 );
	Background:SetTexCoord( 0, 1, 0, 0.25 );

	local TitleBackground = me:CreateTexture( nil, "ARTWORK" );
	TitleBackground:SetTexture( "Interface\\AchievementFrame\\UI-Achievement-Title" );
	TitleBackground:SetPoint( "TOPRIGHT", -5, -5 );
	TitleBackground:SetPoint( "LEFT", 5, 0 );
	TitleBackground:SetHeight( 18 );
	TitleBackground:SetTexCoord( 0, 0.9765625, 0, 0.3125 );
	TitleBackground:SetAlpha( 0.8 );

	local Title = me:CreateFontString( nil, "OVERLAY", "GameFontHighlightMedium" );
	me.Title = Title;
	Title:SetPoint( "TOPLEFT", TitleBackground );
	Title:SetPoint( "RIGHT", TitleBackground );
	me:SetFontString( Title );

	local SubTitle = me:CreateFontString( nil, "OVERLAY", "GameFontBlackTiny" );
	SubTitle:SetPoint( "TOPLEFT", Title, "BOTTOMLEFT", 0, -4 );
	SubTitle:SetPoint( "RIGHT", Title );
	SubTitle:SetText( L.BUTTON_FOUND );

	-- Border
	me:SetBackdrop( {
		tile = true; edgeSize = 16;
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border";
	} );
	me:OnLeave(); -- Set non-highlighted colors

	-- Drag frame
	me.Drag = me:CreateTitleRegion();
	me.EnableDrag( false );

	-- Close button
	local Close = CreateFrame( "Button", nil, me, "UIPanelCloseButton,SecureHandlerClickTemplate" );
	me.Close = Close;
	Close:SetPoint( "TOPRIGHT" );
	Close:SetWidth( 32 );
	Close:SetHeight( 32 );
	Close:SetScale( 0.8 );
	Close:SetHitRectInsets( 8, 8, 8, 8 );
	Close:SetAttribute( "_onclick", [[
		local Button = self:GetParent();
		Button:Disable();
		Button:Hide();
	]] );

	-- Model view
	local Model = CreateFrame( "DressUpModel", nil, me );
	me.Model = Model;
	Model:SetPoint( "BOTTOMLEFT", me, "TOPLEFT", 0, -4 );
	Model:SetPoint( "RIGHT" );
	Model:SetHeight( me:GetWidth() );
	me:SetClampRectInsets( 0, 0, Model:GetTop() - me:GetTop(), 0 ); -- Allow room for model
	Model:SetScript( "OnUpdate", function ( self, Elapsed )
		self:SetFacing( self:GetFacing() + Elapsed * me.RotationRate );
	end );

	-- Flash frame
	local Glow = CreateFrame( "Frame", "$parentGlow", me );
	me.Glow = Glow;
	Glow:SetPoint( "CENTER" );
	Glow:SetWidth( 400 / 300 * me:GetWidth() );
	Glow:SetHeight( 171 / 88 * me:GetHeight() );
	local Texture = Glow:CreateTexture( nil, "OVERLAY" );
	Texture:SetAllPoints();
	Texture:SetTexture( "Interface\\AchievementFrame\\UI-Achievement-Alert-Glow" );
	Texture:SetBlendMode( "ADD" );
	Texture:SetTexCoord( 0, 0.78125, 0, 0.66796875 );


	me:SetAttribute( "type", "macro" );

	me:SetScript( "OnEnter", me.OnEnter );
	me:SetScript( "OnLeave", me.OnLeave );
	me:SetScript( "OnEvent", me.OnEvent );
	me:RegisterEvent( "PLAYER_REGEN_ENABLED" );
	me:RegisterEvent( "MODIFIER_STATE_CHANGED" );
end

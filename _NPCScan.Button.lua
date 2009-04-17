--[[****************************************************************************
  * _NPCScan by Saiket                                                         *
  * _NPCScan.Button.lua - Displays a button to target found NPCs.              *
  ****************************************************************************]]


local _NPCScan = _NPCScan;
local L = _NPCScanLocalization;
local me = CreateFrame( "Button", "_NPCScanButton", nil, "SecureActionButtonTemplate,SecureHandlerShowHideTemplate" );
_NPCScan.Button = me;

local Model = CreateFrame( "PlayerModel", nil, me );
me.Model = Model;

me.PendingName = nil;
me.PendingID = nil;

me.RotationRate = math.pi / 4;

-- Key is lowercase, value = "[Scale]|[X]|[Y]|[Z]", where any parameter can be left empty
me.ModelCameras = {
	[ "creature\\protodragon\\protodragon.m2" ] = "1.5|||10"; -- Time-lost Proto Drake

	[ "creature\\parrot\\parrot.m2" ] = "2"; -- Aotona
	[ "creature\\clockworkgnome\\clockworkgnome.m2" ] = "1.5"; -- Dirkee, Fumblub Gearwind
	[ "creature\\northrendstonegiant\\northrendstonegiant.m2" ] = "1.5"; -- Grocklar
	[ "creature\\valkierdark\\valkierdark.m2" ] = "1.7"; -- Hildana Deathstealer
	[ "creature\\northrendworgen\\northrendworgen.m2" ] = "2"; -- Perobas the Bloodthirster
	[ "creature\\northrendfleshgiant\\northrendfleshgiant.m2" ] = "1.5||2"; -- Putridus the Ancient
	[ "creature\\fleshbeast\\fleshbeast.m2" ] = "1.4"; -- Seething Hate
	[ "creature\\vrykulfemale\\vrykulfemalehunter.m2" ] = "2"; -- Syreian the Bonecarver, Vigdis the War Maiden
	[ "creature\\mammoth\\mammoth.m2" ] = ".6|.8|2.5"; -- Tukemuth
	[ "creature\\bonespider\\bonespider.m2" ] = "2||-1.5"; -- Terror Spinner
	[ "creature\\zuldrakgolem\\zuldrakgolem.m2" ] = ".65||1.4"; -- Zul'drak Sentinel
	[ "creature\\dragon\\northrenddragon.m2" ] = ".5||15|-3"; -- Vyragosa
};




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
  * Function: _NPCScan.Button.Model.Reset                                      *
  * Description: Clears the model and readies it for a SetCreature call.       *
  ****************************************************************************]]
function Model.Reset ()
	Model:ClearModel();
	Model:SetModelScale( 1 );
	Model:SetPosition( 0, 0, 0 );
	Model:SetFacing( 0 );
end
--[[****************************************************************************
  * Function: _NPCScan.Button.Update                                           *
  * Description: Updates the button based on its Name and ID fields.           *
  ****************************************************************************]]
function me.Update ( Name, ID )
	me:Show(); -- Note: Must be visible before model scale calls will work
	me:SetText( Name );
	Model.Reset();
	if ( type( ID ) == "string" ) then -- ID is UnitID
		Model:SetUnit( ID );
		Model:SetModelScale( 0.75 );
		Name = ID;
	else -- ID is NPC ID
		Model:SetCreature( ID );
		if ( type( Model:GetModel() ) == "string" ) then
			local Scale, X, Y, Z = ( "|" ):split( me.ModelCameras[ Model:GetModel():lower() ] or "" );
			Model:SetModelScale( 0.5 * ( tonumber( Scale ) or 1 ) );
			Model:SetPosition( tonumber( Z ) or 0, tonumber( X ) or 0, tonumber( Y ) or 0 );
		end
	end
	me:SetAttribute( "macrotext", "/cleartarget\n/targetexact "..Name );

	UIFrameFadeRemoveFrame( me.Glow );
	UIFrameFlashRemoveFrame( me.Glow );
	if ( UIParent:IsVisible() ) then -- Only flash when animating frame is shown
		UIFrameFlash( me.Glow, 0.1, 0.7, 0.8 );
	end
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

	me:SetAttribute( "_onshow", "self:Enable();" );
	me:SetAttribute( "_onhide", "self:Disable();" );
	me:Hide();

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
	local Close = CreateFrame( "Button", nil, me, "UIPanelCloseButton" );
	me.Close = Close;
	Close:SetPoint( "TOPRIGHT" );
	Close:SetWidth( 32 );
	Close:SetHeight( 32 );
	Close:SetScale( 0.8 );
	Close:SetHitRectInsets( 8, 8, 8, 8 );

	-- Model view
	Model:SetPoint( "BOTTOMLEFT", me, "TOPLEFT", 0, -4 );
	Model:SetPoint( "RIGHT" );
	Model:SetHeight( me:GetWidth() * 0.6 );
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

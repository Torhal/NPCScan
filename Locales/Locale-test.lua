--[[****************************************************************************
  * _NPCScan by Saiket                                                         *
  * Locales/Locale-enUS.lua - Localized string constants (en-US).              *
  ****************************************************************************]]


-- See http://wow.curseforge.com/addons/npcscan/localization/enUS/
local private = select( 2, ... )
private.L = setmetatable( {
	NPCs = {};
	-- Phrases localized by default UI
	FOUND_ZONE_UNKNOWN = UNKNOWN;
	SEARCH_LEVEL_TYPE_FORMAT = UNIT_TYPE_LEVEL_TEMPLATE; -- Level, Type
}, {
	__index = function ( self, Key )
		if ( Key ~= nil ) then
			rawset( self, Key, Key );
			return Key;
		end
	end;
} );

--@localization(locale="enUS", namespace="Localization", format="lua_additive_table", table-name="private.L", handle-unlocalized="comment", handle-subnamespaces="none")@
--@localization(locale="enUS", namespace="NPCs", format="lua_additive_table", table-name="private.L.NPCs", handle-unlocalized="comment", handle-subnamespaces="none")@



SLASH__NPCSCAN1 = "/npcscan";
SLASH__NPCSCAN2 = "/scan";

BINDING_HEADER__NPCSCAN = "_|cffCCCC88NPCScan|r";
_G[ "BINDING_NAME_CLICK _NPCScanButton:LeftButton" ] = [=[Target last found mob
|cff808080(Use when _NPCScan alerts you)|r]=];
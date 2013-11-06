--[[****************************************************************************
  * _NPCScan by Saiket                                                         *
  * Locales/Locale-itIT.lua - Localized string constants (it-IT).              *
  ****************************************************************************]]


if ( GetLocale() ~= "itIT" ) then
	return;
end


-- See http://wow.curseforge.com/addons/npcscan/localization/itIT/
local private = select( 2, ... );
private.L = setmetatable( {
	NPCs = setmetatable( {
	}, { __index = private.L.NPCs; } );
}, { __index = private.L; } );

--@localization(locale="itIT", namespace="Localization", format="lua_additive_table", table-name="private.L", handle-unlocalized="comment", handle-subnamespaces="none")@
--@localization(locale="itIT", namespace="NPCs", format="lua_additive_table", table-name="private.L.NPCs", handle-unlocalized="comment", handle-subnamespaces="none")@

_G[ "BINDING_NAME_CLICK _NPCScanButton:LeftButton" ] = [=[Targetta l'ultimo NPC trovato
|cff808080(Usato da _NPCScan per avvisarti)|r]=];
--[[****************************************************************************
  * _NPCScan by Saiket                                                         *
  * Locales/Locale-frFR.lua - Localized string constants (fr-FR).              *
  ****************************************************************************]]


if ( GetLocale() ~= "frFR" ) then
	return;
end


-- See http://wow.curseforge.com/addons/npcscan/localization/frFR/
local private = select( 2, ... );
private.L = setmetatable( {
	NPCs = setmetatable( {
	}, { __index = private.L.NPCs; } );
}, { __index = private.L; } );

--@localization(locale="frFR", namespace="Localization", format="lua_additive_table", table-name="private.L", handle-unlocalized="comment", handle-subnamespaces="none")@
--@localization(locale="frFR", namespace="NPCs", format="lua_additive_table", table-name="private.L.NPCs", handle-unlocalized="comment", handle-subnamespaces="none")@


_G[ "BINDING_NAME_CLICK _NPCScanButton:LeftButton" ] = [=[Cibler dernier monstre trouvé
|cff808080(Utile qd _NPCScan vous alerte)|r]=];
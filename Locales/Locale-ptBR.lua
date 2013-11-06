--[[****************************************************************************
  * _NPCScan by Saiket                                                         *
  * Locales/Locale-ptBR.lua - Localized string constants (pt-BR).              *
  ****************************************************************************]]


if ( GetLocale() ~= "ptBR" and GetLocale() ~= "ptPT" ) then
	return;
end


-- See http://wow.curseforge.com/addons/npcscan/localization/ptBR/
local private = select( 2, ... );
private.L = setmetatable( {
	NPCs = setmetatable( {
	}, { __index = private.L.NPCs; } );
}, { __index = private.L; } );

--@localization(locale="ptBR", namespace="Localization", format="lua_additive_table", table-name="private.L", handle-unlocalized="comment", handle-subnamespaces="none")@
--@localization(locale="ptBR", namespace="NPCs", format="lua_additive_table", table-name="private.L.NPCs", handle-unlocalized="comment", handle-subnamespaces="none")@


_G[ "BINDING_NAME_CLICK _NPCScanButton:LeftButton" ] = [=[Marca o ultimo PNJ encontrado
|cff808080(Use quando _NPCScan alertar você)|r]=];
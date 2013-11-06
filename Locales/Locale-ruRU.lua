--[[****************************************************************************
  * _NPCScan by Saiket                                                         *
  * Locales/Locale-ruRU.lua - Localized string constants (ru-RU).              *
  ****************************************************************************]]


if ( GetLocale() ~= "ruRU" ) then
	return;
end


-- See http://wow.curseforge.com/addons/npcscan/localization/ruRU/
local private = select( 2, ... );
private.L = setmetatable( {
	NPCs = setmetatable( {
	}, { __index = private.L.NPCs; } );
}, { __index = private.L; } );

--@localization(locale="ruRU", namespace="Localization", format="lua_additive_table", table-name="private.L", handle-unlocalized="comment", handle-subnamespaces="none")@
--@localization(locale="ruRU", namespace="NPCs", format="lua_additive_table", table-name="private.L.NPCs", handle-unlocalized="comment", handle-subnamespaces="none")@


_G[ "BINDING_NAME_CLICK _NPCScanButton:LeftButton" ] = [=[Выбрать последнее из найденных существ
|cff808080(Используйте когда _NPCScan известит Вас)|r]=];
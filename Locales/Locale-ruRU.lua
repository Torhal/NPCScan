--[[****************************************************************************
  * _NPCScan by Saiket                                                         *
  * Locales/Locale-ruRU.lua - Localized string constants (ru-RU).              *
  ****************************************************************************]]


if ( GetLocale() ~= "ruRU" ) then
	return;
end


-- See http://wow.curseforge.com/addons/npcscan/localization/ruRU/
local _NPCScan = select( 2, ... );
_NPCScan.L = setmetatable( {
	NPCs = setmetatable( {	
	}, { __index = _NPCScan.L.NPCs; } );
	}, { __index = _NPCScan.L; } );

--@localization(locale="ruRU", namespace="Localization", format="lua_additive_table", table-name="_NPCScan.L", handle-unlocalized="comment", escape-non-ascii="false", handle-subnamespaces="none")@


--Loads npc id's into a temp file to convert strings into numbers
local temp = {}

--@localization(locale="ruRU", namespace="NPCs ", format="lua_additive_table", table-name="temp", handle-unlocalized="comment", escape-non-ascii="false", handle-subnamespaces="none")@

for ID, Name in pairs(temp) do
	_NPCScan.L.NPCs[tonumber(ID)] = Name
end

_G[ "BINDING_NAME_CLICK _NPCScanButton:LeftButton" ] = [=[Выбрать последнее из найденных существ
|cff808080(Используйте когда _NPCScan известит Вас)|r]=];
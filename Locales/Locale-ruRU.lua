--[[****************************************************************************
  * _NPCScan by Saiket                                                         *
  * Locales/Locale-ruRU.lua - Localized string constants (ru-RU).              *
  ****************************************************************************]]


if ( GetLocale() ~= "ruRU" ) then
	return;
end


-- See http://wow.curseforge.com/addons/npcscan/localization/ruRU/
_NPCScanLocalization.NPCS = setmetatable( {
	[ 18684 ] = "Бро'Газ Без Клана",
	[ 32491 ] = "Затерянный во времени протодракон",
	[ 33776 ] = "Гондрия",
	[ 35189 ] = "Сколл",
	[ 38453 ] = "Арктур",
}, { __index = _NPCScanLocalization.NPCS; } );
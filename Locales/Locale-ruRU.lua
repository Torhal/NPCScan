--[[****************************************************************************
  * _NPCScan by Saiket                                                         *
  * Locales/Locale-ruRU.lua - Localized string constants (ru-RU).              *
  ****************************************************************************]]


if ( GetLocale() == "ruRU" ) then
	_NPCScanLocalization.NPCS = setmetatable( {
		[ 18684 ] = "Бро'Газ Без Клана"; -- Bro'Gaz the Clanless
		[ 32491 ] = "Затерянный во времени протодракон"; -- Time-Lost Proto Drake
		[ 33776 ] = "Гондрия"; -- Gondria
		[ 35189 ] = "Сколл"; -- Skoll
		[ 38453 ] = "Арктур"; -- Arcturis
	}, { __index = _NPCScanLocalization.NPCS; } );
end

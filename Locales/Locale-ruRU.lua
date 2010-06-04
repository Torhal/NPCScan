--[[****************************************************************************
  * _NPCScan by Saiket                                                         *
  * Locales/Locale-ruRU.lua - Localized string constants (ru-RU).              *
  ****************************************************************************]]


if ( GetLocale() == "ruRU" ) then
	_NPCScanLocalization.NPCS = setmetatable( {
		[ "Arcturis" ] = "Арктур";
		[ "Bro'Gaz the Clanless" ] = "Бро'Газ Без Клана";
		[ "Gondria" ] = "Гондрия";
		[ "Skoll" ] = "Сколл";
		[ "Time-Lost Proto Drake" ] = "Затерянный во времени протодракон";
	}, { __index = _NPCScanLocalization.NPCS; } );
end

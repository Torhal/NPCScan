--[[****************************************************************************
  * _NPCScan by Saiket                                                         *
  * Locales/Locale-frFR.lua - Localized string constants (fr-FR).              *
  ****************************************************************************]]


if ( GetLocale() == "frFR" ) then
	_NPCScanLocalization.NPCS = setmetatable( {
		[ "Time-Lost Proto Drake" ] = "Proto-drake perdu dans le temps";
	}, { __index = _NPCScanLocalization.NPCS; } );
end

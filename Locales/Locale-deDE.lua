--[[****************************************************************************
  * _NPCScan by Saiket                                                         *
  * Locales/Locale-deDE.lua - Localized string constants (de-DE).              *
  ****************************************************************************]]


if ( GetLocale() == "deDE" ) then
	_NPCScanLocalization.NPCS = setmetatable( {
		[ "Time-Lost Proto Drake" ] = "Zeitverlorener Protodrache";
	}, { __index = _NPCScanLocalization.NPCS; } );
end

--[[****************************************************************************
  * _NPCScan by Saiket                                                         *
  * Locales/Locale-deDE.lua - Localized string constants (de-DE).              *
  ****************************************************************************]]


if ( GetLocale() == "deDE" ) then
	_NPCScanLocalization.NPCS = setmetatable( {
		[ "Arcturis" ] = "Arcturis";
		[ "Bro'Gaz the Clanless" ] = "Bro'Gaz der Klanlose";
		[ "Gondria" ] = "Gondria";
		[ "Skoll" ] = "Skoll";
		[ "Time-Lost Proto Drake" ] = "Zeitverlorener Protodrache";
	}, { __index = _NPCScanLocalization.NPCS; } );
end

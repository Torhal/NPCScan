--[[****************************************************************************
  * _NPCScan by Saiket                                                         *
  * Locales/Locale-deDE.lua - Localized string constants (de-DE).              *
  ****************************************************************************]]


if ( GetLocale() == "deDE" ) then
	_NPCScanLocalization.NPCS = setmetatable( {
		[ 18684 ] = "Bro'Gaz der Klanlose"; -- Bro'Gaz the Clanless
		[ 32491 ] = "Zeitverlorener Protodrache"; -- Time-Lost Proto Drake
		[ 33776 ] = "Gondria"; -- Gondria
		[ 35189 ] = "Skoll"; -- Skoll
		[ 38453 ] = "Arcturis"; -- Arcturis
	}, { __index = _NPCScanLocalization.NPCS; } );
end

--[[****************************************************************************
  * _NPCScan by Saiket                                                         *
  * Locales/Locale-frFR.lua - Localized string constants (fr-FR).              *
  ****************************************************************************]]


if ( GetLocale() == "frFR" ) then
	_NPCScanLocalization.NPCS = setmetatable( {
		[ 18684 ] = "Bro'Gaz Sans-clan"; -- Bro'Gaz the Clanless
		[ 32491 ] = "Proto-drake perdu dans le temps"; -- Time-Lost Proto Drake
		[ 33776 ] = "Gondria"; -- Gondria
		[ 35189 ] = "Skoll"; -- Skoll
		[ 38453 ] = "Arcturis"; -- Arcturis
	}, { __index = _NPCScanLocalization.NPCS; } );
end

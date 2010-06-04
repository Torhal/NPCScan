--[[****************************************************************************
  * _NPCScan by Saiket                                                         *
  * Locales/Locale-esES.lua - Localized string constants (es-ES/es-MX).        *
  ****************************************************************************]]


if ( GetLocale() == "esES" or GetLocale() == "esMX" ) then
	_NPCScanLocalization.NPCS = setmetatable( {
		[ 18684 ] = "Bro'Gaz sin Clan"; -- Bro'Gaz the Clanless
		[ 32491 ] = "Protodraco Tiempo Perdido"; -- Time-Lost Proto Drake
		[ 33776 ] = "Gondria"; -- Gondria
		[ 35189 ] = "Skoll"; -- Skoll
		[ 38453 ] = "Arcturis"; -- Arcturis
	}, { __index = _NPCScanLocalization.NPCS; } );
end

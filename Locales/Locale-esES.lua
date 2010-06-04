--[[****************************************************************************
  * _NPCScan by Saiket                                                         *
  * Locales/Locale-esES.lua - Localized string constants (es-ES/es-MX).        *
  ****************************************************************************]]


if ( GetLocale() == "esES" or GetLocale() == "esMX" ) then
	_NPCScanLocalization.NPCS = setmetatable( {
		[ "Arcturis" ] = "Arcturis";
		[ "Bro'Gaz the Clanless" ] = "Bro'Gaz sin Clan";
		[ "Gondria" ] = "Gondria";
		[ "Skoll" ] = "Skoll";
		[ "Time-Lost Proto Drake" ] = "Protodraco Tiempo Perdido";
	}, { __index = _NPCScanLocalization.NPCS; } );
end

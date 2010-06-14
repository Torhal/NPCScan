--[[****************************************************************************
  * _NPCScan by Saiket                                                         *
  * Locales/Locale-frFR.lua - Localized string constants (fr-FR).              *
  ****************************************************************************]]


if ( GetLocale() ~= "frFR" ) then
	return;
end


-- See http://wow.curseforge.com/addons/npcscan/localization/frFR/
_NPCScanLocalization.NPCS = setmetatable( {
	[ 18684 ] = "Bro'Gaz Sans-clan",
	[ 32491 ] = "Proto-drake perdu dans le temps",
	[ 33776 ] = "Gondria",
	[ 35189 ] = "Skoll",
	[ 38453 ] = "Arcturis",
}, { __index = _NPCScanLocalization.NPCS; } );
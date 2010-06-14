--[[****************************************************************************
  * _NPCScan by Saiket                                                         *
  * Locales/Locale-koKR.lua - Localized string constants (ko-KR).              *
  ****************************************************************************]]


if ( GetLocale() ~= "koKR" ) then
	return;
end


_NPCScanLocalization.NPCS = setmetatable( {
	[ 18684 ] = "외톨이 브로가즈"; -- Bro'Gaz the Clanless
	--[ 32491 ] = ""; -- Time-Lost Proto Drake
	[ 33776 ] = "곤드리아"; -- Gondria
	[ 35189 ] = "스콜"; -- Skoll
	--[ 38453 ] = ""; -- Arcturis
}, { __index = _NPCScanLocalization.NPCS; } );
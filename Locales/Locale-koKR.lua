--[[****************************************************************************
  * _NPCScan by Saiket                                                         *
  * Locales/Locale-koKR.lua - Localized string constants (ko-KR).              *
  ****************************************************************************]]


if ( GetLocale() ~= "koKR" ) then
	return;
end


-- See http://wow.curseforge.com/addons/npcscan/localization/koKR/
_NPCScanLocalization.NPCS = setmetatable( {
	[ 18684 ] = "외톨이 브로가즈",
	[ 33776 ] = "곤드리아",
	[ 35189 ] = "스콜",
}, { __index = _NPCScanLocalization.NPCS; } );
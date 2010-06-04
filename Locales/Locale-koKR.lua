--[[****************************************************************************
  * _NPCScan by Saiket                                                         *
  * Locales/Locale-koKR.lua - Localized string constants (ko-KR).              *
  ****************************************************************************]]


if ( GetLocale() == "koKR" ) then
	_NPCScanLocalization.NPCS = setmetatable( {
		--[ "Arcturis" ] = "";
		[ "Bro'Gaz the Clanless" ] = "외톨이 브로가즈";
		[ "Gondria" ] = "곤드리아";
		[ "Skoll" ] = "스콜";
		--[ "Time-Lost Proto Drake" ] = "";
	}, { __index = _NPCScanLocalization.NPCS; } );
end

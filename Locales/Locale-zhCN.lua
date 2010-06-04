--[[****************************************************************************
  * _NPCScan by Saiket                                                         *
  * Locales/Locale-zhCN.lua - Localized string constants (zh-CN).              *
  ****************************************************************************]]


if ( GetLocale() == "zhCN" ) then
	_NPCScanLocalization.NPCS = setmetatable( {
		--[ "Arcturis" ] = "";
		[ "Bro'Gaz the Clanless" ] = "独行者布罗加斯";
		[ "Gondria" ] = "古德利亚";
		--[ "Skoll ] = "";
		--[ "Time-Lost Proto Drake" ] = "";
	}, { __index = _NPCScanLocalization.NPCS; } );
end

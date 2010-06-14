--[[****************************************************************************
  * _NPCScan by Saiket                                                         *
  * Locales/Locale-zhCN.lua - Localized string constants (zh-CN).              *
  ****************************************************************************]]


if ( GetLocale() ~= "zhCN" ) then
	return;
end


_NPCScanLocalization.NPCS = setmetatable( {
	[ 18684 ] = "独行者布罗加斯"; -- Bro'Gaz the Clanless
	--[ 32491 ] = ""; -- Time-Lost Proto Drake
	[ 33776 ] = "古德利亚"; -- Gondria
	--[ 35189 ] = ""; -- Skoll
	--[ 38453 ] = ""; -- Arcturis
}, { __index = _NPCScanLocalization.NPCS; } );
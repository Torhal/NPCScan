--[[****************************************************************************
  * _NPCScan by Saiket                                                         *
  * Locales/Locale-ptBR.lua - Localized string constants (pt-BR).              *
  ****************************************************************************]]


if ( GetLocale() ~= "ptBR" ) then
	return;
end


-- See http://wow.curseforge.com/addons/npcscan/localization/ptBR/
local _NPCScan = select( 2, ... );
_NPCScan.L = setmetatable( {
	NPCs = setmetatable( {
		[ 32491 ] = "Time-Lost Proto Drake", -- Needs review
		[ 33776 ] = "Gondria", -- Needs review
		[ 35189 ] = "Skoll", -- Needs review
		[ 38453 ] = "Arcturis", -- Needs review
	}, { __index = _NPCScan.L.NPCs; } );

	BUTTON_FOUND = "NPC encontrado!", -- Needs review
	CMD_REMOVENOTFOUND_FORMAT = "NPC |cff808080“%s”|r não encontrado.", -- Needs review
	CONFIG_ALERT = "Opções de alerta", -- Needs review
	CONFIG_ALERT_SOUND = "Arquivo de som de alerta", -- Needs review
	CONFIG_TEST_NAME = "Você! (Teste)", -- Needs review
	SEARCH_ACHIEVEMENT_DISABLED = "Desabilitado", -- Needs review
	SEARCH_COMPLETED = "Feito", -- Needs review
	SEARCH_NAME = "Nome:", -- Needs review
	SEARCH_TITLE = "Procurar", -- Needs review
}, { __index = _NPCScan.L; } );
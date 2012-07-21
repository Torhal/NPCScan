--[[****************************************************************************
  * _NPCScan by Saiket                                                         *
  * Locales/Locale-itIT.lua - Localized string constants (it-IT).              *
  ****************************************************************************]]


if ( GetLocale() ~= "itIT" ) then
	return;
end


-- See http://wow.curseforge.com/addons/npcscan/localization/itIT/
local _NPCScan = select( 2, ... );
_NPCScan.L = setmetatable( {
	NPCs = setmetatable( {
	}, { __index = _NPCScan.L.NPCs; } );

	BUTTON_FOUND = "NPC trovato!", -- Needs review
	CACHED_FORMAT = "La/le seguente/i unità sono già nella cache: %s.", -- Needs review
	CACHED_LONG_FORMAT = "La/le seguente/i unità sono già nella cache. Considera l'opportunità di rimuoverle usando |cff808080“/npcscan”|r's menu o resettando la cache: %s.", -- Needs review
	CACHED_WORLD_FORMAT = "La/le seguente/i unità %2$s sono già nella cache: %1$s.", -- Needs review
	CACHELIST_ENTRY_FORMAT = "|cff808080“%s”|r", -- Needs review
	CACHELIST_SEPARATOR = ",", -- Needs review
	CMD_ADD = "AGGIUNGI", -- Needs review
	CMD_CACHE = "CACHE", -- Needs review
	CMD_CACHE_EMPTY = "Nessuno dei mob cercati è nella cache.", -- Needs review
	CMD_HELP = "I comandi sono |cff808080“/npcscan add <NpcID> <Nome>”|r, |cff808080“/npcscan remove <NpcID o Nome>”|r, |cff808080“/npcscan cache”|r per mettere in lista i mob nella cache, e semplicemente |cff808080“/npcscan”|r per il menu delle opzioni.", -- Needs review
	CMD_REMOVE = "RIMUOVI", -- Needs review
	CMD_REMOVENOTFOUND_FORMAT = "NPC |cff808080“%s”|r non trovato.", -- Needs review
	CONFIG_ALERT = "Opzioni d'allarme", -- Needs review
	CONFIG_ALERT_SOUND = "File sonoro di allarme", -- Needs review
	CONFIG_ALERT_SOUND_DEFAULT = "|cffffd200Default|r", -- Needs review
	CONFIG_ALERT_SOUND_DESC = "Scegli il suono di allarme da riprodurre quando un NPC viene trovato. Altri suoni possono essere aggiunti tramite gli addon |cff808080“SharedMedia”|r.", -- Needs review
	CONFIG_ALERT_UNMUTE = "Attiva per il suono d'allarme", -- Needs review
	CONFIG_ALERT_UNMUTE_DESC = "Abilita il suono del gioco quando il bottone obiettivo viene mostrato così puoi sentire gli allarmi anche quando mutato.", -- Needs review
	CONFIG_CACHEWARNINGS = "Stampa promemoria della cache al login ed ai cambiamenti di mondo", -- Needs review
	CONFIG_CACHEWARNINGS_DESC = "Se un NPC è già nella cache quando logghi o cambi mondo, questa opzione stampa un promemoria di quali mob nella cache non possono essere cercati.", -- Needs review
	CONFIG_DESC = "Queste opzioni ti lasciano configurare il modo in cui _NPCScan ti avvisa quando trova NPC rari.", -- Needs review
	CONFIG_TEST = "Prova Allarme Trovato", -- Needs review
	CONFIG_TEST_DESC = "Simula un allarme |cff808080“NPC trovato”|r per farti sapere a cosa devi stare attento.", -- Needs review
	CONFIG_TEST_HELP_FORMAT = "Clicca il bottone target o usa il keybind fornito per selezionare il mob trovato. Tieni premuto |cffffffff<%s>|r e sposta per muovere il bottone del target. Nota che se un NPC viene trovato finchè sei in combat, il bottone comparirà solo dopo l'uscita dal combat.", -- Needs review
	CONFIG_TEST_NAME = "Tu! (Test)", -- Needs review
	CONFIG_TITLE = "_|cffCCCC88NPCScan|r", -- Needs review
	FOUND_FORMAT = "Trovato |cff808080“%s”|r!", -- Needs review
	FOUND_TAMABLE_FORMAT = "Trovato |cff808080“%s”|r!  |cffff2020(Nota: mob catturabile, potrebbe essere solo un famiglio)|r", -- Needs review
	FOUND_TAMABLE_WRONGZONE_FORMAT = "|cffff2020Falso allarme:|r Trovato mob catturabil |cff808080“%s”|r in %s invece che %s (ID %d); Senzaltro un pet.", -- Needs review
	PRINT_FORMAT = "%s_|cffCCCC88NPCScan|r: %s", -- Needs review
}, { __index = _NPCScan.L; } );
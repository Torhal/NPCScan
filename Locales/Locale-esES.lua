--[[****************************************************************************
  * _NPCScan by Saiket                                                         *
  * Locales/Locale-esES.lua - Localized string constants (es-ES/es-MX).        *
  ****************************************************************************]]


if ( GetLocale() ~= "esES" and GetLocale() ~= "esMX" ) then
	return;
end


-- See http://wow.curseforge.com/addons/npcscan/localization/esES/
local _NPCScan = select( 2, ... );
_NPCScan.L = setmetatable( {
	NPCs = setmetatable( {
		[ 18684 ] = "Bro'Gaz sin Clan",
		[ 32491 ] = "Protodraco Tiempo Perdido",
		[ 33776 ] = "Gondria",
		[ 35189 ] = "Skoll",
		[ 38453 ] = "Arcturis",
	}, { __index = _NPCScan.L.NPCs; } );

	BUTTON_FOUND = "NPC Encontrado!",
	CACHED_FORMAT = "Los siguientes NPC ya han sido encontrados: %s",
	CACHED_LONG_FORMAT = "Los siguientes NPC ya han sido encontrados. Piensate el borrarlos usando el menu |cff808080“/npcscan”|r o borrando tu cache",
	CACHED_PET_RESTING_FORMAT = "La siguiente mascota(s) domesticable fueron encontradas: %s",
	CACHED_STABLED_FORMAT = "El siguiente NPC(s) no puede ser encontrado estando domesticado: %s",
	CACHED_WORLD_FORMAT = "Los siguientes %2$s NPC (s) ya han sido encontrados: %1$s.",
	CACHELIST_ENTRY_FORMAT = "|cff808080“%s”|r",
	CACHELIST_SEPARATOR = ",",
	CMD_ADD = "AÑADIR",
	CMD_CACHE = "CACHE",
	CMD_CACHE_EMPTY = "Ninguno de los NPC buscados han sido encontrados",
	CMD_HELP = "Los comandos son |cff808080“/npcscan add <NpcID> <Nombre>”|r, |cff808080“/npcscan remove <NpcID or Nombre>”|r, |cff808080“/npcscan cache”|r para lista los NPC encontrados, y solo |cff808080“/npcscan”|r para el menu de opciones.",
	CMD_REMOVE = "BORRAR",
	CMD_REMOVENOTFOUND_FORMAT = "NPC  |cff808080“%s”|r no encontrado.",
	CONFIG_ALERT = "Opciones de Alerta",
	CONFIG_ALERT_SOUND = "Sonido de la alerta",
	CONFIG_ALERT_SOUND_DEFAULT = "|cffffd200Por defecto|r",
	CONFIG_ALERT_SOUND_DESC = "Selecciona el sonido de alerta cuando NPC es encontrado. Se puede añadir sonidos adicionales por medio de addons |cff808080“SharedMedia”|r",
	CONFIG_ALERT_UNMUTE = "Quitar el silencio al sonido de alerta",
	CONFIG_ALERT_UNMUTE_DESC = "Activa el sonido del juego cuando se muestra el boton de objetivo NPC para que puedas oir la alerta con el silencio activado.",
	CONFIG_CACHEWARNINGS = "Muestra el recordatorio de cache al logear y entre cambios de mundo",
	CONFIG_CACHEWARNINGS_DESC = "Si un NPC ya ha sido encontrado cuando logeas o cambias de mundo, esta opcion muestra un recordatorio que explica que los NPC encontrados no se pueden buscar de nuevo",
	CONFIG_DESC = "Esta opcion te deja configurar como _NPCScan te alerta cuando encuentra a un NPC raro.",
	CONFIG_TEST = "Probar alerta al encontrar",
	CONFIG_TEST_DESC = "Simula una alerta de |cff808080“NPC encontrado”|r para que sepas su configuracion actual",
	CONFIG_TEST_HELP_FORMAT = "Pulsa en el boton de objetivo o usa la macro para seleccionar como objetivo el NPC encontrado. Manten  |cffffffff<%s>|r y arrastra para mover el boton objetivo. Nota: Si un NPC es encontrado mientras estas en combate, el boton de objetivo solo aparecera cuando salgas de combate.",
	CONFIG_TEST_NAME = "Tu! (Prueba)",
	CONFIG_TITLE = "_|cffCCCC88NPCScan|r",
	FOUND_FORMAT = "Encontrado |cff808080“%s”|r!",
	FOUND_TAMABLE_FORMAT = "Encontrado |cff808080“%s”|r!  |cffff2020(Nota: NPC domesticable, puede ser solo una mascota.)|r",
	FOUND_TAMABLE_WRONGZONE_FORMAT = "|cffff2020Falsa alarma:|r NPC domesticable encontrado |cff808080“%s”|r en %s en vez de %s (ID %d); Definitivamente es una mascota.",
	PRINT_FORMAT = "_|cffCCCC88NPCScan|r: %s",
	SEARCH_ACHIEVEMENTADDFOUND = "Busca logros completados sobre NPCs",
	SEARCH_ACHIEVEMENTADDFOUND_DESC = "Continua buscando todos los NPC de logros, incluso si ya no los necesitas",
	SEARCH_ACHIEVEMENT_DISABLED = "Desactivado",
	SEARCH_ADD = "+",
	SEARCH_ADD_DESC = "Añade un nuevo NPC o salva los cambios de uno existente",
	SEARCH_ADD_TAMABLE_FORMAT = "Nota: |cff808080“%s”|r es domesticable, así que encontrar una mascota domesticada por un cazador puede producir una falsa alarma.",
	SEARCH_CACHED = "Encontrado",
	SEARCH_COMPLETED = "Listo",
	SEARCH_DESC = "Esta tabla te permite añadir o borrar NPCs y busquedas de logros",
	SEARCH_ID = "NPC ID:",
	SEARCH_ID_DESC = "El ID del NPC a buscar. Puedes buscar este valor en webs como wowhead.com",
	SEARCH_MAP = "Zona:",
	SEARCH_NAME = "Nombre:",
	SEARCH_NAME_DESC = "Un nombre para el NPC. Puede no coincidir con el nombre actual del NPC",
	SEARCH_NPCS = "NPC personalizado",
	SEARCH_NPCS_DESC = "Añadir cualquier NPC a la busqueda, incluso cuando no tiene logro",
	SEARCH_REMOVE = "-",
	SEARCH_TITLE = "Buscar",
	SEARCH_WORLD = "Mundo:",
	SEARCH_WORLD_DESC = "Un nombre de mundo opcional para limitar la busqueda. Puede ser el nombre de un continente o |cffff7f3f nombre de estancia|r (diferencia minusculas-mayusculas)",
	SEARCH_WORLD_FORMAT = "(%s)",
}, { __index = _NPCScan.L; } );


_G[ "BINDING_NAME_CLICK _NPCScanButton:LeftButton" ] = [=[Marca como objetivo el ultimo NPC encontrado
|cff808080(Usalo cuando _NPCScan te alerta)|r]=];
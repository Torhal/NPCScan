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
		[ 49822 ] = "Colmillo de Jade",
		[ 49913 ] = "Lady LaLa",
		[ 50005 ] = "Poseidus",
		[ 50009 ] = "Mobus",
		[ 50050 ] = "Shok'sharak",
		[ 50051 ] = "Reptafantasmas",
		[ 50052 ] = "Burgy Corazón Negro",
		[ 50053 ] = "Thartuk el Exiliado",
		[ 50056 ] = "Garr",
		[ 50057 ] = "Alardiente",
		[ 50058 ] = "Terrorpín",
		[ 50059 ] = "Golgarok",
		[ 50060 ] = "Terborus",
		[ 50061 ] = "Xariona",
		[ 50062 ] = "Aeonaxx",
		[ 50063 ] = "Akma'hat",
		[ 50064 ] = "Cyrus el Oscuro",
		[ 50065 ] = "Armagedillo",
		[ 50085 ] = "Señor supremo Hiendefuria",
		[ 50086 ] = "Tarvus el Vil",
		[ 50089 ] = "Julak Fatalidad",
		[ 50138 ] = "Karoma",
		[ 50154 ] = "Madexx", -- Needs review
		[ 50159 ] = "Sambas",
		[ 50409 ] = "Figurilla de camello misteriosa",
		[ 50410 ] = "Figurilla de camello misteriosa",
		[ 51071 ] = "Capitán Florence",
		[ 51079 ] = "Capitán Vientinfecto",
		[ 51401 ] = "Madexx", -- Needs review
		[ 51402 ] = "Madexx", -- Needs review
		[ 51403 ] = "Madexx", -- Needs review
		[ 51404 ] = "Madexx", -- Needs review
		[ 62346 ] = "Galeón", -- Needs review
	}, { __index = _NPCScan.L.NPCs; } );

	BUTTON_FOUND = "NPC Encontrado!",
	CACHED_FORMAT = "Los siguientes NPC se encuentran en la cache: %s",
	CACHED_LONG_FORMAT = "Los siguientes NPC ya han sido encontrados. Piensate el borrarlos usando el menu de |cff808080“/npcscan”|r o reiniciarlos borrando su cache: %s",
	CACHED_PET_RESTING_FORMAT = "La(s) siguiente(s) mascota(s) domesticable(s) fueron vistas mientras descansabas: %s",
	CACHED_STABLED_FORMAT = "Los siguientes NPC(s) no pueden buscarse si han sido domesticados: %s",
	CACHED_WORLD_FORMAT = "Los siguientes %2$s NPC (s) se encuentran en la cache: %1$s.",
	CACHELIST_ENTRY_FORMAT = "|cff808080“%s”|r",
	CACHELIST_SEPARATOR = ",",
	CMD_ADD = "AÑADIR",
	CMD_CACHE = "CACHE",
	CMD_CACHE_EMPTY = "Ninguno de los NPC buscados han sido encontrados",
	CMD_HELP = "Los comandos son: |cff808080“/npcscan add <NpcID> <Nombre>”|r, |cff808080“/npcscan remove <NpcID o Nombre>”|r, |cff808080“/npcscan cache”|r para listar los NPC en cache, y simplemente |cff808080“/npcscan”|r para el menu de opciones.",
	CMD_REMOVE = "BORRAR",
	CMD_REMOVENOTFOUND_FORMAT = "NPC  |cff808080“%s”|r no encontrado.",
	CONFIG_ALERT = "Opciones de Alerta",
	CONFIG_ALERT_SOUND = "Sonido de la alerta",
	CONFIG_ALERT_SOUND_DEFAULT = "|cffffd200Por defecto|r",
	CONFIG_ALERT_SOUND_DESC = "Selecciona el sonido de alerta cuando se encuentra un NPC. Se pueden añadir sonidos adicionales por medio de addons |cff808080“SharedMedia”|r",
	CONFIG_ALERT_UNMUTE = "Quitar el silencio al sonido de alerta",
	CONFIG_ALERT_UNMUTE_DESC = "Activa el sonido del juego cuando se muestra el boton de objetivo NPC para que pueda oir la alerta, incluso con el silencio activado.",
	CONFIG_CACHEWARNINGS = "Muestra recordatorios sobre el cache al conectar y al cambiar de mundo",
	CONFIG_CACHEWARNINGS_DESC = "Si un NPC ya está en cache cuando conectas o cambias de mundo, esta opción muestra un recordatorio sobre los NPCs que están en cache y no pueden buscarse.",
	CONFIG_DESC = "Estas opciones permiten configurar el modo en que _NPCScan te alerta cuando encuentra un NPC raro.",
	CONFIG_TEST = "Probar alerta al encontrar",
	CONFIG_TEST_DESC = "Simula una alerta de |cff808080“NPC encontrado”|r para que sepas qué buscar",
	CONFIG_TEST_HELP_FORMAT = "Pulsa en el botón de objetivo o usa la macro de teclado para seleccionar el NPC encontrado. Mantén pulsado |cffffffff<%s>|r y arrastra para mover el botón objetivo. Ten en cuenta que si encuentras un NPC mientras estas en combate, el botón solo aparecera cuando salgas del combate.",
	CONFIG_TEST_NAME = "Tu! (Prueba)",
	CONFIG_TITLE = "_|cffCCCC88NPCScan|r",
	FOUND_FORMAT = "Encontrado |cff808080“%s”|r!",
	FOUND_TAMABLE_FORMAT = "Encontrado |cff808080“%s”|r!  |cffff2020(Nota: NPC domesticable, puede ser solo una mascota.)|r",
	FOUND_TAMABLE_WRONGZONE_FORMAT = "|cffff2020Falsa alarma:|r Encontrado un NPC domesticable |cff808080“%s”|r en %s en vez de %s (ID %d); Definitivamente es una mascota.",
	PRINT_FORMAT = "%s_|cffCCCC88NPCScan|r: %s",
	SEARCH_ACHIEVEMENTADDFOUND = "Busca NPCs de logros ya completados",
	SEARCH_ACHIEVEMENTADDFOUND_DESC = "Continua buscando todos los NPC de logros, incluso si ya no los necesitas",
	SEARCH_ACHIEVEMENT_DISABLED = "Desactivado",
	SEARCH_ADD = "+",
	SEARCH_ADD_DESC = "Añade un nuevo NPC o guarda los cambios de uno existente",
	SEARCH_ADD_TAMABLE_FORMAT = "Nota: |cff808080“%s”|r es domesticable, así que verlo como mascota de cazador puede producir una falsa alarma.",
	SEARCH_CACHED = "En cache",
	SEARCH_COMPLETED = "Listo",
	SEARCH_DESC = "Esta tabla te permite añadir o borrar NPCs y busquedas de logros",
	SEARCH_ID = "NPC ID:",
	SEARCH_ID_DESC = "El ID del NPC a buscar. Puedes buscar este valor en webs como wowhead.com",
	SEARCH_MAP = "Zona:",
	SEARCH_NAME = "Nombre:",
	SEARCH_NAME_DESC = "Un nombre para el NPC. No tiene por qué coincidir con el nombre actual del NPC",
	SEARCH_NPCS = "NPC personalizado",
	SEARCH_NPCS_DESC = "Añadir cualquier NPC a la búsqueda, incluso cuando no tiene logro",
	SEARCH_REMOVE = "-",
	SEARCH_TITLE = "Buscar",
	SEARCH_WORLD = "Mundo:",
	SEARCH_WORLD_DESC = "Un nombre de mundo opcional para limitar la busqueda. Puede ser el nombre de un continente o |cffff7f3f nombre de estancia|r (diferencia minusculas-mayusculas)",
	SEARCH_WORLD_FORMAT = "(%s)",
}, { __index = _NPCScan.L; } );


_G[ "BINDING_NAME_CLICK _NPCScanButton:LeftButton" ] = [=[Marca el último NPC encontrado
|cff808080(Usalo cuando _NPCScan te alerta)|r]=];
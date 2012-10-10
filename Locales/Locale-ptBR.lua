--[[****************************************************************************
  * _NPCScan by Saiket                                                         *
  * Locales/Locale-ptBR.lua - Localized string constants (pt-BR).              *
  ****************************************************************************]]


if ( GetLocale() ~= "ptBR" and GetLocale() ~= "ptPT" ) then
	return;
end


-- See http://wow.curseforge.com/addons/npcscan/localization/ptBR/
local _NPCScan = select( 2, ... );
_NPCScan.L = setmetatable( {
	NPCs = setmetatable( {
		[ 18684 ] = "Bro'Gaz o Sem clã",
		[ 32491 ] = "Protodraco do Tempo Perdido",
		[ 33776 ] = "Gondria",
		[ 35189 ] = "Skoll",
		[ 38453 ] = "Arcturis",
		[ 49822 ] = "Jadefang", -- Needs review
		[ 49913 ] = "Lady LaLa", -- Needs review
		[ 50005 ] = "Poseidus", -- Needs review
		[ 50009 ] = "Mobus", -- Needs review
		[ 50050 ] = "Shok'sharak", -- Needs review
		[ 50051 ] = "Ghostcrawler", -- Needs review
		[ 50052 ] = "Burgy Blackheart", -- Needs review
		[ 50053 ] = "Thartuk o Exilado", -- Needs review
		[ 50056 ] = "Garr", -- Needs review
		[ 50057 ] = "Blazewing", -- Needs review
		[ 50058 ] = "Terrorpene", -- Needs review
		[ 50059 ] = "Golgarok", -- Needs review
		[ 50060 ] = "Terborus", -- Needs review
		[ 50061 ] = "Xariona", -- Needs review
		[ 50062 ] = "Aeonaxx", -- Needs review
		[ 50063 ] = "Akma'hat", -- Needs review
		[ 50064 ] = "Cyrus o Negro", -- Needs review
		[ 50065 ] = "Armagedillo", -- Needs review
		[ 50085 ] = "Suserano Sunderfury", -- Needs review
		[ 50086 ] = "Tarvus o Vil", -- Needs review
		[ 50089 ] = "Julak-Doom", -- Needs review
		[ 50138 ] = "Karoma", -- Needs review
		[ 50154 ] = "Madexx (Marrom)", -- Needs review
		[ 50159 ] = "Sambas", -- Needs review
		[ 50409 ] = "Figura de camelo misteriosa", -- Needs review
		[ 50410 ] = "Figura de camelo misteriosa", -- Needs review
		[ 50815 ] = "Skarr", -- Needs review
		[ 50959 ] = "Karkin", -- Needs review
		[ 51071 ] = "Captão Floreio", -- Needs review
		[ 51079 ] = "Captão Ventolo", -- Needs review
		[ 51401 ] = "Madexx (Vermelho)", -- Needs review
		[ 51402 ] = "Madexx (Verde)", -- Needs review
		[ 51403 ] = "Madexx (Negro)", -- Needs review
		[ 51404 ] = "Madexx (Azul)", -- Needs review
		[ 54318 ] = "Ankha", -- Needs review
		[ 54319 ] = "Magria", -- Needs review
		[ 54320 ] = "Ban'thalos", -- Needs review
		[ 54321 ] = "Solix", -- Needs review
		[ 54322 ] = "Deth'tilac", -- Needs review
		[ 54323 ] = "Kirix", -- Needs review
		[ 54324 ] = "Skitterflame", -- Needs review
		[ 54338 ] = "Anthriss", -- Needs review
		[ 62346 ] = "Gailleon", -- Needs review
	}, { __index = _NPCScan.L.NPCs; } );

	BUTTON_FOUND = "PNJ encontrado!",
	CACHED_FORMAT = "As unidades a seguir já estão no cache: %s",
	CACHED_LONG_FORMAT = "As unidades a seguir já estão no cache. Considere remove-las usando o menu do |cff808080“/npcscan”|r ou resetando-as limpando o seu cache: %s",
	CACHED_PET_RESTING_FORMAT = "Os seguintes ajudantes domáveis foram armazenados em cache enquanto descanava: %s",
	CACHED_STABLED_FORMAT = "As seguintes unidades não podem ser procuradas enquanto domadas: %s.",
	CACHED_WORLD_FORMAT = "As unidades a seguir do mundo %2$s já estão no cache: %1$s.",
	CACHELIST_ENTRY_FORMAT = "|cff808080“%s”|r",
	CACHELIST_SEPARATOR = ",",
	CMD_ADD = "ADD",
	CMD_CACHE = "CACHE",
	CMD_CACHE_EMPTY = "Nenhuma das unidades procuradas está no cache.",
	CMD_HELP = "Os comandos são: |cff808080“/npcscan add <ID do PNJ> <Nome do PNJ>”|r, |cff808080“/npcscan remover <ID ou nome do PNJ>”|r, |cff808080“/npcscan cache”|r para listar as unidades em cache, ou simplesmente |cff808080“/npcscan”|r para o menu de opções.",
	CMD_REMOVE = "REMOVER",
	CMD_REMOVENOTFOUND_FORMAT = "PNJ |cff808080“%s”|r não encontrado.",
	CONFIG_ALERT = "Opções de alerta",
	CONFIG_ALERT_SOUND = "Arquivo de som do alerta",
	CONFIG_ALERT_SOUND_DEFAULT = "|cffffd200Padrão|r",
	CONFIG_ALERT_SOUND_DESC = "Escolha o som de alerta que tocará quando um PNJ for encontrado. Sons adicionais podem ser adicionados através do addon |cff808080“SharedMedia”|r",
	CONFIG_ALERT_UNMUTE = "Tirar do mudo para os alertas sonoros.",
	CONFIG_ALERT_UNMUTE_DESC = "Ativa os sons de jogo enquanto o botão de alvo estiver visível, assim você pode ouvir os alertas mesmo que o som esteja mudo.",
	CONFIG_CACHEWARNINGS = "Imprimir lembrete de cache no login e troca de mundo.",
	CONFIG_CACHEWARNINGS_DESC = "Se um PNJ já estiver no cache quando você entrar no jogo ou mudar de mundo, esta opção imprime um lembrete de quais unidades do cache não podem ser procuradas.",
	CONFIG_DESC = "Esta opção permite configurar o modo como o _NPCScan te alerta quando encontra um PNJ raro.",
	CONFIG_PRINTTIME = "Mostrar data e hora na janela de chat",
	CONFIG_PRINTTIME_DESC = "Adiciona a hora atual a todas as mensagens impressas. Útil para gravar quando os PNJs forem encontrados.",
	CONFIG_TEST = "Testar Alerta de Encontrado",
	CONFIG_TEST_DESC = "Simula um alerta de |cff808080“PNJ Achado”|r para te mostrar por o que procurar.",
	CONFIG_TEST_HELP_FORMAT = "Clique no botão de alvo ou use a tecla de atalho para selecionar o PNJ encontrado. Segure |cffffffff<%s>|r e arraste para mover o botão de alvo. Note que se um PNJ for encontrado enquanto você está em combate, o botão só aparecerá depois que você sair de combate.",
	CONFIG_TEST_NAME = "Você! (Teste)",
	CONFIG_TITLE = "_|cffCCCC88NPCScan|r",
	FOUND_FORMAT = "Encontrado: |cff808080“%s”|r!",
	FOUND_TAMABLE_FORMAT = "Encontrado: |cff808080“%s”|r!  |cffff2020(Nota: Unidade domável, pode ser apenas um ajudante.)|r",
	FOUND_TAMABLE_WRONGZONE_FORMAT = "|cffff2020Alarme falso:|r Encontrada unidade domável |cff808080“%s”|r em %s ao invés de %s (ID %d); Definitivamente é um ajudante.",
	PRINT_FORMAT = "%s_|cffCCCC88NPCScan|r: %s",
	SEARCH_ACHIEVEMENTADDFOUND = "Procurar por PNJ de conquistas já completadas.",
	SEARCH_ACHIEVEMENTADDFOUND_DESC = "Continua a procurar por todos os PNJs de conquistas, mesmo se você não precisar mais deles.",
	SEARCH_ACHIEVEMENT_DISABLED = "Desabilitado",
	SEARCH_ADD = "+",
	SEARCH_ADD_DESC = "Adiciona um novo PNJ ou salva mudanças em um já existente.",
	SEARCH_ADD_TAMABLE_FORMAT = "Nota: |cff808080“%s”|r é domável, então vê-lo como um ajudante de caçador causará um alarme falso.",
	SEARCH_CACHED = "No cache",
	SEARCH_COMPLETED = "Feito",
	SEARCH_DESC = "Esta tabela permite adicionar ou remover PNJs e conquistas para procurar.",
	SEARCH_ID = "ID do PNJ",
	SEARCH_ID_DESC = "O ID do PNJ para procurar. Este valor pode ser encontrado em sites como Wowhead.com.",
	SEARCH_MAP = "Zona:",
	SEARCH_NAME = "Nome:",
	SEARCH_NAME_DESC = "Um apelido para o PNJ. Não precisa ser igual ao nome do PNJ.",
	SEARCH_NPCS = "PNJs Personalizados",
	SEARCH_NPCS_DESC = "Adicione qualquer PNJ a busca, mesmo se ele não tiver conquistas associadas.",
	SEARCH_REMOVE = "-",
	SEARCH_TITLE = "Procurar",
	SEARCH_WORLD = "Mundo:",
	SEARCH_WORLD_DESC = "Um nome de mundo otimizado para limitar a busca. Pode ser o nome de um continente ou o |cffff7f3finome de uma masmorra|r (diferencia maiúsculas e minúsculas).",
	SEARCH_WORLD_FORMAT = "(%s)",
	TIME_FORMAT = "|cff808080[%H:%M:%S]|r ",
}, { __index = _NPCScan.L; } );


_G[ "BINDING_NAME_CLICK _NPCScanButton:LeftButton" ] = [=[Marca o ultimo PNJ encontrado
|cff808080(Use quando _NPCScan alertar você)|r]=];
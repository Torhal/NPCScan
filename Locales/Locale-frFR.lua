--[[****************************************************************************
  * _NPCScan by Saiket                                                         *
  * Locales/Locale-frFR.lua - Localized string constants (fr-FR).              *
  ****************************************************************************]]


if ( GetLocale() ~= "frFR" ) then
	return;
end


-- See http://wow.curseforge.com/addons/npcscan/localization/frFR/
local _NPCScan = select( 2, ... );
_NPCScan.L = setmetatable( {
	NPCs = setmetatable( {
		[ 18684 ] = "Bro'Gaz Sans-clan",
		[ 32491 ] = "Proto-drake perdu dans le temps",
		[ 33776 ] = "Gondria",
		[ 35189 ] = "Skoll",
		[ 38453 ] = "Arcturis",
		[ 49822 ] = "Jadecroc",
		[ 49913 ] = "Dame LaLa",
		[ 50005 ] = "Poséidus",
		[ 50009 ] = "Mobus",
		[ 50050 ] = "Shok'sharak",
		[ 50051 ] = "Clampant fantôme",
		[ 50052 ] = "Burgy Coeur-noir",
		[ 50053 ] = "Thartuk l'Exilé",
		[ 50056 ] = "Garr",
		[ 50057 ] = "Ailembrase",
		[ 50058 ] = "Terrorpene",
		[ 50059 ] = "Golgarok",
		[ 50060 ] = "Terborus",
		[ 50061 ] = "Xariona",
		[ 50062 ] = "Aeonaxx",
		[ 50063 ] = "Akma'hat",
		[ 50064 ] = "Cyrus le Noir",
		[ 50065 ] = "Armaglyptodon",
		[ 50085 ] = "Suzerain Fractefurie",
		[ 50086 ] = "Tarvus le Vil",
		[ 50089 ] = "Julak-Dram",
		[ 50138 ] = "Karoma",
		[ 50154 ] = "Madexx (brun)",
		[ 50159 ] = "Samba",
		[ 50409 ] = "Figurine de dromadaire mystérieuse",
		[ 50410 ] = "Figurine de dromadaire mystérieuse",
		[ 50815 ] = "Bal'afr",
		[ 50959 ] = "Karkin",
		[ 51071 ] = "Capitaine Florence",
		[ 51079 ] = "Capitaine Souillaile",
		[ 51401 ] = "Madexx (rouge)",
		[ 51402 ] = "Madexx (vert)",
		[ 51403 ] = "Madexx (noir)",
		[ 51404 ] = "Madexx (bleu)",
		[ 54318 ] = "Ankha",
		[ 54319 ] = "Magria",
		[ 54320 ] = "Ban'thalos",
		[ 54321 ] = "Solix",
		[ 54322 ] = "Deth'tilac",
		[ 54323 ] = "Kirix",
		[ 54324 ] = "Rampeflamme",
		[ 54338 ] = "Anthriss",
		[ 62346 ] = "Galion",
	}, { __index = _NPCScan.L.NPCs; } );

	BUTTON_FOUND = "PNJ trouvé !",
	CACHED_FORMAT = "Les unités suivantes sont déjà dans le cache : %s.",
	CACHED_LONG_FORMAT = "Les unités suivantes sont déjà dans le cache. Pensez à les enlever en utilisant le menu |cff808080“/npcscan”|r ou réinitialisez-les en effaçant votre cache : %s.",
	CACHED_PET_RESTING_FORMAT = "Les familiers domptables suivants ont été ajoutés au cache pendant votre repos : %s.",
	CACHED_STABLED_FORMAT = "Les unités suivantes ne peuvent être recherchées tant qu'elles sont domptées : %s.",
	CACHED_WORLD_FORMAT = "Les unités suivantes |2 %2$s sont déjà dans le cache : %1$s.",
	CACHELIST_ENTRY_FORMAT = "|cff808080“%s”|r",
	CACHELIST_SEPARATOR = ", ",
	CMD_ADD = "AJOUTER", -- Needs review
	CMD_CACHE = "CACHE",
	CMD_CACHE_EMPTY = "Aucun des monstres recherchés n'est dans le cache.",
	CMD_HELP = "Les commandes sont |cff808080“/npcscan ajouter <ID-PNJ> <Nom>”|r, |cff808080“/npcscan enlever <ID-PNJ ou Nom>”|r, |cff808080“/npcscan cache”|r pour afficher la liste des monstres en cache, et simplement |cff808080“/npcscan”|r pour le menu des options.", -- Needs review
	CMD_REMOVE = "ENLEVER",
	CMD_REMOVENOTFOUND_FORMAT = "PNJ |cff808080“%s”|r non trouvé.",
	CONFIG_ALERT = "Options d'alerte",
	CONFIG_ALERT_SOUND = "Fichier son d'alerte",
	CONFIG_ALERT_SOUND_DEFAULT = "|cffffd200Défaut|r",
	CONFIG_ALERT_SOUND_DESC = "Choisissez le son d'alerte à jouer quand un PNJ est trouvé. Des sons additionnels peuvent être ajoutés via l'addon |cff808080“SharedMedia”|r.",
	CONFIG_ALERT_UNMUTE = "Enlever la sourdine pour le son d'alerte",
	CONFIG_ALERT_UNMUTE_DESC = "Active les sons du jeu quand le bouton de ciblage est affiché afin que vous puissiez entendre les alertes même si le jeu est mis en sourdine.",
	CONFIG_CACHEWARNINGS = "Me rappeler de vider mon cache à la connexion",
	CONFIG_CACHEWARNINGS_DESC = "Si un PNJ est présent dans le cache quand vous vous connectez à ce personnage, cette option affichera un rappel des monstres en cache que l'addon ne pourra pas rechercher.", -- Needs review
	CONFIG_DESC = "Ces options vous permettent de définir comment _NPCScan vous prévient quand il trouve un PNJ rare.",
	CONFIG_PRINTTIME = "Afficher l'horodatage dans la fenêtre de discussion",
	CONFIG_PRINTTIME_DESC = "Ajoute l'heure actuelle à tous les messages affichés dans la fenêtre de discussion. Utile pour enregistrer quand les PNJs ont été trouvés.",
	CONFIG_TEST = "Test de l'alerte",
	CONFIG_TEST_DESC = "Simule une alerte |cff808080“PNJ trouvé”|r afin que vous puissez voir à quoi cela ressemble.",
	CONFIG_TEST_HELP_FORMAT = "Cliquez sur le cadre d'alerte ou utilisez le raccourci clavier prédéfini pour cibler le monstre trouvé. Maintenez enfoncé |cffffffff<%s>|r et saisissez le cadre d'alerte pour déplacer ce dernier. Notez que si un PNJ est trouvé quand vous êtes en combat, le cadre d'alerte n'apparaitra qu'une fois que vous serez hors combat.",
	CONFIG_TEST_NAME = "Vous ! (Test)",
	CONFIG_TITLE = "_|cffCCCC88NPCScan|r",
	FOUND_FORMAT = "|cff808080“%s”|r trouvé !",
	FOUND_TAMABLE_FORMAT = "|cff808080“%s”|r trouvé ! |cffff2020(Note : monstre domptable, il s'agit peut être d'un familier.)|r",
	FOUND_TAMABLE_WRONGZONE_FORMAT = "|cffff2020Fausse alerte :|r Monstre domptable |cff808080“%s”|r trouvé à %s au lieu |2 %s (ID %d) ; certainement un familier.",
	PRINT_FORMAT = "%s_|cffCCCC88NPCScan|r : %s",
	SEARCH_ACHIEVEMENTADDFOUND = "Rechercher les PNJs déjà réussis dans les hauts faits",
	SEARCH_ACHIEVEMENTADDFOUND_DESC = "Continue à rechercher tous les PNJs des hauts faits, même ceux dont vous n'avez plus besoin.",
	SEARCH_ACHIEVEMENT_DISABLED = "Désactivé",
	SEARCH_ADD = "+",
	SEARCH_ADD_DESC = "Ajoute un nouveau PNJ ou sauvegarde les changements appliqués à un pré-existant.",
	SEARCH_ADD_TAMABLE_FORMAT = "Note : |cff808080“%s”|r est domptable. S'il (elle) est vu(e) en tant que familier de chasseur, cela causera une fausse alerte.",
	SEARCH_CACHED = "En cache",
	SEARCH_COMPLETED = "Fait",
	SEARCH_DESC = "Cette table vous permet d'ajouter ou d'enlever des PNJs et de définir les hauts faits à surveiller.",
	SEARCH_ID = "ID du PNJ :",
	SEARCH_ID_DESC = "L'identifiant du PNJ à rechercher. Cette valeur peut être trouvée sur des sites comme Wowhead.com.",
	SEARCH_MAP = "Zone :",
	SEARCH_NAME = "Nom :",
	SEARCH_NAME_DESC = "Un libellé pour le PNJ. Il ne doit pas forcément correspondre au nom exact du PNJ.",
	SEARCH_NPCS = "PNJs perso.",
	SEARCH_NPCS_DESC = "Ajoute n'importe quel PNJ à la surveillance, même s'il n'est lié à aucun haut fait.",
	SEARCH_REMOVE = "-",
	SEARCH_TITLE = "Recherche",
	SEARCH_WORLD = "Monde :",
	SEARCH_WORLD_DESC = "Un nom de monde optionnel afin de limiter les recherches. Peut être un nom de continent ou |cffff7f3fun nom d'instance|r (sensible à la casse).",
	SEARCH_WORLD_FORMAT = "(%s)",
	TIME_FORMAT = "|cff808080[%H:%M:%S]|r ",
	TOOLS_TITLE = "|cff808080Outils|r",
}, { __index = _NPCScan.L; } );


_G[ "BINDING_NAME_CLICK _NPCScanButton:LeftButton" ] = [=[Cibler dernier monstre trouvé
|cff808080(Utile qd _NPCScan vous alerte)|r]=];
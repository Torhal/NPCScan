-------------------------------------------------------------------------------
-- Localized Lua globals.
-------------------------------------------------------------------------------
local _G = getfenv(0)

-- Functions
local pairs = _G.pairs
local tostring = _G.tostring
local type = _G.type

-- Libraries
local string = _G.string
local table = _G.table


-------------------------------------------------------------------------------
-- AddOn namespace.
-------------------------------------------------------------------------------
local FOLDER_NAME, private = ...
local L = private.L
local ZN = private.ZONE_NAMES

do
	local function TableKeyFormat(input)
		if not input then
			return ""
		end

		return input:upper():gsub(" ", "_"):gsub("'", ""):gsub(":", ""):gsub("-", "_"):gsub("%(", ""):gsub("%)", "")
	end


	local function rpad(input, length)
		return (" "):rep(length - #input)
	end


	local CONTINENT_NAMES = {
		"KALIMDOR",
		"EASTERN_KINGDOMS",
		"OUTLAND",
		"NORTHREND",
		"THE_MAELSTROM",
		"PANDARIA",
	}


	function private.DumpNPCData()
		if not private.TextDump then
			return
		end
		local output = private.TextDump
		local data = private.RareMobData
		local npc_data = {}
		local longest_world = 0
		local longest_map = 0
		local longest_id = 0

		for npc_id, world_id in pairs(data.NPCWorldIDs) do
			npc_data[npc_id] = { world_id = type(world_id) == "number" and ("ZN.%s"):format(CONTINENT_NAMES[world_id]) or ("ZN.%s"):format(TableKeyFormat(world_id)) }
			npc_data[npc_id].is_tamable = false

			if #npc_data[npc_id].world_id > longest_world then
				longest_world = #npc_data[npc_id].world_id
			end

			local id_str = tostring(npc_id)
			if #id_str > longest_id then
				longest_id = #id_str
			end
		end

		for npc_id, zone_id in pairs(private.TamableIDs) do
			npc_data[npc_id] = npc_data[npc_id] or {}
			npc_data[npc_id].is_tamable = true

			local id_str = tostring(npc_id)
			if #id_str > longest_id then
				longest_id = #id_str
			end
		end

		for npc_id, map_name in pairs(data.map_names) do
			if not npc_data[npc_id] then
				npc_data[npc_id] = {}
			end
			npc_data[npc_id].map_name = ("ZN.%s"):format(TableKeyFormat(map_name))

			if #npc_data[npc_id].map_name > longest_map then
				longest_map = #npc_data[npc_id].map_name
			end

			local id_str = tostring(npc_id)
			if #id_str > longest_id then
				longest_id = #id_str
			end
		end
		local npc_output = {}

		for npc_id in pairs(npc_data) do
			npc_output[#npc_output + 1] = npc_id
		end
		table.sort(npc_output)

		output:Clear()
		output:AddLine("local NPC_DATA = {")

		for index = 1, #npc_output do
			local npc_id = npc_output[index]
			local info = npc_data[npc_id]
			output:AddLine(("[%d]%s = { world_id = %s,%s map_name = %s,%s is_tamable = %s%s }, -- %s"):format(npc_id, rpad(tostring(npc_id), longest_id), tostring(info.world_id), rpad(tostring(info.world_id), longest_world), tostring(info.map_name), rpad(tostring(info.map_name), longest_map), tostring(info.is_tamable), rpad(tostring(info.is_tamable), 5), private.L.NPCs[npc_id] or "**** NO LOCALIZATION ****"))
		end

		output:AddLine("}")
		output:Display()
	end
end -- do-block


local NPC_DATA = {
	[61]    = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.ELWYNN_FOREST,               is_tamable = false }, -- Thuros Lightfingers
	[62]    = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.NORTHSHIRE,                  is_tamable = false }, -- Gug Fatcandle
	[79]    = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.ELWYNN_FOREST,               is_tamable = false }, -- Narg the Taskmaster
	[99]    = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.ELWYNN_FOREST,               is_tamable = false }, -- Morgaine the Sly
	[100]   = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.ELWYNN_FOREST,               is_tamable = false }, -- Gruff Swiftbite
	[462]   = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.WESTFALL,                    is_tamable = true  }, -- Vultros
	[471]   = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.ELWYNN_FOREST,               is_tamable = true  }, -- Mother Fang
	[472]   = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.ELWYNN_FOREST,               is_tamable = false }, -- Fedfennel
	[506]   = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.WESTFALL,                    is_tamable = false }, -- Sergeant Brashclaw
	[507]   = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.DUSKWOOD,                    is_tamable = false }, -- Fenros
	[519]   = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.WESTFALL,                    is_tamable = false }, -- Slark
	[520]   = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.WESTFALL,                    is_tamable = false }, -- Brack
	[521]   = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.DUSKWOOD,                    is_tamable = true  }, -- Lupos
	[534]   = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.DUSKWOOD,                    is_tamable = false }, -- Nefaru
	[572]   = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.WESTFALL,                    is_tamable = false }, -- Leprithus
	[573]   = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.WESTFALL,                    is_tamable = false }, -- Foe Reaper 4000
	[574]   = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.DUSKWOOD,                    is_tamable = true  }, -- Naraxis
	[584]   = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.REDRIDGE_MOUNTAINS,          is_tamable = false }, -- Kazon
	[596]   = { world_id = ZN.THE_DEADMINES,            map_name = ZN.THE_DEADMINES,               is_tamable = false }, -- Brainwashed Noble
	[599]   = { world_id = ZN.THE_DEADMINES,            map_name = ZN.THE_DEADMINES,               is_tamable = false }, -- Marisa du'Paige
	[616]   = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.REDRIDGE_MOUNTAINS,          is_tamable = true  }, -- Chatter
	[763]   = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SWAMP_OF_SORROWS,            is_tamable = false }, -- Lost One Chieftain
	[947]   = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.REDRIDGE_MOUNTAINS,          is_tamable = false }, -- Rohh the Silent
	[1063]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SWAMP_OF_SORROWS,            is_tamable = false }, -- Jade
	[1106]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SWAMP_OF_SORROWS,            is_tamable = false }, -- Lost One Cook
	[1112]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.WETLANDS,                    is_tamable = true  }, -- Leech Widow
	[1119]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.DUN_MOROGH,                  is_tamable = false }, -- Hammerspine
	[1130]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.DUN_MOROGH,                  is_tamable = true  }, -- Bjarn
	[1132]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.NEW_TINKERTOWN,              is_tamable = true  }, -- Timber
	[1137]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.DUN_MOROGH,                  is_tamable = false }, -- Edan the Howler
	[1140]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.WETLANDS,                    is_tamable = true  }, -- Razormaw Matriarch
	[1260]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.DUN_MOROGH,                  is_tamable = false }, -- Great Father Arctikus
	[1398]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.LOCH_MODAN,                  is_tamable = false }, -- Boss Galgosh
	[1399]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.LOCH_MODAN,                  is_tamable = false }, -- Magosh
	[1424]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.WESTFALL,                    is_tamable = false }, -- Master Digger
	[1425]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.LOCH_MODAN,                  is_tamable = false }, -- Kubb
	[1531]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.TIRISFAL_GLADES,             is_tamable = false }, -- Lost Soul
	[1533]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.TIRISFAL_GLADES,             is_tamable = false }, -- Tormented Spirit
	[1552]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.THE_CAPE_OF_STRANGLETHORN,   is_tamable = false }, -- Scale Belly
	[1837]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.WESTERN_PLAGUELANDS,         is_tamable = false }, -- Scarlet Judge
	[1838]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.WESTERN_PLAGUELANDS,         is_tamable = false }, -- Scarlet Interrogator
	[1839]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.WESTERN_PLAGUELANDS,         is_tamable = false }, -- Scarlet High Clerist
	[1841]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.WESTERN_PLAGUELANDS,         is_tamable = false }, -- Scarlet Executioner
	[1843]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.EASTERN_PLAGUELANDS,         is_tamable = false }, -- Foreman Jerris
	[1844]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.EASTERN_PLAGUELANDS,         is_tamable = false }, -- Foreman Marcrid
	[1847]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.WESTERN_PLAGUELANDS,         is_tamable = false }, -- Foulmane
	[1848]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.WESTERN_PLAGUELANDS,         is_tamable = false }, -- Lord Maldazzar
	[1849]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.WESTERN_PLAGUELANDS,         is_tamable = false }, -- Dreadwhisper
	[1850]  = { world_id = ZN.SCHOLOMANCE,              map_name = ZN.SCHOLOMANCE,                 is_tamable = false }, -- Putridius
	[1851]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.WESTERN_PLAGUELANDS,         is_tamable = false }, -- The Husk
	[1885]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.WESTERN_PLAGUELANDS,         is_tamable = false }, -- Scarlet Smith
	[1910]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.TIRISFAL_GLADES,             is_tamable = false }, -- Muad
	[1911]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.TIRISFAL_GLADES,             is_tamable = false }, -- Deeb
	[1936]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.TIRISFAL_GLADES,             is_tamable = false }, -- Farmer Solliden
	[2090]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.WETLANDS,                    is_tamable = false }, -- Ma'ruk Wyrmscale
	[2108]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.WETLANDS,                    is_tamable = false }, -- Garneg Charskull
	[2162]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.TELDRASSIL,                  is_tamable = false }, -- Agal
	[2172]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.DARKSHORE,                   is_tamable = true  }, -- Strider Clutchmother
	[2175]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.DARKSHORE,                   is_tamable = true  }, -- Shadowclaw
	[2184]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.DARKSHORE,                   is_tamable = false }, -- Lady Moongazer
	[2186]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.DARKSHORE,                   is_tamable = false }, -- Carnivous the Breaker
	[2191]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.DARKSHORE,                   is_tamable = false }, -- Licillin
	[2192]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.DARKSHORE,                   is_tamable = false }, -- Firecaller Radison
	[2258]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.HILLSBRAD_FOOTHILLS,         is_tamable = false }, -- Maggarrak
	[2452]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.HILLSBRAD_FOOTHILLS,         is_tamable = false }, -- Skhowl
	[2453]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.HILLSBRAD_FOOTHILLS,         is_tamable = false }, -- Lo'Grosh
	[2476]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.LOCH_MODAN,                  is_tamable = true  }, -- Gosh-Haldir
	[2541]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.THE_CAPE_OF_STRANGLETHORN,   is_tamable = false }, -- Lord Sakrasis
	[2598]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.ARATHI_HIGHLANDS,            is_tamable = false }, -- Darbel Montrose
	[2600]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.ARATHI_HIGHLANDS,            is_tamable = false }, -- Singer
	[2601]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.ARATHI_HIGHLANDS,            is_tamable = false }, -- Foulbelly
	[2602]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.ARATHI_HIGHLANDS,            is_tamable = false }, -- Ruul Onestone
	[2603]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.ARATHI_HIGHLANDS,            is_tamable = false }, -- Kovork
	[2604]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.ARATHI_HIGHLANDS,            is_tamable = false }, -- Molok the Crusher
	[2605]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.ARATHI_HIGHLANDS,            is_tamable = false }, -- Zalas Witherbark
	[2606]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.ARATHI_HIGHLANDS,            is_tamable = false }, -- Nimar the Slayer
	[2609]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.ARATHI_HIGHLANDS,            is_tamable = false }, -- Geomancer Flintdagger
	[2744]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BADLANDS,                    is_tamable = false }, -- Shadowforge Commander
	[2749]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BADLANDS,                    is_tamable = false }, -- Barricade
	[2751]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BADLANDS,                    is_tamable = false }, -- War Golem
	[2752]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BADLANDS,                    is_tamable = false }, -- Rumbler
	[2753]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BADLANDS,                    is_tamable = true  }, -- Barnabus
	[2754]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BADLANDS,                    is_tamable = false }, -- Anathemus
	[2779]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.ARATHI_HIGHLANDS,            is_tamable = false }, -- Prince Nazjak
	[2850]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BADLANDS,                    is_tamable = true  }, -- Broken Tooth
	[2931]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BADLANDS,                    is_tamable = true  }, -- Zaricotl
	[3058]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.MULGORE,                     is_tamable = false }, -- Arra'chea
	[3068]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.MULGORE,                     is_tamable = true  }, -- Mazzranache
	[3253]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.SOUTHERN_BARRENS,            is_tamable = true  }, -- Silithid Harvester
	[3270]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.NORTHERN_BARRENS,            is_tamable = false }, -- Elder Mystic Razorsnout
	[3295]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.NORTHERN_BARRENS,            is_tamable = false }, -- Sludge Anomaly
	[3398]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.NORTHERN_BARRENS,            is_tamable = false }, -- Gesharahan
	[3470]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.NORTHERN_BARRENS,            is_tamable = false }, -- Rathorian
	[3535]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.TELDRASSIL,                  is_tamable = false }, -- Blackmoss the Fetid
	[3581]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.STORMWIND_CITY,              is_tamable = true  }, -- Sewer Beast
	[3652]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.NORTHERN_BARRENS,            is_tamable = false }, -- Trigore the Lasher
	[3672]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.NORTHERN_BARRENS,            is_tamable = false }, -- Boahn
	[3735]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.ASHENVALE,                   is_tamable = false }, -- Apothecary Falthis
	[3736]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.ASHENVALE,                   is_tamable = false }, -- Darkslayer Mordenthal
	[3773]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.ASHENVALE,                   is_tamable = false }, -- Akkrilus
	[3792]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.ASHENVALE,                   is_tamable = false }, -- Terrowulf Packlord
	[3872]  = { world_id = ZN.SHADOWFANG_KEEP,          map_name = ZN.SHADOWFANG_KEEP,             is_tamable = false }, -- Deathsworn Captain
	[4066]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.STONETALON_MOUNTAINS,        is_tamable = false }, -- Nal'taszar
	[4132]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.THOUSAND_NEEDLES,            is_tamable = true  }, -- Krkk'kx
	[4339]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.DUSTWALLOW_MARSH,            is_tamable = false }, -- Brimgore
	[4380]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.DUSTWALLOW_MARSH,            is_tamable = true  }, -- Darkmist Widow
	[4425]  = { world_id = ZN.RAZORFEN_KRAUL,           map_name = ZN.RAZORFEN_KRAUL,              is_tamable = true  }, -- Blind Hunter
	[4842]  = { world_id = ZN.RAZORFEN_KRAUL,           map_name = ZN.RAZORFEN_KRAUL,              is_tamable = false }, -- Earthcaller Halmgar
	[5343]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.FERALAS,                     is_tamable = false }, -- Lady Szallah
	[5345]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.FERALAS,                     is_tamable = false }, -- Diamond Head
	[5346]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.FERALAS,                     is_tamable = false }, -- Bloodroar the Stalker
	[5347]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.FERALAS,                     is_tamable = false }, -- Antilus the Soarer
	[5348]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SWAMP_OF_SORROWS,            is_tamable = false }, -- Dreamwatcher Forktongue
	[5349]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.FERALAS,                     is_tamable = true  }, -- Arash-ethis
	[5350]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.FERALAS,                     is_tamable = true  }, -- Qirot
	[5352]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.FERALAS,                     is_tamable = true  }, -- Old Grizzlegut
	[5354]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.FERALAS,                     is_tamable = false }, -- Gnarl Leafbrother
	[5356]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.FERALAS,                     is_tamable = true  }, -- Snarler
	[5785]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.MULGORE,                     is_tamable = false }, -- Sister Hatelash
	[5786]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.MULGORE,                     is_tamable = false }, -- Snagglespear
	[5787]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.MULGORE,                     is_tamable = false }, -- Enforcer Emilgund
	[5807]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.MULGORE,                     is_tamable = true  }, -- The Rake
	[5809]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.DUROTAR,                     is_tamable = false }, -- Sergeant Curtis
	[5822]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.DUROTAR,                     is_tamable = false }, -- Felweaver Scornn
	[5823]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.DUROTAR,                     is_tamable = true  }, -- Death Flayer
	[5824]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.DUROTAR,                     is_tamable = false }, -- Captain Flat Tusk
	[5826]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.DUROTAR,                     is_tamable = false }, -- Geolord Mottle
	[5828]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.NORTHERN_BARRENS,            is_tamable = true  }, -- Humar the Pridelord
	[5829]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.SOUTHERN_BARRENS,            is_tamable = true  }, -- Snort the Heckler
	[5830]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.NORTHERN_BARRENS,            is_tamable = false }, -- Sister Rathtalon
	[5831]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.NORTHERN_BARRENS,            is_tamable = false }, -- Swiftmane
	[5834]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.SOUTHERN_BARRENS,            is_tamable = true  }, -- Azzere the Skyblade
	[5835]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.NORTHERN_BARRENS,            is_tamable = false }, -- Foreman Grills
	[5836]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.NORTHERN_BARRENS,            is_tamable = false }, -- Engineer Whirleygig
	[5837]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.NORTHERN_BARRENS,            is_tamable = false }, -- Stonearm
	[5838]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.NORTHERN_BARRENS,            is_tamable = false }, -- Brokespear
	[5841]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.NORTHERN_BARRENS,            is_tamable = false }, -- Rocklance
	[5842]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.NORTHERN_BARRENS,            is_tamable = true  }, -- Takk the Leaper
	[5847]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.SOUTHERN_BARRENS,            is_tamable = false }, -- Heggin Stonewhisker
	[5848]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.SOUTHERN_BARRENS,            is_tamable = false }, -- Malgin Barleybrew
	[5849]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.SOUTHERN_BARRENS,            is_tamable = false }, -- Digger Flameforge
	[5851]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.SOUTHERN_BARRENS,            is_tamable = false }, -- Captain Gerogg Hammertoe
	[5859]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.SOUTHERN_BARRENS,            is_tamable = false }, -- Hagg Taurenbane
	[5863]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.SOUTHERN_BARRENS,            is_tamable = false }, -- Geopriest Gukk'rok
	[5864]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.SOUTHERN_BARRENS,            is_tamable = false }, -- Swinegart Spearhide
	[5865]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.NORTHERN_BARRENS,            is_tamable = true  }, -- Dishu
	[5912]  = { world_id = ZN.WAILING_CAVERNS,          map_name = ZN.WAILING_CAVERNS,             is_tamable = false }, -- Deviate Faerie Dragon
	[5915]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.STONETALON_MOUNTAINS,        is_tamable = false }, -- Brother Ravenoak
	[5928]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.STONETALON_MOUNTAINS,        is_tamable = false }, -- Sorrow Wing
	[5930]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.STONETALON_MOUNTAINS,        is_tamable = false }, -- Sister Riven
	[5932]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.STONETALON_MOUNTAINS,        is_tamable = false }, -- Taskmaster Whipfang
	[5933]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.THOUSAND_NEEDLES,            is_tamable = false }, -- Achellios the Banished
	[5935]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.THOUSAND_NEEDLES,            is_tamable = false }, -- Ironeye the Invincible
	[5937]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.THOUSAND_NEEDLES,            is_tamable = true  }, -- Vile Sting
	[6118]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.AZSHARA,                     is_tamable = false }, -- Varo'then's Ghost
	[6228]  = { world_id = ZN.GNOMEREGAN,               map_name = ZN.GNOMEREGAN,                  is_tamable = false }, -- Dark Iron Ambassador
	[6581]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.UNGORO_CRATER,               is_tamable = true  }, -- Ravasaur Matriarch
	[6582]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.UNGORO_CRATER,               is_tamable = true  }, -- Clutchmother Zavas
	[6583]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.UNGORO_CRATER,               is_tamable = false }, -- Gruff
	[6584]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.UNGORO_CRATER,               is_tamable = true  }, -- King Mosh
	[6585]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.UNGORO_CRATER,               is_tamable = true  }, -- Uhk'loc
	[6648]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.AZSHARA,                     is_tamable = false }, -- Antilos
	[6649]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.AZSHARA,                     is_tamable = false }, -- Lady Sesspira
	[6650]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.AZSHARA,                     is_tamable = false }, -- General Fangferror
	[6651]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.AZSHARA,                     is_tamable = false }, -- Gatekeeper Rageroar
	[7015]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.DARKSHORE,                   is_tamable = false }, -- Flagglemurk the Cruel
	[7016]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.DARKSHORE,                   is_tamable = false }, -- Lady Vespira
	[7017]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.DARKSHORE,                   is_tamable = false }, -- Lord Sinslayer
	[7104]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.FELWOOD,                     is_tamable = false }, -- Dessecus
	[7137]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.FELWOOD,                     is_tamable = false }, -- Immolatus
	[7846]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BLASTED_LANDS,               is_tamable = false }, -- Teremus the Devourer
	[8199]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.TANARIS,                     is_tamable = false }, -- Warleader Krazzilak
	[8200]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.TANARIS,                     is_tamable = false }, -- Jin'Zallah the Sandbringer
	[8201]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.TANARIS,                     is_tamable = false }, -- Omgorn the Lost
	[8203]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.TANARIS,                     is_tamable = false }, -- Kregg Keelhaul
	[8204]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.TANARIS,                     is_tamable = true  }, -- Soriid the Devourer
	[8205]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.TANARIS,                     is_tamable = true  }, -- Haarka the Ravenous
	[8207]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.TANARIS,                     is_tamable = true  }, -- Emberwing
	[8208]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.TANARIS,                     is_tamable = true  }, -- Murderous Blisterpaw
	[8210]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.THE_HINTERLANDS,             is_tamable = false }, -- Razortalon
	[8211]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.THE_HINTERLANDS,             is_tamable = true  }, -- Old Cliff Jumper
	[8212]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.THE_HINTERLANDS,             is_tamable = false }, -- The Reak
	[8213]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.THE_HINTERLANDS,             is_tamable = true  }, -- Ironback
	[8214]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.THE_HINTERLANDS,             is_tamable = false }, -- Jalinde Summerdrake
	[8215]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.THE_HINTERLANDS,             is_tamable = false }, -- Grimungous
	[8216]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.THE_HINTERLANDS,             is_tamable = false }, -- Retherokk the Berserker
	[8217]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.THE_HINTERLANDS,             is_tamable = false }, -- Mith'rethis the Enchanter
	[8218]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.THE_HINTERLANDS,             is_tamable = false }, -- Witherheart the Stalker
	[8219]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.THE_HINTERLANDS,             is_tamable = false }, -- Zul'arek Hatefowler
	[8277]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SEARING_GORGE,               is_tamable = true  }, -- Rekk'tilac
	[8278]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SEARING_GORGE,               is_tamable = false }, -- Smoldar
	[8279]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SEARING_GORGE,               is_tamable = false }, -- Faulty War Golem
	[8280]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SEARING_GORGE,               is_tamable = false }, -- Shleipnarr
	[8281]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SEARING_GORGE,               is_tamable = false }, -- Scald
	[8282]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SEARING_GORGE,               is_tamable = false }, -- Highlord Mastrogonde
	[8283]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SEARING_GORGE,               is_tamable = false }, -- Slave Master Blackheart
	[8296]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BLASTED_LANDS,               is_tamable = false }, -- Mojo the Twisted
	[8297]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BLASTED_LANDS,               is_tamable = false }, -- Magronos the Unyielding
	[8298]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BLASTED_LANDS,               is_tamable = false }, -- Akubar the Seer
	[8299]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BLASTED_LANDS,               is_tamable = true  }, -- Spiteflayer
	[8300]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BLASTED_LANDS,               is_tamable = true  }, -- Ravage
	[8301]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BLASTED_LANDS,               is_tamable = true  }, -- Clack the Reaver
	[8302]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BLASTED_LANDS,               is_tamable = false }, -- Deatheye
	[8303]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BLASTED_LANDS,               is_tamable = true  }, -- Grunter
	[8304]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BLASTED_LANDS,               is_tamable = false }, -- Dreadscorn
	[8503]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.NEW_TINKERTOWN,              is_tamable = false }, -- Gibblewilt
	[8660]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.AZSHARA,                     is_tamable = true  }, -- The Evalcharr
	[8923]  = { world_id = ZN.BLACKROCK_DEPTHS,         map_name = ZN.BLACKROCK_DEPTHS,            is_tamable = false }, -- Panzor the Invincible
	[8976]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BURNING_STEPPES,             is_tamable = false }, -- Hematos
	[8978]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BURNING_STEPPES,             is_tamable = false }, -- Thauris Balgarr
	[8979]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BURNING_STEPPES,             is_tamable = false }, -- Gruklash
	[8981]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BURNING_STEPPES,             is_tamable = false }, -- Malfunctioning Reaver
	[9217]  = { world_id = ZN.BLACKROCK_SPIRE,          map_name = ZN.BLACKROCK_SPIRE,             is_tamable = false }, -- Spirestone Lord Magus
	[9218]  = { world_id = ZN.BLACKROCK_SPIRE,          map_name = ZN.BLACKROCK_SPIRE,             is_tamable = false }, -- Spirestone Battle Lord
	[9219]  = { world_id = ZN.BLACKROCK_SPIRE,          map_name = ZN.BLACKROCK_SPIRE,             is_tamable = false }, -- Spirestone Butcher
	[9596]  = { world_id = ZN.BLACKROCK_SPIRE,          map_name = ZN.BLACKROCK_SPIRE,             is_tamable = false }, -- Bannok Grimaxe
	[9602]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BURNING_STEPPES,             is_tamable = false }, -- Hahk'Zor
	[9604]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BURNING_STEPPES,             is_tamable = false }, -- Gorgon'och
	[9718]  = { world_id = ZN.BLACKROCK_SPIRE,          map_name = ZN.BLACKROCK_SPIRE,             is_tamable = false }, -- Ghok Bashguud
	[9736]  = { world_id = ZN.BLACKROCK_SPIRE,          map_name = ZN.BLACKROCK_SPIRE,             is_tamable = false }, -- Quartermaster Zigris
	[10077] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BURNING_STEPPES,             is_tamable = true  }, -- Deathmaw
	[10078] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BURNING_STEPPES,             is_tamable = false }, -- Terrorspark
	[10080] = { world_id = ZN.ZULFARRAK,                map_name = ZN.ZULFARRAK,                   is_tamable = false }, -- Sandarr Dunereaver
	[10081] = { world_id = ZN.ZULFARRAK,                map_name = ZN.ZULFARRAK,                   is_tamable = false }, -- Dustwraith
	[10082] = { world_id = ZN.ZULFARRAK,                map_name = ZN.ZULFARRAK,                   is_tamable = false }, -- Zerillis
	[10119] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BURNING_STEPPES,             is_tamable = false }, -- Volchan
	[10196] = { world_id = ZN.KALIMDOR,                 map_name = ZN.WINTERSPRING,                is_tamable = false }, -- General Colbatann
	[10197] = { world_id = ZN.KALIMDOR,                 map_name = ZN.WINTERSPRING,                is_tamable = false }, -- Mezzir the Howler
	[10198] = { world_id = ZN.KALIMDOR,                 map_name = ZN.WINTERSPRING,                is_tamable = false }, -- Kashoch the Reaver
	[10199] = { world_id = ZN.KALIMDOR,                 map_name = ZN.WINTERSPRING,                is_tamable = false }, -- Grizzle Snowpaw
	[10200] = { world_id = ZN.KALIMDOR,                 map_name = ZN.WINTERSPRING,                is_tamable = true  }, -- Rak'shiri
	[10202] = { world_id = ZN.KALIMDOR,                 map_name = ZN.WINTERSPRING,                is_tamable = false }, -- Azurous
	[10263] = { world_id = ZN.BLACKROCK_SPIRE,          map_name = ZN.BLACKROCK_SPIRE,             is_tamable = false }, -- Burning Felguard
	[10356] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.TIRISFAL_GLADES,             is_tamable = true  }, -- Bayne
	[10357] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.TIRISFAL_GLADES,             is_tamable = true  }, -- Ressan the Needler
	[10358] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.TIRISFAL_GLADES,             is_tamable = false }, -- Fellicent's Shade
	[10359] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.TIRISFAL_GLADES,             is_tamable = true  }, -- Sri'skulk
	[10376] = { world_id = ZN.BLACKROCK_SPIRE,          map_name = ZN.BLACKROCK_SPIRE,             is_tamable = true  }, -- Crystal Fang
	[10393] = { world_id = ZN.STRATHOLME,               map_name = ZN.STRATHOLME,                  is_tamable = false }, -- Skul
	[10509] = { world_id = ZN.BLACKROCK_SPIRE,          map_name = ZN.BLACKROCK_SPIRE,             is_tamable = false }, -- Jed Runewatcher
	[10558] = { world_id = ZN.STRATHOLME,               map_name = ZN.STRATHOLME,                  is_tamable = false }, -- Hearthsinger Forresten
	[10559] = { world_id = ZN.KALIMDOR,                 map_name = ZN.ASHENVALE,                   is_tamable = false }, -- Lady Vespia
	[10639] = { world_id = ZN.KALIMDOR,                 map_name = ZN.ASHENVALE,                   is_tamable = false }, -- Rorgish Jowl
	[10640] = { world_id = ZN.KALIMDOR,                 map_name = ZN.ASHENVALE,                   is_tamable = false }, -- Oakpaw
	[10641] = { world_id = ZN.KALIMDOR,                 map_name = ZN.ASHENVALE,                   is_tamable = false }, -- Branch Snapper
	[10642] = { world_id = ZN.KALIMDOR,                 map_name = ZN.ASHENVALE,                   is_tamable = false }, -- Eck'alom
	[10644] = { world_id = ZN.KALIMDOR,                 map_name = ZN.ASHENVALE,                   is_tamable = true  }, -- Mist Howler
	[10647] = { world_id = ZN.KALIMDOR,                 map_name = ZN.ASHENVALE,                   is_tamable = false }, -- Prince Raze
	[10741] = { world_id = ZN.KALIMDOR,                 map_name = ZN.WINTERSPRING,                is_tamable = true  }, -- Sian-Rotam
	[10809] = { world_id = ZN.STRATHOLME,               map_name = ZN.STRATHOLME,                  is_tamable = false }, -- Stonespine
	[10817] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.EASTERN_PLAGUELANDS,         is_tamable = false }, -- Duggan Wildhammer
	[10818] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.EASTERN_PLAGUELANDS,         is_tamable = false }, -- Death Knight Soulbearer
	[10819] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.EASTERN_PLAGUELANDS,         is_tamable = false }, -- Baron Bloodbane
	[10820] = { world_id = ZN.STRATHOLME,               map_name = ZN.STRATHOLME,                  is_tamable = false }, -- Duke Ragereaver
	[10821] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.EASTERN_PLAGUELANDS,         is_tamable = false }, -- Hed'mush the Rotting
	[10823] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.EASTERN_PLAGUELANDS,         is_tamable = false }, -- Zul'Brin Warpbranch
	[10824] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.EASTERN_PLAGUELANDS,         is_tamable = false }, -- Death-Hunter Hawkspear
	[10825] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.EASTERN_PLAGUELANDS,         is_tamable = false }, -- Gish the Unmoving
	[10826] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.EASTERN_PLAGUELANDS,         is_tamable = false }, -- Lord Darkscythe
	[10827] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.EASTERN_PLAGUELANDS,         is_tamable = false }, -- Deathspeaker Selendre
	[10828] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.EASTERN_PLAGUELANDS,         is_tamable = false }, -- Lynnia Abbendis
	[11383] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.NORTHERN_STRANGLETHORN,      is_tamable = false }, -- High Priestess Hai'watna
	[11447] = { world_id = ZN.KALIMDOR,                 map_name = ZN.FERALAS,                     is_tamable = false }, -- Mushgog
	[11467] = { world_id = ZN.DIRE_MAUL,                map_name = ZN.DIRE_MAUL,                   is_tamable = false }, -- Tsu'zee
	[11497] = { world_id = ZN.KALIMDOR,                 map_name = ZN.FERALAS,                     is_tamable = true  }, -- The Razza
	[11498] = { world_id = ZN.KALIMDOR,                 map_name = ZN.FERALAS,                     is_tamable = false }, -- Skarr the Broken
	[11688] = { world_id = ZN.KALIMDOR,                 map_name = ZN.DESOLACE,                    is_tamable = false }, -- Cursed Centaur
	[12037] = { world_id = ZN.KALIMDOR,                 map_name = ZN.ASHENVALE,                   is_tamable = true  }, -- Ursol'lok
	[12237] = { world_id = ZN.MARAUDON,                 map_name = ZN.MARAUDON,                    is_tamable = false }, -- Meshlok the Harvester
	[12431] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SILVERPINE_FOREST,           is_tamable = true  }, -- Gorefang
	[12433] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SILVERPINE_FOREST,           is_tamable = true  }, -- Krethis the Shadowspinner
	[12902] = { world_id = ZN.BLACKFATHOM_DEEPS,        map_name = ZN.BLACKFATHOM_DEEPS,           is_tamable = false }, -- Lorgus Jett
	[13896] = { world_id = ZN.KALIMDOR,                 map_name = ZN.AZSHARA,                     is_tamable = false }, -- Scalebeard
	[14221] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.HILLSBRAD_FOOTHILLS,         is_tamable = false }, -- Gravis Slipknot
	[14222] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.HILLSBRAD_FOOTHILLS,         is_tamable = true  }, -- Araga
	[14223] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.HILLSBRAD_FOOTHILLS,         is_tamable = true  }, -- Cranky Benj
	[14224] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BADLANDS,                    is_tamable = false }, -- 7:XT
	[14225] = { world_id = ZN.KALIMDOR,                 map_name = ZN.DESOLACE,                    is_tamable = false }, -- Prince Kellen
	[14226] = { world_id = ZN.KALIMDOR,                 map_name = ZN.DESOLACE,                    is_tamable = false }, -- Kaskk
	[14227] = { world_id = ZN.KALIMDOR,                 map_name = ZN.DESOLACE,                    is_tamable = false }, -- Hissperak
	[14228] = { world_id = ZN.KALIMDOR,                 map_name = ZN.DESOLACE,                    is_tamable = true  }, -- Giggler
	[14229] = { world_id = ZN.KALIMDOR,                 map_name = ZN.DESOLACE,                    is_tamable = false }, -- Accursed Slitherblade
	[14230] = { world_id = ZN.KALIMDOR,                 map_name = ZN.DUSTWALLOW_MARSH,            is_tamable = false }, -- Burgle Eye
	[14231] = { world_id = ZN.KALIMDOR,                 map_name = ZN.DUSTWALLOW_MARSH,            is_tamable = false }, -- Drogoth the Roamer
	[14232] = { world_id = ZN.KALIMDOR,                 map_name = ZN.DUSTWALLOW_MARSH,            is_tamable = true  }, -- Dart
	[14233] = { world_id = ZN.KALIMDOR,                 map_name = ZN.DUSTWALLOW_MARSH,            is_tamable = true  }, -- Ripscale
	[14234] = { world_id = ZN.KALIMDOR,                 map_name = ZN.DUSTWALLOW_MARSH,            is_tamable = true  }, -- Hayoc
	[14235] = { world_id = ZN.KALIMDOR,                 map_name = ZN.DUSTWALLOW_MARSH,            is_tamable = false }, -- The Rot
	[14236] = { world_id = ZN.KALIMDOR,                 map_name = ZN.DUSTWALLOW_MARSH,            is_tamable = false }, -- Lord Angler
	[14237] = { world_id = ZN.KALIMDOR,                 map_name = ZN.DUSTWALLOW_MARSH,            is_tamable = true  }, -- Oozeworm
	[14266] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.LOCH_MODAN,                  is_tamable = true  }, -- Shanda the Spinner
	[14267] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.LOCH_MODAN,                  is_tamable = false }, -- Emogg the Crusher
	[14268] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.LOCH_MODAN,                  is_tamable = true  }, -- Lord Condar
	[14269] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.REDRIDGE_MOUNTAINS,          is_tamable = false }, -- Seeker Aqualon
	[14270] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.REDRIDGE_MOUNTAINS,          is_tamable = false }, -- Squiddic
	[14271] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.REDRIDGE_MOUNTAINS,          is_tamable = false }, -- Ribchaser
	[14272] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.REDRIDGE_MOUNTAINS,          is_tamable = false }, -- Snarlflare
	[14273] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.REDRIDGE_MOUNTAINS,          is_tamable = false }, -- Boulderheart
	[14275] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.HILLSBRAD_FOOTHILLS,         is_tamable = false }, -- Tamra Stormpike
	[14276] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.HILLSBRAD_FOOTHILLS,         is_tamable = false }, -- Scargil
	[14277] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.HILLSBRAD_FOOTHILLS,         is_tamable = false }, -- Lady Zephris
	[14278] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.HILLSBRAD_FOOTHILLS,         is_tamable = false }, -- Ro'Bark
	[14279] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.HILLSBRAD_FOOTHILLS,         is_tamable = true  }, -- Creepthess
	[14280] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.HILLSBRAD_FOOTHILLS,         is_tamable = true  }, -- Big Samras
	[14281] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.HILLSBRAD_FOOTHILLS,         is_tamable = false }, -- Jimmy the Bleeder
	[14339] = { world_id = ZN.KALIMDOR,                 map_name = ZN.FELWOOD,                     is_tamable = true  }, -- Death Howl
	[14340] = { world_id = ZN.KALIMDOR,                 map_name = ZN.FELWOOD,                     is_tamable = false }, -- Alshirr Banebreath
	[14342] = { world_id = ZN.KALIMDOR,                 map_name = ZN.FELWOOD,                     is_tamable = false }, -- Ragepaw
	[14343] = { world_id = ZN.KALIMDOR,                 map_name = ZN.FELWOOD,                     is_tamable = true  }, -- Olm the Wise
	[14344] = { world_id = ZN.KALIMDOR,                 map_name = ZN.FELWOOD,                     is_tamable = true  }, -- Mongress
	[14345] = { world_id = ZN.KALIMDOR,                 map_name = ZN.FELWOOD,                     is_tamable = false }, -- The Ongar
	[14424] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.WETLANDS,                    is_tamable = false }, -- Mirelow
	[14425] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.WETLANDS,                    is_tamable = false }, -- Gnawbone
	[14426] = { world_id = ZN.KALIMDOR,                 map_name = ZN.THOUSAND_NEEDLES,            is_tamable = false }, -- Harb Foulmountain
	[14427] = { world_id = ZN.KALIMDOR,                 map_name = ZN.THOUSAND_NEEDLES,            is_tamable = false }, -- Gibblesnik
	[14428] = { world_id = ZN.KALIMDOR,                 map_name = ZN.TELDRASSIL,                  is_tamable = false }, -- Uruson
	[14429] = { world_id = ZN.KALIMDOR,                 map_name = ZN.TELDRASSIL,                  is_tamable = false }, -- Grimmaw
	[14430] = { world_id = ZN.KALIMDOR,                 map_name = ZN.TELDRASSIL,                  is_tamable = true  }, -- Duskstalker
	[14431] = { world_id = ZN.KALIMDOR,                 map_name = ZN.TELDRASSIL,                  is_tamable = false }, -- Fury Shelda
	[14432] = { world_id = ZN.KALIMDOR,                 map_name = ZN.TELDRASSIL,                  is_tamable = false }, -- Threggil
	[14433] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.WETLANDS,                    is_tamable = false }, -- Sludginn
	[14445] = { world_id = ZN.THE_TEMPLE_OF_ATALHAKKAR, map_name = ZN.THE_TEMPLE_OF_ATALHAKKAR,    is_tamable = false }, -- Captain Wyrmak
	[14446] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SWAMP_OF_SORROWS,            is_tamable = false }, -- Fingat
	[14447] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SWAMP_OF_SORROWS,            is_tamable = false }, -- Gilmorian
	[14448] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SWAMP_OF_SORROWS,            is_tamable = false }, -- Molt Thorn
	[14471] = { world_id = ZN.KALIMDOR,                 map_name = ZN.SILITHUS,                    is_tamable = false }, -- Setis
	[14472] = { world_id = ZN.KALIMDOR,                 map_name = ZN.SILITHUS,                    is_tamable = true  }, -- Gretheer
	[14473] = { world_id = ZN.KALIMDOR,                 map_name = ZN.SILITHUS,                    is_tamable = true  }, -- Lapress
	[14474] = { world_id = ZN.KALIMDOR,                 map_name = ZN.SILITHUS,                    is_tamable = true  }, -- Zora
	[14475] = { world_id = ZN.KALIMDOR,                 map_name = ZN.SILITHUS,                    is_tamable = true  }, -- Rex Ashil
	[14476] = { world_id = ZN.KALIMDOR,                 map_name = ZN.SILITHUS,                    is_tamable = true  }, -- Krellack
	[14477] = { world_id = ZN.KALIMDOR,                 map_name = ZN.SILITHUS,                    is_tamable = true  }, -- Grubthor
	[14478] = { world_id = ZN.KALIMDOR,                 map_name = ZN.SILITHUS,                    is_tamable = false }, -- Huricanian
	[14479] = { world_id = ZN.KALIMDOR,                 map_name = ZN.SILITHUS,                    is_tamable = false }, -- Twilight Lord Everun
	[14487] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.NORTHERN_STRANGLETHORN,      is_tamable = false }, -- Gluggl
	[14488] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.NORTHERN_STRANGLETHORN,      is_tamable = false }, -- Roloch
	[14490] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.THE_CAPE_OF_STRANGLETHORN,   is_tamable = false }, -- Rippa
	[14491] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.THE_CAPE_OF_STRANGLETHORN,   is_tamable = true  }, -- Kurmokk
	[14492] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.THE_CAPE_OF_STRANGLETHORN,   is_tamable = false }, -- Verifonix
	[16179] = { world_id = ZN.KARAZHAN,                 map_name = ZN.KARAZHAN,                    is_tamable = false }, -- Hyakiss the Lurker
	[16180] = { world_id = ZN.KARAZHAN,                 map_name = ZN.KARAZHAN,                    is_tamable = true  }, -- Shadikith the Glider
	[16181] = { world_id = ZN.KARAZHAN,                 map_name = ZN.KARAZHAN,                    is_tamable = true  }, -- Rokad the Ravager
	[16184] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.EASTERN_PLAGUELANDS,         is_tamable = false }, -- Nerubian Overseer
	[16854] = { world_id = ZN.OUTLAND,                  map_name = ZN.EVERSONG_WOODS,              is_tamable = false }, -- Eldinarcus
	[16855] = { world_id = ZN.OUTLAND,                  map_name = ZN.EVERSONG_WOODS,              is_tamable = false }, -- Tregla
	[17144] = { world_id = ZN.OUTLAND,                  map_name = ZN.NAGRAND,                     is_tamable = true  }, -- Goretooth
	[18241] = { world_id = ZN.KALIMDOR,                 map_name = ZN.DESOLACE,                    is_tamable = true  }, -- Crusty
	[18677] = { world_id = ZN.OUTLAND,                  map_name = ZN.HELLFIRE_PENINSULA,          is_tamable = false }, -- Mekthorg the Wild
	[18678] = { world_id = ZN.OUTLAND,                  map_name = ZN.HELLFIRE_PENINSULA,          is_tamable = false }, -- Fulgorge
	[18679] = { world_id = ZN.OUTLAND,                  map_name = ZN.HELLFIRE_PENINSULA,          is_tamable = false }, -- Vorakem Doomspeaker
	[18680] = { world_id = ZN.OUTLAND,                  map_name = ZN.ZANGARMARSH,                 is_tamable = true  }, -- Marticar
	[18681] = { world_id = ZN.OUTLAND,                  map_name = ZN.ZANGARMARSH,                 is_tamable = false }, -- Coilfang Emissary
	[18682] = { world_id = ZN.OUTLAND,                  map_name = ZN.ZANGARMARSH,                 is_tamable = false }, -- Bog Lurker
	[18683] = { world_id = ZN.OUTLAND,                  map_name = ZN.NAGRAND,                     is_tamable = false }, -- Voidhunter Yar
	[18684] = { world_id = ZN.OUTLAND,                  map_name = ZN.NAGRAND,                     is_tamable = false }, -- Bro'Gaz the Clanless
	[18685] = { world_id = ZN.OUTLAND,                  map_name = ZN.TEROKKAR_FOREST,             is_tamable = false }, -- Okrek
	[18686] = { world_id = ZN.OUTLAND,                  map_name = ZN.TEROKKAR_FOREST,             is_tamable = false }, -- Doomsayer Jurim
	[18689] = { world_id = ZN.OUTLAND,                  map_name = ZN.TEROKKAR_FOREST,             is_tamable = false }, -- Crippler
	[18690] = { world_id = ZN.OUTLAND,                  map_name = ZN.BLADES_EDGE_MOUNTAINS,       is_tamable = false }, -- Morcrush
	[18692] = { world_id = ZN.OUTLAND,                  map_name = ZN.BLADES_EDGE_MOUNTAINS,       is_tamable = false }, -- Hemathion
	[18693] = { world_id = ZN.OUTLAND,                  map_name = ZN.BLADES_EDGE_MOUNTAINS,       is_tamable = false }, -- Speaker Mar'grom
	[18694] = { world_id = ZN.OUTLAND,                  map_name = ZN.SHADOWMOON_VALLEY,           is_tamable = false }, -- Collidus the Warp-Watcher
	[18695] = { world_id = ZN.OUTLAND,                  map_name = ZN.SHADOWMOON_VALLEY,           is_tamable = false }, -- Ambassador Jerrikar
	[18696] = { world_id = ZN.OUTLAND,                  map_name = ZN.SHADOWMOON_VALLEY,           is_tamable = false }, -- Kraator
	[18697] = { world_id = ZN.OUTLAND,                  map_name = ZN.NETHERSTORM,                 is_tamable = false }, -- Chief Engineer Lorthander
	[18698] = { world_id = ZN.OUTLAND,                  map_name = ZN.NETHERSTORM,                 is_tamable = false }, -- Ever-Core the Punisher
	[20932] = { world_id = ZN.OUTLAND,                  map_name = ZN.NETHERSTORM,                 is_tamable = true  }, -- Nuramoc
	[21724] = { world_id = ZN.OUTLAND,                  map_name = ZN.TEROKKAR_FOREST,             is_tamable = true  }, -- Hawkbane
	[22060] = { world_id = ZN.OUTLAND,                  map_name = ZN.BLOODMYST_ISLE,              is_tamable = false }, -- Fenissa the Assassin
	[22062] = { world_id = ZN.OUTLAND,                  map_name = ZN.GHOSTLANDS,                  is_tamable = false }, -- Dr. Whitherlimb
	[32357] = { world_id = ZN.NORTHREND,                map_name = ZN.BOREAN_TUNDRA,               is_tamable = false }, -- Old Crystalbark
	[32358] = { world_id = ZN.NORTHREND,                map_name = ZN.BOREAN_TUNDRA,               is_tamable = false }, -- Fumblub Gearwind
	[32361] = { world_id = ZN.NORTHREND,                map_name = ZN.BOREAN_TUNDRA,               is_tamable = true  }, -- Icehorn
	[32377] = { world_id = ZN.NORTHREND,                map_name = ZN.HOWLING_FJORD,               is_tamable = false }, -- Perobas the Bloodthirster
	[32386] = { world_id = ZN.NORTHREND,                map_name = ZN.HOWLING_FJORD,               is_tamable = false }, -- Vigdis the War Maiden
	[32398] = { world_id = ZN.NORTHREND,                map_name = ZN.HOWLING_FJORD,               is_tamable = false }, -- King Ping
	[32400] = { world_id = ZN.NORTHREND,                map_name = ZN.DRAGONBLIGHT,                is_tamable = false }, -- Tukemuth
	[32409] = { world_id = ZN.NORTHREND,                map_name = ZN.DRAGONBLIGHT,                is_tamable = false }, -- Crazed Indu'le Survivor
	[32417] = { world_id = ZN.NORTHREND,                map_name = ZN.DRAGONBLIGHT,                is_tamable = false }, -- Scarlet Highlord Daion
	[32422] = { world_id = ZN.NORTHREND,                map_name = ZN.GRIZZLY_HILLS,               is_tamable = false }, -- Grocklar
	[32429] = { world_id = ZN.NORTHREND,                map_name = ZN.GRIZZLY_HILLS,               is_tamable = false }, -- Seething Hate
	[32438] = { world_id = ZN.NORTHREND,                map_name = ZN.GRIZZLY_HILLS,               is_tamable = false }, -- Syreian the Bonecarver
	[32447] = { world_id = ZN.NORTHREND,                map_name = ZN.ZULDRAK,                     is_tamable = false }, -- Zul'drak Sentinel
	[32471] = { world_id = ZN.NORTHREND,                map_name = ZN.ZULDRAK,                     is_tamable = false }, -- Griegen
	[32475] = { world_id = ZN.NORTHREND,                map_name = ZN.ZULDRAK,                     is_tamable = true  }, -- Terror Spinner
	[32481] = { world_id = ZN.NORTHREND,                map_name = ZN.SHOLAZAR_BASIN,              is_tamable = true  }, -- Aotona
	[32485] = { world_id = ZN.NORTHREND,                map_name = ZN.SHOLAZAR_BASIN,              is_tamable = true  }, -- King Krush
	[32487] = { world_id = ZN.NORTHREND,                map_name = ZN.ICECROWN,                    is_tamable = false }, -- Putridus the Ancient
	[32491] = { world_id = ZN.NORTHREND,                map_name = ZN.THE_STORM_PEAKS,             is_tamable = false }, -- Time-Lost Proto-Drake
	[32495] = { world_id = ZN.NORTHREND,                map_name = ZN.ICECROWN,                    is_tamable = false }, -- Hildana Deathstealer
	[32500] = { world_id = ZN.NORTHREND,                map_name = ZN.THE_STORM_PEAKS,             is_tamable = false }, -- Dirkee
	[32501] = { world_id = ZN.NORTHREND,                map_name = ZN.ICECROWN,                    is_tamable = false }, -- High Thane Jorfus
	[32517] = { world_id = ZN.NORTHREND,                map_name = ZN.SHOLAZAR_BASIN,              is_tamable = true  }, -- Loque'nahak
	[32630] = { world_id = ZN.NORTHREND,                map_name = ZN.THE_STORM_PEAKS,             is_tamable = false }, -- Vyragosa
	[33776] = { world_id = ZN.NORTHREND,                map_name = ZN.ZULDRAK,                     is_tamable = true  }, -- Gondria
	[35189] = { world_id = ZN.NORTHREND,                map_name = ZN.THE_STORM_PEAKS,             is_tamable = true  }, -- Skoll
	[38453] = { world_id = ZN.NORTHREND,                map_name = ZN.GRIZZLY_HILLS,               is_tamable = true  }, -- Arcturis
	[39183] = { world_id = ZN.KALIMDOR,                 map_name = ZN.TANARIS,                     is_tamable = true  }, -- Scorpitar
	[39185] = { world_id = ZN.KALIMDOR,                 map_name = ZN.TANARIS,                     is_tamable = true  }, -- Slaverjaw
	[39186] = { world_id = ZN.KALIMDOR,                 map_name = ZN.TANARIS,                     is_tamable = false }, -- Hellgazer
	[43488] = { world_id = ZN.KALIMDOR,                 map_name = ZN.FERALAS,                     is_tamable = false }, -- Mordei the Earthrender
	[43613] = { world_id = ZN.KALIMDOR,                 map_name = ZN.MULGORE,                     is_tamable = false }, -- Doomsayer Wiserunner
	[43720] = { world_id = ZN.KALIMDOR,                 map_name = ZN.CAMP_NARACHE,                is_tamable = false }, -- "Pokey" Thornmantle
	[44224] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.WETLANDS,                    is_tamable = false }, -- Two-Toes
	[44225] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.WETLANDS,                    is_tamable = false }, -- Rufus Darkshot
	[44226] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.WETLANDS,                    is_tamable = false }, -- Sarltooth
	[44227] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.WETLANDS,                    is_tamable = false }, -- Gazz the Loch-Hunter
	[44714] = { world_id = ZN.KALIMDOR,                 map_name = ZN.TANARIS,                     is_tamable = false }, -- Fronkle the Disturbed
	[44722] = { world_id = ZN.KALIMDOR,                 map_name = ZN.TANARIS,                     is_tamable = false }, -- Twisted Reflection of Narain
	[44750] = { world_id = ZN.KALIMDOR,                 map_name = ZN.TANARIS,                     is_tamable = false }, -- Caliph Scorpidsting
	[44759] = { world_id = ZN.KALIMDOR,                 map_name = ZN.TANARIS,                     is_tamable = false }, -- Andre Firebeard
	[44761] = { world_id = ZN.KALIMDOR,                 map_name = ZN.TANARIS,                     is_tamable = false }, -- Aquementas the Unchained
	[44767] = { world_id = ZN.KALIMDOR,                 map_name = ZN.TANARIS,                     is_tamable = false }, -- Occulus the Corrupted
	[45257] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BLASTED_LANDS,               is_tamable = false }, -- Mordak Nightbender
	[45258] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BLASTED_LANDS,               is_tamable = false }, -- Cassia the Slitherqueen
	[45260] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BLASTED_LANDS,               is_tamable = false }, -- Blackleaf
	[45262] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BLASTED_LANDS,               is_tamable = false }, -- Narixxus the Doombringer
	[45369] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.LOCH_MODAN,                  is_tamable = false }, -- Morick Darkbrew
	[45380] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.LOCH_MODAN,                  is_tamable = true  }, -- Ashtail
	[45384] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.LOCH_MODAN,                  is_tamable = false }, -- Sagepaw
	[45398] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.LOCH_MODAN,                  is_tamable = false }, -- Grizlak
	[45399] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.LOCH_MODAN,                  is_tamable = false }, -- Optimo
	[45401] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.LOCH_MODAN,                  is_tamable = false }, -- Whitefin
	[45402] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.LOCH_MODAN,                  is_tamable = true  }, -- Nix
	[45404] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.LOCH_MODAN,                  is_tamable = false }, -- Geoshaper Maren
	[45739] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.DUSKWOOD,                    is_tamable = false }, -- The Unknown Soldier
	[45740] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.DUSKWOOD,                    is_tamable = false }, -- Watcher Eva
	[45771] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.DUSKWOOD,                    is_tamable = false }, -- Marus
	[45785] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.DUSKWOOD,                    is_tamable = false }, -- Carved One
	[45801] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.DUSKWOOD,                    is_tamable = false }, -- Eliza
	[45811] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.DUSKWOOD,                    is_tamable = false }, -- Marina DeSirrus
	[46981] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SILVERPINE_FOREST,           is_tamable = false }, -- Nightlash
	[46992] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SILVERPINE_FOREST,           is_tamable = false }, -- Berard the Moon-Crazed
	[47003] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SILVERPINE_FOREST,           is_tamable = false }, -- Bolgaff
	[47008] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SILVERPINE_FOREST,           is_tamable = false }, -- Fenwick Thatros
	[47009] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SILVERPINE_FOREST,           is_tamable = false }, -- Aquarius the Unbound
	[47010] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.HILLSBRAD_FOOTHILLS,         is_tamable = false }, -- Indigos
	[47012] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SILVERPINE_FOREST,           is_tamable = false }, -- Effritus
	[47015] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SILVERPINE_FOREST,           is_tamable = false }, -- Lost Son of Arugal
	[47023] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SILVERPINE_FOREST,           is_tamable = false }, -- Thule Ravenclaw
	[47386] = { world_id = ZN.KALIMDOR,                 map_name = ZN.TANARIS,                     is_tamable = true  }, -- Ainamiss the Hive Queen
	[47387] = { world_id = ZN.KALIMDOR,                 map_name = ZN.TANARIS,                     is_tamable = true  }, -- Harakiss the Infestor
	[49822] = { world_id = ZN.DEEPHOLM,                 map_name = ZN.DEEPHOLM,                    is_tamable = true  }, -- Jadefang
	[49913] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.KELPTHAR_FOREST,             is_tamable = false }, -- Lady La-La
	[50005] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SHIMMERING_EXPANSE,          is_tamable = false }, -- Poseidus
	[50050] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.ABYSSAL_DEPTHS,              is_tamable = false }, -- Shok'sharak
	[50051] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.ABYSSAL_DEPTHS,              is_tamable = true  }, -- Ghostcrawler
	[50052] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SHIMMERING_EXPANSE,          is_tamable = false }, -- Burgy Blackheart
	[50053] = { world_id = ZN.KALIMDOR,                 map_name = ZN.MOUNT_HYJAL,                 is_tamable = false }, -- Thartuk the Exile
	[50057] = { world_id = ZN.KALIMDOR,                 map_name = ZN.MOUNT_HYJAL,                 is_tamable = false }, -- Blazewing
	[50058] = { world_id = ZN.KALIMDOR,                 map_name = ZN.MOUNT_HYJAL,                 is_tamable = true  }, -- Terrorpene
	[50059] = { world_id = ZN.DEEPHOLM,                 map_name = ZN.DEEPHOLM,                    is_tamable = false }, -- Golgarok
	[50060] = { world_id = ZN.DEEPHOLM,                 map_name = ZN.DEEPHOLM,                    is_tamable = false }, -- Terborus
	[50062] = { world_id = ZN.DEEPHOLM,                 map_name = ZN.DEEPHOLM,                    is_tamable = false }, -- Aeonaxx
	[50064] = { world_id = ZN.KALIMDOR,                 map_name = ZN.ULDUM,                       is_tamable = false }, -- Cyrus the Black
	[50065] = { world_id = ZN.KALIMDOR,                 map_name = ZN.ULDUM,                       is_tamable = false }, -- Armagedillo
	[50085] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.TWILIGHT_HIGHLANDS,          is_tamable = false }, -- Overlord Sunderfury
	[50086] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.TWILIGHT_HIGHLANDS,          is_tamable = false }, -- Tarvus the Vile
	[50138] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.TWILIGHT_HIGHLANDS,          is_tamable = true  }, -- Karoma
	[50154] = { world_id = ZN.KALIMDOR,                 map_name = ZN.ULDUM,                       is_tamable = true  }, -- Madexx
	[50159] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.TWILIGHT_HIGHLANDS,          is_tamable = true  }, -- Sambas
	[50328] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.DEATHKNELL,                  is_tamable = true  }, -- Fangor
	[50329] = { world_id = ZN.KALIMDOR,                 map_name = ZN.THOUSAND_NEEDLES,            is_tamable = true  }, -- Rrakk
	[50330] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SILVERPINE_FOREST,           is_tamable = true  }, -- Kree
	[50331] = { world_id = ZN.PANDARIA,                 map_name = ZN.KRASARANG_WILDS,             is_tamable = false }, -- Go-Kan
	[50332] = { world_id = ZN.PANDARIA,                 map_name = ZN.KUN_LAI_SUMMIT,              is_tamable = false }, -- Korda Torros
	[50333] = { world_id = ZN.PANDARIA,                 map_name = ZN.TOWNLONG_STEPPES,            is_tamable = false }, -- Lon the Bull
	[50334] = { world_id = ZN.PANDARIA,                 map_name = ZN.DREAD_WASTES,                is_tamable = false }, -- Dak the Breaker
	[50335] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.HILLSBRAD_FOOTHILLS,         is_tamable = true  }, -- Alitus
	[50336] = { world_id = ZN.PANDARIA,                 map_name = ZN.VALE_OF_ETERNAL_BLOSSOMS,    is_tamable = false }, -- Yorik Sharpeye
	[50337] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.ARATHI_HIGHLANDS,            is_tamable = true  }, -- Cackle
	[50338] = { world_id = ZN.PANDARIA,                 map_name = ZN.THE_JADE_FOREST,             is_tamable = false }, -- Kor'nas Nightsavage
	[50339] = { world_id = ZN.PANDARIA,                 map_name = ZN.VALLEY_OF_THE_FOUR_WINDS,    is_tamable = false }, -- Sulik'shor
	[50340] = { world_id = ZN.PANDARIA,                 map_name = ZN.KRASARANG_WILDS,             is_tamable = false }, -- Gaarn the Toxic
	[50341] = { world_id = ZN.PANDARIA,                 map_name = ZN.KUN_LAI_SUMMIT,              is_tamable = false }, -- Borginn Darkfist
	[50342] = { world_id = ZN.KALIMDOR,                 map_name = ZN.DUSTWALLOW_MARSH,            is_tamable = true  }, -- Heronis
	[50343] = { world_id = ZN.KALIMDOR,                 map_name = ZN.STONETALON_MOUNTAINS,        is_tamable = true  }, -- Quall
	[50344] = { world_id = ZN.PANDARIA,                 map_name = ZN.TOWNLONG_STEPPES,            is_tamable = false }, -- Norlaxx
	[50345] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.WESTERN_PLAGUELANDS,         is_tamable = true  }, -- Alit
	[50346] = { world_id = ZN.KALIMDOR,                 map_name = ZN.WINTERSPRING,                is_tamable = true  }, -- Ronak
	[50347] = { world_id = ZN.PANDARIA,                 map_name = ZN.DREAD_WASTES,                is_tamable = false }, -- Karr the Darkener
	[50348] = { world_id = ZN.KALIMDOR,                 map_name = ZN.WINTERSPRING,                is_tamable = true  }, -- Norissis
	[50349] = { world_id = ZN.PANDARIA,                 map_name = ZN.VALE_OF_ETERNAL_BLOSSOMS,    is_tamable = false }, -- Kang the Soul Thief
	[50350] = { world_id = ZN.PANDARIA,                 map_name = ZN.THE_JADE_FOREST,             is_tamable = false }, -- Morgrinn Crackfang
	[50351] = { world_id = ZN.PANDARIA,                 map_name = ZN.VALLEY_OF_THE_FOUR_WINDS,    is_tamable = false }, -- Jonn-Dar
	[50352] = { world_id = ZN.PANDARIA,                 map_name = ZN.KRASARANG_WILDS,             is_tamable = false }, -- Qu'nas
	[50353] = { world_id = ZN.KALIMDOR,                 map_name = ZN.WINTERSPRING,                is_tamable = true  }, -- Manas
	[50354] = { world_id = ZN.PANDARIA,                 map_name = ZN.KUN_LAI_SUMMIT,              is_tamable = false }, -- Havak
	[50355] = { world_id = ZN.PANDARIA,                 map_name = ZN.TOWNLONG_STEPPES,            is_tamable = false }, -- Kah'tir
	[50356] = { world_id = ZN.PANDARIA,                 map_name = ZN.DREAD_WASTES,                is_tamable = false }, -- Krol the Blade
	[50357] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BURNING_STEPPES,             is_tamable = true  }, -- Sunwing
	[50358] = { world_id = ZN.PANDARIA,                 map_name = ZN.ISLE_OF_THUNDER,             is_tamable = false }, -- Haywire Sunreaver Construct
	[50359] = { world_id = ZN.PANDARIA,                 map_name = ZN.VALE_OF_ETERNAL_BLOSSOMS,    is_tamable = false }, -- Urgolax
	[50361] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BURNING_STEPPES,             is_tamable = true  }, -- Ornat
	[50362] = { world_id = ZN.KALIMDOR,                 map_name = ZN.FELWOOD,                     is_tamable = true  }, -- Blackbog the Fang
	[50363] = { world_id = ZN.PANDARIA,                 map_name = ZN.THE_JADE_FOREST,             is_tamable = false }, -- Krax'ik
	[50364] = { world_id = ZN.PANDARIA,                 map_name = ZN.VALLEY_OF_THE_FOUR_WINDS,    is_tamable = false }, -- Nal'lak the Ripper
	[50370] = { world_id = ZN.KALIMDOR,                 map_name = ZN.SILITHUS,                    is_tamable = true  }, -- Karapax
	[50388] = { world_id = ZN.PANDARIA,                 map_name = ZN.KRASARANG_WILDS,             is_tamable = false }, -- Torik-Ethis
	[50409] = { world_id = ZN.KALIMDOR,                 map_name = ZN.ULDUM,                       is_tamable = false }, -- Mysterious Camel Figurine
	[50410] = { world_id = ZN.KALIMDOR,                 map_name = ZN.ULDUM,                       is_tamable = false }, -- Mysterious Camel Figurine
	[50724] = { world_id = ZN.KALIMDOR,                 map_name = ZN.FELWOOD,                     is_tamable = true  }, -- Spinecrawl
	[50725] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BURNING_STEPPES,             is_tamable = true  }, -- Azelisk
	[50726] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BADLANDS,                    is_tamable = true  }, -- Kalixx
	[50727] = { world_id = ZN.KALIMDOR,                 map_name = ZN.THOUSAND_NEEDLES,            is_tamable = true  }, -- Strix the Barbed
	[50728] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BADLANDS,                    is_tamable = true  }, -- Deathstrike
	[50730] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BURNING_STEPPES,             is_tamable = true  }, -- Venomspine
	[50731] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BADLANDS,                    is_tamable = true  }, -- Needlefang
	[50733] = { world_id = ZN.PANDARIA,                 map_name = ZN.KUN_LAI_SUMMIT,              is_tamable = false }, -- Ski'thik
	[50734] = { world_id = ZN.PANDARIA,                 map_name = ZN.TOWNLONG_STEPPES,            is_tamable = false }, -- Lith'ik the Stalker
	[50735] = { world_id = ZN.KALIMDOR,                 map_name = ZN.DUSTWALLOW_MARSH,            is_tamable = true  }, -- Blinkeye the Rattler
	[50737] = { world_id = ZN.KALIMDOR,                 map_name = ZN.SILITHUS,                    is_tamable = true  }, -- Acroniss
	[50738] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SWAMP_OF_SORROWS,            is_tamable = true  }, -- Shimmerscale
	[50739] = { world_id = ZN.PANDARIA,                 map_name = ZN.DREAD_WASTES,                is_tamable = false }, -- Gar'lok
	[50741] = { world_id = ZN.KALIMDOR,                 map_name = ZN.THOUSAND_NEEDLES,            is_tamable = true  }, -- Kaxx
	[50742] = { world_id = ZN.KALIMDOR,                 map_name = ZN.SILITHUS,                    is_tamable = true  }, -- Qem
	[50743] = { world_id = ZN.KALIMDOR,                 map_name = ZN.SILITHUS,                    is_tamable = true  }, -- Manax
	[50744] = { world_id = ZN.KALIMDOR,                 map_name = ZN.SILITHUS,                    is_tamable = true  }, -- Qu'rik
	[50745] = { world_id = ZN.KALIMDOR,                 map_name = ZN.SILITHUS,                    is_tamable = true  }, -- Losaj
	[50746] = { world_id = ZN.KALIMDOR,                 map_name = ZN.SILITHUS,                    is_tamable = true  }, -- Bornix the Burrower
	[50747] = { world_id = ZN.KALIMDOR,                 map_name = ZN.AHNQIRAJ_THE_FALLEN_KINGDOM, is_tamable = true  }, -- Tix
	[50748] = { world_id = ZN.KALIMDOR,                 map_name = ZN.THOUSAND_NEEDLES,            is_tamable = true  }, -- Nyaj
	[50749] = { world_id = ZN.PANDARIA,                 map_name = ZN.VALE_OF_ETERNAL_BLOSSOMS,    is_tamable = false }, -- Kal'tik the Blight
	[50750] = { world_id = ZN.PANDARIA,                 map_name = ZN.THE_JADE_FOREST,             is_tamable = false }, -- Aethis
	[50752] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.ELWYNN_FOREST,               is_tamable = true  }, -- Tarantis
	[50759] = { world_id = ZN.KALIMDOR,                 map_name = ZN.STONETALON_MOUNTAINS,        is_tamable = true  }, -- Iriss the Widow
	[50763] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.TIRISFAL_GLADES,             is_tamable = true  }, -- Shadowstalker
	[50764] = { world_id = ZN.KALIMDOR,                 map_name = ZN.DUSTWALLOW_MARSH,            is_tamable = true  }, -- Paraliss
	[50765] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.HILLSBRAD_FOOTHILLS,         is_tamable = true  }, -- Miasmiss
	[50766] = { world_id = ZN.PANDARIA,                 map_name = ZN.VALLEY_OF_THE_FOUR_WINDS,    is_tamable = false }, -- Sele'na
	[50768] = { world_id = ZN.PANDARIA,                 map_name = ZN.KRASARANG_WILDS,             is_tamable = false }, -- Cournith Waterstrider
	[50769] = { world_id = ZN.PANDARIA,                 map_name = ZN.KUN_LAI_SUMMIT,              is_tamable = false }, -- Zai the Outcast
	[50770] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.HILLSBRAD_FOOTHILLS,         is_tamable = true  }, -- Zorn
	[50772] = { world_id = ZN.PANDARIA,                 map_name = ZN.TOWNLONG_STEPPES,            is_tamable = false }, -- Eshelon
	[50775] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.EASTERN_PLAGUELANDS,         is_tamable = true  }, -- Likk the Hunter
	[50776] = { world_id = ZN.PANDARIA,                 map_name = ZN.DREAD_WASTES,                is_tamable = false }, -- Nalash Verdantis
	[50777] = { world_id = ZN.KALIMDOR,                 map_name = ZN.FELWOOD,                     is_tamable = true  }, -- Needle
	[50778] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.WESTERN_PLAGUELANDS,         is_tamable = true  }, -- Ironweb
	[50779] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.EASTERN_PLAGUELANDS,         is_tamable = true  }, -- Sporeggon
	[50780] = { world_id = ZN.PANDARIA,                 map_name = ZN.VALE_OF_ETERNAL_BLOSSOMS,    is_tamable = false }, -- Sahn Tidehunter
	[50782] = { world_id = ZN.PANDARIA,                 map_name = ZN.THE_JADE_FOREST,             is_tamable = false }, -- Sarnak
	[50783] = { world_id = ZN.PANDARIA,                 map_name = ZN.VALLEY_OF_THE_FOUR_WINDS,    is_tamable = false }, -- Salyin Warscout
	[50784] = { world_id = ZN.KALIMDOR,                 map_name = ZN.DUSTWALLOW_MARSH,            is_tamable = true  }, -- Anith
	[50785] = { world_id = ZN.KALIMDOR,                 map_name = ZN.THOUSAND_NEEDLES,            is_tamable = true  }, -- Skyshadow
	[50786] = { world_id = ZN.KALIMDOR,                 map_name = ZN.STONETALON_MOUNTAINS,        is_tamable = true  }, -- Sparkwing
	[50787] = { world_id = ZN.PANDARIA,                 map_name = ZN.KRASARANG_WILDS,             is_tamable = false }, -- Arness the Scale
	[50788] = { world_id = ZN.KALIMDOR,                 map_name = ZN.WINTERSPRING,                is_tamable = true  }, -- Quetzl
	[50789] = { world_id = ZN.PANDARIA,                 map_name = ZN.KUN_LAI_SUMMIT,              is_tamable = false }, -- Nessos the Oracle
	[50790] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SWAMP_OF_SORROWS,            is_tamable = true  }, -- Ionis
	[50791] = { world_id = ZN.PANDARIA,                 map_name = ZN.TOWNLONG_STEPPES,            is_tamable = false }, -- Siltriss the Sharpener
	[50792] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BURNING_STEPPES,             is_tamable = true  }, -- Chiaa
	[50797] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SWAMP_OF_SORROWS,            is_tamable = true  }, -- Yukiko
	[50803] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.TIRISFAL_GLADES,             is_tamable = true  }, -- Bonechewer
	[50804] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.ARATHI_HIGHLANDS,            is_tamable = true  }, -- Ripwing
	[50805] = { world_id = ZN.PANDARIA,                 map_name = ZN.DREAD_WASTES,                is_tamable = false }, -- Omnis Grinlok
	[50806] = { world_id = ZN.PANDARIA,                 map_name = ZN.VALE_OF_ETERNAL_BLOSSOMS,    is_tamable = false }, -- Moldo One-Eye
	[50807] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BURNING_STEPPES,             is_tamable = true  }, -- Catal
	[50808] = { world_id = ZN.PANDARIA,                 map_name = ZN.THE_JADE_FOREST,             is_tamable = false }, -- Urobi the Walker
	[50809] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.WESTERN_PLAGUELANDS,         is_tamable = true  }, -- Heress
	[50810] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BURNING_STEPPES,             is_tamable = true  }, -- Favored of Isiset
	[50811] = { world_id = ZN.PANDARIA,                 map_name = ZN.VALLEY_OF_THE_FOUR_WINDS,    is_tamable = false }, -- Nasra Spothide
	[50812] = { world_id = ZN.KALIMDOR,                 map_name = ZN.STONETALON_MOUNTAINS,        is_tamable = true  }, -- Arae
	[50813] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.EASTERN_PLAGUELANDS,         is_tamable = true  }, -- Fene-mal
	[50814] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SILVERPINE_FOREST,           is_tamable = true  }, -- Corpsefeeder
	[50815] = { world_id = ZN.MOLTEN_FRONT,             map_name = ZN.MOLTEN_FRONT,                is_tamable = true  }, -- Skarr
	[50816] = { world_id = ZN.PANDARIA,                 map_name = ZN.KRASARANG_WILDS,             is_tamable = false }, -- Ruun Ghostpaw
	[50817] = { world_id = ZN.PANDARIA,                 map_name = ZN.KUN_LAI_SUMMIT,              is_tamable = false }, -- Ahone the Wanderer
	[50818] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.HILLSBRAD_FOOTHILLS,         is_tamable = true  }, -- The Dark Prowler
	[50819] = { world_id = ZN.KALIMDOR,                 map_name = ZN.WINTERSPRING,                is_tamable = true  }, -- Iceclaw
	[50820] = { world_id = ZN.PANDARIA,                 map_name = ZN.TOWNLONG_STEPPES,            is_tamable = false }, -- Yul Wildpaw
	[50821] = { world_id = ZN.PANDARIA,                 map_name = ZN.DREAD_WASTES,                is_tamable = false }, -- Ai-Li Skymirror
	[50822] = { world_id = ZN.PANDARIA,                 map_name = ZN.VALE_OF_ETERNAL_BLOSSOMS,    is_tamable = false }, -- Ai-Ran the Shifting Cloud
	[50823] = { world_id = ZN.PANDARIA,                 map_name = ZN.THE_JADE_FOREST,             is_tamable = false }, -- Mister Ferocious
	[50825] = { world_id = ZN.KALIMDOR,                 map_name = ZN.STONETALON_MOUNTAINS,        is_tamable = true  }, -- Feras
	[50828] = { world_id = ZN.PANDARIA,                 map_name = ZN.VALLEY_OF_THE_FOUR_WINDS,    is_tamable = false }, -- Bonobos
	[50830] = { world_id = ZN.PANDARIA,                 map_name = ZN.KRASARANG_WILDS,             is_tamable = false }, -- Spriggin
	[50831] = { world_id = ZN.PANDARIA,                 map_name = ZN.KUN_LAI_SUMMIT,              is_tamable = false }, -- Scritch
	[50832] = { world_id = ZN.PANDARIA,                 map_name = ZN.TOWNLONG_STEPPES,            is_tamable = false }, -- The Yowler
	[50833] = { world_id = ZN.KALIMDOR,                 map_name = ZN.FELWOOD,                     is_tamable = true  }, -- Duskcoat
	[50836] = { world_id = ZN.PANDARIA,                 map_name = ZN.DREAD_WASTES,                is_tamable = false }, -- Ik-Ik the Nimble
	[50837] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SWAMP_OF_SORROWS,            is_tamable = true  }, -- Kash
	[50838] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BADLANDS,                    is_tamable = true  }, -- Tabbs
	[50839] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = nil,                            is_tamable = true  }, -- Chromehound
	[50840] = { world_id = ZN.PANDARIA,                 map_name = ZN.VALE_OF_ETERNAL_BLOSSOMS,    is_tamable = false }, -- Major Nanners
	[50842] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BURNING_STEPPES,             is_tamable = true  }, -- Magmagan
	[50846] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SEARING_GORGE,               is_tamable = true  }, -- Slavermaw
	[50855] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BURNING_STEPPES,             is_tamable = true  }, -- Jaxx the Rabid
	[50856] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.EASTERN_PLAGUELANDS,         is_tamable = true  }, -- Snark
	[50858] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.HILLSBRAD_FOOTHILLS,         is_tamable = true  }, -- Dustwing
	[50864] = { world_id = ZN.KALIMDOR,                 map_name = ZN.FELWOOD,                     is_tamable = true  }, -- Thicket
	[50865] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.ARATHI_HIGHLANDS,            is_tamable = true  }, -- Saurix
	[50874] = { world_id = ZN.KALIMDOR,                 map_name = ZN.STONETALON_MOUNTAINS,        is_tamable = true  }, -- Tenok
	[50875] = { world_id = ZN.KALIMDOR,                 map_name = ZN.DUSTWALLOW_MARSH,            is_tamable = true  }, -- Nychus
	[50876] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SEARING_GORGE,               is_tamable = true  }, -- Avis
	[50882] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SWAMP_OF_SORROWS,            is_tamable = true  }, -- Chupacabros
	[50884] = { world_id = ZN.KALIMDOR,                 map_name = ZN.STONETALON_MOUNTAINS,        is_tamable = true  }, -- Dustflight the Cowardly
	[50886] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SWAMP_OF_SORROWS,            is_tamable = true  }, -- Seawing
	[50891] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.ARATHI_HIGHLANDS,            is_tamable = true  }, -- Boros
	[50892] = { world_id = ZN.KALIMDOR,                 map_name = ZN.THOUSAND_NEEDLES,            is_tamable = true  }, -- Cyn
	[50895] = { world_id = ZN.KALIMDOR,                 map_name = ZN.STONETALON_MOUNTAINS,        is_tamable = true  }, -- Volux
	[50897] = { world_id = ZN.KALIMDOR,                 map_name = ZN.SILITHUS,                    is_tamable = true  }, -- Ffexk the Dunestalker
	[50901] = { world_id = ZN.KALIMDOR,                 map_name = ZN.DUSTWALLOW_MARSH,            is_tamable = true  }, -- Teromak
	[50903] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SWAMP_OF_SORROWS,            is_tamable = true  }, -- Orlix the Swamplord
	[50905] = { world_id = ZN.KALIMDOR,                 map_name = ZN.FELWOOD,                     is_tamable = true  }, -- Cida
	[50906] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.WESTERN_PLAGUELANDS,         is_tamable = true  }, -- Mutilax
	[50908] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.TIRISFAL_GLADES,             is_tamable = true  }, -- Nighthowl
	[50915] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.EASTERN_PLAGUELANDS,         is_tamable = true  }, -- Snort
	[50916] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.ELWYNN_FOREST,               is_tamable = true  }, -- Lamepaw the Whimperer
	[50922] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.WESTERN_PLAGUELANDS,         is_tamable = true  }, -- Warg
	[50925] = { world_id = ZN.KALIMDOR,                 map_name = ZN.FELWOOD,                     is_tamable = true  }, -- Grovepaw
	[50926] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.ELWYNN_FOREST,               is_tamable = true  }, -- Grizzled Ben
	[50929] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.HILLSBRAD_FOOTHILLS,         is_tamable = true  }, -- Little Bjorn
	[50930] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.TIRISFAL_GLADES,             is_tamable = true  }, -- Hibernus the Sleeper
	[50931] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.WESTERN_PLAGUELANDS,         is_tamable = true  }, -- Mange
	[50937] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.WESTERN_PLAGUELANDS,         is_tamable = true  }, -- Hamhide
	[50940] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.ARATHI_HIGHLANDS,            is_tamable = true  }, -- Swee
	[50942] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.ELWYNN_FOREST,               is_tamable = true  }, -- Snoot the Rooter
	[50945] = { world_id = ZN.KALIMDOR,                 map_name = ZN.DUSTWALLOW_MARSH,            is_tamable = true  }, -- Scruff
	[50946] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SEARING_GORGE,               is_tamable = true  }, -- Hogzilla
	[50947] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.EASTERN_PLAGUELANDS,         is_tamable = true  }, -- Varah
	[50948] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SEARING_GORGE,               is_tamable = true  }, -- Crystalback
	[50949] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SILVERPINE_FOREST,           is_tamable = true  }, -- Finn's Gambit
	[50952] = { world_id = ZN.KALIMDOR,                 map_name = ZN.THOUSAND_NEEDLES,            is_tamable = true  }, -- Barnacle Jim
	[50955] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.HILLSBRAD_FOOTHILLS,         is_tamable = true  }, -- Carcinak
	[50957] = { world_id = ZN.KALIMDOR,                 map_name = ZN.DUSTWALLOW_MARSH,            is_tamable = true  }, -- Hugeclaw
	[50959] = { world_id = ZN.MOLTEN_FRONT,             map_name = ZN.MOLTEN_FRONT,                is_tamable = true  }, -- Karkin
	[50964] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.WETLANDS,                    is_tamable = true  }, -- Chops
	[50967] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.HILLSBRAD_FOOTHILLS,         is_tamable = true  }, -- Craw the Ravager
	[50986] = { world_id = ZN.KALIMDOR,                 map_name = ZN.STONETALON_MOUNTAINS,        is_tamable = true  }, -- Goldenback
	[50993] = { world_id = ZN.KALIMDOR,                 map_name = ZN.WINTERSPRING,                is_tamable = true  }, -- Gal'dorak
	[50995] = { world_id = ZN.KALIMDOR,                 map_name = ZN.WINTERSPRING,                is_tamable = true  }, -- Bruiser
	[50997] = { world_id = ZN.KALIMDOR,                 map_name = ZN.WINTERSPRING,                is_tamable = true  }, -- Bornak the Gorer
	[51000] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BADLANDS,                    is_tamable = true  }, -- Blackshell the Impenetrable
	[51001] = { world_id = ZN.KALIMDOR,                 map_name = ZN.THOUSAND_NEEDLES,            is_tamable = true  }, -- Venomclaw
	[51002] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SEARING_GORGE,               is_tamable = true  }, -- Scorpoxx
	[51004] = { world_id = ZN.KALIMDOR,                 map_name = ZN.SILITHUS,                    is_tamable = true  }, -- Toxx
	[51007] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BADLANDS,                    is_tamable = true  }, -- Serkett
	[51008] = { world_id = ZN.KALIMDOR,                 map_name = ZN.THOUSAND_NEEDLES,            is_tamable = true  }, -- The Barbed Horror
	[51010] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SEARING_GORGE,               is_tamable = true  }, -- Snips
	[51014] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.ELWYNN_FOREST,               is_tamable = true  }, -- Terrapis
	[51017] = { world_id = ZN.KALIMDOR,                 map_name = ZN.FELWOOD,                     is_tamable = true  }, -- Gezan
	[51018] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BADLANDS,                    is_tamable = true  }, -- Zormus
	[51021] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BADLANDS,                    is_tamable = true  }, -- Vorticus
	[51022] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.HILLSBRAD_FOOTHILLS,         is_tamable = true  }, -- Chordix
	[51025] = { world_id = ZN.KALIMDOR,                 map_name = ZN.FELWOOD,                     is_tamable = true  }, -- Dilennaa
	[51026] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SILVERPINE_FOREST,           is_tamable = true  }, -- Gnath
	[51027] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.EASTERN_PLAGUELANDS,         is_tamable = true  }, -- Spirocula
	[51028] = { world_id = ZN.KALIMDOR,                 map_name = ZN.WINTERSPRING,                is_tamable = true  }, -- The Deep Tunneler
	[51029] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.WESTERN_PLAGUELANDS,         is_tamable = true  }, -- Parasitus
	[51031] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.WESTERN_PLAGUELANDS,         is_tamable = true  }, -- Tracker
	[51037] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SILVERPINE_FOREST,           is_tamable = true  }, -- Lost Gilnean Wardog
	[51040] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.ARATHI_HIGHLANDS,            is_tamable = true  }, -- Snuffles
	[51042] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.EASTERN_PLAGUELANDS,         is_tamable = true  }, -- Bleakheart
	[51044] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.TIRISFAL_GLADES,             is_tamable = true  }, -- Plague
	[51045] = { world_id = ZN.KALIMDOR,                 map_name = ZN.WINTERSPRING,                is_tamable = true  }, -- Arcanus
	[51046] = { world_id = ZN.KALIMDOR,                 map_name = ZN.FELWOOD,                     is_tamable = true  }, -- Fidonis
	[51048] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SEARING_GORGE,               is_tamable = true  }, -- Rexxus
	[51052] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SWAMP_OF_SORROWS,            is_tamable = true  }, -- Gib the Banana-Hoarder
	[51053] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.EASTERN_PLAGUELANDS,         is_tamable = true  }, -- Quirix
	[51057] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.HILLSBRAD_FOOTHILLS,         is_tamable = true  }, -- Weevil
	[51058] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.WESTERN_PLAGUELANDS,         is_tamable = true  }, -- Aphis
	[51059] = { world_id = ZN.PANDARIA,                 map_name = ZN.VALLEY_OF_THE_FOUR_WINDS,    is_tamable = false }, -- Blackhoof
	[51061] = { world_id = ZN.KALIMDOR,                 map_name = ZN.DUSTWALLOW_MARSH,            is_tamable = true  }, -- Roth-Salam
	[51062] = { world_id = ZN.KALIMDOR,                 map_name = ZN.STONETALON_MOUNTAINS,        is_tamable = true  }, -- Khep-Re
	[51063] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.ARATHI_HIGHLANDS,            is_tamable = true  }, -- Phalanax
	[51066] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = nil,                            is_tamable = true  }, -- Crystalfang
	[51067] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.ARATHI_HIGHLANDS,            is_tamable = true  }, -- Glint
	[51069] = { world_id = ZN.KALIMDOR,                 map_name = ZN.DUSTWALLOW_MARSH,            is_tamable = true  }, -- Scintillex
	[51071] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SHIMMERING_EXPANSE,          is_tamable = false }, -- Captain Florence
	[51076] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.HILLSBRAD_FOOTHILLS,         is_tamable = true  }, -- Lopex
	[51077] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.ELWYNN_FOREST,               is_tamable = true  }, -- Bushtail
	[51078] = { world_id = ZN.PANDARIA,                 map_name = ZN.THE_JADE_FOREST,             is_tamable = false }, -- Ferdinand
	[51079] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.VASHJIR,                     is_tamable = false }, -- Captain Foulwind
	[51401] = { world_id = ZN.KALIMDOR,                 map_name = ZN.ULDUM,                       is_tamable = true  }, -- Madexx
	[51402] = { world_id = ZN.KALIMDOR,                 map_name = ZN.ULDUM,                       is_tamable = true  }, -- Madexx
	[51403] = { world_id = ZN.KALIMDOR,                 map_name = ZN.ULDUM,                       is_tamable = true  }, -- Madexx
	[51404] = { world_id = ZN.KALIMDOR,                 map_name = ZN.ULDUM,                       is_tamable = true  }, -- Madexx
	[51658] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.NORTHERN_STRANGLETHORN,      is_tamable = false }, -- Mogh the Dead
	[51661] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.NORTHERN_STRANGLETHORN,      is_tamable = true  }, -- Tsul'Kalu
	[51662] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.NORTHERN_STRANGLETHORN,      is_tamable = true  }, -- Mahamba
	[51663] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.NORTHERN_STRANGLETHORN,      is_tamable = true  }, -- Pogeyan
	[52146] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.REDRIDGE_MOUNTAINS,          is_tamable = true  }, -- Chitter
	[54318] = { world_id = ZN.KALIMDOR,                 map_name = ZN.MOUNT_HYJAL,                 is_tamable = true  }, -- Ankha
	[54319] = { world_id = ZN.KALIMDOR,                 map_name = ZN.MOUNT_HYJAL,                 is_tamable = true  }, -- Magria
	[54320] = { world_id = ZN.KALIMDOR,                 map_name = ZN.MOUNT_HYJAL,                 is_tamable = true  }, -- Ban'thalos
	[54321] = { world_id = ZN.MOLTEN_FRONT,             map_name = ZN.MOLTEN_FRONT,                is_tamable = true  }, -- Solix
	[54322] = { world_id = ZN.MOLTEN_FRONT,             map_name = ZN.MOLTEN_FRONT,                is_tamable = true  }, -- Deth'tilac
	[54323] = { world_id = ZN.MOLTEN_FRONT,             map_name = ZN.MOLTEN_FRONT,                is_tamable = true  }, -- Kirix
	[54324] = { world_id = ZN.MOLTEN_FRONT,             map_name = ZN.MOLTEN_FRONT,                is_tamable = true  }, -- Skitterflame
	[54338] = { world_id = ZN.MOLTEN_FRONT,             map_name = ZN.MOLTEN_FRONT,                is_tamable = true  }, -- Anthriss
	[54533] = { world_id = ZN.KALIMDOR,                 map_name = ZN.SILITHUS,                    is_tamable = true  }, -- Prince Lakma
	[56081] = { world_id = ZN.HILLSBRAD_FOOTHILLS,      map_name = ZN.OLD_HILLSBRAD_FOOTHILLS,     is_tamable = false }, -- Optimistic Benj
	[58474] = { world_id = ZN.PANDARIA,                 map_name = ZN.VALE_OF_ETERNAL_BLOSSOMS,    is_tamable = true  }, -- Bloodtip
	[58768] = { world_id = ZN.PANDARIA,                 map_name = ZN.VALE_OF_ETERNAL_BLOSSOMS,    is_tamable = false }, -- Cracklefang
	[58769] = { world_id = ZN.PANDARIA,                 map_name = ZN.VALE_OF_ETERNAL_BLOSSOMS,    is_tamable = false }, -- Vicejaw
	[58771] = { world_id = ZN.PANDARIA,                 map_name = ZN.VALE_OF_ETERNAL_BLOSSOMS,    is_tamable = false }, -- Quid
	[58778] = { world_id = ZN.PANDARIA,                 map_name = ZN.VALE_OF_ETERNAL_BLOSSOMS,    is_tamable = false }, -- Aetha
	[58817] = { world_id = ZN.PANDARIA,                 map_name = ZN.VALE_OF_ETERNAL_BLOSSOMS,    is_tamable = false }, -- Spirit of Lao-Fe
	[58949] = { world_id = ZN.PANDARIA,                 map_name = ZN.VALE_OF_ETERNAL_BLOSSOMS,    is_tamable = false }, -- Bai-Jin the Butcher
	[59369] = { world_id = ZN.SCHOLOMANCE,              map_name = ZN.SCHOLOMANCE,                 is_tamable = false }, -- Doctor Theolen Krastinov
	[60491] = { world_id = ZN.PANDARIA,                 map_name = ZN.KUN_LAI_SUMMIT,              is_tamable = false }, -- Sha of Anger
	[62346] = { world_id = ZN.PANDARIA,                 map_name = ZN.VALLEY_OF_THE_FOUR_WINDS,    is_tamable = false }, -- Galleon
	[62880] = { world_id = ZN.PANDARIA,                 map_name = ZN.VALE_OF_ETERNAL_BLOSSOMS,    is_tamable = false }, -- Gochao the Ironfist
	[62881] = { world_id = ZN.PANDARIA,                 map_name = ZN.VALE_OF_ETERNAL_BLOSSOMS,    is_tamable = false }, -- Gaohun the Soul-Severer
	[63101] = { world_id = ZN.PANDARIA,                 map_name = ZN.VALE_OF_ETERNAL_BLOSSOMS,    is_tamable = false }, -- General Temuja
	[63240] = { world_id = ZN.PANDARIA,                 map_name = ZN.VALE_OF_ETERNAL_BLOSSOMS,    is_tamable = false }, -- Shadowmaster Sydow
	[63510] = { world_id = ZN.PANDARIA,                 map_name = ZN.VALE_OF_ETERNAL_BLOSSOMS,    is_tamable = false }, -- Wulon
	[63691] = { world_id = ZN.PANDARIA,                 map_name = ZN.VALE_OF_ETERNAL_BLOSSOMS,    is_tamable = false }, -- Huo-Shuang
	[63695] = { world_id = ZN.PANDARIA,                 map_name = ZN.VALE_OF_ETERNAL_BLOSSOMS,    is_tamable = false }, -- Baolai the Immolator
	[63977] = { world_id = ZN.PANDARIA,                 map_name = ZN.VALE_OF_ETERNAL_BLOSSOMS,    is_tamable = false }, -- Vyraxxis
	[63978] = { world_id = ZN.PANDARIA,                 map_name = ZN.VALE_OF_ETERNAL_BLOSSOMS,    is_tamable = false }, -- Kri'chon
	[64004] = { world_id = ZN.PANDARIA,                 map_name = ZN.VALLEY_OF_THE_FOUR_WINDS,    is_tamable = false }, -- Ghostly Pandaren Fisherman
	[64191] = { world_id = ZN.PANDARIA,                 map_name = ZN.VALLEY_OF_THE_FOUR_WINDS,    is_tamable = false }, -- Ghostly Pandaren Craftsman
	[68317] = { world_id = ZN.PANDARIA,                 map_name = ZN.KRASARANG_WILDS,             is_tamable = false }, -- Mavis Harms
	[68318] = { world_id = ZN.PANDARIA,                 map_name = ZN.KRASARANG_WILDS,             is_tamable = false }, -- Dalan Nightbreaker
	[68319] = { world_id = ZN.PANDARIA,                 map_name = ZN.KRASARANG_WILDS,             is_tamable = false }, -- Disha Fearwarden
	[68320] = { world_id = ZN.PANDARIA,                 map_name = ZN.KRASARANG_WILDS,             is_tamable = false }, -- Ubunti the Shade
	[68321] = { world_id = ZN.PANDARIA,                 map_name = ZN.KRASARANG_WILDS,             is_tamable = false }, -- Kar Warmaker
	[68322] = { world_id = ZN.PANDARIA,                 map_name = ZN.KRASARANG_WILDS,             is_tamable = false }, -- Muerta
	[69099] = { world_id = ZN.PANDARIA,                 map_name = ZN.ISLE_OF_THUNDER,             is_tamable = false }, -- Nalak
	[69161] = { world_id = ZN.PANDARIA,                 map_name = ZN.ISLE_OF_GIANTS,              is_tamable = false }, -- Oondasta
	[69664] = { world_id = ZN.PANDARIA,                 map_name = ZN.ISLE_OF_THUNDER,             is_tamable = false }, -- Mumta
	[69768] = { world_id = ZN.PANDARIA,                 map_name = ZN.TOWNLONG_STEPPES,            is_tamable = false }, -- Zandalari Warscout
	[69769] = { world_id = ZN.PANDARIA,                 map_name = ZN.TOWNLONG_STEPPES,            is_tamable = false }, -- Zandalari Warbringer
	[69841] = { world_id = ZN.PANDARIA,                 map_name = ZN.TOWNLONG_STEPPES,            is_tamable = false }, -- Zandalari Warbringer
	[69842] = { world_id = ZN.PANDARIA,                 map_name = ZN.DREAD_WASTES,                is_tamable = false }, -- Zandalari Warbringer
	[69843] = { world_id = ZN.ISLE_OF_THUNDER,          map_name = ZN.THRONE_OF_THUNDER,           is_tamable = false }, -- Zao'cho
	[69996] = { world_id = ZN.PANDARIA,                 map_name = ZN.ISLE_OF_THUNDER,             is_tamable = false }, -- Ku'lai the Skyclaw
	[69997] = { world_id = ZN.PANDARIA,                 map_name = ZN.ISLE_OF_THUNDER,             is_tamable = false }, -- Progenitus
	[69998] = { world_id = ZN.PANDARIA,                 map_name = ZN.ISLE_OF_THUNDER,             is_tamable = true  }, -- Goda
	[69999] = { world_id = ZN.PANDARIA,                 map_name = ZN.ISLE_OF_THUNDER,             is_tamable = false }, -- God-Hulk Ramuk
	[70000] = { world_id = ZN.PANDARIA,                 map_name = ZN.ISLE_OF_THUNDER,             is_tamable = false }, -- Al'tabim the All-Seeing
	[70001] = { world_id = ZN.PANDARIA,                 map_name = ZN.ISLE_OF_THUNDER,             is_tamable = false }, -- Backbreaker Uru
	[70002] = { world_id = ZN.PANDARIA,                 map_name = ZN.ISLE_OF_THUNDER,             is_tamable = false }, -- Lu-Ban
	[70003] = { world_id = ZN.PANDARIA,                 map_name = ZN.ISLE_OF_THUNDER,             is_tamable = false }, -- Molthor
	[70096] = { world_id = ZN.PANDARIA,                 map_name = ZN.ISLE_OF_GIANTS,              is_tamable = false }, -- War-God Dokah
	[70126] = { world_id = ZN.PANDARIA,                 map_name = ZN.THE_VEILED_STAIR,            is_tamable = false }, -- Willy Wilder
	[70238] = { world_id = ZN.ISLE_OF_THUNDER,          map_name = ZN.THRONE_OF_THUNDER,           is_tamable = false }, -- Unblinking Eye
	[70249] = { world_id = ZN.ISLE_OF_THUNDER,          map_name = ZN.THRONE_OF_THUNDER,           is_tamable = false }, -- Focused Eye
	[70276] = { world_id = ZN.ISLE_OF_THUNDER,          map_name = ZN.THRONE_OF_THUNDER,           is_tamable = false }, -- No'ku Stormsayer
	[70323] = { world_id = ZN.PANDARIA,                 map_name = ZN.KUN_LAI_SUMMIT,              is_tamable = false }, -- Krakkanon
	[70430] = { world_id = ZN.ISLE_OF_THUNDER,          map_name = ZN.THRONE_OF_THUNDER,           is_tamable = false }, -- Rocky Horror
	[70440] = { world_id = ZN.ISLE_OF_THUNDER,          map_name = ZN.THRONE_OF_THUNDER,           is_tamable = false }, -- Monara
	[70530] = { world_id = ZN.ISLE_OF_THUNDER,          map_name = ZN.ISLE_OF_THUNDER,             is_tamable = false }, -- Ra'sha
	[71864] = { world_id = ZN.PANDARIA,                 map_name = ZN.TIMELESS_ISLE,               is_tamable = false }, -- Spelurk
	[71919] = { world_id = ZN.PANDARIA,                 map_name = ZN.TIMELESS_ISLE,               is_tamable = false }, -- Zhu-Gon the Sour
	[72045] = { world_id = ZN.PANDARIA,                 map_name = ZN.TIMELESS_ISLE,               is_tamable = false }, -- Chelon
	[72048] = { world_id = ZN.PANDARIA,                 map_name = ZN.TIMELESS_ISLE,               is_tamable = false }, -- Rattleskew
	[72049] = { world_id = ZN.PANDARIA,                 map_name = ZN.TIMELESS_ISLE,               is_tamable = false }, -- Cranegnasher
	[72193] = { world_id = ZN.PANDARIA,                 map_name = ZN.TIMELESS_ISLE,               is_tamable = false }, -- Karkanos
	[72245] = { world_id = ZN.PANDARIA,                 map_name = ZN.TIMELESS_ISLE,               is_tamable = false }, -- Zesqua
	[72769] = { world_id = ZN.PANDARIA,                 map_name = ZN.TIMELESS_ISLE,               is_tamable = false }, -- Spirit of Jadefire
	[72775] = { world_id = ZN.PANDARIA,                 map_name = ZN.TIMELESS_ISLE,               is_tamable = false }, -- Bufo
	[72808] = { world_id = ZN.PANDARIA,                 map_name = ZN.TIMELESS_ISLE,               is_tamable = true  }, -- Tsavo'ka
	[72909] = { world_id = ZN.PANDARIA,                 map_name = ZN.TIMELESS_ISLE,               is_tamable = false }, -- Gu'chi the Swarmbringer
	[72970] = { world_id = ZN.PANDARIA,                 map_name = ZN.TIMELESS_ISLE,               is_tamable = false }, -- Golganarr
	[73157] = { world_id = ZN.PANDARIA,                 map_name = ZN.TIMELESS_ISLE,               is_tamable = false }, -- Rock Moss
	[73158] = { world_id = ZN.PANDARIA,                 map_name = ZN.TIMELESS_ISLE,               is_tamable = true  }, -- Emerald Gander
	[73160] = { world_id = ZN.PANDARIA,                 map_name = ZN.TIMELESS_ISLE,               is_tamable = false }, -- Ironfur Steelhorn
	[73161] = { world_id = ZN.PANDARIA,                 map_name = ZN.TIMELESS_ISLE,               is_tamable = true  }, -- Great Turtle Furyshell
	[73163] = { world_id = ZN.PANDARIA,                 map_name = ZN.TIMELESS_ISLE,               is_tamable = false }, -- Imperial Python
	[73166] = { world_id = ZN.PANDARIA,                 map_name = ZN.TIMELESS_ISLE,               is_tamable = true  }, -- Monstrous Spineclaw
	[73167] = { world_id = ZN.PANDARIA,                 map_name = ZN.TIMELESS_ISLE,               is_tamable = false }, -- Huolon
	[73169] = { world_id = ZN.PANDARIA,                 map_name = ZN.TIMELESS_ISLE,               is_tamable = false }, -- Jakur of Ordon
	[73170] = { world_id = ZN.PANDARIA,                 map_name = ZN.TIMELESS_ISLE,               is_tamable = false }, -- Watcher Osu
	[73171] = { world_id = ZN.PANDARIA,                 map_name = ZN.TIMELESS_ISLE,               is_tamable = false }, -- Champion of the Black Flame
	[73172] = { world_id = ZN.PANDARIA,                 map_name = ZN.TIMELESS_ISLE,               is_tamable = false }, -- Flintlord Gairan
	[73173] = { world_id = ZN.PANDARIA,                 map_name = ZN.TIMELESS_ISLE,               is_tamable = false }, -- Urdur the Cauterizer
	[73174] = { world_id = ZN.PANDARIA,                 map_name = ZN.TIMELESS_ISLE,               is_tamable = false }, -- Archiereus of Flame
	[73175] = { world_id = ZN.PANDARIA,                 map_name = ZN.TIMELESS_ISLE,               is_tamable = false }, -- Cinderfall
	[73277] = { world_id = ZN.PANDARIA,                 map_name = ZN.TIMELESS_ISLE,               is_tamable = false }, -- Leafmender
	[73279] = { world_id = ZN.PANDARIA,                 map_name = ZN.TIMELESS_ISLE,               is_tamable = false }, -- Evermaw
	[73281] = { world_id = ZN.PANDARIA,                 map_name = ZN.TIMELESS_ISLE,               is_tamable = false }, -- Dread Ship Vazuvius
	[73282] = { world_id = ZN.PANDARIA,                 map_name = ZN.TIMELESS_ISLE,               is_tamable = false }, -- Garnia
	[73293] = { world_id = ZN.PANDARIA,                 map_name = ZN.TIMELESS_ISLE,               is_tamable = false }, -- Whizzig
	[73666] = { world_id = ZN.PANDARIA,                 map_name = ZN.TIMELESS_ISLE,               is_tamable = false }, -- Archiereus of Flame
	[73704] = { world_id = ZN.PANDARIA,                 map_name = ZN.TIMELESS_ISLE,               is_tamable = false }, -- Stinkbraid
}


private.NPC_ID_TO_MAP_NAME = {}
private.NPC_ID_TO_NAME = {}
private.NPC_ID_TO_WORLD_NAME = {}


private.TAMABLE_ID_TO_MAP_NAME = {}
private.TAMABLE_ID_TO_NAME = {}
private.TAMABLE_ID_TO_WORLD_NAME = {}


private.UNTAMABLE_ID_TO_MAP_NAME = {}
private.UNTAMABLE_ID_TO_NAME = {}
private.UNTAMABLE_ID_TO_WORLD_NAME = {}


for npc_id, data in pairs(NPC_DATA) do
	private.NPC_ID_TO_MAP_NAME[npc_id] = data.map_name
	private.NPC_ID_TO_NAME[npc_id] = L.NPCs[npc_id]
	private.NPC_ID_TO_WORLD_NAME[npc_id] = data.world_id

	if data.is_tamable then
		private.TAMABLE_ID_TO_MAP_NAME[npc_id] = data.map_name
		private.TAMABLE_ID_TO_NAME[npc_id] = L.NPCs[npc_id]
		private.TAMABLE_ID_TO_WORLD_NAME[npc_id] = data.world_id
	else
		private.UNTAMABLE_ID_TO_MAP_NAME[npc_id] = data.map_name
		private.UNTAMABLE_ID_TO_NAME[npc_id] = L.NPCs[npc_id]
		private.UNTAMABLE_ID_TO_WORLD_NAME[npc_id] = data.world_id
	end
end


private.RareMobData = {
	NPCWorldIDs = {
		[61] = 2;
		[62] = 2;
		[79] = 2;
		[99] = 2;
		[100] = 2;
		[462] = 2;
		[471] = 2;
		[472] = 2;
		[506] = 2;
		[507] = 2;
		[519] = 2;
		[520] = 2;
		[521] = 2;
		[534] = 2;
		[572] = 2;
		[573] = 2;
		[574] = 2;
		[584] = 2;
		[596] = ZN.THE_DEADMINES,
		[599] = ZN.THE_DEADMINES,
		[616] = 2;
		[763] = 2;
		[947] = 2;
		[1063] = 2;
		[1106] = 2;
		[1112] = 2;
		[1119] = 2;
		[1130] = 2;
		[1132] = 2;
		[1137] = 2;
		[1140] = 2;
		[1260] = 2;
		[1398] = 2;
		[1399] = 2;
		[1424] = 2;
		[1425] = 2;
		[1531] = 2;
		[1533] = 2;
		[1552] = 2;
		[1837] = 2;
		[1838] = 2;
		[1839] = 2;
		[1841] = 2;
		[1843] = 2;
		[1844] = 2;
		[1847] = 2;
		[1848] = 2;
		[1849] = 2;
		[1851] = 2;
		[1885] = 2;
		[1910] = 2;
		[1911] = 2;
		[1936] = 2;
		[2090] = 2;
		[2108] = 2;
		[2162] = 1;
		[2172] = 1;
		[2175] = 1;
		[2184] = 1;
		[2186] = 1;
		[2191] = 1;
		[2192] = 1;
		[2258] = 2;
		[2452] = 2;
		[2453] = 2;
		[2476] = 2;
		[2541] = 2;
		[2598] = 2;
		[2600] = 2;
		[2601] = 2;
		[2602] = 2;
		[2603] = 2;
		[2604] = 2;
		[2605] = 2;
		[2606] = 2;
		[2609] = 2;
		[2744] = 2;
		[2749] = 2;
		[2751] = 2;
		[2752] = 2;
		[2753] = 2;
		[2754] = 2;
		[2779] = 2;
		[2850] = 2;
		[2931] = 2;
		[3058] = 1;
		[3068] = 1;
		[3253] = 1;
		[3270] = 1;
		[3295] = 1;
		[3398] = 1;
		[3470] = 1;
		[3535] = 1;
		[3581] = 2;
		[3652] = 1;
		[3672] = 1;
		[3735] = 1;
		[3736] = 1;
		[3773] = 1;
		[3792] = 1;
		[3872] = ZN.SHADOWFANG_KEEP,
		[4066] = 1;
		[4132] = 1;
		[4339] = 1;
		[4380] = 1;
		[4425] = ZN.RAZORFEN_KRAUL,
		[4842] = ZN.RAZORFEN_KRAUL,
		[5343] = 1;
		[5345] = 1;
		[5346] = 1;
		[5347] = 1;
		[5348] = 2;
		[5349] = 1;
		[5350] = 1;
		[5352] = 1;
		[5354] = 1;
		[5356] = 1;
		[5785] = 1;
		[5786] = 1;
		[5787] = 1;
		[5807] = 1;
		[5809] = 1;
		[5822] = 1;
		[5823] = 1;
		[5824] = 1;
		[5826] = 1;
		[5828] = 1;
		[5829] = 1;
		[5830] = 1;
		[5831] = 1;
		[5834] = 1;
		[5835] = 1;
		[5836] = 1;
		[5837] = 1;
		[5838] = 1;
		[5841] = 1;
		[5842] = 1;
		[5847] = 1;
		[5848] = 1;
		[5849] = 1;
		[5851] = 1;
		[5859] = 1;
		[5863] = 1;
		[5864] = 1;
		[5865] = 1;
		[5912] = ZN.WAILING_CAVERNS,
		[5915] = 1;
		[5928] = 1;
		[5930] = 1;
		[5932] = 1;
		[5933] = 1;
		[5935] = 1;
		[5937] = 1;
		[6118] = 1;
		[6228] = ZN.GNOMEREGAN,
		[6581] = 1;
		[6582] = 1;
		[6583] = 1;
		[6584] = 1;
		[6585] = 1;
		[6648] = 1;
		[6649] = 1;
		[6650] = 1;
		[6651] = 1;
		[7015] = 1;
		[7016] = 1;
		[7017] = 1;
		[7104] = 1;
		[7137] = 1;
		[7846] = 2;
		[8199] = 1;
		[8200] = 1;
		[8201] = 1;
		[8203] = 1;
		[8204] = 1;
		[8205] = 1;
		[8207] = 1;
		[8210] = 2;
		[8211] = 2;
		[8212] = 2;
		[8213] = 2;
		[8214] = 2;
		[8215] = 2;
		[8216] = 2;
		[8217] = 2;
		[8218] = 2;
		[8219] = 2;
		[8277] = 2;
		[8278] = 2;
		[8279] = 2;
		[8280] = 2;
		[8281] = 2;
		[8282] = 2;
		[8283] = 2;
		[8296] = 2;
		[8297] = 2;
		[8298] = 2;
		[8299] = 2;
		[8300] = 2;
		[8301] = 2;
		[8302] = 2;
		[8303] = 2;
		[8304] = 2;
		[8503] = 2;
		[8660] = 1;
		[8923] = ZN.BLACKROCK_DEPTHS,
		[8976] = 2;
		[8978] = 2;
		[8979] = 2;
		[8981] = 2;
		[9217] = ZN.BLACKROCK_SPIRE,
		[9218] = ZN.BLACKROCK_SPIRE,
		[9219] = ZN.BLACKROCK_SPIRE,
		[9596] = ZN.BLACKROCK_SPIRE,
		[9602] = 2;
		[9604] = 2;
		[9718] = ZN.BLACKROCK_SPIRE,
		[9736] = ZN.BLACKROCK_SPIRE,
		[10077] = 2;
		[10078] = 2;
		[10080] = ZN.ZULFARRAK,
		[10081] = ZN.ZULFARRAK,
		[10082] = ZN.ZULFARRAK,
		[10119] = 2;
		[10196] = 1;
		[10197] = 1;
		[10198] = 1;
		[10199] = 1;
		[10200] = 1;
		[10202] = 1;
		[10263] = ZN.BLACKROCK_SPIRE,
		[10356] = 2;
		[10357] = 2;
		[10358] = 2;
		[10359] = 2;
		[10376] = ZN.BLACKROCK_SPIRE,
		[10393] = ZN.STRATHOLME,
		[10509] = ZN.BLACKROCK_SPIRE,
		[10558] = ZN.STRATHOLME,
		[10559] = 1;
		[10639] = 1;
		[10640] = 1;
		[10641] = 1;
		[10642] = 1;
		[10644] = 1;
		[10647] = 1;
		[10741] = 1;
		[10809] = ZN.STRATHOLME,
		[10817] = 2;
		[10818] = 2;
		[10819] = 2;
		[10821] = 2;
		[10823] = 2;
		[10824] = 2;
		[10825] = 2;
		[10826] = 2;
		[10827] = 2;
		[10828] = 2;
		[11383] = 2;
		[11447] = 1;
		[11467] = ZN.DIRE_MAUL,
		[11497] = 1;
		[11498] = 1;
		[11688] = 1;
		[12037] = 1;
		[12237] = ZN.MARAUDON,
		[12431] = 2;
		[12433] = 2;
		[12902] = ZN.BLACKFATHOM_DEEPS,
		[13896] = 1;
		[14221] = 2;
		[14222] = 2;
		[14223] = 2;
		[14224] = 2;
		[14225] = 1;
		[14226] = 1;
		[14227] = 1;
		[14228] = 1;
		[14229] = 1;
		[14230] = 1;
		[14231] = 1;
		[14232] = 1;
		[14233] = 1;
		[14234] = 1;
		[14235] = 1;
		[14236] = 1;
		[14237] = 1;
		[14266] = 2;
		[14267] = 2;
		[14268] = 2;
		[14269] = 2;
		[14270] = 2;
		[14271] = 2;
		[14272] = 2;
		[14273] = 2;
		[14275] = 2;
		[14276] = 2;
		[14277] = 2;
		[14278] = 2;
		[14279] = 2;
		[14280] = 2;
		[14281] = 2;
		[14339] = 1;
		[14340] = 1;
		[14342] = 1;
		[14343] = 1;
		[14344] = 1;
		[14345] = 1;
		[14424] = 2;
		[14425] = 2;
		[14426] = 1;
		[14427] = 1;
		[14428] = 1;
		[14429] = 1;
		[14430] = 1;
		[14431] = 1;
		[14432] = 1;
		[14433] = 2;
		[14445] = ZN.THE_TEMPLE_OF_ATALHAKKAR,
		[14446] = 2;
		[14447] = 2;
		[14448] = 2;
		[14471] = 1;
		[14472] = 1;
		[14473] = 1;
		[14474] = 1;
		[14475] = 1;
		[14476] = 1;
		[14477] = 1;
		[14478] = 1;
		[14479] = 1;
		[14487] = 2;
		[14488] = 2;
		[14490] = 2;
		[14491] = 2;
		[14492] = 2;
		[16179] = ZN.KARAZHAN,
		[16180] = ZN.KARAZHAN,
		[16181] = ZN.KARAZHAN,
		[16184] = 2;
		[16854] = 3;
		[16855] = 3;
		[18241] = 1;
		[18684] = 3;
		[21724] = 3;
		[22060] = 3;
		[22062] = 3;
		[32491] = 4;
		[33776] = 4;
		[35189] = 4;
		[38453] = 4;
		[39183] = 1;
		[39185] = 1;
		[39186] = 1;
		[43488] = 1;
		[43613] = 1;
		[43720] = 1;
		[44224] = 2;
		[44225] = 2;
		[44226] = 2;
		[44227] = 2;
		[44714] = 1;
		[44722] = 1;
		[44750] = 1;
		[44759] = 1;
		[44761] = 1;
		[44767] = 1;
		[45257] = 2;
		[45258] = 2;
		[45260] = 2;
		[45262] = 2;
		[45369] = 2;
		[45380] = 2;
		[45384] = 2;
		[45398] = 2;
		[45399] = 2;
		[45401] = 2;
		[45402] = 2;
		[45404] = 2;
		[45739] = 2;
		[45740] = 2;
		[45771] = 2;
		[45785] = 2;
		[45801] = 2;
		[45811] = 2;
		[46981] = 2;
		[46992] = 2;
		[47003] = 2;
		[47008] = 2;
		[47009] = 2;
		[47010] = 2;
		[47012] = 2;
		[47015] = 2;
		[47023] = 2;
		[47386] = 1;
		[47387] = 1;
		[49822] = ZN.DEEPHOLM;
		[49913] = 2;
		[50005] = 2;
		[50050] = 2;
		[50051] = 2;
		[50052] = 2;
		[50053] = 1;
		[50057] = 1;
		[50058] = 1;
		[50059] = ZN.DEEPHOLM;
		[50060] = ZN.DEEPHOLM;
		[50062] = ZN.DEEPHOLM;
		[50064] = 1;
		[50065] = 1;
		[50085] = 2;
		[50086] = 2;
		[50138] = 2;
		[50154] = 1;
		[50159] = 2;
		[50328] = 2;
		[50329] = 1;
		[50330] = 2;
		[50335] = 2;
		[50337] = 2;
		[50342] = 1;
		[50343] = 1;
		[50345] = 2;
		[50346] = 1;
		[50348] = 1;
		[50353] = 1;
		[50357] = 2;
		[50361] = 2;
		[50362] = 1;
		[50370] = 1;
		[50724] = 1;
		[50725] = 2;
		[50726] = 2;
		[50727] = 1;
		[50728] = 2;
		[50730] = 2;
		[50731] = 2;
		[50735] = 1;
		[50737] = 1;
		[50738] = 2;
		[50741] = 1;
		[50742] = 1;
		[50743] = 1;
		[50744] = 1;
		[50745] = 1;
		[50746] = 1;
		[50747] = 1;
		[50748] = 1;
		[50752] = 2;
		[50759] = 1;
		[50763] = 2;
		[50764] = 1;
		[50765] = 2;
		[50770] = 2;
		[50775] = 2;
		[50777] = 1;
		[50778] = 2;
		[50779] = 2;
		[50784] = 1;
		[50785] = 1;
		[50786] = 1;
		[50788] = 1;
		[50790] = 2;
		[50792] = 2;
		[50797] = 2;
		[50803] = 2;
		[50804] = 2;
		[50807] = 2;
		[50809] = 2;
		[50810] = 2;
		[50812] = 1;
		[50813] = 2;
		[50814] = 2;
		[50815] = ZN.MOLTEN_FRONT;
		[50818] = 2;
		[50819] = 1;
		[50825] = 1;
		[50833] = 1;
		[50837] = 2;
		[50838] = 2;
		[50839] = 2;
		[50842] = 2;
		[50846] = 2;
		[50855] = 2;
		[50856] = 2;
		[50858] = 2;
		[50864] = 1;
		[50865] = 2;
		[50875] = 1;
		[50876] = 2;
		[50882] = 2;
		[50884] = 1;
		[50886] = 2;
		[50891] = 2;
		[50892] = 1;
		[50895] = 1;
		[50897] = 1;
		[50901] = 1;
		[50903] = 2;
		[50905] = 1;
		[50906] = 2;
		[50908] = 2;
		[50915] = 2;
		[50916] = 2;
		[50922] = 2;
		[50925] = 1;
		[50926] = 2;
		[50929] = 2;
		[50930] = 2;
		[50931] = 2;
		[50937] = 2;
		[50940] = 2;
		[50942] = 2;
		[50945] = 1;
		[50946] = 2;
		[50947] = 2;
		[50948] = 2;
		[50949] = 2;
		[50952] = 1;
		[50955] = 2;
		[50957] = 1;
		[50959] = ZN.MOLTEN_FRONT;
		[50964] = 2;
		[50967] = 2;
		[50986] = 1;
		[50993] = 1;
		[50995] = 1;
		[50997] = 1;
		[51000] = 2;
		[51001] = 1;
		[51002] = 2;
		[51004] = 1;
		[51007] = 2;
		[51008] = 1;
		[51010] = 2;
		[51014] = 2;
		[51017] = 1;
		[51018] = 2;
		[51021] = 2;
		[51022] = 2;
		[51025] = 1;
		[51026] = 2;
		[51027] = 2;
		[51028] = 1;
		[51029] = 2;
		[51031] = 2;
		[51037] = 2;
		[51040] = 2;
		[51042] = 2;
		[51044] = 2;
		[51045] = 1;
		[51046] = 1;
		[51048] = 2;
		[51052] = 2;
		[51053] = 2;
		[51057] = 2;
		[51058] = 2;
		[51061] = 1;
		[51062] = 1;
		[51063] = 2;
		[51066] = 2;
		[51067] = 2;
		[51069] = 1;
		[51071] = 2;
		[51076] = 2;
		[51077] = 2;
		[51079] = 2;
		[51401] = 1;
		[51402] = 1;
		[51403] = 1;
		[51404] = 1;
		[51658] = 2;
		[51661] = 2;
		[51662] = 2;
		[51663] = 2;
		[52146] = 2;
		[54318] = 1;
		[54319] = 1;
		[54320] = 1;
		[54321] = ZN.MOLTEN_FRONT;
		[54322] = ZN.MOLTEN_FRONT;
		[54323] = ZN.MOLTEN_FRONT;
		[54324] = ZN.MOLTEN_FRONT;
		[54338] = ZN.MOLTEN_FRONT;
		[54533] = 1;
		[56081] = ZN.HILLSBRAD_FOOTHILLS,
		[58474] = 6;
		[58768] = 6;
		[58769] = 6;
		[58778] = 6;
		[58817] = 6;
		[59369] = ZN.SCHOLOMANCE,
		[62880] = 6;
		[63101] = 6;
		[63510] = 6;
		[63691] = 6;
		[63977] = 6;
		[68317] = 6;
		[68318] = 6;
		[68319] = 6;
		[68320] = 6;
		[68321] = 6;
		[68322] = 6;
		[69768] = 6;
		[69769] = 6;
		[69841] = 6;
		[69842] = 6;
		[69843] = ZN.ISLE_OF_THUNDER;
		[70096] = 6;
		[70126] = 6;
		[70238] = ZN.ISLE_OF_THUNDER;
		[70249] = ZN.ISLE_OF_THUNDER;
		[70276] = ZN.ISLE_OF_THUNDER;
		[70323] = 6;
		[70430] = ZN.ISLE_OF_THUNDER;
		[70440] = ZN.ISLE_OF_THUNDER;
		[70530] = ZN.ISLE_OF_THUNDER;
		[72049] = 6;
		[73293] = 6;
		[73666] = 6;
	},
	map_names = {
		[61] = ZN.ELWYNN_FOREST,
		[62] = ZN.NORTHSHIRE,
		[79] = ZN.ELWYNN_FOREST,
		[99] = ZN.ELWYNN_FOREST,
		[100] = ZN.ELWYNN_FOREST,
		[462] = ZN.WESTFALL,
		[471] = ZN.ELWYNN_FOREST,
		[472] = ZN.ELWYNN_FOREST,
		[506] = ZN.WESTFALL,
		[507] = ZN.DUSKWOOD,
		[519] = ZN.WESTFALL,
		[520] = ZN.WESTFALL,
		[521] = ZN.DUSKWOOD,
		[534] = ZN.DUSKWOOD,
		[572] = ZN.WESTFALL,
		[573] = ZN.WESTFALL,
		[574] = ZN.DUSKWOOD,
		[584] = ZN.REDRIDGE_MOUNTAINS,
		[596] = ZN.THE_DEADMINES,
		[599] = ZN.THE_DEADMINES,
		[616] = ZN.REDRIDGE_MOUNTAINS,
		[763] = ZN.SWAMP_OF_SORROWS,
		[947] = ZN.REDRIDGE_MOUNTAINS,
		[1063] = ZN.SWAMP_OF_SORROWS,
		[1106] = ZN.SWAMP_OF_SORROWS,
		[1112] = ZN.WETLANDS,
		[1119] = ZN.DUN_MOROGH,
		[1130] = ZN.DUN_MOROGH,
		[1132] = ZN.NEW_TINKERTOWN,
		[1137] = ZN.DUN_MOROGH,
		[1140] = ZN.WETLANDS,
		[1260] = ZN.DUN_MOROGH,
		[1398] = ZN.LOCH_MODAN,
		[1399] = ZN.LOCH_MODAN,
		[1424] = ZN.WESTFALL,
		[1425] = ZN.LOCH_MODAN,
		[1531] = ZN.TIRISFAL_GLADES,
		[1533] = ZN.TIRISFAL_GLADES,
		[1552] = ZN.THE_CAPE_OF_STRANGLETHORN,
		[1837] = ZN.WESTERN_PLAGUELANDS,
		[1838] = ZN.WESTERN_PLAGUELANDS,
		[1839] = ZN.WESTERN_PLAGUELANDS,
		[1841] = ZN.WESTERN_PLAGUELANDS,
		[1843] = ZN.EASTERN_PLAGUELANDS,
		[1844] = ZN.EASTERN_PLAGUELANDS,
		[1847] = ZN.WESTERN_PLAGUELANDS,
		[1848] = ZN.WESTERN_PLAGUELANDS,
		[1849] = ZN.WESTERN_PLAGUELANDS,
		[1850] = ZN.SCHOLOMANCE,
		[1851] = ZN.WESTERN_PLAGUELANDS,
		[1885] = ZN.WESTERN_PLAGUELANDS,
		[1910] = ZN.TIRISFAL_GLADES,
		[1911] = ZN.TIRISFAL_GLADES,
		[1936] = ZN.TIRISFAL_GLADES,
		[2090] = ZN.WETLANDS,
		[2108] = ZN.WETLANDS,
		[2162] = ZN.TELDRASSIL,
		[2172] = ZN.DARKSHORE,
		[2175] = ZN.DARKSHORE,
		[2184] = ZN.DARKSHORE,
		[2186] = ZN.DARKSHORE,
		[2191] = ZN.DARKSHORE,
		[2192] = ZN.DARKSHORE,
		[2258] = ZN.HILLSBRAD_FOOTHILLS,
		[2452] = ZN.HILLSBRAD_FOOTHILLS,
		[2453] = ZN.HILLSBRAD_FOOTHILLS,
		[2476] = ZN.LOCH_MODAN,
		[2541] = ZN.THE_CAPE_OF_STRANGLETHORN,
		[2598] = ZN.ARATHI_HIGHLANDS,
		[2600] = ZN.ARATHI_HIGHLANDS,
		[2601] = ZN.ARATHI_HIGHLANDS,
		[2602] = ZN.ARATHI_HIGHLANDS,
		[2603] = ZN.ARATHI_HIGHLANDS,
		[2604] = ZN.ARATHI_HIGHLANDS,
		[2605] = ZN.ARATHI_HIGHLANDS,
		[2606] = ZN.ARATHI_HIGHLANDS,
		[2609] = ZN.ARATHI_HIGHLANDS,
		[2744] = ZN.BADLANDS,
		[2749] = ZN.BADLANDS,
		[2751] = ZN.BADLANDS,
		[2752] = ZN.BADLANDS,
		[2753] = ZN.BADLANDS,
		[2754] = ZN.BADLANDS,
		[2779] = ZN.ARATHI_HIGHLANDS,
		[2850] = ZN.BADLANDS,
		[2931] = ZN.BADLANDS,
		[3058] = ZN.MULGORE,
		[3068] = ZN.MULGORE,
		[3253] = ZN.SOUTHERN_BARRENS,
		[3270] = ZN.NORTHERN_BARRENS,
		[3295] = ZN.NORTHERN_BARRENS,
		[3398] = ZN.NORTHERN_BARRENS,
		[3470] = ZN.NORTHERN_BARRENS,
		[3535] = ZN.TELDRASSIL,
		[3581] = ZN.STORMWIND_CITY,
		[3652] = ZN.NORTHERN_BARRENS,
		[3672] = ZN.NORTHERN_BARRENS,
		[3735] = ZN.ASHENVALE,
		[3736] = ZN.ASHENVALE,
		[3792] = ZN.ASHENVALE,
		[3872] = ZN.SHADOWFANG_KEEP,
		[4066] = ZN.STONETALON_MOUNTAINS,
		[4132] = ZN.THOUSAND_NEEDLES,
		[4339] = ZN.DUSTWALLOW_MARSH,
		[4380] = ZN.DUSTWALLOW_MARSH,
		[4425] = ZN.RAZORFEN_KRAUL,
		[4842] = ZN.RAZORFEN_KRAUL,
		[5343] = ZN.FERALAS,
		[5345] = ZN.FERALAS,
		[5346] = ZN.FERALAS,
		[5347] = ZN.FERALAS,
		[5348] = ZN.SWAMP_OF_SORROWS,
		[5349] = ZN.FERALAS,
		[5350] = ZN.FERALAS,
		[5352] = ZN.FERALAS,
		[5354] = ZN.FERALAS,
		[5356] = ZN.FERALAS,
		[5785] = ZN.MULGORE,
		[5786] = ZN.MULGORE,
		[5787] = ZN.MULGORE,
		[5807] = ZN.MULGORE,
		[5809] = ZN.DUROTAR,
		[5822] = ZN.DUROTAR,
		[5823] = ZN.DUROTAR,
		[5824] = ZN.DUROTAR,
		[5826] = ZN.DUROTAR,
		[5828] = ZN.NORTHERN_BARRENS,
		[5829] = ZN.SOUTHERN_BARRENS,
		[5830] = ZN.NORTHERN_BARRENS,
		[5831] = ZN.NORTHERN_BARRENS,
		[5834] = ZN.SOUTHERN_BARRENS,
		[5835] = ZN.NORTHERN_BARRENS,
		[5836] = ZN.NORTHERN_BARRENS,
		[5837] = ZN.NORTHERN_BARRENS,
		[5838] = ZN.NORTHERN_BARRENS,
		[5841] = ZN.NORTHERN_BARRENS,
		[5842] = ZN.NORTHERN_BARRENS,
		[5847] = ZN.SOUTHERN_BARRENS,
		[5848] = ZN.SOUTHERN_BARRENS,
		[5849] = ZN.SOUTHERN_BARRENS,
		[5851] = ZN.SOUTHERN_BARRENS,
		[5859] = ZN.SOUTHERN_BARRENS,
		[5863] = ZN.SOUTHERN_BARRENS,
		[5864] = ZN.SOUTHERN_BARRENS,
		[5865] = ZN.NORTHERN_BARRENS,
		[5912] = ZN.WAILING_CAVERNS,
		[5915] = ZN.STONETALON_MOUNTAINS,
		[5928] = ZN.STONETALON_MOUNTAINS,
		[5930] = ZN.STONETALON_MOUNTAINS,
		[5932] = ZN.STONETALON_MOUNTAINS,
		[5933] = ZN.THOUSAND_NEEDLES,
		[5935] = ZN.THOUSAND_NEEDLES,
		[5937] = ZN.THOUSAND_NEEDLES,
		[6118] = ZN.AZSHARA,
		[6228] = ZN.GNOMEREGAN,
		[6581] = ZN.UNGORO_CRATER,
		[6582] = ZN.UNGORO_CRATER,
		[6583] = ZN.UNGORO_CRATER,
		[6584] = ZN.UNGORO_CRATER,
		[6585] = ZN.UNGORO_CRATER,
		[6648] = ZN.AZSHARA,
		[6649] = ZN.AZSHARA,
		[6650] = ZN.AZSHARA,
		[6651] = ZN.AZSHARA,
		[7015] = ZN.DARKSHORE,
		[7016] = ZN.DARKSHORE,
		[7017] = ZN.DARKSHORE,
		[7104] = ZN.FELWOOD,
		[7137] = ZN.FELWOOD,
		[7846] = ZN.BLASTED_LANDS,
		[8199] = ZN.TANARIS,
		[8200] = ZN.TANARIS,
		[8201] = ZN.TANARIS,
		[8203] = ZN.TANARIS,
		[8204] = ZN.TANARIS,
		[8205] = ZN.TANARIS,
		[8207] = ZN.TANARIS,
		[8210] = ZN.THE_HINTERLANDS,
		[8211] = ZN.THE_HINTERLANDS,
		[8212] = ZN.THE_HINTERLANDS,
		[8213] = ZN.THE_HINTERLANDS,
		[8214] = ZN.THE_HINTERLANDS,
		[8215] = ZN.THE_HINTERLANDS,
		[8216] = ZN.THE_HINTERLANDS,
		[8217] = ZN.THE_HINTERLANDS,
		[8218] = ZN.THE_HINTERLANDS,
		[8219] = ZN.THE_HINTERLANDS,
		[8277] = ZN.SEARING_GORGE,
		[8278] = ZN.SEARING_GORGE,
		[8279] = ZN.SEARING_GORGE,
		[8280] = ZN.SEARING_GORGE,
		[8281] = ZN.SEARING_GORGE,
		[8282] = ZN.SEARING_GORGE,
		[8283] = ZN.SEARING_GORGE,
		[8296] = ZN.BLASTED_LANDS,
		[8297] = ZN.BLASTED_LANDS,
		[8298] = ZN.BLASTED_LANDS,
		[8299] = ZN.BLASTED_LANDS,
		[8300] = ZN.BLASTED_LANDS,
		[8301] = ZN.BLASTED_LANDS,
		[8302] = ZN.BLASTED_LANDS,
		[8303] = ZN.BLASTED_LANDS,
		[8304] = ZN.BLASTED_LANDS,
		[8503] = ZN.NEW_TINKERTOWN,
		[8660] = ZN.AZSHARA,
		[8923] = ZN.BLACKROCK_DEPTHS,
		[8976] = ZN.BURNING_STEPPES,
		[8978] = ZN.BURNING_STEPPES,
		[8979] = ZN.BURNING_STEPPES,
		[8981] = ZN.BURNING_STEPPES,
		[9217] = ZN.BLACKROCK_SPIRE,
		[9218] = ZN.BLACKROCK_SPIRE,
		[9219] = ZN.BLACKROCK_SPIRE,
		[9596] = ZN.BLACKROCK_SPIRE,
		[9602] = ZN.BURNING_STEPPES,
		[9604] = ZN.BURNING_STEPPES,
		[9718] = ZN.BLACKROCK_SPIRE,
		[9736] = ZN.BLACKROCK_SPIRE,
		[10077] = ZN.BURNING_STEPPES,
		[10078] = ZN.BURNING_STEPPES,
		[10080] = ZN.ZULFARRAK,
		[10081] = ZN.ZULFARRAK,
		[10082] = ZN.ZULFARRAK,
		[10119] = ZN.BURNING_STEPPES,
		[10196] = ZN.WINTERSPRING,
		[10197] = ZN.WINTERSPRING,
		[10198] = ZN.WINTERSPRING,
		[10199] = ZN.WINTERSPRING,
		[10200] = ZN.WINTERSPRING,
		[10202] = ZN.WINTERSPRING,
		[10263] = ZN.BLACKROCK_SPIRE,
		[10356] = ZN.TIRISFAL_GLADES,
		[10357] = ZN.TIRISFAL_GLADES,
		[10358] = ZN.TIRISFAL_GLADES,
		[10359] = ZN.TIRISFAL_GLADES,
		[10376] = ZN.BLACKROCK_SPIRE,
		[10393] = ZN.STRATHOLME,
		[10509] = ZN.BLACKROCK_SPIRE,
		[10558] = ZN.STRATHOLME,
		[10559] = ZN.ASHENVALE,
		[10639] = ZN.ASHENVALE,
		[10640] = ZN.ASHENVALE,
		[10641] = ZN.ASHENVALE,
		[10642] = ZN.ASHENVALE,
		[10644] = ZN.ASHENVALE,
		[10647] = ZN.ASHENVALE,
		[10741] = ZN.WINTERSPRING,
		[10809] = ZN.STRATHOLME,
		[10817] = ZN.EASTERN_PLAGUELANDS,
		[10818] = ZN.EASTERN_PLAGUELANDS,
		[10819] = ZN.EASTERN_PLAGUELANDS,
		[10820] = ZN.STRATHOLME,
		[10821] = ZN.EASTERN_PLAGUELANDS,
		[10823] = ZN.EASTERN_PLAGUELANDS,
		[10824] = ZN.EASTERN_PLAGUELANDS,
		[10825] = ZN.EASTERN_PLAGUELANDS,
		[10826] = ZN.EASTERN_PLAGUELANDS,
		[10827] = ZN.EASTERN_PLAGUELANDS,
		[10828] = ZN.EASTERN_PLAGUELANDS,
		[11383] = ZN.NORTHERN_STRANGLETHORN,
		[11447] = ZN.FERALAS,
		[11467] = ZN.DIRE_MAUL,
		[11497] = ZN.FERALAS,
		[11498] = ZN.FERALAS,
		[11688] = ZN.DESOLACE,
		[12037] = ZN.ASHENVALE,
		[12237] = ZN.MARAUDON,
		[12431] = ZN.SILVERPINE_FOREST,
		[12433] = ZN.SILVERPINE_FOREST,
		[12902] = ZN.BLACKFATHOM_DEEPS,
		[13896] = ZN.AZSHARA,
		[14221] = ZN.HILLSBRAD_FOOTHILLS,
		[14222] = ZN.HILLSBRAD_FOOTHILLS,
		[14223] = ZN.HILLSBRAD_FOOTHILLS,
		[14224] = ZN.BADLANDS,
		[14225] = ZN.DESOLACE,
		[14226] = ZN.DESOLACE,
		[14227] = ZN.DESOLACE,
		[14228] = ZN.DESOLACE,
		[14229] = ZN.DESOLACE,
		[14230] = ZN.DUSTWALLOW_MARSH,
		[14231] = ZN.DUSTWALLOW_MARSH,
		[14232] = ZN.DUSTWALLOW_MARSH,
		[14233] = ZN.DUSTWALLOW_MARSH,
		[14234] = ZN.DUSTWALLOW_MARSH,
		[14235] = ZN.DUSTWALLOW_MARSH,
		[14236] = ZN.DUSTWALLOW_MARSH,
		[14237] = ZN.DUSTWALLOW_MARSH,
		[14266] = ZN.LOCH_MODAN,
		[14267] = ZN.LOCH_MODAN,
		[14268] = ZN.LOCH_MODAN,
		[14269] = ZN.REDRIDGE_MOUNTAINS,
		[14270] = ZN.REDRIDGE_MOUNTAINS,
		[14271] = ZN.REDRIDGE_MOUNTAINS,
		[14272] = ZN.REDRIDGE_MOUNTAINS,
		[14273] = ZN.REDRIDGE_MOUNTAINS,
		[14275] = ZN.HILLSBRAD_FOOTHILLS,
		[14276] = ZN.HILLSBRAD_FOOTHILLS,
		[14277] = ZN.HILLSBRAD_FOOTHILLS,
		[14278] = ZN.HILLSBRAD_FOOTHILLS,
		[14279] = ZN.HILLSBRAD_FOOTHILLS,
		[14280] = ZN.HILLSBRAD_FOOTHILLS,
		[14281] = ZN.HILLSBRAD_FOOTHILLS,
		[14339] = ZN.FELWOOD,
		[14340] = ZN.FELWOOD,
		[14342] = ZN.FELWOOD,
		[14343] = ZN.FELWOOD,
		[14344] = ZN.FELWOOD,
		[14345] = ZN.FELWOOD,
		[14424] = ZN.WETLANDS,
		[14425] = ZN.WETLANDS,
		[14426] = ZN.THOUSAND_NEEDLES,
		[14427] = ZN.THOUSAND_NEEDLES,
		[14428] = ZN.TELDRASSIL,
		[14429] = ZN.TELDRASSIL,
		[14430] = ZN.TELDRASSIL,
		[14431] = ZN.TELDRASSIL,
		[14432] = ZN.TELDRASSIL,
		[14433] = ZN.WETLANDS,
		[14445] = ZN.THE_TEMPLE_OF_ATALHAKKAR,
		[14446] = ZN.SWAMP_OF_SORROWS,
		[14447] = ZN.SWAMP_OF_SORROWS,
		[14448] = ZN.SWAMP_OF_SORROWS,
		[14471] = ZN.SILITHUS,
		[14472] = ZN.SILITHUS,
		[14473] = ZN.SILITHUS,
		[14474] = ZN.SILITHUS,
		[14475] = ZN.SILITHUS,
		[14476] = ZN.SILITHUS,
		[14477] = ZN.SILITHUS,
		[14478] = ZN.SILITHUS,
		[14479] = ZN.SILITHUS,
		[14487] = ZN.NORTHERN_STRANGLETHORN,
		[14488] = ZN.NORTHERN_STRANGLETHORN,
		[14490] = ZN.THE_CAPE_OF_STRANGLETHORN,
		[14491] = ZN.THE_CAPE_OF_STRANGLETHORN,
		[14492] = ZN.THE_CAPE_OF_STRANGLETHORN,
		[16179] = ZN.KARAZHAN,
		[16180] = ZN.KARAZHAN,
		[16181] = ZN.KARAZHAN,
		[16184] = ZN.EASTERN_PLAGUELANDS,
		[16854] = ZN.EVERSONG_WOODS,
		[16855] = ZN.EVERSONG_WOODS,
		[17144] = ZN.NAGRAND,
		[18241] = ZN.DESOLACE,
		[18677] = ZN.HELLFIRE_PENINSULA,
		[18678] = ZN.HELLFIRE_PENINSULA,
		[18679] = ZN.HELLFIRE_PENINSULA,
		[18680] = ZN.ZANGARMARSH,
		[18681] = ZN.ZANGARMARSH,
		[18682] = ZN.ZANGARMARSH,
		[18683] = ZN.NAGRAND,
		[18684] = ZN.NAGRAND,
		[18685] = ZN.TEROKKAR_FOREST,
		[18686] = ZN.TEROKKAR_FOREST,
		[18689] = ZN.TEROKKAR_FOREST,
		[18690] = ZN.BLADES_EDGE_MOUNTAINS,
		[18692] = ZN.BLADES_EDGE_MOUNTAINS,
		[18693] = ZN.BLADES_EDGE_MOUNTAINS,
		[18694] = ZN.SHADOWMOON_VALLEY,
		[18695] = ZN.SHADOWMOON_VALLEY,
		[18696] = ZN.SHADOWMOON_VALLEY,
		[18697] = ZN.NETHERSTORM,
		[18698] = ZN.NETHERSTORM,
		[20932] = ZN.NETHERSTORM,
		[21724] = ZN.TEROKKAR_FOREST,
		[22060] = ZN.BLOODMYST_ISLE,
		[22062] = ZN.GHOSTLANDS,
		[32357] = ZN.BOREAN_TUNDRA,
		[32358] = ZN.BOREAN_TUNDRA,
		[32361] = ZN.BOREAN_TUNDRA,
		[32377] = ZN.HOWLING_FJORD,
		[32386] = ZN.HOWLING_FJORD,
		[32398] = ZN.HOWLING_FJORD,
		[32400] = ZN.DRAGONBLIGHT,
		[32409] = ZN.DRAGONBLIGHT,
		[32417] = ZN.DRAGONBLIGHT,
		[32422] = ZN.GRIZZLY_HILLS,
		[32429] = ZN.GRIZZLY_HILLS,
		[32438] = ZN.GRIZZLY_HILLS,
		[32447] = ZN.ZULDRAK,
		[32471] = ZN.ZULDRAK,
		[32475] = ZN.ZULDRAK,
		[32481] = ZN.SHOLAZAR_BASIN,
		[32485] = ZN.SHOLAZAR_BASIN,
		[32487] = ZN.ICECROWN,
		[32491] = ZN.THE_STORM_PEAKS,
		[32495] = ZN.ICECROWN,
		[32500] = ZN.THE_STORM_PEAKS,
		[32501] = ZN.ICECROWN,
		[32517] = ZN.SHOLAZAR_BASIN,
		[32630] = ZN.THE_STORM_PEAKS,
		[33776] = ZN.ZULDRAK,
		[35189] = ZN.THE_STORM_PEAKS,
		[38453] = ZN.GRIZZLY_HILLS,
		[39183] = ZN.TANARIS,
		[39185] = ZN.TANARIS,
		[39186] = ZN.TANARIS,
		[43488] = ZN.FERALAS,
		[43613] = ZN.MULGORE,
		[43720] = ZN.CAMP_NARACHE,
		[44224] = ZN.WETLANDS,
		[44225] = ZN.WETLANDS,
		[44226] = ZN.WETLANDS,
		[44227] = ZN.WETLANDS,
		[44714] = ZN.TANARIS,
		[44722] = ZN.TANARIS,
		[44750] = ZN.TANARIS,
		[44759] = ZN.TANARIS,
		[44761] = ZN.TANARIS,
		[44767] = ZN.TANARIS,
		[45257] = ZN.BLASTED_LANDS,
		[45258] = ZN.BLASTED_LANDS,
		[45260] = ZN.BLASTED_LANDS,
		[45262] = ZN.BLASTED_LANDS,
		[45369] = ZN.LOCH_MODAN,
		[45380] = ZN.LOCH_MODAN,
		[45384] = ZN.LOCH_MODAN,
		[45398] = ZN.LOCH_MODAN,
		[45399] = ZN.LOCH_MODAN,
		[45401] = ZN.LOCH_MODAN,
		[45402] = ZN.LOCH_MODAN,
		[45404] = ZN.LOCH_MODAN,
		[45739] = ZN.DUSKWOOD,
		[45740] = ZN.DUSKWOOD,
		[45771] = ZN.DUSKWOOD,
		[45785] = ZN.DUSKWOOD,
		[45801] = ZN.DUSKWOOD,
		[45811] = ZN.DUSKWOOD,
		[46981] = ZN.SILVERPINE_FOREST,
		[46992] = ZN.SILVERPINE_FOREST,
		[47003] = ZN.SILVERPINE_FOREST,
		[47008] = ZN.SILVERPINE_FOREST,
		[47009] = ZN.SILVERPINE_FOREST,
		[47010] = ZN.HILLSBRAD_FOOTHILLS,
		[47012] = ZN.SILVERPINE_FOREST,
		[47015] = ZN.SILVERPINE_FOREST,
		[47023] = ZN.SILVERPINE_FOREST,
		[47386] = ZN.TANARIS,
		[47387] = ZN.TANARIS,
		[49822] = ZN.DEEPHOLM,
		[49913] = ZN.KELPTHAR_FOREST,
		[50005] = ZN.SHIMMERING_EXPANSE,
		[50050] = ZN.ABYSSAL_DEPTHS,
		[50051] = ZN.ABYSSAL_DEPTHS,
		[50052] = ZN.SHIMMERING_EXPANSE,
		[50053] = ZN.MOUNT_HYJAL,
		[50057] = ZN.MOUNT_HYJAL,
		[50058] = ZN.MOUNT_HYJAL,
		[50059] = ZN.DEEPHOLM,
		[50060] = ZN.DEEPHOLM,
		[50062] = ZN.DEEPHOLM,
		[50064] = ZN.ULDUM,
		[50065] = ZN.ULDUM,
		[50085] = ZN.TWILIGHT_HIGHLANDS,
		[50086] = ZN.TWILIGHT_HIGHLANDS,
		[50138] = ZN.TWILIGHT_HIGHLANDS,
		[50154] = ZN.ULDUM,
		[50159] = ZN.TWILIGHT_HIGHLANDS,
		[50328] = ZN.DEATHKNELL,
		[50329] = ZN.THOUSAND_NEEDLES,
		[50330] = ZN.SILVERPINE_FOREST,
		[50331] = ZN.KRASARANG_WILDS,
		[50332] = ZN.KUN_LAI_SUMMIT,
		[50333] = ZN.TOWNLONG_STEPPES,
		[50334] = ZN.DREAD_WASTES,
		[50335] = ZN.HILLSBRAD_FOOTHILLS,
		[50336] = ZN.VALE_OF_ETERNAL_BLOSSOMS,
		[50337] = ZN.ARATHI_HIGHLANDS,
		[50338] = ZN.THE_JADE_FOREST,
		[50339] = ZN.VALLEY_OF_THE_FOUR_WINDS,
		[50340] = ZN.KRASARANG_WILDS,
		[50341] = ZN.KUN_LAI_SUMMIT,
		[50342] = ZN.DUSTWALLOW_MARSH,
		[50343] = ZN.STONETALON_MOUNTAINS,
		[50344] = ZN.TOWNLONG_STEPPES,
		[50345] = ZN.WESTERN_PLAGUELANDS,
		[50346] = ZN.WINTERSPRING,
		[50347] = ZN.DREAD_WASTES,
		[50348] = ZN.WINTERSPRING,
		[50349] = ZN.VALE_OF_ETERNAL_BLOSSOMS,
		[50350] = ZN.THE_JADE_FOREST,
		[50351] = ZN.VALLEY_OF_THE_FOUR_WINDS,
		[50352] = ZN.KRASARANG_WILDS,
		[50353] = ZN.WINTERSPRING,
		[50354] = ZN.KUN_LAI_SUMMIT,
		[50355] = ZN.TOWNLONG_STEPPES,
		[50356] = ZN.DREAD_WASTES,
		[50357] = ZN.BURNING_STEPPES,
		[50358] = ZN.ISLE_OF_THUNDER,
		[50359] = ZN.VALE_OF_ETERNAL_BLOSSOMS,
		[50361] = ZN.BURNING_STEPPES,
		[50362] = ZN.FELWOOD,
		[50363] = ZN.THE_JADE_FOREST,
		[50364] = ZN.VALLEY_OF_THE_FOUR_WINDS,
		[50370] = ZN.SILITHUS,
		[50388] = ZN.KRASARANG_WILDS,
		[50724] = ZN.FELWOOD,
		[50725] = ZN.BURNING_STEPPES,
		[50726] = ZN.BADLANDS,
		[50727] = ZN.THOUSAND_NEEDLES,
		[50728] = ZN.BADLANDS,
		[50730] = ZN.BURNING_STEPPES,
		[50731] = ZN.BADLANDS,
		[50733] = ZN.KUN_LAI_SUMMIT,
		[50734] = ZN.TOWNLONG_STEPPES,
		[50735] = ZN.DUSTWALLOW_MARSH,
		[50737] = ZN.SILITHUS,
		[50738] = ZN.SWAMP_OF_SORROWS,
		[50739] = ZN.DREAD_WASTES,
		[50741] = ZN.THOUSAND_NEEDLES,
		[50742] = ZN.SILITHUS,
		[50743] = ZN.SILITHUS,
		[50744] = ZN.SILITHUS,
		[50745] = ZN.SILITHUS,
		[50746] = ZN.SILITHUS,
		[50747] = ZN.AHNQIRAJ_THE_FALLEN_KINGDOM,
		[50748] = ZN.THOUSAND_NEEDLES,
		[50749] = ZN.VALE_OF_ETERNAL_BLOSSOMS,
		[50750] = ZN.THE_JADE_FOREST,
		[50752] = ZN.ELWYNN_FOREST,
		[50759] = ZN.STONETALON_MOUNTAINS,
		[50763] = ZN.TIRISFAL_GLADES,
		[50764] = ZN.DUSTWALLOW_MARSH,
		[50765] = ZN.HILLSBRAD_FOOTHILLS,
		[50766] = ZN.VALLEY_OF_THE_FOUR_WINDS,
		[50768] = ZN.KRASARANG_WILDS,
		[50769] = ZN.KUN_LAI_SUMMIT,
		[50770] = ZN.HILLSBRAD_FOOTHILLS,
		[50772] = ZN.TOWNLONG_STEPPES,
		[50775] = ZN.EASTERN_PLAGUELANDS,
		[50776] = ZN.DREAD_WASTES,
		[50777] = ZN.FELWOOD,
		[50778] = ZN.WESTERN_PLAGUELANDS,
		[50779] = ZN.EASTERN_PLAGUELANDS,
		[50780] = ZN.VALE_OF_ETERNAL_BLOSSOMS,
		[50782] = ZN.THE_JADE_FOREST,
		[50783] = ZN.VALLEY_OF_THE_FOUR_WINDS,
		[50784] = ZN.DUSTWALLOW_MARSH,
		[50785] = ZN.THOUSAND_NEEDLES,
		[50786] = ZN.STONETALON_MOUNTAINS,
		[50787] = ZN.KRASARANG_WILDS,
		[50788] = ZN.WINTERSPRING,
		[50789] = ZN.KUN_LAI_SUMMIT,
		[50790] = ZN.SWAMP_OF_SORROWS,
		[50791] = ZN.TOWNLONG_STEPPES,
		[50792] = ZN.BURNING_STEPPES,
		[50797] = ZN.SWAMP_OF_SORROWS,
		[50803] = ZN.TIRISFAL_GLADES,
		[50804] = ZN.ARATHI_HIGHLANDS,
		[50805] = ZN.DREAD_WASTES,
		[50806] = ZN.VALE_OF_ETERNAL_BLOSSOMS,
		[50807] = ZN.BURNING_STEPPES,
		[50808] = ZN.THE_JADE_FOREST,
		[50809] = ZN.WESTERN_PLAGUELANDS,
		[50810] = ZN.BURNING_STEPPES,
		[50811] = ZN.VALLEY_OF_THE_FOUR_WINDS,
		[50812] = ZN.STONETALON_MOUNTAINS,
		[50813] = ZN.EASTERN_PLAGUELANDS,
		[50814] = ZN.SILVERPINE_FOREST,
		[50815] = ZN.MOLTEN_FRONT,
		[50816] = ZN.KRASARANG_WILDS,
		[50817] = ZN.KUN_LAI_SUMMIT,
		[50818] = ZN.HILLSBRAD_FOOTHILLS,
		[50819] = ZN.WINTERSPRING,
		[50820] = ZN.TOWNLONG_STEPPES,
		[50821] = ZN.DREAD_WASTES,
		[50822] = ZN.VALE_OF_ETERNAL_BLOSSOMS,
		[50823] = ZN.THE_JADE_FOREST,
		[50825] = ZN.STONETALON_MOUNTAINS,
		[50828] = ZN.VALLEY_OF_THE_FOUR_WINDS,
		[50830] = ZN.KRASARANG_WILDS,
		[50831] = ZN.KUN_LAI_SUMMIT,
		[50832] = ZN.TOWNLONG_STEPPES,
		[50833] = ZN.FELWOOD,
		[50836] = ZN.DREAD_WASTES,
		[50837] = ZN.SWAMP_OF_SORROWS,
		[50838] = ZN.BADLANDS,
		[50840] = ZN.VALE_OF_ETERNAL_BLOSSOMS,
		[50842] = ZN.BURNING_STEPPES,
		[50846] = ZN.SEARING_GORGE,
		[50855] = ZN.BURNING_STEPPES,
		[50856] = ZN.EASTERN_PLAGUELANDS,
		[50858] = ZN.HILLSBRAD_FOOTHILLS,
		[50864] = ZN.FELWOOD,
		[50865] = ZN.ARATHI_HIGHLANDS,
		[50874] = ZN.STONETALON_MOUNTAINS,
		[50875] = ZN.DUSTWALLOW_MARSH,
		[50876] = ZN.SEARING_GORGE,
		[50882] = ZN.SWAMP_OF_SORROWS,
		[50884] = ZN.STONETALON_MOUNTAINS,
		[50886] = ZN.SWAMP_OF_SORROWS,
		[50891] = ZN.ARATHI_HIGHLANDS,
		[50892] = ZN.THOUSAND_NEEDLES,
		[50895] = ZN.STONETALON_MOUNTAINS,
		[50897] = ZN.SILITHUS,
		[50901] = ZN.DUSTWALLOW_MARSH,
		[50903] = ZN.SWAMP_OF_SORROWS,
		[50905] = ZN.FELWOOD,
		[50906] = ZN.WESTERN_PLAGUELANDS,
		[50908] = ZN.TIRISFAL_GLADES,
		[50915] = ZN.EASTERN_PLAGUELANDS,
		[50916] = ZN.ELWYNN_FOREST,
		[50922] = ZN.WESTERN_PLAGUELANDS,
		[50925] = ZN.FELWOOD,
		[50926] = ZN.ELWYNN_FOREST,
		[50929] = ZN.HILLSBRAD_FOOTHILLS,
		[50930] = ZN.TIRISFAL_GLADES,
		[50931] = ZN.WESTERN_PLAGUELANDS,
		[50937] = ZN.WESTERN_PLAGUELANDS,
		[50940] = ZN.ARATHI_HIGHLANDS,
		[50942] = ZN.ELWYNN_FOREST,
		[50945] = ZN.DUSTWALLOW_MARSH,
		[50946] = ZN.SEARING_GORGE,
		[50947] = ZN.EASTERN_PLAGUELANDS,
		[50948] = ZN.SEARING_GORGE,
		[50949] = ZN.SILVERPINE_FOREST,
		[50952] = ZN.THOUSAND_NEEDLES,
		[50955] = ZN.HILLSBRAD_FOOTHILLS,
		[50957] = ZN.DUSTWALLOW_MARSH,
		[50959] = ZN.MOLTEN_FRONT,
		[50964] = ZN.WETLANDS,
		[50967] = ZN.HILLSBRAD_FOOTHILLS,
		[50986] = ZN.STONETALON_MOUNTAINS,
		[50993] = ZN.WINTERSPRING,
		[50995] = ZN.WINTERSPRING,
		[50997] = ZN.WINTERSPRING,
		[51000] = ZN.BADLANDS,
		[51001] = ZN.THOUSAND_NEEDLES,
		[51002] = ZN.SEARING_GORGE,
		[51004] = ZN.SILITHUS,
		[51007] = ZN.BADLANDS,
		[51008] = ZN.THOUSAND_NEEDLES,
		[51010] = ZN.SEARING_GORGE,
		[51014] = ZN.ELWYNN_FOREST,
		[51017] = ZN.FELWOOD,
		[51018] = ZN.BADLANDS,
		[51021] = ZN.BADLANDS,
		[51022] = ZN.HILLSBRAD_FOOTHILLS,
		[51025] = ZN.FELWOOD,
		[51026] = ZN.SILVERPINE_FOREST,
		[51027] = ZN.EASTERN_PLAGUELANDS,
		[51028] = ZN.WINTERSPRING,
		[51029] = ZN.WESTERN_PLAGUELANDS,
		[51031] = ZN.WESTERN_PLAGUELANDS,
		[51037] = ZN.SILVERPINE_FOREST,
		[51040] = ZN.ARATHI_HIGHLANDS,
		[51042] = ZN.EASTERN_PLAGUELANDS,
		[51044] = ZN.TIRISFAL_GLADES,
		[51045] = ZN.WINTERSPRING,
		[51046] = ZN.FELWOOD,
		[51048] = ZN.SEARING_GORGE,
		[51052] = ZN.SWAMP_OF_SORROWS,
		[51053] = ZN.EASTERN_PLAGUELANDS,
		[51057] = ZN.HILLSBRAD_FOOTHILLS,
		[51058] = ZN.WESTERN_PLAGUELANDS,
		[51059] = ZN.VALLEY_OF_THE_FOUR_WINDS,
		[51061] = ZN.DUSTWALLOW_MARSH,
		[51062] = ZN.STONETALON_MOUNTAINS,
		[51063] = ZN.ARATHI_HIGHLANDS,
		[51067] = ZN.ARATHI_HIGHLANDS,
		[51069] = ZN.DUSTWALLOW_MARSH,
		[51071] = ZN.SHIMMERING_EXPANSE,
		[51076] = ZN.HILLSBRAD_FOOTHILLS,
		[51077] = ZN.ELWYNN_FOREST,
		[51078] = ZN.THE_JADE_FOREST,
		[51079] = ZN.VASHJIR,
		[51401] = ZN.ULDUM,
		[51402] = ZN.ULDUM,
		[51403] = ZN.ULDUM,
		[51404] = ZN.ULDUM,
		[51658] = ZN.NORTHERN_STRANGLETHORN,
		[51661] = ZN.NORTHERN_STRANGLETHORN,
		[51662] = ZN.NORTHERN_STRANGLETHORN,
		[51663] = ZN.NORTHERN_STRANGLETHORN,
		[52146] = ZN.REDRIDGE_MOUNTAINS,
		[54318] = ZN.MOUNT_HYJAL,
		[54319] = ZN.MOUNT_HYJAL,
		[54320] = ZN.MOUNT_HYJAL,
		[54321] = ZN.MOLTEN_FRONT,
		[54322] = ZN.MOLTEN_FRONT,
		[54323] = ZN.MOLTEN_FRONT,
		[54324] = ZN.MOLTEN_FRONT,
		[54338] = ZN.MOLTEN_FRONT,
		[54533] = ZN.SILITHUS,
		[56081] = ZN.OLD_HILLSBRAD_FOOTHILLS,
		[58474] = ZN.VALE_OF_ETERNAL_BLOSSOMS,
		[58768] = ZN.VALE_OF_ETERNAL_BLOSSOMS,
		[58769] = ZN.VALE_OF_ETERNAL_BLOSSOMS,
		[58771] = ZN.VALE_OF_ETERNAL_BLOSSOMS,
		[58778] = ZN.VALE_OF_ETERNAL_BLOSSOMS,
		[58817] = ZN.VALE_OF_ETERNAL_BLOSSOMS,
		[58949] = ZN.VALE_OF_ETERNAL_BLOSSOMS,
		[59369] = ZN.SCHOLOMANCE,
		[62880] = ZN.VALE_OF_ETERNAL_BLOSSOMS,
		[62881] = ZN.VALE_OF_ETERNAL_BLOSSOMS,
		[63101] = ZN.VALE_OF_ETERNAL_BLOSSOMS,
		[63240] = ZN.VALE_OF_ETERNAL_BLOSSOMS,
		[63510] = ZN.VALE_OF_ETERNAL_BLOSSOMS,
		[63691] = ZN.VALE_OF_ETERNAL_BLOSSOMS,
		[63695] = ZN.VALE_OF_ETERNAL_BLOSSOMS,
		[63977] = ZN.VALE_OF_ETERNAL_BLOSSOMS,
		[63978] = ZN.VALE_OF_ETERNAL_BLOSSOMS,
		[68317] = ZN.KRASARANG_WILDS,
		[68318] = ZN.KRASARANG_WILDS,
		[68319] = ZN.KRASARANG_WILDS,
		[68320] = ZN.KRASARANG_WILDS,
		[68321] = ZN.KRASARANG_WILDS,
		[68322] = ZN.KRASARANG_WILDS,
		[69664] = ZN.ISLE_OF_THUNDER,
		[69768] = ZN.TOWNLONG_STEPPES,
		[69769] = ZN.TOWNLONG_STEPPES,
		[69841] = ZN.TOWNLONG_STEPPES,
		[69842] = ZN.DREAD_WASTES,
		[69843] = ZN.THRONE_OF_THUNDER,
		[69996] = ZN.ISLE_OF_THUNDER,
		[69997] = ZN.ISLE_OF_THUNDER,
		[69998] = ZN.ISLE_OF_THUNDER,
		[69999] = ZN.ISLE_OF_THUNDER,
		[70000] = ZN.ISLE_OF_THUNDER,
		[70001] = ZN.ISLE_OF_THUNDER,
		[70002] = ZN.ISLE_OF_THUNDER,
		[70003] = ZN.ISLE_OF_THUNDER,
		[70096] = ZN.ISLE_OF_GIANTS,
		[70126] = ZN.THE_VEILED_STAIR,
		[70238] = ZN.THRONE_OF_THUNDER,
		[70249] = ZN.THRONE_OF_THUNDER,
		[70276] = ZN.THRONE_OF_THUNDER,
		[70323] = ZN.KUN_LAI_SUMMIT,
		[70430] = ZN.THRONE_OF_THUNDER,
		[70440] = ZN.THRONE_OF_THUNDER,
		[70530] = ZN.ISLE_OF_THUNDER,
		[71864] = ZN.TIMELESS_ISLE,
		[71919] = ZN.TIMELESS_ISLE,
		[72045] = ZN.TIMELESS_ISLE,
		[72048] = ZN.TIMELESS_ISLE,
		[72049] = ZN.TIMELESS_ISLE,
		[72193] = ZN.TIMELESS_ISLE,
		[72245] = ZN.TIMELESS_ISLE,
		[72769] = ZN.TIMELESS_ISLE,
		[72775] = ZN.TIMELESS_ISLE,
		[72808] = ZN.TIMELESS_ISLE,
		[72909] = ZN.TIMELESS_ISLE,
		[72970] = ZN.TIMELESS_ISLE,
		[73157] = ZN.TIMELESS_ISLE,
		[73158] = ZN.TIMELESS_ISLE,
		[73160] = ZN.TIMELESS_ISLE,
		[73161] = ZN.TIMELESS_ISLE,
		[73163] = ZN.TIMELESS_ISLE,
		[73166] = ZN.TIMELESS_ISLE,
		[73167] = ZN.TIMELESS_ISLE,
		[73169] = ZN.TIMELESS_ISLE,
		[73170] = ZN.TIMELESS_ISLE,
		[73171] = ZN.TIMELESS_ISLE,
		[73172] = ZN.TIMELESS_ISLE,
		[73173] = ZN.TIMELESS_ISLE,
		[73174] = ZN.TIMELESS_ISLE,
		[73175] = ZN.TIMELESS_ISLE,
		[73277] = ZN.TIMELESS_ISLE,
		[73279] = ZN.TIMELESS_ISLE,
		[73281] = ZN.TIMELESS_ISLE,
		[73282] = ZN.TIMELESS_ISLE,
		[73293] = ZN.TIMELESS_ISLE,
		[73666] = ZN.TIMELESS_ISLE,
		[73704] = ZN.TIMELESS_ISLE,
		-- Non Standard Mobs
		[64004] = ZN.VALLEY_OF_THE_FOUR_WINDS, -- "Ghostly Pandaren Fisherman";
		[64191] = ZN.VALLEY_OF_THE_FOUR_WINDS, --"Ghostly Pandaren Craftsman";
		[50409] = ZN.ULDUM, --"Mysterious Camel Figurine";
		[50410] = ZN.ULDUM, --"Mysterious Camel Figurine";
		[62346] = ZN.VALLEY_OF_THE_FOUR_WINDS, --"Galleon";
		[60491] = ZN.KUN_LAI_SUMMIT, --"Sha of Anger";
		[69099] = ZN.ISLE_OF_THUNDER, --"Nalak";
		[69161] = ZN.ISLE_OF_GIANTS, --"Oondasta";
	},
	RareNPCs = {
		[61] = L.NPCs[61], -- "Thuros Lightfingers"
		[62] = L.NPCs[62], -- "Gug Fatcandle"
		[79] = L.NPCs[79], -- "Narg the Taskmaster"
		[99] = L.NPCs[99], -- "Morgaine the Sly"
		[100] = L.NPCs[100], -- "Gruff Swiftbite"
		[472] = L.NPCs[472], -- "Fedfennel"
		[506] = L.NPCs[506], -- "Sergeant Brashclaw"
		[507] = L.NPCs[507], -- "Fenros"
		[519] = L.NPCs[519], -- "Slark"
		[520] = L.NPCs[520], -- "Brack"
		[534] = L.NPCs[534], -- "Nefaru"
		[572] = L.NPCs[572], -- "Leprithus"
		[573] = L.NPCs[573], -- "Foe Reaper 4000"
		[584] = L.NPCs[584], -- "Kazon"
		[596] = L.NPCs[596], -- "Brainwashed Noble"
		[599] = L.NPCs[599], -- "Marisa du'Paige"
		[763] = L.NPCs[763], -- "Lost One Chieftain"
		[947] = L.NPCs[947], -- "Rohh the Silent"
		[1063] = L.NPCs[1063], -- "Jade"
		[1106] = L.NPCs[1106], -- "Lost One Cook"
		[1119] = L.NPCs[1119], -- "Hammerspine"
		[1137] = L.NPCs[1137], -- "Edan the Howler"
		[1260] = L.NPCs[1260], -- "Great Father Arctikus"
		[1398] = L.NPCs[1398], -- "Boss Galgosh"
		[1399] = L.NPCs[1399], -- "Magosh"
		[1424] = L.NPCs[1424], -- "Master Digger"
		[1425] = L.NPCs[1425], -- "Kubb"
		[1531] = L.NPCs[1531], -- "Lost Soul"
		[1533] = L.NPCs[1533], -- "Tormented Spirit"
		[1552] = L.NPCs[1552], -- "Scale Belly"
		[1837] = L.NPCs[1837], -- "Scarlet Judge"
		[1838] = L.NPCs[1838], -- "Scarlet Interrogator"
		[1839] = L.NPCs[1839], -- "Scarlet High Clerist"
		[1841] = L.NPCs[1841], -- "Scarlet Executioner"
		[1843] = L.NPCs[1843], -- "Foreman Jerris"
		[1844] = L.NPCs[1844], -- "Foreman Marcrid"
		[1847] = L.NPCs[1847], -- "Foulmane"
		[1848] = L.NPCs[1848], -- "Lord Maldazzar"
		[1849] = L.NPCs[1849], -- "Dreadwhisper"
		[1850] = L.NPCs[1850], -- "Putridius"
		[1851] = L.NPCs[1851], -- "The Husk"
		[1885] = L.NPCs[1885], -- "Scarlet Smith"
		[1910] = L.NPCs[1910], -- "Muad"
		[1911] = L.NPCs[1911], -- "Deeb"
		[1936] = L.NPCs[1936], -- "Farmer Solliden"
		[2090] = L.NPCs[2090], -- "Ma'ruk Wyrmscale"
		[2108] = L.NPCs[2108], -- "Garneg Charskull"
		[2162] = L.NPCs[2162], -- "Agal"
		[2184] = L.NPCs[2184], -- "Lady Moongazer"
		[2186] = L.NPCs[2186], -- "Carnivous the Breaker"
		[2191] = L.NPCs[2191], -- "Licillin"
		[2192] = L.NPCs[2192], -- "Firecaller Radison"
		[2258] = L.NPCs[2258], -- "Maggarrak"
		[2452] = L.NPCs[2452], -- "Skhowl"
		[2453] = L.NPCs[2453], -- "Lo'Grosh"
		[2541] = L.NPCs[2541], -- "Lord Sakrasis"
		[2598] = L.NPCs[2598], -- "Darbel Montrose"
		[2600] = L.NPCs[2600], -- "Singer"
		[2601] = L.NPCs[2601], -- "Foulbelly"
		[2602] = L.NPCs[2602], -- "Ruul Onestone"
		[2603] = L.NPCs[2603], -- "Kovork"
		[2604] = L.NPCs[2604], -- "Molok the Crusher"
		[2605] = L.NPCs[2605], -- "Zalas Witherbark"
		[2606] = L.NPCs[2606], -- "Nimar the Slayer"
		[2609] = L.NPCs[2609], -- "Geomancer Flintdagger"
		[2744] = L.NPCs[2744], -- "Shadowforge Commander"
		[2749] = L.NPCs[2749], -- "Barricade"
		[2751] = L.NPCs[2751], -- "War Golem"
		[2752] = L.NPCs[2752], -- "Rumbler"
		[2754] = L.NPCs[2754], -- "Anathemus"
		[2779] = L.NPCs[2779], -- "Prince Nazjak"
		[3058] = L.NPCs[3058], -- "Arra'chea"
		[3270] = L.NPCs[3270], -- "Elder Mystic Razorsnout"
		[3295] = L.NPCs[3295], -- "Sludge Anomaly"
		[3398] = L.NPCs[3398], -- "Gesharahan"
		[3470] = L.NPCs[3470], -- "Rathorian"
		[3535] = L.NPCs[3535], -- "Blackmoss the Fetid"
		[3652] = L.NPCs[3652], -- "Trigore the Lasher"
		[3672] = L.NPCs[3672], -- "Boahn"
		[3735] = L.NPCs[3735], -- "Apothecary Falthis"
		[3736] = L.NPCs[3736], -- "Darkslayer Mordenthal"
		[3773] = L.NPCs[3773], -- "Akkrilus"
		[3792] = L.NPCs[3792], -- "Terrowulf Packlord"
		[3872] = L.NPCs[3872], -- "Deathsworn Captain"
		[4066] = L.NPCs[4066], -- "Nal'taszar"
		[4339] = L.NPCs[4339], -- "Brimgore"
		[4842] = L.NPCs[4842], -- "Earthcaller Halmgar"
		[5343] = L.NPCs[5343], -- "Lady Szallah"
		[5345] = L.NPCs[5345], -- "Diamond Head"
		[5346] = L.NPCs[5346], -- "Bloodroar the Stalker"
		[5347] = L.NPCs[5347], -- "Antilus the Soarer"
		[5348] = L.NPCs[5348], -- "Dreamwatcher Forktongue"
		[5354] = L.NPCs[5354], -- "Gnarl Leafbrother"
		[5785] = L.NPCs[5785], -- "Sister Hatelash"
		[5786] = L.NPCs[5786], -- "Snagglespear"
		[5787] = L.NPCs[5787], -- "Enforcer Emilgund"
		[5809] = L.NPCs[5809], -- "Sergeant Curtis"
		[5822] = L.NPCs[5822], -- "Felweaver Scornn"
		[5824] = L.NPCs[5824], -- "Captain Flat Tusk"
		[5826] = L.NPCs[5826], -- "Geolord Mottle"
		[5830] = L.NPCs[5830], -- "Sister Rathtalon"
		[5831] = L.NPCs[5831], -- "Swiftmane"
		[5832] = L.NPCs[5832], -- "Thunderstomp"
		[5835] = L.NPCs[5835], -- "Foreman Grills"
		[5836] = L.NPCs[5836], -- "Engineer Whirleygig"
		[5837] = L.NPCs[5837], -- "Stonearm"
		[5838] = L.NPCs[5838], -- "Brokespear"
		[5841] = L.NPCs[5841], -- "Rocklance"
		[5847] = L.NPCs[5847], -- "Heggin Stonewhisker"
		[5848] = L.NPCs[5848], -- "Malgin Barleybrew"
		[5849] = L.NPCs[5849], -- "Digger Flameforge"
		[5851] = L.NPCs[5851], -- "Captain Gerogg Hammertoe"
		[5859] = L.NPCs[5859], -- "Hagg Taurenbane"
		[5863] = L.NPCs[5863], -- "Geopriest Gukk'rok"
		[5864] = L.NPCs[5864], -- "Swinegart Spearhide"
		[5912] = L.NPCs[5912], -- "Deviate Faerie Dragon"
		[5915] = L.NPCs[5915], -- "Brother Ravenoak"
		[5928] = L.NPCs[5928], -- "Sorrow Wing"
		[5930] = L.NPCs[5930], -- "Sister Riven"
		[5932] = L.NPCs[5932], -- "Taskmaster Whipfang"
		[5933] = L.NPCs[5933], -- "Achellios the Banished"
		[5935] = L.NPCs[5935], -- "Ironeye the Invincible"
		[6118] = L.NPCs[6118], -- "Varo'then's Ghost"
		[6228] = L.NPCs[6228], -- "Dark Iron Ambassador"
		[6583] = L.NPCs[6583], -- "Gruff"
		[6648] = L.NPCs[6648], -- "Antilos"
		[6649] = L.NPCs[6649], -- "Lady Sesspira"
		[6650] = L.NPCs[6650], -- "General Fangferror"
		[6651] = L.NPCs[6651], -- "Gatekeeper Rageroar"
		[7015] = L.NPCs[7015], -- "Flagglemurk the Cruel"
		[7016] = L.NPCs[7016], -- "Lady Vespira"
		[7017] = L.NPCs[7017], -- "Lord Sinslayer"
		[7104] = L.NPCs[7104], -- "Dessecus"
		[7137] = L.NPCs[7137], -- "Immolatus"
		[7846] = L.NPCs[7846], -- "Teremus the Devourer"
		[8199] = L.NPCs[8199], -- "Warleader Krazzilak"
		[8200] = L.NPCs[8200], -- "Jin'Zallah the Sandbringer"
		[8201] = L.NPCs[8201], -- "Omgorn the Lost"
		[8203] = L.NPCs[8203], -- "Kregg Keelhaul"
		[8210] = L.NPCs[8210], -- "Razortalon"
		[8212] = L.NPCs[8212], -- "The Reak"
		[8214] = L.NPCs[8214], -- "Jalinde Summerdrake"
		[8215] = L.NPCs[8215], -- "Grimungous"
		[8216] = L.NPCs[8216], -- "Retherokk the Berserker"
		[8217] = L.NPCs[8217], -- "Mith'rethis the Enchanter"
		[8218] = L.NPCs[8218], -- "Witherheart the Stalker"
		[8219] = L.NPCs[8219], -- "Zul'arek Hatefowler"
		[8278] = L.NPCs[8278], -- "Smoldar"
		[8279] = L.NPCs[8279], -- "Faulty War Golem"
		[8280] = L.NPCs[8280], -- "Shleipnarr"
		[8281] = L.NPCs[8281], -- "Scald"
		[8282] = L.NPCs[8282], -- "Highlord Mastrogonde"
		[8283] = L.NPCs[8283], -- "Slave Master Blackheart"
		[8296] = L.NPCs[8296], -- "Mojo the Twisted"
		[8297] = L.NPCs[8297], -- "Magronos the Unyielding"
		[8298] = L.NPCs[8298], -- "Akubar the Seer"
		[8302] = L.NPCs[8302], -- "Deatheye"
		[8304] = L.NPCs[8304], -- "Dreadscorn"
		[8503] = L.NPCs[8503], -- "Gibblewilt"
		[8923] = L.NPCs[8923], -- "Panzor the Invincible"
		[8924] = L.NPCs[8924], -- "The Behemoth"
		[8976] = L.NPCs[8976], -- "Hematos"
		[8978] = L.NPCs[8978], -- "Thauris Balgarr"
		[8979] = L.NPCs[8979], -- "Gruklash"
		[8981] = L.NPCs[8981], -- "Malfunctioning Reaver"
		[9217] = L.NPCs[9217], -- "Spirestone Lord Magus"
		[9218] = L.NPCs[9218], -- "Spirestone Battle Lord"
		[9219] = L.NPCs[9219], -- "Spirestone Butcher"
		[9596] = L.NPCs[9596], -- "Bannok Grimaxe"
		[9602] = L.NPCs[9602], -- "Hahk'Zor"
		[9604] = L.NPCs[9604], -- "Gorgon'och"
		[9718] = L.NPCs[9718], -- "Ghok Bashguud"
		[9736] = L.NPCs[9736], -- "Quartermaster Zigris"
		[10078] = L.NPCs[10078], -- "Terrorspark"
		[10080] = L.NPCs[10080], -- "Sandarr Dunereaver"
		[10081] = L.NPCs[10081], -- "Dustwraith"
		[10082] = L.NPCs[10082], -- "Zerillis"
		[10119] = L.NPCs[10119], -- "Volchan"
		[10196] = L.NPCs[10196], -- "General Colbatann"
		[10197] = L.NPCs[10197], -- "Mezzir the Howler"
		[10198] = L.NPCs[10198], -- "Kashoch the Reaver"
		[10199] = L.NPCs[10199], -- "Grizzle Snowpaw"
		[10202] = L.NPCs[10202], -- "Azurous"
		[10263] = L.NPCs[10263], -- "Burning Felguard"
		[10358] = L.NPCs[10358], -- "Fellicent's Shade"
		[10393] = L.NPCs[10393], -- "Skul"
		[10509] = L.NPCs[10509], -- "Jed Runewatcher"
		[10558] = L.NPCs[10558], -- "Hearthsinger Forresten"
		[10559] = L.NPCs[10559], -- "Lady Vespia"
		[10639] = L.NPCs[10639], -- "Rorgish Jowl"
		[10640] = L.NPCs[10640], -- "Oakpaw"
		[10641] = L.NPCs[10641], -- "Branch Snapper"
		[10642] = L.NPCs[10642], -- "Eck'alom"
		[10647] = L.NPCs[10647], -- "Prince Raze"
		[10809] = L.NPCs[10809], -- "Stonespine"
		[10817] = L.NPCs[10817], -- "Duggan Wildhammer"
		[10818] = L.NPCs[10818], -- "Death Knight Soulbearer"
		[10819] = L.NPCs[10819], -- "Baron Bloodbane"
		[10820] = L.NPCs[10820], -- "Duke Ragereaver"
		[10821] = L.NPCs[10821], -- "Hed'mush the Rotting"
		[10823] = L.NPCs[10823], -- "Zul'Brin Warpbranch"
		[10824] = L.NPCs[10824], -- "Death-Hunter Hawkspear"
		[10825] = L.NPCs[10825], -- "Gish the Unmoving"
		[10826] = L.NPCs[10826], -- "Lord Darkscythe"
		[10827] = L.NPCs[10827], -- "Deathspeaker Selendre"
		[10828] = L.NPCs[10828], -- "Lynnia Abbendis"
		[11383] = L.NPCs[11383], -- "High Priestess Hai'watna"
		[11447] = L.NPCs[11447], -- "Mushgog"
		[11467] = L.NPCs[11467], -- "Tsu'zee"
		[11498] = L.NPCs[11498], -- "Skarr the Broken"
		[11688] = L.NPCs[11688], -- "Cursed Centaur"
		[12237] = L.NPCs[12237], -- "Meshlok the Harvester"
		[12902] = L.NPCs[12902], -- "Lorgus Jett"
		[13896] = L.NPCs[13896], -- "Scalebeard"
		[14221] = L.NPCs[14221], -- "Gravis Slipknot"
		[14224] = L.NPCs[14224], -- "7:XT"
		[14225] = L.NPCs[14225], -- "Prince Kellen"
		[14226] = L.NPCs[14226], -- "Kaskk"
		[14227] = L.NPCs[14227], -- "Hissperak"
		[14229] = L.NPCs[14229], -- "Accursed Slitherblade"
		[14230] = L.NPCs[14230], -- "Burgle Eye"
		[14231] = L.NPCs[14231], -- "Drogoth the Roamer"
		[14235] = L.NPCs[14235], -- "The Rot"
		[14236] = L.NPCs[14236], -- "Lord Angler"
		[14267] = L.NPCs[14267], -- "Emogg the Crusher"
		[14269] = L.NPCs[14269], -- "Seeker Aqualon"
		[14270] = L.NPCs[14270], -- "Squiddic"
		[14271] = L.NPCs[14271], -- "Ribchaser"
		[14272] = L.NPCs[14272], -- "Snarlflare"
		[14273] = L.NPCs[14273], -- "Boulderheart"
		[14275] = L.NPCs[14275], -- "Tamra Stormpike"
		[14276] = L.NPCs[14276], -- "Scargil"
		[14277] = L.NPCs[14277], -- "Lady Zephris"
		[14278] = L.NPCs[14278], -- "Ro'Bark"
		[14281] = L.NPCs[14281], -- "Jimmy the Bleeder"
		[14340] = L.NPCs[14340], -- "Alshirr Banebreath"
		[14342] = L.NPCs[14342], -- "Ragepaw"
		[14345] = L.NPCs[14345], -- "The Ongar"
		[14424] = L.NPCs[14424], -- "Mirelow"
		[14425] = L.NPCs[14425], -- "Gnawbone"
		[14426] = L.NPCs[14426], -- "Harb Foulmountain"
		[14427] = L.NPCs[14427], -- "Gibblesnik"
		[14428] = L.NPCs[14428], -- "Uruson"
		[14429] = L.NPCs[14429], -- "Grimmaw"
		[14431] = L.NPCs[14431], -- "Fury Shelda"
		[14432] = L.NPCs[14432], -- "Threggil"
		[14433] = L.NPCs[14433], -- "Sludginn"
		[14445] = L.NPCs[14445], -- "Captain Wyrmak"
		[14446] = L.NPCs[14446], -- "Fingat"
		[14447] = L.NPCs[14447], -- "Gilmorian"
		[14448] = L.NPCs[14448], -- "Molt Thorn"
		[14471] = L.NPCs[14471], -- "Setis"
		[14478] = L.NPCs[14478], -- "Huricanian"
		[14479] = L.NPCs[14479], -- "Twilight Lord Everun"
		[14487] = L.NPCs[14487], -- "Gluggl"
		[14488] = L.NPCs[14488], -- "Roloch"
		[14490] = L.NPCs[14490], -- "Rippa"
		[14492] = L.NPCs[14492], -- "Verifonix"
		[16179] = L.NPCs[16179], -- "Hyakiss the Lurker"
		[16184] = L.NPCs[16184], -- "Nerubian Overseer"
		[16854] = L.NPCs[16854], -- "Eldinarcus"
		[16855] = L.NPCs[16855], -- "Tregla"
		[18684] = L.NPCs[18684], -- "Bro'Gaz the Clanless"
		[21724] = L.NPCs[21724], -- "Hawkbane"
		[22060] = L.NPCs[22060], -- "Fenissa the Assassin"
		[22062] = L.NPCs[22062], -- "Dr. Whitherlimb"
		--[ 32435 ] = L.NPCs[ 32435 ], -- "Vern"
		[32491] = L.NPCs[32491], -- "Time-Lost Proto-Drake"
		[39186] = L.NPCs[39186], -- "Hellgazer"
		[43488] = L.NPCs[43488], -- "Mordei the Earthrender"
		[43613] = L.NPCs[43613], -- "Doomsayer Wiserunner"
		[43720] = L.NPCs[43720], -- "\"Pokey\" Thornmantle"
		[44224] = L.NPCs[44224], -- "Two-Toes"
		[44225] = L.NPCs[44225], -- "Rufus Darkshot"
		[44226] = L.NPCs[44226], -- "Sarltooth"
		[44227] = L.NPCs[44227], -- "Gazz the Loch-Hunter"
		[44714] = L.NPCs[44714], -- "Fronkle the Disturbed"
		[44722] = L.NPCs[44722], -- "Twisted Reflection of Narain"
		[44750] = L.NPCs[44750], -- "Caliph Scorpidsting"
		[44759] = L.NPCs[44759], -- "Andre Firebeard"
		[44761] = L.NPCs[44761], -- "Aquementas the Unchained"
		[44767] = L.NPCs[44767], -- "Occulus the Corrupted"
		[45257] = L.NPCs[45257], -- "Mordak Nightbender"
		[45258] = L.NPCs[45258], -- "Cassia the Slitherqueen"
		[45260] = L.NPCs[45260], -- "Blackleaf"
		[45262] = L.NPCs[45262], -- "Narixxus the Doombringer"
		[45369] = L.NPCs[45369], -- "Morick Darkbrew"
		[45384] = L.NPCs[45384], -- "Sagepaw"
		[45398] = L.NPCs[45398], -- "Grizlak"
		[45399] = L.NPCs[45399], -- "Optimo"
		[45401] = L.NPCs[45401], -- "Whitefin"
		[45404] = L.NPCs[45404], -- "Geoshaper Maren"
		[45739] = L.NPCs[45739], -- "The Unknown Soldier"
		[45740] = L.NPCs[45740], -- "Watcher Eva"
		[45771] = L.NPCs[45771], -- "Marus"
		[45785] = L.NPCs[45785], -- "Carved One"
		[45801] = L.NPCs[45801], -- "Eliza"
		[45811] = L.NPCs[45811], -- "Marina DeSirrus"
		[46981] = L.NPCs[46981], -- "Nightlash"
		[46992] = L.NPCs[46992], -- "Berard the Moon-Crazed"
		[47003] = L.NPCs[47003], -- "Bolgaff"
		[47008] = L.NPCs[47008], -- "Fenwick Thatros"
		[47009] = L.NPCs[47009], -- "Aquarius the Unbound"
		[47010] = L.NPCs[47010], -- "Indigos"
		[47012] = L.NPCs[47012], -- "Effritus"
		[47015] = L.NPCs[47015], -- "Lost Son of Arugal"
		[47023] = L.NPCs[47023], -- "Thule Ravenclaw"
		[49913] = L.NPCs[49913], -- "Lady La-La"
		[50005] = L.NPCs[50005], -- "Poseidus"
		[50050] = L.NPCs[50050], -- "Shok'sharak"
		[50052] = L.NPCs[50052], -- "Burgy Blackheart"
		[50053] = L.NPCs[50053], -- "Thartuk the Exile"
		[50057] = L.NPCs[50057], -- "Blazewing"
		[50059] = L.NPCs[50059], -- "Golgarok"
		[50060] = L.NPCs[50060], -- "Terborus"
		[50062] = L.NPCs[50062], -- "Aeonaxx"
		[50064] = L.NPCs[50064], -- "Cyrus the Black"
		[50065] = L.NPCs[50065], -- "Armagedillo"
		[50085] = L.NPCs[50085], -- "Overlord Sunderfury"
		[50086] = L.NPCs[50086], -- "Tarvus the Vile"
		[51071] = L.NPCs[51071], -- "Captain Florence"
		[51079] = L.NPCs[51079], -- "Captain Foulwind"
		[51658] = L.NPCs[51658], -- "Mogh the Dead"
		[56081] = L.NPCs[56081], -- "Optimistic Benj"
		[58771] = L.NPCs[58771], -- "Quid"
		[58778] = L.NPCs[58778], -- "Aetha"
		[59369] = L.NPCs[59369], -- "Doctor Theolen Krastinov"
		[63510] = L.NPCs[63510], -- "Wulon"
		[68317] = L.NPCs[68317], -- "Mavis Harms"
		[68318] = L.NPCs[68318], -- "Dalan Nightbreaker"
		[68319] = L.NPCs[68319], -- "Disha Fearwarden"
		[68320] = L.NPCs[68320], -- "Ubunti the Shade"
		[68321] = L.NPCs[68321], -- "Kar Warmaker"
		[68322] = L.NPCs[68322], -- "Muerta"
		[69768] = L.NPCs[69768], -- "Zandalari Warscout"
		[69769] = L.NPCs[69769], -- "Zandalari Warbringer"
		[69841] = L.NPCs[69841], -- "Zandalari Warbringer"
		[69842] = L.NPCs[69842], -- "Zandalari Warbringer"
		[69843] = L.NPCs[69843], -- "Zao'cho"
		[70096] = L.NPCs[70096], -- "War-God Dokah"
		[70126] = L.NPCs[70126], -- "Willy Wilder"
		[70238] = L.NPCs[70238], -- "Unblinking Eye"
		[70243] = L.NPCs[70243], -- "Archritualist Kelada"
		[70249] = L.NPCs[70249], -- "Focused Eye"
		[70276] = L.NPCs[70276], -- "No'ku Stormsayer"
		[70323] = L.NPCs[70323], -- "Krakkanon"
		[70429] = L.NPCs[70429], -- "Flesh'rok the Diseased"
		[70430] = L.NPCs[70430], -- "Rocky Horror"
		[70440] = L.NPCs[70440], -- "Monara"
		[70530] = L.NPCs[70530], -- "Ra'sha"
		[72049] = L.NPCs[72049], -- "Cranegnasher"
		[73293] = L.NPCs[73293], -- "Whizzig"
		[73666] = L.NPCs[73666], -- "Archiereus of Flame"
	},
}

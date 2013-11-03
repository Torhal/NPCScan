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

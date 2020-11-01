-- ----------------------------------------------------------------------------
-- AddOn Namespace
-- ----------------------------------------------------------------------------
local AddOnFolderName, private = ...
local NPCs = private.Data.NPCs
local NPCClassification = private.Enum.NPCClassification

-- ----------------------------------------------------------------------------
-- Darkmoon Island (407)
-- ----------------------------------------------------------------------------
NPCs[71992] = { -- Moonfang
    classification = NPCClassification.Elite,
    pets = {
        {
            itemID = 101570, -- Moon Moon
            npcID = 72160, -- Moon Moon
        },
    },
    toys = {
        { itemID = 101571, }, -- Moonfang Shroud
        { itemID = 105898, }, -- Moonfang's Paw
    },
	vignetteID = 63, -- Moonfang
}

NPCs[122899] = { -- Death Metal Knight
    classification = NPCClassification.RareElite,
	questID = 47767, -- Death Metal Knight
	vignetteID = 2003, -- Death Metal Knight
}

-- ----------------------------------------------------------------------------
-- Nazjatar (1355)
-- ----------------------------------------------------------------------------
NPCs[144644] = { -- Mirecrawler
	questID = 56274, -- Unknown
}

NPCs[149653] = { -- Carnivorous Lasher
	questID = 55366, -- Unknown
}

NPCs[150191] = { -- Avarius
	questID = 55584, -- Unknown
}

NPCs[150468] = { -- Vor'koth
	questID = 55603, -- Unknown
}

NPCs[150583] = { -- Rockweed Shambler
	questID = 56291, -- Unknown
}

NPCs[151719] = { -- Voice in the Deeps
	questID = 56300, -- Unknown
}

NPCs[151870] = { -- Sandcastle
	questID = 56276, -- Unknown
}

NPCs[152290] = { -- Soundless
	questID = 56298, -- Unknown
}

NPCs[152323] = { -- King Gakula
	questID = 55671, -- Unknown
}

NPCs[152359] = { -- Siltstalker the Packmother
	questID = 56297, -- Unknown
}

NPCs[152360] = { -- Toxigore the Alpha
	questID = 56278, -- Unknown
}

NPCs[152361] = { -- Banescale the Packfather
	questID = 56282, -- Unknown
}

NPCs[152397] = { -- Oronu
	questID = 56288, -- Unknown
}

NPCs[152414] = { -- Elder Unu
	questID = 56284, -- Unknown
}

NPCs[152415] = { -- Alga the Eyeless
	questID = 56279, -- Unknown
}

NPCs[152416] = { -- Allseer Oma'kil
	questID = 56280, -- Unknown
}

NPCs[152448] = { -- Iridescent Glimmershell
	questID = 56286, -- Unknown
}

NPCs[152464] = { -- Caverndark Terror
	questID = 56283, -- Unknown
}

NPCs[152465] = { -- Needlespine
	questID = 56275, -- Unknown
}

NPCs[152542] = { -- Scale Matriarch Zodia
	questID = 56294, -- Unknown
}

NPCs[152545] = { -- Scale Matriarch Vynara
	questID = 56293, -- Unknown
}

NPCs[152548] = { -- Scale Matriarch Gratinax
	questID = 56292, -- Unknown
}

NPCs[152552] = { -- Shassera
	questID = 56295, -- Unknown
}

NPCs[152553] = { -- Garnetscale
	questID = 56273, -- Unknown
}

NPCs[152555] = { -- Elderspawn Nalaada
	questID = 56285, -- Unknown
}

NPCs[152556] = { -- Chasm-Haunter
	questID = 56270, -- Unknown
}

NPCs[152566] = { -- Anemonar
	questID = 56281, -- Unknown
}

NPCs[152567] = { -- Kelpwillow
	questID = 56287, -- Unknown
}

NPCs[152568] = { -- Urduu
	questID = 56299, -- Unknown
}

NPCs[152681] = { -- Prince Typhonus
	questID = 56289, -- Unknown
}

NPCs[152682] = { -- Prince Vortran
	questID = 56290, -- Unknown
}

NPCs[152712] = { -- Blindlight
	questID = 56269, -- Unknown
}

NPCs[152756] = { -- Daggertooth Terror
	questID = 56271, -- Unknown
}

NPCs[152794] = { -- Amethyst Spireshell
	questID = 56268, -- Unknown
}

NPCs[152795] = { -- Sandclaw Stoneshell
	questID = 56277, -- Unknown
}

NPCs[153303] = { -- Voidblade Kassar
	questID = 55900, -- Unknown
}

NPCs[153309] = { -- Alzana, Arrow of Thunder
	questID = 57169, -- Unknown
}

NPCs[153312] = { -- Kyx'zhul the Deepspeaker
	questID = 57168, -- Unknown
}

NPCs[153658] = { -- Shiz'narasz the Consumer
	questID = 56296, -- Unknown
}

NPCs[153898] = { -- Tidelord Aquatus
	questID = 56122, -- Unknown
}

NPCs[153928] = { -- Tidelord Dispersius
	questID = 56123, -- Unknown
}

NPCs[154148] = { -- Tidemistress Leth'sindra
	questID = 56106, -- Unknown
}

NPCs[155811] = { -- Commander Minzera
	questID = 56882, -- Unknown
}

NPCs[155838] = { -- Incantatrix Vazina
	questID = 56895, -- Unknown
}

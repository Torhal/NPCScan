--------------------------------------------------------------------------------
---- AddOn Namespace
--------------------------------------------------------------------------------
local AddOnFolderName = ... ---@type string
local private = select(2, ...) ---@class PrivateNamespace

local Maps = private.Data.Maps
local MapID = private.Enum.MapID

--------------------------------------------------------------------------------
---- Darkmon Island
--------------------------------------------------------------------------------
Maps[MapID.DarkmoonIsland].NPCs = {
    [71992] = true, -- Moonfang
    [122899] = true, -- Death Metal Knight
}

--------------------------------------------------------------------------------
---- Nazjatar
--------------------------------------------------------------------------------
Maps[MapID.Nazjatar].NPCs = {
    [144644] = true, -- Mirecrawler
    [149653] = true, -- Carnivorous Lasher
    [150191] = true, -- Avarius
    [150468] = true, -- Vor'koth
    [150583] = true, -- Rockweed Shambler
    [151719] = true, -- Voice in the Deeps
    [151870] = true, -- Sandcastle
    [152290] = true, -- Soundless
    [152291] = true, -- Deepglider
    [152323] = true, -- King Gakula
    [152359] = true, -- Siltstalker the Packmother
    [152360] = true, -- Toxigore the Alpha
    [152361] = true, -- Banescale the Packfather
    [152397] = true, -- Oronu
    [152414] = true, -- Elder Unu
    [152415] = true, -- Alga the Eyeless
    [152416] = true, -- Allseer Oma'kil
    [152448] = true, -- Iridescent Glimmershell
    [152464] = true, -- Caverndark Terror
    [152465] = true, -- Needlespine
    [152542] = true, -- Scale Matriarch Zodia
    [152545] = true, -- Scale Matriarch Vynara
    [152548] = true, -- Scale Matriarch Gratinax
    [152552] = true, -- Shassera
    [152553] = true, -- Garnetscale
    [152555] = true, -- Elderspawn Nalaada
    [152556] = true, -- Chasm-Haunter
    [152566] = true, -- Anemonar
    [152567] = true, -- Kelpwillow
    [152568] = true, -- Urduu
    [152681] = true, -- Prince Typhonus
    [152682] = true, -- Prince Vortran
    [152712] = true, -- Blindlight
    [152756] = true, -- Daggertooth Terror
    [152794] = true, -- Amethyst Spireshell
    [152795] = true, -- Sandclaw Stoneshell
    [153296] = true, -- Shalan'ali Stormtongue
    [153299] = true, -- Bonebreaker Szun
    [153300] = true, -- Iron Zoko
    [153301] = true, -- Shirakess Starseeker
    [153302] = true, -- Glacier Mage Zhiela
    [153303] = true, -- Voidblade Kassar
    [153304] = true, -- Undana Frostbarb
    [153305] = true, -- Zanj'ir Brutalizer
    [153309] = true, -- Alzana, Arrow of Thunder
    [153310] = true, -- Qalina, Spear of Ice
    [153311] = true, -- Slitherblade Azanz
    [153312] = true, -- Kyx'zhul the Deepspeaker
    [153314] = true, -- Aldrantiss
    [153658] = true, -- Shiz'narasz the Consumer
    [153898] = true, -- Tidelord Aquatus
    [153928] = true, -- Tidelord Dispersius
    [154148] = true, -- Tidemistress Leth'sindra
    [155811] = true, -- Commander Minzera
    [155836] = true, -- Theurgist Nitara
    [155838] = true, -- Incantatrix Vazina
    [155840] = true, -- Warlord Zalzjar
    [155841] = true, -- Shadowbinder Athissa
}

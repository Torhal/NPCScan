---@meta _

--------------------------------------------------------------------------------
---- Types
--------------------------------------------------------------------------------

---@class MountData
---@field itemID integer
---@field spellID integer

---@class PetData
---@field itemID integer
---@field npcID integer

---@class ToyData
---@field itemID integer

---@class NPCData
---@field achievementAssetName? string
---@field achievementCriteriaID? integer
---@field achievementID? integer
---@field achievementQuestID? integer
---@field classification? UnitClassification
---@field factionGroup? "Alliance" | "Horde"
---@field isCriteriaCompleted? boolean
---@field isTameable? boolean
---@field mapIDs? integer[]
---@field mounts? MountData[]
---@field npcID integer
---@field pets? PetData[]
---@field questID? integer
---@field toys? ToyData[]
---@field vignetteID? integer
---@field worldQuestID? integer

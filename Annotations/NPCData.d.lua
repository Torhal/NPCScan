---@meta _

--------------------------------------------------------------------------------
---- Types
--------------------------------------------------------------------------------

---@class MountData
---@field itemID ItemID
---@field spellID SpellID

---@class PetData
---@field itemID ItemID
---@field npcID NPCID

---@class ToyData
---@field itemID ItemID

---@class NPCData
---@field achievementAssetName? string
---@field achievementCriteriaID? AchievementCriteriaID
---@field achievementID? AchievementID
---@field achievementQuestID? QuestID
---@field classification? UnitClassification
---@field factionGroup? "Alliance" | "Horde"
---@field isCriteriaCompleted? boolean
---@field isTameable? boolean
---@field mapIDs? MapID[]
---@field mounts? MountData[]
---@field npcID NPCID
---@field pets? PetData[]
---@field questID? QuestID
---@field toys? ToyData[]
---@field vignetteID? VignetteID
---@field vignetteName? string
---@field worldQuestID? QuestID

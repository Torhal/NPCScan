--------------------------------------------------------------------------------
---- AddOn Namespace
--------------------------------------------------------------------------------
local AddOnFolderName = ... ---@type string
local private = select(2, ...) ---@class PrivateNamespace

local Data = private.Data
local Enum = private.Enum
local NPCs = Data.NPCs

local LibStub = _G.LibStub

local NPCScan = LibStub("AceAddon-3.0"):GetAddon(AddOnFolderName) ---@class NPCScan

--------------------------------------------------------------------------------
---- Constants
--------------------------------------------------------------------------------

---@class NPCClassification
local NPCClassification = {
    Elite = "elite",
    Minus = "minus",
    Normal = "normal",
    Rare = "rare",
    RareElite = "rareelite",
    Trivial = "trivial",
    WorldBoss = "worldboss",
}

Enum.NPCClassification = NPCClassification

---@type table<integer, table<integer, NPCData>>
local QuestNPCs = {}

private.QuestNPCs = QuestNPCs

local VignetteIDToNPCMapping = {}
private.VignetteIDToNPCMapping = VignetteIDToNPCMapping

--------------------------------------------------------------------------------
---- Prototype
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
---@field classification? NPCClassification
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
local NPCDataPrototype = {
    IsQuestComplete = function(self) end,
}

function NPCDataPrototype:HasQuest()
    local questID = self.questID or self.achievementQuestID

    return questID and questID >= 0
end

function NPCDataPrototype:HasActiveWorldQuest()
    local questID = self.worldQuestID

    if not questID then
        return false
    end

    return C_TaskQuest.IsActive(questID)
end

function NPCDataPrototype:IsAchievementCriteriaComplete()
    if not self.achievementID then
        return true
    end

    return Data.Achievements[self.achievementID].isCompleted or self.isCriteriaCompleted
end

function NPCDataPrototype:IsQuestComplete()
    local questID = self.questID or self.achievementQuestID

    return questID and questID >= 0 and C_QuestLog.IsQuestFlaggedCompleted(questID)
end

local NPCMetatable = {
    __index = NPCDataPrototype,
}

private.NPCMetatable = NPCMetatable

--------------------------------------------------------------------------------
---- Helpers
--------------------------------------------------------------------------------

---@param npc NPCData
---@param questFieldName "achievementQuestID" | "questID"
local function AssignNPCToQuest(npc, questFieldName)
    local questID = npc[questFieldName]

    if not questID then
        return
    end

    local questNPCs = QuestNPCs[questID]

    if not questNPCs then
        questNPCs = {}
        QuestNPCs[questID] = questNPCs
    end

    questNPCs[npc.npcID] = npc

    local questName = NPCScan:GetQuestNameFromID(questID)

    if questName and questName ~= UNKNOWN then
        private.QuestIDFromName[questName] = questID
    end
end

local function InitializeNPC(npcID)
    local npc = NPCs[npcID]

    if npc then
        if getmetatable(npc) then
            -- Already initialized.
            return npc
        end
    else
        npc = {
            npcID = npcID,
        }

        NPCs[npcID] = npc
    end

    setmetatable(npc, NPCMetatable)

    npc.npcID = npcID

    -- Sets value for NPCIDFromName.
    NPCScan:GetNPCNameFromID(npcID)

    AssignNPCToQuest(npc, "questID")
    AssignNPCToQuest(npc, "achievementQuestID")

    if npc.vignetteID then
        VignetteIDToNPCMapping[npc.vignetteID] = VignetteIDToNPCMapping[npc.vignetteID] or {}

        table.insert(VignetteIDToNPCMapping[npc.vignetteID], npc)
    end

    return npc
end

private.InitializeNPC = InitializeNPC

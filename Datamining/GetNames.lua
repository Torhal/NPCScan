--------------------------------------------------------------------------------
----  AddOn Namespace
--------------------------------------------------------------------------------

local AddOnFolderName = ... ---@type string
local private = select(2, ...) ---@class PrivateNamespace

local NPCScan = LibStub("AceAddon-3.0"):GetAddon(AddOnFolderName) ---@class NPCScan

--------------------------------------------------------------------------------
------- Constants
--------------------------------------------------------------------------------

local ItemIDFromName = {} ---@type table<string, integer>

private.ItemIDFromName = ItemIDFromName

local NPCIDFromName = {} ---@type table<string, integer>

private.NPCIDFromName = NPCIDFromName

local QuestIDFromName = {} ---@type table<string, integer>

private.QuestIDFromName = QuestIDFromName

local DatamineTooltip = CreateFrame("GameTooltip", "NPCScanDatamineTooltip", UIParent, "GameTooltipTemplate")
DatamineTooltip:SetOwner(WorldFrame, "ANCHOR_NONE")

--------------------------------------------------------------------------------
---- Data Mining Functions
--------------------------------------------------------------------------------

---@param itemID integer
function GetItemNameFromID(itemID)
    local itemName = private.db.locale.itemNames[itemID]

    if itemName then
        return itemName
    end

    itemName = C_Item.GetItemNameByID(itemID)

    if not itemName then
        return UNKNOWN
    end

    if itemName ~= "" then
        private.db.locale.itemNames[itemID] = itemName
        ItemIDFromName[itemName] = itemID
    end

    return itemName
end

private.GetItemNameFromID = GetItemNameFromID

---@param npcID integer
function GetNPCNameFromID(npcID)
    local npcName = private.db.locale.npcNames[npcID]

    if not npcName then
        DatamineTooltip:SetHyperlink(("unit:Creature-0-0-0-0-%d"):format(npcID))

        npcName = _G["NPCScanDatamineTooltipTextLeft1"]:GetText()

        if npcName and npcName ~= "" then
            private.db.locale.npcNames[npcID] = npcName
            NPCIDFromName[npcName] = npcID
        else
            npcName = UNKNOWN
        end
    end

    return npcName
end

private.GetNPCNameFromID = GetNPCNameFromID

---@param questID integer
function GetQuestNameFromID(questID)
    local questName = private.db.locale.questNames[questID]

    if questName then
        return questName
    end

    questName = C_QuestLog.GetTitleForQuestID(questID)

    if not questName then
        C_QuestLog.RequestLoadQuestByID(questID)

        return UNKNOWN
    end

    if questName ~= "" then
        private.db.locale.questNames[questID] = questName
        QuestIDFromName[questName] = questID
    end

    return questName
end

private.GetQuestNameFromID = GetQuestNameFromID

--------------------------------------------------------------------------------
------- Event Handlers
--------------------------------------------------------------------------------

---@param questID integer
---@param isSuccessful boolean
function NPCScan:QUEST_DATA_LOAD_RESULT(_, questID, isSuccessful)
    if isSuccessful then
        print(("Quest %d has data!"):format(questID))

        GetQuestNameFromID(questID)
    end
end

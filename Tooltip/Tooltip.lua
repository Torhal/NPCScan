--------------------------------------------------------------------------------
---- AddOn Namespace
--------------------------------------------------------------------------------

local AddOnFolderName = ... ---@type string
local private = select(2, ...) ---@type PrivateNamespace

local Data = private.Data
local EventMessage = private.EventMessage

local FormatAtlasTexture = private.FormatAtlasTexture

local QTip = LibStub("LibQTip-2.0")

--------------------------------------------------------------------------------
---- Constants
--------------------------------------------------------------------------------

---@class DataObject: LibDataBroker.DataDisplay & Frame & AceEvent-3.0
---@field ScannerData ScannerData
local DataObject = LibStub("AceEvent-3.0"):Embed(LibStub("LibDataBroker-1.1"):NewDataObject(AddOnFolderName, {
    icon = [[Interface\LFGFRAME\BattlenetWorking0]],
    label = OBJECTIVES_LABEL,
    ScannerData = {
        NPCCount = 0,
        NPCs = {},
    },
    text = NONE,
    type = "data source",
}))

---@class TooltipHandler
---@field Tooltip TooltipHandler.Tooltip
local TooltipHandler = {

    ---@class TooltipHandler.Tooltip
    ---@field Data? LibQTip-2.0.Tooltip
    ---@field Main? LibQTip-2.0.Tooltip
    Tooltip = {
        Data = nil,
        Main = nil,
    },
}

local ICON_MOUNT = FormatAtlasTexture("StableMaster")
local ICON_PET = FormatAtlasTexture("WildBattlePetCapturable")

local ICON_TAMEABLE
do
    local textureFormat = [[|TInterface\TargetingFrame\UI-CLASSES-CIRCLES:0:0:0:0:256:256:%d:%d:%d:%d|t]]
    local textureSize = 256
    local left, right, top, bottom = unpack(CLASS_ICON_TCOORDS["HUNTER"])

    ICON_TAMEABLE =
        textureFormat:format(left * textureSize, right * textureSize, top * textureSize, bottom * textureSize)
end

local ICON_TOY = [[|TInterface\Worldmap\TreasureChest_64:0:0|t]]
local ICON_WORLDQUEST = FormatAtlasTexture("worldquest-tracker-questmarker")

local npcAchievementNames = {}
local npcDisplayNames = {}
local npcIDs = {}
local npcNames = {}

local TitleFont = CreateFont("NPCScanTitleFont")
TitleFont:SetTextColor(0.510, 0.773, 1.0)
TitleFont:SetFontObject("QuestTitleFont")

--------------------------------------------------------------------------------
---- Helper Functions
--------------------------------------------------------------------------------

local function SortByNPCNameThenByID(a, b)
    local nameA = npcNames[a]
    local nameB = npcNames[b]

    if nameA == nameB then
        return a < b
    end

    return nameA < nameB
end

local function SortByNPCAchievementNameThenByNameThenByID(a, b)
    local achievementNameA = npcAchievementNames[a]
    local achievementNameB = npcAchievementNames[b]

    if achievementNameA == achievementNameB then
        return SortByNPCNameThenByID(a, b)
    end

    if not achievementNameA then
        return false
    end

    if not achievementNameB then
        return true
    end

    return achievementNameA < achievementNameB
end

--------------------------------------------------------------------------------
---- Cell Scripts
--------------------------------------------------------------------------------

---@param achievementID AchievementID
local function OpenToAchievement(_, achievementID)
    if not AchievementFrame or not AchievementFrame:IsShown() then
        ToggleAchievementFrame()
    end

    AchievementFrameBaseTab_OnClick(1)
    AchievementFrame_SelectAchievement(achievementID, true)

    local categoryID = GetAchievementCategory(achievementID)
    local categoryTitle, parentCategoryID = GetCategoryInfo(categoryID)
    local parentCategoryTitle = GetCategoryInfo(parentCategoryID)

    if parentCategoryID == -1 then
        for _, entry in pairs(ACHIEVEMENT_FUNCTIONS.categories) do
            if entry.id == categoryID then
                entry.collapsed = false
            elseif entry.parent == categoryID then
                entry.hidden = false
            end
        end

        AchievementFrameCategories_Update()
    end
end

---@param tooltipCell LibQTip-2.0.Cell
---@param achievementID AchievementID
local function ShowAchievementTooltip(tooltipCell, achievementID)
    GameTooltip_SetDefaultAnchor(GameTooltip, tooltipCell)

    local description = Data.Achievements[achievementID] and Data.Achievements[achievementID].description or UNKNOWN
    GameTooltip:SetText(description, 1, 1, 1, 1, true)
    GameTooltip:Show()
end

local function HideAchievementTooltip()
    GameTooltip:Hide()
end

--------------------------------------------------------------------------------
---- NPC Tidbit Helpers
--------------------------------------------------------------------------------

local entryFromID = {}

---@param dataTooltip LibQTip-2.0.Tooltip
---@param iconPath number
---@param entryName string
---@param isCollected boolean
local function AddEntryToDataTooltip(dataTooltip, iconPath, entryName, isCollected)
    local row = dataTooltip:AddRow()

    row:GetCell(1):SetFormattedText("|T%s:0:0|t %s", iconPath, entryName)
    row:GetCell(2):SetText("    ")

    if isCollected then
        row:GetCell(3):SetFormattedText("%s%s", GREEN_FONT_COLOR_CODE, COLLECTED)
    else
        row:GetCell(3):SetFormattedText("%s%s", RED_FONT_COLOR_CODE, NOT_COLLECTED)
    end
end

local function AddEntryDataIDs(list, fieldName)
    table.wipe(entryFromID)

    for index = 1, #list do
        entryFromID[list[index][fieldName]] = list[index]
    end
end

--------------------------------------------------------------------------------
---- Data Tooltip Helpers
--------------------------------------------------------------------------------

---@param tooltipCell LibQTip-2.0.Cell
local function ReleaseDataTooltip(tooltipCell)
    if TooltipHandler.Tooltip.Data then
        TooltipHandler.Tooltip.Data:Hide()
        TooltipHandler.Tooltip.Data:Release()
    end
end

---@param tooltipCell LibQTip-2.0.Cell
---@return LibQTip-2.0.Tooltip
local function AcquireDataTooltip(tooltipCell)
    local dataTooltip = TooltipHandler.Tooltip.Data

    if not dataTooltip then
        dataTooltip = QTip:AcquireTooltip(AddOnFolderName .. "DataTooltip", 3)

        dataTooltip
            :SetAutoHideDelay(0.1, tooltipCell)
            :SmartAnchorTo(tooltipCell)
            :SetCellMarginH(10)
            :SetBackdropColor(0.05, 0.05, 0.05, 1)

        TooltipHandler.Tooltip.Data = dataTooltip

        QTip.RegisterCallback(TooltipHandler, "OnReleaseTooltip", "OnReleaseTooltip")
    end

    dataTooltip:Clear()

    return dataTooltip
end

---@param tooltipCell LibQTip-2.0.Cell
---@param text string
local function DisplayDataText(tooltipCell, text)
    local dataTooltip = AcquireDataTooltip(tooltipCell)

    dataTooltip:AddRow():GetCell(1):SetColSpan(3):SetText(text)
    dataTooltip:Show()
end

---@param tooltipCell LibQTip-2.0.Cell
local function DisplayMountInfo(tooltipCell, mountList)
    local dataTooltip = AcquireDataTooltip(tooltipCell)

    AddEntryDataIDs(mountList, "spellID")

    local mountIDs = C_MountJournal.GetMountIDs()

    for index = 1, #mountIDs do
        local creatureName, spellID, iconPath, _, _, _, _, _, _, hideOnChar, isCollected =
            C_MountJournal.GetMountInfoByID(mountIDs[index])

        if creatureName and not hideOnChar and entryFromID[spellID] then
            AddEntryToDataTooltip(dataTooltip, iconPath, creatureName, isCollected)
        end
    end

    dataTooltip:Show()
end

---@param tooltipCell LibQTip-2.0.Cell
local function DisplayPetInfo(tooltipCell, petList)
    local dataTooltip = AcquireDataTooltip(tooltipCell)

    AddEntryDataIDs(petList, "npcID")

    C_PetJournal.SetFilterChecked(LE_PET_JOURNAL_FILTER_COLLECTED, true)
    C_PetJournal.SetFilterChecked(LE_PET_JOURNAL_FILTER_FAVORITES, false)
    C_PetJournal.SetFilterChecked(LE_PET_JOURNAL_FILTER_NOT_COLLECTED, true)
    C_PetJournal.SetAllPetTypesChecked(true)
    C_PetJournal.SetAllPetSourcesChecked(true)
    C_PetJournal.ClearSearchFilter()

    if PetJournalSearchBox then
        PetJournalSearchBox:SetText("")
    end

    local numPets = C_PetJournal.GetNumPets()

    for index = 1, numPets do
        local _, _, isCollected, _, _, _, _, petName, iconPath, _, npcID = C_PetJournal.GetPetInfoByIndex(index)

        if petName and entryFromID[npcID] then
            AddEntryToDataTooltip(dataTooltip, iconPath, petName, isCollected)
            entryFromID[npcID] = nil -- Prevent multiples if already collected.
        end
    end

    dataTooltip:Show()
end

local function DisplayToyInfo(tooltipCell, toyList)
    local dataTooltip = AcquireDataTooltip(tooltipCell)

    AddEntryDataIDs(toyList, "itemID")

    C_ToyBox.SetAllSourceTypeFilters(true)
    C_ToyBox.SetCollectedShown(true)
    C_ToyBox.SetFilterString("")

    if ToyBox then
        ToyBox.searchBox:SetText("")
    end

    local numToys = C_ToyBox.GetNumToys()

    for index = 1, numToys do
        local toyID = C_ToyBox.GetToyFromIndex(index)
        local itemID, toyName, iconPath = C_ToyBox.GetToyInfo(toyID)

        if toyName and entryFromID[itemID] then
            AddEntryToDataTooltip(dataTooltip, iconPath, toyName, PlayerHasToy(itemID))
        end
    end

    dataTooltip:Show()
end

local function GenerateData()
    local hasMounts = false
    local hasPets = false
    local hasToys = false
    local hasTameable = false
    local hasWorldQuest = false

    local mountsColumn
    local petsColumn
    local tameableColumn
    local toysColumn
    local worldQuestColumn

    local numTooltipColumns = 1

    table.wipe(npcAchievementNames)
    table.wipe(npcDisplayNames)
    table.wipe(npcIDs)
    table.wipe(npcNames)

    for npcID in pairs(DataObject.ScannerData.NPCs) do
        local npc = Data.NPCs[npcID]

        -- The npcID may belong to a custom NPC, which will not have further information.
        if npc then
            npcAchievementNames[npcID] = npc.achievementID and Data.Achievements[npc.achievementID].name or nil
            npcDisplayNames[npcID] = private.GetNPCOptionsName(npcID)
            npcIDs[#npcIDs + 1] = npcID
            npcNames[npcID] = private.GetNPCNameFromID(npcID)

            if not hasTameable and npc.isTameable then
                hasTameable = true
            end

            if not hasMounts and npc.mounts then
                hasMounts = true
            end

            if not hasPets and npc.pets then
                hasPets = true
            end

            if not hasToys and npc.toys then
                hasToys = true
            end

            if not hasWorldQuest and npc:HasActiveWorldQuest() then
                hasWorldQuest = true
            end
        end
    end

    if hasMounts then
        numTooltipColumns = numTooltipColumns + 1
        mountsColumn = numTooltipColumns
    end

    if hasPets then
        numTooltipColumns = numTooltipColumns + 1
        petsColumn = numTooltipColumns
    end

    if hasToys then
        numTooltipColumns = numTooltipColumns + 1
        toysColumn = numTooltipColumns
    end

    if hasTameable then
        numTooltipColumns = numTooltipColumns + 1
        tameableColumn = numTooltipColumns
    end

    if hasWorldQuest then
        numTooltipColumns = numTooltipColumns + 1
        worldQuestColumn = numTooltipColumns
    end

    table.sort(npcIDs, SortByNPCAchievementNameThenByNameThenByID)

    return {
        mountsColumn = mountsColumn,
        petsColumn = petsColumn,
        tameableColumn = tameableColumn,
        toysColumn = toysColumn,
        worldQuestColumn = worldQuestColumn,
        numTooltipColumns = numTooltipColumns,
    }
end

--------------------------------------------------------------------------------
---- Display Rendering
--------------------------------------------------------------------------------

---@param eventName string The name of the event that triggered this method. Unused.
---@param tooltip LibQTip-2.0.Tooltip The tooltip which has just been released.
function TooltipHandler:OnReleaseTooltip(eventName, tooltip)
    -- QTip.UnregisterCallback(tooltip, "OnReleaseTooltip")

    if tooltip == self.Tooltip.Main then
        tooltip:SetFrameStrata("TOOLTIP")

        self.Tooltip.Main = nil
    elseif tooltip == self.Tooltip.Data then
        self.Tooltip.Data = nil
    end
end

---@param anchorFrame LibDataBroker.DataDisplay & Frame
function TooltipHandler:Render(anchorFrame)
    if not anchorFrame then
        return
    end

    local tooltipData = GenerateData()

    if tooltip and QTip:IsAcquiredTooltip(AddOnFolderName) then
        QTip:ReleaseTooltip(tooltip)
    end

    local tooltip = self.Tooltip.Main

    if not tooltip then
        tooltip = QTip:AcquireTooltip(AddOnFolderName, tooltipData.numTooltipColumns)
        tooltip:SetFrameStrata("DIALOG")

        tooltip
            :Clear()
            :SmartAnchorTo(anchorFrame)
            :SetAutoHideDelay(0.25, anchorFrame)
            :SetBackdropColor(0.05, 0.05, 0.05, 1)

        self.Tooltip.Main = tooltip

        QTip.RegisterCallback(self, "OnReleaseTooltip", "OnReleaseTooltip")
    end

    tooltip:Clear():AddRow(AddOnFolderName):GetCell(1):SetFontObject(TitleFont):SetJustifyH("CENTER")
    tooltip:AddSeparator(1, 0, 0, 0)

    if DataObject.ScannerData.NPCCount == 0 then
        tooltip:AddSeparator(1, 0, 0, 0)
        tooltip:AddSeparator(1, 1, 0.82, 0)
        tooltip:AddRow(ERR_GENERIC_NO_VALID_TARGETS):GetCell(1):SetJustifyH("CENTER")

        return
    end

    local mountsColumn = tooltipData.mountsColumn
    local petsColumn = tooltipData.petsColumn
    local tameableColumn = tooltipData.tameableColumn
    local toysColumn = tooltipData.toysColumn
    local worldQuestColumn = tooltipData.worldQuestColumn

    local currentAchievementID

    for index = 1, #npcIDs do
        local npcID = npcIDs[index]
        local npc = Data.NPCs[npcID]

        if npc.achievementID then
            if npc.achievementID ~= currentAchievementID then
                currentAchievementID = npc.achievementID

                tooltip:AddSeparator(1, 0, 0, 0)
                tooltip:AddSeparator(1, 1, 0.82, 0)

                local achievementData = Data.Achievements[npc.achievementID]

                tooltip
                    :AddRow()
                    :GetCell(1, QTip:GetCellProvider("NPCScan Section Header"))
                    :SetFormattedText("|T%s:0|t %s", achievementData.iconTexturePath, achievementData.name)
                    :SetJustifyH("CENTER")
                    :SetScript("OnMouseUp", OpenToAchievement, tostring(npc.achievementID))
                    :SetScript("OnEnter", ShowAchievementTooltip, tostring(npc.achievementID))
                    :SetScript("OnLeave", HideAchievementTooltip)

                tooltip:AddSeparator(1, 1, 0.82, 0)
            end
        elseif not currentAchievementID then
            -- No achievement section before this, and it's the first entry
            currentAchievementID = -1

            tooltip:AddSeparator(1, 0, 0, 0)
            tooltip:AddSeparator(1, 1, 0.82, 0)
        elseif currentAchievementID >= 0 then
            -- End of achievements.
            currentAchievementID = -1

            tooltip:AddSeparator(1, 0, 0, 0)
            tooltip:AddSeparator(1, 1, 0.82, 0)

            tooltip:AddRow(MISCELLANEOUS):GetCell(1):SetJustifyH("CENTER")

            tooltip:AddSeparator(1, 1, 0.82, 0)
        end

        local row = tooltip:AddRow()

        if index % 2 == 0 then
            row:SetColor(0.20, 0.20, 0.20)
        end

        row:GetCell(1):SetText(npcDisplayNames[npcID])

        if worldQuestColumn and npc:HasActiveWorldQuest() then
            row:GetCell(worldQuestColumn)
                :SetText(ICON_WORLDQUEST)
                :SetScript("OnEnter", DisplayDataText, TRACKER_HEADER_WORLD_QUESTS)
                :SetScript("OnLeave", ReleaseDataTooltip)
        end

        if tameableColumn and npc.isTameable then
            row:GetCell(tameableColumn)
                :SetText(ICON_TAMEABLE)
                :SetScript("OnEnter", DisplayDataText, TAMEABLE)
                :SetScript("OnLeave", ReleaseDataTooltip)
        end

        if mountsColumn and npc.mounts then
            row:GetCell(mountsColumn)
                :SetText(ICON_MOUNT)
                :SetScript("OnEnter", DisplayMountInfo, npc.mounts)
                :SetScript("OnLeave", ReleaseDataTooltip)
        end

        if petsColumn and npc.pets then
            row:GetCell(petsColumn)
                :SetText(ICON_PET)
                :SetScript("OnEnter", DisplayPetInfo, npc.pets)
                :SetScript("OnLeave", ReleaseDataTooltip)
        end

        if toysColumn and npc.toys then
            row:GetCell(toysColumn)
                :SetText(ICON_TOY)
                :SetScript("OnEnter", DisplayToyInfo, npc.toys)
                :SetScript("OnLeave", ReleaseDataTooltip)
        end
    end

    tooltip:Show()
end

--------------------------------------------------------------------------------
---- DataObject Methods
--------------------------------------------------------------------------------

function DataObject:OnClick()
    LibStub("AceConfigDialog-3.0"):Open(AddOnFolderName)
end

function DataObject:OnEnter()
    TooltipHandler:Render(self)
end

function DataObject:OnLeave()
    -- Null operation: Some LDB displays get cranky if this method is missing.
end

local UpdateDisplayThrottleIntervalSeconds = 5
local lastUpdateTime = time()

function DataObject:UpdateDisplay(_, scannerData)
    self.text = scannerData.NPCCount > 0 and scannerData.NPCCount or NONE
    self.ScannerData = scannerData

    if TooltipHandler.Tooltip.Main and TooltipHandler.Tooltip.Main:IsShown() then
        local now = time()

        if now > lastUpdateTime + UpdateDisplayThrottleIntervalSeconds then
            lastUpdateTime = now

            TooltipHandler:Render(self)
        end
    end
end

DataObject:RegisterMessage(EventMessage.ScannerDataUpdated, "UpdateDisplay")

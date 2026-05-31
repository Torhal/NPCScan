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

---@param tooltipCell LibQTip-2.0.Cell
local function HideGameTooltip(tooltipCell)
    tooltipCell.Tooltip:SetFrameStrata("TOOLTIP")

    GameTooltip:Hide()
end

---@param tooltipCell LibQTip-2.0.Cell
---@param achievementID AchievementID
local function ShowAchievementTooltip(tooltipCell, achievementID)
    tooltipCell.Tooltip:SetFrameStrata("DIALOG")

    GameTooltip:SetOwner(
        tooltipCell,
        UIParent:GetCenter() > tooltipCell:GetCenter() and "ANCHOR_RIGHT" or "ANCHOR_LEFT"
    )

    GameTooltip:SetHyperlink(GetAchievementLink(achievementID))
    GameTooltip:Show()
end

---@param tooltipCell LibQTip-2.0.Cell
---@param npcID NPCID
local function ShowNPCTooltip(tooltipCell, npcID)
    tooltipCell.Tooltip:SetFrameStrata("DIALOG")

    GameTooltip:SetOwner(
        tooltipCell,
        UIParent:GetCenter() > tooltipCell:GetCenter() and "ANCHOR_RIGHT" or "ANCHOR_LEFT"
    )

    GameTooltip:SetHyperlink(("unit:Creature-0-0-0-0-%d"):format(npcID))
    GameTooltip:Show()
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

    row
        :GetCell(1, QTip:GetCellProvider("LibQTip-2.0 Icon")) --[[@as LibQTip-2.0.IconCell]]
        :SetIconTexture(iconPath)

    row:GetCell(2):SetFormattedText("%s    ", entryName)

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
    tooltipCell.Tooltip:SetFrameStrata("TOOLTIP")

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
---@param mountList MountData[]
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
---@param petList PetData[]
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

---@param tooltipCell LibQTip-2.0.Cell
---@param toyList ToyData[]
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
        end
    end

    table.sort(npcIDs, SortByNPCAchievementNameThenByNameThenByID)
end

--------------------------------------------------------------------------------
---- Display Rendering
--------------------------------------------------------------------------------

---@param eventName string The name of the event that triggered this method. Unused.
---@param tooltip LibQTip-2.0.Tooltip The tooltip which has just been released.
function TooltipHandler:OnReleaseTooltip(eventName, tooltip)
    if tooltip == self.Tooltip.Main then
        self.Tooltip.Main = nil
    elseif tooltip == self.Tooltip.Data then
        self.Tooltip.Data = nil
    end
end

---@class RenderIconParameters
---@field atlasName string
---@field columnIndex number
---@field onEnterArgument unknown
---@field onEnterFunction fun(tooltipCell: LibQTip-2.0.Cell, arg: unknown)
---@field row LibQTip-2.0.Row

---@param parameters RenderIconParameters
local function RenderIcon(parameters)
    local atlasInfo = C_Texture.GetAtlasInfo(parameters.atlasName)

    if atlasInfo.file then
        parameters
            .row
            :GetCell(parameters.columnIndex, QTip:GetCellProvider("LibQTip-2.0 Icon")) --[[@as LibQTip-2.0.IconCell]]
            :SetIconTexture(atlasInfo.file)
            :SetIconTexCoord(
                atlasInfo.leftTexCoord,
                atlasInfo.rightTexCoord,
                atlasInfo.topTexCoord,
                atlasInfo.bottomTexCoord
            )
            :SetScript("OnEnter", parameters.onEnterFunction, parameters.onEnterArgument)
            :SetScript("OnLeave", ReleaseDataTooltip)
    end
end

local TooltipColumnCount = 6

local TooltipColumnID = {
    Name = 1,
    Mount = 2,
    Pet = 3,
    Toy = 4,
    Tameable = 5,
    WorldQuest = 6,
}

---@param anchorFrame LibDataBroker.DataDisplay & Frame
function TooltipHandler:Render(anchorFrame)
    if not anchorFrame then
        return
    end

    GenerateData()

    if tooltip and QTip:IsAcquiredTooltip(AddOnFolderName) then
        QTip:ReleaseTooltip(tooltip)
    end

    local tooltip = self.Tooltip.Main

    if not tooltip then
        tooltip = QTip:AcquireTooltip(AddOnFolderName, TooltipColumnCount)

        tooltip
            :SmartAnchorTo(anchorFrame)
            :SetAutoHideDelay(0.25, anchorFrame)
            :SetHighlightTexture([[Interface\ClassTrainerFrame\TrainerTextures]])
            :SetHighlightTexCoord(0.00195313, 0.57421875, 0.75390625, 0.84570313)
            :SetBackdropColor(0.05, 0.05, 0.05, 1)

        self.Tooltip.Main = tooltip

        QTip.RegisterCallback(self, "OnReleaseTooltip", "OnReleaseTooltip")
    end

    tooltip
        :Clear()
        :AddRow()
        :GetCell(1)
        :SetColSpan(0)
        :SetJustifyH("CENTER")
        :SetFontObject(TitleFont)
        :SetText(AddOnFolderName)

    tooltip:AddSeparator(1, 0.510, 0.773, 1.0)

    if DataObject.ScannerData.NPCCount == 0 then
        tooltip:AddSeparator(1, 0, 0, 0)
        tooltip:AddSeparator(1, 1, 0.82, 0)
        tooltip:AddRow(ERR_GENERIC_NO_VALID_TARGETS):GetCell(1):SetJustifyH("CENTER")

        return
    end

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
                    :SetColSpan(0)
                    :SetFormattedText("|T%s:0|t %s", achievementData.iconTexturePath, achievementData.name)
                    :SetJustifyH("CENTER")
                    :SetScript("OnEnter", ShowAchievementTooltip, tostring(npc.achievementID))
                    :SetScript("OnLeave", HideGameTooltip)

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

        row:GetCell(TooltipColumnID.Name)
            :SetText(npcDisplayNames[npcID])
            :SetScript("OnEnter", ShowNPCTooltip, npcID)
            :SetScript("OnLeave", HideGameTooltip)

        if npc:HasActiveWorldQuest() then
            RenderIcon({
                atlasName = "worldquest-tracker-questmarker",
                columnIndex = TooltipColumnID.WorldQuest,
                onEnterArgument = TRACKER_HEADER_WORLD_QUESTS,
                onEnterFunction = DisplayDataText,
                row = row,
            })
        end

        if npc.isTameable then
            RenderIcon({
                atlasName = "UI-HUD-UnitFrame-Player-Portrait-ClassIcon-Hunter",
                columnIndex = TooltipColumnID.Tameable,
                onEnterArgument = TAMEABLE,
                onEnterFunction = DisplayDataText,
                row = row,
            })
        end

        if npc.mounts then
            RenderIcon({
                atlasName = "StableMaster",
                columnIndex = TooltipColumnID.Mount,
                onEnterArgument = npc.mounts,
                onEnterFunction = DisplayMountInfo,
                row = row,
            })
        end

        if npc.pets then
            RenderIcon({
                atlasName = "WildBattlePetCapturable",
                columnIndex = TooltipColumnID.Pet,
                onEnterArgument = npc.pets,
                onEnterFunction = DisplayPetInfo,
                row = row,
            })
        end

        if npc.toys then
            RenderIcon({
                atlasName = "BonusLoot-Chest",
                columnIndex = TooltipColumnID.Toy,
                onEnterArgument = npc.toys,
                onEnterFunction = DisplayToyInfo,
                row = row,
            })
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

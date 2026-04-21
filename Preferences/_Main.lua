--------------------------------------------------------------------------------
---- AddOn Namespace
--------------------------------------------------------------------------------

local AddOnFolderName = ... ---@type string
local private = select(2, ...) ---@type PrivateNamespace

local NPCScan = LibStub("AceAddon-3.0"):GetAddon(AddOnFolderName) ---@class NPCScan

local AceConfigDialog = LibStub("AceConfigDialog-3.0")
local AceConfigRegistry = LibStub("AceConfigRegistry-3.0")

--------------------------------------------------------------------------------
---- Initialization
--------------------------------------------------------------------------------

local buildVersion = C_AddOns.GetAddOnMetadata(AddOnFolderName, "Version")
local isDevelopmentVersion = false
local isAlphaVersion = false

--@debug@
isDevelopmentVersion = true
--@end-debug@

--@alpha@
isAlphaVersion = true
--@end-alpha@

buildVersion = isDevelopmentVersion and "Development Version"
    or (isAlphaVersion and buildVersion .. "-Alpha")
    or buildVersion

local Options ---@type AceConfig.OptionsTable

local function GetOptions()
    Options = Options
        or {
            args = {
                npcOptions = private.GetOrUpdateNPCOptions(),
                detectionOptions = private.GetDetectionOptions(),
                alertOptions = private.GetAlertOptions(),
                targetingOptions = private.GetTargetingOptions(),
                profileOptions = LibStub("AceDBOptions-3.0"):GetOptionsTable(private.db),
            },
            childGroups = "tab",
            name = ("%s - %s"):format(AddOnFolderName, buildVersion),
            type = "group",
        }

    return Options
end

function NPCScan:SetupOptions()
    AceConfigRegistry:RegisterOptionsTable(AddOnFolderName, GetOptions())
    AceConfigDialog:SetDefaultSize(AddOnFolderName, 1000, 720)

    self.OptionsFrame = AceConfigDialog:AddToBlizOptions(AddOnFolderName)
end

--------------------------------------------------------------------------------
---- Helpers
--------------------------------------------------------------------------------

---@param mapID integer
---@return string
local function GetMapOptionDescription(mapID)
    local continentID = private.Data.Maps[mapID].continentID

    if continentID then
        local continentName = private.Data.Continents[continentID].name

        if continentName then
            return ("%s %s %s"):format(ID, mapID, PARENS_TEMPLATE:format(continentName))
        end

        private.Debug("GetMapOptionDescription: No continentName for mapID %d", mapID)
    end

    return ("%s %s"):format(ID, mapID)
end

private.GetMapOptionDescription = GetMapOptionDescription

---@param mapID integer
---@return string
local function GetMapOptionName(mapID)
    local continentID = private.Data.Maps[mapID].continentID
    local profile = private.db.profile
    local isBlacklisted = profile.blacklist.mapIDs[mapID]
        or profile.detection.continentIDs[continentID] == private.Enum.DetectionGroupStatus.Disabled
    local colorCode = isBlacklisted and RED_FONT_COLOR_CODE or GREEN_FONT_COLOR_CODE

    return ("%s%s|r"):format(colorCode, private.Data.Maps[mapID].name)
end

private.GetMapOptionName = GetMapOptionName

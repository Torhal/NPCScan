--------------------------------------------------------------------------------
---- AddOn Namespace
--------------------------------------------------------------------------------
local AddOnFolderName = ... ---@type string
local private = select(2, ...) ---@class PrivateNamespace

local LibStub = _G.LibStub
local NPCScan = LibStub("AceAddon-3.0"):GetAddon(AddOnFolderName)

local AceConfigDialog = LibStub("AceConfigDialog-3.0")
local AceConfigRegistry = LibStub("AceConfigRegistry-3.0")

--------------------------------------------------------------------------------
---- Initialization
--------------------------------------------------------------------------------
local buildVersion = GetAddOnMetadata(AddOnFolderName, "Version")
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

local Options

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

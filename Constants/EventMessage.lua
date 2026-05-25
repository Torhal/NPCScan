--------------------------------------------------------------------------------
---- AddOn Namespace
--------------------------------------------------------------------------------

local AddOnFolderName = ... ---@type string
local private = select(2, ...) ---@class PrivateNamespace

--------------------------------------------------------------------------------
---- Types
--------------------------------------------------------------------------------

---@enum NPCScan.EventMessage
local EventMessage = {
    DetectedNPC = "NPCScan_DetectedNPC",
    DismissTargetButtonByID = "NPCScan_DismissTargetButtonByID",
    ScannerDataUpdated = "NPCScan_ScannerDataUpdated",
    TargetButtonNeedsReclassified = "NPCScan_TargetButtonNeedsReclassified",
    TargetButtonRequestDeactivate = "NPCScan_TargetButtonRequestDeactivate",
    TargetButtonScaleChanged = "NPCScan_TargetButtonScaleChanged",
    UnitInformationAvailable = "NPCScan_UnitInformationAvailable",
}

private.EventMessage = EventMessage

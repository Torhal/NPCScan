local AddOnFolderName = ... ---@type string
local private = select(2, ...) ---@class PrivateNamespace

local ValidEventMessages = {
    "DetectedNPC",
    "DismissTargetButtonByID",
    "ScannerDataUpdated",
    "TargetButtonNeedsReclassified",
    "TargetButtonRequestDeactivate",
    "TargetButtonScaleChanged",
    "UnitInformationAvailable",
}

local EventMessage = {}
private.EventMessage = EventMessage

for index = 1, #ValidEventMessages do
    local messageName = ValidEventMessages[index]
    EventMessage[messageName] = ("NPCScan_%s"):format(messageName)
end

----------------------------------------------------------------------------------
---- AddOn Namespace
---------------------------------------------------------------------------------
local AddOnFolderName = ... ---@type string
local private = select(2, ...) ---@class PrivateNamespace

--------------------------------------------------------------------------------
---- Constants
--------------------------------------------------------------------------------
private.Enum = {
    DetectionGroupStatus = {
        Enabled = 1,
        UserDefined = 2,
        Disabled = 3,
    },
}

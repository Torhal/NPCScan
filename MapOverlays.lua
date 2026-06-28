----------------------------------------------------------------------------------
---- AddOn Namespace
---------------------------------------------------------------------------------
local AddOnFolderName = ... ---@type string
local private = select(2, ...) ---@class PrivateNamespace
private.Overlays = _G.LibStub("AceEvent-3.0"):Embed({})

local MESSAGE_REGISTER = "NpcOverlay_RegisterScanner"
local MESSAGE_ADD = "NpcOverlay_Add"
local MESSAGE_REMOVE = "NpcOverlay_Remove"
local MESSAGE_FOUND = "NpcOverlay_Found"

--- Announces to overlay mods that _NPCScan will take over control of shown paths.
function private.Overlays.Register()
    private.Overlays:SendMessage(MESSAGE_REGISTER, AddOnFolderName)
end

--- Enables overlay maps for a given NPC ID.
---@param npcID NPCID
function private.Overlays.Add(npcID)
    private.Overlays:SendMessage(MESSAGE_ADD, npcID, AddOnFolderName)
end

--- Disables overlay maps for a given NPC ID.
---@param npcID NPCID
function private.Overlays.Remove(npcID)
    private.Overlays:SendMessage(MESSAGE_REMOVE, npcID, AddOnFolderName)
end

--- Lets overlay mods know the NPC ID was found.
---@param npcID NPCID
function private.Overlays.Found(npcID)
    private.Overlays:SendMessage(MESSAGE_FOUND, npcID, AddOnFolderName)
end

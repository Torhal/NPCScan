-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
local _G = getfenv(0)

-- Libraries
local string = _G.string

-- Functions
local date = _G.date

-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local FOLDER_NAME, private = ...

local LibStub = _G.LibStub

local NPCScan = LibStub("AceAddon-3.0"):NewAddon(FOLDER_NAME, "AceConsole-3.0", "AceEvent-3.0", "AceTimer-3.0", "LibToast-1.0")
_G._NPCScan = NPCScan

local TextDump = LibStub("LibTextDump-1.0")
local HereBeDragons = LibStub("HereBeDragons-1.0")

local Dialog = LibStub("LibDialog-1.0")

-----------------------------------------------------------------------
-- Constants
-----------------------------------------------------------------------

-----------------------------------------------------------------------
-- Variables
-----------------------------------------------------------------------

-----------------------------------------------------------------------
-- Debugger.
-----------------------------------------------------------------------
do
	local DEBUGGER_WIDTH = 750
	local DEBUGGER_HEIGHT = 800
	local debugger

	local function Debug(...)
		local message = string.format(...)
		debugger:AddLine(message, "%X")

		return message
	end

	private.Debug = function(...)
		debugger = TextDump:New(("%s Debug Output"):format(FOLDER_NAME), DEBUGGER_WIDTH, DEBUGGER_HEIGHT)
		private.Debug = Debug

		return Debug(...)
	end

	private.GetDebugger = function()
		debugger = TextDump:New(("%s Debug Output"):format(FOLDER_NAME), DEBUGGER_WIDTH, DEBUGGER_HEIGHT)

		private.GetDebugger = function()
			return debugger
		end

		return debugger
	end
end

-----------------------------------------------------------------------
-- Helpers.
-----------------------------------------------------------------------

-----------------------------------------------------------------------
-- AddOn Methods.
-----------------------------------------------------------------------
function NPCScan:OnInitialize()
end

function NPCScan:OnEnable()
	self:RegisterEvent("PLAYER_LEAVING_WORLD")
	self:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
	self:RegisterEvent("LOOT_CLOSED")
	self:RegisterEvent("NAME_PLATE_UNIT_ADDED")
end

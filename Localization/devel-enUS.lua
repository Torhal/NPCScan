local AddOnFolderName, private = ...

local _G = getfenv(0)
local L = _G.LibStub("AceLocale-3.0"):NewLocale(AddOnFolderName, "enUS", true)

if not L then return end

L["Alerts"] = true
L["Completed Achievement Criteria"] = true
L["Completed Quest Objectives"] = true

L["Drag to set the spawn point for targeting buttons."] = true
L["Detection"] = true
L["Duration"] = true
L["Hide Anchor"] = true
L["Horizontal offset from the anchor point."] = true
L["Ignore Mute"] = true
L["Interval"] = true
L["Play alert sounds when sound is muted."] = true
L["Reset Position"] = true
L["Screen Flash"] = true
L["Screen Location"] = true
L["Show Anchor"] = true
L["Spawn Point"] = true
L["The number of minutes before an NPC will be detected again."] = true
L["The number of minutes a targeting button will exist before fading out."] = true
L["Vertical offset from the anchor point."] = true
L["X Offset"] = true
L["Y Offset"] = true

L["BOTTOM"] = "Bottom"
L["BOTTOMLEFT"] = "Bottom Left"
L["BOTTOMRIGHT"] = "Bottom Right"
L["CENTER"] = "Center"
L["LEFT"] = "Left"
L["RIGHT"] = "Right"
L["TOP"] = "Top"
L["TOPLEFT"] = "Top Left"
L["TOPRIGHT"] = "Top Right"

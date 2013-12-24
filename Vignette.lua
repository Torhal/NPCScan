--Code to handle triggering alerts off of Vignettes

--Known issues:  VIGNETTE_ADDED does not give useful info for mobs,
--Work around target macro may not be reliable if there are more than one rare mobs around
--No way to filter alerts if a player is not tracking certain mobs.

local FOLDER_NAME, private = ...
local L = private.L
local LoadingFinished = false
local VignetteDelay = nil
local InstanceIdFound = {}
local VignetteFoundCount = 0
local lastVignette = 0
local DEBUGGING = false

private.VFrame = _G.CreateFrame("Frame")
private.VFrame:RegisterEvent("VIGNETTE_ADDED")
private.VFrame:RegisterEvent("VIGNETTE_REMOVED")
private.VFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
private.VFrame:RegisterEvent("PLAYER_REGEN_ENABLED")

private.VFrame:SetScript("OnEvent", function(self, event_name, ...)
	if self[event_name] then
		return self[event_name](self, event_name, ...)
	end
end)

function private.VFrame:ZONE_CHANGED_NEW_AREA (event,...)
	if VignetteDelay then 
		if DEBUGGING then print("Debug: Releasing Delay") end
		private.VFrame:VIGNETTE_ADDED ("VIGNETTE_ADDED", VignetteDelay) 
		VignetteDelay = nil
	end
end

--Clears the last found Vignette mob only after combat has ended.
function private.VFrame:PLAYER_REGEN_ENABLED (event,...)
	if VignetteFoundCount == 0 then
		if not _G.InCombatLockdown() then
			lastVignette = 0
		end
	end
end

function private.VignetteHandler(instanceid)
	if  InstanceIdFound[instanceid] then
		InstanceIdFound[instanceid] = nil
		VignetteFoundCount = VignetteFoundCount - 1

	else
		InstanceIdFound[instanceid] = true
		VignetteFoundCount = VignetteFoundCount +1
	end

	if VignetteFoundCount == 0 then
		if not _G.InCombatLockdown() then
			lastVignette = 0
		end
	end
	if DEBUGGING then print("Found: "..VignetteFoundCount) end
	if DEBUGGING then print("Last ID: "..lastVignette) end

	return
end


--Checks to see if achievement mobs are being tracked and filters by zone if an achievement is disabled.
local function VignetteFilterByAchievement()
	local currentzone = _G.GetCurrentMapAreaID()
	if (not private.OptionsCharacter.Achievements[private.ACHIEVEMENT_IDS.ONE_MANY_ARMY] and currentzone == private.ZONE_IDS.VALE_OF_ETERNAL_BLOSSOMS) then
			if DEBUGGING then print("Debug: ONE_MANY_ARMY not tracked") end
		return false
	elseif (not private.OptionsCharacter.Achievements[private.ACHIEVEMENT_IDS.CHAMPIONS_OF_LEI_SHEN] and currentzone == private.ZONE_IDS.ISLE_OF_THUNDER) then
			if DEBUGGING then print("Debug: CHAMPIONS_OF_LEI_SHEN not tracked") end
		return false
	elseif (not private.OptionsCharacter.Achievements[private.ACHIEVEMENT_IDS.TIMELESS_CHAMPION] and currentzone == private.ZONE_IDS.TIMELESS_ISLE ) then
			if DEBUGGING then print("Debug: TIMELESS_CHAMPION not tracked") end
		return false
	elseif (not private.OptionsCharacter.Achievements[private.ACHIEVEMENT_IDS.GLORIOUS] and (currentzone ~= private.ZONE_IDS.VALE_OF_ETERNAL_BLOSSOMS and currentzone ~= private.ZONE_IDS.TIMELESS_ISLE  and currentzone ~= private.ZONE_IDS.ISLE_OF_THUNDER)) then
			if DEBUGGING then print("Debug: GLORIOUS not tracked") end
		return false
	else
		if DEBUGGING then print("Tracking Mob") end
		return true
	end
end


--Updates button to display actual target info
function  private.SetVignetteTarget()
	local NPCName = GetUnitName("target")
	local ID = private.NPC_NAME_TO_ID[NPCName]
	local isDead = UnitIsDead("target")

	if isDead and VignetteFoundCount > 1 then 
		lastVignette = ID
		private.VignetteBuildList(ID)
		private.Button:Update(ID,"Vignette Mob", "Unknown Vignette")
		if DEBUGGING then print("Mob Dead") end
		return
	end

	if ID then 
		if _G.InCombatLockdown() then
			if DEBUGGING then print("Combat LockDown") end
			private.Button.PendingID, private.Button.PendingName, private.Button.PendingSource = ID,NPCName,"Vignette Mob"
		else
			private.Button:Update(ID,NPCName,"Vignette Mob")
		end
		lastVignette = ID
	end
	if DEBUGGING then print("Last ID: "..lastVignette) end


end

--Builds a target macro for every rare mob in the current zone
--Hack way to aquire target as the GetVignetteInfoFromInstanceID does not currently return the correct mob info
--Might not work correctly if more than one Vignette is detected

private.macrotext = "/cleartarget"  

function private.VignetteBuildList(instanceid)

	private.macrotext  = "/cleartarget" 
	local currentmapid = _G.GetCurrentMapAreaID()
	local currentzone = _G.GetMapNameByID(currentmapid)

	--Delays alerts on login untill the world so current zone can be properly detected
	 if currentzone == nil then 
		 VignetteDelay = instanceid
		 if DEBUGGING then print("Build List Delayed") end
		 return false 
	 end

	for id , map in pairs(private.NPC_ID_TO_MAP_NAME ) do
		if currentzone == map  and id ~= lastVignette then
			private.macrotext = private.macrotext .."\n/targetexact "..private.NPC_ID_TO_NAME[id]
		end
	end

	--Manually add Zandalari Warscout & Warbringer due to them appearing in multiple zones but in only one in the data file.
	--Ignore if on Timeless Isle
	if currentmapid ~= private.ZONE_IDS.TIMELESS_ISLE then
		if lastVignette ~= 69768 then
		private.macrotext = private.macrotext .."\n/targetexact "..private.NPC_ID_TO_NAME[69768]
		end
		if lastVignette ~= 69769 then
		private.macrotext = private.macrotext .."\n/targetexact "..private.NPC_ID_TO_NAME[69769]
		end
	end

	private.macrotext  = private.macrotext .."\n/run _G._NPCScan.SetVignetteTarget()"
	return true
end


--_G._NPCScan.macrotext
-- Vignette alert,  VIGNETTE_ADDED Currently does not work corrrectly to bugs with instanceid assignment
-- Will revisit again when 5.4.2 is released to see if issue is resolved
-- Refrence: http://wowpedia.org/API_C_Vignettes.GetVignetteInfoFromInstanceID
function private.VFrame:VIGNETTE_ADDED (event, instanceid, ...)
	private.VignetteHandler(instanceid)
	if not private.OptionsCharacter.TrackVignettes or
	  not instanceid or
	  not VignetteFilterByAchievement() or
	 -- private.Button:IsShown() or
	  GetUnitName("target") == lastVignette or
	  not private.VignetteBuildList(instanceid) then 
		return 
	end
	
	local x, y, name, iconid = C_Vignettes.GetVignetteInfoFromInstanceID(instanceid)
	-- iconid seems to be 40:chests, 41:mobs
	if iconid == nil  then --Use case for broken Mob Info
		if DEBUGGING then print("Nul Mob Data Returned") end
		private.Print(L["FOUND_FORMAT"]:format("Vignette Mob"), _G.GREEN_FONT_COLOR)
		private.Button:SetNPC(67490, "Vignette Mob", "Unknown Vignette")

	elseif iconid == 41 then --Use Case if AIP returns Mob Info
		if DEBUGGING then print("Correct Mob Data Returned") end
		private.Print(L["FOUND_FORMAT"]:format("Vignette Mob"), _G.GREEN_FONT_COLOR)
		private.Button:SetNPC(private.NPC_NAME_TO_ID[name], name, "Vignette Mob")
	
	else -- All other cases
		if DEBUGGING then print("Untracked Vigenette") end
		return 
	end
end

--Clears last seen mob when vignette is removed from map
function private.VFrame:VIGNETTE_REMOVED (event, instanceid, ...)
	private.VignetteHandler(instanceid)
end


--@do-not-package@
function CurrentMacro()
	print(private.macrotext)
end


--@end-do-not-package@ 
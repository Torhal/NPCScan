--Code to handle triggering alerts off of Vignettes and map based icon events

-------------------------------------------------------------------------------
-- Localized Lua globals.
-------------------------------------------------------------------------------
local _G = getfenv(0)

-- Functions
local pairs = _G.pairs


-------------------------------------------------------------------------------
-- AddOn namespace.
-------------------------------------------------------------------------------
local FOLDER_NAME, private = ...
local L = private.L

local LibStub = _G.LibStub
local HereBeDragons = LibStub("HereBeDragons-1.0")
local Toast = LibStub("LibToast-1.0")

-------------------------------------------------------------------------------
-- Variables.
-------------------------------------------------------------------------------
local EVENT_WARNING_SOUND = "Sound\\Spells\\PVPFlagTaken.ogg"
local TANAAN_ZONE_ID = 945
local VIGNETTE_MOB_ID = 41
local VIGNETTE_EVENT_MOB_ID = 45
local VIGNETTE_STAR_ICON_ID = 4733
local VIGNETTE_TREASURE_ICON_ID = 4715
local MAP_EVENT_ICON = 45 --Crossed Swords on Diamond
local BLOODMOON = private.L.NPCs["91200"]

local last_vignette_id = 0
local vignette_delay
local vignette_found_count = 0


private.VFrame = _G.CreateFrame("Frame")
private.VFrame:RegisterEvent("VIGNETTE_ADDED")
private.VFrame:RegisterEvent("VIGNETTE_REMOVED")
private.VFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
private.VFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
private.VFrame:RegisterEvent("PLAYER_ENTERING_WORLD")

private.VFrame:SetScript("OnEvent", function(self, event_name, ...)
	if self[event_name] then
		return self[event_name](self, event_name, ...)
	end
end)


function private.VFrame:ZONE_CHANGED_NEW_AREA()
	if vignette_delay then
		private.VFrame:VIGNETTE_ADDED("VIGNETTE_ADDED", vignette_delay)
		vignette_delay = nil
	end

	if HereBeDragons:GetPlayerZone() == TANAAN_ZONE_ID then
		self:RegisterEvent("WORLD_MAP_UPDATE")
	else
		self:UnregisterEvent("WORLD_MAP_UPDATE")
	end
end


--Clears the last found Vignette mob only after combat has ended.
function private.VFrame:PLAYER_REGEN_ENABLED(event, ...)
	if vignette_found_count == 0 then
		if not _G.InCombatLockdown() then
			last_vignette_id = 0
		end
	end
end


function private.VFrame:PLAYER_ENTERING_WORLD()
	private.VFrame:ZONE_CHANGED_NEW_AREA()
end

--Scans world map and looks at POI icons that relate to Hellbane mob events
function private.VFrame:WORLD_MAP_UPDATE()
	if not private.CharacterOptions.TrackHellbane then
		return
	end

	for landmarkIndex = 1, _G.GetNumMapLandmarks() do
		local landmarkType, landmarkName, _, textureIndex, mapPositionX, mapPositionY = _G.GetMapLandmarkInfo(landmarkIndex)

		--Check to see if POI icon matches Hellbane event
		if textureIndex == MAP_EVENT_ICON then
			local alertText = L.EVENT_ACTIVE:format(landmarkName)

			if private.AntiSpam(private.ANTI_SPAM_DELAY, landmarkName .. "MapAlert") and not landmarkName:find(BLOODMOON) then
				private.Print(alertText, _G.RED_FONT_COLOR)

				if private.CharacterOptions.ShowAlertAsToast and alertText then
					Toast:Spawn("_NPCScanAlertToast", alertText)
				end
				_G.PlaySoundFile(EVENT_WARNING_SOUND, "master")
				_G.RaidNotice_AddMessage(RaidWarningFrame, alertText, ChatTypeInfo["RAID_WARNING"])
			end
		end
	end
end


--Delays alerts on login untill the world so current zone can be properly detected
local function VignetteZoneCheck()
	local map_id = _G.GetCurrentMapAreaID()
	local zone_name = _G.GetMapNameByID(map_id)

	if not zone_name then
		vignette_delay = true
		return false
	else
		return true
	end
end


--Updates button to display actual target info
function private.SetVignetteTarget()
	local npc_name = _G.GetUnitName("target")
	local npc_id = private.NPC_NAME_TO_ID[npc_name]

	if _G.UnitIsDead("target") and vignette_found_count > 1 then
		last_vignette_id = npc_id
		private.GenerateTargetMacro(npc_id)
		private.Button:Update(npc_id, "Vignette Mob", "Unknown Vignette")
		return
	end

	if npc_id then
		if _G.InCombatLockdown() then
			private.Button.PendingID, private.Button.PendingName, private.Button.PendingSource = npc_id, npc_name, "Vignette Mob"
		else
			private.Button:Update(npc_id, npc_name, "Vignette Mob")
		end

		last_vignette_id = npc_id
	end
end


-- Vignette alert, Appears to be Fixed in WoD will need to monitor
-- Refrence: http://wowpedia.org/API_C_Vignettes.GetVignetteInfoFromInstanceID
function private.VFrame:VIGNETTE_ADDED(event, instanceID, ...)
	vignette_found_count = vignette_found_count + 1

	local x, y, name, iconID = _G.C_Vignettes.GetVignetteInfoFromInstanceID(instanceID)

	private.Debug("VIGNETTE_ADDED - %s", instanceID)
	if not private.CharacterOptions.TrackVignettes or
		not instanceID or
		_G.GetUnitName("target") == last_vignette_id or
		not VignetteZoneCheck or
		_G.UnitIsDeadOrGhost("player") or
		not private.AntiSpam(private.ANTI_SPAM_DELAY, name) then
		return false
	end

	-- iconId seems to be 40:chests, 41:mobs, 45: Tannan special rares
	local npcID = private.NPC_NAME_TO_ID[name]
	local alert_text

	if not iconID then
		alert_text = L["FOUND_FORMAT"]:format("Vignette Mob")
		private.Button:SetNPC(29147, "Vignette Mob", "Unknown Vignette")
	elseif iconID == VIGNETTE_MOB_ID or iconID == VIGNETTE_EVENT_MOB_ID or iconID == VIGNETTE_STAR_ICON_ID then
		if npcID and private.ScanIDs[npcID] and not _G._NPCScanOptions.IgnoreList.NPCs[npcID] then
			private.Button:SetNPC(npcID, name, "Vignette Mob")
		else
			private.Button:SetNPC(29147, name, "Unknown Vignette")
		end

		alert_text = L["FOUND_FORMAT"]:format("Vignette Mob: " .. name)
	else
		private.Debug("Untracked Vigenette: %s - iconID %s", name, iconID)
	end

	if private.CharacterOptions.ShowAlertAsToast and alert_text then
		Toast:Spawn("_NPCScanAlertToast", alert_text)
	elseif alert_text then
		private.Print(alert_text, _G.GREEN_FONT_COLOR)
	end
end


--Clears last seen mob when vignette is removed from map
function private.VFrame:VIGNETTE_REMOVED(event, instanceId, ...)
	vignette_found_count = vignette_found_count - 1
	if vignette_found_count == 0 then
		if not _G.InCombatLockdown() then
			last_vignette_id = 0
		end
	end
end

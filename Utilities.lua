-- ----------------------------------------------------------------------------
-- Localized Lua globals.
-- ----------------------------------------------------------------------------
-- Functions
local pairs = _G.pairs
local tonumber = _G.tonumber
local tostring = _G.tostring
local type = _G.type

-- Libraries
local table = _G.table

-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local AddOnFolderName, private = ...

-----------------------------------------------------------------------
-- Helpers
-----------------------------------------------------------------------
local function CreateAlphaAnimation(animationGroup, fromAlpha, toAlpha, duration, startDelay, order)
	local animation = animationGroup:CreateAnimation("Alpha")
	animation:SetFromAlpha(fromAlpha)
	animation:SetToAlpha(toAlpha)
	animation:SetDuration(duration)

	if startDelay then
		animation:SetStartDelay(startDelay)
	end

	if order then
		animation:SetOrder(order)
	end

	return animation
end

private.CreateAlphaAnimation = CreateAlphaAnimation

local function CreateScaleAnimation(animationGroup, fromScaleX, fromScaleY, toScaleX, toScaleY, duration, startDelay, order)
	local animation = animationGroup:CreateAnimation("Scale")
	animation:SetFromScale(fromScaleX, fromScaleY)
	animation:SetToScale(toScaleX, toScaleY)
	animation:SetDuration(duration)

	if startDelay then
		animation:SetStartDelay(startDelay)
	end

	if order then
		animation:SetOrder(order)
	end

	return animation
end

private.CreateScaleAnimation = CreateScaleAnimation

local function GetMapOptionName(mapID)
	local profile = private.db.profile
	local isBlacklisted = profile.blacklist.mapIDs[mapID] or profile.detection.continentIDs[private.ContinentIDByMapID[mapID]] == private.DetectionGroupStatus.Disabled
	local colorCode = isBlacklisted and _G.RED_FONT_COLOR_CODE or _G.GREEN_FONT_COLOR_CODE
	return ("%s%s|r"):format(colorCode, private.MapNameByID[mapID])
end

private.GetMapOptionName = GetMapOptionName

local function GUIDToCreatureID(GUID)
	local unitTypeName, _, _, _, _, unitID = ("-"):split(GUID)
	if unitTypeName == "Creature" then
		return tonumber(unitID)
	end
end

private.GUIDToCreatureID = GUIDToCreatureID

local function IsNPCQuestComplete(npcID)
	local npcData = private.NPCData[npcID]
	if npcData then
		local questID = npcData.questID
		return questID and _G.IsQuestFlaggedCompleted(questID) or false
	end

	return false
end

private.IsNPCQuestComplete = IsNPCQuestComplete

local function NumericSortString(a, b)
	local x, y = tonumber(a), tonumber(b)

	if x and y then
		return x < y
	end

	return a < b
end

local function TableKeyFormat(input)
	return input and input:upper():gsub(" ", "_"):gsub("'", ""):gsub(":", ""):gsub("-", "_"):gsub("%(", ""):gsub("%)", "") or ""
end

local function UnitTokenToCreatureID(unitToken)
	if unitToken then
		local GUID = _G.UnitGUID(unitToken)
		if not GUID then
			return
		end

		return GUIDToCreatureID(GUID)
	end
end

private.UnitTokenToCreatureID = UnitTokenToCreatureID

do
	local OrderedDataFields = {
		"factionGroup",
		"isTameable",
		"questID",
		"vignetteName",
	}

	local SortedNPCIDs

	function private.DumpNPCData()
		local NPCScan = _G.LibStub("AceAddon-3.0"):GetAddon(AddOnFolderName)

		if not SortedNPCIDs then
			SortedNPCIDs = {}

			for npcID, data in pairs(private.NPCData) do
				SortedNPCIDs[#SortedNPCIDs + 1] = npcID
			end

			table.sort(SortedNPCIDs)
		end

		local npcData = private.NPCData
		local output = private.TextDump

		output:AddLine("local NPCData = {")

		for index = 1, #SortedNPCIDs do
			local npcID = SortedNPCIDs[index]
			local data = private.NPCData[npcID]

			local startedEntry = false

			for index = 1, #OrderedDataFields do
				local field = OrderedDataFields[index]
				local fieldInfo = data[field]

				if fieldInfo then
					if not startedEntry then
						startedEntry = true
						output:AddLine(("    [%d] = { -- %s"):format(npcID, NPCScan:GetNPCNameFromID(npcID)))
					end

					local fieldInfoOutput = type(fieldInfo) == "string" and ("\"%s\""):format(fieldInfo) or tostring(fieldInfo)
					local fieldInfoComment = field == "questID" and (" -- %s"):format(NPCScan:GetQuestNameFromID(fieldInfo)) or ""

					output:AddLine(("        %s = %s,%s"):format(field, fieldInfoOutput, fieldInfoComment))
				end
			end

			if startedEntry then
				output:AddLine("    },")
			end
		end

		output:AddLine("}")
		output:Display()
	end

	private.DUMP_COMMANDS = {
		npcdata = function()
			private.DumpNPCData()
		end
	}
end -- do-block

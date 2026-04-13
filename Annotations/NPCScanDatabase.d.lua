---@meta _

--------------------------------------------------------------------------------
---- Types
--------------------------------------------------------------------------------

---@class NPCScanDatabase.Profile.UserDefined
---@field continentNPCs table<integer, table<integer, NPCData>>
---@field mapNPCs table<integer, table<integer, NPCData>>
---@field npcIDs table<integer, boolean?>

---@class NPCScanDatabase.Profile.TargetButtonGroup
---@field durationSeconds integer
---@field hideDuringCombat boolean
---@field isEnabled boolean
---@field point FramePoint
---@field scale number
---@field x integer
---@field y integer

---@class NPCScanDatabase.Profile.Detection
---@field achievementIDs table
---@field continentIDs table
---@field ignoreCompletedAchievementCriteria boolean
---@field ignoreCompletedQuestObjectives boolean
---@field ignoreDeadNPCs boolean
---@field ignoreMinimap boolean
---@field ignoreWorldMap boolean
---@field intervalSeconds integer
---@field raidMarker table<"add" | "addInGroup", boolean>
---@field rares boolean
---@field tameables boolean
---@field userDefined boolean
---@field whileOnTaxi boolean

---@class NPCScanDatabase.Profile.Blacklist
---@field mapIDs table<integer, boolean>
---@field npcIDs table<integer, boolean>

---@class NPCScanDatabase.Profile.Alert.Sound
---@field channel string
---@field ignoreMute boolean
---@field isEnabled boolean
---@field sharedMediaNames table<string, boolean>

---@class NPCScanDatabase.Profile.Alert.ScreenFlash
---@field color table<"r" | "g" | "b" | "a", number>
---@field isEnabled boolean
---@field texture string

---@class NPCScanDatabase.Profile.Alert.Output
---@field sink20OutputSink string

---@class NPCScanDatabase.Profile.Alert
---@field output NPCScanDatabase.Profile.Alert.Output
---@field screenFlash NPCScanDatabase.Profile.Alert.ScreenFlash
---@field sound NPCScanDatabase.Profile.Alert.Sound

---@class NPCScanDatabase.Profile
---@field alert NPCScanDatabase.Profile.Alert
---@field blacklist NPCScanDatabase.Profile.Blacklist
---@field detection NPCScanDatabase.Profile.Detection
---@field targetButtonGroup NPCScanDatabase.Profile.TargetButtonGroup
---@field userDefined NPCScanDatabase.Profile.UserDefined

---@class NPCScanDatabase.Locale
---@field npcNames table<integer, string>
---@field questNames table<integer, string>

---@class NPCScanDatabase: AceDBObject-3.0
---@field locale NPCScanDatabase.Locale
---@field profile NPCScanDatabase.Profile

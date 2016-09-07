local AddOnFolderName, private = ...

local isReleaseVersion = true
--@debug@
isReleaseVersion = false
--@end-debug@


local L = _G.LibStub("AceLocale-3.0"):NewLocale(AddOnFolderName, "enUS", isReleaseVersion, isReleaseVersion)

if not L then return end

--@localization(locale="enUS", format="lua_additive_table", handle-unlocalized="ignore", escape-non-ascii=false, same-key-is-true=true)@

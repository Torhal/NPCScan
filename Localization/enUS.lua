local AddOnFolderName, private = ...

local isReleaseVersion = true
--@debug@
isReleaseVersion = false
--@end-debug@

local L = _G.LibStub("AceLocale-3.0"):NewLocale(AddOnFolderName, "enUS", isReleaseVersion, isReleaseVersion)
if not L then return end

--@localization(locale="enUS", format="lua_additive_table", same-key-is-true=true)@

local VL = _G.LibStub("AceLocale-3.0"):NewLocale(AddOnFolderName .. "Vignette", "enUS", isReleaseVersion, isReleaseVersion)
if not VL then return end

--@localization(locale="enUS", namespace="Vignette", table-name="VL", format="lua_additive_table", same-key-is-true=true)@

local AddOnFolderName, private = ...

local _G = getfenv(0)
local L = _G.LibStub("AceLocale-3.0"):NewLocale(AddOnFolderName, "esMX", false)

if not L then return end

--@localization(locale="esMX", format="lua_additive_table", handle-unlocalized="ignore", escape-non-ascii=false, same-key-is-true=true)@
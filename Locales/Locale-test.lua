--[[****************************************************************************
  * Localization test file for Curseforge's localization on build feature                                                         *
  * Locales/Locale-enUS.lua - Localized string constants (en-US).              *
  ****************************************************************************]]
private = select( 2, ... )

-- See http://wow.curseforge.com/addons/npcscan/localization/enUS/
private.L  = setmetatable(
  {NPCs = {},
  }, -- empty table
  {
    __index = function(self, key) -- line 8
      rawset(self, key, key)
      return key
    end
  }
)

--@localization(locale="enUS", namespace="Localization", format="lua_additive_table", table-name="private.L", handle-unlocalized="comment", escape-non-ascii="true",handle-subnamespaces="none")@
--@localization(locale="enUS", namespace="NPCs ", format="lua_additive_table", table-name="private.L.NPCs", handle-unlocalized="comment", escape-non-ascii="true",handle-subnamespaces="none")@
SLASH__NPCSCAN1 = "/npcscan";
SLASH__NPCSCAN2 = "/scan";

BINDING_HEADER__NPCSCAN = "_|cffCCCC88NPCScan|r";
_G[ "BINDING_NAME_CLICK _NPCScanButton:LeftButton" ] = [=[Target last found mob
|cff808080(Use when _NPCScan alerts you)|r]=];
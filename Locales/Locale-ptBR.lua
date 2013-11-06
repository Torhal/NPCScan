--[[****************************************************************************
  * _NPCScan by Saiket                                                         *
  * Locales/Locale-ptBR.lua - Localized string constants (pt-BR).              *
  ****************************************************************************]]


if ( GetLocale() ~= "ptBR" and GetLocale() ~= "ptPT" ) then
	return;
end


-- See http://wow.curseforge.com/addons/npcscan/localization/ptBR/
local private = select( 2, ... );
private.L = setmetatable( {
	NPCs = setmetatable( {
	}, { __index = private.L.NPCs; } );
}, { __index = _private.L; } );


--@localization(locale="ptBR", namespace="Localization", format="lua_additive_table", table-name="private.L", handle-unlocalized="comment",handle-subnamespaces="none")@


--Loads npc id's into a temp file to convert strings into numbers
local temp = {}

--@localization(locale="ptBR", namespace="NPCs", format="lua_addtive_table", table-name="temp", handle-unlocalized="comment", handle-subnamespaces="none")@

for ID, Name in pairs(temp) do
	private.L.NPCs[tonumber(ID)] = Name
end

_G[ "BINDING_NAME_CLICK _NPCScanButton:LeftButton" ] = [=[Marca o ultimo PNJ encontrado
|cff808080(Use quando _NPCScan alertar você)|r]=];
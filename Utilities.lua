--------------------------------------------------------------------------------
---- Lua Builtins
--------------------------------------------------------------------------------

-- Functions
local pairs = pairs
local tonumber = tonumber
local tostring = tostring
local type = type

-- Libraries
local table = table

--------------------------------------------------------------------------------
---- AddOn Namespace
--------------------------------------------------------------------------------

local AddOnFolderName = ... ---@type string
local private = select(2, ...) ---@class PrivateNamespace

--------------------------------------------------------------------------------
---- Helpers
--------------------------------------------------------------------------------

---@param animationGroup AnimationGroup
---@param fromAlpha number
---@param toAlpha number
---@param duration number
---@param startDelay? number
---@param order? number
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

---@param animationGroup AnimationGroup
---@param fromScaleX number
---@param fromScaleY number
---@param toScaleX number
---@param toScaleY number
---@param duration number
---@param startDelay? number
---@param order? number
local function CreateScaleAnimation(
    animationGroup,
    fromScaleX,
    fromScaleY,
    toScaleX,
    toScaleY,
    duration,
    startDelay,
    order
)
    local animation = animationGroup:CreateAnimation("Scale")
    animation:SetScaleFrom(fromScaleX, fromScaleY)
    animation:SetScaleTo(toScaleX, toScaleY)
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

---@param atlasName string
local function FormatAtlasTexture(atlasName)
    local atlasInfo = C_Texture.GetAtlasInfo(atlasName)

    if not atlasInfo.file then
        return
    end

    local bottomTexCoord = atlasInfo.bottomTexCoord
    local leftTexCoord = atlasInfo.leftTexCoord
    local rightTexCoord = atlasInfo.rightTexCoord
    local topTexCoord = atlasInfo.topTexCoord

    local atlasWidth = atlasInfo.width / (rightTexCoord - leftTexCoord)
    local atlasHeight = atlasInfo.height / (bottomTexCoord - topTexCoord)
    local pxLeft = atlasWidth * leftTexCoord
    local pxRight = atlasWidth * rightTexCoord
    local pxTop = atlasHeight * topTexCoord
    local pxBottom = atlasHeight * bottomTexCoord

    return ("|T%s:%d:%d:0:0:%d:%d:%d:%d:%d:%d|t"):format(
        atlasInfo.file,
        0,
        0,
        atlasWidth,
        atlasHeight,
        pxLeft,
        pxRight,
        pxTop,
        pxBottom
    )
end

private.FormatAtlasTexture = FormatAtlasTexture

do
    local ValidUnitTypeNames = {
        Creature = true,
        Vehicle = true,
    }

    ---@param GUID string
    ---@return integer | nil
    local function GUIDToCreatureID(GUID)
        local unitTypeName, _, _, _, _, unitID = ("-"):split(GUID)
        if ValidUnitTypeNames[unitTypeName] then
            return tonumber(unitID)
        end
    end

    private.GUIDToCreatureID = GUIDToCreatureID

    ---@param unitToken UnitToken
    ---@return integer | nil
    local function UnitTokenToCreatureID(unitToken)
        if unitToken then
            local GUID = UnitGUID(unitToken)
            if not GUID then
                return
            end

            return GUIDToCreatureID(GUID)
        end
    end

    private.UnitTokenToCreatureID = UnitTokenToCreatureID
end -- do-block

local function NumericSortString(a, b)
    local x, y = tonumber(a), tonumber(b)

    if x and y then
        return x < y
    end

    return a < b
end

local function TableKeyFormat(input)
    return input
            and input:upper():gsub(" ", "_"):gsub("'", ""):gsub(":", ""):gsub("-", "_"):gsub("%(", ""):gsub("%)", "")
        or ""
end

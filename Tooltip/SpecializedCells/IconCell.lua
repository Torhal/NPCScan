--------------------------------------------------------------------------------
---- Library Namespace
--------------------------------------------------------------------------------

local QTip = LibStub:GetLibrary("LibQTip-2.0")

local providerValues = QTip:CreateCellProvider()

QTip:RegisterCellProvider("LibQTip-2.0 Icon", providerValues.newCellProvider)

---@class LibQTip-2.0.IconCell: LibQTip-2.0.Cell
---@field IconTexture Texture
local IconCell = providerValues.newCellPrototype

local BaseCell = providerValues.baseCellPrototype

--------------------------------------------------------------------------------
---- Constants
--------------------------------------------------------------------------------

local DefaultIconSize = 18

--------------------------------------------------------------------------------
---- Methods
--------------------------------------------------------------------------------

function IconCell:GetContentHeight()
	return self.IconTexture:GetHeight()
end

-- Returns the size of the IconCell.
---@return number width The width of the IconCell.
---@return number height The height of the IconCell.
function IconCell:GetSize()
	return self.IconTexture:GetSize()
end

function IconCell:OnCreation()
	BaseCell.OnCreation(self)

	local iconTexture = self:CreateTexture(nil, "ARTWORK")
	iconTexture:SetSize(DefaultIconSize, DefaultIconSize)
	iconTexture:SetPoint("CENTER", self)

	self.IconTexture = iconTexture
end

function IconCell:OnRelease()
	BaseCell.OnRelease(self)

	self.IconTexture:SetSize(DefaultIconSize, DefaultIconSize)
	self.IconTexture:SetTexture(nil)
end

---@param width number
---@param height number
---@return LibQTip-2.0.IconCell
function IconCell:SetIconSize(width, height)
	self.IconTexture:SetSize(width, height)

	self:OnContentChanged()

	return self
end

-- Works identically to the default UI's texture:SetTexCoord() API, for the IconCell's IconTexture.
---@param ... number Arguments to pass to texture:SetTexCoord()
---@overload fun(ULx: number, ULy: number, LLx: number, LLy: number, URx: number, URy: number, LRx: number, LRy: number)
---@overload fun(minX: number, maxX: number, minY: number, maxY: number)
---@return LibQTip-2.0.IconCell
function IconCell:SetIconTexCoord(...)
	self.IconTexture:SetTexCoord(...)

	return self
end

--- Populates the Cell with an icon texture.
---@param texturePath string The path to the icon asset.
---@return LibQTip-2.0.IconCell
function IconCell:SetIconTexture(texturePath)
	self.IconTexture:SetTexture(texturePath)

	self:OnContentChanged()

	return self
end

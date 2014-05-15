SpriteItemBomb = class(Sprite)
SpriteItemBomb.spriteInitImage = SpriteItemBomb.super.initImage

function SpriteItemBomb:imageCache()
    return Cache:loadImage("graphics/Items.png")
end

function SpriteItemBomb:initImage()
    self:spriteInitImage()
    --
    local w = self:imageWidth() / 5
    local h = self:imageHeight()
    local x = 0
    local y = 0
    self:setQuad(x, y, w, h)
end
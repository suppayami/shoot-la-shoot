SpriteItemBoostB = class(Sprite)
SpriteItemBoostB.spriteInitImage = SpriteItemBoostB.super.initImage

function SpriteItemBoostB:imageCache()
    return Cache:loadImage("graphics/Items.png")
end

function SpriteItemBoostB:initImage()
    self:spriteInitImage()
    --
    local w = self:imageWidth() / 5
    local h = self:imageHeight()
    local x = w * 1
    local y = 0
    self:setQuad(x, y, w, h)
end
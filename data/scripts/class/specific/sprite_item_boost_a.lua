SpriteItemBoostA = class(Sprite)
SpriteItemBoostA.spriteInitImage = SpriteItemBoostA.super.initImage

function SpriteItemBoostA:imageCache()
    return Cache:loadImage("graphics/Items.png")
end

function SpriteItemBoostA:initImage()
    self:spriteInitImage()
    --
    local w = self:imageWidth() / 5
    local h = self:imageHeight()
    local x = w * 2
    local y = 0
    self:setQuad(x, y, w, h)
end
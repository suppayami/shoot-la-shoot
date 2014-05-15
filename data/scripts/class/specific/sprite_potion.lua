SpriteItemPotion = class(Sprite)
SpriteItemPotion.spriteInitImage = SpriteItemPotion.super.initImage

function SpriteItemPotion:imageCache()
    return Cache:loadImage("graphics/Items.png")
end

function SpriteItemPotion:initImage()
    self:spriteInitImage()
    --
    local w = self:imageWidth() / 5
    local h = self:imageHeight()
    local x = w * 3
    local y = 0
    self:setQuad(x, y, w, h)
end
SpriteItemCroquette = class(Sprite)
SpriteItemCroquette.spriteInitImage = SpriteItemCroquette.super.initImage

function SpriteItemCroquette:imageCache()
    return Cache:loadImage("graphics/Items.png")
end

function SpriteItemCroquette:initImage()
    self:spriteInitImage()
    --
    local w = self:imageWidth() / 5
    local h = self:imageHeight()
    local x = w * 4
    local y = 0
    self:setQuad(x, y, w, h)
end
SpriteBackgroundGround = class(Sprite)

function SpriteBackgroundGround:imageCache()
    local bg = Cache:loadImage("graphics/bg.png")
    self.z  = 1
    bg:setWrap("repeat", "repeat")
    return bg
end

function SpriteBackgroundGround:update(dt)
    self:setQuad(0, self:quadY() - 2, self:width(), self:height())
end
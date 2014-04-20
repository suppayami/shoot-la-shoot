SpriteBackgroundDeco = class(Sprite)

function SpriteBackgroundDeco:imageCache()
    local bg = Cache:loadImage("graphics/clouds.png")
    bg:setWrap("repeat", "repeat")
    self.z = 2
    return bg
end

function SpriteBackgroundDeco:update(dt)
    self:setQuad(0, self:quadY() - 5, self:width(), self:height())
end
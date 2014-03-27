SpriteRyuko = class(Sprite)

function SpriteRyuko:initImage()
    local image = self:imageCache()
    self:setImage(image)
end

function SpriteRyuko:imageCache()
    return Cache:loadImage("graphics/player.png")
end
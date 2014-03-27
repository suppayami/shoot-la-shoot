SpriteRyuko = class(Sprite)

function SpriteRyuko:initImage()
    local image = Cache:loadImage("graphics/player.png")
    self:setImage(image)
end
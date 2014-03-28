SpriteEnemyB = class(Sprite)

function SpriteEnemyB:initImage()
    local image = self:imageCache()
    self:setImage(image)
end

function SpriteEnemyB:imageCache()
    return Cache:loadImage("graphics/enemy A.png")
end
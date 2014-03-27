SpriteEnemyA = class(Sprite)

function SpriteEnemyA:initImage()
    local image = self:imageCache()
    self:setImage(image)
end

function SpriteEnemyA:imageCache()
    return Cache:loadImage("graphics/enemy A.png")
end
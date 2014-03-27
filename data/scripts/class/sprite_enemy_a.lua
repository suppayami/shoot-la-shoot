SpriteEnemyA = class(Sprite)

function SpriteEnemyA:initImage()
    local image = Cache:loadImage("graphics/enemy A.png")
    self:setImage(image)
end
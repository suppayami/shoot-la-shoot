SpriteBulletEnemyB = class(Sprite)

function SpriteBulletEnemyB:initImage()
    local image = self:imageCache()
    self:setImage(image)
end

function SpriteBulletEnemyB:imageCache()
    return Cache:loadImage("graphics/bullet.png")
end
SpriteBulletEnemyA = class(Sprite)

function SpriteBulletEnemyA:initImage()
    local image = self:imageCache()
    self:setImage(image)
end

function SpriteBulletEnemyA:imageCache()
    return Cache:loadImage("graphics/bullet.png")
end
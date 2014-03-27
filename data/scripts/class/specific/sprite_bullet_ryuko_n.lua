SpriteBulletRyukoN = class(Sprite)

function SpriteBulletRyukoN:initImage()
    local image = self:imageCache()
    self:setImage(image)
end

function SpriteBulletRyukoN:imageCache()
    return Cache:loadImage("graphics/bullet.png")
end
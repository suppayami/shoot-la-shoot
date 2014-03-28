Ryuko = class(Player)

function Ryuko:spriteClass()
    return SpriteRyuko
end

function Ryuko:spriteLayer()
    return "player"
end

function Ryuko:spriteName()
    return "player"
end

function Ryuko:shootDelay()
    return 8
end

function Ryuko:moveRateX()
    return 6
end

function Ryuko:moveRateY()
    return 6
end

function Ryuko:bulletClass()
    return BulletRyukoN -- bullet class
end

function Ryuko:bulletType()
    return "playerBullet"
end

function Ryuko:bulletName()
    return "ryuko_bullet_n"
end

function Ryuko:actionShoot()
    local imageCache = self:bulletSpriteClass():imageCache()
    local x1 = self.x - self.width / 2 + imageCache:getWidth() / 2
    local x2 = self.x + self.width / 2 - imageCache:getWidth() / 2
    local y  = self.y - self.height / 2 - imageCache:getHeight()

    self:createBullet(x1, y)
    self:createBullet(x2, y)
end
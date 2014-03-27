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

function Ryuko:bulletSpriteClass()
    return self:bulletClass():spriteClass() -- bullet class
end

function Ryuko:bulletType()
    return "playerBullet"
end

function Ryuko:actionShoot()
    local imageCache = self:bulletSpriteClass():imageCache()
    local x1 = self.x
    local x2 = self.x + self.width - imageCache:getWidth()
    local y  = self.y - imageCache:getHeight() - 2

    self:createBullet(x1, y)
    self:createBullet(x2, y)
end
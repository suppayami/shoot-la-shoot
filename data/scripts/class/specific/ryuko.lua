Ryuko = class(Player)
Ryuko.playerInitParams = Ryuko.super.initParams

function Ryuko:initParams()
    Ryuko:playerInitParams()
    -- hp and regen
    self.regen = 5 / 60
    self.hp    = 100
    self.mhp   = 100
    -- power up
    self.powerA = false
    self.powerB = false
end

function Ryuko:initSize()
    self.width  = self.sprite:width() - 64
    self.height = self.sprite:height() - 96
end

function Ryuko:spriteClass()
    return SpriteRyuko
end

function Ryuko:spriteLayer()
    return "scene"
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
    local x1 = self.x - self.sprite:width() / 2 + imageCache:getWidth() / 2 + self.sprite:width() / 4
    local x2 = self.x + self.sprite:width() / 2 - imageCache:getWidth() / 2 - self.sprite:width() / 4
    local x3 = x1 - 20
    local x4 = x2 + 20
    local y  = self.y - self.sprite:height() / 2 - imageCache:getHeight() + 12

    self:createBullet(x1, y)
    self:createBullet(x2, y)
    if self.powerB then
        local b1 = self:createBullet(x3, y)
        local b2 = self:createBullet(x4, y)
        b1.sprite.angle = - math.pi / 4 + math.pi / 8
        b2.sprite.angle = math.pi / 4 - math.pi / 8
    end
end

function Ryuko:lostLife()
    self.powerA = false
    self.powerB = false
end

function Ryuko:getDamage()
    if self.powerA then
        return 20
    else
        return 10
    end
end
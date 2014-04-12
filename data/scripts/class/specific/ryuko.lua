Ryuko = class(Player)
Ryuko.playerInitParams = Ryuko.super.initParams

function Ryuko:initParams()
    Ryuko:playerInitParams()
    -- hp and regen
    self.regen = 1 / 240
    self.hp    = 10
    -- power up
    self.powerA = false
    self.powerB = false
end

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
    if self.powerA then
        return BulletRyukoA -- bullet class for power A
    else
        return BulletRyukoN -- bullet class
    end
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
    local x3 = x1 - (x2 - x1)
    local x4 = x2 + (x2 - x1)
    local y  = self.y - self.height / 2 - imageCache:getHeight()

    self:createBullet(x1, y)
    self:createBullet(x2, y)
    if self.powerB then
        self:createBullet(x3, y)
        self:createBullet(x4, y)
    end
end
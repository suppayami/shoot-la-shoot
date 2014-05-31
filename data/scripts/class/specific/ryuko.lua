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
    self.width  = self.sprite:width()
    self.height = self.sprite:height()
    --
    self:setCollisionMask("Ryuko Collision Mask.png")
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

    local shootSE = love.audio.newSource("sounds/Ryuko Shoot.wav", "stream")

    local b1 = self:createBullet(x1, y)
    local b2 = self:createBullet(x2, y)

    if self.powerA then
        b1.sprite.red = 203
        b1.sprite.green = 192
        b1.sprite.blue = 245
        b2.sprite.red = 203
        b2.sprite.green = 192
        b2.sprite.blue = 245
    end

    if self.powerB then
        local b3 = self:createBullet(x3, y)
        local b4 = self:createBullet(x4, y)
        b3.sprite.angle = - math.pi / 4 + math.pi / 8
        b4.sprite.angle = math.pi / 4 - math.pi / 8

        if self.powerA then
            b3.sprite.red = 203
            b3.sprite.green = 192
            b3.sprite.blue = 245
            b4.sprite.red = 203
            b4.sprite.green = 192
            b4.sprite.blue = 245
        end
    end

    shootSE:setVolume(0.5)
    shootSE:play()
end

function Ryuko:lostLife()
    self.powerA = false
    self.powerB = false
end

function Ryuko:getDamage()
    if self.powerA then
        return 15
    else
        return 10
    end
end

Satsuki = class(Player)
Satsuki.playerInitParams = Satsuki.super.initParams

function Satsuki:initParams()
    Satsuki:playerInitParams()
    -- hp and regen
    self.regen = 7 / 60
    self.hp    = 120
    self.mhp   = 120
    -- power up
    self.powerA = false
    self.powerB = false
end

function Satsuki:initSize()
    self.width  = self.sprite:width()
    self.height = self.sprite:height()
    --
    self:setCollisionMask("Satsuki Collision Mask.png")
end

function Satsuki:spriteClass()
    return SpriteSatsuki
end

function Satsuki:spriteLayer()
    return "scene"
end

function Satsuki:spriteName()
    return "player"
end

function Satsuki:shootDelay()
    if self.powerA then
        return 15
    else
        return 30
    end
end

function Satsuki:moveRateX()
    return 6
end

function Satsuki:moveRateY()
    return 6
end

function Satsuki:bulletClass()
    return BulletSatsuki -- bullet class
end

function Satsuki:bulletType()
    return "playerBullet"
end

function Satsuki:bulletName()
    return "satsuki_bullet_n"
end

function Satsuki:actionShoot()
    local imageCache = self:bulletSpriteClass():imageCache()
    local x1 = self.x - self.sprite:width() / 2
    local x2 = self.x + self.sprite:width() / 2
    local x3 = self.x - self.sprite:width()
    local x4 = self.x + self.sprite:width()
    local y1 = self.y - self.sprite:height() / 2 - imageCache:getHeight() + 36
    local y2 = self.y - self.sprite:height() / 2 + 36

    local shootSE = love.audio.newSource("sounds/Satsuki Missile Launch [freesfx.co.uk].mp3", "stream")

    if self.powerB then
        local target   = nil
        local allEnemy = ModelManager:getModelArray("enemyCharacter")

        if #allEnemy >= 1 then
            target = allEnemy[randomNumber:random(1, #allEnemy)]
            self:createBullet(x1, y1, target, true)
            target = allEnemy[randomNumber:random(1, #allEnemy)]
            self:createBullet(x2, y1, target, true)
            target = allEnemy[randomNumber:random(1, #allEnemy)]
            self:createBullet(x3, y2, target, true)
            target = allEnemy[randomNumber:random(1, #allEnemy)]
            self:createBullet(x4, y2, target, true)
        else
            self:createBullet(x1, y1)
            self:createBullet(x2, y1)
            self:createBullet(x3, y2)
            self:createBullet(x4, y2)
        end
    else
        self:createBullet(x1, y1)
        self:createBullet(x2, y1)
        self:createBullet(x3, y2)
        self:createBullet(x4, y2)
    end

    shootSE:setVolume(0.5)
    shootSE:play()
end

function Satsuki:lostLife()
    self.powerA = false
    self.powerB = false
end

function Satsuki:getDamage()
    return 30
end

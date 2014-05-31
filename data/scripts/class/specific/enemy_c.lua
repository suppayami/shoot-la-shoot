EnemyC = class(Enemy)
EnemyC.enemyInitParams      = EnemyC.super.initParams
EnemyC.enemyAttackCondition = EnemyC.super.attackCondition

function EnemyC:initSpawn()
    self.a = 90
    self.b = 0
    self.c = randomNumber:random(1, 3)
    self.f = 1 / randomNumber:random(45, 70)
    self.x = randomNumber:random(self.width / 2, love.window.getWidth() - self.width / 2)
    self.y = -48
    --
    self.bc = 0
    self.bd = 0
    --
    if self.x < love.window.getWidth() / 2 then
        self.a = self.a * (- 1)
    end
    --
    local max = math.max(self.x, love.window.getWidth() - self.x) / 2
    local min = max / 1.5
    self.s = randomNumber:random(min, max)
    --
    self:update()
end

function EnemyC:initParams()
    self:enemyInitParams()
    self.hp    = 50
    self.mhp   = 50
end

function EnemyC:spriteClass()
    return SpriteEnemyC
end

function EnemyC:spriteLayer()
    return "scene"
end

function EnemyC:spriteName()
    return "enemy_c"
end

function EnemyC:getScore()
    return 10
end

function EnemyC:shootDelay()
    return 60
end

function EnemyC:moveRateX()
    local s  = self.s
    local dt = self.f
    self.b   = self.b + dt
    return s * math.cos(math.pi * self.a / 180 + self.b) * dt
end

function EnemyC:moveRateY()
    return self.c
end

function EnemyC:bulletClass()
    return BulletEnemyC -- bullet class
end

function EnemyC:bulletType()
    return "enemyBullet"
end

function EnemyC:bulletName()
    return "enemy_bullet_c"
end

function EnemyC:actionShoot()
    -- self.attack = true
end

function EnemyC:attackCondition()
    -- local cond = self:enemyAttackCondition()
    -- self.bd = self.bd - 1
    -- cond = cond and (self.bd <= 0)
    -- return cond
    return false
end

function EnemyC:actionAttack()
    -- local imageCache = self:bulletSpriteClass():imageCache()
    -- local x = self.x
    -- local y = self.y + self.height / 2 + imageCache:getHeight()

    -- self:createBullet(x, y)

    -- self.bc = self.bc + 1
    -- self.bd = 12

    -- if self.bc >= 3 then
    --     self.attack = false
    --     self.bc = 0
    --     self.bd = 0
    -- end
end

function EnemyC:deathEffect()
    local layer  = self:spriteLayer()
    local name   = "deadeffect"..self:spriteName()
    local class  = SpriteEnemyDead
    local sprite = LayerManager:addSprite(layer, name, class)
    local deathSE = SoundManager:addSound("Enemy Death.wav")

    sprite.x  = self.x
    sprite.y  = self.y
    
    sprite.ox = sprite:width() / 2
    sprite.oy = sprite:width() / 2

    sprite:autoDestroy(1)
    deathSE:play()
end

-- X-axis:
-- 320 * sin(n + t)
-- moveRateX:
-- 320 * cos(n + t) * dt
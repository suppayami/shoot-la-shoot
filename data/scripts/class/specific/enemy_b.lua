EnemyB = class(Enemy)
EnemyB.enemyInitParams      = EnemyB.super.initParams
EnemyB.enemyAttackCondition = EnemyB.super.attackCondition

function EnemyB:initSpawn()
    self.h = 0
    self.w = 0
    self.rh = randomNumber:random(150, 360)
    self.rw = randomNumber:random(290, 360)
    if randomNumber:random(1, 10) <= 5 then
        self.x = randomNumber:random(32, 128)
    else
        self.x = randomNumber:random(480, 612)
        self.rw = -self.rw
    end
    self.y = -48
    --
    self.bc = 0
    self.bd = 0
    --
    self:update()
end

function EnemyB:initParams()
    self:enemyInitParams()
    self.hp    = 100
    self.mhp   = 100
end

function EnemyB:spriteClass()
    return SpriteEnemyB
end

function EnemyB:spriteLayer()
    return "scene"
end

function EnemyB:spriteName()
    return "enemy_b"
end

function EnemyB:getScore()
    return 30
end

function EnemyB:shootDelay()
    return 60
end

function EnemyB:moveRateX()
    if self.h >= self.rh and self.w < math.abs(self.rw) then
        self.w = self.w + 3
        if self.rw > 0 then
            return 3
        else
            return -3
        end
    else
        return 0
    end 
end

function EnemyB:moveRateY()
    if self.h < self.rh or self.w >= math.abs(self.rw) then
        self.h = self.h + 3
        return 3
    else
        return 0
    end
end

function EnemyB:bulletClass()
    return BulletEnemyB -- bullet class
end

function EnemyB:bulletType()
    return "enemyBullet"
end

function EnemyB:bulletName()
    return "enemy_bullet_b"
end

function EnemyB:actionShoot()
    if self.destroyed then return end
    self.sprite:setRow(1)
    self.sprite:noLoop(function() 
        self.attack = true
    end)
end

function EnemyB:attackCondition()
    local cond = self:enemyAttackCondition()
    self.bd = self.bd - 1
    cond = cond and (self.bd <= 0)
    return cond
end

function EnemyB:actionAttack()
    if self.destroyed then return end
    local imageCache = self:bulletSpriteClass():imageCache()
    local x = self.x
    local y = self.y

    self:createBullet(x, y)

    self.bc = self.bc + 1
    self.bd = 12

    if self.bc >= 3 then
        self.attack = false
        self.bc = 0
        self.bd = 0
        if self.sprite then
            self.sprite:setRow(0)
        end
    end
end

function EnemyB:deathEffect()
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

function EnemyB:getDamage()
    return 15
end

-- X-axis:
-- 320 * sin(n + t)
-- moveRateX:
-- 320 * cos(n + t) * dt
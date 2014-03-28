EnemyB = class(Enemy)
EnemyB.characterAttackCondition = EnemyB.super.attackCondition

function EnemyB:initSpawn()
    self.a = 90
    self.b = 0
    self.c = randomNumber:random(1, 3)
    self.f = 1 / randomNumber:random(45, 70)
    self.x = randomNumber:random(self.width / 2, love.window.getWidth() - self.width / 2)
    self.y = 0
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

function EnemyB:initParams()
    self.hp = 1
end

function EnemyB:spriteClass()
    return SpriteEnemyB
end

function EnemyB:spriteLayer()
    return "enemy"
end

function EnemyB:spriteName()
    return "enemy_b"
end

function EnemyB:shootDelay()
    return 60
end

function EnemyB:moveRateX()
    local s  = self.s
    local dt = self.f
    self.b   = self.b + dt
    return s * math.cos(math.pi * self.a / 180 + self.b) * dt
end

function EnemyB:moveRateY()
    return self.c
end

function EnemyB:bulletClass()
    return BulletEnemyA -- bullet class
end

function EnemyB:bulletType()
    return "enemyBullet"
end

function EnemyB:bulletName()
    return "enemy_bullet_b"
end

function EnemyB:actionShoot()
    self.attack = true
end

function EnemyB:attackCondition()
    local cond = self:characterAttackCondition()
    self.bd = self.bd - 1
    cond = cond and (self.bd <= 0)
    return cond
end

function EnemyB:actionAttack()
    local imageCache = self:bulletSpriteClass():imageCache()
    local x = self.x
    local y = self.y + self.height / 2 + imageCache:getHeight()

    self:createBullet(x, y)

    self.bc = self.bc + 1
    self.bd = 12

    if self.bc >= 3 then
        self.attack = false
        self.bc = 0
        self.bd = 0
    end
end

-- X-axis:
-- 320 * sin(n + t)
-- moveRateX:
-- 320 * cos(n + t) * dt
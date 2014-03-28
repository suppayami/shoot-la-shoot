EnemyA = class(Enemy)

function EnemyA:initSpawn()
    self.a = 90 * ((-1) ^ randomNumber:random(1,4))
    self.b = 0
    self.s = 330 + self.width / 2
    self.x = love.window.getWidth() / 2
    self.x = self.x + self.s * math.sin(math.pi * self.a / 180)
    self.y = randomNumber:random(self.height / 2 + 8, love.window.getHeight() / 4)
    self:update()
end

function EnemyA:initParams()
    self.hp = 1
end

function EnemyA:spriteClass()
    return SpriteEnemyA
end

function EnemyA:spriteLayer()
    return "enemy"
end

function EnemyA:spriteName()
    return "enemy_a"
end

function EnemyA:shootDelay()
    return 60
end

function EnemyA:moveRateX()
    local s  = self.s
    local dt = 1 / 150
    self.b   = self.b + dt
    -- only move 3 times
    if self.b > math.pi * 3 then
        return 999
    end
    -- return true rate
    return s * math.cos(math.pi * self.a / 180 + self.b) * dt
end

function EnemyA:moveRateY()
    return 0
end

function EnemyA:bulletClass()
    return BulletEnemyA -- bullet class
end

function EnemyA:bulletType()
    return "enemyBullet"
end

function EnemyA:bulletName()
    return "enemy_bullet_a"
end

function EnemyA:actionShoot()
    local imageCache = self:bulletSpriteClass():imageCache()
    local x = self.x
    local y = self.y + self.height / 2 + imageCache:getHeight()

    self:createBullet(x, y)
end

-- X-axis:
-- 320 * sin(n + t)
-- moveRateX:
-- 320 * cos(n + t) * dt
EnemyA = class(Enemy)
EnemyA.enemyInitParams = EnemyA.super.initParams

function EnemyA:initSpawn()
    self.a = 90 * ((-1) ^ randomNumber:random(1,4))
    self.b = 0
    self.s = 330 + self.width / 2
    self.x = love.window.getWidth() / 2
    self.x = self.x + self.s * math.sin(math.pi * self.a / 180)
    self.sy = randomNumber:random(self.height / 2 + 8, love.window.getHeight() / 4 - 60)
    self.y  = self.sy
    self:update()
end

function EnemyA:initParams()
    self:enemyInitParams()
    self.hp    = 200
    self.mhp   = 200
end

function EnemyA:spriteClass()
    return SpriteEnemyA
end

function EnemyA:spriteLayer()
    return "scene"
end

function EnemyA:spriteName()
    return "enemy_a"
end

function EnemyA:getScore()
    return 70
end

function EnemyA:shootDelay()
    return 60
end

function EnemyA:moveRateX()
    local s  = self.s
    local dt = 1 / 100
    self.b   = self.b + dt
    self.y   = self.sy + 160 * math.floor(self.b / math.pi)
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
    if self.destroyed then return end
    self.sprite:setRow(1)
    self.sprite:autoReset(0, function() 
        local imageCache = self:bulletSpriteClass():imageCache()
        local x = self.x
        local y = self.y
        local player = ModelManager:getModel("playerCharacter", "player")
        self:createBullet(x, y, player, false) 
    end)
end

function EnemyA:deathEffect()
    local layer  = self:spriteLayer()
    local name   = "deadeffect"..self:spriteName()
    local class  = SpriteEnemyDead
    local sprite = LayerManager:addSprite(layer, name, class)

    sprite.x  = self.x
    sprite.y  = self.y
    
    sprite.ox = sprite:width() / 2
    sprite.oy = sprite:width() / 2

    sprite:autoDestroy(1)
end

function EnemyA:getDamage()
    return 30
end

-- X-axis:
-- 320 * sin(n + t)
-- moveRateX:
-- 320 * cos(n + t) * dt
EnemyD = class(Enemy)
EnemyD.enemyInitParams = EnemyD.super.initParams

function EnemyD:initSpawn()
    self.s = randomNumber:random(120, 320) + 46
    self.x = randomNumber:random(64, 588)
    self.y = -46
    self:update()
end

function EnemyD:initParams()
    self:enemyInitParams()
end

function EnemyD:spriteClass()
    return SpriteEnemyD
end

function EnemyD:spriteLayer()
    return "scene"
end

function EnemyD:spriteName()
    return "enemy_d"
end

function EnemyD:shootDelay()
    return 120
end

function EnemyD:moveRateX()
    return 0
end

function EnemyD:moveRateY()
    if self.s > 0 then
        self.s = self.s - 3
        return 3
    else
        return 0
    end
end

function EnemyD:bulletClass()
    return BulletEnemyD -- bullet class
end

function EnemyD:bulletType()
    return "enemyBullet"
end

function EnemyD:bulletName()
    return "enemy_bullet_d"
end

function EnemyD:actionShoot()
    local imageCache = self:bulletSpriteClass():imageCache()
    local x = self.x
    local y = self.y + self.height / 2 + imageCache:getHeight()
    self:createBullet(x, y) 
end

function EnemyD:deathEffect()
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

-- X-axis:
-- 320 * sin(n + t)
-- moveRateX:
-- 320 * cos(n + t) * dt
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
    self.hp    = 100
    self.mhp   = 100
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

function EnemyD:getScore()
    return 50
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
    if self.destroyed then return end
    local imageCache = self:bulletSpriteClass():imageCache()
    local x = self.x
    local y = self.y
    local player = ModelManager:getModel("playerCharacter", "player")
    self:createBullet(x, y, player, false) 
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

function EnemyD:getDamage()
    return 15
end

-- X-axis:
-- 320 * sin(n + t)
-- moveRateX:
-- 320 * cos(n + t) * dt
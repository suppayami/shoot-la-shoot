EnemyRagyo = class(Enemy)
EnemyRagyo.enemyUpdate = EnemyRagyo.super.update
EnemyRagyo.enemyInitParams = EnemyRagyo.super.initParams
EnemyRagyo.enemyAttackCondition = EnemyRagyo.super.attackCondition

function EnemyRagyo:initSpawn()
    self.phase = 0
    self.position = 1
    --
    self.x = love.window.getWidth() / 2
    self.y = -48
    --
    self.bc = 0
    self.bd = 0
    --
    self.bombBatch = 0
    --
    self.devices = {}
    self.bombs   = {}
    --
    self.tempHP  = 0
    --
    self.touch = {}
    --
    self:update()
    self:initSprite()
end

function EnemyRagyo:positionPhase3()
    local pos = {}
    --
    if self.postion == 1 then
        pos.x = 585
        pos.y = 55
    elseif self.position == 2 then
        pos.x = 55
        pos.y = 55
    elseif self.position == 3 then
        pos.x = 585
        pos.y = 585
    elseif self.position == 4 then
        pos.x = 55
        pos.y = 585
    end
    --
    return pos
end

function EnemyRagyo:initParams()
    self:enemyInitParams()
    --
    self.mhp = 1000
    self.hp  = 1000
end

function EnemyRagyo:spriteClass()
    if self.phase == 1 or self.phase == 0 then
        return SpriteEnemyRagyoShield
    else
        return SpriteEnemyRagyo
    end
end

function EnemyRagyo:spriteLayer()
    return "scene"
end

function EnemyRagyo:spriteName()
    return "enemy_ragyo"
end

function EnemyRagyo:shootDelay()
    if self.phase == 1 then
        return 120
    elseif self.phase == 2 then
        return 60
    elseif self.phase == 3 then
        return 120
    else
        return 0
    end
end

function EnemyRagyo:moveRateX()
    local pos = self:positionPhase3()
    --
    if self.phase == 3 then
        if self.x < pos.x then
            return math.min(10, pos.x - self.x)
        else
            return math.max(pos.x - self.x, -10)
        end
    else
        return 0
    end
end

function EnemyRagyo:moveRateY()
    local pos = self:positionPhase3()
    --
    if self.phase == 0 and self.y == 120 then
        self.phase = 1
    end
    --
    if self.phase == 0 then
        return math.min(2, 120 - self.y)
    elseif self.phase == 3 then
        if self.y < pos.y then
            return math.min(10, pos.y - self.y)
        else
            return math.max(pos.y - self.y, -10)
        end
    else
        return 0
    end
end

function EnemyRagyo:bulletClass()
    return BulletEnemyRagyo
end

function EnemyRagyo:bulletType()
    return "enemyBullet"
end

function EnemyRagyo:bulletName()
    return "enemy_bullet_ragyo"
end

function EnemyRagyo:actionShoot()
    if self.destroyed then return end
    --
    if self.phase == 1 then
        self:throwBombs()
    elseif self.phase == 2 then
        self.attack = true
    elseif self.phase == 3 then
        self:shootSun()
    end
end

function EnemyRagyo:throwBombs()
    if self.bombBatch >= 2 then return end
    if self.phase ~= 1 then return end
    --
    for i=1,6 do
        local x = self.x
        local y = self.y
        local toX = randomNumber:random(40, 600)
        local toY = randomNumber:random(40, 600)

        local model = ModelManager:addModel("enemySpecial", "bomb", RagyoBomb, x, y)
        model:throwTo(toX, toY)

        model.sprite:setTimer(200, function()
            local layer  = self:spriteLayer()
            local name   = "deadeffect_bomb_"..self:spriteName()
            local class  = SpriteEnemyDead
            local sprite = LayerManager:addSprite(layer, name, class)

            sprite.x  = model.x
            sprite.y  = model.y
            
            sprite.ox = sprite:width() / 2
            sprite.oy = sprite:width() / 2

            sprite:autoDestroy(1)
            model:destroy()
        end)

        self.bombs[#self.bombs+1] = model
    end
    --
    self.bombBatch = self.bombBatch + 1
end

function EnemyRagyo:bombDamage()
    return 2
end

function EnemyRagyo:shootSun()
    for i=1,8 do
        local angle = math.pi / 4 * (i - 1)
        local imageCache = self:bulletSpriteClass():imageCache()
        local x = self.x + 60 * math.sin(angle)
        local y = self.y - 60 * math.cos(angle)

        local pos = {}

        pos.x = self.x + 100 * math.sin(angle)
        pos.y = self.y - 100 * math.cos(angle)
        pos.shootAngle = angle

        self:createBullet(x, y, pos, false)
    end
end

function EnemyRagyo:attackCondition()
    local cond = self:enemyAttackCondition()
    self.bd = self.bd - 1
    cond = cond and (self.bd <= 0)
    return cond
end

function EnemyRagyo:actionAttack()
    if self.destroyed then return end
    local imageCache = self:bulletSpriteClass():imageCache()
    local x = self.x
    local y = self.y + self.height / 2 + imageCache:getHeight()
    local player = ModelManager:getModel("playerCharacter", "player")

    self:createBullet(x, y, player, false)

    self.bc = self.bc + 1
    self.bd = 12

    if self.bc >= 3 then
        self.attack = false
        self.bc = 0
        self.bd = 0
    end
end

function EnemyRagyo:initPhase2()
    for i=1,4 do
        local model = ModelManager:addModel("enemyCharacter", "ragyo_device", RagyoDevice, i)
        self.devices[#self.devices+1] = model
    end
end

function EnemyRagyo:deathEffect()
    local layer  = self:spriteLayer()
    local name   = "deadeffect"..self:spriteName()
    local class  = SpriteRagyoDead
    local sprite = LayerManager:addSprite(layer, name, class)

    sprite.x  = self.x
    sprite.y  = self.y
    
    sprite.ox = sprite:width() / 2
    sprite.oy = sprite:width() / 2

    sprite:autoDestroy(1)
end

function EnemyRagyo:update()
    if self.destroyed then return end
    self:enemyUpdate()
    self:updatePhase()
end

function EnemyRagyo:updatePhase()
    if self.bombBatch >= 2 and self.phase == 1 then
        local change = true
        if #self.bombs == 0 then change = false end
        for k,v in pairs(self.bombs) do
            if not v.destroyed then change = false end
        end
        --
        if change then
            self.phase     = 2
            self.bombBatch = 0
            self.bombs     = {}
            self:initPhase2()
            self:initSprite()
        end
    end
    --
    if self.phase == 2 then
        local change = true
        if #self.devices == 0 then change = false end
        for k,v in pairs(self.devices) do
            if not v.destroyed then change = false end
        end
        --
        if change then
            self.phase    = 3
            self.devices  = {}
            self.tempHP   = self.hp
            self.position = 1
            self:initSprite()
        end
    end
    --
    if self.phase == 3 then
        local pos = self:positionPhase3()
        --
        if self.x == pos.x and self.y == pos.y then
            self.position = self.position + 1
            if self.position > 4 then
                self.position = 1
            end
        end
        --
        if self.tempHP - self.hp >= self.mhp / 3 then
            self.phase = 1
            self.position = 1
            self:initSprite()
        end
    end
end

function EnemyRagyo:updateCollidePlayer()
    local playerCharacter = ModelManager:getModel('playerCharacter')
    for k,v in pairs(playerCharacter) do
        if self:collided(v) then
            if not self.touch[v] then self.touch[v] = 0 end
            if self.touch[v] <= 0 then
                v:applyDamage(2, true)
                self.touch[v] = 30
            end
            self.touch[v] = self.touch[v] - 1
        end
    end
end

function EnemyRagyo:updateCollideBullet()
    local playerBullter = ModelManager:getModel('playerBullet')
    for k,v in pairs(playerBullter) do
        if self:collided(v) and self.phase > 1 then
            if not v.is_damage[self] then v.is_damage[self] = 0 end
            if v.is_damage[self] <= 0 then
                v:applyEffect(self)
                self:applyDamage(v:getDamage())
                v.is_damage[self] = 30
            end
        end
    end
end
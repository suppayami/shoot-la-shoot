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
    pos.x = 0
    pos.y = 0
    --
    if self.position == 1 then
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
    self.mhp = 3200
    self.hp  = 3200
end

function EnemyRagyo:getScore()
    return 1000
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
        return 340
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
            return math.min(8, pos.x - self.x)
        else
            return math.max(pos.x - self.x, -8)
        end
    elseif self.phase == 0 then
        if self.x < love.window.getWidth() / 2 then
            return math.min(2, love.window.getWidth() / 2 - self.x)
        else
            return math.max(-2, love.window.getWidth() / 2 - self.x)
        end
    else
        return 0
    end
end

function EnemyRagyo:moveRateY()
    local pos = self:positionPhase3()
    --
    if self.phase == 0 and self.y == 120 and self.x == love.window.getWidth() / 2 then
        self.phase = 1
    end
    --
    if self.phase == 0 then
        if self.y < 120 then
            return math.min(2, 120 - self.y)
        else
            return math.max(-2, 120 - self.y)
        end
    elseif self.phase == 3 then
        if self.y < pos.y then
            return math.min(8, pos.y - self.y)
        else
            return math.max(pos.y - self.y, -8)
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
            local playerCharacter = ModelManager:getModel('playerCharacter')

            sprite.x  = model.x
            sprite.y  = model.y

            sprite.ox = sprite:width() / 2
            sprite.oy = sprite:width() / 2

            sprite:autoDestroy(1)

            for k,v in pairs(playerCharacter) do
                local dist = math.sqrt((v.x - model.x) ^ 2 + (v.y - model.y) ^ 2)
                if dist <= 120 then
                    v:applyDamage(self:bombDamage())
                end
            end

            model:destroy()
        end)

        self.bombs[#self.bombs+1] = model
    end
    --
    self.bombBatch = self.bombBatch + 1
end

function EnemyRagyo:bombDamage()
    return 80
end

function EnemyRagyo:shootSun()
    for i=1,8 do
        local angle = math.pi / 4 * (i - 1)
        local imageCache = self:bulletSpriteClass():imageCache()
        local x = self.x
        local y = self.y

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
    local y = self.y
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
    local deathSE = SoundManager:addSound("Player Death.wav")

    sprite.x  = self.x
    sprite.y  = self.y

    sprite.ox = sprite:width() / 2
    sprite.oy = sprite:width() / 2

    sprite:autoDestroy(1)
    deathSE:play()

    love.preUnlocked = true
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
            self.phase = 0
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
                v:applyDamage(5, true)
                if self.phase > 1 then
                    self:applyDamage(5, true)
                end
                self.touch[v] = 30
            end
            self.touch[v] = self.touch[v] - 1
        end
    end
end

function EnemyRagyo:updateCollideBullet()
    local playerBullet = ModelManager:getModel('playerBullet')
    for k,v in pairs(playerBullet) do
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

function EnemyRagyo:getDamage()
    if self.phase == 2 then
        return 15
    else
        return 15
    end
end

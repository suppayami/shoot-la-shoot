EnemyNui = class(Enemy)
EnemyNui.enemyInitParams = EnemyNui.super.initParams
EnemyNui.enemyAttackCondition = EnemyNui.super.attackCondition

function EnemyNui:initSpawn()
    self.phase = 0
    self.dash  = 0 -- 0 mean normal, 1 mean dash down, 2 mean go up
    self.dashDelay = 120
    self.dashDam = {}
    --
    self.b = 0
    self.s = love.window.getWidth() / 2 - self.width / 2
    --
    self.gunAngle = 0
    self.gunTurn  = 0 -- 0 mean left, 1 mean right
    self.bc = 0
    self.bd = 0
    --
    self.touch = {}
    --
    self.x = love.window.getWidth() / 2
    self.y = -48
    self:update()
end

function EnemyNui:initParams()
    self:enemyInitParams()
    --
    self.mhp = 2500
    self.hp  = 2500
end

function EnemyNui:spriteClass()
    if self.dash == 1 then
        return SpriteEnemyNuiDash
    else
        return SpriteEnemyNui
    end
end

function EnemyNui:spriteLayer()
    return "scene"
end

function EnemyNui:spriteName()
    return "enemy_nui"
end

function EnemyNui:getScore()
    return 1000
end

function EnemyNui:shootDelay()
    if self.phase == 1 then
        return 10
    elseif self.phase == 2 then
        return 60
    else
        return 0
    end
end

function EnemyNui:moveRateX()
    local s  = self.s
    local dt = 1 / 120
    local player = ModelManager:getModel("playerCharacter", "player")
    --
    if self.phase == 0 then
        return 0
    end
    --
    if self.phase == 2 and self.dash == 0 then
        self.dashDelay = self.dashDelay - 1
    end
    --
    if self.phase == 2 and (self.x >= player.x - 36 and self.x <= player.x + 36)
        and self.dashDelay <= 0 and self.dash == 0 then
        self.dash = 1
        self.dashDelay = 120
        for k,v in pairs(self.touch) do
            self.touch[k] = 0
        end
        self.dashDam = {}
        self:initSprite()
    end
    --
    if self.b >= math.pi * 2 then
        self.b = self.b - math.pi * 2
        if self.phase == 1 then
            self.dashDelay = 120
            self.phase = 2
        elseif self.phase == 2 then
            self.phase = 1
        end
    end
    --
    if self.dash > 0 then
        return 0
    else
        self.b = self.b + dt
        -- return true rate
        return s * math.cos(self.b) * dt
    end
end

function EnemyNui:moveRateY()
    if self.phase == 0 and self.y == 120 then
        self.phase = 1
    end
    --
    if self.phase > 0 and self.dash == 1
        and self.y >= (love.window.getHeight() - self.height / 2) then
        self.dash = 2
        self:initSprite()
    end
    --
    if self.phase > 0 and self.dash == 2 and self.y <= 120 then
        self.dash = 0
    end
    --
    if self.phase == 0 then
        return math.min(2, 120 - self.y)
    else
        if self.dash == 0 then
            return 0
        elseif self.dash == 1 then
            return math.min(12, love.window.getHeight() - self.height / 2 - self.y)
        elseif self.dash == 2 then
            return math.max(-8, 120 - self.y)
        end
    end
end

function EnemyNui:bulletClass()
    if self.phase == 1 then
        return BulletEnemyNuiA
    elseif self.phase == 2 then
        return BulletEnemyNuiB
    end
end

function EnemyNui:bulletType()
    return "enemyBullet"
end

function EnemyNui:bulletName()
    return "enemy_bullet_nui"
end

function EnemyNui:actionShoot()
    if self.destroyed then return end
    if self.dash > 0 then return end
    if self.phase == 1 then
        local imageCache = self:bulletSpriteClass():imageCache()
        local x   = self.x
        local y   = self.y
        local pos = {}
        --
        if self.gunTurn == 0 then
            self.gunAngle = self.gunAngle - 5
        elseif self.gunTurn == 1 then
            self.gunAngle = self.gunAngle + 5
        end
        --
        if self.gunAngle <= -45 then
            self.gunTurn = 1
        elseif self.gunAngle >= 45 then
            self.gunTurn = 0
        end
        --
        pos.x = self.x + 100 * math.sin(self.gunAngle * math.pi / 180)
        pos.y = self.y + 100 * math.cos(self.gunAngle * math.pi / 180)
        pos.shootAngle = self.gunAngle * math.pi / 180
        --
        self:createBullet(x, y, pos, false)
    elseif self.phase == 2 then
        self.attack = true
    end
end

function EnemyNui:attackCondition()
    local cond = self:enemyAttackCondition()
    self.bd = self.bd - 1
    cond = cond and (self.bd <= 0)
    return cond
end

function EnemyNui:actionAttack()
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

function EnemyNui:deathEffect()
    local layer  = self:spriteLayer()
    local name   = "deadeffect"..self:spriteName()
    local class  = SpriteNuiDead
    local sprite = LayerManager:addSprite(layer, name, class)
    local deathSE = SoundManager:addSound("Player Death.wav")

    sprite.x  = self.x
    sprite.y  = self.y

    sprite.ox = sprite:width() / 2
    sprite.oy = sprite:width() / 2

    sprite:autoDestroy(1)
    deathSE:play()
end

function EnemyNui:updateCollidePlayer()
    local playerCharacter = ModelManager:getModel('playerCharacter')
    for k,v in pairs(playerCharacter) do
        if self:collided(v) then
            if not self.touch[v] then self.touch[v] = 0 end
            if self.dash == 1 and self.touch[v] <= 0 then
                v:applyDamage(30, true)
                self.touch[v] = 40
            end
            if self.dash ~= 1 and self.touch[v] <= 0 then
                v:applyDamage(5, true)
                self:applyDamage(5, true)
                self.touch[v] = 40
            end
            self.touch[v] = self.touch[v] - 1
            -- self:applyDamage(self.hp, true)
        end
    end
end

function EnemyNui:getDamage()
    if self.phase == 1 then
        return 30
    else
        return 35
    end
end

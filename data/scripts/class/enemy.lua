Enemy = class(Character)
Enemy.characterUpdateCollide = Enemy.super.updateCollide
Enemy.characterInit = Enemy.super.init

function Enemy:init()
    self:characterInit(0, 0)
    self.touch = {}
    self:initSpawn()
end

function Enemy:initSpawn()
    -- none
end

function Enemy:bulletType()
    return "enemyBullet"
end

function Enemy:getScore()
    return 0
end

function Enemy:afterDeath()
    if not love.score then love.score = 0 end
    love.score = love.score + self:getScore()
end

function Enemy:updateCollide()
    self:characterUpdateCollide()
    --
    self:updateCollidePlayer()
    self:updateCollideBullet()
end

function Enemy:updateCollidePlayer()
    local playerCharacter = ModelManager:getModel('playerCharacter')
    for k,v in pairs(playerCharacter) do
        if self:collided(v) then
            if not self.touch[v] then self.touch[v] = 0 end
            if self.touch[v] <= 0 then
                v:applyDamage(5, true)
                self:applyDamage(5, true)
                self.touch[v] = 30
            end
            self.touch[v] = self.touch[v] - 1
        end
    end
end

function Enemy:updateCollideBullet()
    local playerBullter = ModelManager:getModel('playerBullet')
    for k,v in pairs(playerBullter) do
        if self:collided(v) then
            if not v.is_damage[self] then v.is_damage[self] = 0 end
            if v.is_damage[self] <= 0 then
                v:applyEffect(self)
                self:applyDamage(v:getDamage())
                v.is_damage[self] = 30
            end
        end
    end
end

function Enemy:updateAutoDestroy()
    -- none
    if self.x > love.window.getWidth() + 16 + self.width / 2 then
        self:destroy()
    end
    if self.y > love.window.getHeight() + self.height / 2 then
        self:destroy()
    end
    if self.x < - self.width - 16 - self.width / 2 then
        self:destroy()
    end
    if self.y < - self.height - 16 - self.width / 2 then
        self:destroy()
    end
end

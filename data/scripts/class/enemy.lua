Enemy = class(Character)
Enemy.characterUpdateCollide = Enemy.super.updateCollide
Enemy.characterInit = Enemy.super.init

function Enemy:init()
    self:characterInit(0, 0)
    self:initSpawn()
end

function Enemy:initSpawn()
    -- none
end

function Enemy:bulletType()
    return "enemyBullet"
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
            self:applyDamage(self.hp, true)
        end
    end
end

function Enemy:updateCollideBullet()
    local playerBullter = ModelManager:getModel('playerBullet')
    for k,v in pairs(playerBullter) do
        if self:collided(v) then
            v:destroy()
            self:applyDamage(v:getDamage())
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
Player = class(Character)
Player.characterShootCondition = Player.super.shootCondition
Player.characterUpdateCollide  = Player.super.updateCollide
Player.characterInitParams     = Player.super.initParams

function Player:initParams()
    Player:characterInitParams()
    -- inventory
    self.inventory = {}
    -- dirty slow
    self.slowRate     = 0
    self.slowDuration = 0
end

function Player:bulletType()
    return "playerBullet"
end

function Player:updateMove()
    -- move by input
    -- dirty slow
    self.x = self.x + self:moveRateX() * Input.axisX * (1 - self.slowRate)
    self.y = self.y + self:moveRateY() * Input.axisY * (1 - self.slowRate)
    -- correct position, out of bound
    self.x = math.max(self.width / 2, self.x)
    self.x = math.min(love.window.getWidth() - self.width / 2, self.x)
    self.y = math.max(self.height / 2, self.y)
    self.y = math.min(love.window.getHeight() - self.height / 2, self.y)
    -- dirty slow
    self.slowDuration = math.max(0, self.slowDuration - 1)
    if self.slowDuration <= 0 then
        self.slowRate = 0
    end
end

function Player:shootCondition()
    local cond = self:characterShootCondition()
    cond = cond and Input.fire
    return cond
end

function Player:updateCollide()
    self:characterUpdateCollide()
    --
    self:updateCollideBullet()
end

function Player:updateCollideBullet()
    local enemyBullet = ModelManager:getModel('enemyBullet')
    for k,v in pairs(enemyBullet) do
        if self:collided(v) then
            v:applyEffect(self)
            self:applyDamage(v:getDamage())
        end
    end
end

function Player:deathEffect()
    local layer  = self:spriteLayer()
    local name   = "deadeffect"..self:spriteName()
    local class  = SpritePlayerDead
    local sprite = LayerManager:addSprite(layer, name, class)

    sprite.x  = self.x
    sprite.y  = self.y
    
    sprite.ox = sprite:width() / 2
    sprite.oy = sprite:width() / 2

    sprite:autoDestroy(1)
end
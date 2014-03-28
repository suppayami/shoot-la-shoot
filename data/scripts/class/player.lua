Player = class(Character)
Player.characterShootCondition = Player.super.shootCondition
Player.characterUpdateCollide  = Player.super.updateCollide

function Player:bulletType()
    return "playerBullet"
end

function Player:updateMove()
    -- move by input
    self.x = self.x + self:moveRateX() * Input.axisX
    self.y = self.y + self:moveRateY() * Input.axisY
    -- correct position, out of bound
    self.x = math.max(self.width / 2, self.x)
    self.x = math.min(love.window.getWidth() - self.width / 2, self.x)
    self.y = math.max(self.height / 2, self.y)
    self.y = math.min(love.window.getHeight() - self.height / 2, self.y)
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
            v:destroy()
            self:applyDamage(v:getDamage())
        end
    end
end
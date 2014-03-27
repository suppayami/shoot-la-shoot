Player = class(Character)
Player.characterShootCondition = Player.super.shootCondition

function Player:bulletType()
    return "playerBullet"
end

function Player:updateMove()
    -- move by input
    self.x = self.x + self:moveRateX() * Input.axisX
    self.y = self.y + self:moveRateY() * Input.axisY
    -- correct position, out of bound
    self.x = math.max(0, self.x)
    self.x = math.min(love.window.getWidth() - self.width, self.x)
    self.y = math.max(0, self.y)
    self.y = math.min(love.window.getHeight() - self.height, self.y)
end

function Player:shootCondition()
    local cond = self:characterShootCondition()
    cond = cond and Input.fire
    return cond
end

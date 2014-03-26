Player = class(Model)
Player.modelInit   = Player.super.init
Player.modelUpdate = Player.super.update

function Player:init(x, y)
    self:modelInit()
    -- init position
    self.x = x
    self.y = y
end

function Player:moveRateX()
    return 6
end

function Player:moveRateY()
    return 6
end

function Player:update()
    self:modelUpdate()
    -- update movement
    self:updateMove()
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
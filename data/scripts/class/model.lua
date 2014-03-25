Model = class(Object)

function Model:init()
    self.x = 0
    self.y = 0
    self.width  = 0
    self.height = 0
    self.sprite = nil
end

function Model:moveRateX()
    return 0
end

function Model:moveRateY()
    return 0
end

function Model:setSprite(sprite)
    self.sprite = sprite
    self:initSize()
    self:updateSprite()
end

function Model:initSize()
    self.width  = self.sprite:width()
    self.height = self.sprite:height()
end

function Model:update()
    self:updateSprite()
end

function Model:updateSprite()
    if not self.sprite then return end
    self:updateSpritePosition()
end

function Model:updateSpritePosition()
    local sprite = self.sprite
    sprite.x = self.x + (self.width - sprite:width()) / 2
    sprite.y = self.y + (self.height - sprite:height()) / 2
end

function Model:collided(model)
    local x1, x2 = self.x + self.width / 2, model.x + model.width / 2
    local y1, y2 = self.y + self.height / 2, model.y + model.height / 2
    local w      = self.width / 2 + model.width / 2
    local h      = self.height / 2 + model.height / 2
    local ox     = math.abs(x1 - x2)
    local oy     = math.abs(y1 - y2)
    local colX   = false
    local colY   = false

    -- check x-axis & y-axis
    if ox < w then colX = true end
    if oy < h then colY = true end

    return (colX and colY)
end
Model = class(Object)

function Model:init(x, y)
    self.x = x
    self.y = y
    self.width     = 0
    self.height    = 0
    self.sprite    = nil
    self.destroyed = false
    --
    self.shoot     = 0 -- shoot delay
    self:initSprite()  -- init sprite for model
end

function Model:initSprite()
    local layer  = self:spriteLayer()
    local name   = self:spriteName()
    local class  = self:spriteClass()
    local sprite = LayerManager:addSprite(layer, name, class)

    self:setSprite(sprite)
end

function Model:spriteClass()
    return Sprite
end

function Model:spriteLayer()
    return "layer_name"
end

function Model:spriteName()
    return "sprite_name"
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
    self:updateCollide()
    self:updateMove()
    self:updateAutoDestroy()
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

function Model:updateCollide()
    -- none
end

function Model:updateMove()
    self.x = self.x + self:moveRateX()
    self.y = self.y + self:moveRateY()
end

function Model:updateAutoDestroy()
    -- none
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

function Model:destroy()
    if self.destroyed then return end
    self.destroyed = true
    self.sprite:dispose()
    self.sprite    = nil
end
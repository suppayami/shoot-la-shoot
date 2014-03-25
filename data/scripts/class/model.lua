Model = class(Object)

function Model:init()
    self.x = 0
    self.y = 0
    self.width  = 0
    self.height = 0
    self.sprite = nil
end

function Model:setSprite(sprite)
    self.sprite = sprite
    self:updateSprite()
end

function Model:update()
    self:updateSprite()
end

function Model:updateSprite()
    if not self.sprite then return end
    self:updateSpritePosition()
end

function Model:updateSpritePosition()

end
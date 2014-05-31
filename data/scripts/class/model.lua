Model = class(Object)

function Model:init(x, y)
    self.x = x
    self.y = y
    self.width     = 0
    self.height    = 0
    self.sprite    = nil
    self.destroyed = false
    --
    self.collisionMask = nil
    --
    self:initSprite()  -- init sprite for model
end

function Model:initSprite()
    local layer  = self:spriteLayer()
    local name   = self:spriteName()
    local class  = self:spriteClass()
    local sprite = LayerManager:addSprite(layer, name, class)

    self:setupSprite(sprite)
    self:setSprite(sprite)
end

function Model:setupSprite(sprite)
    sprite.ox = sprite:width() / 2
    sprite.oy = sprite:height() / 2
end

function Model:setCollisionMask(filename)
    local layer  = self:spriteLayer()
    local name   = self:spriteName().."mask"
    local class  = Sprite
    local sprite = LayerManager:addSprite(layer, name, class)

    sprite:setImage(Cache:loadImage("graphics/"..filename))
    sprite.alpha = 0

    self.collisionMask = sprite
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
    if self.sprite then
        self.sprite:dispose()
    end
    self.sprite = sprite
    self:initSize()
    self:updateSprite()
end

function Model:initSize()
    self.width  = self.sprite:width()
    self.height = self.sprite:height()
end

function Model:update()
    if self.destroyed then return end
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
    local mask   = self.collisionMask

    sprite.x = self.x
    sprite.y = self.y

    if mask then
        mask.x = self.x - self.width / 2
        mask.y = self.y - self.height / 2
        mask.z = sprite.z + 1
    end
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
    local x1, x2  = self.x, model.x
    local y1, y2  = self.y, model.y
    local w       = self.width / 2 + model.width / 2
    local h       = self.height / 2 + model.height / 2
    local ox      = math.abs(x1 - x2)
    local oy      = math.abs(y1 - y2)
    local colX    = false
    local colY    = false
    local mask    = self.collisionMask
    local colMask = false

    -- check x-axis & y-axis
    if ox < w then colX = true end
    if oy < h then colY = true end

    if mask and not (model.is_item or self.is_item) then
        local bitmap = mask.image:getData()
        local mx1, mx2 = model.x - model.width / 2, model.x + model.width / 2
        local my1, my2 = model.y - model.height / 2, model.y + model.height / 2

        local px1, px2 = math.floor(mx1 - mask.x), math.floor(mx2 - mask.x)
        local py1, py2 = math.floor(my1 - mask.y), math.floor(my2 - mask.y)

        if px1 >= 0 and px1 < bitmap:getWidth() and py1 >= 0 and py1 < bitmap:getHeight() then
            local r, g, b, a = bitmap:getPixel(px1, py1)
            if a > 0 then colMask = true end
        end

        if px1 >= 0 and px1 < bitmap:getWidth() and py2 >= 0 and py2 < bitmap:getHeight() then
            local r, g, b, a = bitmap:getPixel(px1, py2)
            if a > 0 then colMask = true end
        end

        if px2 >= 0 and px2 < bitmap:getWidth() and py1 >= 0 and py1 < bitmap:getHeight() then
            local r, g, b, a = bitmap:getPixel(px2, py1)
            if a > 0 then colMask = true end
        end

        if px2 >= 0 and px2 < bitmap:getWidth() and py2 >= 0 and py2 < bitmap:getHeight() then
            local r, g, b, a = bitmap:getPixel(px2, py2)
            if a > 0 then colMask = true end
        end
    else
        colMask = true
    end

    return (colX and colY and colMask)
end

function Model:destroy(effect)
    if self.destroyed then return end
    if effect then self:deathEffect() end
    self.destroyed = true
    self.sprite:dispose()
    self.sprite    = nil
end

function Model:deathEffect()
    -- none
end

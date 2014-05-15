ItemBomb = class(Item)

function ItemBomb:throwTo(x, y)
    self.throw = true
    self.toX   = x
    self.toY   = y
    self.moveX = x - self.x
    self.moveY = y - self.y
    if self.moveY ~= 0 then
        self.flyAngle = math.atan(self.moveX / self.moveY)
    else
        self.flyAngle = math.pi / 2
    end
end

function ItemBomb:moveRateX()
    if self.x == self.toX and self.y == self.toY then
        self.throw = false
    end
    if self.throw then
        if self.moveY > 0 then
            if math.sin(self.flyAngle) > 0 then
                return math.min(self.toX - self.x, 10 * math.sin(self.flyAngle))
            else
                return math.max(self.toX - self.x, 10 * math.sin(self.flyAngle))
            end
        else
            if math.sin(self.flyAngle) > 0 then
                return math.max(self.toX - self.x, -10 * math.sin(self.flyAngle))
            else
                return math.min(self.toX - self.x, -10 * math.sin(self.flyAngle))
            end
        end
    else
        return 0
    end
end

function ItemBomb:moveRateY()
    if self.x == self.toX and self.y == self.toY then
        self.throw = false
    end
    if self.throw then
        if self.moveY > 0 then
            if math.cos(self.flyAngle) > 0 then
                return math.min(self.toY - self.y, 10 * math.cos(self.flyAngle))
            else
                return math.max(self.toY - self.y, 10 * math.cos(self.flyAngle))
            end
        else
            if math.cos(self.flyAngle) > 0 then
                return math.max(self.toY - self.y, -10 * math.cos(self.flyAngle))
            else
                return math.min(self.toY - self.y, -10 * math.cos(self.flyAngle))
            end
        end
    else
        return 4
    end
end

function ItemBomb:spriteClass()
    return SpriteItemBomb
end

function ItemBomb:spriteLayer()
    return "scene"
end

function ItemBomb:spriteName()
    return "item_bomb"
end

function ItemBomb:collideEffect(player)
    player:addItem(self)
end

function ItemBomb:applyEffect(player)
    local layer  = self:spriteLayer()
    local name   = "bombeffect"
    local class  = SpriteBomb
    local sprite = LayerManager:addSprite(layer, name, class, true)

    sprite.x = 0
    sprite.y = 440

    sprite:frameCallback(3, function()
        local layer  = self:spriteLayer()
        local name   = "boosteffect"
        local class  = SpriteBomb
        local sprite = LayerManager:addSprite(layer, name, class, true)

        sprite.x = 0
        sprite.y = 320

        sprite:frameCallback(3, function()
            local layer  = self:spriteLayer()
            local name   = "boosteffect"
            local class  = SpriteBomb
            local sprite = LayerManager:addSprite(layer, name, class, true)

            sprite.x = 0
            sprite.y = 200

            sprite:frameCallback(3, function()
                local layer  = self:spriteLayer()
                local name   = "boosteffect"
                local class  = SpriteBomb
                local sprite = LayerManager:addSprite(layer, name, class, true)

                sprite.x = 0
                sprite.y = 80

                sprite:frameCallback(3, function()
                    local layer  = self:spriteLayer()
                    local name   = "boosteffect"
                    local class  = SpriteBomb
                    local sprite = LayerManager:addSprite(layer, name, class, true)

                    sprite.x = 0
                    sprite.y = -40

                    sprite:autoDestroy(1)
                end)

                sprite:autoDestroy(1)
            end)

            sprite:autoDestroy(1)
        end)

        sprite:autoDestroy(1)
    end)

    local enemies = ModelManager:getModel("enemyCharacter")
    for k,v in pairs(enemies) do
        v:applyDamage(1, false)
    end

    sprite:autoDestroy(1)

    self:destroy()
end
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
    self.delayCollide = 16
end

function ItemBomb:moveRateX()
    if self.x == self.toX and self.y == self.toY then
        self.throw = false
        self.delayCollide = 0
    end
    self.delayCollide = self.delayCollide - 1
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
    if self.delayCollide <= 0 then
        player:addItem(self)
    end
end

function ItemBomb:applyEffect(player)
    local layer  = self:spriteLayer()
    local name   = "bombeffect"
    local class  = SpriteBomb
    local cutin  = nil

    if love.char == 0 then
        cutin = LayerManager:addSprite(layer, "cutin", CutinBombRyuko)
    elseif love.char == 1 then
        cutin = LayerManager:addSprite(layer, "cutin", CutinBombSatsuki)
    end

    cutin.callback = function()
        local sprite = LayerManager:addSprite(layer, name, class, true)

        local useSE = SoundManager:addSound("Using Bomb.wav")
        useSE:play()

        sprite.x = 0
        sprite.y = 440

        local explosionSE = SoundManager:addSound("Bomb Explosion.mp3")
        explosionSE:play()

        sprite:frameCallback(3, function()
            local layer  = self:spriteLayer()
            local name   = "boosteffect"
            local class  = SpriteBomb
            local sprite = LayerManager:addSprite(layer, name, class, true)

            local explosionSE = SoundManager:addSound("Bomb Explosion.mp3")
            explosionSE:play()

            sprite.x = 0
            sprite.y = 320

            sprite:frameCallback(3, function()
                local layer  = self:spriteLayer()
                local name   = "boosteffect"
                local class  = SpriteBomb
                local sprite = LayerManager:addSprite(layer, name, class, true)

                local explosionSE = SoundManager:addSound("Bomb Explosion.mp3")
                explosionSE:play()

                sprite.x = 0
                sprite.y = 200

                sprite:frameCallback(3, function()
                    local layer  = self:spriteLayer()
                    local name   = "boosteffect"
                    local class  = SpriteBomb
                    local sprite = LayerManager:addSprite(layer, name, class, true)

                    local explosionSE = SoundManager:addSound("Bomb Explosion.mp3")
                    explosionSE:play()

                    sprite.x = 0
                    sprite.y = 80

                    sprite:frameCallback(3, function()
                        local layer  = self:spriteLayer()
                        local name   = "boosteffect"
                        local class  = SpriteBomb
                        local sprite = LayerManager:addSprite(layer, name, class, true)

                        local explosionSE = SoundManager:addSound("Bomb Explosion.mp3")
                        explosionSE:play()

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
            v:applyDamage(300, false)
        end

        sprite:autoDestroy(1)

        self:destroy()
    end

end

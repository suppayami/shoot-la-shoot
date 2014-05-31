ItemBoostB = class(Item)

function ItemBoostB:moveRateY()
    return 4
end

function ItemBoostB:spriteClass()
    return SpriteItemBoostB
end

function ItemBoostB:spriteLayer()
    return "scene"
end

function ItemBoostB:spriteName()
    return "item_boost_b"
end

function ItemBoostB:collideEffect(player)
    player:addItem(self)
end

function ItemBoostB:applyEffect(player)
    local layer  = self:spriteLayer()
    local name   = "boosteffect"
    local class  = SpriteBoost
    local cutin  = nil

    local callback = function()
        local sprite = LayerManager:addSprite(layer, name, class, false, player)

        local SE = SoundManager:addSound("Equip Boost.wav")
        SE:play()

        sprite.x  = player.x
        sprite.y  = player.y

        sprite.ox = sprite:width() / 2
        sprite.oy = sprite:width() / 2

        sprite:autoDestroy(1)

        self:destroy()
        player.powerB = true
    end

    if player.powerA then
        if love.char == 0 then
            cutin = LayerManager:addSprite(layer, "cutin", CutinRyuko)
        elseif love.char == 1 then
            cutin = LayerManager:addSprite(layer, "cutin", CutinSatsuki)
        end

        cutin.callback = callback
    else
        callback()
    end
end

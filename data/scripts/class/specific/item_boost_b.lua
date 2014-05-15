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
    local sprite = LayerManager:addSprite(layer, name, class, false, player)

    sprite.x  = player.x
    sprite.y  = player.y
    
    sprite.ox = sprite:width() / 2
    sprite.oy = sprite:width() / 2

    sprite:autoDestroy(1)

    self:destroy()
    player.powerB = true
end
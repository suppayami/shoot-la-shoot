ItemBoostA = class(Item)

function ItemBoostA:moveRateY()
    return 4
end

function ItemBoostA:spriteClass()
    return SpriteItemBoostA
end

function ItemBoostA:spriteLayer()
    return "scene"
end

function ItemBoostA:spriteName()
    return "item_boost_a"
end

function ItemBoostA:collideEffect(player)
    player:addItem(self)
end

function ItemBoostA:applyEffect(player)
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
    player.powerA = true
end
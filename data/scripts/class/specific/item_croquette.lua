ItemCroquette = class(Item)

function ItemCroquette:moveRateY()
    return 4
end

function ItemCroquette:spriteClass()
    return SpriteItemCroquette
end

function ItemCroquette:spriteLayer()
    return "scene"
end

function ItemCroquette:spriteName()
    return "item_croquette"
end

function ItemCroquette:collideEffect(player)
    local layer  = self:spriteLayer()
    local name   = "potioneffect"
    local class  = SpritePotionEffect
    local npc    = ModelManager:getModel("playerCharacter", "npc")
    local player = ModelManager:getModel("playerCharacter", "player")
    local sprite = LayerManager:addSprite(layer, name, class, false, npc)

    local SE = SoundManager:addSound("Potion.wav")
    SE:play()

    sprite.x  = npc.x
    sprite.y  = npc.y

    sprite.ox = sprite:width() / 2
    sprite.oy = sprite:width() / 2

    sprite:autoDestroy(1)

    npc:healDamage(npc.mhp / 4)
    npc.slowRate = 0
    npc.slowDuration = 0
    player.slowRate = 0
    player.slowDuration = 0

    self:destroy()
end

function ItemCroquette:applyEffect(player)

end

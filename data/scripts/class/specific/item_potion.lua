ItemPotion = class(Item)

function ItemPotion:moveRateY()
    return 4
end

function ItemPotion:spriteClass()
    return SpriteItemPotion
end

function ItemPotion:spriteLayer()
    return "scene"
end

function ItemPotion:spriteName()
    return "item_potion"
end

function ItemPotion:collideEffect(player)
    player:addItem(self)
end

function ItemPotion:applyEffect(player)
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

    npc:healDamage(npc.mhp / 2)
    npc.slowRate = 0
    npc.slowDuration = 0
    player.slowRate = 0
    player.slowDuration = 0

    self:destroy()
end

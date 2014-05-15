SpriteNPCHP = class(Sprite)
SpriteNPCHP.spriteInit = SpriteNPCHP.super.init

function SpriteNPCHP:init()
    self:spriteInit()
    self:initLife(life)
end

function SpriteNPCHP:initLife()
    self.player = ModelManager:getModel("playerCharacter", "npc")
    self:update()
end

function SpriteNPCHP:imageCache()
    self.z = 101
    return Cache:loadImage("graphics/NakedSun_HPbar.png")
end

function SpriteNPCHP:updateRate()
    self.rate = self.player:hpRate()
end

function SpriteNPCHP:updateQuad()
    self:setQuad(0, 0, self:imageWidth() * self.rate, self:imageHeight())
end

function SpriteNPCHP:updatePosition()
    self.x = 153
    self.y = 611
end

function SpriteNPCHP:update(dt)
    self:updateRate()
    self:updateQuad()
    self:updatePosition()
end
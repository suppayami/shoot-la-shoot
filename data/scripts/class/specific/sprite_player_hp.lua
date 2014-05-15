SpritePlayerHP = class(Sprite)
SpritePlayerHP.spriteInit = SpritePlayerHP.super.init

function SpritePlayerHP:init(life)
    self:spriteInit()
    self:initLife(life)
end

function SpritePlayerHP:initLife(life)
    self.life   = life
    self.player = ModelManager:getModel("playerCharacter", "player")
    self:update()
end

function SpritePlayerHP:imageCache()
    self.z = 101
    return Cache:loadImage("graphics/Player_HPbar.png")
end

function SpritePlayerHP:updateRate()
    if self.life > self.player.life then
        self.rate = 0.0
    elseif self.life == self.player.life then
        self.rate = self.player:hpRate()
    else
        self.rate = 1.0
    end
end

function SpritePlayerHP:updateQuad()
    self:setQuad(self:imageWidth() / 3 * (3 - self.life), 0, 
                 self:imageWidth() / 3, self:imageHeight() * self.rate)
end

function SpritePlayerHP:updatePosition()
    self.x = 4
    self.y = 380 + 56 * (3 - self.life) + self:imageHeight() * (1 - self.rate)
end

function SpritePlayerHP:update(dt)
    self:updateRate()
    self:updateQuad()
    self:updatePosition()
end
SpritePlayerHP = class(Sprite)

function SpritePlayerHP:imageCache()
    self.z = 101
    return Cache:loadImage("graphics/Player_HPbar.png")
end

function SpritePlayerHP:update(dt)
    self.player = ModelManager:getModel("playerCharacter", "player")
    if not self.player then
        self:setQuad(0, 0, self:width(), 0)
        return false
    end
    self.rate = self.player:hpRate()
    self:setQuad(0, 0, self:width(), self:imageHeight() * self.rate)
    self.x = 5
    self.y = 385 + self:imageHeight() * (1 - self.rate)
end
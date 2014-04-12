Item = class(Model)
Item.modelUpdateCollide = Item.super.updateCollide

function Item:updateCollide()
    self:modelUpdateCollide()
    --
    self:updateCollidePlayer()
end

function Item:updateCollidePlayer()
    local playerCharacter = ModelManager:getModel('playerCharacter')
    for k,v in pairs(playerCharacter) do
        if self:collided(v) then
            self:applyEffect(v)
        end
    end
end

function Item:updateAutoDestroy()
    if self.x > love.window.getWidth() + 16 then
        self:destroy()
    end
    if self.y > love.window.getHeight() + 16 then
        self:destroy()
    end
    if self.x < - self.width - 16 then
        self:destroy()
    end
    if self.y < - self.height - 16 then
        self:destroy()
    end
end

function Item:applyEffect(player)
    -- none
end
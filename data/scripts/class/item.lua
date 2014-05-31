Item = class(Model)
Item.modelUpdateCollide = Item.super.updateCollide
Item.modelUpdate = Item.super.update

function Item:initSize()
    self.is_item = true
    self.width  = self.sprite:width() + 32
    self.height = self.sprite:height() + 32
end

function Item:update()
    if self.destroyed then return end
    if self.in_inventory then
        self:updateSprite()
        return
    end
    self:modelUpdate()
end

function Item:updateCollide()
    self:modelUpdateCollide()
    --
    self:updateCollidePlayer()
end

function Item:updateCollidePlayer()
    local playerCharacter = ModelManager:getModel('playerCharacter')
    local player = ModelManager:getModel("playerCharacter", "player")
    for k,v in pairs(playerCharacter) do
        if self:collided(v) then
            self:collideEffect(player)
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

function Item:collideEffect(player)
    -- none
end

function Item:applyEffect(player)
    -- none
end

function Item:setInventory(slot)
    if self.inventory then return end
    local i = 0
    if slot == "item1" then i = 0 end
    if slot == "item2" then i = 1 end
    if slot == "item3" then i = 2 end
    self.in_inventory = true
    self.x = 43
    self.y = 527 - i * 35
    self.sprite.z = 105
    LayerManager:sortSprite("scene")
    self:update()
end

function Item:updateMove()
    if self.in_inventory then return end
    self.x = self.x + self:moveRateX()
    self.y = self.y + self:moveRateY()
end

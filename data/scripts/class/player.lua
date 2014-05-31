Player = class(Character)
Player.characterUpdate         = Player.super.update
Player.characterShootCondition = Player.super.shootCondition
Player.characterUpdateCollide  = Player.super.updateCollide
Player.characterInitParams     = Player.super.initParams

function Player:initParams()
    Player:characterInitParams()
    -- inventory
    self.inventory = {item1=false, item2=false, item3=false}
    -- dirty slow
    self.slowRate     = 0
    self.slowDuration = 0
    -- life
    self.life = 3
    --
    self.nearDeathSE = love.audio.newSource("sounds/Near Death.wav", "stream")
end

function Player:bulletType()
    return "playerBullet"
end

function Player:update()
    self:characterUpdate()
    if self.destroyed then
        self.nearDeathSE:stop()
        return
    end
    self:updateItem()
    self:updateSE()
end

function Player:updateSE()
    if self.destroyed then
        self.nearDeathSE:stop()
        return
    end
    if self.life > 1 then
        self.nearDeathSE:stop()
    end
    if self.life == 1 then
        if self.hp / self.mhp > 0.25 then
            self.nearDeathSE:stop()
        else
            self.nearDeathSE:setLooping(true)
            self.nearDeathSE:play()
        end
    end
end

function Player:updateMove()
    -- move by input
    -- dirty slow
    self.x = self.x + self:moveRateX() * Input.axisX * (1 - self.slowRate)
    self.y = self.y + self:moveRateY() * Input.axisY * (1 - self.slowRate)
    -- correct position, out of bound
    self.x = math.max(self.width / 2, self.x)
    self.x = math.min(love.window.getWidth() - self.width / 2, self.x)
    self.y = math.max(self.height / 2, self.y)
    self.y = math.min(love.window.getHeight() - self.height / 2 - 16, self.y)
    -- dirty slow
    self.slowDuration = math.max(0, self.slowDuration - 1)
    if self.slowDuration <= 0 then
        self.slowRate = 0
    end
end

function Player:updateItem()
    local item = nil
    --
    if Input.item1 then
        item = self.inventory.item1
        self.inventory.item1 = false
    elseif Input.item2 then
        item = self.inventory.item2
        self.inventory.item2 = false
    elseif Input.item3 then
        item = self.inventory.item3
        self.inventory.item3 = false
    end
    --
    if item then
        item:applyEffect(self)
    end
end

function Player:addItem(item)
    if not self.inventory.item1 then
        self.inventory.item1 = item
        item:setInventory("item1")
    elseif not self.inventory.item2 then
        self.inventory.item2 = item
        item:setInventory("item2")
    elseif not self.inventory.item3 then
        self.inventory.item3 = item
        item:setInventory("item3")
    else
        local item1 = self.inventory.item1
        self.inventory.item1 = self.inventory.item2
        self.inventory.item1:setInventory("item1")
        self.inventory.item2 = self.inventory.item3
        self.inventory.item2:setInventory("item2")
        self.inventory.item3 = item
        self.inventory.item3:setInventory("item3")
        item1:destroy()
    end
    --
    local SE = SoundManager:addSound("Pick-up.wav")
    SE:play()
end

function Player:shootCondition()
    local cond = self:characterShootCondition()
    cond = cond and Input.fire
    return cond
end

function Player:updateCollide()
    self:characterUpdateCollide()
    --
    self:updateCollideBullet()
end

function Player:updateCollideBullet()
    local enemyBullet = ModelManager:getModel('enemyBullet')
    for k,v in pairs(enemyBullet) do
        if self:collided(v) and v:collided(self) then
            if not v.is_damage[self] then v.is_damage[self] = 0 end
            if v.is_damage[self] <= 0 then
                v:applyEffect(self)
                self:applyDamage(v:getDamage())
                v.is_damage[self] = 30
            end
        end
    end
end

function Player:damageEffect()
    local hud = LayerManager:getSprite("scene", "base")
    if not self.sprite then return end
    self.sprite:setToneChange(255, 92, 92, 196, 8)
    if hud.setHurt then hud:setHurt() end
end

function Player:deathEffect()
    local layer  = self:spriteLayer()
    local name   = "deadeffect"..self:spriteName()
    local class  = SpritePlayerDead
    local sprite = LayerManager:addSprite(layer, name, class)

    local SE = SoundManager:addSound("Player Death.wav")
    SE:play()

    self.nearDeathSE:stop()

    sprite.x  = self.x
    sprite.y  = self.y

    sprite.ox = sprite:width() / 2
    sprite.oy = sprite:width() / 2

    sprite:autoDestroy(1)
end

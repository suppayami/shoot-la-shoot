NakedSun = class(Character)
NakedSun.characterUpdate = NakedSun.super.update
NakedSun.characterInitParams = NakedSun.super.initParams
NakedSun.characterUpdateCollide  = NakedSun.super.updateCollide

function NakedSun:initParams()
    NakedSun:characterInitParams()
    self.hp  = 300
    self.mhp = 300
    ---
    self.player = ModelManager:getModel('playerCharacter', 'player')
    self.delay  = 0
    self.check  = false
    self.move   = false
    self.x     = self:newX()
    self.y     = self:newY()
    -- dirty slow
    self.slowRate     = 0
    self.slowDuration = 0
    --
    self:setCollisionMask("Naked Sun Collision Mask.png")
end

function NakedSun:spriteClass()
    return SpriteNakedSun
end

function NakedSun:spriteLayer()
    return "scene"
end

function NakedSun:spriteName()
    return "npc"
end

function NakedSun:update()
    if self.destroyed then return end
    if self.player.destroyed then return end
    self:characterUpdate()
    self:updateChase()
end

function NakedSun:updateChase()
    self.delay = math.max(self.delay - 1, 0)
    if self.x ~= self:newX() or
        self.y ~= self:newY() then
        if self.delay <= 0 and (not self.check and not self.move) then
            self.delay = 1
            self.check = true
        end
        if self.delay <= 0 and self.check then
            self.move  = true
            self.check = false
        end
    else
        self.move  = false
        self.check = false
    end
end

function NakedSun:updateMove()
    -- dirty slow
    self.x = self.x + self:moveRateX() * (1 - self.slowRate)
    self.y = self.y + self:moveRateY() * (1 - self.slowRate)
    -- dirty slow
    self.slowDuration = math.max(0, self.slowDuration - 1)
    if self.slowDuration <= 0 then
        self.slowRate = 0
    end
end

function NakedSun:moveRateX()
    if self.move then
        if self.x < self:newX() then
            return math.min(4, self:newX() - self.x)
        else
            return math.max(-4, self:newX() - self.x)
        end
    else
        return 0
    end
end

function NakedSun:moveRateY()
    if self.move then
        if self.y < self:newY() then
            return math.min(6, self:newY() - self.y)
        else
            return math.max(-6, self:newY() - self.y)
        end
    else
        return 0
    end
end

function NakedSun:newX()
    return self.player.x
end

function NakedSun:newY()
    return self.player.y + self.player.sprite:imageHeight() / 2
end

function NakedSun:updateCollide()
    self:characterUpdateCollide()
    --
    self:updateCollideBullet()
end

function NakedSun:updateCollideBullet()
    local enemyBullet = ModelManager:getModel('enemyBullet')
    for k,v in pairs(enemyBullet) do
        if self:collided(v) then
            if not v.is_damage[self] then v.is_damage[self] = 0 end
            if v.is_damage[self] <= 0 then
                v:applyEffect(self)
                self:applyDamage(v:getDamage())
                v.is_damage[self] = 30
            end
        end
    end
end

function NakedSun:deathEffect()
    local layer  = self:spriteLayer()
    local name   = "deadeffect"..self:spriteName()
    local class  = SpritePlayerDead
    local sprite = LayerManager:addSprite(layer, name, class)

    local SE = SoundManager:addSound("Naked Sun Death [freesfx.co.uk].mp3")
    SE:play()

    sprite.x  = self.x
    sprite.y  = self.y

    sprite.ox = sprite:width() / 2
    sprite.oy = sprite:width() / 2

    sprite:autoDestroy(1)
end

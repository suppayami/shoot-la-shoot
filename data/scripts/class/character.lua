Character = class(Model)
Character.modelInit   = Character.super.init
Character.modelUpdate = Character.super.update

function Character:init(x, y)
    self:modelInit(x, y)
    self:initParams()
    -- shooting
    self.shoot  = 0 -- shoot delay
    self.attack = false -- special shoot
end

function Character:initParams()
    self.mhp   = 1
    self.hp    = 1
    self.regen = 0
    self.life  = 1
end

function Character:hpRate()
    return self.hp / self.mhp
end

function Character:healDamage(damage)
    self.hp = math.min(self.hp + damage, self.mhp)
end

function Character:applyDamage(damage, pure)
    local realDamage = 0
    if pure then
        realDamage = damage
    else
        realDamage = self:calculateDamage(damage)
    end
    self.hp = self.hp - realDamage
    if realDamage > 0 then
        if not self.destroyed then
            self:damageEffect()
        end
    end
    self:checkAlive()
end

function Character:calculateDamage(damage)
    return damage
end

function Character:damageEffect()
    if not self.sprite then return end
    self.sprite:setToneChange(255, 92, 92, 196, 8)
end

function Character:checkAlive()
    if math.floor(self.hp) > 0 then return end
    self:lostLife()
    self.life = self.life - 1
    self.hp   = self.mhp + self.hp
    self:checkAlive()
    if self.life > 0 then return end
    self.hp   = 0
    self:destroy(true)
    self:afterDeath()
end

function Character:afterDeath()
    -- none
end

function Character:lostLife()
    -- none
end

function Character:shootDelay()
    return 0
end

function Character:shootCondition()
    local cond = (self.shoot == 0)
    return cond
end

function Character:attackCondition()
    local cond = self.attack
    return cond
end

function Character:bulletClass()
    return Bullet -- bullet class
end

function Character:bulletSpriteClass()
    return self:bulletClass():spriteClass() -- bullet class
end

function Character:bulletType()
    return "bullet"
end

function Character:bulletName()
    return "bullet"
end

function Character:actionShoot()
    -- for normal shoot
    -- none
end

function Character:actionAttack()
    -- for special shoot
    -- none
end

function Character:createBullet(x, y, target, homing)
    local typen = self:bulletType()
    local name  = self:bulletName()
    local class = self:bulletClass()

    local model = ModelManager:addModel(typen, name, class, x, y, self, target, homing)

    return model
end

function Character:update()
    if self.destroyed then return end
    self:modelUpdate()
    self:updateShoot()  -- for shooting delay
    self:updateAttack() -- for shooting skill
    self:updateRegen()
end

function Character:updateShoot()
    self.shoot = math.max(self.shoot - 1, 0)
    if not self:shootCondition() then return end -- condition
    self.shoot = self:shootDelay()
    self:actionShoot()
end

function Character:updateAttack()
    if not self:attackCondition() then return end -- condition
    self:actionAttack()
end

function Character:updateRegen()
    self.hp = math.min(self.hp + self.regen, self.mhp)
end

function Character:getDamage()
    return 1
end

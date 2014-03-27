Character = class(Model)
Character.modelInit   = Character.super.init
Character.modelUpdate = Character.super.update

function Character:init(x, y)
    self:modelInit(x, y)
    self:initParams()
end

function Character:initParams()
    self.hp = 1
end

function Character:applyDamage(damage, pure)
    local realDamage = 0
    if pure then 
        realDamage = damage 
    else 
        realDamage = self:calculateDamage(damage) 
    end
    self.hp = math.max(self.hp - realDamage, 0)
    self:checkAlive()
end

function Character:calculateDamage(damage)
    return damage
end

function Character:checkAlive()
    if self.hp > 0 then return end
    self:destroy()
end

function Character:shootDelay()
    return 0
end

function Character:shootCondition()
    local cond = (self.shoot == 0)
    return cond
end

function Character:bulletClass()
    return Bullet -- bullet class
end

function Character:bulletType()
    return "bullet"
end

function Character:bulletName()
    return "bullet"
end

function Character:actionShoot()
    -- none
end

function Character:createBullet(x, y)
    local typen = self:bulletType()
    local name  = self:bulletName()
    local class = self:bulletClass()

    local model = ModelManager:addModel(typen, name, class, x, y)

    return model
end

function Character:update()
    self:modelUpdate()
    self:updateShoot()
end

function Character:updateShoot()
    self.shoot = math.max(self.shoot - 1, 0)
    if not self:shootCondition() then return end -- condition
    self.shoot = self:shootDelay()
    self:actionShoot()
end
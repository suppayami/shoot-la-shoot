Bullet = class(Model)
Bullet.modelInit = Bullet.super.init
Bullet.modelUpdate = Bullet.super.update

function Bullet:init(x, y, user, target, homing)
    self:modelInit(x, y)
    self.user = user
    self.target = target
    self.homing = homing
    self.flyAngle = 0
    self.is_damage = {}
    ---
    if not self.homing then
        if self.target then
            self.moveX = target.x - self.x
            self.moveY = target.y - self.y
        end
    end
    ---
    if self.moveX and self.moveY then
        if self.moveY ~= 0 then
            self.flyAngle = math.atan(self.moveX / self.moveY)
        else
            self.flyAngle = math.pi / 2
        end
    end
    ---
    if target and target.shootAngle then
        self.flyAngle = target.shootAngle
    end
end

function Bullet:getDamage()
    if self.user.damage then 
        return self.user:getDamage()
    else
        return 1
    end
end

function Bullet:update()
    if self.destroyed then return end
    self:modelUpdate()
    self:updateIsDamage()
end

function Bullet:updateAutoDestroy()
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

function Bullet:updateIsDamage()
    for k,v in pairs(self.is_damage) do
        self.is_damage[k] = math.max(v - 1, 0)
    end
end

function Bullet:applyEffect(target)
    -- nothing
end
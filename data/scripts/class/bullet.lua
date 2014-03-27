Bullet = class(Model)
Bullet.modelInit   = Bullet.super.init
Bullet.modelUpdate = Bullet.super.update

function Bullet:init(x, y)
    self:modelInit()
    -- init position
    self.x = x
    self.y = y
end

function Bullet:getDamage()
    return 1
end
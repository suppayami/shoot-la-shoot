Enemy = class(Model)
Enemy.modelInit          = Enemy.super.init
Enemy.modelUpdateCollide = Enemy.super.updateCollide

function Enemy:init(x, y)
    self:modelInit()
    -- init position
    self.x = x
    self.y = y
end

function Enemy:initParams()
    self.hp = 1
end

function Enemy:updateCollide()
    self:modelUpdateCollide()
    --
    self:updateCollidePlayer()
    self:updateCollideBullet()
end

function Enemy:updateCollidePlayer()
    
end

function Enemy:updateCollideBullet()
    for k,v in pairs(ModelManager:getModel('playerBullet')) do
        if self:collided(v) then
            v:destroy()
        end
    end
end
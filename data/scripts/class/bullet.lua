Bullet = class(Model)

function Bullet:getDamage()
    return 1
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
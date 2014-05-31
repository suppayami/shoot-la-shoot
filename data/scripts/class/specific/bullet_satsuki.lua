BulletSatsuki = class(Bullet)

function BulletSatsuki:spriteClass()
    return SpriteBulletSatsuki
end

function BulletSatsuki:spriteLayer()
    return "scene"
end

function BulletSatsuki:spriteName()
    return "bullet_satsuki"
end

function BulletSatsuki:moveRateX()
    if self.target then
        if self.y <= self.target.y then
            return 0
        else
            if self.x < self.target.x then
                return math.min(self.target.x - self.x, 4)
            else
                return math.max(self.target.x - self.x, -4)
            end
        end
    else
        return 0
    end
end

function BulletSatsuki:moveRateY()
    return -8
end

function BulletSatsuki:applyEffect(target)
    self:destroy()
end

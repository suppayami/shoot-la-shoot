BulletEnemyRagyo = class(Bullet)

function BulletEnemyRagyo:spriteClass()
    return SpriteBulletRagyo
end

function BulletEnemyRagyo:spriteLayer()
    return "scene"
end

function BulletEnemyRagyo:spriteName()
    return "bullet_ragyo"
end

function BulletEnemyRagyo:moveRateX()
    if self.target and self.target.shootAngle then
        return 10 * math.sin(self.flyAngle)
    end
    if self.moveY > 0 then
        return 10 * math.sin(self.flyAngle)
    else
        return -10 * math.sin(self.flyAngle)
    end
end

function BulletEnemyRagyo:moveRateY()
    if self.target and self.target.shootAngle then
        return -10 * math.cos(self.flyAngle)
    end
    if self.moveY > 0 then
        return 10 * math.cos(self.flyAngle)
    else
        return -10 * math.cos(self.flyAngle)
    end
end

function BulletEnemyRagyo:applyEffect()
    self:destroy()
end
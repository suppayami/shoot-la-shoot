BulletEnemyA = class(Bullet)

function BulletEnemyA:spriteClass()
    return SpriteBulletEnemyA
end

function BulletEnemyA:spriteLayer()
    return "scene"
end

function BulletEnemyA:spriteName()
    return "bullet_enemy_a"
end

function BulletEnemyA:moveRateX()
    if not self.moveY then return 0 end
    if self.moveY > 0 then
        return 10 * math.sin(self.flyAngle)
    else
        return -10 * math.sin(self.flyAngle)
    end
end

function BulletEnemyA:moveRateY()
    if not self.moveY then return 10 end
    if self.moveY > 0 then
        return 10 * math.cos(self.flyAngle)
    else
        return -10 * math.cos(self.flyAngle)
    end
end

function BulletEnemyA:applyEffect()
    self:destroy()
end
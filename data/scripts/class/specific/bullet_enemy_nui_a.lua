BulletEnemyNuiA = class(Bullet)

function BulletEnemyNuiA:spriteClass()
    return SpriteBulletNuiA
end

function BulletEnemyNuiA:spriteLayer()
    return "scene"
end

function BulletEnemyNuiA:spriteName()
    return "bullet_enemy_a"
end

function BulletEnemyNuiA:moveRateX()
    return 10 * math.sin(self.flyAngle)
end

function BulletEnemyNuiA:moveRateY()
    return 10 * math.cos(self.flyAngle)
end

function BulletEnemyNuiA:applyEffect()
    self:destroy()
end
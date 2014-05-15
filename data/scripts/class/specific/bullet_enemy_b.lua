BulletEnemyB = class(Bullet)

function BulletEnemyB:spriteClass()
    return SpriteBulletEnemyB
end

function BulletEnemyB:spriteLayer()
    return "scene"
end

function BulletEnemyB:spriteName()
    return "bullet_enemy_b"
end

function BulletEnemyB:moveRateX()
    return 0
end

function BulletEnemyB:moveRateY()
    return 10
end

function BulletEnemyB:applyEffect()
    self:destroy()
end
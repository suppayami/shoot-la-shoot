BulletEnemyD = class(Bullet)

function BulletEnemyD:getDamage()
    return 1
end

function BulletEnemyD:spriteClass()
    return SpriteBulletEnemyD
end

function BulletEnemyD:spriteLayer()
    return "scene"
end

function BulletEnemyD:spriteName()
    return "bullet_enemy_d"
end

function BulletEnemyD:moveRateX()
    return 0
end

function BulletEnemyD:moveRateY()
    return 6
end

function BulletEnemyD:applyEffect(target)
    target.slowRate     = 0.5
    target.slowDuration = 10 * 60
    self:destroy()
end
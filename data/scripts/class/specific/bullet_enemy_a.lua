BulletEnemyA = class(Bullet)

function BulletEnemyA:getDamage()
    return 1
end

function BulletEnemyA:spriteClass()
    return SpriteBulletEnemyA
end

function BulletEnemyA:spriteLayer()
    return "bullet"
end

function BulletEnemyA:spriteName()
    return "bullet_enemy_a"
end

function BulletEnemyA:moveRateX()
    return 0
end

function BulletEnemyA:moveRateY()
    return 10
end
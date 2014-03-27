BulletRyukoN = class(Bullet)

function BulletRyukoN:getDamage()
    return 1
end

function BulletRyukoN:spriteClass()
    return SpriteBulletRyukoN
end

function BulletRyukoN:spriteLayer()
    return "bullet"
end

function BulletRyukoN:spriteName()
    return "bullet_ryuko_n"
end

function BulletRyukoN:moveRateX()
    return 0
end

function BulletRyukoN:moveRateY()
    return -10
end
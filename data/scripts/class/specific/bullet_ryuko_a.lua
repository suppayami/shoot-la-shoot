BulletRyukoA = class(Bullet)

function BulletRyukoA:getDamage()
    return 2
end

function BulletRyukoA:spriteClass()
    return SpriteBulletRyukoA
end

function BulletRyukoA:spriteLayer()
    return "bullet"
end

function BulletRyukoA:spriteName()
    return "bullet_ryuko_a"
end

function BulletRyukoA:moveRateX()
    return 0
end

function BulletRyukoA:moveRateY()
    return -10
end
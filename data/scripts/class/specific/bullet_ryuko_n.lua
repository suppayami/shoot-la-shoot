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
    local count = LayerManager:getSpriteCount(self:spriteLayer())
    return "bullet_ryuko_n_"..(count + 1)..os.clock()..randomNumber:random(1, 1000)
end

function BulletRyukoN:moveRateX()
    return 0
end

function BulletRyukoN:moveRateY()
    return -10
end
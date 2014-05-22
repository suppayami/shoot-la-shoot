BulletRyukoN = class(Bullet)

function BulletRyukoN:spriteClass()
    return SpriteBulletRyukoN
end

function BulletRyukoN:spriteLayer()
    return "scene"
end

function BulletRyukoN:spriteName()
    return "bullet_ryuko_n"
end

function BulletRyukoN:moveRateX()
    return 10 * math.sin(self.sprite.angle)
end

function BulletRyukoN:moveRateY()
    return -10 * math.cos(self.sprite.angle)
end

function BulletRyukoN:applyEffect(target)
    self.is_damage[target] = 30
end
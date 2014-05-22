BulletRagyoBeam = class(Bullet)

function BulletRagyoBeam:spriteClass()
    return SpriteRagyoBeam
end

function BulletRagyoBeam:spriteLayer()
    return "scene"
end

function BulletRagyoBeam:spriteName()
    return "bullet_ragyo_beam"
end

function BulletRagyoBeam:moveRateX()
    return 0
end

function BulletRagyoBeam:moveRateY()
    return 0
end

function BulletRagyoBeam:applyEffect(target)
    self.is_damage[target] = 30
end
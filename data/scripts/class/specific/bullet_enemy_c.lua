BulletEnemyC = class(Bullet)

function BulletEnemyC:spriteClass()
    return SpriteBulletEnemyC
end

function BulletEnemyC:spriteLayer()
    return "scene"
end

function BulletEnemyC:spriteName()
    return "bullet_enemy_c"
end

function BulletEnemyC:moveRateX()
    return 0
end

function BulletEnemyC:moveRateY()
    return 10
end

function BulletEnemyC:applyEffect()
    self:destroy()
end
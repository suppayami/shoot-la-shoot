BulletEnemyNuiB = class(Bullet)

function BulletEnemyNuiB:spriteClass()
    return SpriteBulletNuiB
end

function BulletEnemyNuiB:spriteLayer()
    return "scene"
end

function BulletEnemyNuiB:spriteName()
    return "bullet_nui_b"
end

function BulletEnemyNuiB:moveRateX()
    return 0
end

function BulletEnemyNuiB:moveRateY()
    return 10
end

function BulletEnemyNuiB:applyEffect()
    self:destroy()
end
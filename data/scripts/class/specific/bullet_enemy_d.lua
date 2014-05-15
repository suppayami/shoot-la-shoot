BulletEnemyD = class(Bullet)

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
    if not self.moveY then return 0 end
    if self.moveY > 0 then
        return 6 * math.sin(self.flyAngle)
    else
        return -6 * math.sin(self.flyAngle)
    end
end

function BulletEnemyD:moveRateY()
    if not self.moveY then return 6 end
    if self.moveY > 0 then
        return 6 * math.cos(self.flyAngle)
    else
        return -6 * math.cos(self.flyAngle)
    end
end

function BulletEnemyD:applyEffect(target)
    local layer  = self:spriteLayer()
    local name   = "sloweffect"
    local class  = SpriteSlow
    local sprite = LayerManager:addSprite(layer, name, class)

    sprite.x  = target.x
    sprite.y  = target.y
    
    sprite.ox = sprite:width() / 2
    sprite.oy = sprite:width() / 2

    sprite:autoDestroy(1)

    target.slowRate     = 0.5
    target.slowDuration = 10 * 60
    self:destroy()
end
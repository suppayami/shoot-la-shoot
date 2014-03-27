EnemyA = class(Enemy)

function EnemyA:spriteClass()
    return SpriteEnemyA
end

function EnemyA:spriteLayer()
    return "enemy"
end

function EnemyA:spriteName()
    local layer = LayerManager:getSprites(self:spriteLayer())
    return "enemyA_"..(#layer + 1)
end

function EnemyA:shootDelay()
    return 60
end

function EnemyA:moveRateX()
    return 0
end

function EnemyA:moveRateY()
    return 0
end

function EnemyA:actionShoot()
    
end
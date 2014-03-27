EnemyA = class(Enemy)

function EnemyA:initParams()
    self.hp = 3
end

function EnemyA:spriteClass()
    return SpriteEnemyA
end

function EnemyA:spriteLayer()
    return "enemy"
end

function EnemyA:spriteName()
    return "enemy_a"
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
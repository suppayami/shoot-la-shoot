SpriteEnemyDead = class(Animation)

function SpriteEnemyDead:imageCache()
    return Cache:loadImage("graphics/Enemy Death.png")
end

function SpriteEnemyDead:animateFrames()
    return 7
end

function SpriteEnemyDead:animateDelay()
    return 4
end

function SpriteEnemyDead:animateRows()
    return 1
end
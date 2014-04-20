SpriteEnemyB = class(Animation)

function SpriteEnemyB:imageCache()
    return Cache:loadImage("graphics/Fast COVER.png")
end

function SpriteEnemyB:animateFrames()
    return 4
end

function SpriteEnemyB:animateDelay()
    return 10
end

function SpriteEnemyB:animateRows()
    return 2
end
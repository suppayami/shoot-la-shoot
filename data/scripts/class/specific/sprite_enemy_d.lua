SpriteEnemyD = class(Animation)

function SpriteEnemyD:imageCache()
    return Cache:loadImage("graphics/Magic COVER.png")
end

function SpriteEnemyD:animateFrames()
    return 4
end

function SpriteEnemyD:animateDelay()
    return 10
end

function SpriteEnemyD:animateRows()
    return 1
end
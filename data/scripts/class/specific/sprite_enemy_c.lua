SpriteEnemyC = class(Animation)

function SpriteEnemyC:imageCache()
    return Cache:loadImage("graphics/Pawn COVER.png")
end

function SpriteEnemyC:animateFrames()
    return 4
end

function SpriteEnemyC:animateDelay()
    return 10
end

function SpriteEnemyC:animateRows()
    return 1
end
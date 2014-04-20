SpriteEnemyA = class(Animation)

function SpriteEnemyA:imageCache()
    return Cache:loadImage("graphics/Kaiju COVER.png")
end

function SpriteEnemyA:animateFrames()
    return 4
end

function SpriteEnemyA:animateDelay()
    return 10
end

function SpriteEnemyA:animateRows()
    return 2
end
SpritePlayerDead = class(Animation)

function SpritePlayerDead:imageCache()
    return Cache:loadImage("graphics/Player Death.png")
end

function SpritePlayerDead:animateFrames()
    return 8
end

function SpritePlayerDead:animateDelay()
    return 4
end

function SpritePlayerDead:animateRows()
    return 1
end
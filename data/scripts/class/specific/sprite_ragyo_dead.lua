SpriteRagyoDead = class(Animation)

function SpriteRagyoDead:imageCache()
    return Cache:loadImage("graphics/Ragyo Death.png")
end

function SpriteRagyoDead:animateFrames()
    return 10
end

function SpriteRagyoDead:animateDelay()
    return 4
end

function SpriteRagyoDead:animateRows()
    return 1
end
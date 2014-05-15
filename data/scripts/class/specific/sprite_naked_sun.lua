SpriteNakedSun = class(Animation)

function SpriteNakedSun:imageCache()
    return Cache:loadImage("graphics/Naked Sun.png")
end

function SpriteNakedSun:animateFrames()
    return 4
end

function SpriteNakedSun:animateDelay()
    return 8
end

function SpriteNakedSun:animateRows()
    return 1
end
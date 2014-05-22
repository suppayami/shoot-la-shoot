SpriteRagyoDevice = class(Animation)

function SpriteRagyoDevice:imageCache()
    return Cache:loadImage("graphics/Ragyo Device.png")
end

function SpriteRagyoDevice:animateFrames()
    return 3
end

function SpriteRagyoDevice:animateDelay()
    return 4
end

function SpriteRagyoDevice:animateRows()
    return 1
end
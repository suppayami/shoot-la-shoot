SpriteRagyoBeam = class(Animation)

function SpriteRagyoBeam:imageCache()
    return Cache:loadImage("graphics/Ragyo Device Beam.png")
end

function SpriteRagyoBeam:animateFrames()
    return 2
end

function SpriteRagyoBeam:animateDelay()
    return 4
end

function SpriteRagyoBeam:animateRows()
    return 1
end
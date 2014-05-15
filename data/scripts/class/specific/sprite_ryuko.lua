SpriteRyuko = class(Animation)

function SpriteRyuko:imageCache()
    self.z = 11
    return Cache:loadImage("graphics/Ryuko.png")
end

function SpriteRyuko:animateFrames()
    return 4
end

function SpriteRyuko:animateDelay()
    return 8
end

function SpriteRyuko:animateRows()
    return 1
end
SpriteBoost = class(Animation)

function SpriteBoost:imageCache()
    self.z = 12
    return Cache:loadImage("graphics/Using Boost.png")
end

function SpriteBoost:animateFrames()
    return 10
end

function SpriteBoost:animateDelay()
    return 4
end

function SpriteBoost:animateRows()
    return 1
end
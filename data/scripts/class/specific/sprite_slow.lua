SpriteSlow = class(Animation)

function SpriteSlow:imageCache()
    self.z = 12
    return Cache:loadImage("graphics/Getting Slow.png")
end

function SpriteSlow:animateFrames()
    return 10
end

function SpriteSlow:animateDelay()
    return 4
end

function SpriteSlow:animateRows()
    return 1
end
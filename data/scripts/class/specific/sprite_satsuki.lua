SpriteSatsuki = class(Animation)

function SpriteSatsuki:imageCache()
    self.z = 11
    return Cache:loadImage("graphics/Satsuki.png")
end

function SpriteSatsuki:animateFrames()
    return 4
end

function SpriteSatsuki:animateDelay()
    return 8
end

function SpriteSatsuki:animateRows()
    return 1
end

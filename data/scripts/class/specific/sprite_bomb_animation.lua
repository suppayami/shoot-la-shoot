SpriteBomb = class(Animation)

function SpriteBomb:imageCache()
    self.z = 15
    return Cache:loadImage("graphics/Bomb.png")
end

function SpriteBomb:animateFrames()
    return 9
end

function SpriteBomb:animateDelay()
    return 3
end

function SpriteBomb:animateRows()
    return 1
end
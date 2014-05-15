SpriteRagyoBomb = class(Animation)

function SpriteRagyoBomb:imageCache()
    self.z = 10
    return Cache:loadImage("graphics/Ragyo Bomb.png")
end

function SpriteRagyoBomb:animateFrames()
    return 4
end

function SpriteRagyoBomb:animateDelay()
    return 10
end

function SpriteRagyoBomb:animateRows()
    return 1
end
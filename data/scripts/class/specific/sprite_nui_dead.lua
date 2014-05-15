SpriteNuiDead = class(Animation)

function SpriteNuiDead:imageCache()
    return Cache:loadImage("graphics/Nui Death.png")
end

function SpriteNuiDead:animateFrames()
    return 8
end

function SpriteNuiDead:animateDelay()
    return 4
end

function SpriteNuiDead:animateRows()
    return 1
end
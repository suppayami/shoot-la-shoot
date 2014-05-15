SpriteEnemyNui = class(Animation)

function SpriteEnemyNui:imageCache()
    self.z = 11
    return Cache:loadImage("graphics/Nui.png")
end

function SpriteEnemyNui:animateFrames()
    return 4
end

function SpriteEnemyNui:animateDelay()
    return 8
end

function SpriteEnemyNui:animateRows()
    return 1
end
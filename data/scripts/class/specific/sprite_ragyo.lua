SpriteEnemyRagyo = class(Animation)

function SpriteEnemyRagyo:imageCache()
    self.z = 11
    return Cache:loadImage("graphics/Ragyo.png")
end

function SpriteEnemyRagyo:animateFrames()
    return 4
end

function SpriteEnemyRagyo:animateDelay()
    return 8
end

function SpriteEnemyRagyo:animateRows()
    return 1
end
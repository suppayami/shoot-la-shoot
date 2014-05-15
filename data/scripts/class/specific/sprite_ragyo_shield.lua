SpriteEnemyRagyoShield = class(Animation)

function SpriteEnemyRagyoShield:imageCache()
    self.z = 11
    return Cache:loadImage("graphics/Ragyo Shield.png")
end

function SpriteEnemyRagyoShield:animateFrames()
    return 4
end

function SpriteEnemyRagyoShield:animateDelay()
    return 8
end

function SpriteEnemyRagyoShield:animateRows()
    return 1
end
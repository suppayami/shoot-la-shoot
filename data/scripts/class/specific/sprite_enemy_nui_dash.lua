SpriteEnemyNuiDash = class(Animation)

function SpriteEnemyNuiDash:imageCache()
    self.z = 11
    return Cache:loadImage("graphics/Nui Dash.png")
end

function SpriteEnemyNuiDash:animateFrames()
    return 1
end

function SpriteEnemyNuiDash:animateDelay()
    return 8
end

function SpriteEnemyNuiDash:animateRows()
    return 1
end
SpriteBulletSatsuki = class(Animation)

function SpriteBulletSatsuki:imageCache()
    self.z = 11
    return Cache:loadImage("graphics/Satsuki Missile.png")
end

function SpriteBulletSatsuki:animateFrames()
    return 2
end

function SpriteBulletSatsuki:animateDelay()
    return 8
end

function SpriteBulletSatsuki:animateRows()
    return 1
end

SpritePotionEffect = class(Animation)

function SpritePotionEffect:imageCache()
    self.blendMode = "additive"
    self.z = 13
    return Cache:loadImage("graphics/Using Potion.png")
end

function SpritePotionEffect:animateFrames()
    return 10
end

function SpritePotionEffect:animateDelay()
    return 4
end

function SpritePotionEffect:animateRows()
    return 1
end
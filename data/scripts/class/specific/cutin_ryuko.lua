CutinRyuko = class(Cutin)

function CutinRyuko:imageCache()
    self.z = 1000
    return Cache:loadImage("graphics/cutin_ryuko.png")
end

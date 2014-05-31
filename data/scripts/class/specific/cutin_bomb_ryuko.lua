CutinBombRyuko = class(Cutin)

function CutinBombRyuko:imageCache()
    self.z = 1000
    return Cache:loadImage("graphics/cutin_mako.png")
end

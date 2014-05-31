CutinBombSatsuki = class(Cutin)

function CutinBombSatsuki:imageCache()
    self.z = 1000
    return Cache:loadImage("graphics/cutin_devas.png")
end

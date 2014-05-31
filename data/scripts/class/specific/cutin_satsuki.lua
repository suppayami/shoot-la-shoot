CutinSatsuki = class(Cutin)

function CutinSatsuki:imageCache()
    self.z = 1000
    return Cache:loadImage("graphics/cutin_satsuki.png")
end

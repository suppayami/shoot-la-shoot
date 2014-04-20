SpriteRyukoHUD = class(Sprite)

function SpriteRyukoHUD:imageCache()
    self.z = 100
    return Cache:loadImage("graphics/Ryuko HUD.png")
end
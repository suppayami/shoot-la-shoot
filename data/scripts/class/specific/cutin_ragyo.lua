CutinRagyo = class(Cutin)

function CutinRagyo:initCutin()
    self.x = -self:width()
    self.y = (640 - self:height()) / 2
    self.alpha = 0
    self.phase = 0
    self.delay = 40
    --
    self.callback = nil
    --
    self:backFade()
    --
    local SE = SoundManager:addSound("Alarm.wav")
    SE:play()
end

function CutinRagyo:imageCache()
    self.z = 1000
    return Cache:loadImage("graphics/cutin_ragyo.png")
end

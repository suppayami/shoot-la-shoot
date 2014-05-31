SpriteRyukoHUD = class(Sprite)

function SpriteRyukoHUD:imageCache()
    local normal = Cache:loadImage("graphics/Ryuko HUD.png")
    local hurt   = Cache:loadImage("graphics/Ryuko HUD - Hurt.png")
    self.z = 100
    if self.isHurt then
        return hurt
    else
        return normal
    end
end

function SpriteRyukoHUD:update()
    if self.isHurt then
        if not self.hurtDelay then self.hurtDelay = 30 end
        self.hurtDelay = self.hurtDelay - 1
        if self.hurtDelay <= 0 then
            self.isHurt = false
            self:initImage()
        end
    end
end

function SpriteRyukoHUD:setHurt()
    self.isHurt = true
    self:initImage()
    self.hurtDelay = 30
end

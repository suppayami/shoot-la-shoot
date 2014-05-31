Cutin = class(Sprite)
Cutin.spriteInit = Cutin.super.init

function Cutin:init()
    self:spriteInit()
    self:initCutin()
end

function Cutin:initCutin()
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
    local SE = SoundManager:addSound("Cutin.wav")
    SE:play()
end

function Cutin:update()
    self:updateCutin()
end

function Cutin:updateCutin()
    if self.phase == 0 then
        self.x = self.x + math.min(640 / 15, -self.x)
        self.alpha = self.alpha + math.min(255 / 15, 255 - self.alpha)
        if self.x == 0 then
            self.phase = 1
        end
    elseif self.phase == 1 then
        self.delay = self.delay - 1
        if self.delay <= 0 then
            self.phase = 2
            self:returnFade()
        end
    elseif self.phase == 2 then
        self.x = self.x + 640 / 10
        self.alpha = self.alpha - 255 / 10
        if self.x >= 640 then
            self:dispose()
            if self.callback then self.callback() end
        end
    end
end

function Cutin:backFade()
    -- local sprites = LayerManager:getSprites("scene")
    -- local bgs     = LayerManager:getSprites("important")

    -- for k,v in pairs(sprites) do
    --     if v ~= self and v.alpha > 0 then
    --         v:setFade(128, 128, 128, 255, 15)
    --     end
    -- end

    -- for k,v in pairs(bgs) do
    --     if v ~= self and v.alpha > 0 then
    --         v:setFade(128, 128, 128, 255, 15)
    --     end
    -- end
    local blackout = LayerManager:getSprite("scene", "blackout")
    blackout:setFade(255, 255, 255, 128, 15)
end

function Cutin:returnFade()
    -- local sprites = LayerManager:getSprites("scene")
    -- local bgs     = LayerManager:getSprites("important")

    -- for k,v in pairs(sprites) do
    --     if v ~= self and v.alpha > 0 then
    --         v:setFade(255, 255, 255, 255, 10)
    --     end
    -- end

    -- for k,v in pairs(bgs) do
    --     if v ~= self and v.alpha > 0 then
    --         v:setFade(255, 255, 255, 255, 10)
    --     end
    -- end
    local blackout = LayerManager:getSprite("scene", "blackout")
    blackout:setFade(255, 255, 255, 0, 10)
end

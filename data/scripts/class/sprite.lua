Sprite = class(Object)

function Sprite:init()
    self.x, self.y, self.z = 0, 0, 10
    self.ox, self.oy = 0, 0
    self.zoom_x, self.zoom_y = 1.0, 1.0
    self.red, self.green, self.blue, self.alpha = 255, 255, 255, 255
    self.toneChange = {}
    self.fadeChange = {}
    self.angle = 0
    self.image = nil
    self.quad  = nil
    self.blendMode = "alpha"
    self.shader = nil
    self.mirror = false
    self.layer  = "" -- for remove in layer manager
    self.name   = "" -- for remove in layer manager
    --
    self:initImage()
end

function Sprite:initImage()
    local image = self:imageCache()
    self:setImage(image)
end

function Sprite:imageCache()
    -- none
end

function Sprite:width()
    local x, y, w, h = self.quad:getViewport()
    return w * math.abs(self:realZoomX())
end

function Sprite:imageWidth()
    return self.image:getWidth()
end

function Sprite:height()
    local x, y, w, h = self.quad:getViewport()
    return h * math.abs(self:realZoomY())
end

function Sprite:imageHeight()
    return self.image:getHeight()
end

function Sprite:quadX()
    local x, y, w, h = self.quad:getViewport()
    return x
end

function Sprite:quadY()
    local x, y, w, h = self.quad:getViewport()
    return y
end

function Sprite:realZoomX()
    local result = self.zoom_x
    if self.mirror then result = result * -1 end
    return result
end

function Sprite:realZoomY()
    return self.zoom_y
end

function Sprite:draw()
    if self.image then
        if self.x - self.ox > love.window.getWidth()
            or self.x + self:width() - self.ox < 0
            or self.y - self.oy > love.window.getHeight()
            or self.y + self:height() - self.oy < 0 then
            return false
        end
        love.graphics.setShader(self.shader)
        love.graphics.setBlendMode(self.blendMode)
        love.graphics.setColor(self.red, self.green, self.blue, self.alpha)
        love.graphics.draw(self.image, self.quad, self.x, self.y, self.angle,
            self:realZoomX(), self:realZoomY(), self.ox, self.oy)
    end
end

function Sprite:setImage(image)
    if not image then return end
    local iw, ih = image:getWidth(), image:getHeight()
    self.image = image
    self.quad  = love.graphics.newQuad(0, 0, iw, ih, iw, ih)
end

function Sprite:unsetImage()
    self.image = nil
    self.quad  = nil
end

function Sprite:updateBase(dt)
    self:updateToneChange(dt)
    self:updateFadeChange(dt)
end

function Sprite:updateToneChange(dt)
    if not self.toneChange.r then return end
    self.red = self.red + math.min(self.toneChange.r, 255 - self.red)
    self.green = self.green + math.min(self.toneChange.g, 255 - self.green)
    self.blue = self.blue + math.min(self.toneChange.b, 255 - self.blue)
    self.alpha = self.alpha + math.min(self.toneChange.a, 255 - self.alpha)
    --
    if self.red + self.green + self.blue + self.alpha >= 255 * 4 then
        self.toneChange = {}
    end
end

function Sprite:updateFadeChange(dt)
    if not self.fadeChange.r then return end
    if self.fadeChange.r > 0 then
        self.red = self.red - math.min(self.fadeChange.r, -self.fadeChange.toR + self.red)
    else
        self.red = self.red - math.max(self.fadeChange.r, -self.fadeChange.toR + self.red)
    end
    if self.fadeChange.g > 0 then
        self.green = self.green - math.min(self.fadeChange.g, -self.fadeChange.toG + self.green)
    else
        self.green = self.green - math.max(self.fadeChange.g, -self.fadeChange.toG + self.green)
    end
    if self.fadeChange.b > 0 then
        self.blue = self.blue - math.min(self.fadeChange.b, -self.fadeChange.toB + self.blue)
    else
        self.blue = self.blue - math.max(self.fadeChange.b, -self.fadeChange.toB + self.blue)
    end
    if self.fadeChange.a > 0 then
        self.alpha = self.alpha - math.min(self.fadeChange.a, -self.fadeChange.toA + self.alpha)
    else
        self.alpha = self.alpha - math.max(self.fadeChange.a, -self.fadeChange.toA + self.alpha)
    end
    --
    if self.red == self.fadeChange.toR and self.green == self.fadeChange.toG and self.blue == self.fadeChange.toB and self.alpha == self.fadeChange.toA then
        self.fadeChange = {}
    end
end

function Sprite:update(dt)
    -- reserved
end

function Sprite:setQuad(x, y, w, h)
    if not x then x = self:quadX() end
    if not y then y = self:quadY() end
    if not w then w = self:width() end
    if not h then h = self:height() end
    self.quad:setViewport(x, y, w, h)
end

function Sprite:dispose()
    LayerManager:removeSprite(self.layer, self.name)
end

function Sprite:setToneChange(r, g, b, a, f)
    if self.toneChange.r then return end
    self.toneChange.r = (self.red - r) / f
    self.toneChange.g = (self.green - g) / f
    self.toneChange.b = (self.blue - b) / f
    self.toneChange.a = (self.alpha - a) / f
    self.red = r
    self.green = g
    self.blue = b
    self.alpha = a
end

function Sprite:setFade(r, g, b, a, f)
    if self.fadeChange.r then return end
    self.toneChange = {}
    self.fadeChange.r = (self.red - r) / f
    self.fadeChange.g = (self.green - g) / f
    self.fadeChange.b = (self.blue - b) / f
    self.fadeChange.a = (self.alpha - a) / f
    self.fadeChange.toR = r
    self.fadeChange.toG = g
    self.fadeChange.toB = b
    self.fadeChange.toA = a
end

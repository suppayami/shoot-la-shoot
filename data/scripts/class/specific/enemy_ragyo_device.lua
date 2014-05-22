RagyoDevice = class(Enemy)
RagyoDevice.enemyInit = RagyoDevice.super.init
RagyoDevice.enemyUpdate = RagyoDevice.super.update
RagyoDevice.enemyInitParams = RagyoDevice.super.initParams

function RagyoDevice:init(index)
    self.index = index
    self:enemyInit()
    self.sprite:setEnable(false)
    self.sprite:noLoop(nil)
end

function RagyoDevice:initSpawn()
    self.round = 0
    self.beams = {}
    --
    if self.index == 1 then
        self.x = -136
        self.rateX = 1
    elseif self.index == 2 then
        self.x = 0
        self.rateX = 1
    elseif self.index == 3 then
        self.x = love.window.getWidth() + 136
        self.rateX = -1
    elseif self.index == 4 then
        self.x = love.window.getWidth()
        self.rateX = -1
    end
    self.shoot = 60
    self.y = 196
    self:update()
end

function RagyoDevice:getScore()
    return 30
end

function RagyoDevice:initParams()
    self:enemyInitParams()
end

function RagyoDevice:spriteClass()
    return SpriteRagyoDevice
end

function RagyoDevice:spriteLayer()
    return "scene"
end

function RagyoDevice:spriteName()
    return "enemy_ragyo_device"
end

function RagyoDevice:shootDelay()
    return 230
end

function RagyoDevice:moveRateX()
    if self.rateX == 1 then
        if self.x >= love.window.getWidth() - self.width / 2
            and self.round < 2 then
            self.rateX = -1
            self.round = self.round + 1
        end
    elseif self.rateX == -1 then
        if self.x <= self.width / 2
            and self.round < 2 then
            self.rateX = 1
            self.round = self.round + 1
        end
    end
    return 2 * self.rateX
end

function RagyoDevice:moveRateY()
    return 0
end

function RagyoDevice:bulletClass()
    return BulletRagyoBeam -- bullet class
end

function RagyoDevice:bulletType()
    return "enemyBullet"
end

function RagyoDevice:bulletName()
    return "enemy_bullet_ragyo_device"
end

function RagyoDevice:actionShoot()
    if self.destroyed then return end
    self.sprite:setEnable(true)

    self.sprite:frameCallback(1, function()
        local imageCache = self:bulletSpriteClass():imageCache()
        local x = self.x
        local y = self.y + self.height / 2 + imageCache:getHeight() / 2

        for i=1,10 do
            local beam = self:createBullet(x, y)
            beam.sprite:noLoop(nil)
            self.beams[#self.beams+1] = beam
            y = y + imageCache:getHeight()
        end
    end)

    self.sprite:setTimer(120, function()
        self.sprite:resetAnimation()
        self.sprite:setEnable(false)
        self.sprite:noLoop(nil)
        for k,v in pairs(self.beams) do
            v:destroy()
            self.beams[k] = nil
        end
    end)
end

function RagyoDevice:deathEffect()
    local layer  = self:spriteLayer()
    local name   = "deadeffect"..self:spriteName()
    local class  = SpriteEnemyDead
    local sprite = LayerManager:addSprite(layer, name, class)

    sprite.x  = self.x
    sprite.y  = self.y

    sprite.ox = sprite:width() / 2
    sprite.oy = sprite:width() / 2

    sprite:autoDestroy(1)

    for k,v in pairs(self.beams) do
        v:destroy()
        self.beams[k] = nil
    end
end

function RagyoDevice:update()
    self:enemyUpdate()
    self:updateBeams()
end

function RagyoDevice:updateBeams()
    for k,v in pairs(self.beams) do
        if not v.destroyed then
            v.x = self.x
        end
    end
end

function RagyoDevice:updateAutoDestroy()
    if self.x > love.window.getWidth() + 140 + self.width / 2 then
        self:destroy()
    end
    if self.x < - self.width - 140 - self.width / 2 then
        self:destroy()
    end
end

function RagyoDevice:getDamage()
    return 15
end

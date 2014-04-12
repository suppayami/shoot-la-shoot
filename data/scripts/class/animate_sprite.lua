Animation = class(Sprite)
Animation.spriteInit = Animation.super.init

function Animation:init()
    self:spriteInit()
    ---
    local frames = self:animateFrames()
    local delay  = self:animateDelay()
    local rows   = self:animateRows()
    self:initAnimation(frames, delay, rows)
end

function Animation:animateFrames()
    return 0
end

function Animation:animateDelay()
    return 0
end

function Animation:animateRows()
    return 0
end

function Animation:initAnimation(frames, delay, rows)
    self.animate = {}
    self.animate.frame = frames
    self.animate.delay = delay
    self.animate.rows  = rows
    if not self.animate.rows then self.animate.rows = 1 end
    ---
    self.frame = 0
    self.tick  = self.animate.delay
    self.row   = 0
    self.loop  = 0 -- 0 means NO auto destroy
    self.loop_count = 0
    self.reset = -1 -- -1 means NO reset row
    ---
    self.sw    = self:width() / self.animate.frame
    self.sh    = self:height() / self.animate.rows
    ---
    self:setFrame()
end

function Animation:setFrame()
    local x = self.frame * self.sw
    local y = self.row   * self.sh
    self:setQuad(x, y, self.sw, self.sh)
end

function Animation:setRow(row)
    if row >= self.animate.rows then return end
    ---
    self.row   = row
    self.frame = 0
    self.tick  = self.animate.delay
    ---
    self:setFrame()
end

function Animation:update(dt)
    self:updateAnimation(dt)
end

function Animation:updateAnimation(dt)
    self.tick = self.tick - 1
    if self.tick <= 0 then
        self.tick  = self.animate.delay
        self.frame = (self.frame + 1) % self.animate.frame
        if self.frame == 0 then
            if self.loop > 0 then
                self.loop_count = self.loop_count + 1
                if self.loop_count >= self.loop then
                    self:dispose()
                    return
                end -- loop_count > loop
            end -- auto destroy ?

            if self.reset >= 0 then
                self:setRow(self.reset)
                return
            end -- auto reset ?
        end -- reset frame?
        self:setFrame()
    end
end

function Animation:autoDestroy(loop)
    self.loop = loop
end

function Animation:autoReset(row)
    self.reset = row
end
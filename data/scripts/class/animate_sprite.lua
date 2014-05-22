Animation = class(Sprite)
Animation.spriteInit = Animation.super.init

function Animation:init(vertical, subject)
    self:spriteInit()
    ---
    local frames = self:animateFrames()
    local delay  = self:animateDelay()
    local rows   = self:animateRows()
    self.vertical = false
    self.subject  = subject
    if vertical then self.vertical = vertical end
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
    ---
    self.enable     = true
    self.loop       = 0 -- 0 means NO auto destroy
    self.loop_count = 0
    self.reset      = -1 -- -1 means NO reset row
    self.callback   = nil -- use for loop/reset/nonLoop
    self.nonLoop    = false
    self.callFrame  = -1 -- -1 means NO call
    self.frameCall  = nil -- use for frame call
    self.timer      = 0
    self.timerCall  = nil
    ---
    if self.vertical then
        self.sw    = self:width() / self.animate.rows
        self.sh    = self:height() / self.animate.frame
    else
        self.sw    = self:width() / self.animate.frame
        self.sh    = self:height() / self.animate.rows
    end
    ---
    self:setFrame()
end

function Animation:setFrame()
    if self.frame >= self.animate.frame then 
        self.frame = self.animate.frame 
    end
    --
    local x = 0
    local y = 0
    if self.vertical then
        x = self.row   * self.sw
        y = self.frame * self.sh
    else
        x = self.frame * self.sw
        y = self.row   * self.sh
    end
    self:setQuad(x, y, self.sw, self.sh)
end

function Animation:resetAnimation()
    self.tick  = self.animate.delay
    self.frame = 0
    --
    self.loop       = 0
    self.loop_count = 0
    self.reset      = -1
    self.callback   = nil
    self.nonLoop    = false
    self.callFrame  = -1
    self.frameCall  = nil
    --
    self:setFrame()
end

function Animation:setRow(row)
    if row >= self.animate.rows then return end
    ---
    self.row   = row
    self.frame = 0
    self.tick  = self.animate.delay
    self.nonLoop = false
    ---
    self:setFrame()
end

function Animation:update(dt)
    self:updateAnimation(dt)
    self:updatePosition(dt)
    self:updateTimer(dt)
end

function Animation:updateAnimation(dt)
    if not self.enable then return end
    self.tick = self.tick - 1
    if self.tick <= 0 then
        self.tick  = self.animate.delay
        self.frame = self.frame + 1
        if self.frame == self.callFrame then
            if self.frameCall then
                self.frameCall()
            end
        end
        if self.nonLoop and self.frame >= self.animate.frame then
            self.frame = self.animate.frame - 1
            if self.callback then
                self.callback()
            end
            self.callback = nil
            return
        else
            self.frame = self.frame % self.animate.frame
        end
        if self.frame == 0 then
            if self.loop > 0 then
                self.loop_count = self.loop_count + 1
                if self.loop_count >= self.loop then
                    self:dispose()
                    if self.callback then 
                        self.callback()
                        self.callback = nil
                    end
                    return
                end -- loop_count > loop
            end -- auto destroy ?

            if self.reset >= 0 then
                self:setRow(self.reset)
                if self.callback then
                    self.callback()
                    self.callback = nil
                end
                return
            end -- auto reset ?
        end -- reset frame?
        self:setFrame()
    end
end

function Animation:noLoop(callback)
    self.nonLoop  = true
    self.callback = callback
end

function Animation:autoDestroy(loop, callback)
    self.loop = loop
    self.callback = callback
end

function Animation:autoReset(row, callback)
    self.reset = row
    self.callback = callback
end

function Animation:frameCallback(frame, callback)
    self.callFrame = frame
    self.frameCall = callback
end

function Animation:setTimer(frame, callback)
    self.timer     = frame
    self.timerCall = callback
end

function Animation:setEnable(flag)
    self.enable = flag
end

function Animation:updatePosition(dt)
    if not self.subject then return end
    self.x = self.subject.x
    self.y = self.subject.y
end

function Animation:updateTimer(dt)
    if self.timer <= 0 then return end
    self.timer = self.timer - 1
    if self.timer <= 0 and self.timerCall then
        self.timerCall()
    end
end
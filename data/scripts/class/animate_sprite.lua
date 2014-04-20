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
    ---
    self.loop       = 0 -- 0 means NO auto destroy
    self.loop_count = 0
    self.reset      = -1 -- -1 means NO reset row
    self.callback   = nil -- use for loop/reset/nonLoop
    self.nonLoop    = false
    ---
    self.sw    = self:width() / self.animate.frame
    self.sh    = self:height() / self.animate.rows
    ---
    self:setFrame()
end

function Animation:setFrame()
    if self.frame >= self.animate.frame then 
        self.frame = self.animate.frame 
    end
    --
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
    self.nonLoop = false
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
        self.frame = self.frame + 1
        if self.nonLoop and self.frame >= self.animate.frame then
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
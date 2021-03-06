Input = class(Object)

-- init properties
Input.axisX = 0
Input.axisY = 0
Input.up    = false
Input.down  = false
Input.left  = false
Input.right = false
Input.fire  = false
Input.item1 = false
Input.item2 = false
Input.item3 = false
-- for pressed and released key
Input.pressed = {}

function Input:update()
    -- reset all key
    self:resetKey()
    -- check key is pressed
    if love.keyboard.isDown(" ")     then self.fire  = true end
    if love.keyboard.isDown("up")    then self.up    = true end
    if love.keyboard.isDown("down")  then self.down  = true end
    if love.keyboard.isDown("left")  then self.left  = true end
    if love.keyboard.isDown("right") then self.right = true end
    if love.keyboard.isDown("d") then
        if not self.pressed.d then
            self.item1 = true
            self.pressed.d = true
        end
    end
    if love.keyboard.isDown("s") then
        if not self.pressed.s then
            self.item2 = true
            self.pressed.s = true
        end
    end
    if love.keyboard.isDown("a") then
        if not self.pressed.a then
            self.item3 = true
            self.pressed.a = true
        end
    end
    -- update axisX & axisY for movement
    self:resetAxis()
    self:updateAxis()
end

function Input:resetKey()
    self.fire  = false
    self.up    = false
    self.down  = false
    self.left  = false
    self.right = false
    self.item1 = false
    self.item2 = false
    self.item3 = false
end

function Input:resetAxis()
    -- axis X
    if not self.left and self.axisX < 0 then 
        self.axisX = math.min(self.axisX + 0.1, 0) 
    end
    if not self.right and self.axisX > 0 then 
        self.axisX = math.max(self.axisX - 0.1, 0) 
    end
    -- axis Y
    if not self.up and self.axisY < 0 then 
        self.axisY = math.min(self.axisY + 0.1, 0) 
    end
    if not self.down and self.axisY > 0 then 
        self.axisY = math.max(self.axisY - 0.1, 0) 
    end
end

function Input:updateAxis()
    -- axis X
    if self.left  then self.axisX = math.max(self.axisX - 0.1, -1) end
    if self.right then self.axisX = math.min(self.axisX + 0.1, 1)  end
    -- axis Y
    if self.up    then self.axisY = math.max(self.axisY - 0.1, -1) end
    if self.down  then self.axisY = math.min(self.axisY + 0.1, 1)  end
end

function love.keyreleased(key)
    Input.pressed[key] = false
end
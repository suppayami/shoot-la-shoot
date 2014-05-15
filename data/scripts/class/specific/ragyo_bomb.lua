RagyoBomb = class(Model)

function RagyoBomb:throwTo(x, y)
    self.throw = true
    self.toX   = x
    self.toY   = y
    self.moveX = x - self.x
    self.moveY = y - self.y
    if self.moveY ~= 0 then
        self.flyAngle = math.atan(self.moveX / self.moveY)
    else
        self.flyAngle = math.pi / 2
    end
end

function RagyoBomb:moveRateX()
    if self.x == self.toX and self.y == self.toY then
        self.throw = false
    end
    if self.throw then
        if self.moveY > 0 then
            if math.sin(self.flyAngle) > 0 then
                return math.min(self.toX - self.x, 10 * math.sin(self.flyAngle))
            else
                return math.max(self.toX - self.x, 10 * math.sin(self.flyAngle))
            end
        else
            if math.sin(self.flyAngle) > 0 then
                return math.max(self.toX - self.x, -10 * math.sin(self.flyAngle))
            else
                return math.min(self.toX - self.x, -10 * math.sin(self.flyAngle))
            end
        end
    else
        return 0
    end
end

function RagyoBomb:moveRateY()
    if self.x == self.toX and self.y == self.toY then
        self.throw = false
    end
    if self.throw then
        if self.moveY > 0 then
            if math.cos(self.flyAngle) > 0 then
                return math.min(self.toY - self.y, 10 * math.cos(self.flyAngle))
            else
                return math.max(self.toY - self.y, 10 * math.cos(self.flyAngle))
            end
        else
            if math.cos(self.flyAngle) > 0 then
                return math.max(self.toY - self.y, -10 * math.cos(self.flyAngle))
            else
                return math.min(self.toY - self.y, -10 * math.cos(self.flyAngle))
            end
        end
    else
        return 0
    end
end

function RagyoBomb:spriteClass()
    return SpriteRagyoBomb
end

function RagyoBomb:spriteLayer()
    return "scene"
end

function RagyoBomb:spriteName()
    return "ragyo_bomb"
end
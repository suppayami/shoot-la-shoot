Ryuko = class(Player)

function Ryuko:spriteClass()
    return SpriteRyuko
end

function Ryuko:spriteLayer()
    return "player"
end

function Ryuko:spriteName()
    return "player"
end

function Ryuko:shootDelay()
    return 15
end

function Ryuko:moveRateX()
    return 6
end

function Ryuko:moveRateY()
    return 6
end

function Ryuko:actionShoot()
    
end
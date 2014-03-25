function love.load()
    local sprite = LayerManager:addSprite('gameObjects', 'player', Sprite)
    sprite:setImage(Cache:loadImage('graphics/player.png'))

    love.player = Player:new(320, 320)
    love.player:setSprite(sprite)

    local sprite = LayerManager:addSprite('gameObjects', 'enemy', Sprite)
    sprite:setImage(Cache:loadImage('graphics/enemy A.png'))

    love.enemy = Model:new()
    love.enemy.x = 100
    love.enemy.y = 100
    love.enemy:setSprite(sprite)

    love.collideTime = 0
end

function love.draw()
    LayerManager:drawAll()
end

function love.update(dt)
    LayerManager:updateAll()
    Input:update()
    love.player:update()
    love.enemy:update()
    if love.player:collided(love.enemy) then
        love.collideTime = love.collideTime + 1
        print("Collided!"..love.collideTime)
    end
end
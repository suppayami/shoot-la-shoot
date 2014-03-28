function love.load()
    local model = ModelManager:addModel("playerCharacter", "player", Ryuko, 300, 540)
    love.spawn = 10
end

function love.draw()
    LayerManager:drawAll()
end

function love.update(dt)
    LayerManager:updateAll()
    Input:update()
    ModelManager:update()
    ---
    love.spawn = love.spawn - 1
    if love.spawn <= 0 then
        love.spawn = randomNumber:random(40, 90)
        ModelManager:addModel("enemyCharacter", "enemy_a", EnemyA)
    end
end
function love.load()
    local model = ModelManager:addModel("playerCharacter", "player", Ryuko, 320, 320)
    local model = ModelManager:addModel("enemyCharacter", "enemy", EnemyA, 100, 100)
end

function love.draw()
    LayerManager:drawAll()
end

function love.update(dt)
    LayerManager:updateAll()
    Input:update()
    ModelManager:update()
end
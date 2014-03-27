function love.load()
    local model = ModelManager:addModel("playerCharacter", "player", Ryuko, 320, 320)
    local model = ModelManager:addModel("enemyCharacter", "enemy1", EnemyA, 100, 100)
    local model = ModelManager:addModel("enemyCharacter", "enemy2", EnemyA, 120, 90)
    local model = ModelManager:addModel("enemyCharacter", "enemy3", EnemyA, 105, 120)
    local model = ModelManager:addModel("enemyCharacter", "enemy4", EnemyA, 100, 200)
end

function love.draw()
    LayerManager:drawAll()
end

function love.update(dt)
    LayerManager:updateAll()
    Input:update()
    ModelManager:update()
end
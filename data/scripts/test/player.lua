function love.load()
    local sprite = LayerManager:addSprite("scene", "ground", SpriteBackgroundGround)
    local sprite = LayerManager:addSprite("scene", "deco", SpriteBackgroundDeco)
    local model  = ModelManager:addModel("playerCharacter", "player", Ryuko, 300, 540)
    local sprite = LayerManager:addSprite("scene", "base", SpriteRyukoHUD)
    local sprite = LayerManager:addSprite("scene", "hp", SpritePlayerHP)
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
        love.spawn = randomNumber:random(60, 90)
        local hjhj = randomNumber:random(1, 20)
        if hjhj <= 5 then
            ModelManager:addModel("enemyCharacter", "enemy_a", EnemyA)
        elseif hjhj <= 10 then
            ModelManager:addModel("enemyCharacter", "enemy_b", EnemyB)
        elseif hjhj <= 15 then
            ModelManager:addModel("enemyCharacter", "enemy_b", EnemyD)
        else
            ModelManager:addModel("enemyCharacter", "enemy_c", EnemyC)
        end
    end
end
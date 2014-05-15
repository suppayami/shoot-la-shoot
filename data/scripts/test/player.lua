function love.load()
    local sprite = LayerManager:addSprite("scene", "ground", SpriteBackgroundGround)
    local sprite = LayerManager:addSprite("scene", "deco", SpriteBackgroundDeco)
    local model  = ModelManager:addModel("playerCharacter", "player", Ryuko, 300, 540)
    local model  = ModelManager:addModel("playerCharacter", "npc", NakedSun, 300, 540)
    local sprite = LayerManager:addSprite("scene", "base", SpriteRyukoHUD)
    local sprite = LayerManager:addSprite("scene", "hp", SpritePlayerHP, 1)
    local sprite = LayerManager:addSprite("scene", "hp", SpritePlayerHP, 2)
    local sprite = LayerManager:addSprite("scene", "hp", SpritePlayerHP, 3)
    local sprite = LayerManager:addSprite("scene", "hp", SpriteNPCHP)
    love.spawn = 60
    love.itemspawn = 60
    love.bombspawn = 120
end

function love.draw()
    LayerManager:drawAll()
end

function love.update(dt)
    LayerManager:updateAll()
    Input:update()
    ModelManager:update()
    --
    love.spawn = love.spawn - 1
    if love.spawn <= 0 then
        love.spawn = 100000000000
        -- local hjhj = randomNumber:random(1, 20)
        -- if hjhj <= 5 then
        --     ModelManager:addModel("enemyCharacter", "enemy_a", EnemyA)
        -- elseif hjhj <= 10 then
        --     ModelManager:addModel("enemyCharacter", "enemy_b", EnemyB)
        -- elseif hjhj <= 15 then
        --     ModelManager:addModel("enemyCharacter", "enemy_b", EnemyC)
        -- else
        --     ModelManager:addModel("enemyCharacter", "enemy_c", EnemyD)
        -- end
        ModelManager:addModel("enemyCharacter", "enemy_c", EnemyRagyo)
    end
    ---
    love.itemspawn = love.itemspawn - 1
    if love.itemspawn <= 0 then
        love.itemspawn = 150
        ModelManager:addModel("items", "item_boost_a", ItemCroquette, randomNumber:random(48, 600), 0)
    end
    ---
    love.bombspawn = love.bombspawn - 1
    if love.bombspawn <= 0 then
        local toX = randomNumber:random(48, 600)
        local toY = randomNumber:random(0, 320)
        local naked = ModelManager:getModel("playerCharacter", "npc")
        local sX  = 0
        while toX >= (naked.x - naked.width - 4) and toX <= (naked.x + naked.width + 4) do
            toX = randomNumber:random(48, 600)
        end
        if naked.x > toX then
            sX = naked.x - naked.width - 4
        elseif naked.x < toX then
            sX = naked.x + naked.width + 4
        end
        love.bombspawn = 1800
        local model = ModelManager:addModel("items", "item_bomb", ItemBomb, sX, naked.y)
        model:throwTo(toX, toY)
    end
end
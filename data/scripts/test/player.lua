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
    love.nui   = false
    love.ragyo = false
    love.boss  = false
    love.spawn = 200
    love.timePass = 0
    love.spawnC = false
    love.spawnCDelay = 0
    love.spawnCCount = 0
    love.itemspawn   = 2400
    love.bombspawn   = 60 * 60
    love.nuispawn    = 3600 * 3
    love.ragyospawn  = 3600 * 3
    love.font = love.graphics.newFont("font/Inconsolata.otf", 48)
end

function love.draw()
    LayerManager:drawAll()
    love.drawScore()
end

function love.drawScore()
    local changeNum = 0
    if not love.score then love.score = 0 end
    if not love.runScore then love.runScore = 0 end
    love.graphics.setFont(love.font)
    love.runScore = love.runScore + math.min(100, love.score - love.runScore)
    -- love.graphics.setColor(0, 0, 0, 255)
    love.graphics.printf(love.runScore, 514, 590, 120, "right")
end

function love.update(dt)
    LayerManager:updateAll()
    Input:update()
    ModelManager:update()
    --
    if not love.nui and not love.boss then
        love.nuispawn = love.nuispawn - 1
        if love.nuispawn <= 0 then
            ModelManager:addModel("enemyCharacter", "boss", EnemyNui)
            love.boss = true
            love.nui  = true
            love.ragyo = false
        end
    end
    --
    if not love.ragyo and not love.boss and love.nui then
        love.ragyospawn = love.ragyospawn - 1
        if love.ragyospawn <= 0 then
            ModelManager:addModel("enemyCharacter", "boss", EnemyRagyo)
            love.boss  = true
            love.ragyo = true
            love.nui   = false
        end
    end
    --
    if love.boss then
        local model = ModelManager:getModel("enemyCharacter", "boss")
        if not model then
            love.boss = false
        end
    end
    --
    -- if not love.boss then
    love.timePass = love.timePass + 1
    love.spawn = love.spawn - 1
    if love.spawn <= 0 then
        if love.timePass < 60 * 40 then
            love.spawn = randomNumber:random(180, 320)
        else
            love.spawn = randomNumber:random(90, 180)
        end
        love.spawn = randomNumber:random(90, 160)
        local hjhj = randomNumber:random(1, 20)
        if hjhj <= 5 then
            ModelManager:addModel("enemyCharacter", "enemy_a", EnemyA)
        elseif hjhj <= 10 then
            ModelManager:addModel("enemyCharacter", "enemy_b", EnemyB)
        elseif hjhj <= 15 then
            --ModelManager:addModel("enemyCharacter", "enemy_c", EnemyC)
            love.spawnC = true
        else
            ModelManager:addModel("enemyCharacter", "enemy_d", EnemyD)
        end
    end
    -- end
    --
    if love.spawnC then
        love.spawnCDelay = love.spawnCDelay - 1
        if love.spawnCDelay <= 0 then
            love.spawnCDelay = 16
            love.spawnCCount = love.spawnCCount + 1
            ModelManager:addModel("enemyCharacter", "enemy_c", EnemyC)
            if love.spawnCCount >= 3 then
                love.spawnC = false
                love.spawnCCount = 0
            end
        end
    end
    --
    love.itemspawn = love.itemspawn - 1
    if love.itemspawn <= 0 then
        love.itemspawn = 2400
        local hjhj = randomNumber:random(1, 20)
        if hjhj <= 5 then
            ModelManager:addModel("items", "item_boost_a", ItemBoostA, randomNumber:random(48, 600), 0)
        elseif hjhj <= 10 then
            ModelManager:addModel("items", "item_boost_b", ItemBoostB, randomNumber:random(48, 600), 0)
        elseif hjhj <= 15 then
            ModelManager:addModel("items", "item_cro", ItemCroquette, randomNumber:random(48, 600), 0)
        else
            ModelManager:addModel("items", "item_pot", ItemPotion, randomNumber:random(48, 600), 0)
        end
    end
    --
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
        love.bombspawn = 60 * 60
        local model = ModelManager:addModel("items", "item_bomb", ItemBomb, sX, naked.y)
        model:throwTo(toX, toY)
    end
end

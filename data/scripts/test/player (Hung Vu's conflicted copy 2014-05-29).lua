function love.load()
    love.unlocked = true
    love.char = 0
    love.scene = "splash1"
    love.font = love.graphics.newFont("font/Inconsolata.otf", 48)
    love.initSplash1()
end

function love.clearAll()
    ModelManager:clearAll()
    LayerManager:clearAll()
end

function love.initSplash1()
    local sprite = LayerManager:addSprite("scene", "splash", Sprite)
    sprite:setImage(Cache:loadImage("graphics/Splash 1.png"))
    sprite:setToneChange(255, 255, 255, 0, 90)
    love.waitScene = 180
end

function love.initSplash2()
    local sprite = LayerManager:addSprite("scene", "splash", Sprite)
    sprite:setImage(Cache:loadImage("graphics/Splash 2.png"))
    sprite:setToneChange(255, 255, 255, 0, 90)
    love.waitScene = 180
    love.scene = "splash2"
end

function love.initTitle()
    LayerManager:clearLayer("scene")
    if not LayerManager:getSprite("important", "ground") then
        local sprite = LayerManager:addSprite("important", "ground", SpriteBackgroundGround)
        sprite:setToneChange(255, 255, 255, 0, 40)
        local sprite = LayerManager:addSprite("important", "deco", SpriteBackgroundDeco)
        sprite:setToneChange(255, 255, 255, 0, 40)
    end
    local sprite = LayerManager:addSprite("scene", "title", Sprite)
    sprite:setImage(Cache:loadImage("graphics/Title Screen.png"))
    sprite:setToneChange(255, 255, 255, 0, 80)
    local sprite = LayerManager:addSprite("scene", "0", Sprite)
    sprite:setImage(Cache:loadImage("graphics/start.png"))
    sprite.x = 175
    sprite.y = 520
    sprite.alpha = 0
    local sprite = LayerManager:addSprite("scene", "1", Sprite)
    sprite:setImage(Cache:loadImage("graphics/High Score.png"))
    sprite.x = 175
    sprite.y = 520
    sprite.alpha = 0
    local sprite = LayerManager:addSprite("scene", "2", Sprite)
    sprite:setImage(Cache:loadImage("graphics/credits.png"))
    sprite.x = 175
    sprite.y = 520
    sprite.alpha = 0
    local sprite = LayerManager:addSprite("scene", "left", Sprite)
    sprite:setImage(Cache:loadImage("graphics/arrowright.png"))
    sprite.x = 120
    sprite.y = 524
    sprite.alpha = 0
    local sprite = LayerManager:addSprite("scene", "right", Sprite)
    sprite:setImage(Cache:loadImage("graphics/arrowleft.png"))
    sprite.x = 492
    sprite.y = 524
    sprite.alpha = 0
    love.scene = "title"
    love.arrrowTick = 0
    love.titleIndex = 0
end

function love.initGameOver()
    LayerManager:clearLayer("scene")
    ModelManager:clearAll()
    local sprite = LayerManager:addSprite("scene", "over", Sprite)
    if love.char == 0 then
        sprite:setImage(Cache:loadImage("graphics/Ryuko GO.png"))
    elseif love.char == 1 then
        sprite:setImage(Cache:loadImage("graphics/Satsuki GO.png"))
    end
    sprite:setToneChange(255, 255, 255, 0, 15)
    local sprite = LayerManager:addSprite("scene", "0", Sprite)
    sprite:setImage(Cache:loadImage("graphics/retry.png"))
    sprite.x = 175
    sprite.y = 520
    sprite.alpha = 0
    local sprite = LayerManager:addSprite("scene", "1", Sprite)
    sprite:setImage(Cache:loadImage("graphics/menu.png"))
    sprite.x = 175
    sprite.y = 520
    sprite.alpha = 0
    local sprite = LayerManager:addSprite("scene", "left", Sprite)
    sprite:setImage(Cache:loadImage("graphics/arrowright.png"))
    sprite.x = 120
    sprite.y = 524
    sprite.alpha = 0
    local sprite = LayerManager:addSprite("scene", "right", Sprite)
    sprite:setImage(Cache:loadImage("graphics/arrowleft.png"))
    sprite.x = 492
    sprite.y = 524
    sprite.alpha = 0
    love.scene = "gameover"
    love.arrrowTick = 0
    love.titleIndex = 0
end

function love.initCredit()
    LayerManager:clearLayer("scene")
    local sprite = LayerManager:addSprite("scene", "credit", Sprite)
    sprite:setImage(Cache:loadImage("graphics/Credits Screen.png"))
    sprite:setToneChange(255, 255, 255, 0, 20)
    love.scene = "credit"
end

function love.initSelect()
    LayerManager:clearLayer("scene")
    local sprite = LayerManager:addSprite("scene", "0", Sprite)
    sprite:setImage(Cache:loadImage("graphics/Char Select - Ryuko.png"))
    sprite:setToneChange(255, 255, 255, 0, 20)
    local sprite = LayerManager:addSprite("scene", "1", Sprite)
    sprite:setImage(Cache:loadImage("graphics/Char Select - Satsuki.png"))
    sprite.alpha = 0
    love.selectIndex = 0
    love.scene = "select"
end

function love.initGame(char)
    LayerManager:clearLayer("scene")
    if char == 0 then
        local model  = ModelManager:addModel("playerCharacter", "player", Ryuko, 300, 540)
    elseif char == 1 then
        local model  = ModelManager:addModel("playerCharacter", "player", Satsuki, 300, 540)
    end
    love.char = char
    local model  = ModelManager:addModel("playerCharacter", "npc", NakedSun, 300, 540)
    if char == 0 then
        local sprite = LayerManager:addSprite("scene", "base", SpriteRyukoHUD)
    elseif char == 1 then
        local sprite = LayerManager:addSprite("scene", "base", SpriteSatsukiHUD)
    end
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
    love.itemspawn   = 0
    love.bombspawn   = 60 * 60
    love.nuispawn    = 3600 * 3
    love.ragyospawn  = 3600 * 3
    love.score = 0
    love.runScore = 0
    love.scene = "game"
end

function love.draw()
    LayerManager:drawAll()
    if love.scene == "game" then
        love.drawScore()
    elseif love.scene == "gameover" then
        love.drawGOScore()
    end
end

function love.drawScore()
    local changeNum = 0
    if not love.score then love.score = 0 end
    if not love.runScore then love.runScore = 0 end
    love.graphics.setFont(love.font)
    love.runScore = love.runScore + math.min(100, love.score - love.runScore)
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.printf(""..love.runScore, 514, 590, 120, "right")
end

function love.drawGOScore()
    if not love.score then love.score = 0 end
    love.graphics.setFont(love.font)
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.printf(""..love.score, 257, 420, 120, "center")
end

function love.update(dt)
    LayerManager:updateAll()
    Input:update()
    ModelManager:update()
    SoundManager:collect()
    if love.scene == "game" then
        love.updateGame(dt)
    elseif love.scene == "splash1" or love.scene == "splash2" then
        love.updateSplash(dt)
    elseif love.scene == "title" then
        love.updateTitle(dt)
    elseif love.scene == "select" then
        love.updateSelect(dt)
    elseif love.scene == "gameover" then
        love.updateGameOver(dt)
    end
end

function love.updateSplash(dt)
    local sprite = LayerManager:getSprite("scene", "splash")
    love.waitScene = love.waitScene - 1
    if love.waitScene <= 0 and sprite then
        sprite:setFade(255, 255, 255, 0, 30)
        if sprite.alpha <= 0 then
            love.clearAll()
            if love.scene == "splash1" then
                love.initSplash2()
                    elseif love.scene == "splash2" then
                        love.initTitle()                                
            end
        end
    end
end

function love.updateTitle(dt)
    local left  = LayerManager:getSprite("scene", "left")
    local right = LayerManager:getSprite("scene", "right")
    local title = LayerManager:getSprite("scene", "title")
    love.arrrowTick = love.arrrowTick + 0.1
    left.x = 120 + 8 * math.sin(love.arrrowTick)
    right.x = 492 - 8 * math.sin(love.arrrowTick)
    if title.alpha >= 200 then
        local button = LayerManager:getSprite("scene", ""..love.titleIndex)
        button:setFade(255, 255, 255, 255, 10)
        left:setFade(255, 255, 255, 255, 10)
        right:setFade(255, 255, 255, 255, 10)
    end
end

function love.updateGameOver(dt)
    local left  = LayerManager:getSprite("scene", "left")
    local right = LayerManager:getSprite("scene", "right")
    local button = LayerManager:getSprite("scene", ""..love.titleIndex)
    love.arrrowTick = love.arrrowTick + 0.1
    left.x = 120 + 8 * math.sin(love.arrrowTick)
    right.x = 492 - 8 * math.sin(love.arrrowTick)
    button:setFade(255, 255, 255, 255, 10)
    left:setFade(255, 255, 255, 255, 10)
    right:setFade(255, 255, 255, 255, 10)
end

function love.updateSelect(dt)
    local char = LayerManager:getSprite("scene", ""..love.selectIndex)
    char:setFade(255, 255, 255, 255, 10)
end

function love.updateGame(dt)
    local player = ModelManager:getModel("playerCharacter", "player")
    local npc = ModelManager:getModel("playerCharacter", "npc")
    if player.destroyed or npc.destroyed then
        love.initGameOver()
    end
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
        local rate = 1
        love.spawn = randomNumber:random(180, 320)
        if player.powerA then rate = rate + 0.35 end
        if player.powerB then rate = rate + 0.35 end
        rate = rate + 0.2 * love.timePass / 1800
        love.spawn = love.spawn / rate
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
            if love.spawnCCount >= 5 then
                love.spawnC = false
                love.spawnCCount = 0
            end
        end
    end
    --
    love.itemspawn = love.itemspawn + 1
    if love.itemspawn % (30 * 60) == 0 then
        if randomNumber:random(1, 100) <= 60 then
            ModelManager:addModel("items", "item_cro", ItemCroquette, randomNumber:random(48, 600), -randomNumber:random(0, 128))
        end
    end
    if love.itemspawn % (60 * 60) == 0 then
        if randomNumber:random(1, 100) <= 80 then
            ModelManager:addModel("items", "item_pot", ItemPotion, randomNumber:random(48, 600), -randomNumber:random(0, 128))
        end
    end
    if love.itemspawn % (40 * 60) == 0 then
        if randomNumber:random(1, 100) <= 60 then
            ModelManager:addModel("items", "item_boost_a", ItemBoostA, randomNumber:random(48, 600), -randomNumber:random(0, 128))
        end
        if randomNumber:random(1, 100) <= 40 then
            ModelManager:addModel("items", "item_boost_b", ItemBoostB, randomNumber:random(48, 600), -randomNumber:random(0, 128))
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

function love.keypressed(key)
    if love.scene == "splash1" or love.scene == "splash2" then
        love.splashKeyPressed(key)
    elseif love.scene == "title" then
        love.titleKeyPressed(key)
    elseif love.scene == "credit" then
        love.creditKeyPressed(key)
    elseif love.scene == "select" then
        love.selectKeyPressed(key)
    elseif love.scene == "gameover" then
        love.overKeyPressed(key)
    end
end

function love.splashKeyPressed(key)
    if love.waitScene > 16 then
        love.waitScene = 16
    end
end

function love.creditKeyPressed(key)
    local cursorMove = SoundManager:addSound("Cursor Cancel.wav")
    cursorMove:play()
    love.initTitle()
end

function love.titleKeyPressed(key)
    local button = LayerManager:getSprite("scene", ""..love.titleIndex)
    local left  = LayerManager:getSprite("scene", "left")
    local right = LayerManager:getSprite("scene", "right")
    --
    if button.alpha < 255 then return end
    --
    if key == "left" then
        local cursorMove = SoundManager:addSound("Cursor Move.wav")
        cursorMove:play()
        button.fadeChange = {}
        button:setFade(255, 255, 255, 0, 10)
        left:setToneChange(100, 100, 100, 96, 8)
        if love.titleIndex <= 0 then
            love.titleIndex = 2
        else
            love.titleIndex = love.titleIndex - 1
        end
    elseif key == "right" then
        local cursorMove = SoundManager:addSound("Cursor Move.wav")
        cursorMove:play()
        button.fadeChange = {}
        button:setFade(255, 255, 255, 0, 10)
        right:setToneChange(100, 100, 100, 96, 8)
        if love.titleIndex >= 2 then
            love.titleIndex = 0
        else
            love.titleIndex = love.titleIndex + 1
        end
    elseif key == " " or key == "return" then
        local cursorMove = SoundManager:addSound("Cursor Selection.wav")
        cursorMove:play()
        if love.titleIndex == 2 then
            love.initCredit()
        elseif love.titleIndex == 0 then
            love.initSelect()
        end
    end
end

function love.overKeyPressed(key)
    local button = LayerManager:getSprite("scene", ""..love.titleIndex)
    local left  = LayerManager:getSprite("scene", "left")
    local right = LayerManager:getSprite("scene", "right")
    --
    if button.alpha < 255 then return end
    --
    if key == "left" then
        local cursorMove = SoundManager:addSound("Cursor Move.wav")
        cursorMove:play()
        button.fadeChange = {}
        button:setFade(255, 255, 255, 0, 10)
        left:setToneChange(100, 100, 100, 96, 8)
        if love.titleIndex <= 0 then
            love.titleIndex = 1
        else
            love.titleIndex = love.titleIndex - 1
        end
    elseif key == "right" then
        local cursorMove = SoundManager:addSound("Cursor Move.wav")
        cursorMove:play()
        button.fadeChange = {}
        button:setFade(255, 255, 255, 0, 10)
        right:setToneChange(100, 100, 100, 96, 8)
        if love.titleIndex >= 1 then
            love.titleIndex = 0
        else
            love.titleIndex = love.titleIndex + 1
        end
    elseif key == " " or key == "return" then
        local cursorMove = SoundManager:addSound("Cursor Selection.wav")
        cursorMove:play()
        if love.titleIndex == 1 then
            love.initTitle()
        elseif love.titleIndex == 0 then
            love.initGame(love.char)
        end
    end
end

function love.selectKeyPressed(key)
    local char = LayerManager:getSprite("scene", ""..love.selectIndex)
    --
    if char.alpha < 255 then return end
    --
    if key == "left" then
        if love.unlocked then
            local cursorMove = SoundManager:addSound("Cursor Move.wav")
            cursorMove:play()
            char.fadeChange = {}
            char:setFade(255, 255, 255, 0, 10)
            if love.selectIndex <= 0 then
                love.selectIndex = 1
            else
                love.selectIndex = love.selectIndex - 1
            end
        end
    elseif key == "right" then
        if love.unlocked then
            local cursorMove = SoundManager:addSound("Cursor Move.wav")
            cursorMove:play()
            char.fadeChange = {}
            char:setFade(255, 255, 255, 0, 10)
            if love.selectIndex >= 1 then
                love.selectIndex = 0
            else
                love.selectIndex = love.selectIndex + 1
            end
        end
    elseif key == " " or key == "return" then
        local cursorMove = SoundManager:addSound("Cursor Selection.wav")
        cursorMove:play()
        love.initGame(love.selectIndex)
    elseif key == "escape" then
        local cursorMove = SoundManager:addSound("Cursor Cancel.wav")
        cursorMove:play()
        love.initTitle()
    end
end

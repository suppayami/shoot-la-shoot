-- singleton
LayerManager = class(Object)
LayerManager.layer = {}
LayerManager.sort  = {}

function LayerManager:clearAll()
    for k,v in pairs(self.layer) do
        for i,s in pairs(v) do
            s:unsetImage()
            v[i] = nil
        end
        self.layer[k] = nil
    end
end

function LayerManager:clearLayer(layer)
    if self.layer[layer] == nil then return 0 end
    local l = self.layer[layer]
    for k,v in pairs(l) do
        v:unsetImage()
        l[k] = nil
    end
    self.layer[layer] = nil
end

function LayerManager:removeSprite(layer, spriteName)
    if self.layer[layer] == nil then return 0 end
    local l = self.layer[layer]
    if l[spriteName] == nil then return 0 end
    l[spriteName]:unsetImage()
    l[spriteName] = nil
end

function LayerManager:addSprite(layer, spriteName, spriteClass, ...)
    if self.layer[layer] == nil then self.layer[layer] = {} end
    --
    local l = self.layer[layer]
    local sprite = spriteClass:new(...)
    if l[spriteName] then spriteName = spriteName..tostring(sprite) end
    l[spriteName]       = sprite
    l[spriteName].layer = layer
    l[spriteName].name  = spriteName
    self.sort[layer]    = sortFunc.sortTable(l, function (a,b) return a.z < b.z end)
    return l[spriteName]
end

function LayerManager:sortSprite(layer)
    local l = self.layer[layer]
    self.sort[layer] = sortFunc.sortTable(l, function (a,b) return a.z < b.z end)
end

function LayerManager:draw(layer)
    if self.sort[layer] == nil then self.sort[layer] = {} end
    --
    local l = self.sort[layer]
    for i,s in pairs(l) do s:draw() end
end

function LayerManager:drawAll()
    for k,v in pairs(self.layer) do
        self:draw(k)
    end
end

function LayerManager:update(layer, dt)
    if self.layer[layer] == nil then self.layer[layer] = {} end
    --
    local l = self.layer[layer]
    for i,s in pairs(l) do s:update(dt) end
end

function LayerManager:updateAll(dt)
    for k,v in pairs(self.layer) do
        self:update(k, dt)
    end
end

function LayerManager:getSprite(layer, spriteName)
    if self.layer[layer] == nil then self.layer[layer] = {} end
    return self.layer[layer][spriteName]
end

function LayerManager:getSprites(layer)
    if self.layer[layer] == nil then self.layer[layer] = {} end
    return self.layer[layer]
end

function LayerManager:getSpriteCount(layer)
    if self.layer[layer] == nil then self.layer[layer] = {} end
    local result = 0
    for k,v in pairs(self.layer[layer]) do
        result = result + 1
    end
    return result
end
-- singleton
LayerManager = class(Object)
LayerManager.layer  = {}
LayerManager.sort   = {}
LayerManager.zLayer = {}
LayerManager.zValue = {}

function LayerManager:clearAll()
    for k,v in pairs(self.layer) do
        for i,s in pairs(v) do
            s:unsetImage()
            v[i] = nil
        end
        self.layer[k] = nil
    end
    --
    for k,v in pairs(self.zValue) do
        self.zValue[k] = nil
    end
    --
    for k,v in pairs(self.zLayer) do
        for i,s in pairs(v) do
            v[i] = nil
        end
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
    --
    local z = self.zLayer[l[spriteName].z]
    for k,v in pairs(z) do
        if v == l[spriteName] then z[k] = nil end
    end
    --
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
    --
    local addZ = true
    for k,v in pairs(self.zValue) do
        if v == sprite.z then addZ = false end
    end
    if addZ then self.zValue[#self.zValue+1] = sprite.z end
    if addZ then self.zLayer[sprite.z] = {} end
    --
    local z = self.zLayer[sprite.z]
    z[#z+1] = sprite
    --
    self.zValue = sortFunc.sortTable(self.zValue, function (a,b) return a < b end)
    -- self.sort[layer]    = sortFunc.sortTable(l, function (a,b) return a.z < b.z end)
    return l[spriteName]
end

function LayerManager:sortSprite(layer)
    -- local l = self.layer[layer]
    -- self.zValue = sortFunc.sortTable(self.zValue, function (a,b) return a < b end)
end

function LayerManager:correctLayer()
    for k,v in pairs(self.zLayer) do
        for i,j in pairs(v) do
            if j.z ~= k then
                v[i] = nil
                --
                local addZ = true
                for u,x in pairs(self.zValue) do
                    if x == j.z then addZ = false end
                end
                if addZ then self.zValue[#self.zValue+1] = j.z end
                if addZ then self.zLayer[j.z] = {} end
                --
                local z = self.zLayer[j.z]
                z[#z+1] = j
                --
                self.zValue = sortFunc.sortTable(self.zValue, function (a,b) return a < b end)
            end
        end
    end
end

function LayerManager:draw(layer)
    if self.sort[layer] == nil then self.sort[layer] = {} end
    --
    local l = self.sort[layer]
    for i,s in pairs(l) do s:draw() end
end

function LayerManager:drawAll()
    self:correctLayer()
    for k,v in pairs(self.zValue) do
        local layer = self.zLayer[v]
        for i,s in pairs(layer) do s:draw() end
    end
    -- for k,v in pairs(self.layer) do
    --     self:draw(k)
    -- end
end

function LayerManager:update(layer, dt)
    if self.layer[layer] == nil then self.layer[layer] = {} end
    --
    local l = self.layer[layer]
    for i,s in pairs(l) do
        s:updateBase(dt)
        s:update(dt)
    end
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

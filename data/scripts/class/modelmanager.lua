-- singleton
ModelManager = class(Object)
ModelManager.types = {}
ModelManager.garbage = {}

function ModelManager:clearAll()
    for k,v in pairs(self.types) do
        for i,s in pairs(v) do
            s:destroy()
            v[i] = nil
        end
        self.types[k] = nil
    end
end

function ModelManager:addModel(type, modelName, modelClass, ...)
    if self.types[type] == nil then self.types[type] = {} end
    --
    local t = self.types[type]
    local model = modelClass:new(...)
    if t[modelName] then modelName = modelName..tostring(model) end
    t[modelName] = model
    return t[modelName]
end

function ModelManager:getModel(type, name)
    if self.types[type] == nil then self.types[type] = {} end
    --
    local result = {}
    if name then
        if type == "playerCharacter" and not self.types[type][name] then
            return self.garbage[name]
        end
        return self.types[type][name]
    end
    for k,v in pairs(self.types[type]) do
        if not v.destroyed then result[#result + 1] = v end
    end
    return result
end

function ModelManager:getModelCount(type)
    if self.types[type] == nil then self.types[type] = {} end
    local result = 0
    for k,v in pairs(self.types[type]) do
        result = result + 1
    end
    return result
end

function ModelManager:getModelArray(type)
    if self.types[type] == nil then self.types[type] = {} end
    --
    local t = self.types[type]
    local result = {}
    --
    for k,v in pairs(t) do
        if not v.destroyed then
            if v.x >= 0 and v.x <= 640 and v.y >= 0 and v.y <= 640 then
                result[#result+1] = v
            end
        end
    end
    --
    return result
end

function ModelManager:update()
    self:garbageCollect()
    self:updateModels()
end

function ModelManager:garbageCollect()
    for k,v in pairs(self.types) do
        for i,m in pairs(v) do
            if m.destroyed then
                if k == "playerCharacter" then
                    self.garbage[i] = m
                end
                v[i] = nil
            end
        end
    end
end

function ModelManager:updateModels()
    for k,v in pairs(self.types) do
        for i,m in pairs(v) do
            m:update()
        end
    end
end

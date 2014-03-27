-- singleton
ModelManager = class(Object)
ModelManager.types = {}

function ModelManager:addModel(type, modelName, modelClass, ...)
    if self.types[type] == nil then self.types[type] = {} end
    --
    local t = self.types[type]
    t[modelName] = modelClass:new(...)
    return t[modelName]
end

function ModelManager:getModel(type)
    if self.types[type] == nil then self.types[type] = {} end
    --
    local result = {}
    for k,v in pairs(self.types[type]) do
        if not v.destroyed then result[#result + 1] = v end
    end
    return result
end

function ModelManager:update()
    self:garbageCollect()
    self:updateModels()
end

function ModelManager:garbageCollect()
    for k,v in pairs(self.types) do
        for i,m in pairs(v) do
            if m.destroyed then v[i] = nil end
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
-- Lua Class/Object
-- Dr Yami
 
-- introduction:
-- this provides object-oriented feature, it has class and object
-- follows prototype-based programming (class/object inherits from object)
 
-- instruction:
-- newClass = class(baseClass)
-- this will create a new class inherit from BaseClass. the root of class
-- is Object, so to create new class inherit from none, use class(Object)
-- ====
-- newObject = createdClass:new(params)
-- create a new object inherit from a class, params will be passed to initialize method
-- ====
-- method Object:init(...)
-- initialize method, will be called when a new object is created
-- ====
-- method Object:is_a(class)
-- return boolean if object inherits from a class or not
-- ====
-- method Object:clone()
-- return a clone object
 
-- initialize metatable
Object = {}
Object.__index = Object
 
-- new instance, can be object or class
function Object:newInstance()
    -- create new object or class
    local obj = setmetatable({}, self)
    self.__index = self
    -- is_a setup
    obj.inherit = {}
    obj.inherit[self] = true
    if not self.inherit then self.inherit = {} end
    for k,v in pairs(self.inherit) do
        obj.inherit[k] = true
    end
    -- class setup
    obj.class = self
    -- return object
    return obj
end
 
-- new object, also call initialize method
function Object:new(...)
    -- create new instance
    local obj = self:newInstance()
    -- call init method
    obj:init(...)
    -- return object
    return obj
end
 
-- initialize method, call each time an object is created
function Object:init()
    -- reserved
end
 
-- check if object inherits any class or object
function Object:is_a(class)
    return self.inherit[class]
end
 
-- deep clone an object or a class
function Object:clone()
    local obj = self.class:new()
    for k, v in pairs(self) do
        obj[k] = v
    end
    return obj
end
 
-- function to create a new class or object
-- call class(Object) to create a new class that inherits none
function class(parent)
    local cls = parent:newInstance()
    cls.__index = parent
    -- setup super class
    cls.super = parent
    -- return class
    return cls
end
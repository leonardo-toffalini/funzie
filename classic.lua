---@class Object
local Object = {}
Object.__index = Object

--- Constructor
function Object:new()
end

--- Inheritance
---@return table
function Object:extend()
  local cls = {}
  for k, v in pairs(self) do
    if k:find("__") == 1 then
      cls[k] = v
    end
  end
  cls.__index = cls
  cls.super = self
  setmetatable(cls, self)
  return cls
end

---@param ... unknown
function Object:implement(...)
  for _, cls in pairs({...}) do
    for k, v in pairs(cls) do
      if self[k] == nil and type(v) == "function" then
        self[k] = v
      end
    end
  end
end

---@param T any
---@return boolean
function Object:is(T)
  local mt = getmetatable(self)
  while mt do
    if mt == T then
      return true
    end
    mt = getmetatable(mt)
  end
  return false
end

---@return string
function Object:__tostring()
  return "Object"
end

--- Instantiation
---@param ... unknown
---@return Object
function Object:__call(...)
  local obj = setmetatable({}, self)
  obj:new(...)
  return obj
end

return Object

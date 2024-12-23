local Object = require("classic")

---@alias edge integer[]

---@class Shape: Object
---@field points Point3D[]: The vertices of the shape
---@field edges edge[]: The edges of the shape,
--- for example {{1, 2}, {1, 3}, {2, 3}} means that vertices 1-2, 1-3, and 2-3 are connected, forming a triangle
local Shape = Object:extend()

--- Constructor for the Shape class
function Shape:new()
  self.points = {}
  self.edges = {}
end

--- Rotates a Shape class in three dimensions
---@param alpha number: Rotation along the x-axis, in radians
---@param beta number: Rotation along the y-axis, in radians
---@param gamma number: Rotation along the z-axis, in radians
---@param dt number: Delta time, this is used to make the rendering framerate independent
function Shape:rotate(alpha, beta, gamma, dt)
  for i = 1, #self.points, 1 do
    self.points[i]:rotate(alpha, beta, gamma, dt)
  end
end

--- Draw only the points of the shape to the screen
---@param fov integer: Field of view, that is how for the screen is from the imaginary camera lense
---@param scale integer: How much the projection should be scaled up or down
function Shape:drawPoints(fov, scale)
  for _, p in ipairs(self.points) do
    local pp = p:project(fov, scale)
    love.graphics.points(pp.x, pp.y)
  end
end

--- Draw only the edges of the shape to the screen
---@param fov integer: Field of view, that is how for the screen is from the imaginary camera lense
---@param scale integer: How much the projection should be scaled up or down
function Shape:drawEdges(fov, scale)
  for _, edge in ipairs(self.edges) do
    local start, finish = self.points[edge[1]], self.points[edge[2]]
    local pp_start = start:project(fov, scale)
    local pp_finish = finish:project(fov, scale)
    love.graphics.line(pp_start.x, pp_start.y, pp_finish.x, pp_finish.y)
  end
end

--- Draw the shape to the screen
---@param mode "points" | "edges" | "all": Draw mode, "all" means both points and edges will be drawn
---@param fov integer: Field of view, that is how for the screen is from the imaginary camera lense
---@param scale integer: How much the projection should be scaled up or down
function Shape:draw(mode, fov, scale)
  if mode == "points" then self:drawPoints(fov, scale) end
  if mode == "edges" then self:drawEdges(fov, scale) end
  if mode == "all" then
    self:drawEdges(fov, scale)
    self:drawPoints(fov, scale)
  end
end

return Shape

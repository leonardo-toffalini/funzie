local Object = require("classic")
local Shape = Object:extend()

function Shape:new()
  self.points = {}
  self.edges = {}
end

function Shape:rotate(alpha, beta, gamma, dt)
  for i = 1, #self.points, 1 do
    self.points[i]:rotate(alpha, beta, gamma, dt)
  end
end

function Shape:drawPoints(fov, scale)
  for _, p in ipairs(self.points) do
    local pp = p:project(fov, scale)
    love.graphics.points(pp.x, pp.y)
  end
end

function Shape:drawEdges(fov, scale)
  for _, edge in ipairs(self.edges) do
    local start, finish = self.points[edge[1]], self.points[edge[2]]
    local pp_start = start:project(fov, scale)
    local pp_finish = finish:project(fov, scale)
    love.graphics.line(pp_start.x, pp_start.y, pp_finish.x, pp_finish.y)
  end
end

function Shape:draw(mode, fov, scale)
  if mode == "points" then self:drawPoints(fov, scale) end
  if mode == "edges" then self:drawEdges(fov, scale) end
  if mode == "all" then 
    self:drawEdges(fov, scale)
    self:drawPoints(fov, scale)
  end
end

return Shape

local Shape = require("shape")
local Point = require("point")
local Tetrahedron = Shape:extend()

function Tetrahedron:new()
  self.points = {}
  self.points[#self.points+1] = Point(1, 1, 1)
  self.points[#self.points+1] = Point(1, -1, -1)
  self.points[#self.points+1] = Point(-1, 1, -1)
  self.points[#self.points+1] = Point(-1, -1, 1)

  -- every vertex is connected to every other vertex (4 choose 2)
  self.edges = {{1, 2}, {1, 3}, {1, 4}, {2, 3}, {2, 4}, {3, 4}}
end

return Tetrahedron

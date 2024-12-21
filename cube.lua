local Shape = require("shape")
local Point = require("point")
local Cube = Shape:extend()

function Cube:new()
  self.points = {}
  self.points[#self.points+1] = Point(1, 1, 1)
  self.points[#self.points+1] = Point(1, 1, -1)
  self.points[#self.points+1] = Point(1, -1, 1)
  self.points[#self.points+1] = Point(1, -1, -1)
  self.points[#self.points+1] = Point(-1, 1, 1)
  self.points[#self.points+1] = Point(-1, 1, -1)
  self.points[#self.points+1] = Point(-1, -1, 1)
  self.points[#self.points+1] = Point(-1, -1, -1)

  self.edges = {
    {1, 2}, {3, 4}, {5, 6}, {7, 8},
    {1, 3}, {2, 4}, {3, 7}, {4, 8},
    {5, 7}, {6, 8}, {1, 5}, {2, 6}
  }
end

return Cube


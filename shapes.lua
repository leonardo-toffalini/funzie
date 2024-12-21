local Shape = require("shape")
local Point = require("point")
local Cube = Shape:extend()
local Tetrahedron = Shape:extend()
local Octahedron = Shape:extend()
local Icosahedron = Shape:extend()

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

function Tetrahedron:new()
  self.points = {}
  self.points[#self.points+1] = Point(1, 1, 1)
  self.points[#self.points+1] = Point(1, -1, -1)
  self.points[#self.points+1] = Point(-1, 1, -1)
  self.points[#self.points+1] = Point(-1, -1, 1)

  -- every vertex is connected to every other vertex (4 choose 2)
  self.edges = {{1, 2}, {1, 3}, {1, 4}, {2, 3}, {2, 4}, {3, 4}}
end

function Octahedron:new()
  self.points = {}
  self.points[#self.points+1] = Point(0, 0, 1)
  self.points[#self.points+1] = Point(0, 0, -1)
  self.points[#self.points+1] = Point(-1, 0, 0)
  self.points[#self.points+1] = Point(1, 0, 0)
  self.points[#self.points+1] = Point(0, -1, 0)
  self.points[#self.points+1] = Point(0, 1, 0)

  self.edges = {
    {1, 3}, {1, 4}, {1, 5}, {1, 6},
    {2, 3}, {2, 4}, {2, 5}, {2, 6},
    {4, 5}, {3, 5}, {3, 6}, {4, 6}
  }
end

function Icosahedron:new()
  local t = (-1 + math.sqrt(5)) / 2  -- golden ratio
  self.points = {}
  self.points[#self.points+1] = Point(1, 0, t)
  self.points[#self.points+1] = Point(1, 0, -t)
  self.points[#self.points+1] = Point(-1, 0, t)
  self.points[#self.points+1] = Point(-1, 0, -t)
  self.points[#self.points+1] = Point(0, t, 1)
  self.points[#self.points+1] = Point(0, -t, 1)
  self.points[#self.points+1] = Point(0, t, -1)
  self.points[#self.points+1] = Point(0, -t, -1)
  self.points[#self.points+1] = Point(t, 1, 0)
  self.points[#self.points+1] = Point(-t, 1, 0)
  self.points[#self.points+1] = Point(t, -1, 0)
  self.points[#self.points+1] = Point(-t, -1, 0)

  self.edges = {
    -- upper pentagon
    {1, 2}, {1, 5}, {1, 6}, {1, 9}, {1, 11},
    {2, 9}, {2, 11}, {5, 6}, {5, 9}, {6, 11},
    -- lower pentagon
    {4, 3}, {4, 7}, {4, 8}, {4, 10}, {4, 12},
    {3, 10}, {3, 12}, {7, 10}, {7, 8}, {8, 12},
    -- connecting strip
    {2, 7}, {7, 9}, {9, 10}, {10, 5}, {5, 3},
    {3, 6}, {6, 12}, {12, 11}, {11, 8}, {8, 2}
  }
end

local shapes = {Cube = Cube, Tetrahedron = Tetrahedron, Octahedron = Octahedron, Icosahedron = Icosahedron}
return shapes

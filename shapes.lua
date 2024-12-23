local Shape = require("shape")
local Point = require("point")

---@class Cube: Shape
local Cube = Shape:extend()

---@class Tetrahedron: Shape
local Tetrahedron = Shape:extend()

---@class Octahedron: Shape
local Octahedron = Shape:extend()

---@class Icosahedron: Shape
local Icosahedron = Shape:extend()

---@class Dodecahedron: Shape
local Dodecahedron = Shape:extend()


--- Constructor for the Cube class
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

  self.faces = {
    {color = {0.7, 0, 0}, points = {1, 2, 4, 3}},
    {color = {0.7, 0, 0}, points = {5, 6, 8, 7}},
    {color = {0, 0.7, 0}, points = {3, 4, 8, 7}},
    {color = {0, 0.7, 0}, points = {1, 2, 6, 5}},
    {color = {0, 0, 0.7}, points = {1, 3, 7, 5}},
    {color = {0, 0, 0.7}, points = {2, 4, 8, 6}}
  }
end

--- Constructor for the Tetrahedron class
function Tetrahedron:new()
  self.points = {}
  self.points[#self.points+1] = Point(1, 1, 1)
  self.points[#self.points+1] = Point(1, -1, -1)
  self.points[#self.points+1] = Point(-1, 1, -1)
  self.points[#self.points+1] = Point(-1, -1, 1)

  -- every vertex is connected to every other vertex (4 choose 2)
  self.edges = {{1, 2}, {1, 3}, {1, 4}, {2, 3}, {2, 4}, {3, 4}}

  self.faces = {
    {color = {0.7, 0, 0}, points = {1, 2, 3}},
    {color = {0, 0.7, 0}, points = {1, 2, 4}},
    {color = {0, 0, 0.7}, points = {1, 3, 4}},
    {color = {0.7, 0.7, 0}, points = {2, 3, 4}},
  }
end

--- Constructor for the Octahedron class
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

  self.faces = {
    {color = {0.7, 0, 0}, points = {1, 3, 5}},
    {color = {0, 0.7, 0}, points = {1, 3, 6}},
    {color = {0, 0, 0.7}, points = {1, 4, 5}},
    {color = {0.7, 0.7, 0}, points = {1, 4, 6}},
    {color = {0.7, 0, 0}, points = {2, 4, 6}},
    {color = {0, 0.7, 0}, points = {2, 3, 5}},
    {color = {0, 0, 0.7}, points = {2, 3, 6}},
    {color = {0.7, 0.7, 0}, points = {2, 4, 5}},
  }
end

--- Constructor for the Icosahedron class
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
    -- upper pentagonal
    {1, 2}, {1, 5}, {1, 6}, {1, 9}, {1, 11},
    {2, 9}, {2, 11}, {5, 6}, {5, 9}, {6, 11},
    -- lower pentagonal
    {4, 3}, {4, 7}, {4, 8}, {4, 10}, {4, 12},
    {3, 10}, {3, 12}, {7, 10}, {7, 8}, {8, 12},
    -- connecting strip
    {2, 7}, {7, 9}, {9, 10}, {10, 5}, {5, 3},
    {3, 6}, {6, 12}, {12, 11}, {11, 8}, {8, 2}
  }
end

--- Constructor for the Dodecahedron class
function Dodecahedron:new()
  local t = (-1 + math.sqrt(5)) / 2  -- golden ratio
  self.points = {}
  -- inscribed cube vertices
  self.points[#self.points+1] = Point(1, 1, 1)
  self.points[#self.points+1] = Point(1, 1, -1)
  self.points[#self.points+1] = Point(1, -1, 1)
  self.points[#self.points+1] = Point(1, -1, -1)
  self.points[#self.points+1] = Point(-1, 1, 1)
  self.points[#self.points+1] = Point(-1, 1, -1)
  self.points[#self.points+1] = Point(-1, -1, 1)
  --
  self.points[#self.points+1] = Point(-1, -1, -1)
  self.points[#self.points+1] = Point(t, 0, 1/t)
  self.points[#self.points+1] = Point(t, 0, -1/t)
  self.points[#self.points+1] = Point(-t, 0, 1/t)
  self.points[#self.points+1] = Point(-t, 0, -1/t)
  self.points[#self.points+1] = Point(0, 1/t, t)
  self.points[#self.points+1] = Point(0, -1/t, t)
  self.points[#self.points+1] = Point(0, 1/t, -t)
  self.points[#self.points+1] = Point(0, -1/t, -t)
  self.points[#self.points+1] = Point(1/t, t, 0)
  self.points[#self.points+1] = Point(-1/t, t, 0)
  self.points[#self.points+1] = Point(1/t, -t, 0)
  self.points[#self.points+1] = Point(-1/t, -t, 0)

  self.edges = {
    -- upper pentagon
    {1, 9}, {1, 17}, {9, 3}, {3, 19}, {17, 19},
    -- lower pentagon
    {20, 18}, {20, 8}, {8, 12}, {12, 6}, {18, 6},
    -- strip
    {2, 10}, {10, 4}, {4, 16}, {16, 14}, {14, 7},
    {7, 11}, {11, 5}, {5, 13}, {13, 15}, {15, 2},
    -- connecting the strip to the pentagons
    {2, 17}, {10, 12}, {4, 19}, {16, 8}, {14, 3},
    {7, 20}, {11, 9}, {5, 18}, {13, 1}, {15, 6}
  }

  self.faces = {
    {color = {0.7, 0, 0}, points = {1, 9, 3, 19, 17}},
    {color = {0, 0, 0.7}, points = {6, 12, 8, 20, 18}},
    {color = {0, 0, 0.7}, points = {2, 10, 4, 19, 17}},
    {color = {0, 0.7, 0}, points = {17, 2, 15, 13, 1}},
    {color = {0.7, 0.7, 0}, points = {5, 13, 1, 9, 11}},
    {color = {0, 0.7, 0}, points = {7, 20, 18, 5, 11}},
    {color = {0.7, 0, 0}, points = {18, 6, 15, 13, 5}},
    {color = {0.7, 0.7, 0}, points = {7, 20, 8, 16, 14}},
    {color = {0, 0, 0.7}, points = {3, 9, 11, 7, 14}},
    {color = {0, 0.7, 0}, points = {3, 14, 16, 4, 19}},
    {color = {0.7, 0, 0}, points = {16, 4, 10, 12, 8}},
    {color = {0.7, 0.7, 0}, points = {15, 2, 10, 12, 6}},
  }
end

local shapes = {
  Cube = Cube, Tetrahedron = Tetrahedron, Octahedron = Octahedron,
  Icosahedron = Icosahedron, Dodecahedron = Dodecahedron
}
return shapes

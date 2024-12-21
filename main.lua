local shapes = require("shapes")
local width, height = love.graphics.getDimensions()

local fov = 10
local scale = 100
local alpha = math.pi / 16
local beta = math.pi / 32
local gamma = math.pi / 64

local shape = nil

function love.load(args)
  shapeInput = args[1]
  if shapeInput == "cube" or shapeInput == "6" then shape = shapes.Cube()
  elseif shapeInput == "tetrahedron" or shapeInput == "4" then shape = shapes.Tetrahedron()
  elseif shapeInput == "octahedron" or shapeInput == "8" then shape = shapes.Octahedron()
  elseif shapeInput == "icosahedron" or shapeInput == "20" then shape = shapes.Icosahedron()
  elseif shapeInput == "dodecahedron" or shapeInput == "12" then shape = shapes.Dodecahedron()
  else
    print("Not recognized shape input: " .. shapeInput)
    print("Available shapes:\n\tcube (6), tetrahedron (4), octahedron (8), icosahedron (20), dodecahedron (12)")
    os.exit()
  end

end

function love.update(dt)
  if shape ~= nil then
    shape:rotate(alpha, beta, gamma, dt)
  end
end

function love.draw()
  love.graphics.translate(width / 2, height / 2)
  if shape ~= nil then
    shape:draw("all", fov, scale)
  end
end

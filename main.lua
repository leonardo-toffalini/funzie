local shapes = require("shapes")
local cli = require("cli")
local width, height = love.graphics.getDimensions()

local fov = 10
local scale = 100
local alpha = math.pi / 16
local beta = math.pi / 32
local gamma = math.pi / 64
local shape = nil

local params = {
  {name = "shape", desc = "The shape to be rendered in 3D.", default = "cube"}
}

function love.load(args)
  local parsedArgs = cli.parse(params, args)
  if parsedArgs.shape == "cube" or parsedArgs.shape == "6" then shape = shapes.Cube()
  elseif parsedArgs.shape == "tetrahedron" or parsedArgs.shape == "4" then shape = shapes.Tetrahedron()
  elseif parsedArgs.shape == "octahedron" or parsedArgs.shape == "8" then shape = shapes.Octahedron()
  elseif parsedArgs.shape == "icosahedron" or parsedArgs.shape == "20" then shape = shapes.Icosahedron()
  elseif parsedArgs.shape == "dodecahedron" or parsedArgs.shape == "12" then shape = shapes.Dodecahedron()
  else
    print("Not recognized shape input: " .. parsedArgs.shape)
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

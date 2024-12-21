local shapes = require("shapes")
local width, height = love.graphics.getDimensions()

local fov = 10
local scale = 100
local alpha = math.pi / 16
local beta = math.pi / 32
local gamma = math.pi / 64

local shape = shapes.Icosahedron()

function love.load(args)
  for i = 1, #args do
    print(args[i])
  end
end

function love.update(dt)
  shape:rotate(alpha, beta, gamma, dt)
end

function love.draw()
  love.graphics.translate(width / 2, height / 2)
  shape:draw("all", fov, scale)
end

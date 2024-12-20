local fun = require("fun")
local width, height = love.graphics.getDimensions()

local fov = 10
local alpha = math.pi / 16
local beta = math.pi / 32
local gamma = math.pi / 64

local cube = fun.createUnitCube()

function love.update(dt)
  fun.rotateShape(cube, alpha, beta, gamma, dt)
end

function love.draw()
  love.graphics.translate(width / 2, height / 2)
  fun.drawEdges(cube, fov)
end

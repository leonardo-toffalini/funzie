local Cube = require("cube")
local width, height = love.graphics.getDimensions()

local fov = 10
local scale = 100
local alpha = math.pi / 16
local beta = math.pi / 32
local gamma = math.pi / 64

local cube = Cube()

function love.update(dt)
  cube:rotate(alpha, beta, gamma, dt)
end

function love.draw()
  love.graphics.translate(width / 2, height / 2)
  cube:draw(fov, scale)
end

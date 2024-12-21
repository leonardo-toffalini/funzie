local Object = require("classic")
local Point = Object:extend()

local sin = math.sin
local cos = math.cos

function Point:new(x, y, z)
  self.x = x
  self.y = y
  self.z = z
end

function Point:rotate(alpha, beta, gamma, dt)
  alpha = alpha * dt
  beta = beta * dt
  gamma = gamma * dt
  local newX = self.x * (cos(alpha) * cos(beta)) + self.y * (sin(alpha) * cos(beta)) - self.z * sin(beta)
  local newY = self.x * (cos(alpha) * sin(beta) * sin(gamma) - sin(alpha) * cos(gamma)) + self.y * (sin(alpha) * sin(beta) * sin(gamma) + cos(alpha) * cos(gamma)) + self.z * cos(beta) * sin(gamma)
  local newZ = self.x * (cos(alpha) * sin(beta) * cos(gamma) + sin(alpha) * sin(gamma)) + self.y * (sin(alpha) * sin(beta) * cos(gamma) - cos(alpha) * sin(gamma)) + self.z * cos(beta) * cos(gamma)
  self.x = newX
  self.y = newY
  self.z = newZ
end

function Point:project(fov, scale)
  return {
    x = scale * (self.x * fov) / (self.z + fov),
    y = scale * (self.y * fov) / (self.z + fov)
  }
end

return Point

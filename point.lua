local Object = require("classic")

local sin = math.sin
local cos = math.cos

---@class (exact) Point2D
---@field x number: The x coordinate of the point
---@field y number: The y coordinate of the point
local Point2D

---@class (exact) Point3D
---@field x number: The x coordinate of the point
---@field y number: The y coordinate of the point
---@field z number: The z coordinate of the point
local Point3D = Object:extend()

--- Constructor for the Point3D class
---@param x number: The x coordinate of the point
---@param y number: The y coordinate of the point
---@param z number: The z coordinate of the point
function Point3D:new(x, y, z)
  self.x = x
  self.y = y
  self.z = z
end

--- Rotates a Point3D class in three dimension
---@param alpha number: Rotation along the x-axis, in radians
---@param beta number: Rotation along the y-axis, in radians
---@param gamma number: Rotation along the z-axis, in radians
---@param dt number: Delta time, this is used to make the rendering framerate independent
function Point3D:rotate(alpha, beta, gamma, dt)
  alpha = alpha * dt
  beta = beta * dt
  gamma = gamma * dt
  local newX = self.x * (cos(alpha) * cos(beta)) + self.y * (sin(alpha) * cos(beta)) - self.z * sin(beta)
  local newY =
    self.x * (cos(alpha) * sin(beta) * sin(gamma) - sin(alpha) * cos(gamma)) +
    self.y * (sin(alpha) * sin(beta) * sin(gamma) + cos(alpha) * cos(gamma)) +
    self.z * cos(beta) * sin(gamma)
  local newZ =
    self.x * (cos(alpha) * sin(beta) * cos(gamma) + sin(alpha) * sin(gamma)) +
    self.y * (sin(alpha) * sin(beta) * cos(gamma) - cos(alpha) * sin(gamma)) +
    self.z * cos(beta) * cos(gamma)

  self.x = newX
  self.y = newY
  self.z = newZ
end

--- Projects a Point3D to the screen, resulting in a Point2D
---@param fov integer: Field of view, that is how for the screen is from the imaginary camera lense
---@param scale integer: How much the projection should be scaled up or down
---@return Point2D
function Point3D:project(fov, scale)
  return {
    x = scale * (self.x * fov) / (self.z + fov),
    y = scale * (self.y * fov) / (self.z + fov)
  }
end

return Point3D

local width, height = love.graphics.getDimensions()

-- cube
local points = {}
points[#points+1] = {x = 1, y = 1, z = 1}
points[#points+1] = {x = 1, y = 1, z = -1}
points[#points+1] = {x = 1, y = -1, z = 1}
points[#points+1] = {x = 1, y = -1, z = -1}
points[#points+1] = {x = -1, y = 1, z = 1}
points[#points+1] = {x = -1, y = 1, z = -1}
points[#points+1] = {x = -1, y = -1, z = 1}
points[#points+1] = {x = -1, y = -1, z = -1}

local a = math.pi / 16
local b = math.pi / 32
local g = math.pi / 64

local fov = 10

local lines = {
  {1, 2}, {3, 4}, {5, 6}, {7, 8},
  {1, 3}, {2, 4}, {3, 7}, {4, 8},
  {5, 7}, {6, 8}, {5, 1}, {6, 2}
}

local sin = math.sin
local cos = math.cos

local function rotatePoint(p, alpha, beta, gamma, dt)
  alpha = alpha * dt
  beta = beta * dt
  gamma = gamma * dt
  local newX = p.x * (cos(alpha) * cos(beta)) + p.y * (sin(alpha) * cos(beta)) - p.z * sin(beta)
  local newY = p.x * (cos(alpha) * sin(beta) * sin(gamma) - sin(alpha) * cos(gamma)) + p.y * (sin(alpha) * sin(beta) * sin(gamma) + cos(alpha) * cos(gamma)) + p.z * cos(beta) * sin(gamma)
  local newZ = p.x * (cos(alpha) * sin(beta) * cos(gamma) + sin(alpha) * sin(gamma)) + p.y * (sin(alpha) * sin(beta) * cos(gamma) - cos(alpha) * sin(gamma)) + p.z * cos(beta) * cos(gamma)
  return {x = newX, y = newY, z = newZ}
end

local function projectPoint(p, f)
  return {
    x = 100 * (p.x * fov) / (p.z + f),
    y = 100 * (p.y * fov) / (p.z + f)
  }
end

function love.load()
end

function love.update(dt)
  for i = 1, #points, 1 do
    points[i] = rotatePoint(points[i], a, b, g, dt)
  end
end

function love.draw()
  love.graphics.translate(width / 2, height / 2)
  -- love.graphics.scale(100, 100)
  for _, point in ipairs(points) do
    local pp = projectPoint(point, fov)
    local px, py = pp.x, pp.y
    love.graphics.points(px, py)
  end
  for _, line in ipairs(lines) do
    local start, finish = points[line[1]], points[line[2]]
    local pp_start = projectPoint(start, fov)
    local pp_finish = projectPoint(finish, fov)
    love.graphics.line(pp_start.x, pp_start.y, pp_finish.x, pp_finish.y)
  end
end

local fun = {}

local sin = math.sin
local cos = math.cos

function fun.rotatePoint(p, alpha, beta, gamma, dt)
  alpha = alpha * dt
  beta = beta * dt
  gamma = gamma * dt
  local newX = p.x * (cos(alpha) * cos(beta)) + p.y * (sin(alpha) * cos(beta)) - p.z * sin(beta)
  local newY = p.x * (cos(alpha) * sin(beta) * sin(gamma) - sin(alpha) * cos(gamma)) + p.y * (sin(alpha) * sin(beta) * sin(gamma) + cos(alpha) * cos(gamma)) + p.z * cos(beta) * sin(gamma)
  local newZ = p.x * (cos(alpha) * sin(beta) * cos(gamma) + sin(alpha) * sin(gamma)) + p.y * (sin(alpha) * sin(beta) * cos(gamma) - cos(alpha) * sin(gamma)) + p.z * cos(beta) * cos(gamma)
  return {x = newX, y = newY, z = newZ}
end

function fun.projectPoint(p, fov)
  -- multiply by 100 to scale up the projected points
  -- this way we can see a unit cube in a manageable size
  return {
    x = 100 * (p.x * fov) / (p.z + fov),
    y = 100 * (p.y * fov) / (p.z + fov)
  }
end

function fun.rotateShape(shape, alpha, beta, gamma, dt)
  for i = 1, #shape.points, 1 do
    shape.points[i] = fun.rotatePoint(shape.points[i], alpha, beta, gamma, dt)
  end
end

function fun.drawPoints(shape, fov)
  for _, p in ipairs(shape.points) do
    local pp = fun.projectPoint(p, fov)
    love.graphics.points(pp.x, pp.y)
  end
end

function fun.drawEdges(shape, fov)
  for _, edge in ipairs(shape.edges) do
    local start, finish = shape.points[edge[1]], shape.points[edge[2]]
    local pp_start = fun.projectPoint(start, fov)
    local pp_finish = fun.projectPoint(finish, fov)
    love.graphics.line(pp_start.x, pp_start.y, pp_finish.x, pp_finish.y)
  end
end

function fun.createUnitCube()
  local points = {}
  points[#points+1] = {x = 1, y = 1, z = 1}
  points[#points+1] = {x = 1, y = 1, z = -1}
  points[#points+1] = {x = 1, y = -1, z = 1}
  points[#points+1] = {x = 1, y = -1, z = -1}
  points[#points+1] = {x = -1, y = 1, z = 1}
  points[#points+1] = {x = -1, y = 1, z = -1}
  points[#points+1] = {x = -1, y = -1, z = 1}
  points[#points+1] = {x = -1, y = -1, z = -1}

  local edges = {
    {1, 2}, {3, 4}, {5, 6}, {7, 8},
    {1, 3}, {2, 4}, {3, 7}, {4, 8},
    {5, 7}, {6, 8}, {1, 5}, {2, 6}
  }

  return {points = points, edges = edges}
end

return fun

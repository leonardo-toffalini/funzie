local Object = require("classic")

---@alias edge integer[] For example, {1, 2} means the first and second point are connected by an edge
---@alias face {color: integer[], points: integer[]}
--- For example, {color: {1, 0, 0}, points: {1, 2,, 3}} means the the first three points are connected forming a red triangle

---@class Shape: Object
---@field points Point3D[] The vertices of the shape
---@field edges edge[] The edges of the shape,
---@field faces face[]
local Shape = Object:extend()

--- Constructor for the Shape class
function Shape:new()
  self.points = {}
  self.edges = {}
  self.faces = {}
end

--- Helper function to calculate the maximal z value of an array of 3D points
---@param points3d Point3D[]
---@return number?
local function minZ(points3d)
  if #points3d == 0 then return nil end
  local currMin = points3d[1].z
  for _, point in ipairs(points3d) do
    currMin = math.min(currMin, point.z)
  end
  return currMin
end

--- Sort the faces of a shape based on the face's maximal z value
--- TODO: Definetely has some bugs
---@return {index: integer, z: number}
function Shape:sortFaces()
  local absoluteFaces = {}
  for i, face in ipairs(self.faces) do
    local points3d = {}
    for _, idx in ipairs(face.points) do points3d[#points3d+1] = self.points[idx] end
    absoluteFaces[#absoluteFaces+1] = {index = i, z = minZ(points3d)}
  end

  table.sort(absoluteFaces, function(left, right)
    return left.z > right.z
  end)

  return absoluteFaces
end

--- Rotates a Shape class in three dimensions
---@param alpha number Rotation along the x-axis, in radians
---@param beta number Rotation along the y-axis, in radians
---@param gamma number Rotation along the z-axis, in radians
---@param dt number Delta time, this is used to make the rendering framerate independent
function Shape:rotate(alpha, beta, gamma, dt)
  for i = 1, #self.points, 1 do
    self.points[i]:rotate(alpha, beta, gamma, dt)
  end
end

--- Draw only the points of the shape to the screen
---@param fov integer Field of view, that is how for the screen is from the imaginary camera lense
---@param scale integer How much the projection should be scaled up or down
function Shape:drawPoints(fov, scale)
  for _, p in ipairs(self.points) do
    local pp = p:project(fov, scale)
    love.graphics.push()
    love.graphics.setColor(1, 0, 0)
    love.graphics.points(pp.x, pp.y)
    love.graphics.pop()
  end
end

--- Draw only the edges of the shape to the screen
---@param fov integer Field of view, that is how for the screen is from the imaginary camera lense
---@param scale integer How much the projection should be scaled up or down
function Shape:drawEdges(fov, scale)
  for _, edge in ipairs(self.edges) do
    local start, finish = self.points[edge[1]], self.points[edge[2]]
    local pp_start = start:project(fov, scale)
    local pp_finish = finish:project(fov, scale)
    love.graphics.push()
    love.graphics.setColor(1, 1, 1)
    love.graphics.line(pp_start.x, pp_start.y, pp_finish.x, pp_finish.y)
    love.graphics.pop()
  end
end

--- Draw only the faces of the shape to the screen
---@param fov integer Field of view, that is how for the screen is from the imaginary camera lense
---@param scale integer How much the projection should be scaled up or down
function Shape:drawFaces(fov, scale)
  local absoluteFaces = self:sortFaces()

  for _, absFace in ipairs(absoluteFaces) do
    local poly = {}
    local face = self.faces[absFace.index]
    for _, vertexIdx in ipairs(face.points) do
      local pp = self.points[vertexIdx]:project(fov, scale)
      table.insert(poly, pp.x)
      table.insert(poly, pp.y)
    end
    love.graphics.push()
    love.graphics.setColor(face.color)
    love.graphics.polygon("fill", poly)
    love.graphics.pop()
  end
end

--- Draw the shape to the screen
---@param mode "points" | "edges" | "faces" | "all" Draw mode, "all" means both points and edges will be drawn
---@param fov integer Field of view, that is how for the screen is from the imaginary camera lense
---@param scale integer How much the projection should be scaled up or down
function Shape:draw(mode, fov, scale)
  if mode == "points" then self:drawPoints(fov, scale)
  elseif mode == "edges" then self:drawEdges(fov, scale)
  elseif mode == "faces" then self:drawFaces(fov, scale)
  elseif mode == "all" then
    self:drawEdges(fov, scale)
    self:drawFaces(fov, scale)
    self:drawPoints(fov, scale)
  else
    io.write(mode .. ' is not a valid drawing mode.\n\tPossible values for mode: "points", "edges", "all"\n')
    os.exit(1)
  end
end

return Shape

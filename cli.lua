local cli = {}

-- example params:
-- local params = {
--   {name = "shape", desc = "The shape to be rendered in 3D.", default = "cube"}
-- }

local function startsWith(str, start)
  return str:sub(1, #start) == start
end

local function isValidParam(params, arg)
  for _, param in ipairs(params) do
    if param.name == arg then return true end
  end
  return false
end

local function listParams(params)
  io.write("Available options:\n")
  for _, param in ipairs(params) do
    if param.default then
      io.write("name: " .. param.name .. "\tdescription: " .. param.desc .. "\tdefault: " .. param.default .. "\n")
    else
      io.write("name: " .. param.name .. "\tdescription: " .. param.desc .. "\n")
    end
  end
end

local function defaultValues(params)
  local parsedArgs = {}

  for _, param in ipairs(params) do
    if param.default then
      parsedArgs[param.name] = param.default
    end
  end

  return parsedArgs
end

function cli.parse(params, args)
  local parsedArgs = defaultValues(params)
  local currOption = nil
  local nextIsValue = false

  for _, arg in ipairs(args) do
    if startsWith(arg, "--") then
      currOption = arg:sub(3, #arg)
      nextIsValue = true
    elseif nextIsValue then
      if isValidParam(params, currOption) then
        parsedArgs[currOption] = arg
      else
        print(currOption .. " is not a valid parameter.")
        listParams(params)
        os.exit(1)
      end
      nextIsValue = false
    else
      print("Unrecognized option: " .. arg)
      listParams(params)
      os.exit(1)
    end
  end
  return parsedArgs
end

return cli

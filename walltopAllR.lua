local targs = {...}
local forwardDist = 3
local branchSize = 15
local numTries = 3

if not os.loadAPI("turtleEx") then
  error("Could not load required api.")
  return
end

-- args {forwardDist, rightDist, numtries}
local function usage()
  print("Usage")
  print("  walltopAllR <forwardDist> <right> <num tries>")
end

if (targs[1] == "help") or (targs[1] == "?") then
  usage()
  return
end


-- get the number of blocks forward (>= 1)
if targs[1] ~= nil then
  forwardDist = tonumber(targs[1])
end

if forwardDist < 1 then
  error("Invalid distance forward (n >= 1): " .. forwardDist)
  return
end


-- get the number of blocks right (>= 1)
if targs[2] ~= nil then
  rightDist = tonumber(targs[2])
end

if rightDist < 1 then
  error("Invalid distance right (n >= 1): " .. rightDist)
  return
end


-- get the number of tries >= 1
if targs[3] ~= nil then
  numTries = tonumber(targs[3])
  if numTries < 1 then
    numTries = 5
  end
end

if numTries < 1 then
  error("Invalid number of tries: " .. numTries)
  return
end

print("Build a wall forward (" .. forwardDist .. ") and right (" .. rightDist .. "), trying max " .. numTries .. " times")
shell.run("walltop", forwardDist)
turtle.turnRight()
shell.run("walltop", rightDist)
turtle.turnRight()
shell.run("walltop", forwardDist)
turtle.turnRight()
shell.run("walltop", rightDist)
turtle.turnRight()


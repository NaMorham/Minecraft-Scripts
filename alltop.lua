local targs = {...}
local numLong = 9
local numWide = 9
local leftTurn = true
local direction = "left"
local numTries = 5

if not os.loadAPI("turtleEx.lua") then
  error("Could not load required api.")
  return
end

local function usage()
  print("Usage: ")
  print("   alltop <num blocks long> ")
  print("          <num blocks wide>")
  print("          <turn direction> ")
  print("          <num tries>")
  print(" ")
  print("By default; ")
  print("   width is " .. numWide .. ",")
  print("   length is " .. numWide .. ", ")
  print("   turn direction is " .. direction .. ", ")
  print("   number of tries is " .. numTries .. ". ")
  print(" ")
end

-- args {numLong, numWide, turn dir, numtries}
-- rely on the api to handle the number of tries

if #targs < 4 then 
  usage()
  return false
end

print("Parse length")
-- get the number of blocks >= 1
if targs[1] ~= nil then
  numLong = tonumber(targs[1])
  if numLong < 1 then
    numLong = 1
  end
end

if numLong < 1 then
  error("Invalid number of blocks: " .. numBranches)
  return
end


print("Parse width (in cycles - out and back)")
-- get the width >= 1
if targs[2] ~= nil then
  numWide = tonumber(targs[2])
  if numWide < 1 then
    numWide = 1
  end
end

if numWide < 1 then
  error("Invalid width: " .. numWide)
  return
end


-- get the direction
if targs[3] ~= nil then
  if targs[3] == "left" then
    leftTurn = true
    direction = "left"
  elseif targs[3] == "right" then
    leftTurn = false
    direction = "right"
  else
    error("Invalid turn direction: " .. targs[3])
    return
  end
end


-- get the number of tries >= 1
if targs[4] ~= nil then
  numTries = tonumber(targs[4])
  if numTries < 1 then
    numTries = 1
  end
end

if numTries < 1 then
  error("Invalid number of tries: " .. numTries)
  return
end

print("Top the wall, " .. numLong .. "x" .. numWide)
print(" turning " .. direction .. ", trying " .. numTries .. " times")

local function turnLeft()
  turtle.turnLeft()
  if not turtleEx.digForward(numTries) then
    error("Cannot clear forward when turning left")
    return false
  end

  return true
end

local function turnRight()
  turtle.turnRight()
  if not turtleEx.digForward(numTries) then
    error("Cannot clear forward when turning right")
    return false
  end

  return true
end

local nearTurn

if leftTurn == true then
  nearTurn = turnLeft
else
  nearTurn = turnRight
end


-- do the build
print("Run walltop " .. numLong)
shell.run("walltop", numLong)
turtle.forward()
nearTurn()

print("Run walltop " .. numWide)
shell.run("walltop", numWide)
turtle.forward()
nearTurn()

print("Run walltop " .. numLong)
shell.run("walltop", numLong)
turtle.forward()
nearTurn()

print("Run walltop " .. numWide)
shell.run("walltop", numWide)
turtle.forward()
nearTurn()


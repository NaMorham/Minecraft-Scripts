if not os.loadAPI("turtleEx.lua") then
  error("Could not load turtleEx API")
  return false
end


local targs = {...}

local totalHeight = 36
local gapWidth = 10
local gapLength = 10
local numTries = 5
local upDownStr = "down"
local isDown = true
local direction = "left"
-- enum { left = 0, right = 1, none = 2 }
local dirEnum = 0

--
-- temp values
--
-- steps dug in this leg
local stepCount = 0
local heightRem = totalHeight


local function usage()
  print("Usage:")
  print("  stairs <height> <width> ")
  print("      <length> <turn direction> ")
  print("      <up|down> <num tries>")
  print("Where:")
  print("   height = The num blocks vert")
  print("    width = The number of blocks across")
  print("   length = The number of blocks ahead")
  print("     turn = One of \"left\", \"right\" or \"none\"")
  print("  up|down = One of \"up\" or \"down\"")
  print("num tries = number of tries")
  print(" ")
end

print("Parse args...")

if (#targs < 1) then
  usage()
  return
end

if (targs[1] == "help") or (targs[1] == "?") then
  usage()
  return
end

print("Parse the total height")
-- get the totalHeight >= 1
if targs[1] ~= nil then
  totalHeight = tonumber(targs[1])
  if totalHeight < 1 then
    totalHeight = 1
  end
end

if totalHeight < 1 then
  error("Invalid number of blocks for height: " .. totalHeight)
  usage()
  return
end


print("Parse the width")
-- get the gapWidth >= 1
if targs[2] ~= nil then
  gapWidth = tonumber(targs[2])
  if gapWidth < 1 then
    gapWidth = 1
  end
end

if gapWidth < 1 then
  error("Invalid width: " .. gapWidth)
  usage()
  return
end


print("Parse the length")
-- get the gapLength >= 1
if targs[3] ~= nil then
  gapLength = tonumber(targs[3])
  if gapLength < 1 then
    gapLength = 1
  end
end

if gapLength < 1 then
  error("Invalid length: " .. gapLength)
  usage()
  return
end


print("Parse the turn direction")
-- get the turn direction
if targs[4] ~= nil then
  if targs[4] == "left" then
    dirEnum = 0
    direction = "left"
  elseif targs[4] == "right" then
    dirEnum = 1
    direction = "right"
  elseif targs[4] == "none" then
    dirEnum = 2
    direction = "none"
  else
    error("Invalid turn direction: " .. targs[4])
    usage()
    return
  end
end


print("Parse the vertical direction")
-- get the vertical direction
if targs[5] ~= nil then
  if targs[5] == "up" then
    isDown = false
    upDownStr = "up"
  elseif targs[5] == "down" then
    isDown = true
    upDownStr = "down"
  else
    error("Invalid vertical direction: " .. targs[5])
    usage()
    return
  end
end


print("Parse the number of tries")
-- get the number of tries
if targs[6] ~= nil then
  numTries = tonumber(targs[6])
  if numTries < 1 then
    numTries = 1
  end
end

if numTries < 1 then
  error("Invalid number of tries: " .. numTries)
  usage()
  return
end



-- Script main
print("stairs ")
print("            height = " .. totalHeight .. ", ")
print("             width = " .. gapWidth .. ", ")
print("            length = " .. gapLength .. ", ")
print("   turn direcction = " .. direction .. ", ")
print("vertical direction = " .. upDownStr .. ", ")
print("         num tries = " .. numTries)
print(" ")


local digVDist = 0
local digVDistTotal = 0
local digSideCount = 0


print("Configure the turn func")

-- turn functions
local function leftTurn()
  -- todo: add a torch
  return turtle.turnLeft()
end

local function rightTurn()
  -- todo: add a torch
  return turtle.turnRight()
end

local function nullTurn()
  -- todo: add a torch
  return true  
end

local turnFunc = nil
local revTurnFunc = nil

if (dirEnum == 0) then
  turnFunc = leftTurn
  revTurnFunc = rightTurn
elseif (dirEnum == 1) then
  turnFunc = rightTurn
  revTurnFunc = leftTurn
elseif (dirEnum == 2) then
  turnFunc = nullTurn
  revTurnFunc = nullTurn
else
  turnFunc = nullTurn
  revTurnFunc = nullTurn
  error("Invalid turn direction")
  return false
end

print("Configure the dig cycle")
-- dig cycle
local digCycle = nil

-- we dig forward, then clear up twice to make a 5 block high gap
local function digCycleRaw(numTries)
  -- move into position
  turtleEx.digForward(numTries)
  turtle.forward()

  -- dig below and place a block if needed
  turtleEx.digDown(numTries)
  turtle.down()
  if not turtle.detectDown() then
    turtleEx.placeDown(numTries)
  end
  turtle.up()
  
  for tmp = 1, 3 do
    turtleEx.digUp(numTries)
    turtle.up()
  end

  -- return to start height
  for tmp = 1, 3 do
    turtle.down()
  end  
end

local function digCycleDown(numTries)
  digCycleRaw(numTries)

  -- move down an extra step
  turtle.down()
end

local function digCycleUp(numTries)
  digCycleRaw(numTries)

  -- move up an extra step
  turtle.up()
end

-- work out which digCycle to use
if isDown then
  digCycle = digCycleDown
else
  digCycle = digCycleUp
end

-- one side
local function goBack(dist)
  for j = 1, dist do
    turtle.back()
    turtle.up()
  end
end

local function digSide(hDist, heightRem, numTries)
  stepCount = 0
  
  -- each "side" is the distance + 1
  for i = 1, hDist do
    if (digVDist >= heightRem) then
      -- we have reached our maximum so return
      goBack(stepCount)
      digvDist = digVDist - stepCount
      if (digSideCount >= 1) then
        goBackSides(digSideCount, digvDist)
      end
      turtle.back()
      return
    else
      digCycle(numTries)
      stepCount = stepCount + 1
      digVDist = digVDist + 1
      digVDistTotal = digVDist
    end
  end

  if (isDown) then
    turtle.up()
  else
    turtle.down()
  end

  digCycleRaw(numTries)
  turnFunc()
  digSideCount = digSideCount + 1
end



local function goBackSides(numSides, dist)
  print("TODO: go back multiple sides.")
  for k = 0, digSideCount do
    revTurnFunc()
    turtle.back()
    for m = 1, 3 do
      turtle.back()
      turtle.up()
    end
  end
end


-- main program --
local modVal = 1
local redLength = gapLength - 1
local redWidth = gapWidth-1

digCycleRaw(numTries)

while (digVDist < totalHeight) do
  modVal = digVDist % 2
  if modVal == 1 then
    digSide(redWidth, totalHeight, numTries)
  else
    digSide(redLength, totalHeight, numTries)
  end
end

turtle.back()

print("Done.")


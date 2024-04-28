local targs = {...}
local numLong = 9
local numWide = 9
local dist = 2
local numTries = 5
local selSlot = 1

if not os.loadAPI("turtleEx.lua") then
  error("Could not load required api.")
  return
end

turtle.select(selSlot)

local function placeBlock(numTries)
  print( "selSlot = " .. selSlot .. ", items = " .. turtle.getItemCount(selSlot) )
  
  local itemCount = turtle.getItemCount( selSlot )
  while itemCount < 1 do
    selSlot = selSlot + 1
    turtle.select(selSlot)
    itemCount = turtle.getItemCount( selSlot )
    if (selSlot > 12 ) then 
      print ( "No material to build with." )
      return false
    end
  end

  turtleEx.digDown(numTries)
  turtleEx.placeDown(numTries)
  
  return true
end

-- args {numLong, numWide, dist, numtries}
-- rely on the api to handle the number of tries

local function usage()
  print("Usage")
  print("  buildfloor <length> <width> ")
  print("             <dist> <num tries>")
end

if (targs[1] == "help") or (targs[1] == "?") then
  usage()
  return
end

-- length (distance in direction turtle is facing)
if targs[1] ~= nil then
  numLong = tonumber(targs[1])
  if numLong < 1 then
    numLong = 1
  end
end

-- width (distance perpendicular to direction turtle is facing)
if targs[2] ~= nil then
  numWide = tonumber(targs[2])
  if numWide < 1 then
    numWide = 1
  end
end

local shiftLeft = math.floor(numWide / 2)

-- dist (how many blocks to move away first)
if targs[3] ~= nil then
  dist = tonumber(targs[3])
  if dist < 1 then
    dist = 1
  end
end

-- numTries
if targs[4] ~= nil then
  numTries = tonumber(targs[4])
  if numTries < 1 then
    numTries = 1
  end
end

print("Build a " .. numLong .. "x" .. numWide .. " room " .. dist .. " blocks away.")
print("shiftLeft = " .. shiftLeft .. ". numTries = " .. numTries)

if dist > 1 then
  for i = 1, dist do
    if not turtleEx.digForward(numTries) then
      error("Could not dig forward")
      return false
    end
    turtle.forward()
  end
end

local lSide = numLong - 1
if lSide < 1 then
  lSide = 1
end

local wSide = numWide - 1
if wSide < 1 then
  wSide = 1
end

turtle.turnLeft()

for i = 1,shiftLeft do
  if not turtleEx.digForward(numTries) then
    error("Cannot dig")
    return false
  end
  turtle.forward()
end

turtle.turnRight()
turtle.turnRight()

for i = 1,numLong do
  for j = 1,wSide do
    print("Place block [" .. j .. "," .. i .. "]")
    
    if not turtleEx.digDown(numTries) then
      error("Cannot dig down")
      return false
    end
    if not placeBlock(numTries) then
      return false
    end

    if not turtleEx.digForward(numTries) then
      error("Cannot dig")
      return false
    end
    turtle.forward()
  end
  
  local modVal = i % 2
  if modVal == 0 then
    turtle.turnRight()
    turtleEx.digDown(numTries)
    if not placeBlock(numTries) then
      return false
    end
    if (i < numLong) then
      turtleEx.digForward(numTries)
      turtle.forward()
      turtleEx.digDown(numTries)
      turtle.turnRight()
    end
  else
    turtle.turnLeft()
    turtleEx.digDown(numTries)
    if not placeBlock() then
      return false
    end
    if (i < numLong) then
      turtleEx.digForward(numTries)
      turtle.forward()
      turtleEx.digDown(numTries)
      turtle.turnLeft()
    end
  end
end

-- return to start
turtle.turnLeft()
if not turtleEx.forward(shiftLeft) then
  error("cannot return")
  return false
end
turtle.turnLeft()

local returnDist = numLong+dist-1
if returnDist > 1 then
  if not turtleEx.forward(returnDist) then
    error("cannot return")
    return false
  end
end
turtleEx.turnLeft(2)

return true

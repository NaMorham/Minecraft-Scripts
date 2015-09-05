-- clear a tower
local targs = {...}
local numLong = 5
local numWide = 5
local height = 1
local leftTurn = true
local direction = "left"
local numTries = 5


if not os.loadAPI("turtleEx") then
  error("Could not load required api.")
  return
end

-- args {numLong, numWide, height, numtries}
-- rely on the api to handle the number of tries

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


-- get the height >= 1
if targs[3] ~= nil then
  height = tonumber(targs[3])
  if height < 1 then
    height = 1
  end
end

if height < 1 then
  error("Invalid height: " .. height)
  return
end


-- get the direction
if targs[4] ~= nil then
  if targs[4] == "left" then
    leftTurn = true
    direction = "left"
  elseif targs[4] == "right" then
    leftTurn = false
    direction = "right"
  else
    error("Invalid turn direction: " .. targs[4])
    return
  end
end


-- get the number of tries >= 1
if targs[5] ~= nil then
  numTries = tonumber(targs[5])
  if numTries < 1 then
    numTries = 1
  end
end

if numTries < 1 then
  error("Invalid number of tries: " .. numTries)
  return
end


print("clear mine a " .. numLong .. "x" .. numWide .. " area.")
print("turn direction = " .. direction .. ". height = " .. height)
print("numTries = " .. numTries)

local function turnLeft()
  turtle.turnLeft()
  if not turtleEx.digForward(numTries) then
    error("Cannot clear forward when turning left")
    return false
  end
  turtle.forward()
  turtle.turnLeft()
  if not turtleEx.digDown(numTries) then
    error("Cannot dig down when turning left")
    return false
  end

  if not turtleEx.digUp(numTries) then
    error("Cannot clear above when turning left")
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
  turtle.forward()
  turtle.turnRight()
  if not turtleEx.digDown(numTries) then
    error("Cannot dig down when turning right")
    return false
  end

  if not turtleEx.digUp(numTries) then
    error("Cannot clear above when turning right")
    return false
  end
  return true
end

local farTurn
local nearTurn

if leftTurn == true then
  farTurn = turnLeft
  nearTurn = turnRight
else
  farTurn = turnRight
  nearTurn = turnLeft
end

if not turtleEx.digForward(numTries) then
  error("Cannot clear start")
  exit()
end
turtle.forward()

for k = 1,height do
  for i = 1,numWide do
    print("Cycle " .. i .. " - outbound")
  
    for j = 1,numLong do
      if not turtleEx.digForward(numTries) then
        error("Cannot clear obstacle on outbound leg")
        exit()
      end
  
      turtle.forward()
  
      print("Clear block " .. j .. " of " .. numLong .. " outbound")
  
      if not turtleEx.digDown(numTries) then
        error("Cannot clear floor on outbound leg")
        exit()
      end
  
      if not turtleEx.digUp(numTries) then
        error("Cannot clear above on outbound leg")
        exit()
      end
    end
    
    if not farTurn() then
      error("Could not turn around for return leg")
      exit()
    end
  
    print("Cycle " .. i .. " - inbound")
  
    for j = 1,numLong do
      if not turtleEx.digForward(numTries) then
        error("Cannot clear obstacle on inbound leg")
        exit()
      end
  
      turtle.forward()
  
      print("Clear block " .. j .. " of " .. numLong .. " inbound")
  
      if not turtleEx.digDown(numTries) then
        error("Cannot clear floor on inbound leg")
        exit()
      end
  
      if not turtleEx.digUp(numTries) then
        error("Cannot clear above on inbound leg")
        exit()
      end
    end
    
    print("Attempt to turn back")
    if (i < numWide) then
      if not nearTurn() then
        error("Could not turn again for next cycle")
        exit()
      end
    end
  end

  -- we are now (numWide * 2) -1  blocks away
  local retDist = (numWide * 2) - 1
  print("return " .. retDist .. " blocks")
  if leftTurn == true then
    turtle.turnLeft()
  else
    turtle.turnRight()
  end
  
  for i = 1,retDist do
    turtle.forward()
  end
  
  if leftTurn == true then
    turtle.turnLeft()
  else
    turtle.turnRight()
  end
  
  -- now move up
  if k < (height - 1) then
    for l = 1, 3 do 
      if not turtleEx.digUp() then
        error("Cannot dig up")
        return false
      end
      turtle.up()
    end
  end
end
  
local retHeight = (height * 3)
for k = 1,retHeight do
  turtle.down()
end

print("Done.")
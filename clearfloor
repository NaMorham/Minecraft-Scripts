-- Clear the floor of a room moving horizontal

-- args {num blocks, num cycles [up and back is a cycle], direction [default left], numtries}

local targs = {...}
local numBlocks = 3
local numCycles = 1
local numTries = 5
local isLeft = true
local direction = "left"

if not os.loadAPI("turtleEx") then
  error("Could not load required api.")
  return
end

-- get the number of blocks >= 1
if targs[1] ~= nil then
  numBlocks = tonumber(targs[1])
  if numBlocks < 1 then
    numBlocks = 1
  end
end

if numBlocks < 1 then
  error("Invalid number of blocks: " .. numBranches)
  return
end


-- get the numberof cycles >= 1
if targs[2] ~= nil then
  numCycles = tonumber(targs[2])
  if numCycles < 1 then
    numCycles = 1
  end
end

if numCycles < 1 then
  error("Invalid number of cycels: " .. numCycles)
  return
end


-- get the direction
if targs[3] ~= nil then
  if targs[3] == "left" then
    isLeft = true
    direction = "left"
  elseif targs[3] == "right" then
    isLeft = false
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


-- start clearing
print("Clear " .. numCycles .. " groups of " .. numBlocks .. " blocks.")
print("Perform a " .. direction .. " turn to return to start.")
print("Try " .. numTries .. " times to clear an obstacle.")

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

if isLeft == true then
  farTurn = turnLeft
  nearTurn = turnRight
else
  farTurn = turnRight
  nearTurn = turnLeft
end

if not turtleEx.digDown(numTries) then
  error("Cannot clear floor at start")
  exit()
end


for i = 1,numCycles do
  print("Cycle " .. i .. " - outbound")

  for j = 1,numBlocks do
    if not turtleEx.digForward(numTries) then
      error("Cannot clear obstacle on outbound leg")
      exit()
    end

    turtle.forward()

    print("Clear block " .. j .. " of " .. numBlocks .. " outbound")

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

  for j = 1,numBlocks do
    if not turtleEx.digForward(numTries) then
      error("Cannot clear obstacle on inbound leg")
      exit()
    end

    turtle.forward()

    print("Clear block " .. j .. " of " .. numBlocks .. " inbound")

    if not turtleEx.digDown(numTries) then
      error("Cannot clear floor on inbound leg")
      exit()
    end

    if not turtleEx.digUp(numTries) then
      error("Cannot clear above on inbound leg")
      exit()
    end
  end
  
  if i < numCycles then
    if not nearTurn() then
      error("Could no turn again for next cycle")
      exit()
    end
  end
end

print("Done.")


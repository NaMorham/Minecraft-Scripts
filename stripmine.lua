-- strip mine an area
local targs = {...}
local numLong = 10
local numWide = 1
local leftTurn = true
local direction = "left"
local numTries = 5
local enderSlot = 16
local hasEnder = false

if not os.loadAPI("turtleEx.lua") then
  error("Could not load required api.")
  return
end

-- args {numLong, numWide, dist, numtries}
-- rely on the api to handle the number of tries

local function usage()
  print("Usage")
  print("  stripmine <num blocks> [num cycles]")
  print("       [turn dir] [numTries]")
  print("       [ender chest slot]")
end

if (targs[1] == "help") or (targs[1] == "?") then
  usage()
  return false
end

if targs[1] ~= nil then
  numBlocks = tonumber(targs[1])
  if numBlocks < 1 then
    usage()
    return false
  end
else
  -- no args
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

if targs[5] ~= nil then
  enderSlot = tonumber(targs[5])
  if enderSlot < 1 or enderSlot > 16 then
    print("Invalid slot passed for ender chest")
    enderSlot = 0
    hasEnder = false
  else
    local numEnder = turtle.getItemCount(enderSlot)
    if numEnder > 0 then
      hasEnder = true
      print("Using ender chest in slot " .. enderSlot)
    else
      print("No ender chest available in slot " .. enderSlot)
      hasEnder = false
      enderSlot = 0
    end
  end
else
  print("Not using ender chest")
end


print(" ")
print("Strip mine a " .. numLong .. "x" .. numWide .. " area.")
print("turn direction = " .. direction .. ". numTries = " .. numTries)
if hasEnder == true then
  print("use ender chest in slot " .. enderSlot)
else
  print("not using ender chest")
end
print(" ")


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
  return false
end
turtle.forward()

for i = 1,numWide do
  print("Cycle " .. i .. " - outbound")

  for j = 1,numLong do
    if not turtleEx.digForward(numTries) then
      error("Cannot clear obstacle on outbound leg")
      return false
    end

    turtle.forward()

    print("Clear block " .. j .. " of " .. numLong .. " outbound")

    if not turtleEx.digDown(numTries) then
      error("Cannot clear floor on outbound leg")
      return false
    end

    if not turtleEx.digUp(numTries) then
      error("Cannot clear above on outbound leg")
      return false
    end
  end
  
  if not farTurn() then
    error("Could not turn around for return leg")
    return false
  end

  print("Cycle " .. i .. " - inbound")

  for j = 1,numLong do
    if not turtleEx.digForward(numTries) then
      error("Cannot clear obstacle on inbound leg")
      return false
    end

    turtle.forward()

    print("Clear block " .. j .. " of " .. numLong .. " inbound")

    if not turtleEx.digDown(numTries) then
      error("Cannot clear floor on inbound leg")
      return false
    end

    if not turtleEx.digUp(numTries) then
      error("Cannot clear above on inbound leg")
      return false
    end
  end

  print("--- dump items if needed ---")
  if hasEnder == true then
    print(" -- dump --")
    if not turtleEx.dumpAllItems(numTries, 0, enderSlot) then
      print("Failed to dump items")
      return false
    end
  end
  
  print("Attempt to turn back")
  if (i < numWide) then
    if not nearTurn() then
      error("Could not turn again for next cycle")
      return false
    end
  end
end

-- we are now (numWide * 2) - 1  blocks away
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
turtle.back()


print("Done.")
return true

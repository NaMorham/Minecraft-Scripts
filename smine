local numRises = 1
local targs = {...}
local numLong = 10
local numWide = 1
local leftTurn = true
local direction = "left"
local numTries = 5
local enderSlot = 16
local hasEnder = false


if not os.loadAPI("turtleEx") then
  error("Could not load required api.")
  return
end

-- args {numLong, numWide, dist, numtries}
-- rely on the api to handle the number of tries

local function usage()
  print("Usage")
  print("  smine <num rises> <num blocks>")
  print("       [num cycles] [turn dir]")
  print("       [numTries] [ender chest slot]")
end

if (targs[1] == "help") or (targs[1] == "?") then
  usage()
  return false
end

if targs[1] ~= nil then
  numRises = tonumber(targs[1])
  if numRises < 1 then
    usage()
    return false
  end
else
  -- not enough args
  usage()
  return false
end

print("Parse length")
-- get the number of blocks >= 1
if targs[2] ~= nil then
  numLong = tonumber(targs[2])
  if numLong < 1 then
    numLong = 1
  end
else
  -- not enough args
  usage()
  return false
end

if numLong < 1 then
  error("Invalid number of blocks: " .. numBranches)
  return
end


print("Parse width (in cycles - out and back)")
-- get the width >= 1
if targs[3] ~= nil then
  numWide = tonumber(targs[3])
  if numWide < 1 then
    numWide = 1
  end
end

if numWide < 1 then
  error("Invalid width: " .. numWide)
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

if targs[6] ~= nil then
  enderSlot = tonumber(targs[6])
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
print(numRises .. " passes high, turning = " .. direction .. ". numTries = " .. numTries)
if hasEnder == true then
  print("use ender chest in slot " .. enderSlot)
else
  print("not using ender chest")
end
print(" ")


for k = 1, numRises do
  print(" ")
  print("Strip mine level " .. k .. " of " .. numRises)
  if not shell.run("stripmine", numLong, numWide, direction, numTries, enderSlot) then
    print("Could not strip mine " .. numWide .. " x " .. numLong .. " x " .. numRises)
    print("    turning " .. direction)
  end
  
  if (numRises > 1) and (k < numRises) then 
    for a = 1, 3 do
      if not turtleEx.digUp(numTries) then
        print("Cannot clear up")
        return false
      end
      turtle.up()
    end
  end
  -- end of level
end

if numRises > 1 then
  local numDown = 3 * (numRises - 1)
  print("Return down to start - " .. numDown .. " blocks")
  for a = 1, numDown do
    turtle.down()
  end
end


print("Done")
return true


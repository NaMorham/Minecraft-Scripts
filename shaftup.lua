local targs={...}
local numBlocks = 2
local height = 7
local numTries = 15
local slotFront = -1
local funcFront = nil
local slotRight = -1
local funcRight = nil
local slotBack = -1
local funcBack = nil
local slotLeft = -1
local funcLeft = nil
local placeCap = 0
local replaceBlock = 0


if not os.loadAPI("turtleEx") then
  error("Could not load required api.")
  return
end


-- args {height, numtries, front right back left}
-- rely on the api to handle the number of tries

local function usage()
  print("Usage")
  print("  shaftUp <height> [num tries]")
  print("          [front slot] [right slot]")
  print("          [back slot] [left slot]")
  print("          [place cap] [replace]")
end

local function dumpVals()
  print("shaftup")
  print("height = ".. height .. ", numTries = " .. numTries)
  print("slotFront = " .. slotFront .. ", slotRight = " .. slotRight)
  print("slotBack = " .. slotBack .. ", slotLeft = " .. slotLeft)
  if (placeCap > 0) then
    print("place cap")
  end
  if (replaceBlock == 1) then
    print("replace block")
  end
end

local function skipBlock(numTries, slot)
  -- noop
  return true
end

local function placeBlock(numTries, slot)
  local itemCount = turtle.getItemCount(slot)
  local selectedSlot = turtle.getSelectedSlot()
  turtle.select(slot)

  if (itemCount < 1) then
    print("Out of blocks")
    return false
  end
  if (turtle.detect()) then
    -- print "Block found"
    if (replaceBlock == 1) then
      if (turtleEx.digForward(numTries)) then
        turtle.place()
      else
        -- we tried to dig out in front of us, but could not
        print "Could not dig out"
      end
    else
      -- nothing to do
      -- print "Nothing to do"
    end
  else
    -- nothing detected, just place
    -- print "nothing in front, just place"
    turtle.place()
  end

  turtle.select(selectedSlot)
  return true
end

-- print("Num args = " .. #targs)
if (targs[1] == nil) or (targs[1] == "help") or (targs[1] == "?") or (#targs > 8) or (#targs < 1) then
  usage()
  return false
end

if targs[1] ~= nil then
  height = tonumber(targs[1])
  if (height == nil) then
    print("invalid value for height (should be number")
    dumpVals()
    usage()
    return false
  elseif (height < 2) then
    print("Height too short, must be over 2")
    dumpVals()
    usage()
    return false
  elseif (height > 63) then
    print("Height to long, must be under 63")
    dumpVals()
    usage()
    return false
  end
end

if targs[2] ~= nil then
  numTries = tonumber(targs[2])
  if (numTries == nil) then
    print("invalid type for num tries (should be number")
    dumpVals()
    usage()
    return false
  elseif (numTries < 1) then
    print("invalid number of tries")
    dumpVals()
    usage()
    return false
  end
end

funcFront = skipBlock
if targs[3] ~= nil then
  slotFront = tonumber(targs[3])
  if (slotFront == nil) then
    print("invalid value for front (should be number")
    dumpVals()
    usage()
    return false
  elseif (slotFront < 0) then
    funcFront = skipBlock
  elseif (slotFront < 1) or (slotFront > 16) then
    print("invalid slot value for front")
    dumpVals()
    usage()
    return false
  else
    funcFront = placeBlock
  end
end

funcRight = skipBlock
if targs[4] ~= nil then
  slotRight = tonumber(targs[4])
  if (slotRight == nil) then
    print("invalid value for right (should be number")
    dumpVals()
    usage()
    return false
  elseif (slotRight < 0) then
    funcRight = skipBlock
  elseif (slotRight < 1) or (slotRight > 16) then
    print("invalid slot value for right")
    dumpVals()
    usage()
    return false
  else
    funcRight = placeBlock
  end
end

funcBack = skipBlock
if targs[5] ~= nil then
  slotBack = tonumber(targs[5])
  if (slotBack == nil) then
    print("invalid type for back (should be number")
    dumpVals()
    usage()
    return false
  elseif (slotBack < 0) then
    funcBack = skipBlock
  elseif (slotBack < 1) or (slotBack > 16) then
    print("invalid slot value for back")
    dumpVals()
    usage()
    return false
  else
    funcBack = placeBlock
  end
end

funcLeft = skipBlock
if targs[6] ~= nil then
  slotLeft = tonumber(targs[6])
  if (slotLeft == nil) then
    print("invalid type for left (should be number)")
    dumpVals()
    usage()
    return false
  elseif (slotLeft < 0) then
    funcLeft = skipBlock
  elseif (slotLeft < 1) or (slotLeft > 16) then
    print("invalid slot value for left")
    dumpVals()
    usage()
    return false
  else
    funcLeft = placeBlock
  end
end

placeCap = 0
if targs[7] ~= nil then
  placeCap = tonumber(targs[7])
  if (placeCap == nil) then
    print("invalid type for cap (should be number")
    dumpVals()
    usage()
    return false
  elseif (placeCap < 0) then
    placeCap = 0
  elseif (placeCap < 1) or (placeCap > 16) then 
    print("invalid slot value for cap")
    dumpVals()
    usage()
    return false
  end
end

replaceBlock = 0
if targs[8] ~= nil then
  if (targs[8] == "1") or (targs[8] == "true") then
    replaceBlock = 1
  end
end

dumpVals()
print("Shaft up " .. height)

for i=1,height do
  print("Move " .. i .. "/" .. height)

  if (not turtleEx.digUp(numTries)) then
    print("Could not clear above")
    return false
  end
  if (not turtle.up()) then
    print("Could not move up")
    return false
  end

  if (not funcFront(numTries, slotFront)) then
    print("Cannot place a block in front")
    return false
  end
  turtle.turnRight()
  
  if (not funcRight(numTries, slotRight)) then
    print("Cannot place a block to right")
    return false
  end
  turtle.turnRight()

  if (not funcBack(numTries, slotBack)) then
    print("Cannot place a block behind")
    return false
  end
  turtle.turnRight()

  if (not funcLeft(numTries, slotLeft)) then
    print("Cannot place a block to left")
    return false
  end
  turtle.turnRight()
end


if (placeCap > 0) then
  print("Place cap")
  turtle.select(placeCap)
  if (not turtle.detectUp()) then
    if (not turtle.placeUp(numTries)) then
      print("Cannot place up")
      return false
    end
  end
else
  print("Not placing cap block")
end


print("Return down")
for j=1,height do
  turtle.down()
end


print("Done.")
return true


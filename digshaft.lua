-- dig a shaft down

-- args: 
local targs = {...}
--    specify depth
local depth = 1
--    specify width perpendicular dist 
local width = 1
--    specify length in direction facing
local length = 1
--    specify num tries
local numTries = 10
--    specify enderChest location
local enderSlot = 0
local hasEnder = false
--    specify offset left <default to 0>
local offLeft = 0
--    specify offset forwards <default to 0>
local offFor = 0


if not os.loadAPI("turtleEx") then
  error("Could not load required api.")
  return
end


-- args {num blocks, numtries, torchslot}
-- rely on the api to handle the number of tries

local function usage()
  print("Usage")
  print("  digshaft <depth> [width] [length]")
  print("       [numTries] [ender chest slot]")
  print("       [offset left] [offset ahead]")
end


--------------------------------------------------
-- internal vars for movement
local xPos = 0
local yPos = 0
-- dir 0 == ahead, 1 == right, 2 == back, 3 = left
local dir = 0
local deltaX = 0
local deltaY = 1

local function InitPosAndDir()
  dir = 0
  xPos = 0
  yPos = 0
  deltaX = 0
  deltaY = 1
  -- CalcDeltas()
end

local function CalcDeltas()
  -- hacky
  if dir == 0 then
    deltaX = 0
    deltaY = 1
  elseif dir == 1 then
    deltaX = 1
    deltaY = 0
  elseif dir == 2 then
    deltaX = 0
    deltaY = -1
  elseif dir == 3 then
    deltaX = -1
    deltaY = 0
  else
    -- BAD mojo
    print("Invalid dir, resetting pos and direction")
    InitPosAndDir()
  end
end

local function TurnLeft()
  if turtle.turnLeft() then
    dir = dir - 1
    if dir < 0 then 
      dir = 3
    end
    CalcDeltas()
    return true
  else
    print("Could not turn left")
    return false
  end
end

local function TurnRight()
  if turtle.turnRight() then
    dir = dir + 1
    if dir > 3 then 
      dir = 0
    end
    CalcDeltas()
    return true
  else
    print("Could not turn right")
    return false
  end
end

local function AdvanceTurtle()
  print("AdvanceTurtle")
  if turtleEx.digForward(numTries) then
    if turtle.forward() then
      xPos = xPos + deltaX
      yPos = yPos + deltaY
      return true
    else
      print("Could not advance")
      return false
    end
  else
    print("Could not advance")
    return false
  end
end

local function RetreatTurtle()
  if turtle.back() then
    xPos = xPos - deltaX
    yPos = yPos - deltaY
    return true
  else
    print("Could not retreat")
    return false
  end
end

local function DumpPosAndDir()
  print("Position  = [" .. xPos .. ", " .. yPos .. "]")
  print("Deltas    = [" .. deltaX .. ", " .. deltaY .. "]")
  print("Direction = " .. dir)
  print(" ")
end

--------------------------------------------------


local function parseArgs()
  if (targs[1] == "help") or (targs[1] == "?") then
    usage()
    return false
  end

  if targs[1] ~= nil then
    depth = tonumber(targs[1])
    if depth < 1 then
      usage()
      return false
    end
    print("Dig " .. depth .. " blocks deep")
  else
    -- no args
    usage()
    return false
  end

  if targs[2] ~= nil then
    width = tonumber(targs[2])
    if width < 1 then
      width = 1
    end
  end
  print("Dig " .. width .. " blocks wide")
  
  if targs[3] ~= nil then
    length = tonumber(targs[3])
    if length < 1 then
      length = 1
    end
  end
  print("Dig " .. length .. " blocks long")
  
  if targs[4] ~= nil then
    numTries = tonumber(targs[4])
    if numTries < 1 then
      numTries = 1
    end
  end
  print("Trying " .. numTries .. " times to dig")
  
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
  
  if targs[6] ~= nil then
    offLeft = tonumber(targs[6])
    if offLeft < 1 then
      offLeft = 1
    end
  end
  print("Move " .. offLeft .. " blocks left")
  
  if targs[7] ~= nil then
    offFor = tonumber(targs[7])
    if offFor < 1 then
      offFor = 1
    end
  end
  print("Move " .. offFor .. " blocks ahead")

  return true
end
-- end func parse args

local function MoveToStart()
  -- we move forward first so we can dig from within
  -- a safe location (i.e. inside house in nether
  -- and the turtle will only leave a small hole

  -- move forwards
  if offFor > 0 then
    for i=1,offFor do
      if not turtleEx.digForward(numTries) then
        print("Could not clear forwards")
        return false
      end
      if not turtle.forward() then
        print("Could not move forward")
        return false
      end
    end
  end

  -- TODO handle negative values for offset left
  -- move left
  if offLeft > 0 then
    turtle.turnLeft()
    for i=1,offLeft do
      if not turtleEx.digForward(numTries) then
        print("Could not clear forwards")
        return false
      end
      if not turtle.forward() then
        print("Could not move forward")
        return false
      end
    end
    turtleEx.turnRight(2)
    -- we are now facing right
  end

  return true
end


local function DigSingle()
  local numMoves = 0
  -- dig down
  for i = 1, depth do
    if not turtleEx.digDown(numTries) then
      print("Cannot dig down")
      break
    end
    if turtle.down() then
      numMoves = numMoves + 1
    end
  end
  
  -- come back up
  if numMoves > 0 then
    print("Move back up " .. numMoves .. " blocks")
    if not turtleEx.up(numMoves) then
      print("Cannot move back up.")
      return false
    end
  end
  
  -- clear inventory
  if hasEnder then
    -- note, no torches (arg2)
    if not turtleEx.dumpAllItems(numTries, 0, enderSlot) then
      print("Could not clear items")
      return false
    end
  end
  return true
end

--- Dig the shaft ---
local function DigShaft()
  -- dig the shafts
  local modWidth = width - 1
  if modWidth < 1 then
    modWidth = 1
  end
  local modLength = length - 1
  if modLength < 1 then
    modLength = 1
  end

  for i = 1, width do
    for j = 1, length do
      print("Dig shaft at [" .. xPos .. ", " .. yPos .. "] - ij = [" .. i .. ", " .. j .. "]")
      if not DigSingle() then
        return false
      else
        if j < length then
          if not AdvanceTurtle() then
            return false
          end
        end
      end
    end
    -- end j
     
    -- turn to next row if needed
    if i < width then
      if (i % 2) == 1 then
        if not TurnRight() then
          return false
        end
        if not AdvanceTurtle() then
          return false
        end
        if not TurnRight() then
           return false
        end
      else
        if not TurnLeft() then
          return false
        end
        if not AdvanceTurtle() then
          return false
        end
        if not TurnLeft() then
          return false
        end
      end
    end
  end
  -- end i
  
  return true
end


--- Return to start ---
local function ReturnToStart()
  local startPos = 0
end


-- main program
if not parseArgs() then
  -- could not parse
  return false
end
print(" ")

-- if there is fuel in slot one, top up
turtle.select(1)
turtle.refuel()

if not MoveToStart() then
  print("FAILED.  Could not move into position to start digging")
  return false
end
print(" ")

InitPosAndDir()

-- debugging
--DumpPosAndDir()
--TurnRight()
--AdvanceTurtle()
--
--DumpPosAndDir()
--TurnRight()
--AdvanceTurtle()
--
--DumpPosAndDir()
--TurnRight()
--AdvanceTurtle()
--
--DumpPosAndDir()
--TurnRight()
--AdvanceTurtle()
--
--DumpPosAndDir()

if not DigShaft() then
  print("FAILED.  Could not dig shaft.")
  return false
end

ReturnToStart()

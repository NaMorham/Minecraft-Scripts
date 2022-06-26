local targs = {...}
local numBlocks = 1
local numTries = 15
local placeCount = 0
local torchSlot = 0
local hasTorch = false
local enderSlot = 15
local hasEnder = false

if not os.loadAPI("turtleEx.lua") then
  error("Could not load required api.")
  return
end


-- args {num blocks, numtries, torchslot}
-- rely on the api to handle the number of tries

local function placeTorchOld(torchslot)
  turtle.select(torchSlot)
  turtle.back()
  turtle.turnRight()
  turtle.placeUp()
  turtle.turnLeft()
  turtle.forward()
  turtle.select(1)
end

local function placeTorchBehind(torchslot)
  turtle.select(torchSlot)
  turtle.turnRight()
  turtle.turnRight()
  turtle.place()
  turtle.turnLeft()
  turtle.turnLeft()
  turtle.select(1)
end

local function placeTorchEx(torchslot)
  turtle.select(torchSlot)
  turtle.back()
  turtle.down()
  turtle.placeUp()
  turtle.up()
  turtle.forward()
  turtle.select(1)
end

local function placeTorchAhead(torchslot)
  turtle.select(torchSlot)
  turtle.back()
  turtle.back()
  turtle.up()
  turtle.place()
  turtle.down()
  turtle.forward()
  turtle.forward()
  turtle.select(1)
end

local function placeTorch(torchslot)
  turtle.select(torchSlot)
  turtle.back()
  turtle.placeUp()
  turtle.forward()
  turtle.select(1)
end

local function usage()
  print("Usage")
  print("  mineboth <numblocks> [num tries]")
  print("       [torch slot] [ender chest slot]")
end

if (targs[1] == nil) or (targs[1] == "help") or (targs[1] == "?") then
  usage()
  return false
end

if (targs[1] ~= nil) then
  numBlocks = tonumber(targs[1])
  if numBlocks < 1 then
    usage()
    return false
  end
end

if (targs[2] ~= nil) then
  numTries = tonumber(targs[2])
  if numTries < 1 then
    numTries = 1
  end
end

print("Num args = " .. #targs)
if (targs[3] ~= nil) then
  print("arg 3 = " .. targs[3])
  torchSlot = tonumber(targs[3])
  print("DBG: Check torchSlot [" .. torchSlot .. "]")
  if ( (torchSlot < 1) or (torchSlot > 16) ) then
    print("Invalid slot passed for torches")
    torchSlot = 0
    hasTorch = false
  else
    local data = turtle.getItemDetail(torchSlot)
    if data then
      print("Item name: ", data.name)
      print("Item damage value: ", data.damage)
      print("Item count: ", data.count)
    else
      print("Could not get item data")
    end

    local numTorch = turtle.getItemCount(torchSlot)
    print("DBG: numTorch = " .. tostring(numtorch))
    turtle.select(torchSlot)
    numTorch = turtle.getItemCount()
    print("DBG: numTorch (2) = " .. tostring(numtorch))

    if (numTorch > 0) then -- or (data.count >= 1) then
      hasTorch = true
      print("Using torches in slot " .. torchSlot)
    else
      print("No torches to place")
      torchSlot = 0
      hasTorch = false
    end
  end
  -- return false
else
  torchSlot = 0
  hasTorch = false
  print("Not using torches")
  -- return false
end

if (targs[4] ~= nil) then
  enderSlot = tonumber(targs[4])
  if (enderSlot < 1) or (enderSlot > 16) then
    print("Invalid slot passed for ender chest")
    enderSlot = 0
    hasEnder = false
  else
    local numEnder = turtle.getItemCount(enderSlot)
    if (numEnder > 0) then
      hasEnder = true
      print("Using ender chest in slot " .. enderSlot)
    else
      print("No ender chest available in slot " .. enderSlot)
      hasEnder = false
      enderSlot = 0
    end
  end
else
  enderSlot = 0
  hasEnder = false
  print("Not using ender chest")
end


print("DBG: tslot = " .. torchSlot)
print("DBG: has t = " .. tostring(hasTorch))

print(" ")
print("Mine both directions " .. numBlocks .. " blocks")
if not hasTorch then
  print("  not using torches")
else
  print("  using torches from slot " .. torchSlot)
end
if not hasEnder then
  print("  not using enderChest")
else
  print("  using ender chest from slot " .. enderSlot)
end


-- loop until done
for i = 1, numBlocks do
  print("Dig block " .. i .. "/" .. numBlocks)

  print("    clear ahead")
  if not turtleEx.digForward(numTries) then
    print("cannot continue digging")
    return false
  end

  turtle.forward()
    
  print("    clear above")
  if not turtleEx.digUp(numTries) then
    print("Warning: cannot clear block above")
  end
  
  print("    clear below")
  turtle.digDown()
  
  if hasTorch then
    placeCount = placeCount + 1
    local modVal = (placeCount + 1) % 5
    
    if (modVal == 0) then
      -- This appears to not work after v1.12.2 :(
      -- placeTorch(torchSlot)
      -- This appears to not work after v1.16.2 :(
      -- placeTorchOld(torchSlot)
      placeTorchEx(torchSlot)
    end
  end
end


-- now clear up
for i = 1,4 do
  print("Move up "..i.."/3")
  
  if not turtleEx.digUp(numTries) then
    print("Warning: cannot clear up")
    return false
  end
  if i < 4 then
    turtle.up()
    -- only turn right twice
    if i > 1 then
      turtle.turnRight()
    end
  end
end

-- Mine back to start
-- loop until done
for i = 1, numBlocks do
  print("Dig block " .. i .. "/" .. numBlocks)

  print("    clear ahead")
  if not turtleEx.digForward(numTries) then
    print("cannot continue digging")
    return false
  end

  turtle.forward()
    
  print("    clear above")
  if not turtleEx.digUp(numTries) then
    print("Warning: cannot clear block above")
  end
  
  print("    clear below")
  turtle.digDown()
end

-- drop  down to start position
for i = 1,3 do
  turtle.down()
end

if hasEnder == true then
  print("Dump items")
  if not turtleEx.dumpAllItems(numTries, torchSlot, enderSlot) then
    print("Failed to dump items")
    return false
  end
end

return true


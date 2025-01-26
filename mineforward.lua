local targs = {...}
local numBlocks = 1
local numTries = 15
local placeCount = 0
local torchSlot = 0
local hasTorch = false
local enderSlot = 15
local hasEnder = false

if not os.loadAPI("turtleEx") then
  error("Could not load required api.")
  return
end

if not os.loadAPI("turtleEx") then
  error("Could not load required api.")
  return
end


-- args {num blocks, numtries, torchslot}
-- rely on the api to handle the number of tries

local function usage()
  print("Usage")
  print("  mineboth <numblocks> [num tries]")
  print("       [torch slot] [ender chest slot]")
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

if targs[2] ~= nil then
  numTries = tonumber(targs[2])
  if numTries < 1 then
    numTries = 1
  end
end

if targs[3] ~= nil then
  torchSlot = tonumber(targs[3])
  if torchSlot < 1 or torchSlot > 16 then
    print("Invalid slot passed for torches")
    torchSlot = 0
    hasTorch = false
  else
    local numTorch = turtle.getItemCount(torchSlot)
    if numTorch > 1 then
      hasTorch = true
      print("Using torches in slot " .. torchSlot)
    end
  end
else
  print("Not using torches")
end

if targs[4] ~= nil then
  enderSlot = tonumber(targs[4])
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
      turtle.select(torchSlot)
      turtle.back()
      turtle.turnRight()
      turtle.placeUp()
      turtle.turnLeft()
      turtle.forward()
      turtle.select(1)
    end
  end
end


if hasEnder == true then
  print("Dump items")
  if not turtleEx.dumpAllItems(numTries, torchSlot, enderSlot) then
    print("Failed to dump items")
    return false
  end
end


return true


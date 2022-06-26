local targs = {...}
local numBranches = 3
local branchSize = 15
local numTries = 3
local doubleBranch = branchSize * 2
local torchSlot = 16
local enderSlot = 16
local hasEnder = false
local hasTorch = false

if not os.loadAPI("turtleEx.lua") then
  error("Could not load required api.")
  return
end

-- args {num branches, branch size, numtries}
local function usage()
  print("Usage")
  print("  branchmine <num Branches> <size> ")
  print("             [num tries] [torchSlot]")
  print("             [ender chest slot]")
end

if (targs[1] == nil) or (targs[1] == "help") or (targs[1] == "?") then
  usage()
  return false
end


-- get the number of branches >= 1
if targs[1] ~= nil then
  numBranches = tonumber(targs[1])
  if numBranches < 1 then
    error("Invalid number of branches: " .. numBranches)
    usage()
    return false
  end
else
  error("Invalid number of branches: " .. numBranches)
  usage()
  return false
end


-- get the branch size >= 1
if targs[2] ~= nil then
  branchSize = tonumber(targs[2])
  if branchSize < 1 then
    error("Invalid branch size: " .. branchSize)
    usage()
    return false
  end
else
  error("Invalid branch size: " .. branchSize)
  usage()
  return false
end


-- get the number of tries >= 1
if targs[3] ~= nil then
  numTries = tonumber(targs[3])
  if numTries < 1 then
    numTries = 1
  end
end

if numTries < 1 then
  error("Invalid number of tries: " .. numTries)
  return
end


-- torch slot
if targs[4] ~= nil then
  torchSlot = tonumber(targs[4])
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
  torchSlot = 0
  hasTorch = false
  print("Not using torches")
end


-- ender chest slot
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
      enderSlot = 0
      hasEnder = false
    end
  end
else
  enderSlot = 0
  hasEnder = false
  print("Not using ender chest")
end


-- start mining
print("Branch mine: Dig " .. numBranches .. " branches of size " .. branchSize)

for i = 1,numBranches do
  
  -- dig ahead 3
  if not shell.run("mineforward", 3, numTries) then
    print("Unable to dig forward to branch point")
    return false
  end
  
  -- branch left first
  turtle.turnLeft()
  
  if not shell.run("mineboth", branchSize, numTries, torchSlot, enderSlot) then
    print("Unable to branch left")
    return false
  end
  
  -- should already be facing the correct direction
  -- so mine again, this is the right side
  if not shell.run("mineboth", branchSize, numTries, torchSlot, enderSlot) then
    print("Unable to branch right")
    return false
  end
  
  -- return to starting direction
  turtle.turnRight()
  
end

-- now dig up and mine back to start
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

local mineBack = numBranches * 3
if not shell.run("mineforward", mineBack, numTries) then
  print("Unable to dig back to start")
  return false
end

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

print("Done.")

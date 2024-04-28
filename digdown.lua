-- dig straight down until limit is
-- reached or cannot clear down

-- args {num blocks, numtries, torchslot}
-- rely on the api to handle the number of tries


local targs = {...}
local enderSlot = 15
local hasEnder = false
local height = 10
local numTries = 5

-- temp vars
local blocksDug = 1

if not os.loadAPI("turtleEx.lua") then
  error("Could not load required api.")
  return
end

local function usage()
  print("Usage")
  print("  digdown <height> <num tries> [ender chest slot]")
end

if (#targs < 2) or (targs[1] == nil) or (targs[1] == "help") or (targs[1] == "?") then
  usage()
  return false
end

-- height
height = tonumber(targs[1])
if height < 1 then
  print("Invalid height passed")
  return false
end

-- numTries
numTries = tonumber(targs[2])
if numTries < 1 then
  numTries = 1
end

if targs[3] ~= nil then
  enderSlot = tonumber(targs[3])
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


-- start
print("Dig down " .. height .. " blocks, try " .. numTries .. " times to dig")
for i = 1, height do
  if not turtleEx.digDown(numTries) then
    print("Cannot dig further.")
    print("Reached a depth of " .. blocksDug .. " blocks")
    print("Returning...")
    break
  end
  turtle.down()
  blocksDug = blocksDug + 1
end

-- return
for i = 1, blocksDug-1 do
  turtle.up()
end

-- empty out
if hasEnder == true then
  print("Dump items")
  if not turtleEx.dumpAllItems(numTries, -1, enderSlot) then
    print("Failed to dump items")
    return false
  end
end

print("Done.")
print(" ")

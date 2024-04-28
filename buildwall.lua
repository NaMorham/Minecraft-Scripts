local targs={...}
local numBlocks = 42
local height = 7
local selSlot = 1
local numTries = 5


if not os.loadAPI("turtleEx.lua") then
  error("Could not load required api.")
  return
end


-- args {num blocks, numtries}
-- rely on the api to handle the number of tries

local function usage()
  print("Usage")
  print("  placeforward <numblocks> <height> [num tries]")
end

-- if #args > 2 or #args < 2 
-- print("Num args = " .. #targs)
if (targs[1] == nil) or (targs[1] == "help") or (targs[1] == "?") or (#targs > 3) or (#targs < 2) then
  usage()
  return false
end

if targs[1] ~= nil then
  numBlocks = tonumber(targs[1])
  if numBlocks < 2 then
    usage()
    return false
  end
end

if targs[2] ~= nil then
  height = tonumber(targs[2])
  if height < 1 then
    usage()
    return false
  end
end

if targs[3] ~= nil then
  numTries = tonumber(targs[3])
  if numTries < 1 then
    usage()
    return false
  end
end


---
local maxSlot = 8
function getBlocks_old()
  local startSlot = 0
  local itemCount = 0

  selSlot = startSlot
  repeat
    selSlot = selSlot + 1
    itemCount = turtle.getItemCount( selSlot )
    print("(itemCount > 0) -> (" .. itemCount .. " > 0) = " .. tostring(itemCount > 0) )
    print("(selSlot > maxSlot) -> (" .. selSlot .. " > " .. maxSlot .. ") = " .. tostring(selSlot > maxSlot) )
  until (itemCount > 0) or (selSlot > maxSlot)
  if selSlot > maxSlot then
    print("No materials to build with")
    return false
  end
  turtle.select(selSlot)
  return true
end


---
-- Assumes that selSlot is set
--
function getBlocks()
  local itemCount = turtle.getItemCount( selSlot )
  while itemCount < 1 and selSlot <= maxSlot do
    selSlot = selSlot + 1
    itemCount = turtle.getItemCount( selSlot )
  end

  if selSlot >= maxSlot then
    printError("Out of building materials")
    return false
  end
  turtle.select(selSlot)
  return true
end


---
-- Build a wall 2 high
--
-- Dig out, the place behind and down on way back
function wall2(length, numTries)
  for k=1,length do
    turtleEx.digForward(numTries)
    turtle.forward()
    turtle.digDown()
  end
  for k=1,length do
    if not getBlocks() then
      return false
    end
    turtle.placeDown()
    turtle.back()
    turtle.place()
  end
end


---
-- Build a single layer
--
-- Dig out and replace behind
function wall1(length, numTries)
  for k=1,length do
    turtleEx.digForward(numTries)
    turtle.forward()
  end
  for k=1,length do
    turtle.back()
    if not getBlocks() then
      return false
    end
    turtle.place()
  end
end


---
local numCycles = math.floor((height + 1) / 2)
local modCycles = height % 2
local cycleLen = numBlocks - 1

print("")
print("Begin buildwall(" .. numBlocks .. ", " .. height .. ", " .. numTries .. ")")
print(">> numTries = " .. numTries)
print(">> numCycles = " .. numCycles)
print(">> modCycles = " .. modCycles)
print(">> cycleLen = " .. cycleLen)
print("")


print("Check for building material")
if not getBlocks() then
  return false
end


-- from start position, dig forward, clear up and below
print("move forward to start of cycle area")
shell.run("clearforward", 1, numTries)


---
print("Clear end row")
for j=1,height-1 do
  turtleEx.digUp(numTries)
  turtle.up()
end
for j=1,height-1 do
  turtle.down()
end


---
for j=1,numCycles do
  if j > 1 then
    turtleEx.up(2)
  end
  wall2(cycleLen, numTries)
end

-- Do the extra row if required
if modCycles == 0 then
  turtle.up()
  wall1(cycleLen, numTries)
end

-- Cleanup the end column
for k=1,height-1 do
  turtle.down()
  turtle.placeUp()
end
turtle.placeDown()
turtle.back()
turtle.place()


print("Done.")
return true

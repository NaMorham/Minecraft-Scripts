local targs = {...}
local numTries = 10
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
  print("  clearroom [num tries] [ender chest slot]")
end

if (targs[1] == "help") or (targs[1] == "?") then
  usage()
  return false
end

if targs[1] ~= nil then
  numTries = tonumber(targs[1])
  if numTries < 1 then
    numTries = 1
  end
end

if targs[2] ~= nil then
  enderSlot = tonumber(targs[2])
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


local function digUp(count)
  local digCount = 1
  if count ~= nil then
    if type(count) ~= "number" then
      error( "dig count is not a number")
      return
    end
    if count < 1 then
      error("Invalid dig count passed")
      return
    end
    digCount = count
  else
    digCount = 1
  end

  for i = 1,digCount do  
    local tryCount = 1
    turtle.digUp()
    while turtle.detectUp() and (tryCount <= numTries) do
      turtle.digUp()
      tryCount = tryCount + 1
      sleep(0.5)
    end
  
    if i < digCount then
      turtle.up()
    end
  end
end


shell.run("clearforward", 3, numTries)
turtle.turnLeft()
shell.run("clearforward", 1, numTries)
turtle.turnLeft()
shell.run("clearforward", 2, numTries)
turtle.turnLeft()
shell.run("clearforward", 2, numTries)
turtle.turnLeft()
shell.run("clearforward", 3, numTries)

-- now the room
turtle.turnRight()
shell.run("clearforward", 2, numTries)
turtle.turnLeft()
turtle.turnLeft()
turtle.forward()
turtle.forward()
shell.run("clearforward", 4, numTries)

-- the turtle is in the near
-- left corner
turtle.turnRight()

for i = 1,3 do
  shell.run("clearforward", 6, numTries)
  turtle.turnRight()
  shell.run("clearforward", 1, numTries)
  turtle.turnRight()
  shell.run("clearforward", 6, numTries)
  turtle.turnLeft()
  shell.run("clearforward", 1, numTries)
  turtle.turnLeft()
end
shell.run("clearforward", 6, numTries)

turtle.turnRight()
turtle.turnRight()
digUp(4)

-- the turtle is now in the far
-- right corner, facing the front
for i = 1,2 do
  shell.run("clearforward", 6, numTries)
  turtle.turnRight()
end

-- turtle is back in the front 
-- left corner again
for i = 1,3 do
  shell.run("clearforward", 6, numTries)
  turtle.turnRight()
  shell.run("clearforward", 1, numTries)
  turtle.turnRight()
  shell.run("clearForward", 6, numTries)
  turtle.turnLeft()
  turtle.forward()
  turtle.turnLeft()
end

-- turtle is now in the near right
-- corner
turtle.turnLeft()
for i = 1,3 do
  turtle.down()
  turtle.forward()
end

-- turtle is in the middle of 
-- the entrance, return to start
turtle.turnRight()

for i = 1,4 do
  turtle.back()
end


if hasEnder then
  if not turtleEx.dumpAllItems(numTries, 0, enderSlot) then
    print("Could not empty inventory")
    return false
  end
end

print("Return true")
return true
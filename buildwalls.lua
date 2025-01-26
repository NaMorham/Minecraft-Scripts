os.loadAPI("turtleEx")

local wallHeight = 7
local wallWidth = 9
local wallLength = 9
local shiftLeft = 4
local shiftRight = 5
local numTries = 5
local offset = 2

local targs = {...}

local function usage()
  print("Usage")
  print("  buildwalls <height> <width> <length> <num tries>")
end

if (targs[1] == nil ) or (targs[1] == "help") or (targs[1] == "?") then
  usage()
  return
end


-- get the height >= 1
if targs[1] ~= nil then
  wallHeight = tonumber(targs[1])
  if wallHeight < 1 then
    wallHeight = 1
  end
end

if wallHeight < 1 then
  error("Invalid number of blocks: " .. wallHeight)
  usage()
  return
end


-- get the width >= 1
if targs[2] ~= nil then
  wallWidth = tonumber(targs[2])
  if wallWidth < 1 then
    wallWidth = 1
  end
end

if wallWidth < 1 then
  error("Invalid width: " .. wallWidth)
  usage()
  return
end


-- get the length >= 1
if targs[3] ~= nil then
  wallLength = tonumber(targs[3])
  if wallLength < 1 then
    wallLength = 1
  end
end

if wallLength < 1 then
  error("Invalid length: " .. wallLength)
  usage()
  return
end


-- get the number of tries
if targs[4] ~= nil then
  numTries = tonumber(targs[4])
  if numTries < 1 then
    numTries = 1
  end
end

if numTries < 1 then
  error("Invalid number of tries: " .. numTries)
  usage()
  return
end


print("buildwalls height = " .. wallHeight .. ", width = " .. wallWidth)
print("           length = " .. wallLength .. ", num tries = " .. numTries)


shiftLeft = math.floor(wallWidth / 2)
shiftRight = wallWidth - shiftLeft


turtleEx.digForward(numTries)
turtle.forward()
  for k = 1, 5 do
    turtle.attack()
  end

turtleEx.digForward(numTries)
turtle.forward()
  for k = 1, 5 do
    turtle.attack()
  end
turtle.turnLeft()

for i = 1,wallHeight+1 do
  shell.run( "placeforward", shiftLeft, numTries )
  turtle.turnRight()
  shell.run( "placeforward", wallLength -1, numTries )
  turtle.turnRight()
  shell.run( "placeforward", wallWidth - 1, numTries )
  turtle.turnRight()
  shell.run( "placeforward", wallLength - 1, numTries )
  turtle.turnRight()
  shell.run( "placeforward", shiftLeft, numTries )
  turtleEx.digUp(numTries)
  turtle.up()
end

-- return home --
turtle.turnLeft()
turtleEx.digForward(numTries)
turtle.forward()

for i = 1,wallHeight+1 do
  turtleEx.digDown(numTries)
  turtle.down()
end

turtle.forward()
turtle.turnRight()
turtle.turnRight()



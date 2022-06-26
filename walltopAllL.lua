if not os.loadAPI("turtleEx.lua") then
  error("Could not load turtleEx API")
  return false
end

-- args: 
local targs = {...}
--    specify length
local topLength = 10
--    specify width
local topWidth = 10
--    specify num tries
local numTries = 10
--    specify num tries
local selSlot = 1

local function usage()
  print("Usage: walltopAllL")
  print("  <length> <width>")
  print("  [numTries:" .. numTries .. "] [selSlot:" .. selSlot .. "]")
  print()
end

print("Got " .. #targs .. " arguments")
if (#targs < 1) then
  usage()
  return true
end

if (targs[1] == "help") or (targs[1] == "?") or (#targs < 3) then
  usage()
  return true
end


if targs[1] ~= nil then topLength = tonumber(targs[1]) end
if targs[2] ~= nil then topWidth = tonumber(targs[2]) end
if targs[3] ~= nil then numTries = tonumber(targs[3]) end
if (targs[4] ~= nil) and (tonumber(targs[4]) >= 1) and (tonumber(targs[4]) <= 16) then
  selSlot = tonumber(targs[4])
end

turtle.select(selSlot)

local function placeWallTop(length, numTries)
  local modval = 1

  for i = 1, length do
    print( "[i] = " .. i .. "length = " .. length)
    turtleEx.digForward(numTries)
    for k = 1, 5 do
      turtle.attack()
    end
    turtle.forward()
    sleep(1)

    print("selSlot = " .. selSlot .. ", items = " .. turtle.getItemCount(selSlot))
  
    local itemCount = turtle.getItemCount(selSlot)
    while itemCount < 1 do
      selSlot = selSlot + 1
      turtle.select(selSlot)
      itemCount = turtle.getItemCount(selSlot)
      if (selSlot > 12 ) then 
        print("No material to build with.")
        exit()
      end
    end
    turtleEx.digDown(numTries)
    modVal = i % 2
    if modVal == 1 then
      turtle.placeDown()
    end
  end

  print("placeWallTop - " .. length .. " - Done")
end

placeWallTop(topLength, numTries)
turtle.turnLeft()
placeWallTop(topWidth, numTries)
turtle.turnLeft()
placeWallTop(topLength, numTries)
turtle.turnLeft()
placeWallTop(topWidth - 1, numTries)
turtle.turnLeft()

print("walltopAllL - Done")

return true

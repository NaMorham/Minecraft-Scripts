--
if not os.loadAPI("turtleEx.lua") then
  print("placeaway could not load required API")
  return false
end

local targs={...}
local distance = 1
local numTries = 5
local roofSlot = 1
local rightSlot = -1
local leftSlot = -1

local function Usage()
  print("placeaway <distance> <roof slot>")
  print("          [numTries = 5]")
  print("          [right slot = -1]")
  print("          [left slot = -1]")
end

if #targs < 2 then
  Usage()
  return false
end

distance = tonumber(targs[1])
if (distance < 1) or (distance > 64) then
  print("Invalid distance " .. distance .. " must be (1 <= d <= 64)")
  Usage()
  return false
end

roofSlot = tonumber(targs[2])
if (roofSlot < 1) or (roofSlot > 16) then
  print("Invalid roof slot " .. roofSlot .. " must be (1 <= n <= 16)")
  Usage()
  return false
end


if targs[3] ~= nil then 
  numTries = tonumber(targs[3])
end
if (numTries < 1) then
  print("Invalid number of tries " .. numTries .. ", must be > 1")
  Usage()
  return false
end


if targs[4] ~= nil then
  rightSlot = tonumber(targs[4])
end
if (rightSlot == roofSlot) then
  print("Invalid right slot " .. rightSlot .. " must not be the same as the roof slot")
  Usage()
  return false
end
if (rightSlot < 1) or (rightSlot > 16) then
  rightSlot = 0
  print("Not using left slot")
end


if targs[5] ~= nil then
  leftSlot = tonumber(targs[5])
end
if (leftSlot == roofSlot) or (leftSlot == rightSlot) then
  print("Invalid left slot " .. leftSlot .. " must not be the same as the roof or right slots")
  Usage()
  return false
end
if (leftSlot < 1) or (leftSlot > 16) then
  leftSlot = 0
  print("Not using left slot")
end


--
for i = 1, distance do
  print( "[i] = " .. i .. ", distance = " .. distance)
  
  turtleEx.digForward(numTries)
  for k = 1, 5 do
    turtle.attack()
  end
  if not turtle.forward() then
    print("Cannot move forward")
    return false
  end
  sleep(1)

  -- now in place, check above and place
  if not turtle.detectUp() then
    turtle.select(roofSlot)
    turtle.placeUp()
  end
  
  -- if needed, turn right and place
  if not (rightSlot == 0) then
    turtle.turnRight()
    if not turtle.detect() then
      turtle.select(rightSlot)
      turtle.place()
    end
    turtle.turnLeft()
  end
  
  -- if needed, turn left and place
  if not (leftSlot == 0) then
    turtle.turnLeft()
    if not turtle.detect() then
      turtle.select(leftSlot)
      turtle.place()
    end
    turtle.turnRight()
  end
  
  sleep(1)
end

print ("Done placing, return to start")
for i = 1, distance do
  turtle.back()
end

print("Done")
return true

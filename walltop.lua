if not os.loadAPI("turtleEx.lua") then
  error("Could not load turtleEx API")
  return false
end

local targs={...}
local numBlocks = 1
local selSlot = 1
local numTries = 5

if targs[1] ~= nil then numBlocks = targs[1] end

if targs[2] ~= nil then numTries = targs[2] end

turtle.select(selSlot)

local modval = 1

for i = 1, numBlocks do
  print( "[i] = " .. i .. "numBlocks = " .. numBlocks )
  turtleEx.digForward(numTries)
  for k = 1, 5 do
    turtle.attack()
  end
  turtle.forward()
  sleep(1)

  print( "selSlot = " .. selSlot .. ", items = " .. turtle.getItemCount(selSlot) )
  
  local itemCount = turtle.getItemCount( selSlot )
  while itemCount < 1 do
    selSlot = selSlot + 1
    turtle.select(selSlot)
    itemCount = turtle.getItemCount( selSlot )
    if (selSlot > 12 ) then 
      print ( "No material to build with." )
      exit()
    end
  end
  turtleEx.digDown(numTries)
  modVal = i % 2
  if modVal == 1 then
    turtle.placeDown()
  end
end


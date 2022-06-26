local targs={...}
local numBlocks = 1
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
  print("  placeforward <numblocks> [num tries]")
end

if (targs[1] == nil) or (targs[1] == "help") or (targs[1] == "?") then
  usage()
  return false
end

if targs[1] ~= nil then
  numBlocks = tonumber(targs[1])
  if numBlocks < 1 then
    usage()
    return false
  end
end

if targs[2] ~= nil then
  numTries = tonumber(targs[2])
  if numTries < 1 then
    usage()
    return false
  end
end



turtle.select(selSlot)

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
  turtle.placeDown()
end


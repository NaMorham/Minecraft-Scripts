if not os.loadAPI("turtleEx.lua") then
  print("placeaway could not load required API")
  return false
end

local targs={...}
local distance = 1
local numBlocks = 1
local numTries = 5
local selSlot = 1

local function Usage()
  print("placeaway <distance> <numBlocks>")
  print("          [numTries] [select slot]")
end

if #targs < 1 then
  Usage()
  return false
end

distance = tonumber(targs[1])

if targs[2] ~= nil then
  numBlocks = tonumber(targs[2])
end

if targs[3] ~= nil then 
  numTries = tonumber(targs[3]) 
end

if targs[4] ~= nil then
  selSlot = tonumber(targs[4])
end

print("placeaway distance = " .. distance)
print("         numBlocks = " .. numBlocks)
print("          numTries = " .. numTries)
print("           selSlot = " .. selSlot)

turtle.select(selSlot)

-- Move out to distance
for i = 1, distance do
  print( "[i] = " .. i .. " distance = " .. distance )
  turtleEx.digForward(numTries)
  for k = 1, 5 do
    turtle.attack()
  end
  turtle.forward()
end

-- Move back, place as required
for j = 1, distance do 
  print( "[j] = " .. j .. " distance = " .. distance )
  if (j <= numBlocks) then
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
  turtle.back()
end


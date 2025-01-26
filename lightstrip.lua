local targs={...}
local torchSlot = 1
local distance = 20
local continue = 0
local numTries = 21


if not os.loadAPI("turtleEx") then
  error("Could not load required api.")
  return
end


-- args {num branches, branch size, numtries}
local function usage()
  print("Usage")
  print("  lightstrip <distance> <torchSlot>")
end

if (#arg < 2) or (targs[1] == nil) or (targs[1] == "help") or (targs[1] == "?") then
  usage()
  return false
end

-- distance
if targs[1] ~= nil then
  distance = tonumber(targs[1])
  if distance < 5 then
    print("Invalid distance")
    distance = 20
	continue=0
  else
    continue=1
  end
else
  print("Missing distance")
  continue=0
end


-- torch slot
if (continue == 1) then
  if (targs[2] ~= nil) then
    torchSlot = tonumber(targs[2])
    if torchSlot < 1 or torchSlot > 16 then
      print("Invalid slot passed for torches")
      torchSlot = 0
	  continue=0
    else
	  continue=1
    end
  else
    print("No torch slot provided")
    torchSlot = 0
    continue=0
  end
end


if (continue == 1) then
  print("Place lightstrip")
  for i = 1, distance do
    if not turtleEx.digForward(numTries) then
      error("Could not dig forward")
      return false
    else
      turtle.forward()
	  turtle.digDown()
	  
      local modVal = (i % 5)
	  if (modVal == 0) then
	    turtle.select(torchSlot)
		turtle.placeDown()
	  end -- if mod5
    end
  end
end


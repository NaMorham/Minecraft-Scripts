local targs={...}
local torchSlot = 16
local enderSlot = 16
local direction = "down"


if not os.loadAPI("turtleEx.lua") then
  error("Could not load required api.")
  return
end


-- args {num branches, branch size, numtries}
local function usage()
  print("Usage")
  print("  dropAllItems <direction> ")
  print("      [torchSlot] [ender chest slot]")
end

if (targs[1] == nil) or (targs[1] == "help") or (targs[1] == "?") then
  usage()
  return false
end


-- get the direction >= 1
if targs[1] ~= nil then
  directionStr = targs[1]
  if directionStr == "forward" then
  	direction = 0
  	print("Drop forward")
  elseif directionStr == "up" then
  	direction = 1
  	print("Drop up")
  elseif directionStr == "down" then
  	direction = 2
  	print("Drop Down")
  else
  	usage()
  	return false
  end
else
  error("Invalid drop direction")
  usage()
  return false
end


-- torch slot
if targs[2] ~= nil then
  torchSlot = tonumber(targs[2])
  if torchSlot < 1 or torchSlot > 16 then
    print("Invalid slot passed for torches")
    torchSlot = 0
  end
else
  print("Not using torches")
end


-- ender chest slot
if targs[3] ~= nil then
  enderSlot = tonumber(targs[3])
  if enderSlot < 1 or enderSlot > 16 then
    print("Invalid slot passed for ender chest")
    enderSlot = 0
  end
else
  print("Not using ender chest")
end



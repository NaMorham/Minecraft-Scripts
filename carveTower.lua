-- clear roof and building
local targs = {...}
local numLong = 5
local numWide = 5
local dist = 1
local numTries = 9
local height = 2
local innerHeight = 1
local innerLong = 3
local innerWide = 3

if not os.loadAPI("turtleEx") then
  error("Could not load required api.")
  return
end

-- args {numLong, numWide, dist, numtries, height}
-- rely on the api to handle the number of tries

local function usage()
  print("Usage")
  print("  carveTower <long> <wide> <dist> <num tries> <height>")
end

if (targs[1] == nil ) or (targs[1] == "help") or (targs[1] == "?") then
  usage()
  return
end

-- get the length >= 3
if targs[1] ~= nil then
  numLong = tonumber(targs[1])
  if numLong < 3 then
    numLong = 3
  end
end

-- get the width >= 3
if targs[2] ~= nil then
  numWide = tonumber(targs[2])
  if numWide < 3 then
    numWide = 3
  end
end

-- get the distance from start >= 1
if targs[3] ~= nil then
  dist = tonumber(targs[3])
  if dist < 1 then
    dist = 1
  end
end

-- get the numTries >= 1
if targs[4] ~= nil then
  numTries = tonumber(targs[4])
  if numTries < 1 then
    numTries = 1
  end
end

-- get the numTries >= 2
if targs[5] ~= nil then
  height = tonumber(targs[5])
  if height < 2 then
    height = 2
  end
end

print("buildwalls long = " .. numLong .. ", wide = " .. numWide)
print("           dist = " .. dist .. ", num tries = " .. numTries)
print("           height = " .. height)

innerHeight=height-1
innerLong = numLong-2
innerWide = numWide-2

--print(numLong .. "x" .. numWide .. " roof at height " .. height)

--for k = innerHeight, 1, -1 do
--  print(numLong .. "x" .. numWide .. " roof at height " .. k)
--  print(innerLong .. "x" .. innerWide .. " roof at height " .. k)
  
--end

for k = height, 1, -1 do
  print(numLong .. "x" .. numWide .. " roof at " .. dist .. " and height " .. k)
  shell.run( "buildroof", numLong, numWide, dist, numTries, height )
  print(innerLong .. "x" .. innerWide .. " roof at " .. dist+1 .. " and height " .. k)
  shell.run( "clearRoof.lua", numLong, numWide, dist+1, numTries, height )
end

os.loadAPI("turtleEx")

local targs = {...}
local dist = 1

if (targs[1] == nil) then
  print("No distance specified.")
  return
end

dist = tonumber(targs[1])
if (dist < 1) then
  print("Invalid distance specified = \"" .. targs[1] .. "\"")
  return
end

local count = 0
for i = 1,dist do
  if not turtleEx.digForward(11) then
    print("Cannot dig further")
    break
  end
  turtle.forward()
  count = count + 1
end

for i = 1,count do
  turtle.back()
end

print("Done.")


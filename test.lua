os.loadAPI("turtleEx.lua")

-- try up
for i = 1, 3 do
  turtleEx.digUp(15)
  turtle.up()
end

for i = 1, 3 do
  turtle.down()
end

-- forwards
for i = 1, 3 do
  turtleEx.digForward(15)
  turtle.forward()
end

for i = 1, 3 do
  turtle.back()
end

-- invalid value args 
if turtleEx.digUp(-1) then
  error("digUp(-1) should have failed")
end

if turtleEx.digForward(-1) then
  error("digForward(-1) should have failed")
end

-- bad args
if turtleEx.digUp("foom") then
  error("digUp(\"foom\") should have failed")
end

if turtleEx.digForward("woop") then
  error("digForward(\"woop\") should have failed")
end


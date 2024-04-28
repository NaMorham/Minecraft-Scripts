-- place auto run code here
local numBlocks = 15
local numTries = 21

if not os.loadAPI("turtleEx.lua") then
  error("Could not load required api.")
  return
end

--for i = 1, numBlocks do
--  print("Dig block " .. i .. "/" .. numBlocks)

--  print("    clear ahead")
--  if not turtleEx.digForward(numTries) then
--    print("cannot continue digging")
--    return false
--  end

--  turtle.forward()

--end

-- requires a mining turtle
local targs = {...}
local numBlocks = 1
local dfltTries = 10
local numTries = dfltTries

if not os.loadAPI("turtleEx") then
  error("Could not load required api.")
  return
end

local function showHelp()
    print("Usage: clearforward [numBlocks] [numTries]")
    print("Where:")
    print("   numBlocks is the number of blocks to move forward (defaults to 1)")
    print("   numTries is the number of times to try clearing ahead (defaults to "..dfltTries)
    print(" ")    
end

-- parse args
if targs[1] ~= nil then
    -- check for help
    if targs[1] == "h" or targs[1] == "help" or targs[1] == "?" then
        showHelp()
        return
    end
    numBlocks = tonumber(targs[1])
    if numBlocks < 1 then
        numBlocks = 1
    end    
end

if targs[2] ~= nil then
    numTries = tonumber(targs[2])
    if numTries < 1 then
        numTries = dfltTries
    end
end

for i=1,numBlocks do
  turtleEx.digForward(numTries)
  turtle.forward()
  turtleEx.digUp(numTries)
  turtle.digDown()
end

print("Done.")


local targs = {...}

if not os.loadAPI("turtleEx.lua") then
  error("Could not load required api.")
  return
end

print("Run from 1 to 16")
turtleEx.hasInvSpace(1, 16)


print(" ")
print("Run from 2 to 8")
turtleEx.hasInvSpace(2, 8)


print(" ")
print("Run from 10 to 5")
turtleEx.hasInvSpace(10, 5)


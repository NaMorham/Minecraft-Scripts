local targs = {...}
local forwardDist = 3
local branchSize = 15
local numTries = 3

if not os.loadAPI("turtleEx") then
  error("Could not load required api.")
  return
end

-- 5 19 2 21 0
-- 5  9 2 21 0

-- 5  9 2 21 3
-- 5 19 2 21 3

-- 5 19 2 21 5
-- 5  9 2 21 5
-- up 2
-- 3 11 3 21 0
-- 3 21 3 21 0

-- 3 21 3 21 3
-- 3 11 3 21 3
-- up 2
-- 3 23 4 21 0
-- 3 13 4 21 0

-- 3 13 4 21 3
-- 3 23 4 21 3
-- up 2
-- 3 15 5 21 0
-- 3 25 5 21 0

-- 3 25 5 21 3
-- 3 15 5 21 3
-- up 2
-- 3 27 6 21 0
-- 3 17 6 21 0
-- up 2
-- 3 29 7 21 0
-- 3 19 7 21 0
-- up 2

shell.run("buildroof", 5, 9, 2, 21, 0)
shell.run("buildroof", 5, 19, 2, 21, 3)
shell.run("buildroof", 5, 9, 2, 21, 5)

if not turtleEx.mineUp(2, numTries) then
  error("Cannot mine - move up")
  return false
end

shell.run("buildroof", 5, 21, 3, 21, 0)
shell.run("buildroof", 5, 11, 3, 21, 3)

if not turtleEx.mineUp(2, numTries) then
  error("Cannot mine - move up")
  return false
end

shell.run("buildroof", 3, 23, 6, 21, 0)
shell.run("buildroof", 3, 13, 6, 21, 3)

if not turtleEx.mineUp(2, numTries) then
  error("Cannot mine - move up")
  return false
end

shell.run("buildroof", 3, 25, 7, 21, 0)
shell.run("buildroof", 3, 15, 7, 21, 3)

if not turtleEx.mineUp(2, numTries) then
  error("Cannot mine - move up")
  return false
end

shell.run("buildroof", 3, 27, 8, 21, 0)

if not turtleEx.mineUp(2, numTries) then
  error("Cannot mine - move up")
  return false
end

shell.run("buildroof", 3, 19, 9, 21, 0)

return true


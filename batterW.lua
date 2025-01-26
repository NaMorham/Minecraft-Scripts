local targs = {...}
local forwardDist = 5
local upDist = 0
local widthW = 0
local numTries = 21

if not os.loadAPI("turtleEx") then
  error("Could not load required api.")
  return
end

-- 5 19 2 21 0 -- 5  9 2 21 0
-- 5  9 2 21 3 -- 5 19 2 21 3
-- 5 19 2 21 5 -- 5  9 2 21 5
-- up 2

-- 5 11 3 21 0 -- 5 21 3 21 0
-- 5 21 3 21 3 -- 5 11 3 21 3
-- up 2

-- 5 23 4 21 0 -- 5 13 4 21 0
-- 5 13 4 21 3 -- 5 23 4 21 3
-- up 2

-- 5 15 5 21 0 -- 5 25 5 21 0
-- 5 25 5 21 3 -- 5 15 5 21 3
-- up 2

-- 5 27 6 21 0 -- 5 17 6 21 0
-- up 2

-- 5 29 7 21 0 -- 5 19 7 21 0
-- up 2

-- forwardDist = 5
-- shell.run("buildroof", forwardDist, width, offset, numTries, upDist)

if not shell.run("buildroof", 5, 19, 2, 21, 0) then
  error("Cannot buildroof 5 19 2 21 0")
  return false
end
if not shell.run("buildroof", 5, 19, 2, 21, 3) then
  error("Cannot buildroof 5 19 2 21 3")
  return false
end
if not shell.run("buildroof", 5, 19, 2, 21, 5) then
  error("Cannot buildroof 5 19 2 21 5")
  return false
end

if not turtleEx.mineUp(2, numTries) then
  error("Cannot mine - move up")
  return false
end

if not shell.run("buildroof", 5, 21, 3, 21, 0) then
  error("Cannot buildroof 5 21 3 21 0")
  return false
end
if not shell.run("buildroof", 5, 21, 3, 21, 3) then
  error("Cannot buildroof 5 21 3 21 3")
  return false
end

if not turtleEx.mineUp(2, numTries) then
  error("Cannot mine - move up")
  return false
end

if not shell.run("buildroof", 3, 23, 6, 21, 0) then
  error("Cannot buildroof 3 23 6 21 0")
  return false
end
if not shell.run("buildroof", 3, 23, 6, 21, 3) then
  error("Cannot buildroof 3 23 6 21 3")
  return false
end

if not turtleEx.mineUp(2, numTries) then
  error("Cannot mine - move up")
  return false
end

if not shell.run("buildroof", 3, 25, 7, 21, 0) then
  error("Cannot buildroof 3 23 6 21 0")
  return false
end
if not shell.run("buildroof", 3, 25, 7, 21, 3) then
  error("Cannot buildroof 3 23 6 21 0")
  return false
end

if not turtleEx.mineUp(2, numTries) then
  error("Cannot mine - move up")
  return false
end

if not shell.run("buildroof", 3, 27, 8, 21, 0) then
  error("Cannot buildroof 3 23 6 21 0")
  return false
end

if not turtleEx.mineUp(2, numTries) then
  error("Cannot mine - move up")
  return false
end

if not shell.run("buildroof", 3, 29, 9, 21, 0) then
  error("Cannot buildroof 3 23 6 21 0")
  return false
end

return true


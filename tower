os.loadAPI("turtleEx")
-- Ryan Fechney
-- Builds circular walls
-- Place the turlte at the edge of the circle.  The turtile will build the tower to it's right.
-- Radius is zero for a topwer of boxes

local radius = 4

-- Turle position for edge turning right type circle
local turtlex = -radius
local turtley = 0

-- Turle position for center type circle
-- local turtlex = 0
-- local turtley = 0

-- Declare local function
-- Place a block at a co-ord
local function putBlockAt(gox, goy)
	-- assume tutrtle is facing positive y
	-- deal with positive x direction
	turtle.turnRight()
	while turtlex < gox do
		turtleEx.digForward()
		turtle.forward()
		turtlex = turtlex + 1
	end
	-- deal with negative y direction
	turtle.turnRight()
	while turtley > goy do
		turtleEx.digForward()
		turtle.forward()
		turtley = turtley - 1
	end
	-- deal with negative x direction
	turtle.turnRight()
	while turtlex > gox do
		turtleEx.digForward()
		turtle.forward()
		turtlex = turtlex - 1
	end
	-- deal with positive y direction
	turtle.turnRight()
	while turtley < goy do
		turtleEx.digForward()
		turtle.forward()
		turtley = turtley + 1
	end
	tutrle.placeDown()
end

-- Begin algorithm
-- http://en.wikipedia.org/wiki/Midpoint_circle_algorithm

-- Next pixel position
local x = -radius
local y = 0
local radiusError = 1 - x

-- Loop
while x >= y do
	putBlockAt(x, y)
	putBlockAt(y, x)
	putBlockAt(-x, y)
	putBlockAt(-y, x)
	putBlockAt(-x, -y)
	putBlockAt(-y, -x)
    	putBlockAt(x, -y)
	putBlockAt(y, -x)

	y = y + 1

	if radiusError < 0 then
		radiusError = radiusError + 2 * y + 1
	else
		x = x - 1
		radiusError = radiusError + 2 * (y - x + 1)
	end
end

-- done!

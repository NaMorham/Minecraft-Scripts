-- Attack on a timer if redstone is off

local rsColour = colours.white
local delay = 2


while (true) do
  if not redstone.testBundledInput("bottom", rsColour) then
    turtle.attack()
  end
  sleep(delay)
end

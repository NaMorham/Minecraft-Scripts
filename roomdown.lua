
-- move to middle of floor
for i = 1,2 do
  turtle.down()
end

-- move to back-left corner
turtle.turnLeft()
for i = 1,4 do
  turtle.forward()
end
turtle.turnRight()
for i = 1,4 do
  turtle.back()
end

-- edge of the base
for j = 1,2 do
  for i = 1,4 do
    shell.run( "placeforward", 8)
    turtle.turnRight()
  end
  turtle.up()
end

turtle.forward()
turtle.turnRight()
turtle.forward()
turtle.down()
turtle.down()

turtle.placeDown()
for i = 1,4 do
  shell.run( "placeforward", 6 )
  turtle.turnLeft()
  shell.run( "placeforward", 1 )
  turtle.turnLeft()
  shell.run( "placeforward", 6 )
  turtle.turnRight()
  shell.run( "placeforward", 1 )
  turtle.turnRight()
end



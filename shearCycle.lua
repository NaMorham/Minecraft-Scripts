-- 
turtle.select(1)
for i = 1,4 do
  turtle.place()
  turtle.turnRight()
end
for j = 2,16 do
  turtle.select(j)
  turtle.dropUp()
end
turtle.select(1)


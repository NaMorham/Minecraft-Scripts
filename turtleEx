-- pastebin.com/Qu5xynDY

local defaultTries = 15

function digForward(numTries)
  -- parse args
  local _numTries = defaultTries

  if numTries ~= nil then
    if type(numTries) ~= "number" then
      error("Invalid type \""..type.."\" passed for numTries in digForwardEx. Expected number")
    end
    _numTries = numTries
    if _numTries < 1 then
      error("Invalid value for number of retries in digForwardEx, must be 1 or more.")
    end
  end
  -- if no arg, assume default

  turtle.dig()
  local tryCount = 1
  sleep(0.5)
  while turtle.detect() do
    print("Retry dig: " .. tryCount .. "/" .. _numTries)
    turtle.dig()
    tryCount = tryCount + 1
    sleep(0.5)
    if tryCount > _numTries then
      print("Could not dig forward.")
      return false
    end
  end
  
  -- we're done
  return true
end

function digUp(numTries)
  local _numTries = defaultTries
  
  -- parse args
  if numTries ~= nil then
    if type(numTries) ~= "number" then
      error("Invalid type [" .. type(numTries) .. "] passed to digUp, number expected.")
      return false
    end
    
    _numTries = numTries
    if _numTries < 1 then
      error("Invalid arg passed to digUp, must be 1 or more")
      return false
    end
  end
  
  turtle.digUp()
  sleep(0.5)
  local tryCount = 1
  while turtle.detectUp() do
    print("Retry dig up: " .. tryCount .. "/" .. _numTries)
    turtle.digUp()
    tryCount = tryCount + 1
    sleep(0.5)
    
    if tryCount >= _numTries then
      print("Cannot dig up.")
      return false
    end
  end
  
  -- we're done
  return true
end

function digDown(numTries)
  local _numTries = defaultTries
  
  -- parse args
  if numTries ~= nil then
    if type(numTries) ~= "number" then
      error("Invalid type [" .. type(numTries) .. "] passed to digDown, number expected.")
      return false
    end
    
    _numTries = numTries
    if _numTries < 1 then
      error("Invalid arg passed to digDown, must be 1 or more")
      return false
    end
  end
  
  turtle.digDown()
  sleep(0.5)
  local tryCount = 1
  while turtle.detectDown() do
    print("Retry dig down: " .. tryCount .. "/" .. _numTries)
    turtle.digDown()
    tryCount = tryCount + 1
    sleep(0.5)
    
    if tryCount >= _numTries then
      print("Cannot dig down.")
      return false
    end
  end
  
  -- we're done
  return true
end

-- attempt to place a block ahead
function replaceahead(slot, numTries)
  local _numTries = defaultTries
  local _slot = 1
  
  -- parse args --
  -- the slot to place
  if slot == nil then
    error("missing argument for replaceahead. Slot ID must not be nil")
    return false
  else
    if type(slot) ~= "number" then
      error("Invalid type [" .. type(slot) .. "] passed to replaceAhead - slot ID, number expected.")
      return false
    end
    
    _slot = slot
    if (_slot < 1) or (_slot > 16) then
      error("Invalid slot ID (" .. _slot .. ") passed to replaceAhead, must be within 1 and 16 ")
      return false
    end
  end

  -- the number of tries
  if numTries ~= nil then
    if type(numTries) ~= "number" then
      error("Invalid type [" .. type(numTries) .. "] passed to replaceAhead - num tries , number expected.")
      return false
    end
    
    _numTries = numTries
    if _numTries < 1 then
      error("Invalid arg passed to replaceAhead, must be 1 or more")
      return false
    end
  end
  
  -- first just try and place
  if not turtle.place() then
    print("Could not place the block in slot "..slot". Try to quickly dig and place")
    turtle.dig()
    if not turtle.place() then
      -- at this point we could not place it, dig
      -- and place quickly.  This means we have
      -- to clear out whatever is in the way
      print("Could not dig and place the block in slot "..slot". Remove the block ahead")
      if not digForward(_numTries) then
        -- can't be done
        print("Could not replace the block ahead.")
        return false
      end
      turtle.place()
    end
  end
  
  -- we're done
  return true
end


-- attempt to place a block above
function replaceabove(slot, numTries)
  local _numTries = defaultTries
  local _slot = 1
  
  -- parse args --
  -- the slot to place
  if (slot == nil) then
    error("missing argument for replaceabove. Slot ID must not be nil")
    return false
  else
    if type(slot) ~= "number" then
      error("Invalid type [" .. type(slot) .. "] passed to replaceabove - slot ID, number expected.")
      return false
    end
    
    _slot = slot
    if (_slot < 1) or (_slot > 16) then
      error("Invalid slot ID (" .. _slot .. ") passed to replaceabove, must be within 1 and 16 ")
      return false
    end
  end

  -- the number of tries
  if (numTries ~= nil) then
    if type(numTries) ~= "number" then
      error("Invalid type [" .. type(numTries) .. "] passed to replaceabove, number expected.")
      return false
    end
    
    _numTries = numTries
    if _numTries < 1 then
      error("Invalid arg (" .. _numTries .. ") passed to replaceabove, must be 1 or more")
      return false
    end
  end
  
  -- first just try and place
  if not turtle.placeUp() then
    print("Could not place the block in slot "..slot". Try to quickly dig and place")
    turtle.digUp()
    if not turtle.placeUp() then
      -- at this point we could not place it, dig
      -- and place quickly.  This means we have
      -- to clear out whatever is in the way
      print("Could not dig and place the block in slot "..slot". Remove the block ahead")
      if not digUp(_numTries) then
        -- can't be done
        print("Could not replace the block ahead.")
        return false
      end
      turtle.placeUp()
    end
  end
  
  -- we're done
  return true
end

-- attempt to place a block below
function replacebelow(slot, numTries)
  local _numTries = defaultTries
  local _slot = 1
  
  -- parse args --
  -- the slot to place
  if slot == nil then
    error("missing argument for replacebelow. Slot ID must not be nil")
    return false
  else
    if type(slot) ~= "number" then
      error("Invalid type [" .. type(slot) .. "] passed to replacebelow - slot ID, number expected.")
      return false
    end
    
    _slot = slot
    if (_slot < 1) or (_slot > 16) then
      error("Invalid slot ID (" .. _slot .. ") passed to replacebelow, must be within 1 and 16 ")
      return false
    end
  end

  -- the number of tries
  if numTries ~= nil then
    if type(numTries) ~= "number" then
      error("Invalid type [" .. type(numTries) .. "] passed to replacebelow, number expected.")
      return false
    end
    
    _numTries = numTries
    if _numTries < 1 then
      error("Invalid arg (" .. _numTries .. ") passed to replacebelow, must be 1 or more")
      return false
    end
  end
  
  -- first just try and place
  if not turtle.placeDown() then
    print("Could not place the block in slot "..slot". Try to quickly dig and place")
    turtle.digDown()
    if not turtle.placeDown() then
      -- at this point we could not place it, dig
      -- and place quickly.  This means we have
      -- to clear out whatever is in the way
      print("Could not dig and place the block in slot "..slot". Remove the block ahead")
      if not digDown(_numTries) then
        -- can't be done
        print("Could not replace the block below.")
        return false
      end
      turtle.placeDown()
    end
  end
  
  -- we're done
  return true
end

-- attempt to place a block below
function placeDown(numTries)
  local _numTries = defaultTries
  
  -- parse args --
  -- the number of tries
  if numTries ~= nil then
    if type(numTries) ~= "number" then
      error("Invalid type [" .. type(numTries) .. "] passed to placeDown, number expected.")
      return false
    end
    
    _numTries = numTries
    if _numTries < 1 then
      error("Invalid arg (" .. _numTries .. ") passed to placeDown, must be 1 or more")
      return false
    end
  end
  
  local numAttempts = 0
  
  while (turtle.detectDown() == false) and (numAttempts < _numTries) do
  
    if not turtle.placeDown() then
      print("Cannot placeDown")
      return false
    end
    
    numAttempts = numAttempts + 1
  end
  
  -- we're done
  return true
end

-- attempt to place a block below
function placeUp(numTries)
  local _numTries = defaultTries
  
  -- parse args --
  -- the number of tries
  if numTries ~= nil then
    if type(numTries) ~= "number" then
      error("Invalid type [" .. type(numTries) .. "] passed to placeUp, number expected.")
      return false
    end
    
    _numTries = numTries
    if _numTries < 1 then
      error("Invalid arg (" .. _numTries .. ") passed to placeUp, must be 1 or more")
      return false
    end
  end
  
  local numAttempts = 0
  
  while (turtle.detectDown() == false) and (numAttempts < _numTries) do
  
    if not turtle.placeUp() then
      print("Cannot placeUp")
      return false
    end
    
    numAttempts = numAttempts + 1
  end
  
  -- we're done
  return true
end

-- check inventory for empty space
function hasInvSpace(startIdx, endIdx)
  local _startIdx = 1
  local _endIdx = 16
  
  if startIdx ~= nil then
    if type(startIdx) ~= "number" then
      error("Invalid type passed as start slot id.  Must be in the range 1 <= x <= 16 only")
      return false
    end
    if (startIdx < 1) or (startIdx > 16) then
      error("Invalid start location: " .. start)
      return false
    end
    _startIdx = startIdx
  end
  
  if endIdx ~= nil then
    if type(endIdx) ~= "number" then
      error("Invalid type passed as end slot id")
      return false
    end
    if (endIdx < 1) or (endIdx > 16) then
      error("Invalid end slot id value: " .. endIdx)
      return false
    end
    _endIdx = endIdx
  end
  
  local idx = 1
  local incr = 1
  if _startIdx > _endIdx then
    incr = -1
  end
  for i = _startIdx,_endIdx,incr do
    print("[" .. idx .. "] Select slot " .. i)
    idx = idx + 1
  end
end

-- ----------------------------------------------------------------
-- move forward
function forward(numBlocks)
  local _numBlocks = 1
  if numBlocks ~= nil then
    _numBlocks = tonumber(numBlocks)
  end
  if (_numBlocks < 1) then
    _numBlocks = 1
  end
  
  for i = 1,_numBlocks do
    if not turtle.forward() then
      error("Cannot move forward.")
      return false
    end
  end
  
  return true
end

-- move back
function back(numBlocks)
  local _numBlocks = 1
  if numBlocks ~= nil then
    _numBlocks = tonumber(numBlocks)
  end
  if (_numBlocks < 1) then
    _numBlocks = 1
  end
  
  for i = 1,_numBlocks do
    if not turtle.back() then
      error("Cannot move back.")
      return false
    end
  end
  
  return true
end

-- move up
function up(numBlocks)
  local _numBlocks = 1
  if numBlocks ~= nil then
    _numBlocks = tonumber(numBlocks)
  end
  if (_numBlocks < 1) then
    _numBlocks = 1
  end
  
  for i = 1,_numBlocks do
    if not turtle.up() then
      error("Cannot move up.")
      return false
    end
  end
  
  return true
end

-- dig+move up
function mineUp(numBlocks, numTries)
  local _numBlocks = 1
  local _numTries = 5

  if numBlocks ~= nil then
    _numBlocks = tonumber(numBlocks)
  end
  if (_numBlocks < 1) then
    _numBlocks = 1
  end
  
  if numTries ~= nil then
    _numTries = tonumber(numTries)
  end
  if (_numTries < 1) then
    _numTries = 5
  end

  print("MineUp " .. _numBlocks .. " blocks, trying " .. _numTries .. " times")  
  for i = 1,_numBlocks do
    if digUp(numTries) then
      if not turtle.up() then
        error("Cannot move up.")
        return false
      end
	else
	  error("Cannot dig up")
	  return false
	end
  end
  
  return true
end

-- move down
function down(numBlocks)
  local _numBlocks = 1
  if numBlocks ~= nil then
    _numBlocks = tonumber(numBlocks)
  end
  if (_numBlocks < 1) then
    _numBlocks = 1
  end
  
  for i = 1,_numBlocks do
    if not turtle.down() then
      error("Cannot move down.")
      return false
    end
  end
  
  return true
end

-- turn left
function turnLeft(numTurns)
  local _numTurns = 1
  if numTurns ~= nil then
    _numTurns = tonumber(numTurns)
  end
  if (_numTurns < 1) then
    _numTurns = 1
  end
  
  for i = 1,_numTurns do
    if not turtle.turnLeft() then
      error("Cannot turn left.")
      return false
    end
  end
  
  return true
end

-- turn right
function turnRight(numTurns)
  local _numTurns = 1
  if _numTurns ~= nil then
    _numTurns = tonumber(numTurns)
  end
  if (_numTurns < 1) then
    _numTurns = 1
  end
  
  for i = 1,_numTurns do
    if not turtle.turnRight() then
      error("Cannot turn right.")
      return false
    end
  end
  
  return true
end


--- clear inventory
--- TODO: Modify to take a list of slots to ignore
function dumpAllItems(nTries, tSlot, eSlot)
  local _nTries = 5
  local _eSlot = 15
  local _tSlot = 16

  if nTries == nil or tSlot == nil or eSlot == nil then
    print("Invalid args passed to dumpItems")
    return false
  end

  if type(nTries) == "number" then
    _nTries = nTries
  else
    print("Invalid type for num tries arg \"" .. type(nTries) .. "\"")
    return false
  end

  if type(tSlot) == "number" then
    _tSlot = tSlot
  else
    print("Invalid type for torch slot arg \"" .. type(tSlot) .. "\"")
    return false
  end

  if type(eSlot) == "number" then
    _eSlot = eSlot
  else
    print("Invalid type for ender slot arg \"" .. type(eSlot) .. "\"")
    return false
  end

  if _eSlot < 1 or _eSlot > 16 then
    -- nothing to do
    return true
  end
  
  print("--- Place chest ---")
  if turtle.detectUp() then
    print("--- Clear room for ender chest ---")
    if not turtleEx.digUp(_nTries) then
      print("Could not clear room for ender chest")
      return false
    end
  end

  print("--- Select ender slot ---")
  turtle.select(_eSlot)
  print("--- Place ender chest ---")
  if not turtle.placeUp() then
    print("Could not place ender chest")
    return false
  end
  
  -- we have a chest above us to use, drop it all
  for i = 1, 16 do
    if i == _eSlot or i == _tSlot then
      print("Skip slot " .. i)
    else
      turtle.select(i)
      print("Empty slot " .. i)
      local numItems = turtle.getItemCount(i)
      if numItems > 0 then
        turtle.dropUp(numItems)
      end
    end
  end
  
  -- recover the chest
  turtle.select(_eSlot)
  if not turtleEx.digUp(_nTries) then
    print("Cannot recover chest")
    return false
  end
  
  return true
end


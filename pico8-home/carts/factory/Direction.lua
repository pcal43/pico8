

local Direction = {}
Direction.new = function(number, dx, dy)
  local self = {}
  self.dx = dx
  self.dy = dy
  self.number = number
  
  function self.getVector()
    return dx, dy
  end

  function self.apply(x, y)
    return x + dx, y + dy
  end

  return self
end

RIGHT  = Direction.new(1, 1,0)
DOWN   = Direction.new(2, 0,1)
LEFT   = Direction.new(3, -1,0)
UP     = Direction.new(4, 0,-1)

DIRECTIONS = { RIGHT, DOWN, LEFT, UP }

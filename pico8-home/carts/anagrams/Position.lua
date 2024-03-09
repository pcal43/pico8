
local Position = {}
Position.new = function(_x, _y)
  local self = {}
  self.x = _x or 0
  self.y = _y or 0

  function self.move(dir)
    self.x += dir.dx
    self.y += dir.dy
    return self
  end

  function self.copy() 
    return Position.new(self.x, self.y)
  end

  function self.equals(pos)
    return self.x == pos.x and self.y == pos.y
  end

  return self
end

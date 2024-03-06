
local Position = {}
Position.new = function(_x, _y)
  local self = {}
  self.x = _x
  self.y = _y

  function self.move(dir)
    self.x += dir.dx
    self.y += dir.dy
    return self
  end

  function self.copy() 
    return Position.new(self.x, self.y)
  end

  return self
end

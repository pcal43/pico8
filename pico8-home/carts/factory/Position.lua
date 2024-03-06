
local Position = {}
Position.new = function(x, y)
  local self = {}
  self.x = x
  self.y = y

  function self.move(dir)
    self.x += dir.dx
    self.y += dir.dy
    return self
  end

  function self.copy(dir)
    return Position.new(self.x + dir.dx,  self.y + dir.dy)
  end

  return self
end

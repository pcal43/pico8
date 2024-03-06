
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

  return self
end

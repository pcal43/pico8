
local Rectangle = {}
Rectangle.new = function(_x, _y, _w, _h)
    local self = {}
    self.x = _x or 0
    self.y = _y or 0
    self.w = _w or 0
    self.h = _h or 0

    function self.contains(_x, _y)
        return _x >= self.x and _x < self.x + self.w and _y >= self.y and _y < self.y + self.h
    end

    function self.containsPos(pos)
        return pos.x >= self.x and pos.x < self.x + self.w and pos.y >= self.y and pos.y < self.y + self.h
    end

    return self
end


local Position = {}
Position.new = function(_x, _y)
    local self = {}
    self.x = _x or 0
    self.y = _y or 0

    function self.move(dir)
        self.x += dir.dx()
        self.y += dir.dy()
        return self
    end

    function self.set(_x, _y)
        self.x = _x or 0
        self.y = _y or 0
        return self
    end

    function self.copy() 
        return Position.new(self.x, self.y)
    end

    function self.equals(pos)
        return self.x == pos.x and self.y == pos.y
    end

    function self.toString() 
        return "(" .. tostr(self.x) .. "," .. tostr(self.y) .. ")"
    end

    return self
end

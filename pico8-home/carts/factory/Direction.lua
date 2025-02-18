local Direction = {}
Direction.new = function(number, _dx, _dy)
    local self = {}
    self.dx = _dx
    self.dy = _dy
    self.number = number

    function self.copy()
        return Direction.new(number, self.dx, self.dy)
    end

    function self.getVector()
        return self.dx, self.dy
    end

    function self.apply(x, y)
        return x + self.dx, y + self.dy
    end

    return self
end

RIGHT  = Direction.new(1, 1,  0)
DOWN   = Direction.new(2, 0,  1)
LEFT   = Direction.new(3, -1, 0)
UP     = Direction.new(4, 0, -1)

DIRECTIONS = { RIGHT, DOWN, LEFT, UP }

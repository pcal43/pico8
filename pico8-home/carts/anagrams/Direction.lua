local Direction = {}
Direction.new = function(dx, dy, number)
    if (DIRECTIONS != nil) printh("ERROR! do not create new Directions!")
    local self = {}
    self.number = number

    function self.isZero()
        return dx == 0 and dy == 0
    end

    function self.dx()
        return dx
    end

    function self.dy()
        return dy
    end

    return self
end

RIGHT  = Direction.new(1,  0, 1)
DOWN   = Direction.new(0,  1, 2)
LEFT   = Direction.new(-1, 0, 3)
UP     = Direction.new(0, -1, 4)
ZERO   = Direction.new(0, 0, -1)

DIRECTIONS = { RIGHT, DOWN, LEFT, UP }


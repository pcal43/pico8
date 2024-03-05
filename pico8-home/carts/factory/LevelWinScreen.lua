
local LevelWinScreen = {}
LevelWinScreen.new = function(level)
    self = {}

    function self.update()
    end

    function self.draw()
        cls(11)
    end
    return self
end

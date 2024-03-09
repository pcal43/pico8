
local LevelWinScreen = {}
LevelWinScreen.new = function(level)
    local self = {}

    function self.update()
        if (btnp(5)) CONTROLLER.nextLevel()
    end

    function self.draw()
        rectfill(20,20,110,40, 1)
        print("Nice!  Ready for next?", 22,22, 7)
    end
    return self
end

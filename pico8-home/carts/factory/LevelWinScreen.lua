
local LevelWinScreen = {}
LevelWinScreen.new = function(level)
    local self = {}

    function self.update()
        if (btn(5)) CONTROLLER.nextLevel()
    end

    function self.draw()
        rectfill(20,20,100,40, 1)
        print("Ready for next?", 22,22, 7)
    end
    return self
end

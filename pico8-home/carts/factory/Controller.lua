
CONTROLLER = nil

local Controller = {}
Controller.new = function()
    self = {}
    self.activeScreen = nil

    function self.notifyCakeMade()
        self.activeScreen = LevelWinScreen.new()
    end

    function self.notifyInit()
        self.activeScreen = LevelWinScreen.new()
    end

    function self.showTitle()
        self.activeScreen = LevelRunScreen.new(LEVELS[2])
    end    

    return self
end

function initController()
    CONTROLLER = Controller.new()
    CONTROLLER.showTitle()
end

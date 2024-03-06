
CONTROLLER = nil

local Controller = {}
Controller.new = function()
    self = {}
    local activeScreen = nil

    function self.init()
        initItemTypes()
        initTiles()
        initLevels()
        self.showTitle()
    end

    function self.update() 
        activeScreen.update()
    end

    function self.draw() 
        activeScreen.draw()
    end

    function self.notifyInit()
        activeScreen = LevelWinScreen.new()
    end

    function self.notifyCakeMade()
        activeScreen = LevelWinScreen.new()
    end

    function self.showTitle()
        activeScreen = TitleScreen.new()
    end    

    function self.startLevel(levelNumber)
        printh("start!")
        activeScreen = LevelRunScreen.new(LEVELS[levelNumber])
    end    

    return self
end

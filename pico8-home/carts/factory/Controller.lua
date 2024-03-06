
CONTROLLER = nil

local Controller = {}
Controller.new = function()
    local self = {}
    local activeScreen = nil
    local levelNumber = 1

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

    function self.startLevel()
        activeScreen = LevelRunScreen.new(LEVELS[levelNumber])
    end    

    function self.failLevel()
        activeScreen = LevelWinScreen.new()
    end    

    function self.nextLevel()
        levelNumber += 1
        self.startLevel()
    end    

    return self
end

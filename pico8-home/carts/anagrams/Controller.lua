
CONTROLLER = nil

local Controller = {}
Controller.new = function()
    local self = {}
    local activeScreen = nil
    local modalScreen = nil    
    local levelNumber = 1

    function self.init()
        poke(0x5f2d, 1) -- enable devkit mode
        initTiles()
        initLevels()
        self.showTitle()
    end

    function self.update() 
        if (modalScreen != nil) then
            modalScreen.update()
        else
            activeScreen.update()
        end
   end

    function self.draw() 
        if (activeScreen != nil) activeScreen.draw()
        if (modalScreen != nil) modalScreen.draw()        
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

    function self.wonLevel()
        modalScreen = LevelWinScreen.new()
    end    

    return self
end

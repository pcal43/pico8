
CONTROLLER = nil

local Controller = {}
Controller.new = function()
    local self = {}
    local levelRunScreen = LevelRunScreen.new()
    local levelInfoOverlay = LevelInfoOverlay.new()
    local titleScreen = TitleScreen.new()
    local modalScreen = nil
    local levelNumber = 1
    local showTitle = true


    function self.init()
        poke(0x5f2d, 1) -- enable devkit mode
        initTiles()
        initLevels()
        showTitle = true
    end

    function self.update()
        if (showTitle) then
            if (btnp(5)) self.startLevel()
        else
            if (btnp(5)) levelInfoOverlay.isVisible = not levelInfoOverlay.isVisible
            levelRunScreen.update()        
            levelInfoOverlay.update()
        end
    end

    function self.draw() 
        if (showTitle) then
            titleScreen.draw()
        else
            levelRunScreen.draw()        
            levelInfoOverlay.draw()
        end
    end

    function self.startLevel()
        levelRunScreen.startLevel(LEVELS[levelNumber])
        levelInfoOverlay.level = LEVELS[levelNumber]
        levelInfoOverlay.isVisible = true
        showTitle = false
    end    

    function self.failLevel()
        modalScreen = LevelWinScreen.new()
    end    

    function self.nextLevel()
        levelNumber += 1
        self.startLevel()
    end    

    function self.wonLevel()
        --modalScreen = LevelWinScreen.new()
    end

    return self
end

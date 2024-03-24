
CONTROLLER = nil

local Controller = {}
Controller.new = function()
    local self = {}
    self.cursorPos = Position.new(-1,-1)    
    local levelRunScreen = LevelRunScreen.new(self)
    local levelInfoOverlay = LevelInfoOverlay.new(self)
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
        self.cursorPos.set(flr(stat(32)), flr(stat(33)))
        if (showTitle) then
            if (btnp(5)) self.startLevel()
        else
            --if (btnp(5)) levelInfoOverlay.isVisible = not levelInfoOverlay.isVisible
            levelInfoOverlay.update()
            levelRunScreen.update()
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
        local level = LEVELS[levelNumber]
        levelRunScreen.startLevel(level)
        levelInfoOverlay.startLevel(level)
        showTitle = false
    end    

    function self.failLevel()
        modalScreen = LevelWinScreen.new()
    end    

    function self.resetLevel()
        self.startLevel()
    end    

    function self.exitLevel()
        showTitle = true
    end    

    function self.nextLevel()
        levelNumber += 1
        self.startLevel()
    end    

    function self.levelComplete()
        levelInfoOverlay.levelComplete()
    end

    return self
end

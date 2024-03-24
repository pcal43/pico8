
CONTROLLER = nil

local Controller = {}
Controller.new = function()
    local self = {}
    self.cursorPos = Position.new(-1,-1)    
    local levelRunScreen = LevelRunScreen.new(self)
    local hudScreen = HudScreen.new(self)
    local titleScreen = TitleScreen.new()
    local modalScreen = nil
    local levelNumber = 1
    local showTitle = true
    local isHudFocused = false

    function self.init()
        poke(0x5f2d, 1) -- enable devkit mode
        initTiles()
        initLevels()
        showTitle = true
    end

    function self.setHudFocused(val)
        isHudFocused = val
    end

    function self.update()
        local mouseEnabled = false
        self.cursorPos.set(flr(stat(32)), flr(stat(33)))
        if (showTitle) then
            if (btnp(5)) self.startLevel()
        else
            if (mouseEnabled) then
                if (isHudFocused) then
                    hudScreen.processMouseInput()
                else 
                    levelRunScreen.processMouseInput()
                end
            else
                if (isHudFocused) then
                    hudScreen.processGamepadInput()
                else 
                    levelRunScreen.processGamepadInput()
                end
            end

            --if (btnp(5)) hudScreen.isVisible = not hudScreen.isVisible
            hudScreen.update()
            levelRunScreen.update()
        end
    end

    function self.draw() 
        if (showTitle) then
            titleScreen.draw()
        else
            levelRunScreen.draw(not isHudFocused)        
            hudScreen.draw(isHudFocused)
        end
    end

    function self.startLevel()
        local level = LEVELS[levelNumber]
        levelRunScreen.startLevel(level)
        hudScreen.startLevel(level)
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
        self.setHudFocused(true)
        hudScreen.levelComplete()
    end

    return self
end

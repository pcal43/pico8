
CONTROLLER = nil


local Controller = {}
Controller.new = function()

    local self = {}
    self.cursorPos = Position.new(-1,-1)
    self.frameAlpha = -1
    local levelRunScreen = LevelRunScreen.new(self)
    local hudScreen = HudScreen.new(self)
    local titleScreen = TitleScreen.new(self)
    local endScreen = EndScreen.new(self)
    local modalScreen = nil
    local levelNumber = 1
    local isTitleShown = true -- FIXME this is awful
    local isEndShown = false
    local isHudFocused = false

    local function showTitle()
        isTitleShown = true
        isEndShown = false
        levelRunScreen.startLevel(TITLE_LEVEL)
    end

    local function showEnd()
        isEndShown = true
        isTitleShown = false
        levelRunScreen.startLevel(END_LEVEL)
    end

    function self.init()
        poke(0x5f2d, 1) -- enable devkit mode for mouse controls
        initTiles()
        initLevels()
        showTitle()
    end

    function self.setHudFocused(val)
        isHudFocused = val
    end

    function self.update()
        self.frameAlpha += 1
        local mouseEnabled = false
        self.cursorPos.set(flr(stat(32)), flr(stat(33)))
        if (isTitleShown) then
            levelRunScreen.update()
            if (btnp(BUTTON_MAIN)) self.startLevel()
        elseif (isEndShown) then
            levelRunScreen.update()
            if (btnp(BUTTON_MAIN)) showTitle()
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
            levelRunScreen.update()
        end
    end

    function self.draw() 
        if (isTitleShown) then
            levelRunScreen.draw(false)
            titleScreen.draw()
        elseif (isEndShown) then
            levelRunScreen.draw(false)
            endScreen.draw()
        else
            levelRunScreen.draw(not isHudFocused)        
            hudScreen.draw(isHudFocused)
        end
    end

    function self.startLevel()
        local level = LEVELS[levelNumber]
        levelRunScreen.startLevel(level)
        hudScreen.startLevel(level)
        isTitleShown = false
        self.setHudFocused(false)
    end    

    function self.resetLevel()
        sfx(6)
        self.startLevel()
    end

    function self.exitLevel()
        sfx(8)
        showTitle()
    end

    function self.nextLevel()
        levelNumber += 1
        if (levelNumber > #LEVELS) then
            levelNumber = 1
            showEnd()
        else
            self.startLevel()
        end
    end

    function self.levelComplete()
        self.setHudFocused(true)
        hudScreen.levelComplete()
    end

    return self
end

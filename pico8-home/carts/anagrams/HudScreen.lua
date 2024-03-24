
HudScreen = {}
HudScreen.new = function(controller)
    local self = {}

    local DIALOG_INSET = 32 -- from sides
    local DIALOG_HEIGHT = 8
    local revealY = DIALOG_HEIGHT    
    local BORDER_WIDTH = 1
    local TEXT_MARGIN = 4
    local resetRect = Rectangle.new(127-20, 127-8, 8, 8)
    local exitRect = Rectangle.new(127-8, 127-8, 8, 8)
    local nextRect = Rectangle.new(127-20, 127-8, 17, 8)    
    local frameAlpha = 0
    local spellText
    local levelComplete = false
    local mouseoverRect = nil
    local selectedButton = 0

    function self.levelComplete()
        levelComplete = true
    end

    function self.startLevel(level)
        selectedButton = 0
        spellText = "sPELL \"" .. tostr(level.targetWord) .. "\""
        winText = level.description
        levelComplete = false        
    end

    function self.processGamepadInput()
        -- up or b button
        if (levelComplete) then
            if (btnp(BUTTON_MAIN)) then
                controller.nextLevel()
            end
        else
            if (btnp(BUTTON_AUX) or btnp(BUTTON_UP)) then
                selectedButton = 0
                controller.setHudFocused(false)
            end
            if (btnp(BUTTON_LEFT) and selectedButton == 1) selectedButton = 0
            if (btnp(BUTTON_RIGHT) and selectedButton == 0) selectedButton = 1
            if (btnp(BUTTON_MAIN)) then
                if (selectedButton == 0) then
                    controller.resetLevel()
                else
                    controller.exitLevel()
                end
            end
        end
    end

    function self.processMouseInput()
        local isClicked = isBit(stat(34), 0)
        if (levelComplete) then
            if (isClicked) controller.nextLevel()
        else
            if (resetRect.containsPos(controller.cursorPos)) then
                mouseoverRect = resetRect
                if (isClicked) controller.resetLevel()
            elseif (exitRect.containsPos(controller.cursorPos)) then
                mouseoverRect = exitRect
                if (isClicked) controller.exitLevel()
            else
                mouseoverRect = nil
                text = spellText
            end
        end
    end

    function self.update()
        frameAlpha += 1
    end

    function self.draw(hasFocus)

        --rectfill(127 - 32, 127 - 7, 127 -1, 127 -1, 0)

        local text = spellText
        if (levelComplete) then
            text = winText
            fillRect(nextRect, 0)
            print("nEXT", nextRect.x + 1, 121, 7)
            if (hasFocus) hiliteRect(nextRect, frameAlpha)
        else
            fillRect(resetRect, 0)
            spr(196, resetRect.x, resetRect.y, 1, 1)
            fillRect(exitRect, 0)                        
            spr(197, exitRect.x, exitRect.y, 1, 1)
            if (hasFocus) then
                if (selectedButton == 0) then
                    text = "rESET"
                    hiliteRect(resetRect, frameAlpha)
                else
                    text = "eXIT"
                    hiliteRect(exitRect, frameAlpha)
                end
            end
        end

        rectfill(1, 127 - 7, 1 + (#text * 4), 127 - 1, 0)

        --rectfill(DIALOG_INSET - BORDER_WIDTH, 128  - revealY - BORDER_WIDTH, 128 - DIALOG_INSET + BORDER_WIDTH, 127, 1)
        print(text, 2, 121, 7)
    end

    return self
end


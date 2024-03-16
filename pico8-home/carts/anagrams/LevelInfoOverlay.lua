
LevelInfoOverlay = {}
LevelInfoOverlay.new = function(controller)
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
    local text = nil
    local spellText
    local levelComplete = false

    function self.levelComplete()
        levelComplete = true
    end

    function self.startLevel(level)
        spellText = "sPELL \"" .. tostr(level.targetWord) .. "\""
        winText = level.description
        levelComplete = false        
    end

    function self.update()
        frameAlpha += 1
        if (isBit(stat(34), 0)) then
            if (levelComplete) then
                controller.nextLevel()
            else
                if (resetRect.containsPos(controller.cursorPos)) then
                    controller.resetLevel()
                elseif (exitRect.containsPos(controller.cursorPos)) then
                    controller.exitLevel()
                end
            end
        end    
    end

    function self.draw()

        --rectfill(127 - 32, 127 - 7, 127 -1, 127 -1, 0)

        if (levelComplete) then
            text = winText
            fillRect(nextRect, 0)
            print("nEXT", nextRect.x + 1, 121, 7)
            hiliteRect(nextRect, frameAlpha)
        else
            fillRect(resetRect, 0)
            spr(196, resetRect.x, resetRect.y, 1, 1)
            fillRect(exitRect, 0)                        
            spr(197, exitRect.x, exitRect.y, 1, 1)
            if (resetRect.containsPos(controller.cursorPos)) then
                hiliteRect(resetRect, frameAlpha)
                text = "rESET"
            elseif (exitRect.containsPos(controller.cursorPos)) then
                hiliteRect(exitRect, frameAlpha)
                text = "eXIT"            
            else
                text = spellText
            end
        end

        rectfill(1, 127 - 7, 1 + (#text * 4), 127 - 1, 0)

        --rectfill(DIALOG_INSET - BORDER_WIDTH, 128  - revealY - BORDER_WIDTH, 128 - DIALOG_INSET + BORDER_WIDTH, 127, 1)
        print(text, 2, 121, 7)
    end

    return self
end

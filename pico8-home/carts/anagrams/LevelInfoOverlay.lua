
LevelInfoOverlay = {}
LevelInfoOverlay.new = function(controller)
    local self = {}
    self.level = nil

    local DIALOG_INSET = 32 -- from sides
    local DIALOG_HEIGHT = 8
    local revealY = DIALOG_HEIGHT    
    local BORDER_WIDTH = 1
    local TEXT_MARGIN = 4
    local resetRect = Rectangle.new(127-20, 127-8, 8, 8)
    local exitRect = Rectangle.new(127-8, 127-8, 8, 8)
    local frameAlpha = 0
    local text = nil

    function self.update()
        frameAlpha += 1
        if (isBit(stat(34), 0)) then
            if (resetRect.containsPos(controller.cursorPos)) then
                controller.resetLevel()
            elseif (exitRect.containsPos(controller.cursorPos)) then
                controller.exitLevel()
            end
        end    
    end

    function self.draw()
        spr(196, resetRect.x, resetRect.y, 1, 1)
        spr(197, exitRect.x, exitRect.y, 1, 1)        

        if (resetRect.containsPos(controller.cursorPos)) then
            hiliteRect(resetRect, frameAlpha)
            text = "rESET"
        elseif (exitRect.containsPos(controller.cursorPos)) then
            hiliteRect(exitRect, frameAlpha)
            text = "eXIT"            
        else
            text = "sPELL \"" .. tostr(self.level.targetWord) .. "\""
        end

        --rectfill(DIALOG_INSET - BORDER_WIDTH, 128  - revealY - BORDER_WIDTH, 128 - DIALOG_INSET + BORDER_WIDTH, 127, 1)
        rectfill(1, 127 - 7, 64, 127 -1, 0)
        print(text, 2, 121, 7)
    end

    return self
end

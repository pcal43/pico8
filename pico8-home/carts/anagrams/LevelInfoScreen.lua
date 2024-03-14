
LevelInfoScreen = {}
LevelInfoScreen.new = function(level)
    local self = {}
    local revealY = 0
    local DIALOG_INSET = 8 -- from sides
    local DIALOG_HEIGHT = 32
    local BORDER_WIDTH = 2
    local TEXT_MARGIN = 4

    function self.update()
        if (btnp(5)) CONTROLLER.hideLevelInfo()
        if (revealY < DIALOG_HEIGHT) revealY += 4
    end

    function self.draw()
        rectfill(DIALOG_INSET - BORDER_WIDTH, 128  - revealY - BORDER_WIDTH, 128 - DIALOG_INSET + BORDER_WIDTH, 128 + DIALOG_HEIGHT - revealY, 1)
        rectfill(DIALOG_INSET, 128  - revealY, 128 - DIALOG_INSET, 128 - revealY + DIALOG_HEIGHT, 0)        
        print("tARGET wORD: " .. tostr(level.targetWord) .. "\n\n" .. tostr(level.description), DIALOG_INSET + TEXT_MARGIN, 128 + TEXT_MARGIN - revealY, 7)
    end    

    return self
end

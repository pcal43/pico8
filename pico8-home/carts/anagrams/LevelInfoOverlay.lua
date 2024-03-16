
LevelInfoOverlay = {}
LevelInfoOverlay.new = function()
    local self = {}
    self.level = nil
    local isVisible = false
    local revealY = 0
    local DIALOG_INSET = 8 -- from sides
    local DIALOG_HEIGHT = 16
    local BORDER_WIDTH = 2
    local TEXT_MARGIN = 4

    function self.update()
        if (self.isVisible and revealY < DIALOG_HEIGHT) revealY += 4
        if (not self.isVisible and revealY >= 0) revealY -= 4
    end

    function self.draw()
        rectfill(DIALOG_INSET - BORDER_WIDTH, 128  - revealY - BORDER_WIDTH, 128 - DIALOG_INSET + BORDER_WIDTH, 128 + DIALOG_HEIGHT - revealY, 1)
        rectfill(DIALOG_INSET, 128  - revealY, 128 - DIALOG_INSET, 128 - revealY + DIALOG_HEIGHT, 0)        
        print("tARGET wORD: " .. tostr(self.level.targetWord) .. "\n\n" .. tostr(self.level.description), DIALOG_INSET + TEXT_MARGIN, 128 + TEXT_MARGIN - revealY, 7)
    end    

    return self
end

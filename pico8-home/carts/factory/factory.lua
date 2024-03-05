function _init()
    initItemTypes()
    initTiles()
    initLevels()
    initController()
end

function _update()
    CONTROLLER.activeScreen.update()
end

function _draw()
    CONTROLLER.activeScreen.draw()
end

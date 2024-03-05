
local activeScreen = nil

function _init()
    initItemTypes()
    initTiles()
    initLevels()
    activeScreen = SimulationScreen.new(LEVELS[2])
    activeScreen.init()
end

function cakeMade()
    won = true
    printh("YOU WON!")
end

function _update()
    activeScreen.update()
end

function _draw()
    activeScreen.draw()    
end

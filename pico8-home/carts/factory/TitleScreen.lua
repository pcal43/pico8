
local TitleScreen = {}
TitleScreen.new = function()
    local self = {}

    function self.update()
        if (btn(5)) CONTROLLER.startLevel()
    end

    function self.draw()
        cls(1)
        print("cAKE fACTORY!",20,20)
    end
    return self
end


local TitleScreen = {}
TitleScreen.new = function()
    self = {}

    function self.update()
        if (btn(5)) then
            CONTROLLER.startLevel(2)
        end
    end

    function self.draw()
        cls(1)
        print("cAKE fACTORY!",20,20)
    end
    return self
end

local titleMap = Level.new("welcome!", "WORD", "sTART!",
[[
    .   .   .   .   .   .   .   .
    .   .   .   .   .   .   .   .
    .   .  .   .   .    .   .   .
    .   <   <   <  <    .   .   .
    .   >D  >R  >O  ^W  .   .   .
    .   .   .   .   .   .   .   .
    .   .   .   .   .   .   .   .
    .   .   .   .   .   .   .   .
]])

local TitleScreen = {}
TitleScreen.new = function()
    local self = {}

    function self.update()
    end

    function self.draw()
        cls(1)
        print("cAKE fACTORY!",20,20)
    end
    return self
end

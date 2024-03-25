TITLE_LEVEL = Level.new("welcome!", "TEXTORIO", "sTART!",
[[
    .   .   .   .   .   .   .   .
    .   .   .   .   .   .   .   .
    >O  >   >R  >   >T  >   >E  v
    <   <   <   <   <   <   <   <
    >   >I  >   >O  >   >X  >   ^T
    .   .   .   .   .   .   .   .
    .   .   .   .   .   .   .   .
    .   .   .   .   .   .   .   .
]])


local TitleScreen = {}
TitleScreen.new = function(controller)
    local self = {}

    local startRect = Rectangle.new(127-20, 127-8, 21, 8)   

    function self.draw(hasFocus)
        fillRect(startRect, 0)
        print("sTART", startRect.x + 1, 120, 7)
        hiliteRect(startRect, controller.frameAlpha)
    end

    return self
end

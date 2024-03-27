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
    text = VERSION

    local startRect = Rectangle.new(127-20, 127-8, 21, 8)   

    function self.draw(hasFocus)

        rectfill(1, 127 - 7, 1 + (#text * 4), 127 - 1, 0)
        print(text, 2, 120, 5)

        fillRect(startRect, 0)
        print("sTART", startRect.x + 1, 120, 7)
        hiliteRect(startRect, controller.frameAlpha)
    end

    return self
end

END_LEVEL = Level.new("welcome!", "TEXTORIO", "sTART!",
[[
    .   .   .   .   .   .   .   .
    .T  .H  .A  .N  .K  .S  .   .
    .   .   .   .   .   .   .   .
    .F  .O  .R  .   .   .   .   .
    .   .   .   .   .   .   .   .    
    .P  .L  .A  .Y  .I  .N  .G  .
    .   .   .   .   .   .   .   .
    .   .   .   .   .   .   .   .
]])


local EndScreen = {}
EndScreen.new = function(controller)
    local self = {}

    local startRect = Rectangle.new(127-20, 127-8, 21, 8)   

    function self.draw(hasFocus)
        fillRect(startRect, 0)
        print("yAY!", startRect.x + 1, 120, 7)
        hiliteRect(startRect, controller.frameAlpha)
    end

    return self
end

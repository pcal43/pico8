

ITEMS = nil

ITEM_BUTTER = 1
ITEM_FLOUR = 2
ITEM_SUGAR = 3
ITEM_SPONGE = 4
ITEM_ICING = 5
ITEM_CAKE = 6


local Item = {}
Item.new = function(char, pos, dir)
    local self = {}
    self.char = char
    self.pos = pos.copy()
    self.dir = dir
    self.desiredPos = nil
    self.movePriority = -1

    function self.draw(cx, cy, tileFlags)
        if (self.char < 100) then
            drawSprite(32, cx, cy)
            print(chr(self.char+32), cx + 6, cy + 5, 7)
        else
            drawSprite(34, cx, cy)
        end
    end

    return self
end


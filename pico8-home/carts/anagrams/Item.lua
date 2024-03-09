

ITEMS = nil

ITEM_BUTTER = 1
ITEM_FLOUR = 2
ITEM_SUGAR = 3
ITEM_SPONGE = 4
ITEM_ICING = 5
ITEM_CAKE = 6


local Item = {}
Item.new = function(character, pos, dir)
    local self = {}
    self.character = character
    self.pos = pos.copy()
    self.dir = dir.copy()
    self.desiredPos = nil

    function self.draw(cx, cy, tileFlags)
        drawSprite(32, cx, cy)
        print(chr(self.character), cx + 6, cy + 5, 7)
    end

    return self
end


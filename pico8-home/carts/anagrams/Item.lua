
local Item = {}
Item.new = function(char, pos, dir)
    local self = {}
    self.char = char
    self.pos = pos.copy()
    self.dir = dir
    self.desiredPos = nil
    self.movePriority = -1
    self.blockedExits = { false, false, false, false }
    self.movePriority = -1
    if (char < 100) then 
        self.tileSprite = 32
    else
        self.tileSprite = 34
    end

    function self.draw(cx, cy, tileFlags)
        drawSprite(self.tileSprite, cx, cy) -- red tile
        if (self.char < 100) print(chr(self.char+32), cx + 6, cy + 5, 7)
    end

    function self.setWinner()
        self.tileSprite = 36
        self.desiredPos = nil
        self.dir = ZERO
    end

    function self.isWinner()
        return self.tileSprite == 36
    end

    return self
end

function sortByMovePriority(items)
    for i=1, #items do
        local j = i
        while j > 1 and items[j-1].movePriority > items[j].movePriority do
            items[j], items[j-1] = items[j-1], items[j]
            j = j - 1
        end
    end
end

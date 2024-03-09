LEVELS = nil

Level = {}
Level.new = function(name, targetWord, encodedMap)
    local self = {}
    self.name = name
    
    self.targetWord = targetWord

    self.targetChars = {}
    for i=1,#targetWord do -- pico-8 indexes strings from the right. whatevs
        -- printh(sub(targetWord, i, i).."!!!"..tostr(ord(sub(targetWord, i, i)))) -- the manual is just wrong about how SUB works
        add(self.targetChars, ord(sub(targetWord, i, i)))
    end

    function self.createMap()
        local map = Map.new(0x4300,8,8,1,2)
        local items = {}
        local rows = split(encodedMap, "\n")
        local pos = Position.new()
        for row in all(rows) do
            local onTile = true
            for i = 1, #row do
                c = sub(row, i, i)
                if (onTile) then
                    if (ABBREVS[c]) then 
                        map.setTileP(pos, ABBREVS[c])
                        onTile = false
                    end
                else
                    local cnum = ord(c)
                    if (cnum >= 65 and cnum <=90) then
                        add(items, Item.new(cnum, pos.copy(), ZERO))
                    end
                    pos.x += 1
                    onTile = true
                end
            end
            pos.x = 0
            pos.y += 1
        end

        map.traverseP(function(pos, tileNum, tileFlags)
            TILES[tileNum].onLevelInit(map, pos, tileFlags)
        end)

        return map, items
    end
    return self
end

function initLevels() 
    LEVELS = {}

    add(LEVELS, Level.new("a cAT aCT", "ACT",
    [[
        .  .  .  .  .  .  .  .
        #  #  #  #  #  #  #  #
        #  v  ,  ,  ,  ,  ^  #
        #  v  >  >  >  >  ^  #
        #  v  ,  ,  ,  ,  ^  #
        #  #  #  #  #  #  #  #
        .  .  .  .  .  .  .  .
    ]]))

    add(LEVELS, Level.new("a cAT aCT", "ACT",
    [[
        .  .  .  .  .  .  .  .
        #  #  #  #  #  #  #  #
        #  ,  ,  ,  ,  ,  ,  #        
        #  ,  v  <  <  ,  ,  #
        #  ,  ,  ,C 8A 4T ,  #
        #  ,  ,  ,  -  -  ,  #
        #  #  #  #  #  #  #  #
        .  .  .  .  .  .  .  .
    ]]))

    add(LEVELS, Level.new("a cAT aCT", "ACT",
    [[
        .  .  .  .  .  .  .  .
        #  #  #  #  #  #  #  #
        #  ,  ,  ,  ,  ,  ,  #        
        #  ,  ,  ,  ,  ,  ,  #        
        #  <  #  <  <C <  4  #
        #  ,  ,  =  ,  ,  =  #
        #  #  #  #  #  #  #  #
        .  .  .  .  .  .  .  .
    ]]))

    add(LEVELS, Level.new("bloopey", "what see?",
    [[
        #  #  #  #  #  #  #  #
        !  >  >  >  >  >  >  v
        !  ^  <  4  <  <C <A <T
        !  <  <  =  <  <  <  <
        #  #  #  #  #  #  #  #        
    ]]))

end

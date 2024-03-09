LEVELS = nil

Level = {}
Level.new = function(name, encodedMap)
    local self = {}
    self.name = name
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
                        add(items, Item.new(cnum + 32, pos.copy(), Direction.new(0,0)))
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


    add(LEVELS, Level.new("a cAT aCT",[[
        .  .  .  .  .  .  .  .
        #  #  #  #  #  #  #  #
        #  ,  ,  ,  ,  ,  ,  #        
        #  ,  ,  v  <  <  ,  #
        #  ,  ,  ,  ,C 8A 4T #
        #  ,  ,  ,  ,  =  =  #
        #  #  #  #  #  #  #  #
        .  .  .  .  .  .  .  .
    ]]))

    add(LEVELS, Level.new("a cAT aCT",[[
        .  .  .  .  .  .  .  .
        #  #  #  #  #  #  #  #
        #  ,  ,  ,  ,  ,  ,  #        
        #  ,  ,  ,  ,  ,  ,  #        
        #  <  #  <  <C <  4  #
        #  ,  ,  =  ,  ,  =  #
        #  #  #  #  #  #  #  #
        .  .  .  .  .  .  .  .
    ]]))

    add(LEVELS, Level.new("butc",[[
        #  #  #  #  #  #  #  #
        !  >  >  >  >  >  >  v
        !  ^  <  4  <  <C <A <T
        !  <  <  =  <  <  <  <
        #  #  #  #  #  #  #  #        
    ]]))

end

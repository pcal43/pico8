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
        local tokens = {} 
        for row in all(split(encodedMap, "\n", false)) do
            for token in all(split(row, " ", false)) do
                if (#token > 0) add(tokens, token)
            end
        end
        local pos = Position.new()
        for token in all(tokens) do
            local tile = ABBREVS[token]
            if (not tile) then
                tile = ABBREVS["."]
                printh("WARNING: invalid tile code: '"..token.."'")
            end
            map.setTileP(pos, tile)
            if (pos.x >= 7) then
                pos.x = 0
                pos.y = pos.y + 1
            else
                pos.x = pos.x + 1
            end
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

LEVELS = nil

Level = {}
Level.new = function(name, targetWord, description, encodedMap)
    local self = {}
    self.name = name
    
    self.targetWord = targetWord
    self.description = description or ""

    self.targetChars = {}
    for i=1,#targetWord do -- pico-8 indexes strings from the right. whatevs
        -- printh(sub(targetWord, i, i).."!!!"..tostr(ord(sub(targetWord, i, i)))) -- the manual is just wrong about how SUB works
        add(self.targetChars, ord(sub(targetWord, i, i)))
    end

    function self.createMap()
        local map = Map.new(TILES, 0x4300,8,8,1,2)
        local items = {}
        local tokens = {} 
        for row in all(split(encodedMap, "\n", false)) do
            for token in all(split(row, " ", false)) do
                if (#token > 0) add(tokens, token)
            end
        end
        local pos = Position.new(0,0)
        for token in all(tokens) do
            local lastChar = ord(sub(token,-1,-1))
            if (lastChar >= 65 and lastChar <= 90) then
                token = sub(token,1,-2)
                add(items, Item.new(lastChar, pos.copy(), ZERO))
            elseif (lastChar == 38) then --ampersand
                token = sub(token,1,-2)                
                add(items, Item.new(246, pos.copy(), ZERO)) -- spacer
            end
            local tileNum = ABBREVS[token]
            if (not tileNum) then
                tileNum = 1 --ABBREVS["."]
                printh("WARNING: invalid tile code: '"..token.."'")
            end
            map.setTileNum(pos, tileNum)
            if (pos.x >= 7) then
                pos.x = 0
                pos.y = pos.y + 1
            else
                pos.x = pos.x + 1
            end
        end

        map.traverse(function(pos, tile, tileFlags)
            tile.onLevelInit(map, pos, tileFlags)
        end)

        return map, items
    end
    return self
end

function initLevels() 
    LEVELS = {}


    add(LEVELS, Level.new("ONE NEO", "ONE", "gOODBYE, mR. aNDERSON",
    [[
        .   .   .   .   .   .   .   .        
        .   #   #   #   #   #   #   .
        .   #   v-  v-  v-  #  #   .
        .   #   v!N v!E v!O #   #   .
        .   #   >   >   v   #   #   .
        .   #   ^   <   <   #   #   .
        .   #   #   #   #   #   #   .        
        .   .   .   .   .   .   .   .        
    ]]))


    add(LEVELS, Level.new("dEMO mODE", "MODE", "",
    [[
        .   .   .   .   .   .   .   .        
        .   #   #   #   #   #   #   .
        .   #   v-  v-  v-  v-  #   .
        .   #   v!D v!E v!M v!O #   .        
        .   #   v   <   <   <   #   .        
        .   #   >   >   >   ,   #   .
        .   #   #   #   #   #   #   .
        .   .   .   .   .   .   .   .
        .   .   .   .   .   .   .   .                
    ]]))

    add(LEVELS, Level.new(" STOP", "STOP", "nice job",
    [[
        .   .   .   .   .   .   .   .        
        .   #   #   #   #   #   #   .
        .   #   v-  v-  <-  <-  #   .
        .   #   v!P v!O <!S <!T #   .
        .   #   >   >   >   >   #   .
        .   #   #   #   #   #   #   .
        .   .   .   .   .   .   .   .
        #   #   #   #   #   #   #   #                
    ]]))


-- the wheels of justice turn slowly...
    -- this one makes a good argument for tracking fewest moves

    add(LEVELS, Level.new("PENAL PANEL", "PANEL", "tHE wHEELS oF jUSTICE...",
    [[
        .   .   .   .   .   .   .   .
        #   #   #   #   #   #   #   .
        #   v-  ,   v-  ,   ,   #   .
        #   v!P <E  v!N <A <L   #   .
        #   v   #   v   #   ^   #   .
        #   >   >   >   >   ^   #   .
        #   #   #   #   #   #   #   .
        .   .   .   .   .   .   .   .
    ]]))

    
    add(LEVELS, Level.new("xxx", "CAT",
    [[
        .   .   .   .   .   .   .   .
        .   #   #   #   #   #   .   .
        .   #   v-  ,   v-  #   .   .
        #  <!A <   <B  <   <   .   .
        .   #   >   >!  >!  #   .   .
        .   #   #   #   #   #   .   .
        .   .   .   .   .   .   .   .
    ]]))


    add(LEVELS, Level.new("tIME mITE", "MITE",
    [[
        .   .   .   .   .   .   .   .        
        .   #   #   #   #   #   #   .
        .   #   *   *   <-  v-  #   .
        .   #   v!T <!I <!M v!E #   .
        .   #   >   >   >   >   #   .
        .   #   #   #   #   #   #   .
        .   .   .   .   .   .   .   .
        .   .   .   .   .   .   .   .                
    ]]))


    add(LEVELS, Level.new("FOO BAR", "BAR",
    [[
        .   .   .   .   .   .   .   .
        .   #   #   #   #   #   .   .
        >L  >K  >J  >I  >H  >G  vF  .
        ^M  .   vY  vX  vZ  #   vE  .
        ^N  <!  <   <A  <B  <C  <D  .
        .   -   ,   ,   ,   #   .   .
        .   .   #   #   #   #   .   .
        .   .   .   .   .   .   .   .
    ]]))


    

--[[
    add(LEVELS, Level.new("PENAL PANEL", "PANEL",
    [[
        .   .   .   .   .   .   .   .        
        .   #   #   #   #   #   #   #
        .   #   ,   ,   ,   -   -   #
        .   #   -   -   ,   -   -   #
        .   #   v!P v!E <N  <!A <L  #
        .   #   v   v   #   #   ^   #
        .   #   >   >   >   >   ^   #
        .   #   #   #   #   #   #   #
        .   .   .   .   .   .   .   .                



    add(LEVELS, Level.new("PENAL PANEL", "PANEL",
    [[
        .   .   .   .   .   .   .   .        
        .   #   #   #   #   #   #   #
        .   #   ,   ,   ,   -   -   #
        .   #   -   -   ,   v!& -   #
        .   #   v!P v!E <N  <!A <L <
        .   #   v   v!  -   v!  ^   ^
        .   #   >   >   >   >   ^   ^
        .   #   #   #   #   #   #   .
        .   .   .   .   .   .   .   .                
]]--

    add(LEVELS, Level.new("a cAT!", "CAT",
    [[
        .   .   .   .   .   .   .   .        
        .   #   #   #   #   #   #   .
        .   #   v-  v-  #   v-  #   .
        .   #   v!C v!A #   v!T #   .
        .   #   ,   ,   ,   <   #   .
        .   #   #   #   #   #   #   .
        .   .   .   .   .   .   .   .
        .   .   .   .   .   .   .   .                
    ]]))



    add(LEVELS, Level.new("a cAT aCT", "CAT",
    [[
        #   #   #   #   #   #   #   #
        #   ,   ,   ,   ,   ,   ,   #        
        #   ,   ,   v-  ,   ,   ,   #        
        #   ,   ,   v!A ,   ,   ,   #
        #   ,   ,C  ,   ,   <!T <-  #
        #   ,   ,   ,   ,   ,   ,   #        
        #   ,   ,   ,   ,   ,   ,   #
        #   #   #   #   #   #   #   #
    ]]))

    add(LEVELS, Level.new("a cAT aCT", "ACT",
    [[
        .   .   .   .   .   .   .   .
        #   #   #   #   #   #   #   #
        #   ,   ,   ,   ,   ,   ,   #
        #   ,   v   <   <   ,   ,   #
        #   ,   ,   ,C  ^!A <!T ,   #
        #   ,   ,   ,   -   -   ,   #
        #   ,   ,   ,   ,   ,   ,   #
        #   #   #   #   #   #   #   #
    ]]))
    
    add(LEVELS, Level.new("a cAT aCT", "ACT",
    [[
        .   .   .   .   .   .   .   .
        #   #   #   #   #   #   #   #
        #   v   ,   ,   ,   ,   ^   #
        #   v   >   >   >   >   ^   #
        #   v   ,   ,   ,   ,   ^   #
        #   #   #   #   #   #   #   #
        .   .   .   .   .   .   .   .
        .   .   .   .   .   .   .   .        
    ]]))


    add(LEVELS, Level.new("a cAT aCT", "ACT",
    [[
        .  .  .  .  .  .  .  .
        #  #  #  #  #  #  #  #
        #  ,  ,  ,  ,  ,  ,  #        
        #  ,  ,  ,  ,  ,  ,  #        
        #  <  #  <  <C <  <  #
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

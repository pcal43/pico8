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

-- SAME MESA
-- POSH SHOP

function initLevels() 
    LEVELS = {}


    add(LEVELS, Level.new("a cAT aCT", "ACT", "mEOW mEOW gOOD jOB!",
    [[
        .   .   .   .   .   .   .   .
        .   .   #   #   #   .   .   .
        .   #   #   v-  #   #   .   .
        .   #   >C  v!A ,T  #   .   .
        .   #   ^   <   <   #   .   .
        .   #   #   #   #   #   .   .
        .   .   .   .   .   .   .   .
        .   .   .   .   .   .   .   .
    ]]))
    
    add(LEVELS, Level.new("rAT aRT", "ART", "fIRST-rAT!",
    [[
        .   .   .   .   .   .   .   .
        .   #   #   #   #   #   #   .
        .   #   v   <   <   ,   #   .
        .   #   ,   ,R  ^!A <!T #   .
        .   #   ,   ,   ^-  <-  #   .
        .   #   #   #   #   #   #   .
    ]]))
    
    add(LEVELS, Level.new("ONE NEO", "ONE", "gOODBYE, mR. aNDERSON",
    [[
        .   .   .   .   .   .   .   .        
        .   #   #   #   #   #   .   .
        .   #   >-  v-  v-  #   .   .
        .   #   >!N v!E v!O #   #   #
        .   #   ,   ,   <!  <!& <-  #
        .   #   #   ,   <-  #   #   #        
        .   .   #   #   #   #   .   .        
    ]]))

    add(LEVELS, Level.new("nOW wON", "WON", "yES, yES yOU dID.",
    [[
        .   .   .   .   .   .   .   .        
        .   #   #   #   #   #   .   .
        .   #   v-  v-  v-  #   .   .
        .   #   v!N v!O v!W #   .   .
        .   #   >   >   v   #   .   .
        .   #   ^   <   <   #   .   .
        .   #   #   #   #   #   .   .        
        .   .   .   .   .   .   .   .        
    ]]))

    add(LEVELS, Level.new("tIME mITE", "MITE", "wAT?!",
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

    add(LEVELS, Level.new("dEMO mODE", "MODE", "iS tHIS eASY mODE?",
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

    add(LEVELS, Level.new("POST STOP", "STOP", "sPECIAL dELIVERY!",
    [[
        .   .   .   .   .   .   .   .        
        .   #   #   #   #   #   #   .
        .   #   v-  v-  <-  <-  #   .
        .   #   v!P v!O <!S <!T #   .
        .   #   >   >   >   >   #   .
        .   #   #   #   #   #   #   .
        .   .   .   .   .   .   .   .
        .   .   .   .   .   .   .   .
    ]]))

    add(LEVELS, Level.new("pOSH sHOP", "SHOP", "fANCY!",
    [[
        .   #   #   #   #   #   #   .
        #   v-  v!& >   >   >   v&  #
        #   v!  ,P  ,O  ,S  ,H  <!& #
        #   >   >!  ^!  ^!  ,   <-  #
        #   ,   >-  ^-  ^-  ,   ,   #
        .   #   #   #   #   #   #   .
        .   .   .   .   .   .   .   .
    ]]))

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

    add(LEVELS, Level.new("GARDEN DANGER", "DANGER", "sTEP oN a rAKE?",
    [[
        .   .   .   .   .   .   .   .
        #   #   #   #   #   #   #   #
        #   v   <   <   <   <   <   #
        #   v!G ^!A ^!R ^!D ^!E <N  #
        #   v   ^-  ^-  ^-  ^-  ^   #
        #   >   >   >   >   >   ^   #
        #   #   #   #   #   #   #   #
        .   .   .   .   .   .   .   .
    ]]))

end

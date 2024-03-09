

local Map = {}
Map.new = function(tileArray, address, width, height, tileBytes, flagBytes)
    local self = {}
    local tileBytes = tileBytes or 1
    local flagBytes = flagBytes or 1
    local bytesPerCell = tileBytes + flagBytes
    local width = width
    local height = height    
    local address = address
    local bufferSize = width * height * bytesPerCell

    -- WAT
    for i=0, bufferSize, 4 do poke4(address + i, 0b00000000000000000000000) end

    local function getTileAddress(pos) 
        return address + (pos.x * bytesPerCell) + (pos.y * width * bytesPerCell)
    end

    local function getFlagsAddress(pos) 
        return getTileAddress(pos) + tileBytes
    end

    function self.getTile(pos) 
        if (not self.isInBoundsP(pos)) return nil
        return tileArray[varPeek(getTileAddress(pos), tileBytes)]
    end

    function self.getTileP(pos) 
        if (not self.isInBoundsP(pos)) return nil
        return varPeek(getTileAddress(pos), tileBytes)
    end
  
    function self.setTileNum(pos, tileNum) 
        if (not self.isInBoundsP(pos)) return
        if (tileNum < 1 or tileNum > #tileArray) then
            printh("WARNING: ignoring invalid tile number "..tostr(tileNum))
            tileNum = 1
        end
        return varPoke(getTileAddress(pos), tileNum, tileBytes)
    end

    function self.setTileP(pos, v) 
        if (not self.isInBoundsP(pos)) return
        return varPoke(getTileAddress(pos), v, tileBytes)
    end

    function self.getFlagP(pos, f) 
        return isBit(self.getFlagsP(pos), f)
    end

    function self.getFlagsP(pos) 
        if (not self.isInBoundsP(pos)) return nil 
        return varPeek(getFlagsAddress(pos), flagBytes)
    end

    function self.getFlagsP(pos)
        if (not self.isInBoundsP(pos)) return nil 
        return varPeek(getFlagsAddress(pos), flagBytes)
    end

    function self.getFlagsStrP(pos) 
        if (not self.isInBoundsP(pos)) return nil 
        return varPeekStr(getFlagsAddress(pos), flagBytes)
    end

    function self.clearFlagP(pos, f)
        self.setFlagP(pos, f, false)
    end

    function self.setFlagP(pos, f, v)
        if (not self.isInBoundsP(pos)) return nil
        local addr = getFlagsAddress(pos)
        local flags = varPeek(addr, flagBytes)
        if (v == nil or v) then
            flags = flags | 1 << f
        else
            flags = flags & ~(1 << f)
        end
        varPoke(addr, flags, flagBytes)
    end

    function self.setFlagsP(pos, flags)
        if (not self.isInBoundsP(pos)) return nil
        local addr = getFlagsAddress(pos)
        varPoke(addr, flags, flagBytes)
    end

    function self.isInBoundsP(pos)
        return pos.x >= 0 and pos.x < width and pos.y >= 0 and pos.y < height
    end

    function self.traverseP(fn)
        local offset = address
        local pos = Position.new()
        for y=0, height - 1, 1 do
            for x=0, width - 1, 1 do
                pos.x = x --FIXME figure something less dumb
                pos.y = y
                fn(pos, varPeek(offset, tileBytes), varPeek(offset + tileBytes, flagBytes))
                offset += bytesPerCell
            end
        end    
    end

    return self
end

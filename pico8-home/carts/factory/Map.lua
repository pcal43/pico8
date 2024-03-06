



local Map = {}
Map.new = function(address, width, height, tileBytes, flagBytes)
    local self = {}
    local tileBytes = tileBytes or 1
    local flagBytes = flagBytes or 1
    local bytesPerCell = tileBytes + flagBytes
    local width = width
    local height = height    
    local address = address
    local bufferSize = width * height * bytesPerCell

    for i=0, bufferSize, 4 do poke4(address + i) end

    function self.getSize()
        return width, height
    end

    function self.getTileP(pos) 
        if (not self.isInBoundsP(pos)) return nil
        return varPeek(address + self.getTileOffsetP(pos), tileBytes)
    end
  
    function self.setTileP(pos, v) 
        if (not self.isInBoundsP(pos)) return
        return varPoke(address + self.getTileOffsetP(pos), v, tileBytes)
    end

    function self.getFlagP(pos, f) 
        return isBit(self.getFlagsP(pos), f)
    end

    function self.getFlagsP(pos) 
        if (not self.isInBoundsP(pos)) return nil 
        local addr = address + self.getFlagsOffsetP(pos)
        return varPeek(addr, flagBytes)
    end

    function self.getFlagsP(pos)
        if (not self.isInBoundsP(pos)) return nil 
        local addr = address + self.getFlagsOffsetP(pos)
        return varPeek(addr, flagBytes)
    end

    function self.getFlagsStrP(pos) 
        if (not self.isInBoundsP(pos)) return nil 
        local addr = address + self.getFlagsOffsetP(pos)
        return varPeekStr(addr, flagBytes)
    end

    function self.clearFlagP(pos, f)
        self.setFlagP(pos, f, false)
    end

    function self.setFlagP(pos, f, v)
        if (not self.isInBoundsP(pos)) return nil
        local addr = address + self.getFlagsOffsetP(pos)
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
        local addr = address + self.getFlagsOffsetP(pos)
        varPoke(addr, flags, flagBytes)
    end

    function self.isInBoundsP(pos)
        return pos.x >= 0 and pos.x < width and pos.y >= 0 and pos.y <= height
    end

    function self.getTileOffsetP(pos) 
        return (pos.x * bytesPerCell) + (pos.y * width * bytesPerCell)
    end

    function self.getFlagsOffsetP(pos) 
        return self.getTileOffsetP(pos) + tileBytes
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

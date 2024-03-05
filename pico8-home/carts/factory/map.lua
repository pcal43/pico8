


--https://paulwatt526.github.io/wattageTileEngineDocs/luaOopPrimer.html
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

    function self.getTile(x, y) 
        if (not self.isInBounds(x,y)) return nil
        return varPeek(address + self.getTileOffset(x,y), tileBytes)
    end
  
    function self.setTile(x, y, v) 
        if (not self.isInBounds(x,y)) return
        return varPoke(address + self.getTileOffset(x,y), v, tileBytes)
    end

    function self.getFlag(x, y, f) 
        return isBit(self.getFlags(x, y), f)
    end

    function self.getFlags(x, y) 
        if (not self.isInBounds(x,y)) return nil 
        local addr = address + self.getFlagsOffset(x, y)
        return varPeek(addr, flagBytes)
    end

    function self.getFlagsStr(x, y) 
        if (not self.isInBounds(x,y)) return nil 
        local addr = address + self.getFlagsOffset(x, y)
        return varPeekStr(addr, flagBytes)
    end

    function self.clearFlag(x, y, f)
        self.setFlag(x, y, f, false)
    end

    function self.setFlag(x, y, f, v)
        if (not self.isInBounds(x,y)) return nil
        local addr = address + self.getFlagsOffset(x, y)
        local flags = varPeek(addr, flagBytes)
        if (v == nil or v) then
            flags = flags | 1 << f
        else
            flags = flags & ~(1 << f)
        end
        varPoke(addr, flags, flagBytes)
    end

    function self.setFlags(x, y, flags)
        if (not self.isInBounds(x,y)) return nil
        local addr = address + self.getFlagsOffset(x, y)
        varPoke(addr, flags, flagBytes)
    end

    function self.isInBounds(x, y)
        return x >= 0 and x < width and y >= 0 and y <= height
    end

    function self.getTileOffset(x, y) 
        return (x * bytesPerCell) + (y * width * bytesPerCell)
    end

    function self.getFlagsOffset(x, y) 
        return self.getTileOffset(x,y) + tileBytes
    end
    
    function self.traverse(fn)
        local offset = address
        for y=0, height - 1, 1 do
            for x=0, width - 1, 1 do
                fn(x, y, varPeek(offset, tileBytes), varPeek(offset + tileBytes, flagBytes))
                offset += bytesPerCell
            end
        end    
    end

    return self
end


--https://paulwatt526.github.io/wattageTileEngineDocs/luaOopPrimer.html
local Map = {}
Map.new = function(address, width, height)
    local self = {}    
    local BYTES_PER__CELL = 2
    local FLAGS_OFFSET = 1
    local width = width
    local height = height    
    local address = address
    local bufferSize = width * height * BYTES_PER__CELL

    for i=0, bufferSize, 4 do poke4(i,0) end

    function self.getSize()
        return width, height
    end

    function self.getTile(x, y) 
        return peek(address + self.getTileOffset(x,y))
    end
  
    function self.setTile(x, y, v) 
        return poke(address + self.getTileOffset(x,y), v)
    end

    function self.getFlag(x, y, f) 
        local flags = peek(address + self.getFlagsOffset(x,y))
        if (f) then
            return flags & 1 << f
        else
            return flags
        end
    end
  
    function self.setFlag(x, y, f, v) 
        local addr = self.getFlagsOffset(x, y)
        local flags = peek(addr)
        if (v) then
            flags = flags | 1 << f
        else
            flags = flags & ~(1 << f)
        end
        poke(addr, flags)
    end

    function self.getTileOffset(x, y) 
        return (x * BYTES_PER__CELL) + (y * width * BYTES_PER__CELL)
    end

    function self.getFlagsOffset(x, y) 
        return (x * BYTES_PER__CELL) + (y * width * BYTES_PER__CELL) + FLAGS_OFFSET
    end
    
    function self.traverse(fn)
        local offset = 0
        for y=0, height - 1, 1 do
            for x=0, width - 1, 1 do
                fn(x, y, peek(offset), peek(offset + FLAGS_OFFSET))
                offset += BYTES_PER__CELL
            end
        end    
    end

    return self
end


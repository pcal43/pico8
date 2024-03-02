

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
        if (not self.isInBounds(x,y)) return nil
        return peek(address + self.getTileOffset(x,y))
    end
  
    function self.setTile(x, y, v) 
        if (not self.isInBounds(x,y)) return
        return poke(address + self.getTileOffset(x,y), v)
    end

    function self.getFlag(x, y, f) 
        if (not self.isInBounds(x,y)) return nil 
        local addr = address + self.getFlagsOffset(x, y)
        local flags = peek(addr)
        if (f) then
            --printh("get! " .. tostr(addr) .. " xx " .. tostr(flags) .. " " .. tostr((flags & (1 << f)) ))
            return flags & 1 << f != 0
        else
            return flags
        end
    end
  
    function self.setFlag(x, y, f, v)
        if (not self.isInBounds(x,y)) return nil
        local addr = address + self.getFlagsOffset(x, y)
        local flags = peek(addr)
        if (v == nil or v) then
            --printh("set! " .. tostr(addr) .. " " .. tostr(flags) )
            flags = flags | 1 << f
        else
            flags = flags & ~(1 << f)
        end
        poke(addr, flags)
        --printh("..." .. tostr(flags) .. " " .. tostr(peek(addr)) )
    end

    function self.isInBounds(x, y)
        return x >= 0 and x < width and y >= 0 and y <= height
    end

    function self.getTileOffset(x, y) 
        return (x * BYTES_PER__CELL) + (y * width * BYTES_PER__CELL)
    end

    function self.getFlagsOffset(x, y) 
        return self.getTileOffset(x,y) + FLAGS_OFFSET
    end
    
    function self.traverse(fn)
        local offset = address
        for y=0, height - 1, 1 do
            for x=0, width - 1, 1 do
                fn(x, y, peek(offset), peek(offset + FLAGS_OFFSET))
                offset += BYTES_PER__CELL
            end
        end    
    end

    return self
end




--https://paulwatt526.github.io/wattageTileEngineDocs/luaOopPrimer.html
local Map = {}
Map.new = function(address, width, height)
    local BYTES_PER__CELL = 2
    local FLAGS_OFFSET = 1
    local this = {}
    local width = width
    local height = height    
    local address = address
    local bufferSize = width * height * BYTES_PER__CELL

    for i=0, i < bufferSize, 4 do poke4(i,0) end

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


function mapInit(address, width, height, tileWidth, tileHeight, spriteWidth, spriteHeight)
    m = { a = address, w = width, h = height, tw = tileWidth, th = tileHeight, sw=spriteWidth, sh=spriteHeight  }
    for y=0, m.h-1, 1 do  
        for x=0, m.w-1, 1 do
        mapSet(m, x,y, 0)
        end
    end
    m.drawTile = function(m, tileNumber, sx, sy)
        spr(tileNumber, sx, sy, m.sw, m.sh)
    end
    return m
end
  
function mapGet(m, x,y) 
    return peek(m.a + mapOffset(m,x,y))
end
  
function mapSet(m, x,y, v) 
    return poke(m.a + mapOffset(m,x,y), v)
end
  
function mapOffset(m, x, y)
    return x + (y * m.w)
end

function mapCoords(m, offset)
    return offset % m.w, flr(offset / m.w)
end

--kill
function mapDraw(m, cx, cy)
    for my=0, m.h-1, 1 do  
      for mx=0, m.w-1, 1 do
        m.drawTile(m, mapGet(m, mx, my), cx, cy)
        cx += m.tw
      end
      cx -= (m.tw * m.w)
      cy += m.th
    end
end

function moffLength(m)
    return m.w * m.h
end

function moffNeighbor(m, moff, dx, dy)
    return moff + dx + (dy * m.w)
end

function moffGet(m, moff)
    return peek(m.a + moff)
end

function moffSet(m, moff, v)
    return poke(m.a + moff, v)
end


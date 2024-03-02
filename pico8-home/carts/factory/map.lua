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


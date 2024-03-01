
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
  return peek(m.a + x + (y * m.w))
end

function mapSet(m, x,y, v) 
  return poke(m.a + x + (y * m.w), v)
end

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


local map = {}
local tiles = {}

function _init()
    map = mapInit(0X4300,8,8,16,16,2,2)
    mapSet(map,1,1,5)
    mapSet(map,2,1,6)
    mapSet(map,3,1,7)
    mapSet(map,4,1,8)

    map.drawTile = function(m, tileNumber, sx, sy)
      t = tiles[tileNumber]
      if (t) spr(t.sprite, sx, sy, m.sw, m.sh, t.flipx or false, t.flipy or false)
    end
  

    tiles[5] = { name="belt-right", sprite=64 }
    tiles[6] = { name="belt-left",  sprite=64, flipx=true }
    tiles[7] = { name="belt-up",    sprite=66,}
    tiles[8] = { name="belt-down",  sprite=66, flipy=true }            


end

function flipTile(t, vert, horz) 
  if (vert) t = t | 0b10000000
  if (horz) t = t | 0b01000000
  return t
end


function _update()
 
end

function _draw()
  cls()
  mapDraw(map, 0, 0)
end

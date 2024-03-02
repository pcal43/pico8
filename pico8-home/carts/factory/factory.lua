

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
local TILES = {}
local ITEMS = {}


local actors = {}

function _init()
    map = mapInit(0X4300,8,8,16,16,2,2)
    mapSet(map,0,0,5)
    mapSet(map,1,0,5)
    mapSet(map,2,0,8)
    mapSet(map,2,1,8)

    map.drawTile = function(m, tileNumber, cx, cy)
      t = TILES[tileNumber]
      if (t) spr(t.bigSprite, cx, cy, m.sw, m.sh, t.flipx or false, t.flipy or false)
    end
  
    TILES[5] = { name="belt-right", doReceive=function(a) beltReceive(a, 1, 0) end, bigSprite=64 }
    TILES[6] = { name="belt-left",  doReceive=function(a) beltReceive(a, -1,0) end, bigSprite=64, flipx=true }
    TILES[7] = { name="belt-up",    doReceive=function(a) beltReceive(a, 0,-1) end, bigSprite=66 }
    TILES[8] = { name="belt-down",  doReceive=function(a) beltReceive(a, 0, 1) end, bigSprite=66, flipy=true }

    ITEMS[1] = { name="egg", bigSprite=32 }

    add(actors, { mx = 0, my = 0, dx = 1, dy = 0, item=1 } )
end

function beltReceive(a, bdx, bdy) 
  a.dx = bdx
  a.dy = bdy
end

local framesElapsed = 0
local TILE_WIDTH = 16
local SPRITE_SIZE = 2
local frameAlpha = 0

local FRAMES_PER_TICK = 16

function _update()
  //framesElapsed += 1
  //if (0 == framesElapsed % (FRAMES_PER_TICK / TILE_WIDTH )) frameAlpha += 1
  frameAlpha +=1
  if (frameAlpha == FRAMES_PER_TICK) then
    for a in all(actors) do
      a.mx += (a.dx or 0)
      a.my += (a.dy or 0)
      TILES[mapGet(map, a.mx, a.my)].doReceive(a)
      printh(TILES[mapGet(map, a.mx, a.my)].name)
    end
    frameAlpha = 0
  end
end

function _draw()
  cls(1)
  mapDraw(map, 0, 0)

  for a in all(actors) do
    local item = ITEMS[a.item]
    spr(item.bigSprite, (a.mx * TILE_WIDTH) + a.dx * frameAlpha, 
                        (a.my * TILE_WIDTH) + a.dy * frameAlpha, SPRITE_SIZE, SPRITE_SIZE)
  end
end



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
local ABBREVS = {}


local actors = {}
local sprites = {}



BELT_BEHAVIOR = { 
  onReceiveItem = function(tile, actor)
    actor.dx = tile.beltx
    actor.dy = tile.belty
  end
}

CRATE_BEHAVIOR = { 

}

REPEATER_BEHAVIOR = {
  onTick = function(tile, actor)
  end

}

STARTER_BEHAVIOR = {
  onTick = function(tile, actor)
  end
}



function _init()

  TILES[0] = { abbrev=".", name="empty",      behavior=nil, sprite=nil, flipy=true }
  TILES[5] = { abbrev=">", name="belt-right", behavior=BELT_BEHAVIOR, beltx=1, belty=0, sprite=64 }
  TILES[6] = { abbrev="<", name="belt-left",  behavior=BELT_BEHAVIOR, beltx=-1, belty=0, sprite=64, flipx=true }
  TILES[7] = { abbrev="^", name="belt-up",    behavior=BELT_BEHAVIOR, beltx=0, belty=-1, sprite=66 }
  TILES[8] = { abbrev="V", name="belt-down",  behavior=BELT_BEHAVIOR, beltx=0, belty=1, sprite=66, flipy=true }
  TILES[9] = { abbrev="E", name="egg-crate",  behavior=CRATE_BEHAVIOR, sprite=96, badgeSprite=32 }    

  ITEMS[1] = { name="egg", bigSprite=32 }

    printh("---------------------")
    for i, tile in pairs(TILES) do
      printh("---------------------!")
      ABBREVS[tile.abbrev] = i
      printh(tostr(i)..tostr(tile.abbrev))
    end
    printh("---------------------")
    
    map = mapInit(0X4300,8,8,16,16,2,2)
    local level = [[
E>>>V
^...V
^<<<<
    ]]

    local rows = split(level, "\n")
    local mx = 0
    local my = 0
    for row in all(rows) do
      printh(row)
      for i = 1, #row do
        c = sub(row, i, i)
        printh(tostr(c) .. tostr(i))
        if (ABBREVS[c]) then
          printh("ok")
          mapSet(map, mx, my, ABBREVS[c])
        end
        mx += 1
      end
      mx = 0
      my += 1
    end

    add(actors, { mx = 0, my = 0, dx = 1, dy = 0, item=1 } )
    add(actors, { mx = 5, my = 0, dx = -1, dy = 0, item=1 } )
end



local framesElapsed = 0
local TILE_WIDTH = 16
local SPRITE_SIZE = 2
local frameAlpha = 0
local collided = false
local FRAMES_PER_TICK = 16


function _update()
  if (collided) return
  //framesElapsed += 1
  //if (0 == framesElapsed % (FRAMES_PER_TICK / TILE_WIDTH )) frameAlpha += 1
  frameAlpha +=1
  if (frameAlpha == FRAMES_PER_TICK) then

    local actorsPerTile = {}
    local collisions = nil

    for a in all(actors) do
      a.mx += (a.dx or 0)
      a.my += (a.dy or 0)
      local moff = mapOffset(map, a.mx, a.my)
      if not actorsPerTile[moff] then
        actorsPerTile[moff] = a
      else 
        if (not collisions) collisions = {}
        add(collisions, moff)
      end
      local tile = TILES[mapGet(map, a.mx, a.my)]
      if not tile or not tile.behavior or not tile.behavior.onReceiveItem then
        if (not collisions) collisions = {}
        add(collisions, moff)
      else
        tile.behavior.onReceiveItem(tile, a)
      end
    end

    if (collisions) then
      for moff in all(collisions) do
        local mx, my = mapCoords(map, moff)
        printh("OH NO " .. tostr(moff).. " ".. tostr(mx).. " " .. tostr(my))
        add(sprites, { x = (mx * TILE_WIDTH), y = (my * TILE_WIDTH), sprite = 2 })
      end
      collided = true
    end
    frameAlpha = 0
  end
end

function _draw()
  cls(1)
  local m = map
  local cx = 0
  local cy = 0
  for my=0, m.h-1, 1 do  
    for mx=0, m.w-1, 1 do
      local t = TILES[mapGet(m, mx, my)]
      if t and t.sprite then
        drawSprite(t.sprite, cx, cy, t.flipx, t.flipy)
        if t.badgeSprite then
          drawSprite(t.badgeSprite, cx, cy -2, false, false)
        end
      end
      cx += m.tw
    end
    cx -= (m.tw * m.w)
    cy += m.th
  end


  for a in all(actors) do
    local item = ITEMS[a.item]
    drawSprite(item.bigSprite, (a.mx * TILE_WIDTH) + a.dx * frameAlpha, (a.my * TILE_WIDTH) + a.dy * frameAlpha)
  end
  for s in all(sprites) do
    spr(s.sprite, s.x, s.y, SPRITE_SIZE, SPRITE_SIZE)
  end
end

function drawSprite(number, cx, cy, flipx, flipy)
  if (number <= 128) then
    -- the first two pages of sprites are 16x16
    spr(number, cx, cy, 2, 2, flipx, flipy)
  else
    spr(number, cx, cy, flipx, flipy)
  end
end


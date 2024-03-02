local TILES = {}
local ITEMS = {}
local ABBREVS = {}
local SPRITE_SIZE = 2
local TILE_WIDTH = 16
local TILE_HEIGHT = 16
local FRAMES_PER_TICK = 16

local map = {}
local framesElapsed = 0
local frameAlpha = 0
local collided = false
local ticksElapsed = 0
local pulsedMoffs = {}

local actors = {}
local sprites = {}

newActors = {}


BELT_BEHAVIOR = { 
  onReceiveItem = function(mx, my, tile, actor)
    actor.dx = tile.beltx
    actor.dy = tile.belty
  end,

  willAccept = function(mx, my, tile, actor)
    return (actor.dx == tile.beltx) and (actor.dy == tile.belty)
  end
}

-- maybe dont have direction, just have a consistent rule for looking for outbound belt.  say, start on right and go clockwise
-- DO THIS
CRATE_BEHAVIOR = {
  onPulse = function(tile, mx, my)
    add(actors, { mx=mx, my=my, dx=tile.beltx, dy=tile.belty, item=tile.crateItem })
    printh("crate!")
  end
}

MF_LOCKED = 0
MF_PULSED = 2
MF_PULSE_PROCESSED = 3
MF_OCCUPIED = 4
MF_COLLISION = 5


CLOCK_BEHAVIOR = {
  onTick = function(mx, my, tile, flags, map)
    if (ticksElapsed % 4 == 0) then
      map.setFlag(mx - 1, my,  MF_PULSED, true)
      map.setFlag(mx + 1, my,  MF_PULSED, true)      
      map.setFlag(mx, my + 1,  MF_PULSED, true)            
      map.setFlag(mx, my - 1,  MF_PULSED, true)                  
    end
  end
}

STARTER_BEHAVIOR = {
}

--[[
function findOutboundBelt(ctx)
  local t = ctx.tile
  t = mget(map, mx+1, my)
  if (t and TILES[T].behavior and TILES[t].behavior.willAccept(ctx, 1,0)) return 1, 0
  t = mget(map, mx, my + 1)
  if (t and TILES[T].behavior and TILES[t].behavior.willAccept(ctx, 0,1)) return 0, 1
  t = mget(map, mx - 1, my)
  if (t and TILES[T].behavior and TILES[t].behavior.willAccept(ctx, 1,0)) return -1, 0
  t = mget(map, mx, my - 1)
  if (t and TILES[T].behavior and TILES[t].behavior.willAccept(ctx, 1,0)) return 0, -1
  return nil, nil
end
]]--


function _init()

  TILES[0] = { abbrev=".",  name="empty",      behavior=nil, sprite=nil, flipy=true }
  TILES[1] = { abbrev="C", name="clock",      behavior=CLOCK_BEHAVIOR, sprite=70 }    
  TILES[5] = { abbrev=">",  name="belt-right", behavior=BELT_BEHAVIOR, beltx=1, belty=0, sprite=64 }
  TILES[6] = { abbrev="<",  name="belt-left",  behavior=BELT_BEHAVIOR, beltx=-1, belty=0, sprite=64, flipx=true }
  TILES[7] = { abbrev="^",  name="belt-up",    behavior=BELT_BEHAVIOR, beltx=0, belty=-1, sprite=66 }
  TILES[8] = { abbrev="V",  name="belt-down",  behavior=BELT_BEHAVIOR, beltx=0, belty=1, sprite=66, flipy=true }
  TILES[9] = { abbrev="E",  name="egg-crate",  behavior=CRATE_BEHAVIOR, beltx=1, belty=0, crateItem=1, sprite=96, badgeSprite=32 }    
  TILES[10] = { abbrev="F",  name="flour-crate", behavior=CRATE_BEHAVIOR, beltx=1, belty=0, crateItem=2, sprite=96, badgeSprite=34 }    

  ITEMS[1] = { name="egg", bigSprite=32 }
  ITEMS[2] = { name="flour", bigSprite=34 }

    printh("---------------------")
    for i, tile in pairs(TILES) do
      printh("---------------------!")
      ABBREVS[tile.abbrev] = i
      printh(tostr(i)..tostr(tile.abbrev))
    end
    printh("---------------------")
    
    map = Map.new(0x4300,8,8)

    local level = [[
CF>>>V
E>>>VV
.^..VV
.^<<<<
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
          map.setTile(mx, my, ABBREVS[c])
        end
        mx = mx + 1
      end
      mx = 0
      my = my + 1
    end

    --add(actors, { mx = 0, my = 0, dx = 1, dy = 0, item=1 } )
    --add(actors, { mx = 5, my = 0, dx = -1, dy = 0, item=1 } )
end

function _update()
  if (collided) return
  
  -- framesElapsed += 1
  -- if (0 == framesElapsed % (FRAMES_PER_TICK / TILE_WIDTH )) frameAlpha += 1
  frameAlpha = frameAlpha + 1
  if (frameAlpha == FRAMES_PER_TICK) then
    ticksElapsed += 1

    local ctx = { map = map, newActors = {}, ticksElapsed = ticksElapsed }

    local w, h = map.getSize()
    map.traverse(function(mx, my, tileNum, flags)
      local tile = TILES[tileNum]
      --printh(tostr(mx) .. " " .. tostr(my) .. " " .. tostr(tileNum) .. tostr(flags))
      if (tile and tile.behavior and tile.behavior.onTick) tile.behavior.onTick(mx, my, tile, flags, map)
    end)

    map.traverse(function(mx , my, tileNum, flags)
      if (map.getFlag(mx, my, MF_PULSED)) then
          local tile = TILES[tileNum]          
          if (tile and tile.behavior and tile.behavior.onPulse) tile.behavior.onPulse(tile, mx, my)
      end
    end)
    

    local actorsPerTile = {}

    for a in all(actors) do
      a.mx += (a.dx or 0)
      a.my += (a.dy or 0)
      if (map.getFlag(a.mx, a.my, MF_OCCUPIED)) then
        map.setFlag(a.mx, a.my, MF_COLLISION)
        collided = true
        printh("OH NO!")
      else
        printh("OCCUPADO!  " .. tostr(a.mx) .. "," .. tostr(a.my))
        map.setFlag(a.mx, a.my, MF_OCCUPIED)   
      end
      local tileNum = map.getTile(a.mx, a.my)
      if (tileNum and TILES[tileNum] and TILES[tileNum].behavior and TILES[tileNum].behavior.onReceiveItem) then
        TILES[tileNum].behavior.onReceiveItem(a.mx, a.my, TILES[tileNum], a)
      else
        map.setFlag(a.mx, a.my, MF_COLLISION)
        collided = true
      end
    end

    if (collided) then
      map.traverse(function(mx , my, tileNum, flags)
        if (map.getFlag(mx, my, MF_COLLISION)) then
            printh("OH NO ".. tostr(mx).. " " .. tostr(my))
          add(sprites, { x = (mx * TILE_WIDTH), y = (my * TILE_WIDTH), sprite = 2 })
        end
      end)
    end
    frameAlpha = 0

    map.traverse(function(mx , my) 
      map.setFlag(mx, my, MF_PULSED, false) 
      map.setFlag(mx, my, MF_OCCUPIED, false)       
      map.setFlag(mx, my, MF_COLLISION, false)       
    end)
  

  end
end

function _draw()
  cls(1)
  local cx = 0
  local cy = 0
  local width, height = map.getSize()
  map.traverse(function(x, y, tileNum, flags)
    local t = TILES[tileNum]
    if t and t.sprite then

      drawSprite(t.sprite, x * TILE_WIDTH, y * TILE_HEIGHT, t.flipx, t.flipy)
      if t.badgeSprite then
        drawSprite(t.badgeSprite, x * TILE_WIDTH, y * TILE_HEIGHT -2, false, false)
      end
    end
  end
  )


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


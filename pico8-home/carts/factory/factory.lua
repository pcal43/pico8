local ITEMS = {}

local SPRITE_SIZE = 2
local TILE_WIDTH = 16
local TILE_HEIGHT = 16
local FRAMES_PER_TICK = 16

local map 
framesElapsed = 0
frameAlpha = 0
collided = false
ticksElapsed = 0

actors = {}
sprites = {}


function _init()
  ITEMS[1] = { name="egg", bigSprite=32 }
  ITEMS[2] = { name="flour", bigSprite=34 }
  ITEMS[3] = { name="sugar", bigSprite=36 }  
  initTiles()
  map = loadLevel()
  map.traverse(function(mx , my, tileNum, tileFlags)
    map.setFlags(mx, my, TILES[tileNum].getStartingFlags()) -- FIXME oSetFlags
  end)

  
end

function _update()
  if (collided) return
  
  -- framesElapsed += 1
  -- if (0 == framesElapsed % (FRAMES_PER_TICK / TILE_WIDTH )) frameAlpha += 1
  frameAlpha = frameAlpha + 1
  if (frameAlpha == FRAMES_PER_TICK) then

    map.traverse(function(mx, my, tileNum, flags)
      TILES[tileNum].onTickStart(mx, my, map)
    end)

    map.traverse(function(mx , my, tileNum, tileFlags)
      if (map.getFlag(mx, my, MF_PULSED)) then -- FIXME need a util for this case
        TILES[tileNum].onPulse(mx, my, tileFlags, actors)
      end
    end)

    for i=#actors,1,-1 do
        local a = actors[i]
        a.mx += (a.dx or 0)
        a.my += (a.dy or 0)
        --[[
        if (map.getFlag(a.mx, a.my, MF_OCCUPIED)) then
            map.setFlag(a.mx, a.my, MF_COLLISION)
            collided = true
            printh("OH NO!")
        else
            --printh("OCCUPADO!  " .. tostr(a.mx) .. "," .. tostr(a.my))
            map.setFlag(a.mx, a.my, MF_OCCUPIED)   
        end
        ]]--
        local tileNum = map.getTile(a.mx, a.my)
        if (tileNum) then
            if (TILES[tileNum].onReceiveItem(a, map)) deli(actors,i)
        end
    end

    map.traverse(function(mx , my, tileNum, tileFlags)
      if (isBit(tileFlags, MF_COLLISION)) then
        collided = true
        printh("OH NO ".. tostr(mx).. " " .. tostr(my))
        add(sprites, { x = (mx * TILE_WIDTH), y = (my * TILE_WIDTH), sprite = 2 })
      end
    end)
    frameAlpha = 0

    map.traverse(function(mx , my, tileNum, tileFlags)
      map.setFlag(mx, my, MF_PULSED, false) 
  end)

    
    ticksElapsed += 1

  end
end

function _draw()
  cls(1)
  local cx = 0
  local cy = 0
  local width, height = map.getSize()
  map.traverse(function(x, y, tileNum, tileFlags)
    TILES[tileNum].draw(x * TILE_WIDTH, y * TILE_HEIGHT, tileFlags)
  end)

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

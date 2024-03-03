
TILES = {}
ABBREVS = {}

MF_LOCKED = 0
MF_PULSED = 2
MF_PULSE_PROCESSED = 3
MF_OCCUPIED = 4
MF_COLLISION = 5

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
  
function initTiles() 

    TILES[0] = { abbrev=".",  name="empty",      behavior=nil, sprite=nil, flipy=true }
    TILES[1] = { abbrev="C", name="clock",      behavior=CLOCK_BEHAVIOR, sprite=70 }    
    TILES[5] = { abbrev=">",  name="belt-right", behavior=BELT_BEHAVIOR, beltx=1, belty=0, sprite=64 }
    TILES[6] = { abbrev="<",  name="belt-left",  behavior=BELT_BEHAVIOR, beltx=-1, belty=0, sprite=64, flipx=true }
    TILES[7] = { abbrev="^",  name="belt-up",    behavior=BELT_BEHAVIOR, beltx=0, belty=-1, sprite=66 }
    TILES[8] = { abbrev="V",  name="belt-down",  behavior=BELT_BEHAVIOR, beltx=0, belty=1, sprite=66, flipy=true }
    TILES[9] = { abbrev="E",  name="egg-crate",  behavior=CRATE_BEHAVIOR, beltx=1, belty=0, crateItem=1, sprite=96, badgeSprite=32 }    
    TILES[10] = { abbrev="F",  name="flour-crate", behavior=CRATE_BEHAVIOR, beltx=1, belty=0, crateItem=2, sprite=96, badgeSprite=34 }    
  
  
      printh("---------------------")
      for i, tile in pairs(TILES) do
        printh("---------------------!")
        ABBREVS[tile.abbrev] = i
        printh(tostr(i)..tostr(tile.abbrev))
      end
      printh("---------------------")
      

end





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
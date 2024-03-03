
TILES = {}
ABBREVS = {}

MF_LOCKED = 0
MF_PULSED = 2
MF_PULSE_PROCESSED = 3
MF_OCCUPIED = 4
MF_COLLISION = 5


local AbstractTile = {}
AbstractTile.new = function(fields)

  function self.onReceiveItem(actor)
  end

  function self.onPulse(mx, my, actors)
  end

  function self.willAccept(mx, my, tile, actor)
    return false
  end

  function self.onTick(mx, my, map)
  end

  function self.draw(cx, cy)
    drawSprite(fields.sprite, cx, cy)
  end

  function self.getAbbrev() 
    return fields.abbrev
  end

end


local BeltTile = {}
BeltTile.new = function(fields)
    local self = AbstractTile.new(fields)
    function self.onReceiveItem(actor)
        actor.dx = fields.beltx
        actor.dy = fields.belty
    end
    function self.willAccept(mx, my, actor)
        return (actor.dx == fields.beltx) and (actor.dy == fields.belty)
    end
    function self.draw(cx, cy)
        drawSprite(fields.sprite, cx, cy, fields.flipx or false, fields.flipy or false)
    end
end


local CrateTile = {}
CrateTile.new = function(fields)
    local self = AbstractTile.new(fields)
    function self.onPulse(mx, my, actors)
        add(actors, { mx=mx, my=my, dx=fields.beltx, dy=fields.belty, item=fields.crateItem })
    end
    function self.draw(cx, cy)
        drawSprite(fields.sprite, cx, cy)
        drawSprite(t.badgeSprite, cx, cy -2, false, false)
    end
end

local ClockTile = {}
ClockTile.new = function(args)
    local self = AbstractTile.new(args)
    function self.onTick(mx, my, map)
        if (ticksElapsed % 4 == 0) then
            map.setFlag(mx - 1, my,  MF_PULSED, true)
            map.setFlag(mx + 1, my,  MF_PULSED, true)      
            map.setFlag(mx, my + 1,  MF_PULSED, true)            
            map.setFlag(mx, my - 1,  MF_PULSED, true)                  
        end
    end
end


function initTiles() 

    TILES[0]  = AbstractTile.new{abbrev="."}
    TILES[1]  = ClockTile.new{abbrev="C", sprite=70}
    TILES[5]  = BeltTile.new{abbrev=">",  beltx=1, belty=0, sprite=64}
    TILES[6]  = BeltTile.new{abbrev="<",  beltx=-1, belty=0, sprite=64, flipx=true}
    TILES[7]  = BeltTile.new{abbrev="^",  beltx=0, belty=-1, sprite=66}
    TILES[8]  = BeltTile.new{abbrev="V",  beltx=0, belty=1, sprite=66, flipy=true}

    TILES[9]  = CrateTile.new{abbrev="E",  beltx=1, belty=0, crateItem=1, sprite=96, badgeSprite=32} -- egg crate
    TILES[10] = CrateTile.new{abbrev="F", beltx=1, belty=0, crateItem=2, sprite=96, badgeSprite=34} -- flour crate


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
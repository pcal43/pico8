
TILES = {}
ABBREVS = {}

MF_LOCKED = 8
MF_PULSED = 9
MF_PULSE_PROCESSED = 10
MF_OCCUPIED = 11
MF_COLLISION = 12

MF_MIXER_EGG = 0 -- kill
MF_MIXER_FLOUR = 1 -- kill

local TILE_FLAGS_MASK = 0b0000000011111111



local AbstractTile = {}
AbstractTile.new = function(fields)

  local self = {}

  function self.getStartingFlags()
  end
  
  function self.onReceiveItem(actor, map)
    return false
  end

  function self.onPulse(mx, my, tileFlags, tileFlags)
  end

  function self.willAccept(mx, my, tile, actor)
    return false
  end

  function self.onTick(mx, my, map)
  end

  function self.draw(cx, cy, tileFlags)
    if (fields.sprite >= 0) drawSprite(fields.sprite, cx, cy)
  end

  function self.getAbbrev() 
    return fields.abbrev
  end
  return self
end



local BeltTile = {}
BeltTile.new = function(fields)
    local self = AbstractTile.new(fields)
    function self.willAccept(mx, my, actor)
        return (actor.dx == fields.beltx) and (actor.dy == fields.belty)
    end
    function self.onReceiveItem(actor, map)
        actor.dx = fields.beltx
        actor.dy = fields.belty
        return false
    end
    function self.draw(cx, cy, tileFlags)
        drawSprite(fields.sprite, cx, cy, fields.flipx or false, fields.flipy or false)
    end
    return self
end


-- maybe there is no crate.  just holding tiles.  there are only three ingredients at the start and thats it
-- no infinite supply, just three things
-- yes.  this is the simplificiation we need

local CrateTile = {}
CrateTile.new = function(fields)
    local self = AbstractTile.new(fields)
    function self.onPulse(mx, my, tileFlags, actors)
        add(actors, { mx=mx, my=my, dx=fields.beltx, dy=fields.belty, item=fields.crateItem })
    end
    function self.draw(cx, cy, tileFlags)
        drawSprite(fields.sprite, cx, cy)
        drawSprite(fields.badgeSprite, cx, cy -2)
    end
    return self
end

-- maybe there is no crate.  just holding tiles.  there are only three ingredients at the start and thats it
-- no infinite supply, just three things
-- yes.  this is the simplificiation we need




local BinTile = {}
BinTile.new = function(fields)
    local self = AbstractTile.new(fields)
    function self.getStartingFlags()
        if (fields.startingItem == 0) return 0
        return fields.startingItem & MF_OCCUPIED
    end  
    function self.onPulse(mx, my, tileFlags, actors)
        local item = tileFlags & TILE_FLAGS_MASK
        if (item != 0) add(actors, { mx=mx, my=my, dx=fields.beltx, dy=fields.belty, item=item})
    end
    function self.onReceiveItem(actor, map)
        -- FIXME
    end
    function self.willAccept(mx, my, actor)
        return true
    end
    function self.draw(cx, cy, tileFlags)
        local item = tileFlags & TILE_FLAGS_MASK
        if (item != 0) then
            -- FIXME
            if (item == 1) drawSprite(32, cx, cy)
            if (item == 2) drawSprite(34, cx, cy)
            if (item == 3) drawSprite(36, cx, cy)
        end
        drawSprite(fields.sprite, cx, cy)        
    end
    return self
end

local ClockTile = {}
ClockTile.new = function(fields)
    local self = AbstractTile.new(fields)
    function self.onTick(mx, my, map)
        if (ticksElapsed % 4 == 0) then
            map.setFlag(mx - 1, my,  MF_PULSED, true)
            map.setFlag(mx + 1, my,  MF_PULSED, true)      
            map.setFlag(mx, my + 1,  MF_PULSED, true)            
            map.setFlag(mx, my - 1,  MF_PULSED, true)                  
        end
    end
    return self
end


local MixerTile = {}
MixerTile.new = function(fields)
    local self = AbstractTile.new(fields)
    function self.willAccept(mx, my, actor, actors)
        return true
    end
    function self.onReceiveItem(actor, map)
        if (actor.crateItem == 1) then
            if (map.getFlag(actor.mx, actor.my, MF_MIXER_EGG)) then
                map.setFlag(actor.mx, actor.my, MF_COLLISION)
            else
                map.setFlag(actor.mx, actor.my, MF_MIXER_EGG)
            end
        elseif (actor.crateItem == 2) then
            if (map.getFlag(actor.mx, actor.my, MF_MIXER_FLOUR)) then
                map.setFlag(actor.mx, actor.my, MF_COLLISION)
            else
                map.setFlag(actor.mx, actor.my, MF_MIXER_FLOUR)
            end
        end
        if (map.getFlag(actor.mx, actor.my, MF_MIXER_EGG) and map.getFlag(actor.mx, actor.my, MF_MIXER_FLOUR)) then
            add(actors, { mx=mx, my=my, dx=1, dy=0, item=3 })
        end

        actor.isRemoved = true
        return true
    end
    return self
end


function initTiles() 

    TILES[0]  = AbstractTile.new{abbrev=".", sprite=-1}
    TILES[1]  = ClockTile.new{abbrev="C", sprite=70}
    TILES[5]  = BeltTile.new{abbrev=">",  beltx=1, belty=0, sprite=64}
    TILES[6]  = BeltTile.new{abbrev="<",  beltx=-1, belty=0, sprite=64, flipx=true}
    TILES[7]  = BeltTile.new{abbrev="^",  beltx=0, belty=-1, sprite=66}
    TILES[8]  = BeltTile.new{abbrev="V",  beltx=0, belty=1, sprite=66, flipy=true}

    TILES[9]  = CrateTile.new{abbrev="E",  beltx=1, belty=0, crateItem=1, sprite=96, badgeSprite=32} -- egg crate
    TILES[10] = CrateTile.new{abbrev="F", beltx=1, belty=0, crateItem=2, sprite=96, badgeSprite=34} -- flour crate

    TILES[20] = MixerTile.new{abbrev="M", beltx=1, belty=0, sprite=72 } 

    TILES[30] = BinTile.new{abbrev="Q", beltx=1, belty=0, startingItem=0, sprite=98} -- empty bin
    TILES[31] = BinTile.new{abbrev="R", beltx=1, belty=0, startingItem=1, sprite=98} -- egg crate
    TILES[32] = BinTile.new{abbrev="S", beltx=1, belty=0, startingItem=2, sprite=98} -- flour bin
    TILES[33] = BinTile.new{abbrev="T", beltx=1, belty=0, startingItem=3, sprite=98} -- sugar bin

    printh("---------------------")
    for i, tile in pairs(TILES) do
        printh("---------------------!")
        ABBREVS[tile.getAbbrev()] = i
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
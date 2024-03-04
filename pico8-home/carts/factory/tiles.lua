
TILES = {}
ABBREVS = {}

MF_LOCKED = 8

MF_OCCUPIED = 15
MF_COLLISION = 14
MF_PULSED = 13
MF_PULSE_PROCESSED = 12



MF_MIXER_EGG = 0 -- kill
MF_MIXER_FLOUR = 1 -- kill

local STATE_FLAGS_MASK = 0b0000000011111111


--0001100000000000

local AbstractTile = {}
AbstractTile.new = function(fields)

  local self = {}

  function self.onLevelStart(mx, my, map)
  end

  function self.onTickStart(mx, my, map)
  end

  function self.onReceiveItem(actor, map)
    return false
  end

  function self.onPulse(mx, my, map, tileFlags, tileFlags)
  end

  function self.willAccept(mx, my, tile, actor)
    return false
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
    function self.onTickStart(mx, my, map)
        map.clearFlag(mx, my, MF_OCCUPIED)        
    end
    function self.willAccept(mx, my, actor)
        return (actor.dx == fields.beltx) and (actor.dy == fields.belty)
    end
    function self.onReceiveItem(actor, map)
        local mx, my = actor.mx, actor.my        
        if (map.getFlag(mx, my, MF_OCCUPIED)) then
            map.setFlag(mx, my, MF_COLLISION)
        else
            map.setFlag(mx, my, MF_OCCUPIED)
        end
        actor.dx = fields.beltx
        actor.dy = fields.belty
        return false
    end
    function self.draw(cx, cy, tileFlags)
        drawSprite(fields.sprite, cx, cy, fields.flipx or false, fields.flipy or false)
    end
    return self
end


local BinTile = {}
BinTile.new = function(fields)
    local self = AbstractTile.new(fields)
    function self.onLevelStart(mx, my, map)
        if (fields.startingItem > 0) then
            local flags = map.getFlags(mx, my)
            map.setFlags(mx, my, flags | (fields.startingItem & MF_OCCUPIED))
        end
    end 
    function self.onPulse(mx, my, map, tileFlags, actors)
        local item = tileFlags & STATE_FLAGS_MASK
        if (item > 0) then
            add(actors, { mx=mx, my=my, dx=fields.beltx, dy=fields.belty, item=item})
            tileFlags = tileFlags & ~STATE_FLAGS_MASK -- clear tile state flags
            tileFlags = clearBit(tileFlags, MF_OCCUPIED)
            tileFlags = clearBit(tileFlags, MF_PULSED)
            map.setFlags(mx, my, tileFlags)
        end
    end
    function self.onReceiveItem(actor, map)
        local mx, my = actor.mx, actor.my
        if (map.getFlag(mx, my, MF_OCCUPIED)) then
            map.setFlag(mx, my, MF_COLLISION)
        else
            local flags = map.getFlags(mx, my)
            flags = flags & ~STATE_FLAGS_MASK    -- clear any tile state flags            
            flags = (flags | (1<<MF_OCCUPIED))  -- set the occupied map flag
            flags = flags | actor.item          -- set the tile state to be the item number
            map.setFlags(mx, my, flags)
            actor.isRemoved = true
        end
        return true
    end
    function self.willAccept(mx, my, actor)
        return true
    end
    function self.draw(cx, cy, tileFlags)
        local item = tileFlags & STATE_FLAGS_MASK
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
    function self.onTickStart(mx, my, map)
        if (ticksElapsed % 4 == 0) then
            map.setFlag(mx - 1, my,  MF_PULSED)
            map.setFlag(mx + 1, my,  MF_PULSED)
            map.setFlag(mx, my + 1,  MF_PULSED)
            map.setFlag(mx, my - 1,  MF_PULSED)
        end
    end
    return self
end

local StarterTile = {}
StarterTile.new = function(fields)
    local self = AbstractTile.new(fields)
    function self.onLevelStart(mx, my, map)
        printh("STARTER!")
        map.setFlag(mx - 1, my,  MF_PULSED)
        map.setFlag(mx + 1, my,  MF_PULSED)
        map.setFlag(mx, my + 1,  MF_PULSED)
        map.setFlag(mx, my - 1,  MF_PULSED)
        printh(map.getFlagsStr(0,1) .. "    "..map.getFlagsStr(1,0))
    end
    return self
end


local MixerTile = {}
MixerTile.new = function(fields)

    local ITEM_FLAG_OFFSET = 8
    local SF_IS_MIXING = 7
    local SF_MIXING_TIMER_MASK = 0b0000000000001111
    local ITEM_COLORS = { 10,  8, 12 }

    local ITEM_BUTTER = 1    
    local ITEM_FLOUR = 2
    local ITEM_SUGAR = 3    

    local self = AbstractTile.new(fields)

    function self.onTickStart(mx, my, map)
    end

    function self.willAccept(mx, my, actor, actors)
        return true
    end
    function self.onReceiveItem(actor, map)
        local mx, my = actor.mx, actor.my
        local tileFlags = map.getFlags(mx, my)
        local itemFlag = ITEM_FLAG_OFFSET + actor.item
        if (isBit(tileFlags,itemFlag )) then
            map.setFlag(mx, my, MF_COLLISION)
            return false
        else
            map.setFlag(mx, my, itemFlag)
            actor.isRemoved = true
            return true
        end
    end
    function self.draw(cx, cy, tileFlags)
        drawSprite(fields.sprite, cx, cy)
        local bank = 0
        for i=1,#ITEM_COLORS,1 do
            local itemFlag = ITEM_FLAG_OFFSET + i
            if (isBit(tileFlags, itemFlag)) then
                rectfill(cx+4,cy+4+bank,cx+11,cy+6+bank,ITEM_COLORS[i])
                bank += 5
            end
        end
    end
    
    return self
end


function initTiles() 

    TILES[0]  = AbstractTile.new{abbrev=".", sprite=-1}
    TILES[1]  = StarterTile.new{abbrev="!", sprite=78}
    TILES[2]  = ClockTile.new{abbrev="C", sprite=70}
    TILES[5]  = BeltTile.new{abbrev=">",  beltx=1, belty=0, sprite=64}
    TILES[6]  = BeltTile.new{abbrev="<",  beltx=-1, belty=0, sprite=64, flipx=true}
    TILES[7]  = BeltTile.new{abbrev="^",  beltx=0, belty=-1, sprite=66}
    TILES[8]  = BeltTile.new{abbrev="V",  beltx=0, belty=1, sprite=66, flipy=true}

    TILES[20] = MixerTile.new{abbrev="M", beltx=1, belty=0, sprite=72 } 

    TILES[30] = BinTile.new{abbrev="O", beltx=1, belty=0, startingItem=0, sprite=98} -- empty bin
    TILES[31] = BinTile.new{abbrev="B", beltx=1, belty=0, startingItem=1, sprite=98} -- egg crate
    TILES[32] = BinTile.new{abbrev="F", beltx=1, belty=0, startingItem=2, sprite=98} -- flour bin
    TILES[33] = BinTile.new{abbrev="S", beltx=1, belty=0, startingItem=3, sprite=98} -- sugar bin

    for i, tile in pairs(TILES) do
        ABBREVS[tile.getAbbrev()] = i
        --printh(tostr(i)..tostr(tile.abbrev))
    end
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

TILES = {}
ABBREVS = {}

MF_LOCKED = 15
MF_OCCUPIED = 14
MF_COLLISION = 13
MF_PULSED = 12
MF_PULSE_PROCESSED = 11

local STATE_FLAGS_MASK = 0b0000000011111111
local FLOOR_SPRITE = 4

local AbstractTile = {}
AbstractTile.new = function(fields)

  local self = {}

  function self.onLevelInit(mx, my, map, tileFlags)
    map.setFlag(mx, my, MF_LOCKED)
  end

  function self.onTickStart(mx, my, map, tileFlags, actors)
  end

  function self.onReceiveItem(actor, map)
      return false
  end

  function self.onPulse(mx, my, map, tileFlags)
  end

  function self.willAccept(mx, my, tile, actor)
    return false
  end

  function self.draw(cx, cy, tileFlags, ticksElapsed, frameAlpha)
    drawSprite(fields.sprite, cx, cy)
  end

  function self.getAbbrev() 
    return fields.abbrev
  end
  
  return self
end

local FloorTile = {}
FloorTile.new = function(fields)
    local self = AbstractTile.new(fields)
    function self.onLevelInit(mx, my, map, tileFlags)
        -- these are the only tiles that aren't locked
    end
    function self.draw(cx, cy, tileFlags)
        drawSprite(fields.sprite, cx, cy)    
    end
    return self
end

local BeltTile = {}
BeltTile.new = function(fields)
    local self = AbstractTile.new(fields)
    function self.onTickStart(mx, my, map, tileFlags, actors)
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
        drawSprite(FLOOR_SPRITE, cx, cy)
        drawSprite(fields.sprite, cx, cy, fields.flipx or false, fields.flipy or false)
    end
    return self
end


local BinTile = {}
BinTile.new = function(fields)
    local self = AbstractTile.new(fields)
    local parentOnLevelInit = self.onLevelInit

    local SF_ITEM_START = 4
    local SF_ITEM_SIZE = 4

    function self.onLevelInit(mx, my, map, tileFlags)
        printh("INIT")
        if (fields.startingItem > 0) then
            tileFlags = setBit(tileFlags, MF_OCCUPIED)
            tileFlags = setBitInt(tileFlags, SF_ITEM_START, SF_ITEM_SIZE, fields.startingItem)
            map.setFlags(mx, my, tileFlags)

            local q = getBitInt(tileFlags, SF_ITEM_START, SF_ITEM_SIZE)
        end
        parentOnLevelInit(mx, my, map, tileFlags)
    end 
    function self.onPulse(mx, my, map, tileFlags, actors)
        local itemNumber = getBitInt(tileFlags, SF_ITEM_START, SF_ITEM_SIZE)
        if (itemNumber > 0) then
            add(actors, { mx=mx, my=my, dx=fields.beltx, dy=fields.belty, type=ITEMS[itemNumber]})
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
            flags = flags & ~STATE_FLAGS_MASK       -- clear any tile state flags            
            flags = (flags | (1<<MF_OCCUPIED))      -- set the occupied map flag
            flags = flags | actor.type.getNumber()  -- set the tile state to be the item number
            map.setFlags(mx, my, flags)
            actor.isRemoved = true
        end
        return true
    end
    function self.willAccept(mx, my, actor)
        return true
    end
    function self.draw(cx, cy, tileFlags)
        local itemNumber = getBitInt(tileFlags, SF_ITEM_START, SF_ITEM_SIZE)
        if (itemNumber > 0) ITEMS[itemNumber].draw(cx,cy)
        drawSprite(fields.sprite, cx, cy)        
    end
    return self
end

local ClockTile = {}
ClockTile.new = function(fields)
    local self = AbstractTile.new(fields)
    function self.onTickStart(mx, my, map, tileFlags, actors)
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
    local parentOnLevelInit = self.onLevelInit
    function self.onLevelInit(mx, my, map, tileFlags)
        map.setFlag(mx - 1, my,  MF_PULSED)
        map.setFlag(mx + 1, my,  MF_PULSED)
        map.setFlag(mx, my + 1,  MF_PULSED)
        map.setFlag(mx, my - 1,  MF_PULSED)
        -- printh(map.getFlagsStr(0,1) .. "    "..map.getFlagsStr(1,0))
        parentOnLevelInit(mx, my, map, tileFlags)
    end
    
    return self
end


local MixerTile = {}
MixerTile.new = function(fields)

    local ITEM_FLAG_OFFSET = 3
    local SF_ITEM_START = 2
    local SF_ITEM_SIZE = 2


    local self = AbstractTile.new(fields)

    function self.onTickStart(mx, my, map, tileFlags, actors)
        local mixingProgress = getBitInt(tileFlags, SF_ITEM_START, SF_ITEM_SIZE)
        if (mixingProgress > 0) then
            if (mixingProgress >= 3) then
                local binned = getBinnedItems(tileFlags)
                add(actors, { mx=mx, my=my, dx=1, dy=0, type=ITEMS[RECIPES[binned[1]][binned[2]]]})
                tileFlags = setBitInt(tileFlags, SF_ITEM_START, SF_ITEM_SIZE, 0)
                tileFlags = clearBit(tileFlags, MF_OCCUPIED)
                tileFlags = clearBit(tileFlags, MF_PULSED)
            else
                mixingProgress += 1
                tileFlags = setBitInt(tileFlags, SF_ITEM_START, SF_ITEM_SIZE, mixingProgress)
            end
            map.setFlags(mx, my, tileFlags)
        end
    end

    function self.willAccept(mx, my, actor, actors)
        return true
    end

    function self.onReceiveItem(actor, map)
        local mx, my = actor.mx, actor.my
        local tileFlags = map.getFlags(mx, my)
        local inputTypeNumber = actor.type.getNumber()
        local itemFlag = ITEM_FLAG_OFFSET + inputTypeNumber
        local binned = getBinnedItems(tileFlags)
        actor.isRemoved = true
        printh("rrr  "..tostr(RECIPES[ITEM_BUTTER][ITEM_SUGAR]))
        printh("xxx  "..tostr(binned[1]) .. "   " .. tostr(inputTypeNumber) .. " " .. tostr(RECIPES[binned[1]]))
        if (count(binned) == 0 or (count(binned) == 1 and RECIPES[binned[1]][inputTypeNumber] != nil)) then            
            tileFlags = setBit(tileFlags, itemFlag)
            tileFlags = setBitInt(tileFlags, SF_ITEM_START, SF_ITEM_SIZE, 1)
            map.setFlags(mx, my, tileFlags)
        else 
            map.setFlag(mx, my, MF_COLLISION)
        end
    end

    function self.draw(cx, cy, tileFlags, ticksElapsed, frameAlpha)
        drawSprite(fields.sprite, cx, cy)
        local mixingProgress = getBitInt(tileFlags, SF_ITEM_START, SF_ITEM_SIZE)
        if (mixingProgress > 0) then
            items = getBinnedItems(tileFlags)
            local bankY = 0
            if (count(items) == 2 and frameAlpha % 4 < 2) then
                items[1], items[2] = items[2], items[1]
            end
            for item in all(items) do
                rectfill(cx+4,cy+4+bankY,cx+11,cy+6+bankY,ITEMS[item].getColor())
                bankY += 5
            end
        end
    end

    function getBinnedItems(tileFlags)
        local out = {}
        for i=1,#ITEMS,1 do
            local itemFlag = ITEM_FLAG_OFFSET + i
            if (isBit(tileFlags, itemFlag)) then
                add(out, i)
            end
        end
        return out
    end
    
    return self
end


function initTiles() 
    TILES[0]  = FloorTile.new{abbrev=",", sprite=4}
    TILES[1]  = AbstractTile.new{abbrev="#", sprite=100}    
    TILES[2]  = AbstractTile.new{abbrev=".", sprite=0}
    TILES[3]  = StarterTile.new{abbrev="!", sprite=78}
    TILES[4]  = AbstractTile.new{abbrev="$", sprite=74}

    TILES[10] = ClockTile.new{abbrev="C", sprite=70}
    TILES[11] = BeltTile.new{abbrev=">",  beltx=1, belty=0, sprite=64}
    TILES[12] = BeltTile.new{abbrev="<",  beltx=-1, belty=0, sprite=64, flipx=true}
    TILES[13] = BeltTile.new{abbrev="^",  beltx=0, belty=-1, sprite=66}
    TILES[14] = BeltTile.new{abbrev="V",  beltx=0, belty=1, sprite=66, flipy=true}

    TILES[20] = MixerTile.new{abbrev="M", beltx=1, belty=0, sprite=72 } 

    TILES[30] = BinTile.new{abbrev="O", beltx=1, belty=0, startingItem=0, sprite=98} -- empty bin
    TILES[31] = BinTile.new{abbrev="B", beltx=1, belty=0, startingItem=ITEM_BUTTER, sprite=98} -- egg crate
    TILES[32] = BinTile.new{abbrev="F", beltx=1, belty=0, startingItem=ITEM_FLOUR, sprite=98} -- flour bin
    TILES[33] = BinTile.new{abbrev="S", beltx=1, belty=0, startingItem=ITEM_SUGAR, sprite=98} -- sugar bin

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
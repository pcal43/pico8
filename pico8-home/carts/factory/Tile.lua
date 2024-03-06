
TILES = nil
ABBREVS = nil

-- TODO consider encapsulating these (e.g., Tile.isLocked())
MF_LOCKED = 15
MF_OCCUPIED = 14
MF_COLLISION = 13
MF_PULSED = 12
MF_PULSE_PROCESSED = 11

MF_OUTDIR_START = 10
MF_OUTDIR_LEN = 3
-- 9
-- 8

local STATE_FLAGS_MASK = 0b0000000011111111
local FLOOR_SPRITE = 4

local Tile = {}
Tile.new = function(fields)
  local self = {}

  function self.onLevelInit(mx, my, map, tileFlags)
    local dir = findOutboundDir(map, Position.new(mx,my))
    local dirNum
    if (dir == nil) then
        dirNum = 0
    else 
        dirNum = dir.number
    end
    tileFlags = setBitInt(tileFlags, MF_OUTDIR_START, MF_OUTDIR_LEN, dirNum)
    tileFlags = setBit(tileFlags, MF_LOCKED)
    map.setFlags(mx, my, tileFlags)    
  end

  function self.getOutboundDir(tileFlags)
     local dirNum = getBitInt(tileFlags, MF_OUTDIR_START, MF_OUTDIR_LEN)
     if (dirNum == 0) return nil -- ruh roh
     return DIRECTIONS[dirNum]
  end

  function self.onTickStart(mx, my, map, tileFlags, actors)
  end

  function self.onReceiveItem(actor, map)
    map.setFlag(actor.mx, actor.my, MF_COLLISION)
    return false
  end

  function self.onPulse(mx, my, map, tileFlags)
  end

  function self.getReceivePriority(map, pos, dir)
    return 0
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
    local self = Tile.new(fields)
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
    local self = Tile.new(fields)
    function self.onTickStart(mx, my, map, tileFlags, actors)
        map.clearFlag(mx, my, MF_OCCUPIED)        
    end
    function self.getReceivePriority(map, pos, dir)
        if (dir.dx == fields.beltx and dir.dy == fields.belty) return 999
        if (dir.dx == -fields.beltx or dir.dy == -fields.belty)  then
            return 0
        end
        return 500  -- meh
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
    local self = Tile.new(fields)
    local parentOnLevelInit = self.onLevelInit

    local SF_ITEM_START = 4
    local SF_ITEM_SIZE = 4

    function self.onLevelInit(mx, my, map, tileFlags)
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
            local dir = self.getOutboundDir(tileFlags)
            if (dir == nil) then
                tileFlags = setBit(tileFlags, MF_COLLISION)
            else
                -- printh("EJECT" .. tostr(dir.number) .. " " .. tostr(dir.dx) .. " " .. tostr(dir.dy))
                add(actors, { mx=mx, my=my, dx=dir.dx, dy=dir.dy, type=ITEMS[itemNumber]})
            end
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

    function self.getReceivePriority(map, pos, dir)
        return 250
    end  

    function self.draw(cx, cy, tileFlags)
        local itemNumber = getBitInt(tileFlags, SF_ITEM_START, SF_ITEM_SIZE)
        if (itemNumber > 0) ITEMS[itemNumber].draw(cx,cy)
        drawSprite(fields.sprite, cx, cy)        
    end
    return self
end

--FIXME
local ClockTile = {}
ClockTile.new = function(fields)
    local self = Tile.new(fields)
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

local GoalTile = {}
GoalTile.new = function(fields)
    local self = Tile.new(fields)
    function self.onReceiveItem(actor, map)
        if (actor.type.getNumber() == ITEM_CAKE) then
            CONTROLLER.notifyCakeMade()
        else
            map.setFlag(actor.mx, actor.my, MF_COLLISION)
        end
    end
    return self
end

local StarterTile = {}
StarterTile.new = function(fields)
    local self = Tile.new(fields)
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
    local SF_PROGRESS = 2
    local SF_PROGRESS_LEN = 2


    local self = Tile.new(fields)

    function self.onTickStart(mx, my, map, tileFlags, actors)
        local mixingProgress = getBitInt(tileFlags, SF_PROGRESS, SF_PROGRESS_LEN)
        if (mixingProgress > 0) then
            if (mixingProgress >= 3) then
                local outDir = self.getOutboundDir(tileFlags)
                if (outDir == nil) then
                    tileFlags = setBitInt(tileFlags, MF_COLLISION)
                else
                    local binned = getBinnedItems(tileFlags)    
                    add(actors, { mx=mx, my=my, dx=outDir.dx, dy=outDir.dy, type=ITEMS[RECIPES[binned[1]][binned[2]]]})
                    tileFlags = setBitInt(tileFlags, SF_PROGRESS, SF_PROGRESS_LEN, 0)
                    tileFlags = clearBit(tileFlags, MF_OCCUPIED)
                    tileFlags = clearBit(tileFlags, MF_PULSED)
                end
            else
                mixingProgress += 1
                tileFlags = setBitInt(tileFlags, SF_PROGRESS, SF_PROGRESS_LEN, mixingProgress)
            end
            map.setFlags(mx, my, tileFlags)
        end
    end
    function self.getReceivePriority(map, pos, dir)
        return 250
    end  
    
    function self.onReceiveItem(actor, map)
        local mx, my = actor.mx, actor.my
        local tileFlags = map.getFlags(mx, my)
        local inputTypeNumber = actor.type.getNumber()
        local itemFlag = ITEM_FLAG_OFFSET + inputTypeNumber
        local binned = getBinnedItems(tileFlags)
        actor.isRemoved = true
        -- printh("rrr  "..tostr(RECIPES[ITEM_BUTTER][ITEM_SUGAR]))
        -- printh("xxx  "..tostr(binned[1]) .. "   " .. tostr(inputTypeNumber) .. " " .. tostr(RECIPES[binned[1]]))
        if (count(binned) == 0 or (count(binned) == 1 and RECIPES[binned[1]][inputTypeNumber] != nil)) then            
            tileFlags = setBit(tileFlags, itemFlag)
            if (count(binned) == 1) tileFlags = setBitInt(tileFlags, SF_PROGRESS, SF_PROGRESS_LEN, 1)
            map.setFlags(mx, my, tileFlags)
        else 
            map.setFlag(mx, my, MF_COLLISION)
        end
    end

    function self.draw(cx, cy, tileFlags, ticksElapsed, frameAlpha)
        drawSprite(fields.sprite, cx, cy)
        local mixingProgress = getBitInt(tileFlags, SF_PROGRESS, SF_PROGRESS_LEN)
        items = getBinnedItems(tileFlags)
        local bankY = 0
        if (mixingProgress > 0) then
            if (count(items) == 2 and frameAlpha % 4 < 2) then
                items[1], items[2] = items[2], items[1]
            end
        end
        for item in all(items) do
            rectfill(cx+4,cy+4+bankY,cx+11,cy+6+bankY, ITEMS[item].getColor())
            bankY += 5
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
    TILES = {}
    TILES[0]  = FloorTile.new{abbrev=",", sprite=4}
    TILES[1]  = Tile.new{abbrev="#", sprite=100}    
    TILES[2]  = Tile.new{abbrev=".", sprite=0}
    TILES[3]  = StarterTile.new{abbrev="!", sprite=78}
    TILES[4]  = GoalTile.new{abbrev="$", sprite=74}

    TILES[10] = ClockTile.new{abbrev="@", sprite=70}
    TILES[11] = BeltTile.new{abbrev=">",  beltx=1, belty=0, sprite=64}
    TILES[12] = BeltTile.new{abbrev="<",  beltx=-1, belty=0, sprite=64, flipx=true}
    TILES[13] = BeltTile.new{abbrev="^",  beltx=0, belty=-1, sprite=66}
    TILES[14] = BeltTile.new{abbrev="V",  beltx=0, belty=1, sprite=66, flipy=true}

    TILES[20] = MixerTile.new{abbrev="M", beltx=1, belty=0, sprite=72 } 

    TILES[30] = BinTile.new{abbrev="E", startingItem=0, sprite=98} -- empty bin
    TILES[31] = BinTile.new{abbrev="B", startingItem=ITEM_BUTTER, sprite=98} -- butter bin
    TILES[32] = BinTile.new{abbrev="F", startingItem=ITEM_FLOUR, sprite=98} -- flour bin
    TILES[34] = BinTile.new{abbrev="S", startingItem=ITEM_SUGAR, sprite=98} -- sugar bin
    TILES[35] = BinTile.new{abbrev="P", startingItem=ITEM_SPONGE, sprite=98} -- sponge bin
    TILES[36] = BinTile.new{abbrev="I", startingItem=ITEM_SPONGE, sprite=98} -- icing bin
    TILES[37] = BinTile.new{abbrev="C", startingItem=ITEM_SPONGE, sprite=98} -- cake bin

    ABBREVS = {}
    for i, tile in pairs(TILES) do
        ABBREVS[tile.getAbbrev()] = i
        --printh(tostr(i)..tostr(tile.abbrev))
    end
end



function findOutboundDir(map, pos)
    local winningPriority = 0
    local winningDirection = nil
    for dir in all(DIRECTIONS) do
        local npos = Position.new(pos.x, pos.y).move(dir)
        local tileNum = map.getTile(npos.x, npos.y)
        if (tileNum) then
            local thisPriority = TILES[tileNum].getReceivePriority(map, pos, dir)
            if (thisPriority > winningPriority) then
                winningPriority = thisPriority
                winningDirection = dir
            end
        end
    end
    if (winningDirection) then
    -- printh("WINNING DIRECTION " .. tostr(winningDirection.number))
    end
    return winningDirection
end

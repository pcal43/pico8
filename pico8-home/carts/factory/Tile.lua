
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

  function self.onLevelInit(map, pos, tileFlags)
    local dir = findOutboundDir(map, pos)
    local dirNum
    if (dir == nil) then
        dirNum = 0
    else 
        dirNum = dir.number
    end
    tileFlags = setBitInt(tileFlags, MF_OUTDIR_START, MF_OUTDIR_LEN, dirNum)
    tileFlags = setBit(tileFlags, MF_LOCKED)
    map.setFlagsP(pos, tileFlags)    
  end

  function self.getOutboundDir(tileFlags)
     local dirNum = getBitInt(tileFlags, MF_OUTDIR_START, MF_OUTDIR_LEN)
     if (dirNum == 0) return nil -- ruh roh
     return DIRECTIONS[dirNum].copy()
  end

  function self.onTickStart(map, pos, tileFlags, items)
  end

  function self.onReceiveItem(item, map)
    map.setFlagP(item.pos, MF_COLLISION)
    return false
  end

  function self.onPulse(map, pos, tileFlags)
  end

  function self.getReceivePriority(map, pos, dir)
    return 0
  end

  function self.canReceive()
    return false
  end

  function self.draw(cx, cy, tileFlags, ticksElapsed, frameAlpha)
    drawSprite(fields.sprite, cx, cy)
    if (fields.badge) then
        drawSprite(fields.badge, cx + 4, cy + 4)
    end
  end

  function self.getAbbrev() 
    return fields.abbrev
  end
  
  return self
end

local FloorTile = {}
FloorTile.new = function(fields)
    local self = Tile.new(fields)
    function self.onLevelInit(map, pos, tileFlags)
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
    function self.onTickStart(map, pos, tileFlags, items)
        map.clearFlagP(pos, MF_OCCUPIED)        
    end
    function self.canReceive()
        return true
    end
    function self.getReceivePriority(map, pos, dir)
        if (dir.dx == fields.beltx and dir.dy == fields.belty) return 999
        if (dir.dx == -fields.beltx or dir.dy == -fields.belty) then
            return 0
        end
        return 500  -- meh
    end  
    function self.onReceiveItem(item, map)
        if (map.getFlagP(item.pos, MF_OCCUPIED)) then
            map.setFlagP(item.pos, MF_COLLISION)
        else
            map.setFlagP(item.pos, MF_OCCUPIED)
        end
        item.dir.dx = fields.beltx
        item.dir.dy = fields.belty
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

    function self.onLevelInit(map, pos, tileFlags)
        if (fields.startingItem > 0) then
            tileFlags = setBit(tileFlags, MF_OCCUPIED)
            tileFlags = setBitInt(tileFlags, SF_ITEM_START, SF_ITEM_SIZE, fields.startingItem)
            map.setFlagsP(pos, tileFlags)
            local q = getBitInt(tileFlags, SF_ITEM_START, SF_ITEM_SIZE)
        end
        parentOnLevelInit(map, pos, tileFlags)
    end 

    function self.onPulse(map, pos, tileFlags, items)
        local itemNumber = getBitInt(tileFlags, SF_ITEM_START, SF_ITEM_SIZE)
        if (itemNumber > 0) then
            local dir = self.getOutboundDir(tileFlags)
            if (dir == nil) then
                tileFlags = setBit(tileFlags, MF_COLLISION)
            else
                add(items, Item.new(ITEMS[itemNumber], pos, dir))
            end
            tileFlags = tileFlags & ~STATE_FLAGS_MASK -- clear tile state flags
            tileFlags = clearBit(tileFlags, MF_OCCUPIED)
            tileFlags = clearBit(tileFlags, MF_PULSED)
            map.setFlagsP(pos, tileFlags)            
        end
    end

    function self.onReceiveItem(item, map)
        if (map.getFlagP(item.pos, MF_OCCUPIED)) then
            map.setFlagP(item.pos, MF_COLLISION)
        else
            local flags = map.getFlagsP(item.pos)
            flags = flags & ~STATE_FLAGS_MASK       -- clear any tile state flags            
            flags = (flags | (1<<MF_OCCUPIED))      -- set the occupied map flag
            flags = flags | item.type.getNumber()  -- set the tile state to be the item number
            map.setFlagP(item.pos, flags)
            item.isRemoved = true
        end
        return true
    end
    function self.canReceive()
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

local SensorTile = {}
SensorTile.new = function(fields)
    local self = Tile.new(fields)
    function self.canReceive()
        return true
    end
    function self.getReceivePriority(map, pos, dir)
        return 350
    end  
    function self.onReceiveItem(item, map)
        local tileFlags = map.getFlagsP(item.pos)
        local dir = self.getOutboundDir(tileFlags)
        if (dir == nil) then
            map.setFlagP(item.pos, MF_COLLISION)
        else
            item.dir.dx = dir.dx
            item.dir.dy = dir.dy
        end
        pulseNeighbors(map, item.pos)
    end
    return self
end

local DiverterTile = {}
DiverterTile.new = function(fields)
    local self = Tile.new(fields)

    local FLAG_DIR_START = 0
    local FLAG_DIR_LEN = 2  
    local FLAG_VALID_DIR_START = 2

    function self.onLevelInit(map, pos, tileFlags)
        for i=0,3 do
            local dir = DIRECTIONS[i+1]
            local tileNum = map.getTileP(pos.copy().move(dir))
            if (tileNum and TILES[tileNum].canReceive()) tileFlags = setBit(tileFlags, FLAG_VALID_DIR_START+i)
        end
        tileFlags = setBitInt(tileFlags, FLAG_DIR_START, FLAG_DIR_LEN, fields.startingDir.number - 1)
        map.setFlagsP(pos, tileFlags)
        printh("SET!" .. bitStr(tileFlags, 8))        

    end
    function self.canReceive()
        return true
    end
    function self.getReceivePriority(map, pos, fromDir)
        --[[
        printh("buh")
        local tileFlags = map.getFlagsP(pos)
        printh("buh")        
        local pointDir = DIRECTIONS[getBitInt(tileFlags, FLAG_DIR_START, FLAG_DIR_LEN)]
        if (pointDir == nil) then
            printh("OHNO NO DIR")
            return 500
        end
        printh("buh")
        if (fromDir.dx == pointDir.dx and fromDir.dy == pointDir.dy) return 999
        printh("buh")
        if (fromDir.dx == -pointDir.dx or fromDir.dy == -pointDir.dy) return 0
        printh("buh")
        ]]--
        return 250  -- meh
    end  
    function self.onReceiveItem(item, map)        
        local tileFlags = map.getFlagsP(item.pos)
        local pointDir = DIRECTIONS[getBitInt(tileFlags, FLAG_DIR_START, FLAG_DIR_LEN) + 1]  
        -- printh("I STARTED "..tostr(fields.startingDir.number))
        -- printh("GOING MY WAY?  "..tostr(pointDir.number))      
        item.dir.dx = pointDir.dx
        item.dir.dy = pointDir.dy
    end
    function self.onPulse(map, pos, tileFlags, items)
        tileFlags = clearBit(tileFlags, MF_PULSED)
        local currentDirNum = getBitInt(tileFlags, FLAG_DIR_START, FLAG_DIR_LEN)
        local dirsToCheck = {}
        for i=1,3 do
            add(dirsToCheck, DIRECTIONS[((currentDirNum + i) % 4) + 1])
        end
        local newDir = findOutboundDir(map, pos, dirsToCheck)
        if (newDir) tileFlags = setBitInt(tileFlags, FLAG_DIR_START, FLAG_DIR_LEN, newDir.number)
        map.setFlagsP(pos, tileFlags)
    end
    function self.draw(cx, cy, tileFlags, ticksElapsed, frameAlpha)
        drawSprite(98, cx, cy)
        local dirNum = getBitInt(tileFlags, FLAG_DIR_START, FLAG_DIR_LEN)
        drawSprite(201 + dirNum % 2, cx + 4, cy + 4, dirNum == 2, dirNum == 3)
      end    
    return self
end

local GoalTile = {}
GoalTile.new = function(fields)
    local self = Tile.new(fields)

    function self.canReceive()
        return true
    end
    function self.getReceivePriority(map, pos, dir)
        return 250
    end  

    function self.onReceiveItem(item, map)
        if (item.type.getNumber() == ITEM_CAKE) then
            CONTROLLER.notifyCakeMade()
        else
            map.setFlagP(item.pos, MF_COLLISION)
        end
    end
    return self
end

local StarterTile = {}
StarterTile.new = function(fields)
    local self = Tile.new(fields)
    local parentOnLevelInit = self.onLevelInit
    function self.onLevelInit(map, pos, tileFlags)
        pulseNeighbors(map, pos)
        -- printh(map.getFlagsStr(0,1) .. "    "..map.getFlagsStr(1,0))
        parentOnLevelInit(map, pos, tileFlags)
    end
    
    return self
end


local MixerTile = {}
MixerTile.new = function(fields)

    local ITEM_FLAG_OFFSET = 3
    local SF_PROGRESS = 2
    local SF_PROGRESS_LEN = 2
    local self = Tile.new(fields)

    function self.onTickStart(map, pos, tileFlags, items)
        local mixingProgress = getBitInt(tileFlags, SF_PROGRESS, SF_PROGRESS_LEN)
        if (mixingProgress > 0) then
            if (mixingProgress >= 3) then
                local outDir = self.getOutboundDir(tileFlags)
                if (outDir == nil) then
                    tileFlags = setBit(tileFlags, MF_COLLISION)
                else
                    local binned = getBinnedItems(tileFlags)    
                    add(items, Item.new(ITEMS[RECIPES[binned[1]][binned[2]]], pos, outDir))
                    tileFlags = setBitInt(tileFlags, SF_PROGRESS, SF_PROGRESS_LEN, 0)
                    tileFlags = clearBit(tileFlags, MF_OCCUPIED)
                    tileFlags = clearBit(tileFlags, MF_PULSED)
                    for i=1,#ITEMS,1 do
                        if (i != ITEM_CAKE) then -- FIXME we're out of bits.  dont need one for cake.  but we should get more bits anyway
                            tileFlags = clearBit(tileFlags, ITEM_FLAG_OFFSET + i)
                        end
                    end
                end
            else
                mixingProgress += 1
                tileFlags = setBitInt(tileFlags, SF_PROGRESS, SF_PROGRESS_LEN, mixingProgress)
            end
            map.setFlagsP(pos, tileFlags)
        end
    end

    function self.canReceive()
        return true
    end
    function self.getReceivePriority(map, pos, dir)
        return 250
    end  
    
    function self.onReceiveItem(item, map)
        local tileFlags = map.getFlagsP(item.pos)
        local inputTypeNumber = item.type.getNumber()
        local itemFlag = ITEM_FLAG_OFFSET + inputTypeNumber
        local binned = getBinnedItems(tileFlags)
        item.isRemoved = true
        -- printh("rrr  "..tostr(RECIPES[ITEM_BUTTER][ITEM_SUGAR]))
        -- printh("xxx  "..tostr(binned[1]) .. "   " .. tostr(inputTypeNumber) .. " " .. tostr(RECIPES[binned[1]]))
        if (count(binned) == 0 or (count(binned) == 1 and RECIPES[binned[1]][inputTypeNumber] != nil)) then            
            tileFlags = setBit(tileFlags, itemFlag)
            if (count(binned) == 1) tileFlags = setBitInt(tileFlags, SF_PROGRESS, SF_PROGRESS_LEN, 1)
            map.setFlagsP(item.pos, tileFlags)
        else 
            map.setFlagP(item.pos, MF_COLLISION)
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
            if (i != ITEM_CAKE) then -- FIXME we're out of bits.  dont need one for cake.  but we should get more bits anyway
                local itemFlag = ITEM_FLAG_OFFSET + i
                if (isBit(tileFlags, itemFlag)) then
                    add(out, i)
                end
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
    TILES[5]  = SensorTile.new{abbrev="?", sprite=98, badge=200}

    TILES[6]  = DiverterTile.new{abbrev="}", sprite=98, badge=202, startingDir=RIGHT }
    TILES[7]  = DiverterTile.new{abbrev="\\", sprite=98, badge=202, startingDir=DOWN }
    TILES[8]  = DiverterTile.new{abbrev="{", sprite=98, badge=202, startingDir=LEFT }
    TILES[9]  = DiverterTile.new{abbrev="/", sprite=98, badge=202, startingDir=UP }    

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


    -- TODO should probably also check for inbound belts.  if there's only one, then give (somewhat?) highter priority to
    --    opposite direction.  ???
    function findOutboundDir(map, pos, dirs)
        local winningPriority = 0
        local winningDirection = nil
        for dir in all(dirs or DIRECTIONS) do
            local npos = pos.copy().move(dir)
            local tileNum = map.getTileP(npos)
            if (tileNum) then
                local thisPriority = TILES[tileNum].getReceivePriority(map, npos, dir)
                if (thisPriority > winningPriority) then
                    winningPriority = thisPriority
                    winningDirection = dir
                end
            end
        end
        if (winningDirection) then
            return winningDirection.copy()
        else
            return nil
        end
    end

    function pulseNeighbors(map, pos)
        for dir in all(DIRECTIONS) do
            map.setFlagP(pos.copy().move(dir), MF_PULSED)
        end
    end    
end


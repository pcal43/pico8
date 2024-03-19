
TILES = nil
ABBREVS = nil

-- TODO consider encapsulating these (e.g., Tile.isLocked())

FLAG_BRAKE_ENGAGED = 14
BELT_ENGAGED = 13
MF_PULSED = 12
MF_PULSE_PROCESSED = 11
MF_PULSE_DECAYING = 10
MF_CLICKED = 9
MF_OUTDIR_START = 4
MF_OUTDIR_LEN = 4


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
    map.setFlagsP(pos, tileFlags)    
  end

  function self.getOutboundDir(tileFlags)
     local dirNum = getBitInt(tileFlags, MF_OUTDIR_START, MF_OUTDIR_LEN)
     if (dirNum == 0) return nil -- ruh roh
     return DIRECTIONS[dirNum]
  end

  function self.onTickStart(map, pos, tileFlags, items)
  end

  function self.onClick(map, pos)
  end

  function self.onReceiveItem(item, map)
  end

  function self.onPulse(map, pos)
  end

  function self.getReceivePriority(map, pos, dir)
    return 0
  end

  function self.draw(map, pos, cx, cy, tileFlags, ticksElapsed, frameAlpha)
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
    function self.onReceiveItem(item, map)
        item.dir = ZERO -- FIXME this maybe should be done automatically every tick
    end    
    function self.getReceivePriority(map, pos, dir)
        return 100
    end  
    function self.draw(map, pos, cx, cy, tileFlags, ticksElapsed, frameAlpha)
        drawSprite(4, cx, cy)
    end
    return self
end

local BeltTile = {}
BeltTile.new = function(fields)
    local self = Tile.new(fields)
    self.isBelt = true
    self.dir = fields.dir

    function self.getReceivePriority(map, pos, dir)
        if (dir == self.dir)return 999
        if (dir.dx() == -self.dir.dx() or dir.dy == -self.dir.dy()) then
            return 0
        end
        return 500  -- meh
    end  
    function self.onReceiveItem(item, map)
        item.dir = self.dir
        return false
    end
    function self.draw(map, pos, cx, cy, tileFlags)
        drawSprite(FLOOR_SPRITE, cx, cy)
        drawSprite(fields.sprite, cx, cy, fields.flipx or false, fields.flipy or false)
    end
    return self
end

local MomentaryButtonTile = {}
MomentaryButtonTile.new = function(fields)
    local self = Tile.new(fields)

    function self.onClick(map, pos)
        map.setFlagP(pos, MF_CLICKED)
        map.clearFlagP(pos, MF_PULSE_DECAYING)
        pulseNeighbors(map, pos)
    end

    function self.draw(map, pos, cx, cy, tileFlags)
        drawSprite(FLOOR_SPRITE, cx, cy)
        local sprite = 10   
        if (isBit(tileFlags, MF_CLICKED) or isBit(tileFlags, MF_PULSE_DECAYING)) sprite = 12
            drawSprite(sprite, cx, cy)
        if (fields.dir) then
            drawSprite(202 - fields.dir.number % 2, cx + 4, cy + 4, fields.dir == LEFT, fields.dir == UP)
        end
    end
    return self
end


local ToggleButtonTile = {}
ToggleButtonTile.new = function(fields)
    local FLAG_CLICKED = 0
    local FLAG_TOGGLE_STATE = 1
    local self = Tile.new(fields)

    function self.onLevelInit(map, pos, tileFlags)
    end 

    function self.onTickStart(map, pos, tileFlags, items)
        local toggleState = map.getFlagP(pos, FLAG_TOGGLE_STATE)
        if (map.getFlagP(pos, FLAG_CLICKED)) then
            toggleState = not toggleState
            map.clearFlagP(pos, FLAG_CLICKED)
            map.setFlagP(pos, FLAG_TOGGLE_STATE, toggleState)
        end
        if (toggleState) pulseNeighbors(map, pos)
    end

    function self.onClick(map, pos)
        map.setFlagP(pos, FLAG_CLICKED)
    end

    function self.draw(map, pos, cx, cy, tileFlags)
        drawSprite(FLOOR_SPRITE, cx, cy)
        local toggleState = isBit(tileFlags, FLAG_TOGGLE_STATE)
        if (isBit(tileFlags, FLAG_CLICKED)) toggleState = not toggleState
        local sprite = 10
        if (toggleState) sprite = 12
        drawSprite(sprite, cx, cy)
    end
    return self
end


local WireTile = {}
WireTile.new = function(fields)
    local self = Tile.new(fields)
    function self.onPulse(map, pos)
        pulseNeighbors(map, pos)
        map.setFlagP(pos, MF_PULSED)
        map.clearFlagP(pos, MF_PULSE_DECAYING)
    end
    function self.draw(map, pos, cx, cy, tileFlags)
        drawSprite(FLOOR_SPRITE, cx, cy)
        local spriteOffset = 0
        if (map.getFlagP(pos, MF_PULSED) or map.getFlagP(pos. MF_PULSE_DECAYING)) spriteOffset = 16
        drawSprite(217 + spriteOffset, cx + 4, cy + 4, fields.flipx or false, fields.flipy or false)
    end
    return self
end

local BrakeTile = {}
BrakeTile.new = function(fields)
    local self = Tile.new(fields)

    self.isBelt = true
    self.dir = fields.dir

    function self.onLevelInit(map, pos, tileFlags)
        if (fields.isEngaged) then
            map.setFlagP(pos, FLAG_BRAKE_ENGAGED)
        else
            map.clearFlagP(pos, FLAG_BRAKE_ENGAGED)
        end
    end
    function self.onTickStart(map, pos, tileFlags, items)
        map.setFlagP(pos, FLAG_BRAKE_ENGAGED)
    end

    function self.getReceivePriority(map, pos, dir)
        return 500  -- meh
    end  

    function self.onPulse(map, pos)
        map.clearFlagP(pos, FLAG_BRAKE_ENGAGED)
        map.setFlagP(pos, MF_PULSED)
        map.clearFlagP(pos, MF_PULSE_DECAYING)
    end

    function self.onReceiveItem(item, map)
        local tileFlags = map.getFlagsP(item.pos)
        if (isBit(tileFlags, FLAG_BRAKE_ENGAGED)) then
            item.dir = ZERO
        else
            item.dir = self.dir
        end
    end

    function self.draw(map, pos, cx, cy, tileFlags)
        drawSprite(FLOOR_SPRITE, cx, cy)
        local brakeColor = 11
        if (isBit(tileFlags, FLAG_BRAKE_ENGAGED)) then
            brakeColor = 8
            rect(cx + 2, cy + 2, cx + 13, cy + 13, brakeColor)
            drawSprite(fields.sprite+38, cx, cy, fields.flipx or false, fields.flipy or false)            
        else 
            drawSprite(fields.sprite, cx, cy, fields.flipx or false, fields.flipy or false)
        end

    end
    return self
end


local SensorTile = {}
SensorTile.new = function(fields)
    local self = Tile.new(fields)
    function self.getReceivePriority(map, pos, dir)
        return 350
    end  
    function self.onReceiveItem(item, map)
        local tileFlags = map.getFlagsP(item.pos)
        local dir = self.getOutboundDir(tileFlags)
        if (dir == nil) then
            item.dir = ZERO
        else
            item.dir = dir
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
    local FLAG_VALID_DIR_START = 3

    function self.onLevelInit(map, pos, tileFlags)
        for i=0,3 do
            local dir = DIRECTIONS[i+1]
            local npos = pos.copy().move(dir)
            if (map.getTile(pos).isBelt and map.getTile(pos).getReceivePriority(map, npos, dir) > 0) then
                tileFlags = setBit(tileFlags, FLAG_VALID_DIR_START + i)
            end
        end
        tileFlags = setBitInt(tileFlags, FLAG_DIR_START, FLAG_DIR_LEN, fields.startingDir.number - 1)
        map.setFlagsP(pos, tileFlags)
    end
    function self.getReceivePriority(map, pos, fromDir)
        return 250  -- meh
    end  
    function self.onReceiveItem(item, map)        
        local tileFlags = map.getFlagsP(item.pos)
        local pointDir = DIRECTIONS[getBitInt(tileFlags, FLAG_DIR_START, FLAG_DIR_LEN) + 1]  
        -- printh("I STARTED "..tostr(fields.startingDir.number))
        -- printh("GOING MY WAY?  "..tostr(pointDir.number))      
        item.dir = pointDir
    end
    function self.onPulse(map, pos)
        map.setFlagP(pos, MF_PULSED)
        map.clearFlagP(pos, MF_PULSE_DECAYING)
        local tileFlags = map.getFlagsP(pos)
        local currentDirNum = getBitInt(tileFlags, FLAG_DIR_START, FLAG_DIR_LEN)
        for i=1,3 do
            local checkDir = (currentDirNum + i) % 4
            local bitNumber = FLAG_VALID_DIR_START + checkDir
            if (isBit(tileFlags, bitNumber)) then
                tileFlags = setBitInt(tileFlags, FLAG_DIR_START, FLAG_DIR_LEN, checkDir)
                break
            end
        end
        map.setFlagsP(pos, tileFlags)
    end
    function self.draw(map, pos, cx, cy, tileFlags, ticksElapsed, frameAlpha)
        drawSprite(98, cx, cy)
        local dirNum = getBitInt(tileFlags, FLAG_DIR_START, FLAG_DIR_LEN)
        drawSprite(201 + dirNum % 2, cx + 4, cy + 4, dirNum == 2, dirNum == 3)
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


function initTiles() 
    TILES = {}
    ABBREVS = {}
    
    function register(abbrev, tile)
        add(TILES, tile)
        ABBREVS[abbrev] = #TILES
    end

    register(".",  Tile.new{sprite=0}) -- void
    register(",",  FloorTile.new{})
    register("#",  Tile.new{sprite=100})
    register("!",  StarterTile.new{} )
    register("?",  SensorTile.new{sprite=98, badge=200})
    register("=",  ToggleButtonTile.new{})
    register("*",  WireTile.new{})    

    register("-",  MomentaryButtonTile.new{})
    register(">-", MomentaryButtonTile.new{dir=RIGHT})
    register("v-", MomentaryButtonTile.new{dir=DOWN})
    register("<-", MomentaryButtonTile.new{dir=LEFT})
    register("^-", MomentaryButtonTile.new{dir=UP})

    register(">",  BeltTile.new{dir=RIGHT, sprite=64})
    register("<",  BeltTile.new{dir=LEFT, sprite=64, flipx=true})
    register("v",  BeltTile.new{dir=DOWN, sprite=66, flipy=true})
    register("^",  BeltTile.new{dir=UP, sprite=66})

    register(">@", DiverterTile.new{sprite=98, badge=202, startingDir=RIGHT })
    register("<@", DiverterTile.new{sprite=98, badge=202, startingDir=LEFT })
    register("v@", DiverterTile.new{sprite=98, badge=202, startingDir=DOWN })
    register("^@", DiverterTile.new{sprite=98, badge=202, startingDir=UP })

    register(">?", BrakeTile.new{dir=RIGHT, isEngaged=false, sprite=64})
    register("<?", BrakeTile.new{dir=LEFT,  isEngaged=false, sprite=64, flipx=true})
    register("v?", BrakeTile.new{dir=DOWN,  isEngaged=false, sprite=66, flipy=true})
    register("^?", BrakeTile.new{dir=UP,    isEngaged=false, sprite=66})

    register(">!", BrakeTile.new{dir=RIGHT, isEngaged=true, sprite=64})
    register("<!", BrakeTile.new{dir=LEFT,  isEngaged=true, sprite=64, flipx=true})
    register("v!", BrakeTile.new{dir=DOWN,  isEngaged=true, sprite=66, flipy=true})
    register("^!", BrakeTile.new{dir=UP,    isEngaged=true, sprite=66})
end


-- TODO should probably also check for inbound belts.  if there's only one, then give (somewhat?) highter priority to
--    opposite direction.  ???
function findOutboundDir(map, pos, dirs)
    local winningPriority = 0
    local winningDirection = nil
    for dir in all(dirs or DIRECTIONS) do
        local npos = pos.copy().move(dir)
        if (map.isInBoundsP(npos)) then
            local thisPriority = map.getTile(npos).getReceivePriority(map, npos, dir)
            if (thisPriority > winningPriority) then
                winningPriority = thisPriority
                winningDirection = dir
            end
        end
    end
    if (winningDirection) then
        return winningDirection
    else
        return nil
    end
end

function pulseNeighbors(map, pos)
    for dir in all(DIRECTIONS) do
        local npos =pos.copy().move(dir) 
        map.getTile(npos).onPulse(map, npos)
    end
end


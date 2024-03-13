
LevelRunScreen = {}
LevelRunScreen.new = function(level)
    local self = {}

    local SPRITE_SIZE = 2
    local TILE_WIDTH = 16
    local TILE_HEIGHT = 16
    local FRAMES_PER_TICK = 16   
    
    local framesElapsed = 0
    local frameAlpha = 0
    local ticksElapsed = 0

    local sprites = {}

    local map, items = level.createMap()


    local cursorPos = Position.new()


    local function getItemAt(items, pos)
        for item in all(items) do
            if (pos.equals(item.pos)) return item
        end
        return nil
    end

    local function getItemsAtExcept(items, pos, excludedItem)
        local out = nil
        for item in all(items) do
            if (item != excludedItem) then
                if (item.desiredPos != nil) then
                    if (out == nil) out = {}
                    if (pos.equals(item.desiredPos)) add(out,item)
                elseif (pos.equals(item.pos)) then
                    if (out == nil) out = {}                    
                    add(out, item)
                end
            end
        end
        if (out != nil) add(out, excludedItem)
        return out
    end

    local function getMatches(items, predicateFn)
        local out = nil
        for item in all(items) do
            if (predicateFn(item)) then
                if (out == nil) out = {}
                add(out, item)
            end
        end
        return out
    end

    local function getMatch(items, predicateFn)
        for item in all(items) do
            if (predicateFn(item)) return item
        end
        return nil
    end


    local function getOtherItemsAt(items, checkItem)
        local out = {}
        local pos = checkItem.desiredPos or checkItem.pos
        for item in all(items) do
            if (item != checkItem) then
                if (item.desiredPos != nil) then
                    if (pos.equals(item.desiredPos)) add(out,item)
                elseif (pos.equals(item.pos)) then
                    add(out, item)
                end
            end
        end
        return out
    end

    local function propagatePulses()
        local continuePulses = true
        while(continuePulses) do
            continuePulses = false
            map.traverse(function(pos, tile, tileFlags)
                if (isBit(tileFlags, MF_PULSED) and not isBit(tileFlags, MF_PULSE_PROCESSED)) then
                    tile.onPulse(map, pos)
                    map.setFlagP(pos, MF_PULSE_PROCESSED)
                    continuePulses = true -- will need to make another pass in cases any of the pulses propagated
                end
            end)
        end
        map.traverse(function(pos, tile, tileFlags)
            map.clearFlagP(pos, MF_PULSE_PROCESSED)
        end)
    end

    local function sortByPriority(items) 
        for i=1, #items do
            local j = i
            while j > 1 and items[j-1].movePriority < items[j].movePriority do
                items[j], items[j-1] = items[j-1], items[j]
                j = j - 1
            end
        end
    end

    local function updateMovePriority(item) 
        item.movePriority = -1
        if (item.dir != ZERO) then
            local desiredPos = item.pos.copy().move(item.dir)
            -- set a base priority 0 - 1000 so that it's at least always deterministic
            item.movePriority = item.pos.x + (item.pos.y * 8) + (item.dir.number * 100)
            local fromTile = map.getTile(item.pos)
            if (fromTile.isBelt) item.movePriority += 5000
            if (item.desiredPos == nil) then
                item.movePriority = 0
            else
                local toTile = map.getTile(item.desiredPos)
                if (toTile == nil or toTile.getReceivePriority(map, item.pos, item.dir) == 0) then
                    item.movePriority = -1
                    item.blockedExits[item.dir.number] = true
                    item.dir = ZERO
                    item.desiredPos = item.pos.copy()
                else
                    item.desiredPos = desiredPos
                    if (toTile.isBelt) then
                        if (toTile.dir == fromTile.dir) then
                            item.movePriority += 1000
                        else
                            item.movePriority += 500
                        end
                    else
                        item.movePriority += 250
                    end
                end
            end
        end
    end

    function self.update()
        if (btnp(5)) CONTROLLER.failLevel()

        shift16x16spriteRight(64)
        shift16x16spriteDown(66)


        cursorPos = Position.new(flr(stat(32)/16), flr(stat(33)/16))
        if (isBit(stat(34), 0)) then
            if (map.isInBoundsP(cursorPos)) then
                map.getTile(cursorPos).onClick(map, cursorPos)
                propagatePulses()
            end
        end

        -- framesElapsed += 1
        -- if (0 == framesElapsed % (FRAMES_PER_TICK / TILE_WIDTH )) frameAlpha += 1
        frameAlpha = frameAlpha + 1

        if (frameAlpha < FRAMES_PER_TICK) return

        map.traverse(function(pos, tile, tileFlags)
            tile.onTickStart(map, pos, tileFlags, items)
        end)

        for item in all(items) do
            if (not item.dir.isZero()) item.pos.move(item.dir)
        end

        propagatePulses()

        -- process all items using the tile that they have arrived on
        for item in all(items) do
            map.getTile(item.pos).onReceiveItem(item, map)
        end

        -- determine move priority
        for item in all(items) do
            for i=1, #DIRECTIONS do 
                item.blockedExits[i] = false
                if (item.dir != ZERO) item.desiredPos = item.pos.copy().move(item.dir)
            end
            updateMovePriority(item)
        end
        sortByPriority(items)

        ::resolveCollisions::
        for item in all(items) do
            -- printh("processing "..tostr(item.movePriority))
            if (item.desiredPos != nil) then -- dont bother checking if it has given up trying to move
                local pos = item.desiredPos
                local tile = map.getTile(pos)
                if (tile.getReceivePriority(map, pos, item.dir) == 0) then
                    -- printh("HIT WALL")
                    item.desiredPos = nil
                    item.dir = ZERO
                    item.blockedExits[item.dir.number] = true
                    goto resolveCollisions
                end
            
                local collidingItems = getMatches(items, function(matchMe)
                    if (matchMe != item) then
                        if (matchMe.desiredPos != nil) then
                            return matchMe.desiredPos.equals(pos)
                        else
                             return matchMe.pos.equals(pos)
                        end
                    end
                end)

                if (collidingItems != nil) then
                    add(collidingItems, item)
                    --printh("COLLIDERS "..tostr(#collidingItems))                    
                    sortByPriority(collidingItems)
                    local priorityItem = collidingItems[1]
                    for i=2,#collidingItems do
                        local otherItem = collidingItems[i]
                        if (otherItem.desiredPos == nil) then
                            if (otherItem.blockedExits[priorityItem.dir.number]) then
                                -- The priorityItem is blocked by an item that can't be pushed out of its way.
                                -- It stops moving and is marked as blocked in that direction.
                                priorityItem.desiredPos = nil 
                                priorityItem.blockedExits[priorityItem.dir.number] = true
                                priorityItem.dir = ZERO
                            else
                                -- The priority item is block by an item that maybe can be pushed out of its way.
                                -- Try pushing it.
                                otherItem.dir = priorityItem.dir
                                otherItem.desiredPos = priorityItem.pos.copy().move(priorityItem.dir)
                            end
                        else
                            -- The other item is competing to move into the spot but has a lower priority than the priorityItem.
                            -- It's not going anywhere.  FIXME I think there's a problem here: what if priorityItem ultimately is blocked
                            -- but this next item here is actually able to push it's way in?
                            otherItem.desiredPos = nil
                            otherItem.blockedExits[otherItem.dir.number] = true                            
                            otherItem.dir = ZERO
                        end
                    end
                    goto resolveCollisions
                end
            end
        end

        --
        -- check to see if they won
        --
        for item in all(items) do
            if (item.char == level.targetChars[1]) then
                local pos = item.pos.copy().move(RIGHT)
                for i=2, #level.targetWord do
                    local item = getItemAt(items, pos)
                    if (item == nil or item.char != level.targetChars[i]) goto nope
                    pos.move(RIGHT)
                end
                CONTROLLER.wonLevel()
            end
        end
        ::nope::

        map.traverse(function(pos, tile, tileFlags)
            map.clearFlagP(pos, MF_PULSED)
            map.clearFlagP(pos, MF_CLICKED)            
        end)

        frameAlpha = 0
        ticksElapsed += 1

    end

    local CURSOR_COLORS = { 0, 7, 10 }



    function self.draw()
        cls(0)
        local cx = 0
        local cy = 0
        map.traverse(function(pos, tile, tileFlags)
            tile.draw(map, pos, pos.x * TILE_WIDTH, pos.y * TILE_HEIGHT, tileFlags, ticksElapsed, frameAlpha)
        end)
        for item in all(items) do
            item.draw((item.pos.x * TILE_WIDTH) + item.dir.dx() * frameAlpha, (item.pos.y * TILE_WIDTH) + item.dir.dy() * frameAlpha)
        end
        for s in all(sprites) do
            spr(s.sprite, s.x, s.y, SPRITE_SIZE, SPRITE_SIZE)
        end
        local cursorColor
        if (frameAlpha % 2 == 0) then 
            cursorColor = 7
        else
             cursorColor = 10
        end
        rect(cursorPos.x * TILE_WIDTH, cursorPos.y * TILE_HEIGHT, cursorPos.x * TILE_WIDTH + TILE_WIDTH -1,  cursorPos.y * TILE_HEIGHT + TILE_HEIGHT - 1, 
          CURSOR_COLORS[(frameAlpha % #CURSOR_COLORS) + 1]
        )
    end

    return self
end

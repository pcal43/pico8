
LevelRunScreen = {}
LevelRunScreen.new = function(level)
    local self = {}

    local SPRITE_SIZE = 2
    local TILE_WIDTH = 16
    local TILE_HEIGHT = 16
    local FRAMES_PER_TICK = 16   
    
    local framesElapsed = 0
    local frameAlpha = 0
    local collided = false
    local ticksElapsed = 0

    local items = {}
    local sprites = {}

    local map = level.createMap()


    local cursorPos = Position.new()


    local function getItemsAt(items, pos)
        local out = {}
        for item in all(items) do
            if (item.desiredPos != nil) then
                if (pos.equals(item.desiredPos)) add(out,item)
            elseif (pos.equals(item.pos)) then
                add(out, item)
            end
        end
        return out
    end


    function self.update()
        if (btnp(5)) CONTROLLER.failLevel()

        poke(0x5f2d, 1) -- enable devkit mode

        cursorPos = Position.new(flr(stat(32)/16), flr(stat(33)/16))

        --printh(tostr(x) .. tostr(y))
        if (isBit(stat(34), 0)) then
            local tileNum = map.getTileP(cursorPos)
            --printh(tostr(pos.x) .. " " .. tostr(pos.y) .. " ".. tostr(tileNum))
            if (tileNum != nil) TILES[tileNum].onClick(map, cursorPos)
        end

        -- framesElapsed += 1
        -- if (0 == framesElapsed % (FRAMES_PER_TICK / TILE_WIDTH )) frameAlpha += 1
        frameAlpha = frameAlpha + 1

        if (frameAlpha < FRAMES_PER_TICK) return

        map.traverseP(function(pos, tileNum, tileFlags)
            TILES[tileNum].onTickStart(map, pos, tileFlags, items)
        end)

        for item in all(items) do
            item.pos.move(item.dir)
        end

        map.traverseP(function(pos, tileNum, tileFlags)
            if (map.getFlagP(pos, MF_PULSED)) then -- FIXME need a util for this case
                TILES[tileNum].onPulse(map, pos, tileFlags, items)
            end
        end)        
        for item in all(items) do
            local tileNum = map.getTileP(item.pos)
            if (tileNum) TILES[tileNum].onReceiveItem(item, map)
        end


        for item in all(items) do        
            item.desiredPos = item.pos.copy().move(item.dir)
        end       

        ::resolveCollisions::
        for item in all(items) do
            if (item.desiredPos != nil) then -- dont bother checking if it has given up moving
                local collidingItems = getItemsAt(items, item.desiredPos)
                if (count(collidingItems) > 1) then
                    printh("bump!")
                    for colliding in all(collidingItems) do
                        if (item != colliding) then
                            colliding.desiredPos = nil
                            colliding.dir.dx = 0
                            colliding.dir.dy = 0
                        end
                    end
                    goto resolveCollisions -- need to resolve from scratch
                end
            end
        end

        map.traverseP(function(pos, tileNum, tileFlags)
            map.setFlagP(pos, MF_PULSED, false)
        end)

        frameAlpha = 0
        ticksElapsed += 1

    end

    local CURSOR_COLORS = { 0, 7, 10 }



    function self.draw()
        cls(0)
        local cx = 0
        local cy = 0
        map.traverseP(function(pos, tileNum, tileFlags)
            TILES[tileNum].draw(pos.x * TILE_WIDTH, pos.y * TILE_HEIGHT, tileFlags, ticksElapsed, frameAlpha)
        end)
        for item in all(items) do
            item.type.draw((item.pos.x * TILE_WIDTH) + item.dir.dx * frameAlpha, (item.pos.y * TILE_WIDTH) + item.dir.dy * frameAlpha)
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

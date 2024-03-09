
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

    function self.update()
        if (collided) CONTROLLER.failLevel()
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


        for i=#items,1,-1 do
            local item = items[i]
            item.pos.move(item.dir)
            local tileNum = map.getTileP(item.pos)
            if (tileNum) TILES[tileNum].onReceiveItem(item, map)
        end
        for i=#items,1,-1 do
            if (items[i].isRemoved) deli(items,i)
        end

        --[[
        map.traverseP(function(pos, tileNum, tileFlags)
            tileFlags = clearBit(tileFlags, MF_OCCUPIED)
            tileFlags = clearBit(tileFlags, MF_DESIRED)      
            map.setFlagsP(pos, tileFlags)
        end)

        local anyMoving = true
        while(anyMoving)
            anyMoving = false
            for item in all(items) do
                if (item.dir.dx == 0 and item.dir.dy == 0) then
                    map.setFlagsP(item.pos, MF_OCCUPIED)
                else
                    if (not map.getFlagP(item.pos, MF_OCCUPIED)) then
                        local npos = item.pos.copy().move(item.dir)
                        if (map.getFlagsP(npos, MF_DESIRED)) then
                            map.setFlagsP(item.pos, MF_OCCUPIED)
                        else
                            map.setFlagsP(item.pos, MF_DESIRED)
                            anyMoving = true
                        end
                    end
                end
            end
        end
]]--

        map.traverseP(function(pos, tileNum, tileFlags)
            TILES[tileNum].onTickStart(map, pos, tileFlags, items)
        end)

        map.traverseP(function(pos, tileNum, tileFlags)
            if (map.getFlagP(pos, MF_PULSED)) then -- FIXME need a util for this case
                TILES[tileNum].onPulse(map, pos, tileFlags, items)
            end
        end)

        map.traverseP(function(pos, tileNum, tileFlags)
            if (isBit(tileFlags, MF_COLLISION)) then
                collided = true
                --printh("OH NO ".. tostr(pos.x).. " " .. tostr(pos.y))
                add(sprites, { x = (pos.x * TILE_WIDTH), y = (pos.y * TILE_WIDTH), sprite = 2 })
            end
        end)

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

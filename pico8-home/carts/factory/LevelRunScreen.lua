
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

    function self.update()
        if (collided) CONTROLLER.failLevel()
        if (btnp(5)) CONTROLLER.failLevel()

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

        map.traverseP(function(pos, tileNum, tileFlags)
            TILES[tileNum].onTickStart(pos.x, pos.y, map, tileFlags, items)
        end)

        map.traverseP(function(pos, tileNum, tileFlags)
            if (map.getFlagP(pos, MF_PULSED)) then -- FIXME need a util for this case
                TILES[tileNum].onPulse(pos.x, pos.y, map, tileFlags, items)
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

    function self.draw()
        cls(0)
        local cx = 0
        local cy = 0
        local width, height = map.getSize()
        map.traverseP(function(pos, tileNum, tileFlags)
            TILES[tileNum].draw(pos.x * TILE_WIDTH, pos.y * TILE_HEIGHT, tileFlags, ticksElapsed, frameAlpha)
        end)

        for item in all(items) do
            item.type.draw((item.pos.x * TILE_WIDTH) + item.dir.dx * frameAlpha, (item.pos.y * TILE_WIDTH) + item.dir.dy * frameAlpha)
        end
        for s in all(sprites) do
            spr(s.sprite, s.x, s.y, SPRITE_SIZE, SPRITE_SIZE)
        end
    end

    return self
end

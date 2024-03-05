
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
    won = false
    local ticksElapsed = 0

    local actors = {}
    local sprites = {}

    local map = level.createMap()

    function self.update()
        if (collided or won) return

        -- framesElapsed += 1
        -- if (0 == framesElapsed % (FRAMES_PER_TICK / TILE_WIDTH )) frameAlpha += 1
        frameAlpha = frameAlpha + 1

        if (frameAlpha < FRAMES_PER_TICK) return

        map.traverse(function(mx, my, tileNum, tileFlags)
            TILES[tileNum].onTickStart(mx, my, map, tileFlags, actors)
        end)

        map.traverse(function(mx , my, tileNum, tileFlags)
            if (map.getFlag(mx, my, MF_PULSED)) then -- FIXME need a util for this case
                TILES[tileNum].onPulse(mx, my, map, tileFlags, actors)
            end
        end)

        for i=#actors,1,-1 do
            local a = actors[i]
            a.mx += a.dx
            a.my += a.dy
            local tileNum = map.getTile(a.mx, a.my)
            --printh("MOVE " .. tostr(a.dx) .. " " .. tostr(a.dy) .. " " .. tostr(tilenum))
            if (tileNum) TILES[tileNum].onReceiveItem(a, map)
        end
        for i=#actors,1,-1 do
            if (actors[i].isRemoved) then
                deli(actors,i)
            end
        end

        map.traverse(function(mx , my, tileNum, tileFlags)
            if (isBit(tileFlags, MF_COLLISION)) then
                collided = true
                --printh("OH NO ".. tostr(mx).. " " .. tostr(my))
                add(sprites, { x = (mx * TILE_WIDTH), y = (my * TILE_WIDTH), sprite = 2 })
            end
        end)

        map.traverse(function(mx , my, tileNum, tileFlags)
            map.setFlag(mx, my, MF_PULSED, false)
        end)

        frameAlpha = 0
        ticksElapsed += 1

    end

    function self.draw()
        if (won)  then
            cls(11)
            return
        end
        cls(0)
        local cx = 0
        local cy = 0
        local width, height = map.getSize()
        map.traverse(function(x, y, tileNum, tileFlags)
            TILES[tileNum].draw(x * TILE_WIDTH, y * TILE_HEIGHT, tileFlags, ticksElapsed, frameAlpha)
        end)

        for a in all(actors) do
            a.type.draw((a.mx * TILE_WIDTH) + a.dx * frameAlpha, (a.my * TILE_WIDTH) + a.dy * frameAlpha)
        end
        for s in all(sprites) do
            spr(s.sprite, s.x, s.y, SPRITE_SIZE, SPRITE_SIZE)
        end
    end

    return self
end

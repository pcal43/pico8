LEVELS = nil

local Level = {}
Level.new = function(name, encodedMap)
    local self = {}
    self.name = name
    function self.createMap()
        local map = Map.new(0x4300,8,8,1,2)
        local rows = split(encodedMap, "\n")
        local mx = 0
        local my = 0
        for row in all(rows) do
        printh(row)
        for i = 1, #row do
            c = sub(row, i, i)
            if (ABBREVS[c]) then 
                map.setTile(mx, my, ABBREVS[c])
                mx += 1
            end
        end
        mx = 0
        my = my + 1
        end

        map.traverse(function(mx, my, tileNum, tileFlags)
            TILES[tileNum].onLevelInit(mx, my, map, tileFlags)
        end)

        return map    
    end
    return self
end

function initLevels() 
    LEVELS = {}
    LEVELS[1] = Level.new("Intro",[[
######...
#,,,,####
!S>>M>OV#
B>>>^VCV#
#^,,OV,V#
$<<<<<<<#
#,,,,,,,#
#########
]])

    LEVELS[2] = Level.new("Next",[[
#>>V##!!#
#^,V,,SB#
!FVV,,VV#
!BVV,,M<#
#,>M,,V,#
#>>>M<<,#
#,,,V,,,#
####$####
]])
end


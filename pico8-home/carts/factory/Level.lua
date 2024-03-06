LEVELS = nil

Level = {}
Level.new = function(name, encodedMap)
    local self = {}
    self.name = name
    function self.createMap()
        local map = Map.new(0x4300,8,8,1,2)
        local rows = split(encodedMap, "\n")
        local pos = Position.new()
        for row in all(rows) do
        for i = 1, #row do
            c = sub(row, i, i)
            if (ABBREVS[c]) then 
                map.setTileP(pos, ABBREVS[c])
                pos.x += 1
            end
        end
        pos.x = 0
        pos.y += 1
        end

        map.traverseP(function(pos, tileNum, tileFlags)
            TILES[tileNum].onLevelInit(map, pos, tileFlags)
        end)

        return map    
    end
    return self
end

function initLevels() 
    LEVELS = {}


    add(LEVELS, Level.new("WUT",[[
        ########
        !F,VB,,#
        #>?M?>M$
        #,B^S,,#
        ########
    ]]))


    add(LEVELS, Level.new("Race",[[
        !F>?>>>>
        >>>F>>>>
    ]]))
        

    add(LEVELS, Level.new("Sensodyne",[[
#>>V##!#
#^,?,,S,
!FVV,,?B
!BVV,,MV
#,>M,,VV
#>>>M<<,
#,,,V,,,
####$###
]]))


    add(LEVELS, Level.new("Intro",[[
######...
#,,,,####
!S>>M>OV#
B>>>^VMV#
#^,,OV,V#
$<<<<<<<#
#,,,,,,,#
#########
]]))

    add(LEVELS, Level.new("Next",[[
#>>V##!!#
#^,V,,SB#
!FVV,,VV#
!BVV,,M<#
#,>M,,V,#
#>>>M<<,#
#,,,V,,,#
####$####
]]))


end

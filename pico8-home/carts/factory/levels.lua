
function loadLevel()


    local map = Map.new(0x4300,8,8,1,2)

    local level = [[
CS>>>V
R>>>>V
.^..QV
.M<<<<
]]

    local rows = split(level, "\n")
    local mx = 0
    local my = 0
    for row in all(rows) do
      printh(row)
      for i = 1, #row do
        c = sub(row, i, i)
        printh(tostr(c) .. tostr(i))
        if (ABBREVS[c]) then
          map.setTile(mx, my, ABBREVS[c])
        end
        mx = mx + 1
      end
      mx = 0
      my = my + 1
    end

    return map

end
pico-8 cartridge // http://www.pico-8.com
version 41
__lua__

#include anagrams/bits.lua
#include anagrams/Direction.lua
#include anagrams/Position.lua
#include anagrams/Rectangle.lua
#include anagrams/Map.lua
#include anagrams/effects.lua
#include anagrams/Item.lua
#include anagrams/Tile.lua
#include anagrams/Level.lua
#include anagrams/HudScreen.lua
#include anagrams/LevelRunScreen.lua
#include anagrams/TitleScreen.lua
#include anagrams/EndScreen.lua
#include anagrams/Controller.lua


#include anagrams/bitsTest.lua
#include anagrams/PositionTest.lua


BUTTON_LEFT  = 0
BUTTON_RIGHT = 1
BUTTON_UP    = 2
BUTTON_DOWN  = 3
BUTTON_MAIN  = 4
BUTTON_AUX   = 5


CONTROLLER = Controller.new()

function _init()
    CONTROLLER.init()
end

function _update()
    CONTROLLER.update()
end

function _draw()
    CONTROLLER.draw()
end


 
__gfx__
00000000000000000000000000000000ffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000aa9000000ffffffffffffffff00000000000000000000000000000000000009999990000000000999999000000000000000000000
00000000000000000000000aa9000000ffffffffffffffff00000000000000000000000000000000000091111119000000009aaaaaa900000000000000000000
0000000000001000000000aaaa900000fffffffffffffeff0000000000000000000000000000000000091111111190000009aaaaaaaa90000000000000000000
0010000000000000000000aaaa900000ffffefffffffffff000000000000000000000000000000000091111111111900009aaaaaaaaaa9000000000000000000
000000000000000000000aaaaaa90000ffffffffffffffff00000000000000000000000000000000091111111111119009aaaaaaaaaaaa900000000000000000
000000000000000000000aa15aa90000ffffffffffffffff00000000000000000000000000000000091111111111119009aaaaaaaaaaaa900000000000000000
00000001000000000000aaa15aaa9000ffffffffefffffff00000000000000000000000000000000091111111111119009aaaaaaaaaaaa900000000000000000
00000000000000000000aaa15aaa9000ffffffffffffffff00000000000000000000000000000000091111111111119009aaaaaaaaaaaa900000000000000000
0000000000000000000aaaa15aaaa900ffffffffffffffff00000000000000000000000000000000091111111111119009aaaaaaaaaaaa900000000000000000
0000000000000000000aaaa15aaaa900ffffffffffffffff00000000000000000000000000000000091111111111119009aaaaaaaaaaaa900000000000000000
001000000000000000aaaaaaaaaaaa90ffffffffffffffff000000000000000000000000000000000091111111111900009aaaaaaaaaa9000000000000000000
000000000000000000aaaaa15aaaaa90ffefffffffefffff0000000000000000000000000000000000091111111190000009aaaaaaaa90000000000000000000
00000000000000000aaaaaa15aaaaaa9ffffffffffffffff00000000000000000000000000000000000091111119000000009aaaaaa900000000000000000000
00000000000001000aaaaaaaaaaaaaa9ffffffffffffffff00000000000000000000000000000000000009999990000000000999999000000000000000000000
00000000000000000000000000000000ffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000aaaaaaaaaaaaaaaa9999999999999999333333333333333322222222222222220000000000000000
000000000000000000000000000000000000000000000000a00000000000000a9000000000000009300000000000000320000000000000020000000000000000
005222222222250000055555555550000053333333333500a00000000000000a9000000000000009300000000000000320000a0a0a0000020000000000000000
00288888888882000056666666666500003bbbbbbbbbb300a00000000000000a9000000000000009300000565000000320000e0e0e0000020000000000000000
00288888888882000056666666766500003bbbbbbbbbb300a00007777000000a9000000000000009300006737600000320000e0e0e0000020000000000000000
00288888888882000056666666676500003bbbbbbbbbb300a00007000700000a9000000000000009300007333700000320003333333000020000000000000000
00288888888882000056666666666500003bbbbbbbbbb300a00007777000000a90099999999990093000073b3700000320033333333300020000000000000000
00288888888882000056666666666500003bbbbbbbbbb300a00007000700000a9009aaaaaaaaa0093000073b3700000320033b3b3b3300020000000000000000
00288888888882000056666666666500003bbbbbbbbbb300a00007777000000a9009a999999990093000073b370000032003b3b3b3b300020000000000000000
00288888888882000056666666666500003bbbbbbbbbb300a00000000000000a9009a9aaaaaa90093000073b3700000320033b3b3b3300020000000000000000
00288888888882000056666666666500003bbbbbbbbbb300a0066666666aa00a9009a999999a90093000073b370000032003b3b3b3b300020000000000000000
00288888888882000056666666666500003bbbbbbbbbb300a006aaaaaaaaa00a9009aaaaaaaa90093000073b3700000320033b3b3b3300020000000000000000
00288888888882000056666666666500003bbbbbbbbbb300a006aaaaaaaaa00a9079999999999709300007333700000320733333333370020000000000000000
005222222222250000055555555550000053333333333500a0066666666aa00a9077777777777709300066666660000320777777777770020000000000000000
000000000000000000000000000000000000000000000000a00000000000000a9000000000000009300000000000000320000000000000020000000000000000
000000000000000000000000000000000000000000000000aaaaaaaaaaaaaaaa9999999999999999333333333333333322222222222222220000000000000000
00000000000000000566666666666650660000000000006666666666666666666666666666666666660000000000006666666666666666666666666666666666
5555555555555555056666666666665066000000000000666000000000000006600000000000000666dddddddddddd6666dddddddddddd6666dddddddddddd66
666d66666666666605666666666666506d666666666666d6600000000000000660000000066000060d666666666666d0006dddddddddd600006dddddddddd600
6666d6666666666605666666666666506dd6666666666dd6600000006000000660666600066600060d600000000006d000666666666666000060933000000600
6666d6666666666605666666666666506dd6666666666dd6600000066600000660066600006660060d609575750006d00066600000006600006043b330000600
66666d666666666605666666666666506dd000aaa0006dd6600000066600000660666600000666060d604757575006d000666000a0006600006043bbb3300600
66666d666666666605666666666666506dd000aaa0006dd6600000666660000660660600000066060d604575757006d000666000aa006600006043bbbbb33600
66666d666666666605666666666666506dd000aaa0006dd6600000666660000660660000000066060d604757575006d000666aaaaaa06600006043bbb3300600
66666d666666666605666666666666506dd0aaaaaaa06dd6600006666666000660660000000066060d604575757006d000666aaaaaaa6600006043b330000600
66666d666666666605666666666666506dd00aaaaa006dd6600006666666000660660000000066060d604200000006d000666aaaaaa066000060433000000600
66666d666666666605666dddddd666506dd000aaa0006dd6600066666666600660666000000666060d604200000006d000666000aa0066000060420000000600
6666d66666666666056dd666666dd6506dd0000a00006dd6600000000000000660066600006660060d604200000006d000666000a00066000060420000000600
6666d6666666666605d6666666666d506dd6666666666dd6600000000000000660006666666600060d600000000006d000666000000066000060420000000600
666d66666666666605666666666666506d666666666666d6600066666666600660000666666000060d666666666666d0006dddddddddd600006dddddddddd600
5555555555555555056666666666665066000000000000666000000000000006600000000000000666dddddddddddd6666dddddddddddd6666dddddddddddd66
00000000000000000566666666666650660000000000006666666666666666666666666666666666660000000000006666666666666666666666666666666666
55555555555555556600000000000066000000000000000000000000000000000888888888888880660000000000006600000000000000000000000000000000
554444444444445566dddddddddddd6655555555555555558888888888888888086666666666668066dddddddddddd6600000000000000000000000000000000
54544444444445450d666666666666d04444404444444444866d66666666666808666666666666800d666666666666d000000000000000000000000000000000
54455555555554450d600000000006d044444044444444448666d6666666666808666666666666800d600099990006d00000008000000000000000aaaa000000
54454445444554450d600000000006d044444044444444448666d6666666666808666666666666800d6099aaaa9906d0000000008000000000000aaa7aa00000
54454454445454450d600000000006d0444440444444444486666d666666666808666666666666800d609a000aa906d0008008808800000000000aaaa7a00000
54454544454454450d600000000006d0444440444444444486666d666666666808666666666666800d69aaaaa0aa96d00000a8099880000000000aaaa7a00000
54455444544454450d600000000006d0444440444444444486666d666666666808666666666666800d69aaaaa0aa96d0000088a80080000000000aaa7aa00000
54454445444554450d600000000006d0000000000000000086666d666666666808666666666666800d69aaa00aaa96d00000888a00800000000000aaaa000000
54454454445454450d600000000006d0555555555555555586666d666666666808666666666666800d69aaa0aaaa96d000009000088000000000000aa0000000
54454544454454450d600000000006d0444444444404444486666d666666666808666dddddd666800d609aaaaaa906d00008008a880000000000000dd0000000
54455444544454450d600000000006d044444444440444448666d66666666668086dd666666dd6800d6099a0aa9906d000080880000800000000000aa0000000
54455555555554450d600000000006d044444444440444448666d6666666666808d6666666666d800d600099990006d000000080000000000000000000000000
54544444444445450d666666666666d04444444444044444866d66666666666808666666666666800d666666666666d000000000000000000000000000000000
554444444444445566dddddddddddd6644444444440444448888888888888888086666666666668066dddddddddddd6600000000000000000000000000000000
55555555555555556600000000000066444444444404444400000000000000000888888888888880660000000000006600000000000000000000000000000000
dddd14916665d14aaaaaaaaaaaaaaaaaa90faf00000000aaaffffffff11250011ddddddd6666122211c0ee11ddddddddd5a4faf9aaa7ff1ddd1616112deeeee1
dddd149166d5d09aaaaaaaaaaaaaaaaaff50000faaaaaaff777777777777aff0111ddddd6666622111c1f76c1ddddd661fa2aaa2ff7fa9e6dd16144f2215dd11
ddd5191666d51099aaaaaaaaaaaaaa20100aaaaaaaaaaff7777777777777afff44100ddd66661221761c577c1dd76677194aaaa4aaaa99e76616115d6ee111d6
ddd109166615099aaaaaa9999999901ffaaaaaaaaaaaafa777777777a777affaaaffd11d6666611d770c111c107676712422249aaa99994776161fe111117711
ddd199166615099aa9aaa999992010aaaaaaaaaaaaaaafaaaaaaaaaaaaa999aaaaaaa42016666617771ccccc11777672a7faa0102e999947761612d11776167d
ddd1991ddd150999999999999024aaaaaaaaaaaaaaaaaaaf4444222222220004422244ef10666612761ccccc1077766600ffa77faf2299e77716111776d111ff
dd129916dd15099999999994199aaaaaaaaaaaaaa994001111011111111111112222222492166660011cccc1271767761d11112000014e277711776d1d111222
dd12991dd611099999999401999aaaaaaaaa99900111111111111111111111111222444444416662421111112f71711f000ffef1d110017711676111166d1122
dd129015550119999999414999aaaaaaaf42111111111111111111111111111111044444442166627f11111771f21d7f021777710f1ff16177711d1115d6d611
dd129011115509999994199999aa9990011111111111111111111111111111111104444444066661e7110176d121774f1ff77771771fe077d111d666111d1666
dd1291111155099999e0999994420011111155551ddddddddd1ddddddddddd1111044444411d661112ff51d11161227712f5777ff1111dd1d6d1155dddd111d6
dd129101111109999249999001115551dddddddd1ddddddddd1ddd511ddddd1dd10440011d66177751ff201dddd14422711111f2011111011dd66111d6666111
dd1294041d1e499944994211115ddd51115ddddd1ddddddddd1dd1111115dd1dd111011d61107711d12520666d111242412441111111ffff001d6665115ddd66
dd1299141d1999999111111111dd10100011dddd0ddddddddd1d111dd511dd1ddd10ddd5d766111d1511d66d11dd61114144211677f11177ff7115d66d111dd6
dd0299111d1299001111111111d111dd15d1dddd1ddddddddd1d11dddd11d11ddd161ddd1157777111dddd11dd6d111dd1110ffff11dff10ff7ff501ddd61151
dd62441111110011111111111115dddd115ddddd1dddddddd11111111110111ddd1a0dd5d6611666771d1156dd111d66d15fffffff107fd17f71577f111d6d11
66604015aaaaf00111111dddd1000000fff111111111111112feeeeefeee011ddd1a1dd5ddddd161d66771dd111666dd1112ffffffff6115ffffff25d61116d1
ddd10577a777f5011115ddddd1e777777ffffffffffffffff77777777777111ddd1af171d11ddddd1d5166761dd6d1116d4422fffffffffffff50544d5d11d76
ddd0faaaf7777f01111dddddd17777f01117777777777777777771115777111ddd1aa1717d111ddddd6117567711115ddd144d21ffff555fff224e4211177766
dd149999aa77aaa0111dddddd1777011111007777777777777770111116f111ddd1aa1717dd11511ddddd611d667711111d112442d4ffff424e44211d77661dd
dd09999999aaaaaa011dddddd17f1111111117777777777777771111111f011ddd1aa1717ddd16011111dddd611166771d11d1224422222e4421117676111ddd
cd09999999aaaaaa011ddd1dd1711111111107777777777777711111d111011ddd1991617ddd171111111dddddd616566765111122e4e4ee511d666651dddd11
dd099999999aaaaa011dd51d1111110111d5117777777777770101111601101ddd1991617ddd16111111311111dddd155177761dd111441116666615ddd111dd
dd099999999aaaaa111ddd11111111011116d107777777777d11011106d1111ddd1901717ddd1d11111111121111ddddd11566671111111666751ddddd111115
dd0999999999aaaa111dddd11111d77011166107777777777dd771100771151ddd0911717ddd1611111111ffe4d111ddddd611d6667d5676611dddd1111111dd
dd0999999999a999111ddddd1111d77711117717777777777d6770110771111ddd1917717ddd166111112122fffe2221dddddd61166666d11dddd51ddd41d1dd
dd09999999999999111dddddd111177111157777777777777d176111177f1155dd1017717ddd1662221d11eed22ffee51151ddddd61151ddddd111eeee41d151
dd04999999999999111dddddd101115111157777777777777d111111177f1115dd0077717ddd1661222d61eeee22e22dd41211dddddd1ddd11144eeeee41d1d1
dd14999999999999111dddddd17011111d157777777777777d1141d1177f1115dd1776615ddd1666111661eeee2e4feee41421111ddd1dd1deeeeeeeee41d16d
ddd1999999999990111dddddd171111e1d2d7777777777777715ee22777f1115dd17777661111666666661ee442edfeee41421c111111122deeeeeeeee41d166
ddd1194999999990511dddddd177155ee22d7777777777777712222177ff1115dd17666dd6666666666661ee242edfeeee1421111dd1152d4eeeeeeeee41d111
ddddd00999999901111dddddd177725542d777777777777777722257feff1115dd17666d666666666666612d2d2e4feeee2421111ddd152d4eeeeeeeee411176
6cccccccccccc6000000000000000000555555555555555595757500933000000000000000000000000000000000000000000000000000000000000000000000
cccccc770ccccc00000000000000000050077755575005754757575043b330000000000000009000000a90000990099000000000000000000000000000000000
ccccc77770cccc00000000000000000050700075557557554575757043bbb330000990000000a900000a900009aaaa9000000000000000000000000000000000
cccc7777770ccc00000000000000000067776007505775054757575043bbbbb0009aa9000999aa90000a900000a00a0000000000000000000000000000000000
ccc777777770cc00000000000000000056760007505775054575757043bb3330009aa9000aaaaaa00aaaaa9000a00a0000000000000000000000000000000000
6c77777777770600000000000000000050700075557557554200000043330000000990000000aa0000aaa90009aaaa9000000000000000000000000000000000
c600000000000c00000000000000000050007705575005754200000042000000000000000000a000000a90000990099000000000000000000000000000000000
ccc66666666ccc000000000000000000555555555555555542000000420000000000000000000000000000000000000000000000000000000000000000000000
cc77777777770c000000000000000000000000000000000000000000000000000091190000000000000000000000000000000000000000000000009119500000
cc77777777770c000000000000000000000000000000000000000000000000000091190000000000000000000000000000000000000000000000009119050000
cc0000000000cc000000000000000000000000000000000000000000999999900091190000999900000000000000000000000000000000000000009119500000
cccccccccccccc000000000000000000000000000000000000000000111111110091190000911900000000000000000000000000000000000000009119050000
cccccccccccccc000000000000000000000000000000000000000000111111110091190000911900000000000000000000000000000000000000009119500000
00000000000000000000000000000000000000000000000000000000999999900091190000999900000000000000000000000000000000000000009119050000
00000000000000000000000000000000000000000000000000000000000000000091190000000000000000000000000000000000000000009999991111999999
00000000000000000000000000000000000000000000000000000000000000000001100000000000000000000000000000000000000000001111111111111111
0000000000000000000000000000000000000000000000000000000000000000009aa90000000000000000000000000000000000000000001111111111111111
0000000000000000000000000000000000000000000000000000000000000000009aa90000000000000000000000000000000000000000009999999999999999
0000000000000000000000000000000000000000000000000000000099999990009aa90000999900000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000aaaaaaaa009aa900009aa900000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000aaaaaaaa009aa900009aa900000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000099999990009aa90000999900000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000009aa90000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000aa00000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000911900009aa90000000000009119000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000911900009aa90000000000009119000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000099911999999aa99999999900009119999999999900000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000011111111aaaaaaaa11111900009111111111111100000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000011111111aaaaaaaa11111900009111111111111100000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000099911999999aa99999911900000999999991199900000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000911900009aa90000911900000000000091190000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000911900009aa90000911900000000000091190000000000
__label__
88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888188888888888888888888888888888888888
88888eeeeee888888888888888888888888888888888888888888888888888888888888888888888888ff8ff8881718822888222822888888822888888228888
8888ee888ee88888888888888888888888888888888888888888888888888888888888888888888888ff888ff881711212888222822888882282888888222888
888eee8e8ee88888e88888888888888888888888888888888888888888888888888888888888888888ff888ff881717171888222888888228882888888288888
888eee8e8ee8888eee8888888888888888888888888888888888888888888888888888888888888888ff888ff811777771888888222888228882888822288888
888eee8e8ee88888e88888888888888888888888888888888888888888888888888888888888888888ff888ff171777771888228222888882282888222288888
888eee888ee888888888888888888888888888888888888888888888888888888888888888888888888ff8ff8817777771888228222888888822888222888888
888eeeeeeee888888888888888888888888888888888888888888888888888888888888888888888888888888881177718888888888888888888888888888888
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111177711111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
1bbb1b1b11bb1bbb11bb11711ccc1171111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
1bbb1b1b1b1111b11b1117111c1c1117111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
1b1b1b1b1bbb11b11b1117111c1c1117111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
1b1b1b1b111b11b11b1117111c1c1117111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
1b1b11bb1bb11bbb11bb11711ccc1171111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11bb1b1111bb11711171111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
1b111b111b1117111117111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
1b111b111bbb17111117111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
1b111b11111b17111117111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11bb1bbb1bb111711171111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11bb1bbb1bbb11711cc1111111111c111c1c11111c1c111111111ccc1ccc11711111111111111111111111111111111111111111111111111111111111111111
1b111b1b1b1b171111c1111111111c111c1c11111c1c111111111c1c1c1c11171111111111111111111111111111111111111111111111111111111111111111
1bbb1bbb1bb1171111c1111111111ccc1ccc17771ccc111111111ccc1c1c11171111111111111111111111111111111111111111111111111111111111111111
111b1b111b1b171111c1117111111c1c111c1111111c11711111111c1c1c11171111111111111111111111111111111111111111111111111111111111111111
1bb11b111b1b11711ccc171111111ccc111c1111111c17111111111c1ccc11711111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
16661111111111111ccc111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11611111177711111c1c111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11611111111111111c1c111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11611111177711111c1c111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11611111111111111ccc111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
1eee1e1e1ee111ee1eee1eee11ee1ee1111111111616166616611666166616661171117111111111111111111111111111111111111111111111111111111111
1e111e1e1e1e1e1111e111e11e1e1e1e111111111616161616161616116116111711111711111111111111111111111111111111111111111111111111111111
1ee11e1e1e1e1e1111e111e11e1e1e1e111111111616166616161666116116611711111711111111111111111111111111111111111111111111111111111111
1e111e1e1e1e1e1111e111e11e1e1e1e111111111616161116161616116116111711111711111111111111111111111111111111111111111111111111111111
1e1111ee1e1e11ee11e11eee1ee11e1e111116661166161116661616116116661171117111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
1111166611111111111111111cc11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111161111111711777111111c11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111161111117771111111111c11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111161111111711777111111c11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
1111116111111111111111111ccc1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
1eee1ee11ee111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
1e111e1e1e1e11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
1ee11e1e1e1e11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
1e111e1e1e1e11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
1eee1e1e1eee11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
82888222822882228888822288828228822288888888888888888888888888888888888888888888888888888888822282228882822282288222822288866688
82888828828282888888828888288828828888888888888888888888888888888888888888888888888888888888888288828828828288288282888288888888
82888828828282288888822288288828822288888888888888888888888888888888888888888888888888888888822288228828822288288222822288822288
82888828828282888888888288288828888288888888888888888888888888888888888888888888888888888888828888828828828288288882828888888888
82228222828282228888822282888222822288888888888888888888888888888888888888888888888888888888822282228288822282228882822288822288
88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888

__map__
0001000100010001242526270001808100000000000000000000000000000000000000646564656465646564656465646564650000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1011101110111011343536371011909100000000000068690000000000000000000000747574757475747574757475747574750000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
22234041686900016869686900018081000000000000787900000000000000000000004e4f22230000686926270000000064650000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
32335051787910117879787910119091000022234041686966672627000000000000005e5f32330000787936370000000074750000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2425404148490001484966670001808100003233505178797677363700000000000000646540416a6b48496a6b404148494a4b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3435505158591011585976771011909100004e4f000068690000000000000000000000747550517a7b58597a7b505158595a5b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000068690001686900010001000000005e5f000078790000000000000000000000646500002627424324250000000064650000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
08000800787910117879101110110800000024254041484940416a6b48494a4b000000747500003637525334350000000074750000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
18191819404148496667191819001819000034355051585950517a7b58595a5b000000646500000000000000000000000064650000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000050515859767700000000000000000000000000000000000000000000000000747500000000000000000000000074750000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000006869000000000000006869000000000000000000000000000000000000646500000000000000000000000064650000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000007879000000000000007879000000000000000000000000000000000000747500000000000000000000000074750000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000004a4b000000000000000000000000000000000000000000000000000000646500000000000000000000000064650000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000005a5b000000000000000000000000000000000000000000000000000000747500000000000000000000000074750000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000646564656465646564656465646564650000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000747574757475747574757475747574750000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
0005000011574161541307418074155641a064165641b054185541d1241a7441f5441b044217441d544221141f744220342103426734220242742424024297240070400704007040070400704007040070400704
00101000100500000010050000001c05012050120501405014050120501c05034e751c05010050000001005000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000034275000003427534275000000000000000000000000034275342752a27534275000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000003467534675000003467500000000003467500000346500000000000276500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000d0500d0500d050000001a0501a0501d05000000000000000000000000000000000000000000000000000000000000000000000000000000000
000400002152526535005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500
000800000d04013051170511800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000300000c1500e0511105114051170511705014051120510f0510c15100100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100
000200001b66022650206401b6301662015610116100d6100b6100761005610036100261002610026100261001610016100161501600016000160001600000000000000000000000000000000000000000000000
__music__
03 01424344


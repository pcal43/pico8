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
00000000000000000000000000000000ffffffffffffffff00000000000000000000000000000000000009999990000000000999999000000000000000000000
00000000000000000000000000000000ffffffffffffffff00000000000000000000000000000000000091111119000000009aaaaaa900000000000000000000
00000000000010000000000000000000fffffffffffffeff0000000000000000000000000000000000091111111190000009aaaaaaaa90000000000000000000
00100000000000000000000000000000ffffefffffffffff000000000000000000000000000000000091111111111900009aaaaaaaaaa9000000000000000000
00000000000000000000000000000000ffffffffffffffff00000000000000000000000000000000091111111111119009aaaaaaaaaaaa900000000000000000
00000000000000000000000000000000ffffffffffffffff00000000000000000000000000000000091111111111119009aaaaaaaaaaaa900000000000000000
00000001000000000000000000000000ffffffffefffffff00000000000000000000000000000000091111111111119009aaaaaaaaaaaa900000000000000000
00000000000000000000000000000000ffffffffffffffff00000000000000000000000000000000091111111111119009aaaaaaaaaaaa900000000000000000
00000000000000000000000000000000ffffffffffffffff00000000000000000000000000000000091111111111119009aaaaaaaaaaaa900000000000000000
00000000000000000000000000000000ffffffffffffffff00000000000000000000000000000000091111111111119009aaaaaaaaaaaa900000000000000000
00100000000000000000000000000000ffffffffffffffff000000000000000000000000000000000091111111111900009aaaaaaaaaa9000000000000000000
00000000000000000000000000000000ffefffffffefffff0000000000000000000000000000000000091111111190000009aaaaaaaa90000000000000000000
00000000000000000000000000000000ffffffffffffffff00000000000000000000000000000000000091111119000000009aaaaaa900000000000000000000
00000000000001000000000000000000ffffffffffffffff00000000000000000000000000000000000009999990000000000999999000000000000000000000
00000000000000000000000000000000ffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00522222222225000005555555555000005333333333350000000000000000000000000000000000000000000000000000000000000000000000000000000000
00288888888882000056666666666500003bbbbbbbbbb30000000000000000000000000000000000000000000000000000000000000000000000000000000000
00288888888882000056666666766500003bbbbbbbbbb30000000000000000000000000000000000000000000000000000000000000000000000000000000000
00288888888882000056666666676500003bbbbbbbbbb30000000000000000000000000000000000000000000000000000000000000000000000000000000000
00288888888882000056666666666500003bbbbbbbbbb30000000000000000000000000000000000000000000000000000000000000000000000000000000000
00288888888882000056666666666500003bbbbbbbbbb30000000000000000000000000000000000000000000000000000000000000000000000000000000000
00288888888882000056666666666500003bbbbbbbbbb30000000000000000000000000000000000000000000000000000000000000000000000000000000000
00288888888882000056666666666500003bbbbbbbbbb30000000000000000000000000000000000000000000000000000000000000000000000000000000000
00288888888882000056666666666500003bbbbbbbbbb30000000000000000000000000000000000000000000000000000000000000000000000000000000000
00288888888882000056666666666500003bbbbbbbbbb30000000000000000000000000000000000000000000000000000000000000000000000000000000000
00288888888882000056666666666500003bbbbbbbbbb30000000000000000000000000000000000000000000000000000000000000000000000000000000000
00522222222225000005555555555000005333333333350000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000566666666666650000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
55555555555555550566666666666650000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
666d6666666666660566666666666650000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
6666d666666666660566666666666650000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
6666d666666666660566666666666650000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
66666d66666666660566666666666650000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
66666d66666666660566666666666650000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
66666d66666666660566666666666650000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
66666d66666666660566666666666650000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
66666d66666666660566666666666650000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
66666d666666666605666dddddd66650000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
6666d66666666666056dd666666dd650000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
6666d6666666666605d6666666666d50000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
666d6666666666660566666666666650000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
55555555555555550566666666666650000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000566666666666650000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
55555555555555556600000000000066000000000000000000000000000000000888888888888880000000000000000000000000000000000000000000000000
554444444444445566dddddddddddd66555555555555555588888888888888880866666666666680000000000000000000000000000000000000000000000000
54544444444445450d666666666666d04444404444444444866d6666666666680866666666666680000000000000000000000000000000000000000000000000
54455555555554450d600000000006d044444044444444448666d66666666668086666666666668000000000000000000000008000000000000000aaaa000000
54454445444554450d600000000006d044444044444444448666d6666666666808666666666666800000000000000000000000008000000000000aaa7aa00000
54454454445454450d600000000006d0444440444444444486666d666666666808666666666666800000000000000000008008808800000000000aaaa7a00000
54454544454454450d600000000006d0444440444444444486666d6666666668086666666666668000000000000000000000a8099880000000000aaaa7a00000
54455444544454450d600000000006d0444440444444444486666d666666666808666666666666800000000000000000000088a80080000000000aaa7aa00000
54454445444554450d600000000006d0000000000000000086666d6666666668086666666666668000000000000000000000888a00800000000000aaaa000000
54454454445454450d600000000006d0555555555555555586666d66666666680866666666666680000000000000000000009000088000000000000aa0000000
54454544454454450d600000000006d0444444444404444486666d666666666808666dddddd6668000000000000000000008008a880000000000000dd0000000
54455444544454450d600000000006d044444444440444448666d66666666668086dd666666dd680000000000000000000080880000800000000000aa0000000
54455555555554450d600000000006d044444444440444448666d6666666666808d6666666666d80000000000000000000000080000000000000000000000000
54544444444445450d666666666666d04444444444044444866d6666666666680866666666666680000000000000000000000000000000000000000000000000
554444444444445566dddddddddddd66444444444404444488888888888888880866666666666680000000000000000000000000000000000000000000000000
55555555555555556600000000000066444444444404444400000000000000000888888888888880000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000555555555555555595757500933000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000050077755575005754757575043b330000000000000009000000a90000990099000000000000000000000000000000000
0000000000000000000000000000000050700075557557554575757043bbb330000990000000a900000a900009aaaa9000000000000000000000000000000000
0000000000000000000000000000000067776007505775054757575043bbbbb0009aa9000999aa90000a900000a00a0000000000000000000000000000000000
0000000000000000000000000000000056760007505775054575757043bb3330009aa9000aaaaaa00aaaaa9000a00a0000000000000000000000000000000000
0000000000000000000000000000000050700075557557554200000043330000000990000000aa0000aaa90009aaaa9000000000000000000000000000000000
0000000000000000000000000000000050007705575005754200000042000000000000000000a000000a90000990099000000000000000000000000000000000
00000000000000000000000000000000555555555555555542000000420000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000091190000000000000000000000000000000000000000000000009119500000
00000000000000000000000000000000000000000000000000000000000000000091190000000000000000000000000000000000000000000000009119050000
00000000000000000000000000000000000000000000000000000000999999900091190000999900000000000000000000000000000000000000009119500000
00000000000000000000000000000000000000000000000000000000111111110091190000911900000000000000000000000000000000000000009119050000
00000000000000000000000000000000000000000000000000000000111111110091190000911900000000000000000000000000000000000000009119500000
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


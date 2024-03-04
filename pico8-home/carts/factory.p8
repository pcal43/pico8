pico-8 cartridge // http://www.pico-8.com
version 41
__lua__

#include factory/map.lua
#include factory/tiles.lua
#include factory/levels.lua
#include factory/factory.lua
#include factory/effects.lua

 
__gfx__
55555555555555550000000000000000000000000000000000000000000000000000000000000000555555555555555555555555555555555444494554444445
50000000000000050000000aa90000000000000000000000000000000000000000000000000000005aaaaaaaaaaaaaa544544454445444545444444554444445
50000066660000050000000aa90000000000000000000000000000000000000000000000000000005aaaaaaaaaaaaaa544544454445444545555555555555555
5055555555555005000000aaaa9000000000000000000000000000000000000000000000000000005aaaaaaaaaaaaaa544544454445444545444444554444445
5005656565655005000000aaaa9000000000000000000000000000000000000000000000000000005aaaaaaaaaaaaaa544544454445444545444444554444445
500565656565000500000aaaaaa900000000000000000000000000000000000000000000000000005aaaaaaaaaaaaaa544544454445444545444444554444445
500565656565000500000aa11aa900000000000000000000000000000000000000000000000000005aaaaaaaaaaaaaa544544454445444545555555555555555
50056565656500050000aaa11aaa90000000000000000000000000000000000000000000000000005aaaaaaaaaaaaaa555555555555555555444444554444445
50056565656500050000aaa11aaa9000000000000000000000000000000000000000000000000000555555555555555500000000000000000000000000000000
5005656565650005000aaaa11aaaa900000000000000000000000000000000000000000000000000588888888888888500000000000000000000000000000000
5005656565650005000aaaa11aaaa900000000000000000000000000000000000000000000000000588888888888888500000000000000000000000000000000
500565656565000500aaaaaaaaaaaa90000000000000000000000000000000000000000000000000588888888888888500000000000000000000000000000000
500565656565000500aaaaa11aaaaa90000000000000000000000000000000000000000000000000588888888888888500000000000000000000000000000000
50055555555500050aaaaaa11aaaaaa9000000000000000000000000000000000000000000000000588888888888888500000000000000000000000000000000
50000000000000050aaaaaaaaaaaaaa9000000000000000000000000000000000000000000000000588888888888888500000000000000000000000000000000
55555555555555550000000000000000000000000000000000000000000000000000000000000000555555555555555500000000000000000000000000000000
77777777777777778888888888888888ccccccccccccccccaaaaaaaaaaaaaaaa9999999999999999000000000000000001111110011111100111111001111110
70000000000000078000000000000008c00000000000000ca00000000000000a9000000000000009000000000000000012222221122222211222222112222221
70000077770000078000088888880008c0000ccccccc000ca00000000000000a900000000000000900000000000000001223ff311223ff311223ff311223ff31
700007ffff7000078000877777778008c000c7777777c00ca00000000000000a9000000000000009000000000000000012efffe112efffe112efffe112efffe1
70007ffffff700078008777777778008c00c77777777c00ca00000000000000a900000000000000900000000000000001221122112211221f221122f22111110
70007ffff7f700078008777777778008c00c77777777c00ca00000000000000a90000000000000090000000000000000012882f1f128821f11288211f8188810
7007ffffff7f70078008888888888008c00cccccccccc00ca00000000000000a900999999999900900000000000000001f288810111818110128110011888100
7007ffffff7f70078008888888888008c00cccccccccc00ca00000000000000a9009aaaaaaaaa009000000000000000001811100000118100181000001811000
7007ffffff7f70078008887777888008c00cccc777ccc00ca00000000000000a9009a99999999009bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
7007ffffff7f70078008887888888008c00ccc7cccccc00ca00000000000000a9009a9aaaaaa9009bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
7007ffffff7f70078008887778888008c00cccc77cccc00ca0066666666aa00a9009a999999a9009bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
7007fffff7ff70078008887888888008c00cccccc7ccc00ca006a6a6a66aa00a9009aaaaaaaa9009bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
70007ffffff700078008887888888008c00ccc777cccc00ca0066a6a6a6aa00a9079999999999709bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
70000777777000078000888888880008c000cccccccc000ca0066666666aa00a9077777777777709bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
70000000000000078000000000000008c00000000000000ca00000000000000a9000000000000009bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
77777777777777778888888888888888ccccccccccccccccaaaaaaaaaaaaaaaa9999999999999999bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
00000000000000000566666666666650000000000000000066666666666666666666666666666666666666666666666666666666666666666666666666666666
55555555555555550566666666666650000000000000000066dddddddddddd6666dddddddddddd6666dddddddddddd6666dddddddddddd6666dddddddddddd66
666566666665666605666555555666500000000000000000006dddddddddd600006dddddddddd600006dddddddddd600006dddddddddd600006dddddddddd600
66665666666656660565566666655650000000000000000000666666666666000066666666666600006666666666660000666666666666000060933000000600
66665666666656660556666666666550000000000000000000600000000006000066aaaaaaaa660000666000b00066000066600000006600006043b330000600
66666566666665660566666666666650000000000000000000600077777006000066aaaaaaaa6600006660bbbbb0660000666000a0006600006043bbb3300600
666665666666656605666666666666500000000000000000006007ddddd706000066aaaaaaaa660000666b00b000660000666000aa006600006043bbbbb33600
66666566666665660566666666666650000000000000000000607ddd7ddd7600006666666666660000666b00b000660000666aaaaaa06600006043bbb3300600
66666566666665660566666666666650000000000000000000607ddd7ddd76000066666666666600006660bbbbb0660000666aaaaaaa6600006043b330000600
66666566666665660566666666666650000000000000000000607d777ddd7600006688888888660000666000b00b660000666aaaaaa066000060433000000600
66666566666665660566655555566650000000000000000000607ddddddd7600006688888888660000666000b00b660000666000aa0066000060420000000600
666656666666566605655666666556500000000000000000006007ddddd706000066888888886600006660bbbbb0660000666000a00066000060420000000600
6666566666665666055666666666655000000000000000000060007777700600006666666666660000666000b000660000666000000066000060420000000600
666566666665666605666666666666500000000000000000006dddddddddd600006dddddddddd600006dddddddddd600006dddddddddd600006dddddddddd600
55555555555555550566666666666650000000000000000066dddddddddddd6666dddddddddddd6666dddddddddddd6666dddddddddddd6666dddddddddddd66
00000000000000000566666666666650000000000000000066666666666666666666666666666666666666666666666666666666666666666666666666666666
55555555555555550000000000000000000000000000000000000000000000000566666666666650000000000000000000000000000000000000000000000000
55444444444444550000000000000000000000000000000055555555555555550566666666666650555555555555555500000000000000000000000000000000
54544444444445450000000000000000000000000000000066665666666656660566666666666650666566666665666600000000000000000000000000000000
5445555555555445000000000000000000000000000000006665666666656666055666666666655066665688886656660000008000000000000000aaaa000000
544544454445544500000000000000000000000000000000666566666665666605655666666556506666889999885666000000008000000000000aaa7aa00000
544544544454544500000000000000000000000000000000665666666656666605666555555666506666899999986566008008808800000000000aaaa7a00000
5445454445445445000000000000000000000000000000006656666666566666056666666666665066689999999985660000a8099880000000000aaaa7a00000
544554445444544500000000000000000000000000000000665666666656666605666666666666506668999999998566000088a80080000000000aaa7aa00000
5445444544455445000000000000000000000000000000006656666666566666056666666666665066689999999985660000888a00800000000000aaaa000000
54454454445454450000000000000000000000000000000066566666665666660566666666666650666899999999856600009000088000000000000aa0000000
5445454445445445000000000000000000000000000000006656666666566666056666666666665066668999999865660008008a880000000000000dd0000000
54455444544454450000000000000000000000000000000066656666666566660556666666666550666688999988566600080880000800000000000aa0000000
54455555555554450000000000000000000000000000000066656666666566660565566666655650666656888866566600000080000000000000000000000000
54544444444445450000000000000000000000000000000066665666666656660566655555566650666566666665666600000000000000000000000000000000
55444444444444550000000000000000000000000000000055555555555555550566666666666650555555555555555500000000000000000000000000000000
55555555555555550000000000000000000000000000000000000000000000000566666666666650000000000000000000000000000000000000000000000000
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

__gff__
0000000000000000000000000201000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004040404040400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0002000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0505050000000000242526270000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0505000000000000343536370000000000000000000068690000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2223404168690000686968690000000000000000000078790000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3233505178790000787978790000000000002223404168696667262700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2425404148490000484966670000000000003233505178797677363700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3435505158590000585976770000000000004e4f000068690000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000068690000686900000000000000005e5f000078790000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
08000800787908007879000800000800000024254041484940416a6b48494a4b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
18191819404148496667191819001819000034355051585950517a7b58595a5b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000050515859767700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000006869000000000000006869000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000007879000000000000007879000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000004a4b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000005a5b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
01101000100500000010050000001c05012050120501405014050120501c05034e751c05010050000001005000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000034275000003427534275000000000000000000000000034275342752a27534275000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
011000003467534675000003467500000000003467500000346500000000000276500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000d0500d0500d050000001a0501a0501d05000000000000000000000000000000000000000000000000000000000000000000000000000000000
__music__
03 01424344


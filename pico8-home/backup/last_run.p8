pico-8 cartridge // http://www.pico-8.com
version 41
__lua__

#include garden/garden.lua
#include garden/scripting.lua
#include garden/effects.lua

__gfx__
01111110011111100111111000000000000000000000000000000000000000000000000000000000000000000000000055555555555555555444494554444445
18888881188888811888888100000000000000000005665000000000000000000000000000000000000000000000000044544454445444545444444554444445
18811111188111111881111100000000008080800056666000000000000000000000000000000000000000000000000044544454445444545555555555555555
1812ff211812ff211812ff2100000000005050500066666000000000000000000000000000000000000000000000000044544454445444545444444554444445
181ffff1181ffff1181ffff104545450005050500046665000000000000000000000000000000000000000000000000044544454445444545444444554444445
18833310188333b118b3333104454540006666600444650000000000000000000000000000000000000000000000000044544454445444545444444554444445
18b333b118b33510011533b104444440006666604440000000000000000000000000000000000000000000000000000044544454445444545555555555555555
01151510011511000001151000000000000000044200000000000000000000000000000000000000000000000000000055555555555555555444444554444445
01111110011111100111111001111110011111142000000001111110000000000111111001111110011111100111111000000000000000000000000000500000
18888881188888811888888118888881155555510111111015555551011111101555555115555551155555511555555100000000000000000000000000750000
18811111188111111881111118811111155ffff115555551155ffff115555551155ffff1155ffff1155ffff1155ffff100000000000000000000000000775000
1812ff211812ff211812ff211812ff2115fcffc1155ffff115fcffc1155ffff115fcffc115fcffc115fcffc115fcffc100000000000000000000000000777500
181ffff1181ffff1b81ffffb111ffff101fffff115fcffc101fffff115fcffc101fffff101fffff1f1ffffff11fffff100000000000000000000000000777700
18b33331b813333b18133331b33333310177571001fffff11f77571001fffff1017757f11f75557f17755571f775557100000000000000000000000000777000
011533b11115131111131511111513101f7555f11f7555f1017555f1017555101f75551001175711011717111177571000000000000000000000000000770000
00011510000115100015110000015100017757100177571001775110017757100117571000011710001711000017110000000000000000000000000000700000
01111110000000000111111000000000011111100111111001111110011111100111111000000000011111100000000001111110011111100111111000111110
1aaaaaa1011111101aaaaaa1011111101aaaaaa11aaaaaa11aaaaaa11aaaaaa11222222101111110122222210111111012222221122222211222222112222221
1aa3ff311aaaaaa11aa3ff311aaaaaa11aa3ff311aa3ff311aa3ff311aa3ff311223ff31122222211223ff31122222211223ff311223ff311223ff311223ff31
1afffff11aa3ff311afffff11aa3ff311afffff11afffff11afffff11afffff112efffe11223ff3112efffe11223ff3112efffe112efffe112efffe112efffe1
1a1221101afffff11a1221101afffff11a1221101a1221117a122117aa1222101221122112efffe1112112b112efffe11221122112211221f221122f22111110
1a1ee1001a1221101a7ee1001a1221101a1ee710172eee271a1eeee17e2eee1001288210012882101f28821001288210012882f1f128821f11288211f8188810
017ee71017eeee7101eee71001eeee10017eee1001eeee11011eee1012eeee101f2882f11f2882f1018882f11f2882f11f288810111818110128110011888100
12eeee21012ee21012eeee21012ee21012eeee210011e1000001e10012eee1000181181001811810001118100181181001811100000118100181000001811000
bbbbbbbbbbbbbbbbbbbbbbbbbbb88bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
b88b8b88bbbbcbbbbebebebbbb8f82bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
bb88888bbbbcccbbbbeeebbbbb8882bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
bbb838bbbbccaccbbeeceebbb8888e2bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
bb3b3b3bbbbcccbbbbeeebbbb8f8222bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
bbb333bbbbbbcbbbbebebebbbb8222bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
bbbb3bbbbbb333bbbbb3bbbbbb3113bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
bbbb3bbbbbbb3bbbbbbb3bbbb322223bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
bbb33bbbbbbbb333333bbbbb333bb3b133ab1333bbbbbbbbbbbbb9bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb4444bbbbbbbbbbbbbbbbbbbbbb
bb31b3bbbbbb33333333bbbb33331133b3113333bbbbbbbbbbbb9bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb44999944bbbbbbbbbbbbbbbbbbbb
b33b331bbbb3a3baab333bbbab3331133133a3babb224444444944bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb4494aaa94944bbbbbbbbbbbbbbbbbb
b13aa33bbb3b3baaaab133bbaab13331333b3baab22229949994944bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb449494aaaa444944bbbbbbbbbbbbbbbb
33b5ab33b33311baab13b33bab13b331133311bab21222244244224bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb44949444aaa949494944bbbbbbbbbbbbbb
313bb311b3ab333333bb113b33bb113113ab3333b2212444244bbbbbbbbbbbbbbbb33bbbbbbbbbbbbbbbbbbbbbbb4494949494aaaa4949444944bbbbbbbbbbbb
13bb1b31b311bb331311333b131133344311bb33b12242122221223bbbbbbbbbbbbb3b3bb33bb3bbbbbbbbbbbb449494949494aaaa494449494944bbbbbbbbbb
3113b331b1b31133333ab31b333ab31111b311333311111111111133bbbbbbbb333bb33333bb333bbbbbbbbb449494449444a444444a494949444944bbbbbbbb
1b333111b31bb3b133ab113b33ab1333333bb3b1bbbbbbbbbbbbbbbbbbbbbbb333333333333333333bbbbbbb2494949494a4442222444a4944494942bbbbbbbb
11b3bb11b1111133b311311bb311333333331133bbbbbbbbbbb3bbbbbbbbbb3333333b33bb33333333bbbbbb44949494a44422111122444a49494944bbbbbbbb
31333313bb11b113313311bb3133a3baab333113bbbb88bbb33bbbbbbbbbbbb333bb3bb3bb3b33b33bbbbbbb249444a444221111111122444a494442bbbbbbbb
b311113bbbb1113133111bbb333b3baaaab13331bbb8f88bbbbb3bbbbbbbb3bb333bbbbbbbbbbbb3bb3bbbbb2494a4442211112222111122444a4942bbbbbbbb
bb3223bbbbb3111111113bbb133311baab13b331bbb2882bbbbbb33bbbbbb33b3bbbbbbbbbbbbb33b33bbbbb24a44422111122222222111122444a42bbbbbbbb
bb1442bbbb314211112413bb13ab333333bb1131b2bb22bbbb3bbbbbbbbbbbb33bbbbbbbbbbbbbb33bbbbbbb24442211112222244222221111224442bbbbbbbb
31434413b31421244212413b4311bb3313113334b3b3223bbbb3bbbbbbbbbb333bbbbbbbbbbbbb3333bbbbbb24221111222224444442222211112242bbbbbbbb
b333133bbb331441144133bb11b31133333ab311bbbb33bbbbbbbbbbbbbbbbb333bbbbbbbbbbb3333bbbbbbb21111122222444444444422222111112bbbbbbbb
bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb88bbb33333333bbbbbbb3333bbbbbbbbbbb333bbbbbbb11111222244444444444444222211111bbbbbbbb
bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb8f82bb3b333333bbbbbb333bbbbbbbbbbbbbb333bbbbbbb112122444111144444111444221211bbbbbbbbb
bbbbbdddddddbbbbbbbbbbbbbbbddbbbbbbbddbbbb8882bb33bb3333bbbbbb3b33bbbbbbbbbbbb33b3bbbbbbbb1221444111111444111114441221bbbbbbbbbb
bbbbdd6d666ddbbbbbbbbbbbbdd66dbbbbbd6ddbb8888e2b33333b33bbbbbbbb333bbbbbbbbbb333bbbbbbbbb312242241111114441111142242213bbbbbbbbb
bbbddddddd66ddbbbbbbbbbbd666d55bbbd6dd5bb8f8222b333bb333bbbbbbb333bbbbbbbbbbbbb33bbbbbbbb311244441111914441111144442113bbbbbbbbb
bbdddddddddd6ddbbbbbbbbd66ddd55bb35dd553bb8222bb333333b3bbbbbb333bbbb33b3bbbbb3333bbbbbb3312124441111414442222244421213bbbbbbbbb
bb55dddddd55dddbbbbbbbd66ddd555bbb35553bbb3113bb3bb33b33bbbbbbb333b3bb3b3b3b3b333bbbbbbb3331142241111114444444442241133bbbbbbbbb
b5555ddd66dd555bbbbbbd6ddddd55bbbbbbbbbbb322223b33333333bbbbbbbb3333333333333333bbbbbbbbb333311441111114424224244113333bbbbbbbbb
b55dd5d66dd5155bbbbbdddd5dd551bbbbbbbbbb3333333333333333bbbbbbbb333bb333b33bb333b44bb44b333bb3b133ab1344443bb3b133ab1333bbbbbbbb
b151dddddd55155bbbbdd6dd15555bbbbbbdddbb3333333333333333bbbbb3bbb3bb3b3bbb33bb3b9999999933331133b311449999441133b3113333bbbbbbbb
33151dddd5555133bbbdddddd1551bbbbbdd6ddb3333333333333b33bb333bbbbbb33bbbbbbbbbbb44444444ab333113314494aaa94944133133a3babbbbbbbb
b33111555511133bb331ddd555513333bdddd5db33333333333bbb33b33333bbbbbbbbbbbbbbbbbb42242424aab13331449494aaaa444944333b3baabbbbbbbb
bb333311113333bbbb333111111333bbb5d5555b3333333333bbbbb3b333333bbbbbbbbbbbbbbbbb42422424ab13b344949444aaa9494949443311babbbbbbbb
bbbb33333333bbbbbbbb33333333bbbb335111333333333333bbb333bb3333bbbbbbbbbbbbbbbbbb4444444433bb4494949494aaaa49494449443333bbbbbbbb
bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb3333bb3333333333333333bbbb3bbbbbbbbbbbbbbbbbbbb22bb22b13449494949494aaaa49444949494433bbbbbbbb
bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb3333333333333333bbbbbbbbbbbbbbbbbbbbbbbb32233223449494449444a444444a494949444944bbbbbbbb
40000000444144415555555d00000000470000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00040000414444415dd555d500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000040041444141d55d5d5d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
04000004414441415555d55500000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000004141414155dd555500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000414144415d55d55500100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
400000404441414455d55d5d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0004000044444144dd5555d500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00444440141111110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
44000044444444440000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
40a99904114114110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
40a99904444444440000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
40a99900411141140000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
40a90904444444440000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00a99904411111410000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
40a99904444444440000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
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
0000000000000000000000000201000000000000000000000000000000000000000000000000000000000000000000000101010004040404040404040404040402020202020202040404040202020204020202020200040404040002020202040202020202000404040400020002020402020202020404040404020202020204
0002000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
4344435454544344444444434443444300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008383838383838383838383838383838300000000000000000000000000000000
4341424440445354565644775441425300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008383838383838383838383838383838300000000000000000000000000000000
535152405054584b4c4d4e564751524000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008383839191919191919191919183838300000000000000000000000000000000
43473e50473c515b5c5d5e5a3c3f3e5000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008383818182828282828282828183838300000000000000000000000000000000
4056473f3d473a6b6c6d6e6a5640564400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008383818282828282828282828183838300000000000000000000000000000000
5040473c3e3f473c3b3d78473c503f4400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008383818282828282828282828181838300000000000000000000000000000000
545053473d473e473c4756563d56565400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008383818282828282828282828281838300000000000000000000000000000000
5441423e3c476447493b47563e40564400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008383818282828282828282828281838300000000000000000000000000000000
40515249473e473b47473e475650564000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008383818282828282828282828281838300000000000000000000000000000000
407566755a3b4756473d563b3c56475000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008383818282828282828282828281838300000000000000000000000000000000
504142665a3c3d3c4749473c4956564400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008383819182828282828282828281838300000000000000000000000000000000
50515275683b473e473c5656563c405400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008383839191818282818282828181838300000000000000000000000000000000
69515266755a3b3b4756563c5647505400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008383838383818282819191918183838300000000000000000000000000000000
7979595466606147494741424756564000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008383838383838383838383838383838300000000000000000000000000000000
6263575454707141424851524848485000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008383838383838383838383838383838300000000000000000000000000000000
7273695454545351526653535453547400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008383838383838383838383838383838300000000000000000000000000000000
4344434440404054586643414244447474000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5354535850505058676668515254544444000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
43445856565656473b59666a4142545454000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
53545640404047414267666a5152445400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5950475050503f51523f793b4757545300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
7447563c60613c3f473c3e473b57665300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
405645467071473e563d3836473c596644000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
504756454647563b4747473f3c47575354000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
60613c403c563d3c3d4756473d40574344000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
70715650626360613f47563d4750576654000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
6061565672737071606156477447574344000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
707140565656565670713d56473d575354000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
62635064566263644546743b3f41424443440000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
7273565656727356563c56476451525453540000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
6263646061566061626362636944434400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
7273647071647071727372735354535474000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
01101000100500000010050000001c05012050120501405014050120501c05034e751c05010050000001005000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000034275000003427534275000000000000000000000000034275342752a27534275000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
011000003467534675000003467500000000003467500000346500000000000276500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000d0500d0500d050000001a0501a0501d05000000000000000000000000000000000000000000000000000000000000000000000000000000000
__music__
03 01424344


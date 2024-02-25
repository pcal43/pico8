pico-8 cartridge // http://www.pico-8.com
version 41
__lua__

print "hello, world, sucka"

music(0)


local mloc={}
mloc.x = 0
mloc.y = 0

local p1={}
p1.x = 10
p1.y = 10

function _update()
  if btn(0) then 
    p1.x -= 1
    if (p1.x < 0) then
      p1.x = 127
      mloc.x -= 1 
    end
  end
  if btn(1) then 
    p1.x += 1
    if (p1.x > 127) then
      p1.x = 0
      mloc.x += 1 
    end
  end
  if btn(2) then 
    p1.y -= 1
    if (p1.y < 0) then
      p1.y = 127
      mloc.y += 1 
    end
  end
  if btn(3) then 
    p1.y += 1
    if (p1.y > 127) then
      p1.y = 0
      mloc.y -= 1 
    end
  end

end

glyphs={"\139","\145","\148","\131","\142","\151"}
function _draw()
    cls()
    map(mloc.x * 16, mloc.y * 16, 0, 0)
    spr(2, p1.x, p1.y)
    spr(1, 20, 20) 
    spr(2, 30, 30)

    for p=0,8 do
      print(''..p..':', 0, p*7, 1)
      for b=0,6 do
        if btn(b,p) then
          print(glyphs[b+1], b*8 + 10, p*7, p+1)
        end
      end
    end
  end



__gfx__
00000000000000008888888806666600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000099999908888888806666600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700099999900083330006666666000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000085559900333833006668886000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000085559900833333006668886000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700085559900034430006666666000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000088889900004400006666666000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000004400000666666000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000090000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
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
00000000000000000000000000000009000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000999999cc000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000999999cc000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000900000cc000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000c000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000c000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000c000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000c000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
bbb33bbbbbbbb333333bbbbb333bb3b133ab1333bbbbbbbbbbbbb9bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb4444bbbbbbbbbbbbbbbbbbbbbb
bb31b3bbbbbb33333333bbbb33331133b3113333bbbbbbbbbbbb9bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb44999944bbbbbbbbbbbbbbbbbbbb
b33b331bbbb3a3baab333bbbab3331133133a3babb224444444944bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb4494aaa94944bbbbbbbbbbbbbbbbbb
b13aa33bbb3b3baaaab133bbaab13331333b3baab22229949994944bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb449494aaaa444944bbbbbbbbbbbbbbbb
33b5ab33b33311baab13b33bab13b331133311bab21222244244224bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb44949444aaa949494944bbbbbbbbbbbbbb
313bb311b3ab333333bb113b33bb113113ab3333b22124442444441bbbbbbbbbbbb33bbbbbbbbbbbbbbbbbbbbbbb4494949494aaaa4949444944bbbbbbbbbbbb
13bb1b31b311bb331311333b131133344311bb33b12242122221223bbbbbbbbbb3bb3b3bb33bb3bbbbbbbbbbbb449494949494aaaa494449494944bbbbbbbbbb
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
4344435454544344444444434443444300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
4341424440445354565644775441425300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
535152405054584b4c4d4e564751524f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
434747504747515b5c5d5e475647474f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
475647474747476b6c6d6e565656565600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5440434142567756564769685649694400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5450535152475649477a56564769535400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5441425468654747494747684443444400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5451525454545447474756535453545400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5451525454545447474756535453545400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5441425468654747494747684443444400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5451525454545447474756535453545400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5451525454545447474756535453545400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5441425468654747494747684443544100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5451525454545447474756535453545100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5451525454545447474756535453540100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
01101000100500000010050000001c05010050000001005010050000001c05034e751c05010050000001005000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000034275000003427534275000000000000000000000000034275342752a27534275000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
011000003467534675000003467500000000003467500000346500000000000276500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__music__
03 01020344




function drawSnow(weight) 
    for i=0, weight do
      --poke(0x6000+rnd(0x2000),rnd(256))
      local addr  = 0x6000+rnd(0x2000)
      local current = peek(addr)
      if (i % 2 ==0) then
        poke(addr, 0x07 | (current & 0xF0) )
      else 
        poke(addr, 0x70 | (current & 0x0F) )
      end
    end
  end


  function drawControlStatus() 
    for p=0,8 do
      print(''..p..':', 0, p*7, 1)
      for b=0,6 do
        if btn(b,p) then
          print(glyphs[b+1], b*8 + 10, p*7, p+1)
        end
      end
    end
  end




function randrange(a,b) 
  return a + rnd(b-a)
end

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

function accumulate_snow() 
  local lx = randrange(0,127)
  local ly = randrange(24,63)
  local cur = sget(lx, ly)
  if (cur == 3 or cur == 4 or cur == 9 or cur == 11) sset(lx, ly, 7)
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




function shiftSprite(spriteNumber, dx, dy)
  -- http://pico8wiki.com/index.php?title=Memory#Sprite_sheet
  local addr
  if (dx != 0) then
    addr = 512 * (spriteNumber  \ 16) + 4 * (spriteNumber % 16)
    for addr = addr, addr + (64*7), 64 do
      local b = peek4(addr)
      local bits = abs(dx) * 4
      if (dx > 0) then
      -- >>> = 'zero fill right shift'
        b = (b << bits) | (b >>> (32 - bits))
      else 
        b = (b >>> bits) | (b << (32 - bits))
      end
      poke4(addr, b)
      -- addr += 64
    end
  end
  if (dy != 0) then
    local addr = 512 * (spriteNumber  \ 16) + 4 * (spriteNumber % 16)
    local rows = {}
    for r=0, 7 do
      rows[r] = peek4(addr + (64 * r))
    end
    for r=0, 7 do
      poke4(addr + (64 * r), rows[(r-dy)%8])
    end
  end  
end
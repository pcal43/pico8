




function shift16x16sprite(spriteNumber, dx, dy)
  local addr
  if (dx != 0) then
    addr = 256 * (spriteNumber  \ 8) + 4 * (spriteNumber % 8)
    for addr = addr, addr + (64*15), 64 do
      local b1 = peek4(addr)
      local b2 = peek4(addr + 4)
      local shiftAmount = abs(dx) * 4 -- 4 bits-per-pixel
      if (dx > 0) then
        -- >>> = 'zero fill right shift'
        poke4(addr, (b1 << shiftAmount) | (b2 >>> (32 - shiftAmount)))
        poke4(addr + 4, (b2 << shiftAmount) | (b1 >>> (32 - shiftAmount)))
      else 
        poke4(addr, (b1 << shiftAmount) | (b2 >>> (32 - shiftAmount)))
        poke4(addr + 4, (b2 << shiftAmount) | (b1 >>> (32 - shiftAmount)))
      end
    end
  end
  if (dy != 0) then
    local addr = 512 * (spriteNumber  \ 16) + 4 * (spriteNumber % 16)
    local rows1 = {}
    local rows2 = {}
    for r=0, 15 do
        rows1[r] = peek4(addr + (64 * r))
        rows2[r] = peek4(addr + 4 +(64 * r))        
    end
    for r=0, 15 do
        poke4(addr + (64 * r), rows1[(r-dy)%16])
        poke4(addr + 4 + (64 * r), rows2[(r-dy)%16])
    end
  end  
end

function drawSprite(number, cx, cy, flipx, flipy)
    if (number <= 128) then
      -- the first two pages of sprites are 16x16
      spr(number, cx, cy, 2, 2, flipx, flipy)
    else
      spr(number, cx, cy, 1, 1, flipx, flipy)
    end
  end
  




function shift8x8Sprite(spriteNumber, dx, dy)
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
    local rows = {}
    for r=0, 7 do
      rows[r] = peek4(addr + (64 * r))
    end
    for r=0, 7 do
      poke4(addr + (64 * r), rows[(r-dy)%8])
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
  
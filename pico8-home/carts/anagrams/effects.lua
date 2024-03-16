




function shift16x16spriteRight(spriteNumber)
    local addr
    addr = 256 * (spriteNumber  \ 8) + 4 * (spriteNumber % 8)
    for addr = addr, addr + (64*15), 64 do
      local b1 = peek4(addr)
      local b2 = peek4(addr + 4)
      -- >>> = 'zero fill right shift'
      -- 4 is shift amount, 4 bits per pixel
      poke4(addr, (b1 << 4) | (b2 >>> (32 - 4)))
      poke4(addr + 4, (b2 << 4) | (b1 >>> (32 - 4)))
    end
end

function shift16x16spriteDown(spriteNumber)
    local addr = 512 * (spriteNumber  \ 16) + 4 * (spriteNumber % 16)
    local buf1 = peek4(addr)
    local buf2 = peek4(addr + 4) -- 4 is the width of an 8-pixel sprite (half)
    for r=0, 14 do
        poke4(addr,  peek4(addr + 64))
        poke4(addr + 4, peek4(addr + 4 + 64))
        addr = addr + 64 -- 64 is the width in bytes of the spritesheet
    end
    poke4(addr, buf1)
    poke4(addr + 4 , buf2)
end  

function drawSprite(number, cx, cy, flipx, flipy)
    if (number <= 128) then
      -- the first two pages of sprites are 16x16
      spr(number, cx, cy, 2, 2, flipx, flipy)
    else
        spr(number, cx, cy, 1, 1, flipx, flipy)
    end
end
  

local CURSOR_COLORS = { 0, 7, 10 }
function hiliteRect(r, frameAlpha)
    rect(r.x, r.y, r.x + r.w, r.y + r.h, CURSOR_COLORS[(frameAlpha % #CURSOR_COLORS) + 1])
end

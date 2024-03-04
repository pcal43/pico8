
function isBit(bitfield, fieldNumber)
    return (bitfield & 1 << fieldNumber) != 0
end

function clearBit(bitfield, fieldNumber) 
    return bitfield & ~(1 << fieldNumber)
end

function setBit(bitfield, fieldNumber) 
    return bitfield | (1 << fieldNumber)
end

-- Return the integer that is encoded in the given 'bitfield' as a sequence of
-- 'size' bits at position 'pos'.
function getBitInt(bitfield, pos, size)
    return (((1 << size) - 1) & (bitfield >> (pos - 1)));
end

-- Encode an integer in the given 'bitfield' as a sequence of 'size' bits at 
-- position 'pos' and return the resulting bitfield.
function setBitInt(bitfield, pos, size)
    return bitfield -- FIXME
end

-- Output a given bitfield of size bytesSize as a string of 0's and 1's.
-- Useful mainly for debugging.
function bitStr(bitfield, bytesSize) 
    local out = ""
    for i=(bytesSize*8)-1,0,-1 do
        if (bitfield & (1 << i) != 0) then
            out = out .. tostr(1)
        else 
            out = out .. tostr(0)
        end
    end
    return out
end


function varPeek(addr, bytes) 
    if (bytes == 1) return peek(addr)
    if (bytes == 2) return peek2(addr)    
    if (bytes == 4) return peek4(addr)
    printh("bad peek " .. tostr(bytes))    
    return nil
end


--KILLME
function varPeekStr(addr, bytes) 
    local flags = varPeek(addr, bytes)
    local out = ""
    for i=(bytes*8)-1,0,-1 do
        if (flags & (1 << i) != 0) then
            out = out .. tostr(1)
        else 
            out = out .. tostr(0)
        end
    end
    return out
end

function varPoke(addr, val, bytes) 
    if (bytes == 1) return poke(addr, val)
    if (bytes == 2) return poke2(addr, val)    
    if (bytes == 4) return poke4(addr, val)
    printh("bad poke " .. tostr(bytes))
    return nil
end

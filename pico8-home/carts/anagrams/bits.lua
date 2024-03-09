
function isBit(bitfield, fieldNumber)
    return (bitfield & (1 << fieldNumber)) != 0
end

function clearBit(bitfield, fieldNumber) 
    return bitfield & ~(1 << fieldNumber)
end

function setBit(bitfield, fieldNumber, value) 
    if (value == nil or value) then
        return bitfield | (1 << fieldNumber)
    else
        return clearBit(bitfield, fieldNumber)        
    end
end

-- https://www.geeksforgeeks.org/extract-k-bits-given-position-number/
-- Return the integer that is encoded in the given 'bitfield' as a sequence of
-- 'size' bits at position 'pos'.  pos is the low end of the bit range (right to left)
function getBitInt(bitfield, pos, size)
    -- create a mask of the 'size' rightmost bits, right shift the bitfield over it, & the result
    return ((1 << size) - 1) & (bitfield >> (pos));
end

-- Encode an integer in the given 'bitfield' as a sequence of 'size' bits at 
-- position 'pos' and return the resulting bitfield
function setBitInt(bitfield, pos, size, val)
    val = val << (pos)
    mask = (1 << size) - 1
    mask = ~(mask << (pos))
    bitfield = bitfield & mask
    bitfield = bitfield | val    
    return bitfield
end

-- Output a given bitfield of size bytesSize as a string of 0's and 1's.
-- Useful mainly for debugging.
function bitStr(bitfield, bytes) 
    local out = ""
    for i=(bytes*8)-1,0,-1 do
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
    printh("ERROR: bad peek " .. tostr(bytes))    
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
    printh("ERROR: bad poke " .. tostr(bytes))
    return nil
end

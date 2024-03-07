

function assertEquals(value, expect) 
    assert(value == expect, "Expected " .. tostr(expect) .. " but got " .. tostr(value))
end

function testBits() 
    local b = 0b00000000
    assert(true, "wut?")
    assert("foo" == "foo", "foo?")
    assert("foo" != "bar", "foobar?")
    assert(not isBit(b, 4), "bit should not be set")


    assertEquals(bitStr(0x03, 1), "00000011")
    assertEquals(bitStr(3, 1), "00000011")

    assertEquals(bitStr(3 << 2, 1), "00001100")

    assertEquals(bitStr(1 | 3, 1), "00000011")

    assert(not isBit(b, 0))
    assertEquals(bitStr(b, 1), "00000000")
    b = setBit(b, 0)
    assert(isBit(b, 0))
    assertEquals(bitStr(b, 1), "00000001")

    assert(not isBit(b, 6))
    b = setBit(b, 6)
    assert(isBit(b, 6))
    assertEquals(bitStr(b, 1), "01000001")

    assertEquals(bitStr(3, 1), "00000011")
    b = 1
    b = setBitInt(b, 4, 2, 3)
    assertEquals(bitStr(b, 1), "00110001")
    assertEquals(3, getBitInt(b, 4, 2))


    b = 0
    b = setBitInt(b, 0, 3, 7)
    assertEquals(bitStr(b, 1), "00000111")
    assertEquals(7, getBitInt(b, 0, 3))

    b = 0
    b = setBitInt(b, 1, 3, 7)
    assertEquals(bitStr(b, 1), "00001110")
    assertEquals(7, getBitInt(b, 1, 3))

    b = 3
    assertEquals(bitStr(b, 1), "00000011")    
    b = setBitInt(b, 0, 2, 0)
    assertEquals(bitStr(b, 1), "00000000")
    assertEquals(0, getBitInt(b, 0, 2))

    assertEquals(bitStr(1, 1), "00000001")
    assertEquals(bitStr(setBitInt(0,0,1,2), 1), "00000010")  
    assertEquals(bitStr(setBitInt(0,0,1,1), 1), "00000001")  

    --b = 0b00000000
    --b = setBitInt(b, 3, 3, 8)

    --assert(bitStr(b, 1) == "00011000", "unexpected " .. bitStr(b,1))
end


testBits()



function assertDirEquals(value, expect) 
    assert(value.equals(expect), "Expected "..tostr(expect.x)..","..tostr(expect.y).." but got "..tostr(value.x)..","..tostr(value.y))
end

function testPosition()
    assertDirEquals(Position.new(0,0), Position.new(0,0))
    assertDirEquals(Position.new(0,0), Position.new(9,9).set(0,0))
    assertDirEquals(Position.new(0,0), Position.new(9,9).set())
    assertDirEquals(Position.new(5,4), Position.new(4,4).copy().move(RIGHT))
end


testPosition()

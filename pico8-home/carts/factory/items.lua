
ITEMS = nil

local ItemType = {}
ItemType.new = function(fields)

  local self = {}
  
  function self.draw(cx, cy, tileFlags)
    drawSprite(fields.sprite, cx, cy)
  end

  return self
end

function initItemTypes() 
    ITEMS = {}
    ITEMS[1] = ItemType.new{ name="egg", sprite=32 }
    ITEMS[2] = ItemType.new{ name="flour", sprite=34 }
    ITEMS[3] = ItemType.new{ name="sugar", sprite=36 }  
end

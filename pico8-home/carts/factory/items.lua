
ITEMS = nil


ITEM_BUTTER = 1
ITEM_FLOUR = 2
ITEM_SUGAR = 3


local ItemType = {}
ItemType.new = function(fields)

  local self = {}
  
  function self.draw(cx, cy, tileFlags)
    drawSprite(fields.sprite, cx, cy)
  end

  function self.getNumber()
    return fields.number
  end

  return self
end

function initItemTypes() 
    ITEMS = {}
    ITEMS[ITEM_BUTTER] = ItemType.new{ number = ITEM_BUTTER, sprite=32 }
    ITEMS[ITEM_FLOUR] = ItemType.new{ number = ITEM_FLOUR, sprite=34 }
    ITEMS[ITEM_SUGAR] = ItemType.new{ number = ITEM_SUGAR, sprite=36 }  
end



ITEMS = nil

ITEM_BUTTER = 1
ITEM_FLOUR = 2
ITEM_SUGAR = 3
ITEM_SPONGE = 4
ITEM_ICING = 5
ITEM_CAKE = 6


local ItemType = {}
ItemType.new = function(fields)

  local self = {}
  
  function self.draw(cx, cy, tileFlags)
    drawSprite(fields.sprite, cx, cy)
  end

  function self.getNumber()
    return fields.number
  end

  function self.getColor()
    return fields.color
  end

  return self
end


function initItemTypes() 
    ITEMS = {}
    ITEMS[ITEM_BUTTER] = ItemType.new{ number = ITEM_BUTTER, sprite=38, color = 10 }
    ITEMS[ITEM_FLOUR]  = ItemType.new{ number = ITEM_FLOUR,  sprite=34, color = 8  }
    ITEMS[ITEM_SUGAR]  = ItemType.new{ number = ITEM_SUGAR,  sprite=36, color = 12 }
    ITEMS[ITEM_SPONGE] = ItemType.new{ number = ITEM_SPONGE, sprite=40, color = 9  }
    ITEMS[ITEM_ICING]  = ItemType.new{ number = ITEM_ICING,  sprite=42, color = 11 }
    ITEMS[ITEM_CAKE]   = ItemType.new{ number = ITEM_CAKE,   sprite=44, color = 7  }
end

RECIPES = {
    { nil, 4,   5,   nil, nil, nil },
    { 4,   nil, nil, nil, nil, nil },
    { 5,   nil, nil, nil, nil, nil },
    { nil, nil, nil, nil, 6,   nil },
    { nil, nil, nil, 6,   nil, nil },
    { nil, nil, nil, nil, nil, nil }        
}

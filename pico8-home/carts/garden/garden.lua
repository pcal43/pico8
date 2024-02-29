-- music(0)

local SNOW_WEIGHT = 2000


npcs = {}
actors = {}
warps = {}
items = {}
inventory = {}
inventorySelection = nil

local inventoryShown = false

function _init()
  -- make player top left
  p1 = add(actors, { x=6, y=5, dx=0, dy=0, frame=0, sprite=0, inertia=.4, t=0 })

  sign = add(actors, { x=9.5, y=6.5, sprite = 122 })
  sign.script = function()
      say([[welcome to the flower garden.
plant as many as you like!]])
  end
  add(npcs, sign)

  wizard = add(actors, { x=103, y=5, sprite=20 })
  wizard.sprite = 20
  wizard.script = function()
    if isSnowing then
      ask("do you believe me now?\nshould i make the snow stop?", "yes", "no")
      if ans == 1 then
        say("all righty! ...")
        say("...")
        say("desistiflurris!!!")
        say("...")
        say("done!  you have a good day now.")
        isSnowing = false
      else
        say("suit yourself!  let is snow\nlet it snow let it snow!!")
      end
    else
      say("my magic controls the weather!\ni can prove it!")
      ask("do you want me to make it snow?", "no", "yes")
      if ans == 1 then
        say("what?!  you don't believe me?\nhow dare you!?")
      else
        say("ok! ... ... \n ... um.  ...")
        say("...")
        say("nivis ... \n... glacio ...")
        say("...\n      ...")
        say("frosty ... \n... frostum ...")
        say("...")
        say("there!  go see for yourself!")
        isSnowing = true
      end
    end
  end
  add(npcs, wizard)
end

add(warps, { 8, 4, 102, 11 })
add(warps, { 102, 12, 8, 5 })
add(warps, { 103, 12, 8, 5 })

--add(items, { name = "firewood", sprite = 3, x = 8, y = 7 })
--add(items, { name = "matches", sprite = 4, x = 2, y = 9 })


add(inventory, { name = "rose", sprite = 48 })
add(inventory, { name = "hydrangea", sprite = 49  })
add(inventory, { name = "carnation", sprite = 50  })
add(inventory, { name = "mushroom", sprite = 51  })
add(inventory, { name = "shovel", sprite = 5  })
inventorySelection = 1

local mloc = {}
mloc.x = 0
mloc.y = 0
local t = 0

isSnowing = false
timeOfDay = 2


function isOnMapSquare(ax, ay, mx, my)
  return ax >= mx and ax <= mx + 0.99 and ay >= my and ay <= my + 0.99
end

function _update()
  if not script_active then
    if inventoryShown then
      if count(inventory) > 0 then
        if (not inventorySelection) inventorySelection = 1
        if (btnp(2)) inventorySelection = (inventorySelection or 0) - 1
        if (btnp(3)) inventorySelection = (inventorySelection or 0) + 1
        inventorySelection = (inventorySelection - 1) % count(inventory) + 1 // ficking 1-based
      end
      if (btnp(5)) inventoryShown = false
    else
      accel = 0.1
      if (btn(0)) p1.dx -= accel
      if (btn(1)) p1.dx += accel 
      if (btn(2)) p1.dy -= accel 
      if (btn(3)) p1.dy += accel 
      if (btnp(5)) inventoryShown = true      
      if (btnp(4)) then
        if not tryNpcInteraction(p1) and inventorySelection then 
          local inv = inventory[inventorySelection].sprite
          if inv == 5 then -- shovel
            if fget(mget(p1.x, p1.y), 0) then -- if its a flower
              mset(p1.x, p1.y, 119) -- place a lump there
            end
          elseif inv >= 48 and inv <= 52 then -- flowers
            if fget(mget(p1.x, p1.y), 2) then  -- if ok to plant
              mset(p1.x, p1.y, inv)
            end
          else
            printh("Unknown inventory item " .. tostr(inv))
          end
        end
      end
    end
  end

  movePlayer(p1)

  if p1.dx or p1.dy then
    for i = #items, 1, -1 do
      if isClose(p1, items[i]) then
        add(inventory, items[i])
        text = "picked up " .. items[i].name
        deli(items, i)
        if not inventorySelection then inventorySelection = count(inventory) end
      end
    end
    for warp in all(warps) do
      if isOnMapSquare(p1.x, p1.y, warp[1], warp[2]) then
        p1.x = warp[3] + .5
        p1.y = warp[4] + .5
        break
      end
    end
  end

  -- update the map location
  mloc.x = flr(p1.x / 16)
  mloc.y = flr(p1.y / 16)

  t += 1

  if script_active then
    script_update()
  end
end


function isPlayerInNpcRange(x, y)
  local hx, hy = hero.x, hero.y
  return x - 1 == hx and y == hy
      or x + 1 == hx and y == hy
      or x == hx and y - 1 == hy
      or x == hx and y + 1 == hy
end

-- attempt to run a script
-- if hero is near npc
function tryNpcInteraction(pl)
  for npc in all(npcs) do
    if npc.script and isClose(p1, npc) then
      script_run(npc.script)
      print("wah")
      return true
    end
  end
  return false
end

function isClose(o1, o2)
  return abs(o1.x - o2.x) < 1 and abs(o1.y - o2.y) < 1
end

function drawSprite(s)
  local sx = s.x * 8 - 4 - mloc.x * 128
  local sy = s.y * 8 - 4 - mloc.y * 128
  spr(s.sprite + (s.frame or 0), sx, sy)
end

function get_npc_at(x, y)
  for t in all(npcs) do
    if abs(x - t.x) < 0.6 and abs(y - t.y) < 0.6 then
      return t
    end
  end
end

-- for any given point on the
-- map, true if there is wall
-- there.

function solid(x, y)
  if get_npc_at(x, y) then return true end

  -- grab the cell value
  val = mget(x, y)

  -- check if flag 1 is set (the
  -- orange toggle button in the
  -- sprite editor)
  return fget(val, 1)
end

-- solid_area
-- check if a rectangle overlaps
-- with any walls

--(this version only works for
--actors less than one tile big)

function solid_area(x, y, w, h)
  return solid(x - w, y - h)
      or solid(x + w, y - h)
      or solid(x - w, y + h)
      or solid(x + w, y + h)
end

function movePlayer(a)
  -- only move actor along x
  -- if the resulting position
  -- will not overlap with a wall
  if not solid_area(
    a.x + a.dx,
    a.y, (a.w or 0.3), (a.h or 0.3)
  ) then
    a.x += a.dx
  end

  -- ditto for y

  if not solid_area(
    a.x,
    a.y + a.dy, (a.w or 0.3), (a.h or 0.3)
  ) then
    a.y += a.dy
  end

  -- apply inertia
  -- set dx,dy to zero if you
  -- don't want inertia

  a.dx *= a.inertia
  a.dy *= a.inertia

  -- advance one frame every
  -- time actor moves 1/4 of
  -- a tile

  a.frame += abs(a.dx) * 4
  a.frame += abs(a.dy) * 4
  a.frame %= 2
  -- always 2 frames

  a.t += 1
end

glyphs = { "\139", "\145", "\148", "\131", "\142", "\151" }
function _draw()
  cls()
  local isOutside = p1.x < 16

  t = t + 1
  if isOutside then set_time_palette(flr(t / 300) % 6) end
  map(mloc.x * 16, mloc.y * 16, 0, 0)

  foreach(items, drawSprite)
  foreach(actors, drawSprite)

  if isSnowing then
    if isOutside then drawSnow(SNOW_WEIGHT) end
    accumulate_snow(SNOW_WEIGHT)
  end
  --  drawControlStatus()
  if text then
    rectfill(2, 107, 125, 125, 0)
    print(text, 3, 108, text_color)
  end
  if responses then
    local top = 101 - 6 * #responses
    rectfill(
      70, top,
      125, 105, 0
    )
    for i = 1, #responses do
      print(
        responses[i],
        72, top + i * 6 - 4,
        i == ans and 7 or 5
      )
    end
  end
  pal()

  local BORDER = 2
  local ITEM_PADDING = 1
  local SCREEN_EDGE_PADDING = 1

  rectfill(SCREEN_EDGE_PADDING, SCREEN_EDGE_PADDING, 
  SCREEN_EDGE_PADDING + BORDER + ITEM_PADDING + 8 + ITEM_PADDING + BORDER-1, 
  SCREEN_EDGE_PADDING + BORDER + ITEM_PADDING + 8 + ITEM_PADDING + BORDER-1, 1)
  rectfill(SCREEN_EDGE_PADDING + BORDER, SCREEN_EDGE_PADDING + BORDER, 
  SCREEN_EDGE_PADDING + BORDER + ITEM_PADDING + 8 + ITEM_PADDING-1, 
  SCREEN_EDGE_PADDING + BORDER + ITEM_PADDING + 8 + ITEM_PADDING-1, 0)

  if (inventorySelection) spr(inventory[inventorySelection].sprite or 0, SCREEN_EDGE_PADDING + BORDER + ITEM_PADDING, SCREEN_EDGE_PADDING + BORDER + ITEM_PADDING)

  if inventoryShown then
    local ARROW_SPRITE = 31
    rectfill(30, 30, 128 - 30, 128 - 30, 1)
    rectfill(32, 32, 128 - 32, 128 - 32, 0)
    local y = 32 + BORDER
    for i, inv in ipairs(inventory) do
      local x = 32 + BORDER
      if i == inventorySelection then
        spr(ARROW_SPRITE, x, y)
      end
      x += 8 + BORDER
      spr(inv.sprite, x, y)
      x += 8 + BORDER
      print(inv.name, x, y + 8 - 6, 0x07)
      y += 8 + BORDER
    end
  end
end


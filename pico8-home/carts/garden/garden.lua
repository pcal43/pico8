-- NPCS
-- https://www.lexaloffle.com/bbs/?tid=3833

-- music(0)


npcs = {}    -- people the player can talk to

warps = {}


add(warps,  {8, 4, 22, 11})
add(warps,  {22, 12, 8, 5})
add(warps,  {23, 12, 8, 5})


local mloc={}
mloc.x = 0
mloc.y = 0
local t=0

isSnowing = false


actors = {} --all actors in world

-- make an actor
-- and add to global collection
-- x,y means center of the actor
-- in map tiles (not pixels)
function make_actor(x, y)
 a={}
 a.x = x
 a.y = y
 a.dx = 0
 a.dy = 0
 a.spr = 16
 a.frame = 0
 a.t = 0
 a.inertia = 0.4
 a.bounce  = 1
 
 -- half-width and half-height
 -- slightly less than 0.5 so
 -- that will fit through 1-wide
 -- holes.
 a.w = 0.3
 a.h = 0.3
 
 add(actors, a)
 
 return a
end


function _init()
  -- make player top left
  p1 = make_actor(6,5)
  p1.spr = 0


  sign = make_actor(9.5, 6.5)
  sign.spr = 122
  sign.script = function ()
    say [[welcome to the flower garden.
plant as many as you like!]]
  end
  add(npcs, sign)

  wizard = make_actor(23,5)
  wizard.spr = 20
  wizard.script = function() 
    if (isSnowing) then
      ask("do you believe me now?\nshould i make the snow stop?", "yes", "no")
      if ans==1 then
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
      ask("do you want me to make it snow?","no", "yes")
        if ans==1 then
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


function isOnMapSquare(ax, ay, mx, my) 
  return ax >= mx and ax <= mx+0.99 and ay >= my and ay <= my+0.99
end


function _update()
  control_player(p1)
  foreach(actors, move_actor)

  for warp in all(warps) do
    if isOnMapSquare(p1.x, p1.y, warp[1], warp[2]) then
      p1.x = warp[3] + .5
      p1.y = warp[4] + .5
      break
    end
  end  
  check_map_change(p1)


  check_map_change(p1)
  t += 1

	if script_active then
		script_update()
	end

  --[[
  if (t % 4 == 0) then
    shiftSprite(48, 1, 0)
    shiftSprite(49, -1, 0)
    shiftSprite(50, 0, 1)
    shiftSprite(51, 0, -1)
  end
  ]]--

  --sset(t % 16, t %13, t%16)
end




function control_player(pl)
	if script_active then
		-- player can't move if there
		-- is any running script
		return
	end

  -- how fast to accelerate
  accel = 0.1
  if (btn(0)) pl.dx -= accel 
  if (btn(1)) pl.dx += accel 
  if (btn(2)) pl.dy -= accel 
  if (btn(3)) pl.dy += accel 

  if (btn(4)) plant_flower(pl)
  if (btn(5)) removeFlower(pl)
 
  -- play a sound if moving
  -- (every 4 ticks)
  
  if (abs(pl.dx)+abs(pl.dy) > 0.1 and (pl.t%4) == 0) then
   -- sfx(1)
  end
  
 end


 function plant_flower(player)
  if tryNpcInteraction(player) then return end
  local cur = mget(player.x, player.y)
  if fget(cur, 2) then
      local spr = 4 + rnd(4)
      mset(player.x, player.y, spr)
  end
end
  
function removeFlower(player)
  local cur = mget(player.x, player.y)
  if (fget(cur,0)) then
      mset(player.x, player.y, 119)
  end
end
  
function isPlayerInNpcRange(x,y)
	local hx,hy = hero.x,hero.y
	return (x-1 == hx and y == hy)
	    or (x+1 == hx and y == hy)
	    or (x == hx and y-1 == hy)
	    or (x == hx and y+1 == hy)
end

-- attempt to run a script
-- if hero is near npc
function tryNpcInteraction(pl)
	for npc in all(npcs) do
		if npc.script and abs(pl.x - npc.x) < 1 and abs(pl.y - npc.y) < 1 then
        script_run(npc.script)
        print("wah")
        return true
		end
	end
  return false
end

function draw_actor(a)
  local sx = (a.x * 8) - 4 - (mloc.x * 128)
  local sy = (a.y * 8) - 4 - (mloc.y * 128)
  spr(a.spr + a.frame, sx, sy)
 end

function get_npc_at(x,y)
	for t in all(npcs) do
		if abs(x-t.x) < 0.6 and abs(y-t.y) < 0.6 then
			return t
		end
	end
end

-- for any given point on the
-- map, true if there is wall
-- there.

function solid(x, y)
  if get_npc_at(x,y) then return true end

  -- grab the cell value
  val=mget(x, y)
  
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
 
 function solid_area(x,y,w,h)
 
  return 
   solid(x-w,y-h) or
   solid(x+w,y-h) or
   solid(x-w,y+h) or
   solid(x+w,y+h)
 end
 
 function move_actor(a)
 
  -- only move actor along x
  -- if the resulting position
  -- will not overlap with a wall
 
  if not solid_area(a.x + a.dx, 
   a.y, a.w, a.h) then
   a.x += a.dx
  end
 
  -- ditto for y
 
  if not solid_area(a.x, 
   a.y + a.dy, a.w, a.h) then
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
  a.frame %= 2 -- always 2 frames
 
  a.t += 1
 
end


function check_map_change(p1)
  if (p1.x < mloc.x * 16) then
    mloc.x -= 1 
  elseif (p1.x > (mloc.x + 1) * 16) then
    mloc.x += 1 
  end
  if (p1.y < (mloc.y * 16)) then
    mloc.y -= 1 
  elseif (p1.y > (mloc.y + 1) * 16) then
    mloc.y += 1 
  end
end


glyphs={"\139","\145","\148","\131","\142","\151"}
function _draw()
    cls()
    map(mloc.x * 16, mloc.y * 16, 0, 0)  
    foreach(actors, draw_actor)
    if (isSnowing and p1.x < 16) then drawSnow(500) end
--  drawControlStatus()
    if text then
      rectfill(2,107,125,125,0)
      print(text, 3,108, text_color)
    end
    if responses then
      local top = 101 - 6 * #responses
      rectfill(70, top,
              125, 105, 0)
      for i=1, #responses do
        print(responses[i],
              72, top + i*6-4,
              i==ans and 7 or 5)
      end
    end

end


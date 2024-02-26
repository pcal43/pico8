pico-8 cartridge // http://www.pico-8.com
version 41
__lua__
-- ★ aSCENT ★
-- BY @jOHANpEITZ
-- AUDIO BY @vAVmUSICmAGIC
-- FOR lOWrEZ jAM 2022

-- ★ CHANGELOG V1.1 (POST JAM)
-- added more particles here and there
-- added additional ending
-- tweaked existing ending
-- changed dash to be 0G
-- changed some texts
-- adjusted tiles at several places to read better
-- fixed typos

-- ★ CHANGELOG V1.0 (JAM VERSION)
-- all the things


-- debug=true
function _init()
	-- go into 64x64
	poke(0x5f2c, 3)
	poke(0x5f2c, 3)
	
 -- keep palette 
 poke(0x5f2e,1)
 reset_pal()

 -- font
 poke(0x5600,unpack(split"6,8,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,63,63,63,63,63,63,63,0,0,0,63,63,63,0,0,0,0,0,63,51,63,0,0,0,0,0,51,12,51,0,0,0,0,0,51,0,51,0,0,0,0,0,51,51,51,0,0,0,0,48,60,63,60,48,0,0,0,3,15,63,15,3,0,0,62,6,6,6,6,0,0,0,0,0,48,48,48,48,62,0,99,54,28,62,8,62,8,0,0,0,0,24,0,0,0,0,0,0,0,0,0,12,24,0,0,0,0,0,0,12,12,0,0,0,10,10,0,0,0,0,0,4,10,4,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,1,0,0,0,5,5,0,0,0,0,0,0,0,0,1,0,0,0,0,0,14,17,21,17,14,0,0,0,1,4,2,1,4,0,0,0,0,5,7,2,0,0,0,0,1,1,0,0,0,0,0,0,2,1,1,1,2,0,0,0,1,2,2,2,1,0,0,0,0,5,2,5,0,0,0,0,0,2,7,2,0,0,0,0,0,0,0,0,1,1,0,0,0,0,7,0,0,0,0,0,0,0,0,0,1,0,0,0,4,4,2,2,1,1,0,0,2,5,5,5,2,0,0,0,2,3,2,2,2,0,0,0,3,4,2,1,7,0,0,0,3,4,2,4,3,0,0,0,5,5,7,4,4,0,0,0,7,1,3,4,3,0,0,0,2,1,3,5,2,0,0,0,7,4,4,2,2,0,0,0,2,5,2,5,2,0,0,0,2,5,6,4,2,0,0,0,0,0,1,0,1,0,0,0,0,0,1,0,1,1,0,0,4,2,1,2,4,0,0,0,0,7,0,7,0,0,0,0,1,2,4,2,1,0,0,0,3,4,2,0,2,0,0,0,2,5,5,1,6,0,0,0,0,6,5,5,6,0,0,0,1,3,5,5,3,0,0,0,0,6,1,1,6,0,0,0,4,6,5,5,6,0,0,0,0,2,7,1,2,0,0,0,2,1,1,3,1,1,0,0,0,6,5,7,4,3,0,0,1,3,5,5,5,0,0,0,1,0,1,1,1,0,0,0,2,0,2,2,2,1,0,0,1,5,3,5,5,0,0,0,1,1,1,1,1,0,0,0,0,15,21,21,21,0,0,0,0,3,5,5,5,0,0,0,0,2,5,5,2,0,0,0,0,3,5,5,3,1,0,0,0,6,5,5,6,4,0,0,0,5,3,1,1,0,0,0,0,3,1,2,3,0,0,0,1,3,1,1,2,0,0,0,0,5,5,5,6,0,0,0,0,5,5,5,2,0,0,0,0,17,21,21,10,0,0,0,0,5,2,2,5,0,0,0,0,5,5,6,4,3,0,0,0,15,4,2,15,0,0,0,3,1,1,1,3,0,0,0,1,1,2,2,4,4,0,0,3,2,2,2,3,0,0,0,2,5,0,0,0,0,0,0,0,0,0,0,7,0,0,0,1,2,0,0,0,0,0,0,2,5,5,7,5,0,0,0,3,5,3,5,3,0,0,0,6,1,1,1,6,0,0,0,3,5,5,5,3,0,0,0,7,1,3,1,7,0,0,0,7,1,1,3,1,0,0,0,6,1,1,5,6,0,0,0,5,5,7,5,5,0,0,0,1,1,1,1,1,0,0,0,2,2,2,2,2,1,0,0,5,5,3,5,5,0,0,0,1,1,1,1,7,0,0,0,17,27,21,17,17,0,0,0,3,5,5,5,5,0,0,0,2,5,5,5,2,0,0,0,3,5,5,3,1,0,0,0,2,5,5,5,2,4,0,0,3,5,5,3,5,0,0,0,6,1,2,4,3,0,0,0,7,2,2,2,2,0,0,0,5,5,5,5,6,0,0,0,5,5,5,5,2,0,0,0,17,17,21,27,17,0,0,0,5,5,2,5,5,0,0,0,5,5,5,6,4,2,0,0,7,4,2,1,7,0,0,0,2,2,2,7,2,0,0,0,1,1,1,1,1,1,0,0,0,7,7,7,2,0,0,0,5,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,127,127,127,127,127,127,127,0,85,42,85,42,85,42,85,0,65,99,127,93,93,119,62,0,62,99,99,119,62,65,62,0,17,68,17,68,17,68,17,0,4,12,124,62,31,24,16,0,28,38,95,95,127,62,28,0,34,119,127,127,62,28,8,0,42,28,54,119,54,28,42,0,62,15,15,6,0,0,0,0,8,28,62,127,62,42,58,0,62,103,99,103,62,65,62,0,62,127,93,93,127,99,62,0,24,120,8,8,8,15,7,0,62,99,107,99,62,65,62,0,8,20,42,93,42,20,8,0,0,0,0,85,0,0,0,0,62,115,99,115,62,65,62,0,8,28,127,28,54,34,0,0,127,34,20,8,20,34,127,0,62,119,99,99,62,65,62,0,0,10,4,0,80,32,0,0,17,42,68,0,17,42,68,0,62,107,119,107,62,65,62,0,127,0,127,0,127,0,127,0,85,85,85,85,85,85,85,0")) 
 poke(0x5f58,0x81)

 -- kerning
 kerning={}
 local kdata=split"(=1,)=1,Z=-1,j=1,J=1,.=2,w=-2,W=-2,m=-2,M=-2,S=1,W=-2,'=2,T=1,I=2, =2,i=2,L=2,F=1,➡️=-4,⬅️=-4,⬆️=-4,⬇️=-4,🅾️=-4,❎=-4,:=2"
 for pair in all(kdata) do
  local kv=split(pair,"=")
  kerning[kv[1]]=kv[2]
 end  
 
 fade_progress=1
 fade_pal={
	 0,0,1,14,
	 2,1,13,6,
	 4,4,9,15,
	 13,5,1,3
 }

 particles1={}
 particles2={}
 entities={}
 
 tips={}
 
 -- scan map
 rooms={}
 for ry=0,3 do
  for rx=0,15 do
   rooms[rx+ry*16]={}
   local r=rooms[rx+ry*16]
   for tx=0,7 do
    for ty=0,7 do
     local x=rx*8+tx
     local y=ry*8+ty
     local ▒=mget(x,y)
     local e=parse_tile(▒,x,y)
     if e and ▒!=64 then
      add(r,{▒=▒,x=x,y=y})
      del(entities,e)
     end
    end
   end
  end
 end
 
 -- timer
 ticks=0
 lore_count=0
   
 -- put player on top
 add(entities,del(entities,pl))
 -- start collapsed
 pl.state=2
 pl.collapsed_cooldown=60
 set_anim(pl,{71})
 pl.fs=40
 
 -- camera
 shakex,shakey=0,0
 set_cam(64*(pl.x\64),64*(pl.y\64))

end

function parse_tile(▒,x,y)
 if ▒==64 then
  pl=make_player(x*8+4,y*8+5) 
  mset(x,y,0)
 end
 if ▒==183 then
  make_outro(x*8+4,y*8+4) .on_draw=nil 
  mset(x,y,0)
 end
 if ▒==94 then
  make_fan(x*8+4,y*8+4).on_draw=nil 
  mset(x,y,0)
 end
 if ▒==121 then
  make_lorb(x*8+4,y*8+4) 
  mset(x,y,0)
 end
 if ▒==116 then
  mset(x,y,0)
  make_vines(x*8+4,y*8+4) 
 end
 if ▒==80 then
  mset(x,y,0)
  return make_blob(x*8+4,y*8+6) 
 end
 if ▒==197 then
  mset(x,y,0)
  make_twinkle(x*8+4,y*8+4) 
 end
 if ▒==88 then
  mset(x,y,0)
  make_mushroom(x*8+4,y*8+4) 
 end
 if ▒==96 then
  mset(x,y,0)
  make_checkpoint(x*8+4,y*8+4) 
 end
 if ▒==98 then
  mset(x,y,0)
  return make_bearpig(x*8+4,y*8+4) 
 end
 if ▒==145 then
  make_upgrader(x*8+4,y*8+7) 
 end
 if ▒==148 then
  make_pod(x*8+4,y*8+7) 
 end

 ⧗=0
 intro=20

end

function swap_room(rx,ry)
 -- remove olds
 for e in all(room_entities) do
  del(entities,e)
 end

 -- add news
 local r=rooms[rx+ry*16]
 room_entities={}
 for e in all(r) do
  local ee=parse_tile(e.▒,e.x,e.y)
  if (ee) add(room_entities,ee)
 end
end

function set_cam(cx,cy)
 camtx,camty=cx,cy
 camx,camy=camtx,camty
end


function speak(lines)
 speech_page=1
 speech=lines
end

function _update()
 ⧗+=1
 if ⧗>32000 then
  ⧗-=32000
 end
 
 -- handle speech bubble
 if lore_count>0 and lore_count<100 then
  lore_count+=1
 end
 
-- if (btnp(3,1)) debug=not debug
	
 if fade_progress>0 then
  fade_progress-=0.075
 end	
	
	if camx==camtx and camy==camty then
	 update_particles(particles1)
	 update_particles(particles2)
	
	 if speech then
	  if btnp(❎) then
	   sfx(52)
		  speech_page+=1
		  if speech_page>#speech then
		   speech=nil
		   lore_reply=nil
		  end
		 end
	 elseif active_lore then
	  if btnp(❎) then
	   sfx(52)
	   active_lore=false
   end
	 else
	 
	  if intro<0 and ⧗%30==0 and not outro then
 	  ticks+=1
	  end
	   
			if outro then
		  update_outro()
		 else
			 get_input(pl)
		 end
		 	
			for e in all(entities) do
		  e.on_update(e)
		 end
		 
		 for e in all(entities) do
		  if e.on_hit_player then
		   if aabb(e,pl) then
		    e.on_hit_player(e)
		   end
		  end
		 end
		end
 
 end

 local ocx,ocy=camtx,camty

 camtx=min(960,max(0,64*(pl.x\64)))
 camty=min(192,max(0,64*(pl.y\64)))
 camx+=4*ssgn(camtx-camx)
 camy+=4*ssgn(camty-camy)
 
 if ocx!=camtx or ocy!=camty then
  swap_room(camtx\64,camty\64)
 end
 
 if intro!=20 and intro>-32 then
  intro-=1
 end
 
 if intro==20 and btnp(🅾️) then
  set_anim(pl,{71,72})
  pl.fs=60
  intro=19
  music(0)
 end

 -- desert storm 
 for i=1,4 do
	 spawn_sand(
	  -1,192+rnd(48)+24,
	  rnd(3)+1
	 )
 end
 
end


function _draw()
 cls()
 
 -- fancy bg effects 
 if outro_step==2 then
  local cols=split"0,1,0,0,0,0,0,0,0,1,0,0,0,0,1,1,1,1"
  local c=cols[outro%#cols+1]
  cls(c)
 elseif outro_step==3 then
  local cols={7,6,12,13,12,6,7}
  local c=cols[outro%#cols+1]
  cls(c)
 end
 
 -- show last screen 
 if outro_step==5 then
  prc("sPIRITS SAVED",32,10,12,5)
  prc(pl.lore.."/8", 32, 18, 12,5)

	 prc("tIME PLAYED",32,30,12,5)
	 local mins=ticks\60
	 local secs=ticks-mins*60
	 prc(mins..":"..(secs>9 and "" or "0")..secs,32,38,12,5)

  prc("tHANKS FOR PLAYING",32,50,7,13)
 else
	 -- render game 
	 
	 -- override some stuff

	 camera(camx+shakex,camy+shakey)
		shakex,shakey=0,0
			
		if not debug then
	 	map()
		else
		 -- debug map (flags)
		 local tx,ty=camx\8,camy\8
		 for y=0,7 do
	 	 for x=0,7 do
		   local tile=mget(tx+x,ty+y)
		   local flag=fget(tile)
		   if flag>0 then
	 	   local px,py=x*8+camx,y*8+camy
		    rect(px,py,px+7,py+7,flag+7)
		   end
		  end
		 end
		end
		
		-- particles
	 for p in all(particles1) do
	  if (p.on_draw) p.on_draw(p) 
	 end
	 
	 -- entities
	 for e in all(entities) do
	  if (e.on_draw) e.on_draw(e)
	 end
	
	 for p in all(particles2) do
	  if (p.on_draw) p.on_draw(p) 
	 end
	
	 
	 -- hud
	 camera()
	 
	 if speech then
	  local txt=speech[speech_page]
	  local w,h=tlen(txt)
	  local x=max(2,min(58-w,pl.x-w/2-camx))
	  local y=max(2,pl.y-h*8-16-camy)
	  rectfill(x,y-1,x+w,y+h*5+3,7)
	  rectfill(x-1,y,x+w+1,y+h*5+2,7)
	  local cx,cy=x+w/4,y
	  for i=-6,6 do  
	   line(pl.x-3-camx,pl.y-8-camy,cx+i,y,7)
	  end
	  pr(txt,x+1,y,1,6)
	  
	  spr(126+sin(t()),x+w,y+h*5-1)
	 end 
	 
	 if active_lore then
	  local loreid=pl.lore
	  if (outro_step==2) loreid=9
	  if (outro_step==4) loreid=pl.lore==8 and 12 or 10
	  if (outro_step==2.5) loreid=11
	  draw_lore(loreid)
	 end
	 
	
	 -- debug
	 if debug then
	  local mins=ticks\60
	  local secs=ticks-mins*60
	  pr(mins..":"..(secs>9 and "" or "0")..secs,1,1,7)
	 end
	 
	 if intro>-30 then
	  spr(187,12,intro,5,1)
	  
	  local page=⧗%200
	  if page<50 then
	   pr("pEITZ",39,76-intro,14) 
	   pr("BY jOHAN pEITZ",8,77-intro,4,1) 
	  elseif page<100 then
	   pr("(Z) TO START",12,77-intro,6,1) 
	  elseif page<150 then
	   pr("aUDIO BY vAV",10,77-intro,4,1) 
	  elseif page<200 then
	   pr("(Z) TO START",12,77-intro,6,1) 
	  end
	 end
 end
 
 update_fade()
 
-- if (not debug) print(outro,1,1,8)
end

-->8
-- helpers

function _mget(x,y)
 if (y<0 or y>31) return 0
 return mget(x,y)
end

function add_params(src,dst)
 for k,v in pairs(src) do
  dst[k]=v
 end
end

function ssgn(x)
 if(x==0) return 0
 return sgn(x)
end

function aabb(e1,e2)
 if (e1.x+e1.w/2<e2.x-e2.w/2) return false
 if (e2.x+e2.w/2<e1.x-e1.w/2) return false
 if (e1.y+e1.h/2<e2.y-e2.h/2) return false
 if (e2.y+e2.h/2<e1.y-e1.h/2) return false
 return true
end

function prc(str,x,y,c1,c2)
 pr(str,x-tlen(str)/2,y,c1,c2)
end

function pr(str,x,y,c1,c2)
 local x0=x
 for i=1,#str do
  local char=sub(str,i,i)
  if char=="\n" then
   x0=x
   y+=6
  elseif char=="&" then
   c1=7
  elseif char=="#" then
   c1=13
   c2=nil
  else
	  if c2 then
	   print(char,x0,y+1,c2)
	  end
	  print(char,x0,y,c1)
	  x0+=4
	  if kerning[char] then
	   x0-=kerning[char]
	  end
	 end
 end
end

function tlen(str)
 local len,max_len,lines=0,0,1
 for i=1,#str do
  local c=sub(str,i,i)
  if c=="\n" then
   if len>max_len then
    max_len=len
    len=0
    lines+=1
   end
  elseif c=="#" or c=="&" then
   -- do nothing
  else
   len+=4
   if kerning[c] then
    len-=kerning[c]
   end  
  end
 end
 
 return max(max_len,len),lines
end


function reset_pal()
 pal()
 pal(14,131,1)	
 pal(15,139,1)	
end


function decrease(e,p)
 if e[p]>0 then
  e[p]-=1
 end
end


function update_fade()
 for i=0,15 do
  local col,k=i,6*fade_progress
  for j=1,k do
   col=fade_pal[col+1]
  end
  if (col==14) col=131
  if (col==15) col=139
  
  pal(i,col,1)
 end
end

function fadeout()
 while fade_progress<1 do
  fade_progress=min(fade_progress+0.05,1)
  update_fade()
  flip()
 end
end

-->8
-- entities 


-- create and add entity
function make_entity(params)
 local e={
  ⧗ = 0,
  dx=0,dy=0, -- delta movement
  ix=1,iy=1,
  w=8,h=8,
  inair_frames=0,
  visible=true,
  
  lastty=-1,
  g=0,
  
  hp=1,
   
  spr = 0, 
  sw=8,sh=8,
  tw = 1, 
  th = 1,
  
  frame = 1,
  frames = {1},
  fs = 4,
  fc=0,
  
  dir = 1,
  collide=true,
  cd={},
  
  on_draw = draw_entity,
  on_update = update_entity,
  on_air = entity_air,
  on_hit_floor = entity_hit_floor,
  on_hit_ceiling = entity_hit_ceiling,
  on_hit_wall = entity_hit_wall,
--  on_hit_entity = entity_hit_entity
 } 
 
 add_params(params,e)
 
 return add(entities,e)
end

function set_anim(e,frames,loop)
 if (e.frames==frames) return
 
 e.frames=frames
 e.frame=1
 e.fc=0
 e.fs=4
 e.anim_loop=loop
end

function update_entity_x(e)
 e.x += e.dx
 e.dx *= e.ix
end

function update_entity_y(e)
 if e.inair or not e.collide then
  e.y += e.dy
  
  e.dy=min(8,e.dy+e.g)
  
  e.dy *= e.iy
 end
end

function update_entity(e)
 e.⧗ += 1

 -- clear collision data
 e.cd={}

 -- store old values
 e.odx=e.dx
 e.ody=e.dy
 
 e.ox2=e.ox
 e.oy2=e.oy
 e.ox=e.x
 e.oy=e.y
 
 -- collide with world
 update_entity_x(e)

 if e.collide then
  if collide_side(e) then
   if (e==anchor) connect_anchor()
   e.on_hit_wall(e)
  end
 
  -- store last tile y
  e.lastty=flr((e.y+(e.h/2)-0.01)/8)
 end
 
  update_entity_y(e)
 if e.collide then
  if collide_floor(e) then
   if (e==anchor) connect_anchor()

   if e.inair==true  then
    e.on_hit_floor(e)
   end
   e.inair=false
  else 
   if e.inair==false and e.dy==0 then
    if should_fall(e) then
     if e.inair==false then
      e.on_air(e)
     end
     e.inair=true
    end
   else
    if e.inair==false then
     e.on_air(e)
    end
    e.inair=true
   end
   
  end

  if collide_roof(e) then
   if (e==anchor) connect_anchor()

   e.on_hit_ceiling(e)
  end
  
 end
  
 if e.inair then
  e.inair_frames+=1
 else
  e.inair_frames=0
 end

 update_entity_anim(e)
 
end

function update_entity_anim(e)
 if not e.anim_pause then
  e.fc+=1
 end
 
 if e.fc==e.fs then
  e.fc=0
  e.frame+=1
  if e.frame>#e.frames then
   if e.anim_loop then
    e.frame=1
   else
    e.frame=#e.frames
   end
  end
 end
 
end


function draw_entity(e)
 if (not e.visible) return
 
 if debug then
  local x = e.x - e.w/2
  local y = e.y - e.h/2
  rect(x,y,x+e.w-1,y+e.h-1, e.inair and 8 or 11)
  
  -- collisions
  if e.cd.left then
   line(x,y,x,y+e.h-1,7)
  end
  if e.cd.right then
   line(x+e.w-1,y,x+e.w-1,y+e.h-1,7)
  end
  if e.cd.up then
   line(x,y,x+e.w-1,y,7)
  end
  if e.cd.down then
   line(x,y+e.h-1,x+e.w-1,y+e.h-1,7)
  end

--  if (e.reset_count) pr(""..e.reset_count,e.x-4,e.y-9,7)
  if (e.state) pr(""..e.state,e.x-4,e.y-9,7)
 
--  if e.name then
--   print(e.name.."/"..e.dx,e.x-8,e.y-24,7)
--  end
--  
 elseif e.visible then
	 spr(e.frames[e.frame],
	  e.x - e.sw/2, 
	  e.y - e.sh/2, 
	  e.tw, e.th,
	  e.dir==-1)
 end
  
end

function entity_hit_floor(e)
 if e.state==4 then
  -- ladder to normal
  e.state=0
 else
	 for i=0,e.ody/2 do
	  spawn_dust(e.x,e.y+e.h/2-2,
	             i-e.ody/4)
	 end
 end
 
end

function landing_dust(e)
end

function entity_hit_ceiling(e)
end

function entity_hit_wall(e)
end

function entity_air(e)
end

-->8
-- player
player_walk_anim={67,64,65,66}


function make_player(px,py) 
 player_g=0.35
 player_f=2.2
 return make_entity({
  name="player",
  hp=1,
  max_hp=1,
  lore=0,
  
  x=px,y=py,
  g=player_g,
  ix=0,
  w=4, h=6, sh=10,
  canjump=false,
  
  -- state 0 = free
  -- state 1 = ledge
  -- state 2 = collapsed
  -- state 3 = hit
  -- state 4 = ladder
  state=0,
  ledge_cooldown=0,
  collapsed_cooldown=0,
  hit_cooldown=0,
  ladder_cooldown=0,
  rush_cooldown=0,
  jump_cooldown=0,
  jump_cooldown=0,
  reset_count=60,
    
  on_input = get_input,
  on_update = update_player,
  on_draw = draw_player,
  on_air = player_air,
  on_hit_floor = player_hit_floor,
  on_hit_wall = player_hit_wall,
  on_hit= player_hit,
  on_fall= function(e)
   if e.rushing then
    if e.rush_g == player_g then
     e.rush_g=0
    end
   else
    if e.state!=4 then
	    set_anim(e,{78})
	   end
	  end
  end,
  
  rush_count=0,
  
  -- cheats
--  upg_grab=true,
--  upg_stomp=true,
--  upg_vines=true,
--  upg_scale=true,
--  upg_rush=true,

 },entities)
end


function get_input(e)
 if e.state==0 then
  -- normal movement
  
--  if btnp(❎) then
--   speak({"mMM...\nuPDATES..."})
--  end
  
  if e.upg_rush and 
     btnp(❎) and 
     e.rush_cooldown==0 and 
     e.rush_count==0 then
   sfx(62)
   e.dy=0
   e.rushing=true
   e.rush_count=8
   e.rush_cooldown=30
   
   if e.inair then
    e.rush_g=0
   else
    e.rush_g=player_g
   end
  end
	 
	 if e.rushing then
   -- full speed ahead
   e.dx=3*e.dir
	 else
	  if not e.stomped then
		  -- player decides
			 if btn(⬅️) then 
		   e.dx-=1
			  e.dir=-1
			 end
			 if btn(➡️) then
		   e.dx+=1
			  e.dir=1
			 end
			end
	 end
	 
	 if not e.inair then
	  set_anim(e,
	   abs(e.dx)>0.1 and player_walk_anim or {64},
	   true)
	   
	  -- climb down ladder?
	  if btn(⬇️) and not e.inair and fget(_mget(e.x\8,(e.y+4)\8),2) and e.ladder_cooldown==0 then
    e.y+=4
    grab_ladder(e)
   end
	 end
	 
	 if not btn(🅾️) then--and e.dy>=0 then
	  e.canjump=true
	 end
  
  if e.canjump and btnp(🅾️) then
	  -- regular jump
	  if e.inair_frames<5 then
	   jump(e)
	   e.inair_frames=5
	  end

	  -- stomp
	  if e.upg_stomp and e.inair and not e.stomped and e.jump_cooldown==0 then
	   sfx(61)
	   e.stomped=true  
	   e.dy=2
	   set_anim(e,{75})
	   e.canjump=false
	  end
	 end
	 
	 -- grab ladder
	 if e.state!=4 then
 	 if btn(⬆️) and fget(_mget(e.x\8,e.y\8),2) then
    if e.ladder_cooldown==0 then
     grab_ladder(e)
	   end
	  elseif btn(⬇️) and fget(_mget(e.x\8,(e.y)\8),2) then
    if e.ladder_cooldown==0 then
     grab_ladder(e)
	   end
	  end
		end 
		 
		
	elseif e.state==4 then
	 -- on a ladder
	 if btn(⬆️) then
	  e.y-=0.5
	  e.anim_pause=false
	  -- leave ladder if in air
	  if not fget(_mget(e.x\8,(e.y)\8),2) then
    set_anim(e,{64})
    e.y=8*(e.y\8)+5
    e.inair=false
    e.state=0
    e.anim_pause=false
   end
	 elseif btn(⬇️) then
	  e.y+=0.5
	  e.anim_pause=false

	  -- leave ladder if in air
	  if not fget(_mget(e.x\8,(e.y)\8),2) then
    set_anim(e,{78})
    e.inair=true
    e.state=0
    e.anim_pause=false
   end
  else
	  e.anim_pause=true
	 end
	 if btnp(🅾️) then
	  if btn(⬇️) then
	   -- drop down from ladder
	   e.state=0
	   set_anim(e,{78})
	   e.inair=true
	   e.ladder_cooldown=15
	  else
	   jump(e)
	   e.ladder_cooldown=6
	  end
	 end 
	 
	elseif e.state==1 then
	 -- on ledge
	 if (btn(⬅️) and e.dir==1) or (btn(➡️) and e.dir==-1) then
	  set_anim(e,{68})
	 else
	  set_anim(e,{69})
	 end
	 
	 if e.ledge_cooldown==0 then
	  -- drop?
		 if btn(⬇️) then
			 e.state=0
    set_anim(e,{77,77,78})
  	 e.g=player_g

		  e.ledge_cooldown=7
 		 e.dx=0
		 end 
		 -- jump up
		 if btn(🅾️) then
		  e.ledge_cooldown=3
			 e.state=0
			 e.g=player_g
			 e.canjump=false
			 set_anim(e,{78})
			 if btn(➡️) or btn(⬅️) then
	 	  e.dy=-player_f
   	 if (btn(⬅️) and e.dir==1) or (btn(➡️) and e.dir==-1) then
			   set_anim(e,{76,76,77,78})
   	 end
		  else
		   e.dx=-e.dir
		  end
   end
	 end
	 
	end	 	
	 		 	
end

function player_hit_wall(e)
	if pl.rushing then
 	pl.rushing=false
 	pl.rush_count=0
 	pl.rush_cooldown=0
 	shakex=-pl.dir
 end
end

function grab_ladder(e)
 e.state=4
 e.rushing=false
 e.rush_count=0
 e.rush_cooldown=0
 e.g=0
 e.dir=1
 e.x=(e.x\8)*8+3
 e.dx,e.dy=0,0
 set_anim(e,{73,74},true)
end

function jump(e)
 e.state=0
 e.jump_cooldown=5
 e.anim_pause=false
 e.dy=-player_f
 e.inair=true
 e.canjump=false
 set_anim(e,{76,76,76,77,77,78},false)
 e.fs=2
 
 sfx(53)
end



function update_player(e)
 -- todo: use generic function
 --  for cooldowns
 if e.ledge_cooldown>0 then
  e.ledge_cooldown-=1
 end
 
 if e.jump_cooldown>0 then
  e.jump_cooldown-=1
 end

 if e.rush_cooldown>0 then
  e.rush_cooldown-=1
  if e.rush_cooldown==0 then
   e.flash=7
  end
 end

 if e.ladder_cooldown>0 then
  e.ladder_cooldown-=1
 end
 
 if e.rush_count>0 then
  e.rush_count-=1
  if e.rush_count<=0 then
   e.rushing=false
  end
 end
 
 if not e.inair then
  e.stomped=false
  e.jump_cooldown=0
 end

 if e.state==0 then
  -- feels like a hack!
  -- todo: solve
  
  if e.rushing then
   e.g=e.rush_g
  else
   e.g=player_g
  end
 end
 
 if e.state==0 then
  -- normal movement

	 -- check for ledge
	 if pl.upg_grab then
		 if e.dy>0 and e.dx!=0 and e.ledge_cooldown==0 then
			 local tx=e.x\8+e.dir
			 local dist=abs(tx*8+4-e.x)
	
			 if dist<8 then
				 local ty=e.y\8
				 local t1=_mget(tx,ty-1)
				 local t2=_mget(tx,ty)
				 local t3=_mget(tx-e.dir,ty)
				 local t4=_mget(tx-e.dir,ty+1)
				 t1=fget(t1,0) 
     if (fget(t2,4) and e.upg_scale) t1=false
				 t2=fget(t2,0) 
				 t3=fget(t3,0) --or fget(t3,1)
				 t4=fget(t4,0) --or fget(t4,1)
				 if not t1 and 
				    not t3 and 
				    t2 and 
				    not t4 then
					 -- grab ledge
					 sfx(60)
					 e.ledge_cooldown=7
					 e.state=1
					 set_anim(e,{69})
					 e.dy=0
					 e.g=0
					 e.y=ty*8+e.h/2+2
					 if e.dx>0 then
		 			 e.x=tx*8-e.w/2
		 			else
		 			 e.x=tx*8+e.w+7
		 			end
		 			
					end
				end
		 end	 
  end
  
	elseif e.state==2 then
  if e.hp>0 then
	  if intro<0 then
	   e.collapsed_cooldown-=1
	  end
	  if e.collapsed_cooldown==0 then
	   e.state=0
	   if not tips.woken_up then
	    tips.woken_up=true
	    speak({
	     "uHH... wHAT\nHAPPENED?",
	     "sUDDENLY THE \nSHIP SHUT DOWN!",
	     "    ...   ",
	     "wHERE AM i?"
	    })
	   end
	  end
	 else
	  if e.reset_count>0 then
 	  e.reset_count-=1
	  end
	  if e.reset_count==0 then
 	  fadeout()
 	  e.state=0
 	  if current_cp then
 	   e.x=current_cp.x
 	   e.y=current_cp.y+1
     set_cam(64*(pl.x\64),64*(pl.y\64))
 	  end
    swap_room(camtx\64,camty\64)
 	  e.hp=e.max_hp
		  -- talk to it if first time
    if not tips.respawn then
     tips.respawn=true
     speak({"wHAT\nHAPPENED?","hOW AM i\nSTILL ALIVE?"})
	   end
	   set_anim(e,{64})
	   e.reset_count=30
	  end
	 end
	 
	elseif e.state==3 then
  e.hit_cooldown-=1
  if e.hit_cooldown==0 then
  -- if pl.hp>0 then
    e.state=0
    e.ix=0
  -- end
  end
	end
	
 local ▒=_mget(e.x\8,e.y\8)
 if e.state!=3 then
	 if fget(▒,3) then
   if (pl.hp>0) sfx(58)
   hit_player(pl,99,
     -ssgn(e.x-pl.x),
     -1)
	 end
	end
	
 if pl.state==0 and not pl.inair then
  if lore_reply then
   speak(lore_reply)
   set_anim(pl,{64})
  end
 end
	
	
 update_entity(e)


	if e.y\8>31 then
	 collapse_player()
	 e.hp=0
	 e.dy=0
	end

end

function player_hit_floor(e)
 sfx(54) 
 
 if pl.state==4 then
  e.ladder_cooldown=8
  e.state=0
 end
 

 entity_hit_floor(e)
 
 if (not e.stomped and e.ody>6) or e.hp<=0 then
  hit_player(pl,1)
  collapse_player(true)
  pl.ix=0
 else
  if pl.state==3 then
   if pl.hp>0 then
    set_anim(pl,{72})
   end
  end
 end
 
end

function collapse_player()
 pl.state=2
 pl.collapsed_cooldown=30
 set_anim(pl,pl.hp>0 and {71,71,71,72} or {71})
 pl.fs=8
end


function hit_player(src,amnt,dx,dy)
 if pl.hp>0 and pl.state!=3 then
	 pl.hp-=amnt 
	 
	 pl.state=3
		pl.inair=true
	 pl.hit_cooldown=15
	 
	 pl.rushing=false
	 pl.rush_count=0
	 
	 pl.ix=0.7
	 
	 pl.dx=dx or pl.dx
	 pl.dy=dy or pl.dy
	 
	 set_anim(pl,{70})
	 
	end
end


function draw_player(e)
 if e.rushing or e.stomped then
  ox,oy=pl.x,pl.y

  for i=1,15 do pal(i,12) end
  pl.x,pl.y=pl.ox2,pl.oy2
  draw_entity(e)

  for i=1,15 do pal(i,7) end
  pl.x,pl.y=pl.ox,pl.oy
  draw_entity(e)

  pl.x,pl.y=ox,oy
  reset_pal()
 end
 
 pal(10,4)
 
 if outro_step!=7 then
	 if pl.upg_grab then
	  pal(10,3) -- hands
	 end
	 if pl.upg_stomp then
	  pal(2,14) -- feet
	 end
	 if pl.upg_vines then
	  pal(4,3) -- head
	 end
	 if pl.upg_scale then
	  pal(7,11) -- torso
	  pal(6,15) -- torso
	 end
	 if pl.upg_rush then
	  pal(13,3) -- pants
	  pal(5,14) -- pants
	 end
	end
 
 draw_entity(e)
 reset_pal()

 if e.flash then
  e.flash-=1
  line(e.x-2,e.y-e.flash+2,
       e.x+2,e.y-e.flash+2,12)
  if (e.flash==0) e.flash=nil
 end

end


-->8
-- enemies
function make_blob(px,py) 
 return make_entity({
  name="blob",
  
  x=px,y=py,
  g=0,
  ix=0,
  w=2, h=4, sh=10,
  
  hp=1,
  frames={81},
    
  delay=(px*py)%30,
  direction=1,
     
  on_update = function(e)
   e.delay-=1
   if e.delay<=0 then
    e.delay=25+px%30
    e.direction=-e.direction
    e.dy=2*e.direction
    set_anim(e,{82})
    e.h=4
   end
   
   update_entity(e)
  end,

  on_hit_floor = function(e)
   sfx(59)
   set_anim(e,{81,80,81})
   e.fs=3
   e.h=2
  end,
  on_hit_ceiling = function(e)
   sfx(59)
   set_anim(e,{83,84,83})
   e.fs=3
   e.h=2
  end,
  
  on_hit_player = function(e)
   if not pl.rushing then
    hit_player(e,1,
     -ssgn(e.x-pl.x),
     -1)
   else
    make_blobsplash(e.x,e.y,pl.dir)
    del(entities,e)
   end
  end,
  
 },entities)
end


function make_upgrader(px,py) 
 return make_entity({
  name="upgrader",
  
  x=px,y=py,
  g=0,
  ix=0,
  w=2,h=2,sh=14,
  
  hp=1,
  frames={145},  
  countdown=60,
     
  on_update = function(e)
   -- spawn particles
   if (rnd()<1.1-2*e.countdown/120) make_dot(e.x,e.y-4)
   
   update_entity(e)
   
   if not e.hitplayer then
    e.countdown=60
   else
    e.hitplayer=false
    pl.x=e.x
    shakey=rnd(2)-1
    if e.countdown==0 then
     del(entities,e)
     
     local x=pl.x\8
     if x==66 then
      pl.upg_grab=true
      speak({
       "i FEEL...\ndIFFERENT...",
       "mY ARMS ARE\nSTRONGER!"
      })
     elseif x==125 then
      pl.upg_stomp=true
      speak({
       "aNOTHER\nTRANSFORMATION!",
       "tHINK i CAN\nCONTROL MY\nJUMPS BETTER!",
       "#(pRESS z\nTO DIVE.)"
      })
     elseif x==5 then
      pl.upg_scale =true
      speak({
       "gENIUS!",
       "nOW i CAN\nCLIMB THOSE\nWEIRD WALLS."
      })
     elseif x==51 then
      pl.upg_rush =true
      speak({
       "oUF. iT HURTS\nMORE AND MORE.",
       "bUT i FEEL\nFASTER...",
       "#(pRESS x\nTO DASH.)"
      })
     elseif x==83 then
      pl.upg_vines=true
      speak({
       "tHE VINES...\ni CAN FEEL THEM!","eVEN CONTROL\nTHEM!"
      })
     end
    end
   end
  end,
  
  on_hit_player = function(e)
   if e.countdown>0 then
    e.countdown-=1
   end
   if e.countdown==50 then 
    sfx(63)
   end
   e.hitplayer=true
  end,
  
 },entities)
end


function make_pod(px,py) 
 return make_entity({
  name="pod",
  
  x=px,y=py,
  g=0,
  ix=0,
  
  hp=1,
  frames={148},  
     
  on_update = function(e)
   -- spawn particles
   if (rnd()<0.15) make_smoke(e.x+3,e.y,4)
   
   update_entity(e)
   
  end,
  
 },entities)
end



--function make_spinner(px,py) 
-- local e=make_entity({
--  name="spiner",
--  
--  x=px,y=py,
--  g=0,
--  ix=0,
--  h=12,
--  collide=false,  
--
--  on_hit_player = function(e)
--   if pl.state==0 and 
--      pl.upg_rush and 
--      not pl.inair then
--    pl.rushing=true
--   end
--  end,
--
-- },entities)
-- 
-- set_anim(e,{112,113,114,115},true)
-- 
-- return e
--end

function make_vines(px,py) 
 return make_entity({
  name="vines",
  
  x=px,y=py,
  g=0,
  ix=0,
  
  frames={116},  
     
  on_update = function(e)
   if pl.upg_vines then
    if abs(e.y-pl.y)<4 then
     local dx=abs(e.x-pl.x)
     e.frames={min(max(116,120-dx\3),120)}
    end
   end
  end,
  
  on_hit_player = function(e)
   if not pl.upg_vines then
    local d=ssgn(pl.x-e.x)
    pl.x=e.x+d*7
   end
  end,
  
 },entities)
end


function make_mushroom(px,py) 
 return make_entity({
  name="mushroom",
  
  x=px,y=py+2,
  g=0,
  ix=0,
  collide=false,
  h=4,sh=12,
  
  frames={88},  

  on_update = function(e)
   update_entity(e)
  end,
  
  on_hit_player = function(e)
   if pl.inair and pl.dy>0 and pl.hp>0 then
    
    pl.dy=pl.stomped and -4 or -3
    pl.stomped=false
    set_anim(pl,{76,76,77,78})

    set_anim(e,{89,91,89,90,89,88})   
   
    sfx(55)
   end
  end,
  
 },entities)
end



function make_checkpoint(px,py) 
 return make_entity({
  name="checkpoint",
  
  x=px,y=py,
  g=0,
  ix=0,
  collide=false,
  w=3,

  frames={96},  
  actived=false,

  on_hit_player = function(e)
   
   -- lit up
   make_flame(e.x,e.y)

   -- deactivate all
   for e2 in all(entities) do
    if e2.name=="checkpoint" then
     e2.activated=false
     set_anim(e2,{96})
    end
   end
   
   -- activate this
   e.activated=true
   set_anim(e,{97})
   if current_cp!=e then
    sfx(57) 
   end
   
   current_cp=e
  end,
  
 },entities)
end




function make_bearpig(px,py) 
 return make_entity({
  name="bearpig",
  
  x=px,y=py+2,
  g=0.2,
  ix=0.99, iy=1,
  collide=true,
  w=6, h=4, sh=12,

  frames={98},
  delay=0, 
  
  on_update = function(e)
   decrease(e,"delay")
   if e.inair then 
    e.dx=2*e.dir
   end
   if not e.inair and e.delay==0 then
	   local dx=abs(pl.x-e.x)
	   local dy=abs(pl.y\8-e.y\8)
	   if dx<24 then
	    if dy<2 then
	     e.frames={99}
	     e.dir=sgn(pl.x-e.x)
	     
	     if dx<16 then
	      e.dx=2*e.dir
	      e.dy=-0.8
	      e.inair=true
 	     e.frames={100}
	     end 
	    end  
	   end
	   if dx>28 then
	    if dy<3 then
	     e.frames={98}
	    end  
	   end
	  end
   
   update_entity(e)
  end,
  
  on_hit_floor = function(e)
   e.dx,e.dy=0,0
	  e.frames={99}
   e.delay=16
   entity_hit_floor(e)
  end,
  
  on_hit_player = function(e)
    hit_player(e,1,
     -ssgn(e.x-pl.x),
     -1)
  end,
  
 },entities)
end


--
--function make_heartfruit(px,py) 
-- return make_entity({
--  name="vines",
--  
--  x=px,y=py,
--  g=0,
--  ix=0,
--  w=4,
--  
--  frames={92},  
--     
--     
----  on_update = function(e)
----  end,
--  
--  on_hit_player = function(e)
--   e.frames={93}
--   e.on_hit_player=nil
--   pl.max_hp+=1
--   pl.hp=pl.max_hp
--   
--   if not tips.heartfruit then
--    tips.heartfruit=true
--    speak({
--     "tHIS IS TASTY!",
--     "i CAN FEEL MY\nBODY STRENGTHEN!"
--    })
--   end
--  end,
--  
-- },entities)
--end



function make_lorb(px,py) 
 return make_entity({
  name="lorb",
  
  x=px,y=py+1,
  g=0,
  ix=0,
  w=4,h=4,sh=12,
  
  frames={121,122,123,124},     
  anim_loop=true,
  fs=5,
  
  on_hit_player = function(e)
   sfx(56) 
   
   pl.lore+=1
   del(entities,e)
   active_lore=true
   lorex=e.x-camtx
   lorey=e.y-camty
   lore_count=1
   if pl.lore==1 then
    lore_reply={"bRING ME HERE?\nwHAT'S GOING ON?","wHAT WAS\nTHAT EVEN?"}
   elseif pl.lore==2 then
    lore_reply={"tHE CORE?\nwHERE COULD\nTHAT BE?"}
   elseif pl.lore==8 then
    lore_reply={"lET'S DO THIS!"}
   end
  end,
  
 },entities)
end


function make_twinkle(px,py) 
 return make_entity({
  name="twinkle",
  
  x=px,y=py,
  g=0,
  ix=0,
  collide=false,
  
  frames={0}, 
  
  twinkling=false,  
  
  on_update = function(e)
   if rnd()<0.02 and not e.twinkling then
    if rnd()<0.5 then
     set_anim(e,{195,196,197,197,197,197,196,195,0})
    else
     set_anim(e,{195,196,196,195,0})
    end
    e.twinkling=true
   else
    if e.frames[e.frame]==0 then
     e.twinkling=false
    end
   end
   
   update_entity(e)
  end,
    
 },entities)
end



function make_fan(px,py) 
 return make_entity({
  name="fan",
  
  x=px,y=py,
  g=0,
  ix=0,
  w=24,h=71,
  collide=false,
  
  frames={94},   
  
  on_update = function(e)
   local r=0.05
   if pl.x\64==4 and pl.y\64==2 then
    r=0.5
   end
   if rnd()<r then
    spawn_leaf(e.x+rnd(20)-10,e.y+e.h/2+8)
   end
  end,
  
  on_hit_player = function(e)
   pl.dy-=0.45
   pl.inair=true
   pl.frame=1
   pl.frames={rnd()<0.5 and 77 or 78}
  end,
  
 },entities)
end



function make_outro(px,py) 
 return make_entity({
  name="outro",
  
  x=px,y=py,
  g=0,
  ix=0,
  collide=false,
  
  frames={94},   
    
  on_hit_player = function(e)
   outro=1
   outro_step=1
   pl.frames={64}
   pl.frame=1
   del(entities,e)
   
   lorex=32
   lorey=32

   for i=1,pl.lore do
    make_spin_orb(pl.x+4,pl.y-3,i/pl.lore)
   end

   if pl.lore==8 then
    speak({"i THINK WE'RE\nHERE...","tHIS IS IT,\nRIGHT?"})
   else
    speak({"i HOPE THIS\nIS IT.","i HAVE NOTHING\nMORE TO GIVE."})
   end
  end,
  
 },entities)
end


function make_spin_orb(px,py,a,spd,tween) 
 return make_entity({
  name="slorb",
  
  x=px,
  y=py,
  g=0,
  ix=0,
  spd=spd or 64,
  tween=tween or 0.05,
  
  frames={121,122,123,124},     
  anim_loop=true,
  fs=5,
  a=a,
  tx=px,
  ty=py,
  ry=0,
  collide=false,
  
  on_update=function(e)
   e.tx=928+28*cos(e.a+e.⧗/e.spd)
   e.ty=94+28*sin(e.a+e.⧗/e.spd)+e.ry
   
   
   
   if outro_step==2 then
    e.spd=max(10,e.spd-0.25)
   end
   
   if outro_step==3 then
    e.ry-=8
   end
  
   e.x+=(e.tx-e.x)*e.tween
   e.y+=(e.ty-e.y)*e.tween
   update_entity(e)
  end,
  
 },entities)
end


-->8
-- particles

function update_particles(a)
 for p in all(a) do
  p.dy+=p.g

  p.x+=p.dx
  p.y+=p.dy

  p.dx*=p.ix
  p.dy*=p.iy
  
  if (p.uf) p.uf(p)
  if not p.immortal then
   p.⧗+=1
   if p.⧗>p.life then
    del(p.tbl,p)
   end
  end
 end
end

function make_dot(x,y)
 local r=rnd(16)+16
 local a=rnd()
 local f=0.8+rnd(0.3)

 add(particles2, {
  tbl=particles2,
  ⧗=0,
  x=x+r*cos(a), 
  y=y+r*sin(a),
  dx=-0.02*f*r*cos(a),
  dy=-0.02*f*r*sin(a),
  ix=1,
  iy=1,
  g=0,
  
  life=45,
  
  on_draw=function(p)
   
--   local cols=split"1,14,3,15,11,10,7,7,7,7,7,11,14"
   local cols=split"1,5,13,12,12,12,7,7,7,12,13,1"
   local r=2-3*p.⧗/45
   circfill(p.x,p.y,r,
    cols[1+flr(#cols*p.⧗\p.life)]
   )
  end

 })
end


function spawn_landing_dust(e)
 for i=0,e.ody/2 do
  spawn_dust(e.x,e.y+e.h/2-2,
             i-e.ody/4)
 end
end

function spawn_dust(x,y,dx)
 add(particles2, {
  tbl=particles2,
  ⧗=0,
  x=x, y=y,
  dx=dx,
  dy=0,
  ix=0.9,
  iy=1,
  g=0,
  c1=6,--4,
  c2=13,--2,
  
  life=8+rnd(8),
  
  on_draw=function(e)
    local r=min(1,(e.life-e.⧗)/16)
    if e.dy==0 then
     clip(0,flr(e.y-9-camy)%128,127,11)
    end
    circfill(e.x,e.y+1,r*2.5,e.c2)
    circfill(e.x-1,e.y+1,r*2.5,e.c1)
    clip()
   end,

 })
end



function make_smoke(px,py)
 add(particles2, {
   tbl=particles2,
   ⧗=0,
   x=px, y=py,
   r=rnd(0.5),
   life=20+rnd(20),
   g=-rnd(0.3)-0.2,
   dx=rnd(0.2), dy=-rnd(0.2),
   ix=1, iy=0,

   on_draw=function(pp) 
    pp.r+=0.2
    if pp.life-pp.⧗<5 then
     fillp(0b1010010110100101.1)
    end
    if pp.life-pp.⧗<2 then
     fillp(0b0111111111011111.1)
    end
    
    ovalfill(pp.x-pp.r/2,pp.y-pp.r/2,
             pp.x+pp.r/2,pp.y+pp.r/2,
             5)
    ovalfill(pp.x-pp.r/2,pp.y-pp.r/2,
             pp.x+pp.r/2-1,pp.y+pp.r/2-1,
             13)
    fillp()
   end,
  })

end



function make_blobsplash(x,y,dx)
 add(particles2, {
  tbl=particles2,
  ⧗=0,
  x=x-4, y=y-4,
  dx=dx,
  dy=-0.1,
  ix=0.9,
  iy=1,
  g=0.02,
  
  life=15,
  
  on_draw=function(e)
   spr(85+(e.⧗-1)\5,e.x,e.y)
  end 

 })
end

-- todo:
-- make anim particle with splash
function make_flame(x,y,dx)
 add(particles2, {
  tbl=particles2,
  ⧗=0,
  x=x-5+rnd(3), y=y-4,
  dx=0,
  dy=-rnd(1),
  ix=1,
  iy=1,
  g=0,
  
  life=15,
  
  on_draw=function(e)
   spr(112+(e.⧗)\4,e.x,e.y)
  end 

 })
end


function spawn_leaf(x,y)
 add(particles2, {
  tbl=particles2,
  ⧗=0,
  x=x-4, y=y,
  dx=0,
  dy=-rnd()-1,
  ix=1,
  iy=1,
  g=0,
  spd=flr(rnd(4))+2,
  
  life=72,
  c=rnd()<0.25,
  
  on_draw=function(e)
   if e.c then
    pal(14,2)
    pal(3,4)
   end
   if e.⧗<70 then
    spr(107+(e.⧗\e.spd)%4,e.x,e.y)
   else
    pset(e.x+4,e.y+4,14)
   end
   if e.c then
    reset_pal()
   end
  end 

 })
end

function spawn_sand(x,y,dx)
 add(particles2, {
  tbl=particles2,
  ⧗=0,
  x=x, y=y,
  dx=dx,
  dy=0,
  ix=1,
  iy=1,
  g=0,
  c=rnd({2,2,4,4,4,4,9}),
  
  life=999,
  
  on_draw=function(e)
   if e.x>252 then
    del(e.tbl, e)
   end
   e.y+=sin(t()/100+e.⧗/100+0.25)
  
   pset(e.x,e.y,e.c)
  end 

 })
end
-->8
-- platforming

-- code adapted from  
-- https://www.lexaloffle.com/bbs/?tid=28793
-- by matt hugeson

--check if pushing into side tile and resolve.
function collide_side(self)

	local hh=self.h/2
	local wh=self.w/2
	local data={}
	for i=-hh,hh-1 do
	 -- check to the right
	 if self.dx>=0 then
	  local t=_mget((self.x+wh)/8,(self.y+i)/8)
		 if fget(t,0) then
			 self.dx=0
			 self.x=flr(((self.x+wh)/8))*8-wh
				self.cd.right=true
				return true
	 	end
  end
  
  -- check to the left
		if self.dx<=0 then
   local t=_mget((self.x-wh)/8,(self.y+i)/8)
		 if fget(t,0) then
	 		self.dx=0
	 		self.x=flr((self.x-wh)/8)*8+8+wh
				self.cd.left=true
		 	return true
		 end
 	end
	end
	
	--didn't hit a solid tile.
	return nil
end

--check if standing on air
function should_fall(self)
 if (self.inair) return true

 local air=true
 for i=-(self.w/2),(self.w/2)-1 do
  local newty=flr((self.y+(self.h/2)+1)/8)
  local tile=_mget((self.x+i)/8,newty)
  if fget(tile,0) or fget(tile,1) then
   air=false
  end
 end
 
 if not self.inair and air and self.on_fall then
  self.on_fall(self)
 end

 return air
end

--check if pushing into floor tile and resolve.
function collide_floor(self)
	--only check for ground when falling.
	if self.dy<0 then
		return false
	end
	local landed=false
	--check for collision at multiple points along the bottom
	--of the sprite: left, center, and right.
	for i=-(self.w/2),(self.w/2)-1 do
  local newty=flr((self.y+(self.h/2))/8)
  local tile=_mget((self.x+i)/8,newty)
  if fget(tile,0) then
   landed=true
  end
  if (fget(tile,1)) then
   if (self.lastty<newty) landed=true
		end
	end

 if (landed) then
  self.dy=0
  self.y=(flr((self.y+(self.h/2))/8)*8)-(self.h/2)
		self.ly=self.y
		self.cd.down=true
 end

	return landed
end

--check if pushing into roof tile and resolve.
function collide_roof(self)
	--check for collision at multiple points along the top
	--of the sprite: left, center, and right.
 local collided=false
	for i=-(self.w/2),(self.w/2)-1 do
		if fget(_mget((self.x+i)/8,(self.y-(self.h/2))/8),0) then
			self.dy=0
			self.y=flr((self.y-(self.h/2))/8)*8+8+(self.h/2)
   collided=true
			self.cd.up=true
		end
	end
 return collided
end

-->8
-- !spoilers! --

lore={
 "WE USED OUR\nLAST POWERS\nTO BRING YOU\nHERE",
 "WE ARE WEAK\nOUR POWER LOST\nTAKE US TO\nTHE CORE",
 "WE THOUGHT\nUS INVINCIBLE\nBUT OUR PLANET\nCOLLAPSED",
 "EIGHT OF US\nSTAYED BEHIND\nSO MILLIONS\nCOULD ESCAPE",
 "EONS HAVE\nPASSED SINCE\nTHE CALAMITY",
 "ALL THAT NOW\nREMAINS ARE\nOUR SPIRITS",
 "OUR WORLD...\nA MIRACLE\nNOW ONLY\nRUINS REMAIN",
 "AT LAST WE\nARE TOGETHER\nHELP US\nMOVE ON",
 "WE ARE\nFINALLY HERE\nREADY\nTO MOVE ON",
 "WE OWE YOU\nOUR ETERNAL\nGRATITUDE",
 "NOTHING\nIS LEFT\nCOME\nWITH US",
 "OUR JOURNEY\nCONTINUES\n\nTOGETHER"
}

function draw_lore(id)
 -- make wobbly ovals
 local r1=min(29,lore_count*2)
 local w1=r1+2*sin(t())
 local h1=r1+2*cos(t()*1.5)
 local w2=w1-2
 local h2=h1-2
 ovalfill(lorex-w1,lorey-h1,lorex+w1,lorey+h1,12)
 ovalfill(lorex-w2,lorey-h2,lorex+w2,lorey+h2,7) 
 
 lorex+=(32-lorex)*0.1
 lorey+=(32-lorey)*0.1
  
 if lore_count>15 then
  local lines=split(lore[id],"\n")
  for l=1,min(#lines,(lore_count-15)/8) do
   pr(lines[l],32-tlen(lines[l])/2,12+l*7,12)
  end
 
  spr(126+sin(t()),56,56)
 end
end



function update_outro()
 if outro_step<2 then
  if rnd()<0.05 then
   make_dot(928,96)
  end
 elseif outro_step<4 then  
  make_dot(928,96)
 end
 	 
 outro+=1
 if outro==120 then
  outro_step=2
  active_lore=true
  lore_count=1
 elseif outro==121 then
  if pl.lore==8 then
   outro_step=2.5
   active_lore=true
   lore_count=1
  end    
 elseif outro==150 then
  if pl.lore==8 then
   last_orb=make_spin_orb(pl.x+4,pl.y-3,15/16,80,0.03)
   last_orb.is_player=true
   set_anim(last_orb,{185})
   del(entities,pl)
  else   
   speak({"i HOPE IT\nWILL WORK!"})
  end
 elseif outro==180 then
  if pl.lore==8 then
   set_anim(last_orb,{185,169},true)  
  end
 elseif outro==220 then
  if pl.lore==8 then
   set_anim(last_orb,{121,122,123,124})  
  end
  outro_step=3
  sfx(51)
 elseif outro==260 then
  outro_step=4
  lorey=-32
  active_lore=true
  lore_count=1
 elseif outro==261 then
  fadeout()

  if pl.lore==8 then
   -- good ending
   --  goto end screen
   outro_step=5
  else
   -- bad ending
   --  launch animaiton
   
   -- wait a bit
   for i=0,45 do 
    flip() 
   end
   
   -- run animatiom
   outro_step=6
   camx,camtx=192,192
   camy,camty=64,64
   pl.x=255
   pl.y=101
   pl.dir=-1
   pl.visible=false
   set_anim(pl,player_walk_anim,true)
  end
 end
 
 -- end screen
 if outro_step==5 then
  if outro>300 then
	  if btnp(❎) or btnp(🅾️) then
	   fadeout()
	   run()
	  end
	 end
	end
	
	-- handle bad ending
 if outro_step==6 then
  if outro>320 and outro<420 then
   -- walk into screen
   pl.x-=0.25
   pl.fs=8
   pl.visible=true
  end
  
  if outro==400 then
   sfx(54) 
   set_anim(pl,{72})
   speak({"gASP!\nmY LUNGS...","uNBEARABLE.."})
  elseif outro==401 then
   set_anim(pl,player_walk_anim,true)
  elseif outro==421 then
   sfx(54) 
   set_anim(pl,{72})
   speak({"i CAN'T\nCONTINUE.","mY JOURNEY\nENDS HERE."})
  elseif outro==434 then
   set_anim(pl,{71,184})
   pl.fs=30
   sfx(54) 
  elseif outro==480 then 
   outro_step=7
  end
 end
  
 if outro_step==7 then
  if outro==480 then
   set_anim(pl,{184,183,182,166,150,150,134})
   pl.fs=8
   sfx(57) 
  elseif outro>600 then
   fadeout()
   outro_step=5
  end
  
 
 end
 
end
__gfx__
000000003bb3fbb33bbf3bbb3bbf3bb33282882b01111110000000003bb3fbb33bbf3bbb3bbf3bb301100000000000000000000001e000100100000100000000
00000000bff33ffeeff33fffeff33ffbef2338ff00ee111100010000bff33ffeeff33fffeff33ffb0ee000000000000000000000003000e00e00000100000000
00000000ff3eee3333eee3f333eee3ff332ee2f311ee133110111010ff3eee3333eee3f333eee3ff0e3000000000000000000000003e3e000300000e00000000
00000000f333e333333e33ee333e333f332e33eeee11333e1331e110f333e333333e33ee333e333f03300000000000000000000000303000030000e000000000
00000000fee311eeee11333eee113eefee11333e333e33ee13eee110fee311eeee11333eee113eef0f300000000000000000000000e030000300003003000000
0000000033e1ee1111ee133111ee1e3311ee133133eee3f3ee133ee033e1ee1111ee133111ee1e330f3000000000000ee000000000003000003000e000b00300
000000003e33ee0000ee111100ee33e300ee1111eff33fffe1e333eeee33ee0000ee111100ee33ee03300000000000e33e0000000000e00000300e0000b03000
00000000f3331e100110011001e1333f011001103bbf3bbb33ee11ee0eeeeeeeeeeeeeeeeeeeeee003e00000000e333ff333e000000000000003e00030303000
08888880bf3ee11001100000001e33e3bf3ee100001ee3fb0000000000000000444424444000000000e00000e33f3fe0000000000000000003b3e00000000000
82222222bffe331101110110101e33fbbffe30000003effb0000100000000000222212220240000000300000efef3e0000000000000003000e333e00000e3b30
82111182bf333311000001101ee13efbbf331000000133fb0101110100000000010000102200000000300000330fe0000000000000000b00ee00000000e333e0
8211118233e33110000001000ee1ee3ff3e1110000111e3f011e1331000000000e0000e0244900000f300000fe0300000000000000000b000003b000000000ee
82111182f3ee1ee00000000001133e33f3e0110000110e3f011eee310000000003000e004400000003000000f00e00000000000000000303330e3300000b3000
82111182bfe31ee100000000113333fb3ee0100000010ee30ee331ee0000000000f00e0022004490030000003000000000000000003003b00ee033e00033e033
82888822bf33e101000000001133effbe10000000000001eee333e1e0000000000f3e000024440000f000000e000000000e00000000b033000000ee00e330ee0
022222203e33e10000000000011ee3fb1000000000000001ee11ee33000000000030000044420000030000000000000000030e0000030330000000000ee00000
000000003333f00000000000000f3333ee11e3ffff3e11ee44444244000000000000000000000004030000000000000000000000000000000000000000000003
00000000bf333e100110000001e333fbe333ee1ee1ee333e2222212200100000000000000000042003000000000000066d00000000000000000000000000003e
00000000ff3eee333eeee11e33eee3ff0e33e1eeee1e33e00011000000e000000000000000000022030000000000066666d00000300000003000000000003ee0
00000000f333e33333ee33ee333e333f011ee1e11e1ee1100220000000e00000000000000000944200300000000067766bf500003000000033f0000000f3ee00
00000000fee311eeee11333eee113eef011e11111111e110440000001010000000000000000000440030000000007766bfff00003e00000000e3ff3eeee00300
0040400033e1e11111111331111e1e330101110110111010400000000e10010000000000094400220000000000067766d66f5000030000000030000e00000e00
00444440ee33eeee111e1111eeee33ee0000100000010000000000000110e0000000000000044420000000000006666d66ddd5000e3000000000000300000000
002002000eeeeeeeeeeeeeeeeeeeeee000000000000000000000000001101000000000000000244400000000006d66d66ddddd0000e300000000000000000000
04444400444442444444244444244444001e3dc770000000000000077cd3e1001000000000000000000000000066dd666d566d50000e30000000000000000000
00200200224221222222122222122222101e3eddd00000000000000ddde3e10111000000000000000090000000666666dd566310000ee3b00000000000000000
004024000040244000000000000011001ee13eee0000000000000000eee31ee101110000000000010040009000d66666d5163310000e00e3b000000000000000
004440000044400000000000000002200ee1ee3f0000000000000000f3ee1ee000111100000001110440004200dd666dd5153110000300e0ebb3000000000000
0420200004202000000000000000004401133e33000000000000000033e331100010011111111100240090020dffddddd1111111000300300bee33e000000003
00404000004040000000000000000004113333fb0000000000000000bf3333110010000010010000440040400ff66ddd51155511000e000003000eeeb3bb33ee
004444400444444000000000000000001133effb0000000000000000bffe33110000000010000000422442200f6666dd1155551100000000030000000eeee300
00200200002002000000000000000000011ee3fb0000000000000000bf3ee1100000000000000000402422040d6666dd11551111000000000e0000000e000000
0000000000000000000000000000000000406a0000000a00000000000000000000000000000000a000a0000000a000a000000a0a000a00a00000000000000000
00004000000000000000400000000000074700000004060000040000000000000000000000a04060007040a0007040600000470600074060000040000000e000
000746000000400000074600000040007777600000746000077760000000000000000000007776600077766000774660000747600007460000774600000fe300
00777600000776000077760000774600a076d50007776500777606000000000000000000007776000007766000077600000776000007760007077660003ff300
00766600000776000076660007077600000d05000776d500776000a0000000000000040000076600000766000006660000076650000766000a07660a003f3300
00add50000076a0000add5000a0766a00000d2000a0d0200add55000000000000006760000ddd500000dd550000dd500000dd550000dd550000dd500003dd500
000d0500000dd550000d0500000dd50000000200000d000000d0020005d7760000d7d50000200500000d0020000d0500000d0020000d0002002d0050000d0500
000202000020002000020200000220000000000000020000002000002dd6a640002ad5a0000002000002000000020200000200000020000000000020000e0e00
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000990000000f3e0000331002222222200000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000994400000fee3000e10e102227722200000000
000000000000000000000000000000000000000000000000008000000080000000094400000000000000000000944400003e0030000001e02277772200000000
00000000000000000009800000888800089988800009880000000080000000000099944000944400000000000999944008281030000000e02777777200000000
0000000000000000000980000009800000000000008880000008800000000800094444400999444000999440092dd24008881f30000003e02227722200000000
0000000000098000000880000000000000000000000000000800000000000000042dd240094444449994444400466400028203e000000e102227722200000000
089988800088880000080000000000000000000000000000000000000000000000466400042dd240422dd224006660000030fe0000e031002222222200000000
000000000000000000000000000000000000000000000000000000000000000000666000006664000466644000666000000e3e000001e1002227722200000000
00020000000400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
04444200049994000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002120000
0020200000c7c0000000000000000000000000000000000000000000000000000000000000000000000000000000000000033000000300000000000002220000
0020200000c7c0000000000000000000000448480000000000000000000000000000000000000000000004000000030000003e00003ee0000003000001210000
044442000499940000000000004484800444442000000000000000000000000000009900000000000004420000033e000000e00000e000000033000000000000
00020000000200000044848004444400444444440000000000000000000000000004444000000000000020000000e0000000000000000000000ee00000000000
000400000004000004444400044442000000000000000000000000000000000000045d2000000000000000000000000000000000000000000000000000000000
00040000000400004444444004204200000000000000000000000000000000000000266000000000000000000000000000000000000000000000000000000000
000c0000000000000000000000000000000e33e0000ee3ee00ee33e000ee33e00ee333ee00000000000500000000000000000000000000000777000000000000
00070000000c000000050000000100000f00f3000000ff00000bf000000ffe0000000000000c000000000000000000000000c000077700007575700008281000
00070000000c0000000d00000000000000b0bf000000bf000000f3000000000000000000000000000000c0000000c00000000000757570007757700008881000
0007000000000000000000000000000000f0bf0000f00b00000000000000000000000000000cc000000c700000000000000c0000775770007575700002820000
000000000000000000000000000000000bf0f000000f00f000000000000000000000000000c77c0000c77c00000cc0000007c00075757000d777d00000000000
000000000000000000000000000000000bf00f0000bf0000000b0000000000000000000000c77c0000c77c0000c77c0000c77c00077700000ddd000000000000
000000000000000000000000000000000ff300000bff00000bff00000000000000000000000cc000000cc00000c77c0000c77c00000000000000000000000000
000000000000000000000000000000003f33000033f330003fff33003fbff3003fbff3000000000000000000000cc000000cc000000000000000000000000000
000000000000000000000000001010000000000000000000000c00001d66d111efbbfee0666d666dbbffff6d66d6666d01111111111111100000000000000000
00000000000000000000000000010000000000000000000000c7c000d6655511fbb333ee6de5ddd5633335d56d5dddd577c7ccccccccdcddcccccccc00000000
000000000066660000000000000000000000000000000000000c0000dddd5511ffff33ee635d66df6dee36d56d1556d501111111111111100000000000000000
000000000fdd5500000000000010100000000000000000000000b007d5551110f333eee06edd66f56ddd66d56557c6d177c7ccccccccdcddcccccccc00000000
00000006f3766666600000000001000000000000000000000000b0b00d1111000feeee006566df556d66ddd5dd5cc65501111111111111100000000000000000
0000000d35ddd5d55000000001101100000000000000000073003b00066dd5100bbff3e0ed66d3d36d66dd356d666dd577c7ccccccccdcddcccccccc00000000
0000006663666666660000000011100000000000076d000000b03300ddd55510fff333e06dddd53e6dddd33e6ddd5dd501111111111111100000000000000000
000000dd3ddddd5d5500000000010000000000006d76d000003e3300d5511110f33eeee0d5553ee3d555eeeed555155577c7ccccccccdcddcccccccc00000000
00000005e110011150000000000000000000000666ddd0000000000006dd55100bff33e0666d666d9944446d00000cccccd00000000000cd5d00000000000000
0000000d31000011d000000000000000000000656666d00000070000ddd55551fff3333e6d15ddd5622225d5000cccccccccd00000000c0000d0000000000000
00660006100000016000000000100000000006555666d00000030000d5111111f3eeeeee625d66d46d1126d500c777cccccccd0000007000000d000000000000
00d500f6100000016300000001101001000065111646d0000000b000516dd5103ebff3e061dd66456ddd66d50c77777ccccccdd0000c00000000d00000000000
0666d03d1000000fd0f0000011010010000d6711666dd0000000b0b01666d550ebbbf3306566d4556d66ddd50c77777cccccccd0000c00000000d00000000000
00d500063000000360000000011010010025d666686dd04003003b001d6d5551efbf333e1d66d2d26d66dd25cc77777cccccccdd000d00000000500000000000
0666d006e1000011f000d50000100000044d5d6666dd594200b03300dd551111ff33eeee6dddd5216dddd221ccc777ccccccccdd000d00000000500000000000
00d5003d11100111d30d550000000000ff22d543ddd54422003e3300d5116d55f3eebf33d5552112d5551111ccccccccccccccdd000d00000000500000000000
3bbf3d6666d66666666f3bbb000000003bbf3225354f3bbb00000000516ddd513ebfff3e0c00000000000000ccccccccccccccdd000d00000000500000000000
eff33f5ddd5dd33dd5f33fff00000100eff33fffeff33fff000000001dd55551eff3333e0c00700c07ccccd0ccccccccccccccdd000d00000000500000000000
33ddd3f3666666de33eee3f30001111033eee3f333eee3f3000000001d511111ef3eeeee00cc7cc000000000dccccccccccccddd000d00000000500000000000
336663ee35ddddee333e33ee00100100333e33ee333e33ee00007000d516d510f3ebf3e000077700000000000ccccccccccccdd0000c00000000d00000000000
ee1dd33eee11333eee11333e01000000ee11333eee11333e0000b000516dd5513ebff33e00077700000000000dccccccccccddd0000c00000000d00000000000
11e1133111ee133111ee13310101110011ee133111ee13310000bb001ddd5551efff333e0007cc000000000000ddccccccdddd0000007000000d000000000000
00ee111100ee111100ee11110101110000ee111100ee111100303b001d555510ef3333e000cc00c000000000000dddddddddd00000000c0000d0000000000000
0110011001100110011001100101110001100110011001100ebe33e00511110003eeee00000000c00000000000000dddddd00000000000cd5d00000000000000
01011100000000000000011100000000101000100100010100000000000000000000000003000000000000000000077700077700077700077700077700770000
0000001000111000010001110000000010100000010000010000000000000000000000000b003003000000000000775770775770775770775770775770777700
01111001011011001110111100000000101000100100010100000000000000000000000000bb3ff0000000000000550777750557750557750777750777755000
110011010100011001000111000000000010001001000101000000000000000000000000000bbf00000000000007777757777707700007777707707757700000
110111010010011001000111000000001010001000000101000030000000000000000000000bff00000000000077557700557777500077555007507777500000
1100100100001100010001110000000010100010010001010000b000000000000000000000033e00000000000077077577077577077077077077077577077000
01100010000111000100111100000000100000100100010000eebe000000f0000000000000e300e0000000000057777057775057775057775077077057775000
0011110000111110000001110000000010100010010001010e3e33e0e33fb3e0e3fff3e0000000e007ccccd00005550005550005550005550055055005550000
d666666d66666666d666666d00000000000000000000000000000000000000000000000000000000000000000000000002222dc7000000000000004000000000
5d66d515dd66ddd5515d66d5000000000000000000050000000000000000000000000000000000000000000000000000224444dd000000000000042000000000
05dd5111515ddd111115dd500000000000050000000c000000000000000000000000000000000000000000000000000021244200000000000004040000000000
0155dd551555511555dd5510000d0000005c500005c7c50000000000000000000000000000000000000000000000000044422100000040000000420000000000
00515dd1011155511dd515000000000000050000000c00000000d0d000c000000000000000000000000000000000000042211000004420000000400000000000
00111510000151100151110000000000000000000005000000000700000000000000000000000000000000000000000022110000002420000000400000000000
005ddd100001011001ddd5000000000000000000000000000000d0d0000000000000000000000000000000000000000000000000000442000004200000049940
05ddd51000000000015ddd5000000000000000000000000000000000000000000000000000000000000000000000000000000000244442200004200004999994
05ddd55505500000015dddd5cccccccc01001010ccccccccc7c77777cc7ccccc000000000000000099994bbb9999999900222100499999949999999949999994
05dddd11555550000515dd500000000001001010c11c1111c11c77c11c11000c000010000000000042443fff4499444200011000249942124499444221249942
055d5515005510001ddd55100000000001001010c11c111c11c77c11c111000c00010100000000002e2ee3f32124441100000000024421112124441111124420
5555555100011000dd5515000000000000101010c11c11c11c77c11c1111000c001000100000000021ee33ee1222211200000000012244221222211222442210
5dddd51000010000555dd1000000000000011010c11c1c11c77c11c11111000c0010001000000000e111333e0111000100000000002124410111222114421200
05dd51500055551011dddd500000000000010010c11cc11c77c11c111111000c010100100000000011ee13310000000000000000001112100001211001211100
0155ddd1000551005155d55000000000000111107cc711c77c11c1111111000c100010100000000000ee11110000000000000000002444100001011001444200
005155dd00001000155555550000000000000000c11c1c77c11c11111111000d1000101000000000011001100000000000000000024442100000000001244420
055d5555dddd555555555500cc7cc7cc00000000c117c77c11c111111111001ccccccc7c77777ccc000000000000122222210000024442220121000001244442
00ddd55d5d5155555ddd550000500500000000007cc777c11c1111111111010cc11c1c11c77c10cc000000000002224444222000024444111222221002124420
00dddd555511dddd51dddd0000d00d000000000077777c11c11111111111100dc11cc11c77c11c0c000000000012244444422100022422120012210014442210
000dd155151555d15551110000c00c00000110007777c11c111111111110001dc11711c77c11c00c000000000122214224122210222222210000000044221200
0005511511115551555511000c7cc7c0000101007cc711c1111111111101011d7ccc1c77c11c100c000000000012111221112100244442100001122122244100
0000110501001511151110000050050001110010c1171c11111111111011111dc11cc77c11c1100c000000001244211221124421024421200012222211444420
00000000000000001110000000d00d0001010010c11cc111111111110110111cc11c77c11c11100c001100002144212222124412012244410000121121224220
00000000000000000110000000c00c00010100107cc71111111111101100110c7cc77c11c111100c122211102112222112222112002122440000000012222222
0055510000000000000000000c7cc7c0ccccc77cc11c1111111111011000100d777cc11c1111100d0000000002222dc77cd22220000422224444222222222200
00011000000000000000000000500500c1c1771cc11c1111111110110000001c777c11c11111101d00000000224444dddd444422004442242421222224442200
00000000000000000000000000d00d00c1c7711cc11c1111111101100001010c7cc71c111111111c000000002124420000244212004444222211444421444400
00000000000000000000000000c00c007c77111dc11c1111111011000011100cc11cc1111111010c000000004442210000122444000441221212224122211100
0000000000000000000000000c7cc7c07c71110dc11c1111110110000110000c7ccc11111110000c000000004221200000021224000221121111222122221100
00000000000000000000000000500500c1c1100cc11c1111101100001101000cc11c11111100100c000000002244100000014422000011020100121112111000
00000000000000000000000000d00d00c1c1001cc11c1111011000011011000cc11c11111001100c000000001444420000244441000000000000000011100000
00000000000000000000000000c00c00cccddccccccccccdccddddccdcccccccccccccccddcccccc000000001224220000224221000000000000000001100000
__label__
00111100000000000000000000000000000011jj3333jj330000000000000000000000000000003333333333rr00000000000000000000000000000000000000
00111100000000000000000000000000000011jj3333jj330000000000000000000000000000003333333333rr00000000000000000000000000000000000000
00111111001111000000000000000000110011jj3333rrbb000000000000000000000000000033jjbbrr333333jj110000111100000000000000001100000000
00111111001111000000000000000000110011jj3333rrbb000000000000000000000000000033jjbbrr333333jj110000111100000000000000001100000000
0000000000111100000000000000000011jjjj1133jjrrbb33000000000000000000000033jjjj00rrrr33jjjjjj333333jjjjjjjj1111jj1100111111001100
0000000000111100000000000000000011jjjj1133jjrrbb33000000000000000000000033jjjj00rrrr33jjjjjj333333jjjjjjjj1111jj1100111111001100
0000000000110000000000000000000000jjjj11jjjj33rr3333rr00000000000000rr33jjjj0000rr333333jj3333333333jjjj3333jjjj11333311jj111100
0000000000110000000000000000000000jjjj11jjjj33rr3333rr00000000000000rr33jjjj0000rr333333jj3333333333jjjj3333jjjj11333311jj111100
000000000000000000000000000000000011113333jj33330000jj33rrrr33jjjjjjjj0000330000rrjjjj331111jjjjjjjj1111333333jj1133jjjjjj111100
000000000000000000000000000000000011113333jj33330000jj33rrrr33jjjjjjjj0000330000rrjjjj331111jjjjjjjj1111333333jj1133jjjjjj111100
00000000000000000000000000000000111133333333rrbb00003300000000jj0000000000jj00003333jj11jj1111111111111111333311jjjj113333jjjj00
00000000000000000000000000000000111133333333rrbb00003300000000jj0000000000jj00003333jj11jj1111111111111111333311jjjj113333jjjj00
0000000000000000000000000000000011113333jjrrrrbb00000000000000330000000000000000jjjj3333jjjjjjjj111111jj11111111jj11jj333333jjjj
0000000000000000000000000000000011113333jjrrrrbb00000000000000330000000000000000jjjj3333jjjjjjjj111111jj11111111jj11jj333333jjjj
00000000000000000000000000000000001111jjjj33rrbb0000000000000000000000000000000000jjjjjjjjjjjjjjjjjjjjjjjjjjjjjj3333jjjj1111jjjj
00000000000000000000000000000000001111jjjj33rrbb0000000000000000000000000000000000jjjjjjjjjjjjjjjjjjjjjjjjjjjjjj3333jjjj1111jjjj
00000000000000000011110000000000000011jj3333jj330033bb33jj000000000000000000000000111100000000000011000000000011bbrr33jjjj111100
00000000000000000011110000000000000011jj3333jj330033bb33jj000000000000000000000000111100000000000011000000000011bbrr33jjjj111100
00000000000000000011111100111100110011jj3333rrbb00jj333333jj0000000000000000000000jjjj000000000000jj000000000011bbrrrrjj33331111
00000000000000000011111100111100110011jj3333rrbb00jj333333jj0000000000000000000000jjjj000000000000jj000000000011bbrrrrjj33331111
0000000000000000000000000011110011jjjj1133jjrrbbjjjj000000000000000000000000000000jj33000000000000330000000000jjbbrr333333331111
0000000000000000000000000011110011jjjj1133jjrrbbjjjj000000000000000000000000000000jj33000000000000330000000000jjbbrr333333331111
0000000000000000000000000011000000jjjj11jjjj33rr00000033bb00000000000000000000000033330000000000003300000000jj003333jj3333111100
0000000000000000000000000011000000jjjj11jjjj33rr00000033bb00000000000000000000000033330000000000003300000000jj003333jj3333111100
000000000000000000000000000000000011113333jj3333333300jj33330000000000000000000000rr3300000000000033000000003300rr33jjjj11jjjj00
000000000000000000000000000000000011113333jj3333333300jj33330000000000000000000000rr3300000000000033000000003300rr33jjjj11jjjj00
00000000000000000000000000000000111133333333rrbb00jjjj003333jj00000000000000000000rr330000000000000033000000jj00bbrrjj3311jjjj11
00000000000000000000000000000000111133333333rrbb00jjjj003333jj00000000000000000000rr330000000000000033000000jj00bbrrjj3311jjjj11
0000000000000000000000000000000011113333jjrrrrbb0000000000jjjj00000000000000000000333300000000000000330000jj0000bbrr3333jj110011
0000000000000000000000000000000011113333jjrrrrbb0000000000jjjj00000000000000000000333300000000000000330000jj0000bbrr3333jj110011
00000000000000000000000000000000001111jjjj33rrbb000000000000000000000000000000000033jj000000000000000033jj00000033jj3333jj110000
00000000000000000000000000000000001111jjjj33rrbb000000000000000000000000000000000033jj000000000000000033jj00000033jj3333jj110000
00000000000000000000000000000000000000rr33333333000000000000000000000000000000000000jj00000000000000000000000000bbrr33jjjj111100
00000000000000000000000000000000000000rr33333333000000000000000000000000000000000000jj00000000000000000000000000bbrr33jjjj111100
001111000000000000111100000000000011jj333333rrbb0000000000000000000000000000000000003300000000000000000000000000bbrrrrjj33331111
001111000000000000111100000000000011jj333333rrbb0000000000000000000000000000000000003300000000000000000000000000bbrrrrjj33331111
33jjjjjjjj1111jj33jjjjjjjj1111jj3333jjjjjj33rrrr0000000000000000000000000000000000003300000000000000000000000000bbrr333333331111
33jjjjjjjj1111jj33jjjjjjjj1111jj3333jjjjjj33rrrr0000000000000000000000000000000000003300000000000000000000000000bbrr333333331111
3333jjjj3333jjjj3333jjjj3333jjjj333333jj333333rr0000000000000000000000000000000000rr33000000000000000000000000003333jj3333111100
3333jjjj3333jjjj3333jjjj3333jjjj333333jj333333rr0000000000000000000000000000000000rr33000000000000000000000000003333jj3333111100
jjjj1111333333jjjjjj1111333333jjjj77777733jjjj777777000000777777000000777777000000777777000077770000000000000000rr33jjjj11jjjj00
jjjj1111333333jjjjjj1111333333jjjj77777733jjjj777777000000777777000000777777000000777777000077770000000000000000rr33jjjj11jjjj00
111111111133331111111111113333117777557777jj77775577770077775577770077775577770077775577770077777777000000000000bbrrjj3311jjjj11
111111111133331111111111113333117777557777jj77775577770077775577770077775577770077775577770077777777000000000000bbrrjj3311jjjj11
111111jj11111111111111jj111111115555jj77777777550055557777550055557777550077777777550077777777555500000000000000bbrr3333jj110011
111111jj11111111111111jj111111115555jj77777777550055557777550055557777550077777777550077777777555500000000000000bbrr3333jj110011
jjjjjjjjjjjjjjjjjjjjjjjjjjjjjj777777777755777777777700777700000000777777777700777733777755777700000000000000000033jj3333jj110000
jjjjjjjjjjjjjjjjjjjjjjjjjjjjjj777777777755777777777700777700000000777777777700777733777755777700000000000000000033jj3333jj110000
001100000000001100000000000077775555777700005555777777775500000077775555550000775500777777775500000000000000000033333333rr000000
001100000000001100000000000077775555777700005555777777775500000077775555550000775500777777775500000000000000000033333333rr000000
00jj0000000000110000000000007777007777557777jj77775577770077770077770077770077770077775577770077770000jj33bb3300bbrr333333jj1100
00jj0000000000110000000000007777007777557777jj77775577770077770077770077770077770077775577770077770000jj33bb3300bbrr333333jj1100
00330000000000jj0000000000005577777777jj557777775500557777775500557777775500777700777700557777775500jj333333jj00rrrr33jjjjjj3333
00330000000000jj0000000000005577777777jj557777775500557777775500557777775500777700777700557777775500jj333333jj00rrrr33jjjjjj3333
003300000000jj000000000000000055555533003355555500000055555500dddd555555000055550055550000555555000000000000jjjjrr333333jj333333
003300000000jj000000000000000055555533003355555500000055555500dddd555555000055550055550000555555000000000000jjjjrr333333jj333333
003300000000330000000000000000000000jj0033000000000000000000dddddddddddd000000000033000000000000000000bb33000000rrjjjj331111jjjj
003300000000330000000000000000000000jj0033000000000000000000dddddddddddd000000000033000000000000000000bb33000000rrjjjj331111jjjj
000033000000jj0000000000000000000000000033000000000000000000dddddddddddd55000000003300000000000000003333jj0033333333jj11jj111111
000033000000jj0000000000000000000000000033000000000000000000dddddddddddd55000000003300000000000000003333jj0033333333jj11jj111111
0000330000jj0000000000000000000000000000jj000000000000000000dddddddddddd5500000000rr00000000000000jj333300jjjj00jjjj3333jjjjjjjj
0000330000jj0000000000000000000000000000jj000000000000000000dddddddddddd5500000000rr00000000000000jj333300jjjj00jjjj3333jjjjjjjj
00000033jj00000000000000000000000000000000000000000000000000dddddddddddd55000000003300000000000000jjjj000000000000jjjjjjjjjjjjjj
00000033jj00000000000000000000000000000000000000000000000000dddddddddddd55000000003300000000000000jjjj000000000000jjjjjjjjjjjjjj
00000000000000000000000000000000000000000000000000000000000000dddddddd5500000000003300000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000dddddddd5500000000003300000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000005555550000000000003300000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000005555550000000000003300000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000dddddd55dd000000000000003300000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000dddddd55dd000000000000003300000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000dddddddddd55dd0000000000000033000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000dddddddddd55dd0000000000000033000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000dddddddddddd555500000000000033000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000dddddddddddd555500000000000033000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000dddddd55dddddd5500000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000dddddd55dddddd5500000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000055dddddd55dddd5500000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000055dddddd55dddd5500000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000055dddd55dd5555dd000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000055dddd55dd5555dd000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000dddd555555dddd000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000dddd555555dddd000000000000000000000000000000000000000000000000000000
000000000033000000000000000000000000000000000000000000000000665566666666dd000000000000000000000000000000000000000000000000000000
000000000033000000000000000000000000000000000000000000000000665566666666dd000000000000000000000000000000000000000000000000000000
0000000000bb000000000000000000000000000000000000000000000066555555666666dd000000000000000000000000000000000000000000000000000000
0000000000bb000000000000000000000000000000000000000000000066555555666666dd000000000000000000000000000000000000000000000000000000
0000000000bb000000000000000000000000000000000000000000006655dd5511664466dd000000000000000000000000000000000000000000000000000000
0000000000bb000000000000000000000000000000000000000000006655dd5511664466dd000000000000000000000000000000000000000000000000000000
000000000033003300000000000000000000000000000000000000dd66775555666666dddd000000003300000000000000000000000000000000000000000000
000000000033003300000000000000000000000000000000000000dd66775555666666dddd000000003300000000000000000000000000000000000000000000
000033000033bb000000000000000000000000000000000000002255dd666666668866dddd0044000000bb000033000000000000000000000000000000000000
000033000033bb000000000000000000000000000000000000002255dd666666668866dddd0044000000bb000033000000000000000000000000000000000000
000000bb003333000000jj00000000000055dd7777660000004444dd55dd66666666dddd559944220000bb003300000000000000000000000000000000000000
000000bb003333000000jj00000000000055dd7777660000004444dd55dd66666666dddd559944220000bb003300000000000000000000000000000000000000
00000033003333000000003300jj000022dddd6644664400rrrr2222dd554433dddddd5544442222330033003300000000000000000000000000000000000000
00000033003333000000003300jj000022dddd6644664400rrrr2222dd554433dddddd5544442222330033003300000000000000000000000000000000000000
33bbbbrr33bbbbbb33bbbbrr33bbbbbb33bbbbrr33bbbbbb33bbbbrr33222255335544rr33bbbbbb33bbbbrr33bbbb3300000000000000000000000000000000
33bbbbrr33bbbbbb33bbbbrr33bbbbbb33bbbbrr33bbbbbb33bbbbrr33222255335544rr33bbbbbb33bbbbrr33bbbb3300000000000000000000000000000000
jjrrrr3333rrrrrrjjrrrr3333rrrrrrjjrrrr3333rrrrrrjjrrrr3333rrrrrrjjrrrr3333rrrrrrjjrrrr3333rrrrbb00000000000000000000000000000000
jjrrrr3333rrrrrrjjrrrr3333rrrrrrjjrrrr3333rrrrrrjjrrrr3333rrrrrrjjrrrr3333rrrrrrjjrrrr3333rrrrbb00000000000000000000000000000000
3333jjjjjj33rr333333jjjjjj33rr333333jjjjjj33rr333333jjjjjj33rr333333jjjjjj33rr333333jjjjjj33rrrr00000000000000000000000000000000
3333jjjjjj33rr333333jjjjjj33rr333333jjjjjj33rr333333jjjjjj33rr333333jjjjjj33rr333333jjjjjj33rrrr00000000000000000000000000000000
333333jj3333jjjj333333jj3333jjjj333333jj3333jjjj333333jj3333jjjj333333jj3333jjjj333333jj333333rr00000000000000000000000000000000
333333jj3333jjjj333333jj3333jjjj333333jj3333jjjj333333jj3333jjjj333333jj3333jjjj333333jj333333rr00000000000000000000000000000000
jjjj1111333333jjjjjj1111333333jjjjjj1111333333jjjjjj1111333333jjjjjj1111333333jjjjjj111133jjjjrr00000000000000000000000000000000
jjjj1111333333jjjjjj1111333333jjjjjj1111333333jjjjjj1111333333jjjjjj1111333333jjjjjj111133jjjjrr00000000000000000000000000000000
1111jjjj113333111111jjjj113333111111jjjj113333111111jjjj113333111111jjjj113333111111jjjj11jj3333jj000000000000000000000000000000
1111jjjj113333111111jjjj113333111111jjjj113333111111jjjj113333111111jjjj113333111111jjjj11jj3333jj000000000000000000000000000000
0000jjjj111111110000jjjj111111110000jjjj111111110000jjjj111111110000jjjj111111110000jjjj3333jj3333jj0000000000000000jj0000000000
0000jjjj111111110000jjjj111111110000jjjj111111110000jjjj111111110000jjjj111111110000jjjj3333jj3333jj0000000000000000jj0000000000
001111000011110000111100001111000011110000111100001111000011110000111100001111000011jj11333333rrrr333333jj0000000000003300jj0000
001111000011110000111100001111000011110000111100001111000011110000111100001111000011jj11333333rrrr333333jj0000000000003300jj0000
000000000000000000000000000000000000000000000000001111000000000000000000000000jjjjjj1111jj33rrjj33jjbbrr33bbbbbb33bbbbrr33bbbbbb
000000000000000000000000000000000000000000000000001111000000000000000000000000jjjjjj1111jj33rrjj33jjbbrr33bbbbbb33bbbbrr33bbbbbb
0000000000000000440000000000000000000044000000000044111100111100000000000000004444jj3333jjjj1144jj44jj33jjjjjjjjjjrrrr3333rrrrrr
0000000000000000440000000000000000000044000000000044111100111100000000000000004444jj3333jjjj1144jj44jj33jjjjjjjjjjrrrr3333rrrrrr
00000000000000004444000044004400000000440000440000444400001144440044440000000044114433jj44jjjj11334444jj444444443333jjjjjj33rr33
00000000000000004444000044004400000000440000440000444400001144440044440000000044114433jj44jjjj11334444jj444444443333jjjjjj33rr33
00000000000000004411440044004400000000440044114400441144004411440044114400000044jj4411444444jj44334411jj11114411333333jj3333jjjj
00000000000000004411440044004400000000440044114400441144004411440044114400000044jj4411444444jj44334411jj11114411333333jj3333jjjj
000000000000000044004400114444000000004400440044004400440044004400440044000000444411114411111144jj44jj11jj4411jjjjjj1111333333jj
000000000000000044004400114444000000004400440044004400440044004400440044000000444411114411111144jj44jj11jj4411jjjjjj1111333333jj
000000000000000044441100001144000000004400114411004400440011444400440044000000441111001144110044111144jj444444441111jjjj11333311
000000000000000044441100001144000000004400114411004400440011444400440044000000441111001144110044111144jj444444441111jjjj11333311
000000000000000011110000444411000000441100001100001100110000111100110011000000110000000011000011000011jj111111110000jjjj11111111
000000000000000011110000444411000000441100001100001100110000111100110011000000110000000011000011000011jj111111110000jjjj11111111
00000000000000000000000011110000000011000000000000000000000000000000000000000000000000000000000000111100001111000011110000111100
00000000000000000000000011110000000011000000000000000000000000000000000000000000000000000000000000111100001111000011110000111100

__gff__
0001010101010101010100000000000001010001010101000208000000000000000101010101020000080000000000000406020211000011000008000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000001000101010000000000000000000000010001010000000000010101000101000100000000000000000000000000000000000000000000000001010100000000000000000011000000010101020001010100000101000101010101010600010101010100010101010100000004010101010101001111010101
__map__
ebfefefeeceb99feff0000000000edeeeeef0000000000000000000000edeeee000013000000000000000000000000000000000000000000000000000000000011131e0e0000000f00681d0000000000000000000000001116231b000000000000000000000000e0e1e2000000000000000000000000000000000000000000d0
ef200000edef0000000060cf0000ed00eeed00cf000000000000000000ef00ee0000131e00000000000000000000000000000000000000002b2c00000000000011130000001f01080808092d00001c002700000000000021231b00000000791c0000000000000000000000000000000000000000000000c1c2000000008300d2
ef319a00fdff00000000dddf0000efeeeeef00dddf0000000000000000fcee00001623000000000000008a2d0000000f000000000000001d3b3c0c000000000011130c790f0021231b0d003d3e3f0708080809000000000d00001d0000010202030c1d0000c00000000000000000000000000000c1000000f0000000808182d0
ef30ed0000b200000036fcef0036fcee00fb00edef0000000000000000edee0000130d00000000000000873d3e3f070808091e00000001a0a1a20300000000002123080801030000005000000000000e000d000000000000001f01032d2122061308091e00d0c20000600000c000000000c20000f000000000000060909192d0
ef30ef00808182000000fcef0029edecebef36fcef2632323232320036fc00ee16230000790000000058970000000d0e0000000000002122222223000000581c000f0e0011132f010202030000001d000f000000000060270f0021233d3e3f21231b000000e0c0c1c1c20000f000000000f0000000000000005800c0c1c18bc1
ef30edcd909192cfce00edef0000fdfefecc35efef0000000000000000ed00ee1300000032183389a103a700000f0000681c000000001f11131b00580000070808093839111338111200131e00010202030000580000010203001a0d0000000e0d0000000000d0d1d2e2000000c20000000000c20000000000c0c1c2d1000000
ef30fddddede8bdedbdedffb350000000000cfedff0000000000000036fceeee231e00000000008b122403383901020202030c2700000011133839870000000d0000200b21232e110012133a3a111212133a3a8a3a3a1100130c2a002050001d000050581d68d000d000000000f000c0c23a3ad03a3a3a3a3ad0d1f08b0000d1
ef3000fdfefefeec00eedced3a3adddedededeef000000000000000000fdfeff0000000000000011000013001f1100000024020300000011132e2fa70000000000323101031b00212222230402212222230204020204111224020203313201020202020202020225d23a3a3a3a3a3ad0c0c1c1c1c1c1c1c1c1c1c20000d10000
ef300000000000ef00eeebfefefefefefefefeff0000000000000000000000000000000000001f111200132e2f212206000000132d001f1113000000000000000000301113000000000d00000000000000000000001f212222222223301f21060000001622220600c1c1c1c1c1c1c1e7f6f7ad8c8daef5f6f400000000000000
dddedfcf000000edebfeff00000000000000000000000000000000000000000000000000000000110012131e000a0e11000012133d3e3f21231e00001d0068000f1c3008231e001c1d00000000000000000000000000000f1c000d0030000a11162222232d0e210600000000000000f7b400008c8d0000b5d500001010100000
eeeededd000000edef0000000000790000000000000000000000000000000000000000000000002122222300001a0011121622231e00000000000007093a01020202031b3d3e3f010202031e000000000000000000000102030c000030001a11131b0d003d3e3f1100101010101000d7b40000aaaa0000b5e500101000101000
efff00dc000058efef00000000009a0000000000000000000000000000000000000000000000002a0e000d00001a1f2122230d000000000f0060000d070921222222230f791c68212222230900000000000001033a3a11002403000000002a21231e002b2c2a001100000010001000e7b400009b9c0000b5f500001010100000
ef00000000009aedef0000000000000000000000000000000000000000791c1d000000000000000000790000852a0000000e000000000b0102030c0000000e000d0e0708080808090e000d0000006000000b11240204251200131c501d580f747400273b3c791d1100000010101000f7b40000abac0000b5d500101000101000
ed000000000000eddedf00000000000000000000000000000000003301a0a28a030c60000000000f1d1c4094950f000000001c68581c010316230900000000000000001d0d000f00001c0000000001a0a1a21100120000001224020202020202020202020202022500000000000000d7b4b700baba0000b5e500001010100000
ef200000990000edeeff00000020cf00000000000000000000000000111289002402032632330102020202a4a5030c1c270b010202021413132000000050000f000f0b010202020202030c000020111212001400001200000000001200000000120000120000001200101010101000e7e3f4008c8d00e8e9f500000000000000
ef31003a873a3aedef0000003331260000000000000000000000001f110012000000131e000011120000001200240202020225001212121513310102020202020202022500120000122402033231111200000012000000120000000000001200000000000012000000000000000000f7f3009d8c8d9ef8f9f4f4f40000000000
ef3000fdfefeffedef0000000030000000000000000000000000000011120000120013b400b51100131b000d0e000000000000930000008913301100000000000000000016222206001216231e30111200001622222206001216222222222222222222222222220600101010101000d7f300000000000000000000c500000000
ef300000000000efef0000000099000000000000000000000000000011000012000013b400b5111213000000000000000000808182001f11133011000012000000168922230a1f1100121300003021222222230d1a0e210600131b000000747474747474740f0d1100100000001000e7f300c50000c600d5d6d700000000d800
dbdf0000cf0000edfb3500000000000000000000000000000000000011001200001213b45eb51100131e0000000027680060909192000011133011000000000016230e00001a00212222232d00000074747474002a0000111234350000010202020202020203363700100000001000e7f3000000000000e5e6e70000c500f400
00ef3a00990000effb0000000000000000000000000000000000000021222222222223b400b5212223000000000001028b02a0a1030036371330111200000000130d0000002a000e1a0e0d3d3e010202080808092d001f111234000000111200162222222223363700000000000000f7f30000c7c50000f5f6f70000000000c5
00edff00000000edfb350000000000000000000000000000000000000d00000f1d001cb400b568000f1c0000001f111216222222231e363713301100000012001300a3000000001c2a0f1c1d0b111200131b0d003d3e3f212234350000370000131b505050270b1100101010101000e8d7c50000000000d40000f40000000000
00ef00000000dddefb0000000000000000000000000000000000000000dddede020203b400b50102020300000000110013190e0d0000363713301100000000008a808182000000010202020202111200131e0000005800000000000036370012133907080808081100100000001000f8e700e40000000000c500000000e40000
00ef209a3a3aedeefb3500000000200000000000000000000000000020ed0000120015b400b5111200133a3a3a3a11121300001c279a36371330110012000000139091921c0f0b89120012000014000013201d600fc0c2000000000036370000130c0f001c00001100101010101000e7f7e8e90000c5000000c7000000d3e300
ebff31dddedbdf00ef0000000033310000000000000000000000000031fdec00001200b400b514000024020202022500343500078a002911133011000000000015a0a1a28b020214001200000000000013310102a0a1c1c0c1c200001f111200240202020203363700000000000000f700f8f900000000000000000000c5f300
ef0030dcedeeebfeff000000000030000000000000000000000000003000ed00000016222222222222222397212222063435000e000000111330111622222222222222222222061200138721222222061330212222222206d1d200000011001216222222222336370013c700000000000000c5000000000000000000c600f300
ef003000fdfeff0000000000000030000000000000000000000000003000ef000012131b0e000f74740000a70e0a1f113435000000000011133011131b0d000000000e000f1f21222323871b00000d111330747474000e1100d0000000111200131b000e0000363712130000c50000c7c60000000000c7000000c5000000f300
ef6030cf0000000000000000cf0030000000000000000000000000003232dd0000001300001f010202030000001a00212326320089003637133021231e1c600f000000008700000e1c00872e2f872d11248a020203893911d1d2000000111200131e00008a003637162300000000c60000e40000c5000000000000c70000f400
dddededf000000000000009926323200000000cfce000000000000000000ed001216232d0036370016231e00892a000d000000000000363713300e0a00010202032d001f97383907091ea73839973d2122222222231b001100d00000001100123435003a973a3a11131b000000c700d5d6d700000000d5d6d700000000000000
ed00eeef0000000000000000000000000000dddedbdf0000000000000058ef0000131b3d3e3f1112131b00000d00000f2700000000001f111330001a1f110000133d3e3fa70000000d001a0000a700000e000db10000008b00d2000000110000132e2f070808091113c5000000d800e5e6e700c50000e5e6e7d80000c7f400c6
dcee00ed58ce000000000000000000000000efee00efcf0000cdcf00dddbdbdb22231e0000001100130000000000000709008a00000000111330002a00110000131e58002a000000001c2a5800a71d000000808182005811d1d23a3a3a1112003435000000000d2123000000e8e900f5f6f700000000f5f6f7e8e90000d40000
0000dddededf00ea680058000000cfea00dddf00eeefdbdbdededf00dc600000cf0d1c0f27581112133a583a3a3a3a3a3a3a3a3a3a583a1113301d0058110000133a973a3a583a3a3a873a973a01030c0f1d9091920b012500c0c1c1c1c20000133a3a890c00600f000000c5f8f900d4c700000000c5d4c600f8f90000000000
0000dcee00dddedbdedbdededbdededbdedfdc0000ed000000dddedbdededededbdede01020225002402020202020202020202020202022524020202022500002403a7010202020203a7010203141501028ba0a1a202250000f0120000f000122402020202020202032600c7000000c50000c500c70000000000c7000000c500
__sfx__
310c0000025001d000137000e000157001300018700150001a700180001d7001a0000e0001d000130000e000150001300018000150001a000180001d0001a0000000000000000000000000000000000000000000
0110000c025551d010137550e010157551301018755150101a755180101d7551a0100e0001d000130000e000150001300018000150001a000180001d0001a0000000000000000000000000000000000000000000
0110000c035551d010137550f010157551301018755150101a755180101d7551a010035001d000137000f000150001300018000150001a000180001d0001a0000000000000000000000000000000000000000000
011000182655026510265101d00029550295102951000000285502851028510000002455024510245100000000000000000000000000000000000000000000000000000000000000000000000000000000000000
011000001a010035151d010137150f010157151301018715150101a715180101d7151a000035001d000137000f000150001300018000150001a000180001d0001a00000000000000000000000000000000000000
010c00001a7401a7201a7101a7101c7401c7201c7101c7101d7401d7201d7101d7102474024720247102471028740287202871028710267402672026710267102174021720217102171024740247202471024710
010c0000237402372023710237101f7401f7201f7101f710217402172021710217101c7401c7201c7101c7101d7401d7201d7101d7101f7401f7201f7101f710187401872018710187101c7401c7201c7101c710
010c00001a7501a7301a7201a7101c7001c7001c7001c7001a7201a7101a7101a7002470024700247002870013750137301372013710267002670026700217001372013710137101370024700247002470000000
010c00001a7501a7301a7201a7101c7001c7001c7001c7001a7201a7101a7101a700247002470024700287001f7501f7301f7201f710267002670026700217001f7201f7101f7101370024700247002470000000
010c000032535320003200530305305350000032000000002b5250000030000000002d52500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
010c000032535003000030030305305350000032000000002b5250000030000000002d52500000000000000028515000000000000000295150000000000000002851500000000000000024515000000000000000
010c00001a7401a7201a7101a7101c7401c7201c7101c7101d7401d7201d7101d7102474024720247102471028740287202871028710267402672026710267102b7402b7202b7102b71029740297202971029710
010c000028740287202871028710267402672026710267102474024720247102471023740237202371023710217402172021710217101a7401a7201a7101a7102174021720217102171026740267202671026710
010c00002b7502b7302b7202b7101c7001c7001c7001c7002b7202b7102b7101a7002470024700247002870024750247302472024710267002670026700217002472024710247101370024700247002470000000
010c0000297502973029720297101c7001c7001c7001c7002972029710297101a7002470024700247002870022750227302272022710267002670026700217002272022710227101370024700247002470000000
0110000c07755110101575513010167551301018755150101a75518010117551a0100e0001d000130000e000150001300018000150001a000180001d0001a0000000000000000000000000000000000000000000
0110000c0275518010107550e01011755100101375511010157551301018755150100e0001d000130000e000150001300018000150001a000180001d0001a0000000000000000000000000000000000000000000
0110000c08755160100a755080100c7550a0100f7550c010147550f01016755140100a5001d000130000e000150001300018000150001a000180001d0001a0000000000000000000000000000000000000000000
0110000c007551301007755000100c755070100e7550c0100f7550e010137550f0100a5001d000130000e000150001300018000150001a000180001d0001a0000000000000000000000000000000000000000000
0110000c005551b010117550c0101375511010167551301018755160101b755180100c0001b000110000c0001300011000160001300018000160001b000180000000000000000000000000000000000000000000
010c0000130361a0361d03621036130261a0261d02621026130161a0161d01621016130161a0161d01621016130361a0361d03622036130261a0261d02622026130161a0161d01622016130161a0161d01622016
010c0000130361a0362103624036130261a0262102624026130161a0162101624016130161a0162101624016130361a0362203626036130261a0262202626026130161a0162201626016130161a0162201626016
010c00001d0362103626036290361d0262102626026290261d0162101626016290161d016210162601629016150361c0361d03621036150261c0261d01621016150161c0161d01621016150161c0161d01621016
010c0000150261a0261c0261d026150161a0161c0161d016150161a0161c0161d016150161a0161c0161d0160e02615026180261c0260e01615016180161c0160e01615016180161c0160e01615016180161c016
010c00001403616036180361b0361402616026180261b0261401616016180161b0161401616016180161b01614036180361b0362003614026180261b0162001614016180161b0162001614016180161b01620016
010c0000180361b0362003622036180261b0262002622026180161b0162001622016180161b016200162201618036200362403627036180262002624016270161801620016240162701618016200162401627016
010c00001b0361f03624036270361b0261f02624026270261b0161f01624016270161b0161f0162401627016180361b0361f03624036180261b0261f02624026180161b0161f01624016180161b0161f01624016
010c0000180361a0361b03622036180261a0261b02622026180161a0161b01622016180161a0161b0162201616036180361b0361f03616026180261b0261f02616016180161b0161f01616016180161b0161f016
0110000c0a755180100c7550a0100e7550c010117550e010167551101018755160100c5001f000150001000017000150001a000170001c0001a0001f0001c0000200002000020000200002000020000200002000
010c00001a0361d03622036260361a0261d02622026260261a0161d01622016260161a0161d01622016260161a0361b0361d036220361a0261b0261d016220161a0161b0161d016220161a0161b0161d01622016
010c00001102616026180261d0261101616016180161d0161101616016180161d0161101616016180161d0160c0160e01611016160160c0160e01611016160160c0160e01611016160160c0160e0161101616016
011000002953229512295120050028532285122851200500245322451224512005002653226512265122651226512265122651226512265122651226512265120000000000000000000000000000000000000000
011000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000265322651228532285120000000000000000000000000000000000000000
011000002953229512295120050028532285122851200500245322451224512005002153221512215122151221512215122151221512215122151221512215120000000000000000000000000000000000000000
011000002c5322c5122c512005002b5322b5122b51200500275322751227512005002453224512245122451224512245122451224512245122451224512245120000000000000000000000000000000000000000
011000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001b5321b512205322051224532245120000000000000000000000000000000000000000
0110000026532265122651200500245322451224512005002b5322b5122b512005002653226512265122651226512265122651226512265122651226512265120000000000000000000000000000000000000000
011000002953229512295120050028532285122851200500295322951229512005003053230512305123051230512305123051230512305123051230512305120000000000000000000000000000000000000000
0110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002d5322d51230532305120000000000000000000000000000000000000000
0110000032532325123251200500305323051230512005002e5322e5122e512005002753227512275122751227512275122751227512275122751227512275120000000000000000000000000000000000000000
011000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002453224512265322651227532275120000000000000000000000000000000000000000
0110000029532295122951200500225322251222512005001d5321d5121d512005002253222512225122251222512225122251222512225122251222512225120000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0204000023620286302d640306403364034640356403564033640306402e6402b64025640206401d6401a6401764013640106400e6300d6300b6200a610096100761005610046100361003610026100261002610
000400000875016750000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
010100000c7501075012750160501705017050190501a0501b0501d0401f030200102600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00010000103201d610146001d600283201d330082301b600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000200000533004330073300a3300e3301133014330153300633005320073200a3200d3200f320103200631004310093100d31010310160001c000220001f0000460006600087000a2000b2000c2000e20011000
00030000170101c5201f7402175022750185501d550215502655029550170301c5301f7302173022730185301d530215302653029530170101c5101f7102171022710185101d5102151026510295102340022400
000200001961013310126200e320196300a3300b3500e650123501265017340186401f3400a6401533015630123300d6300d3200c320096200f3200a610173100b6101f310096101231007610113100361006310
01010000053703c2702d370142603625028340132401b2500f2500c250122400764005440034300263001430053303c2302d330142203621028310132101b2200f2200c220122200761005410034100261001410
00020000173100c310113101b3201f320044200161003600016000060000000000000000000000000000000000000256000000000000000000000000000000000000000000000000000000000000000000000000
000100002061018620006002f33025310203100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0102000039060313602e060273601f06019360137600b760077600476002760017600076036060290302003016030100300a0300903020010110100b010050100201000010000500000000000000000000000000
0001000000670076702b5502704023040200401c740187402855025550210501d030167300e7301f5401d5401904016020130200e72005720175301553013030110300e0100771000710111000a1000710004100
0008000004074070740b0740f0741307404064070640b0640f0641306404054070540b0540f0541305404044070440b0340f0341303404024070240b0240f0141301404014070140b0140f014130140400407004
__music__
01 01000044
00 01000044
00 02000044
00 02000044
00 01090044
00 010a0044
00 02090044
00 020a0044
00 01050944
00 01060a44
00 02070944
00 02080a44
00 010b0944
00 010c0a44
00 020d0944
00 020e0a44
00 0f141f44
00 0f152044
00 10162144
00 10170044
00 11182244
00 11192344
00 121a2444
00 121b0044
00 0f141f44
00 0f152044
00 10162544
00 10172644
00 11182744
00 11192844
00 1c1d2944
02 1c1e4344


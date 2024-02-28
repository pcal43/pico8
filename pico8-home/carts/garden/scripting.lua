





-- scripting variables
-------------------------------
text = nil
text_color = 7
responses = nil
ans = 1
routine = nil
script_active = false

-- initiate a script
function script_run(func)
	routine = cocreate(function()
		script_active = true
		func()
		script_active = false
	end)
	coresume(routine)
end

-- this is called every frame
-- and player input is ignored,
-- as long as there is a script
-- active.
function script_update()
	coresume(routine)
end


-- script commands
-------------------------------

function reveal_text(str)
	text = ""
	for i=1, #str do
		text = text..sub(str,i,i)
		yield()
	end
end

function say(str)
	reveal_text(str)
	repeat
	 -- every time we call yield()
	 -- we're saying "that's all
	 -- for now, come back here
	 -- next frame"
		yield()
	until btnp(5)
	text = nil
end

function announce(str)
	text = str
	text_color = 12
	repeat
		yield()
	until btnp(5)
	text = nil
	text_color = 7
end

function ask(str, ...)
	reveal_text(str)
	responses = {...}
	ans = 1
	repeat
		yield()
		if btnp(2) and ans > 1 then
			ans -= 1
		elseif btnp(3) and ans < #responses then
			ans += 1
		end
	until btnp(5)
	text = nil
	responses = nil
end

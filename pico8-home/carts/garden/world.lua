
function initWorld() 

    -- make player top left
  p1 = add(actors, { x=6, y=5, dx=0, dy=0, frame=0, sprite=0, inertia=.4, t=0 })

  
  --add(items, { name = "firewood", sprite = 3, x = 8, y = 7 })
  --add(items, { name = "matches", sprite = 4, x = 2, y = 9 })
  
  
  add(inventory, { name = "rose", sprite = 48 })
  add(inventory, { name = "hydrangea", sprite = 49  })
  add(inventory, { name = "carnation", sprite = 50  })
  add(inventory, { name = "mushroom", sprite = 51  })
  add(inventory, { name = "shovel", sprite = 5  })
  inventorySelection = 1
  
  local mloc = { x=0, y=0 }
  local t = 0
  
  isSnowing = false
  timeOfDay = 2


  add(warps, { 8, 4, 102, 11 })
  add(warps, { 102, 12, 8, 5 })
  add(warps, { 103, 12, 8, 5 })
  


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

## TODO list
- MOAR LEVEL DESIGN
- game flow, edit controls
- add layered tile rendering (so items can go inside boxes)
- extend conveyor drawing into gaps on corners

## more tiles
- transmitter.  maybe 3 different colors
- sensor-filter.  sensor that only pulses when specific item type enters?
- wiring (redstone)
- tunnel/bridge?
- pusher?  push item to next conveyor belt over?  how does timing work?  how does it actually make things interesting
- item teleporter?  or maybe just warp around edges?  YES.  early levels have brick walls around.  but then holes pop up and boom they can warp around pacman style.  that opens up tons of possibilites

## later
- i think outbound rule resolution needs to be rethought.  it really should be: "I will keep going straight until I have to stop."  Priority isn't a thing until a choice has to be made about which way to turn.  Maybe it should just be as simple "as always turn right if possible, otherwise turn left".  only problem here is what do we do about bins - those items aren't going anyhwere.  do we remember which way they were going?  what about the start?  maybe the same belts-only rule, tie goes to the right
- eventually likely to run out of 8x8.  consider scrolling?  or maybe just multiple rooms.  could use walls to enhance the effect.  or just no.
- you need to save their solutions, not just whether they finished the level
- maybe draw checkered flag for cash tile
- decorations on box tiles should be 8x8 sprites
- maybe instead of food it's making sentences by arranging letters?  or doing anagrams?  :/  maybe thats a new game with the same engine
- change clock to repeater.  rebroadcasts with fixed delay in directions not triggered from.  triggering again resets the count?


## done
- ~~diverter~~
- ~~create Items class~~
- ~~get Mixer working.  most efficient to store bit per item, save lowest 2-3 bits for timing/delay~~
- ~~Recipes~~
- ~~NO: on mixer tile, maintain a 'swapped' bit that flips display order in case higher item arrives first.  just visual ~~
- ~~should probably add a Direction class, dx/dy everywhere is annoying~~
- ~~and position while we're at it~~
- ~~fix output direction stuff~~
- ~~wall~~
- ~~direction choice algo: most intuitive thing is for items to continue in a straight line.~~
- ~~...but: this needs to be determined statically, and the display during edit should indicate where the things is going to go.  can draw part of conveyor belt and maybe close of the 'doors' on the other sides.  so even if they hit a weird case, theyll get a heads up rather than waiting for it to crash during playback~~
- ~~goal tile~~
- ~~levels storage model~~
- ~~sensor.  not a belt - should be a box with same exit rules as others.  pulses when item enters.~~
- convert Map methods to be Position-based
- ~~create class for 'actors', probably rename to just item (vs itemType)~~
- ~~animate belts~~

## links
- https://paulwatt526.github.io/wattageTileEngineDocs/luaOopPrimer.html


## TODO list

- create Items class
- get Mixer working.  most efficient to store bit per item, save lowest 2-3 bits for timing/delay
- change clock to repeater.  rebroadcasts with fixed delay in directions not triggered from.  triggering again resets the count?
- should probably add a Direction class, dx/dy everywhere is annoying
- and position while we're at it
- MOAR LEVEL DESIGN

## more tiles
- wall
- transmitter.  maybe 3 different colors
- diverter
- sensor.  not a belt - should be a box with same exit rules as others.  pulses when item enters.
- sensor-filter.  sensor that only pulses when specific item type enters
- wiring (redstone)
- pusher?  push item to next conveyor belt over?  how does timing work?  how does it actually make things interesting
- item teleporter?  or maybe just warp around edges?  YES.  early levels have brick walls around.  but then holes pop up and boom they can warp around pacman style.  that opens up tons of possibilites


## later
- eventually likely to run out of 8x8.  consider scrolling?  or maybe just multiple rooms.  could use walls to enhance the effect
- you need to save their solutions, not just whether they finished the level

- direction choice algo: most intuitive thing is for items to continue in a straight line.
- ...but: this needs to be determined statically, and the display during edit should indicate where the things is going to go.  can draw part of conveyor belt and maybe close of the 'doors' on the other sides.  so even if they hit a weird case, theyll get a heads up rather than waiting for it to crash during playback

- maybe draw checkered flag for cash tile
- decorations on box tiles should be 8x8 sprites
- on mixer tile, maintain a 'swapped' bit that flips display order in case higher item arrives first.  just visual

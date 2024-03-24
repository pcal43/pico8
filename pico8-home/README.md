
## MVP
- magnetic cursor
- basic title screen
- basic end screen

## POST RELEASE
- level select
- extend conveyor drawing into gaps on corners
- draw wiring accurately
- clean up brake animation timing.  don't animate belt until start of tick where brake was disengaged
- add layered tile rendering (so items can go inside boxes)
- edge wrap
- add pistons
- maybe brakes shouldn't display red after win, just looks ugly with green

ok, the way the collision thing needs to work is: each item has a 4 element array, one per direction.  when figuring out next moves, have to remember on a per-direction basis which ways are 'bad' so you can start eliminating them.
actually no you just need to build a priority tree properly

## more tiles
- sensor-filter.  sensor that only pulses when specific item type enters?
- tunnel/bridge?
- pusher?  push item to next conveyor belt over?  how does timing work?  how does it actually make things interesting?  ... PISTON.  can be used to either push items or to hard-block progress.  probably do need one of these
- or maybe just warp around edges?  YES.  early levels have brick walls around.  but then holes pop up and boom they can warp around pacman style.  that opens up tons of possibilites
- switch, allows pulse to get through (or not)


## later
- maybe letters should turn green as they get hooked up in the correct sequence.  play a little ascending tone as they get more and more connected.
- i think outbound rule resolution needs to be rethought.  it really should be: "I will keep going straight until I have to stop."  Priority isn't a thing until a choice has to be made about which way to turn.  Maybe it should just be as simple "as always turn right if possible, otherwise turn left".  only problem here is what do we do about bins - those items aren't going anyhwere.  do we remember which way they were going?  what about the start?  maybe the same belts-only rule, tie goes to the right
- change clock to repeater.  rebroadcasts with fixed delay in directions not triggered from.  triggering again resets the count?
- could think about having optional 9x9 and having edge tiles be half-off the screen, just for aesthetics/borders/centering

## done
- ~~gamepad controls~~
- ~~play sound when win~~
- ~~pause winning tiles when win~~
- ~~change letters to green when win~~
- ~~THREE more levels~~- ~~cant push more than one tile~~
- ~~fix on momentary buttons so that it pulses only once regardless of timing~~
- ~~fix bugs when more than two collisions~~
- ~~fix freezing when two arrive at the spot at same time.  need to pick a winner~~
- ~~fix so last frame always gets rendered when they win~~
- ~~wiring (redstone)~~
- ~~maybe instead of food it's making sentences by arranging letters?  or doing anagrams?  :/  maybe thats a new game with the same engine~~
- ~~decorations on box tiles should be 8x8 sprites~~
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


## no
- ~~item teleporter? ~~
- ~~eventually likely to run out of 8x8.  consider scrolling?  or maybe just multiple rooms.  could use walls to enhance the effect.  or just no.~~
- ~~you need to save their solutions, not just whether they finished the level~~
- ~~maybe draw checkered flag for cash tile~~
- ~~transmitter.  maybe 3 different colors~~
# Infiltrator Gamemode
GitHub release of the Infiltrator gamemode.  
As seen as STAGE 3 of STAG Servers during September 2025.

## Summary
Infiltrator is a hardcore asymmetric stealth gamemode that pits a single sneaky  
infiltrator against a large team of facility guards.  
The solo infiltrator must enter the sprawling facility, complete six objectives  
around the interior, then extract at any of the three locations.  
The team of heavily-armed guards must hunt down the infiltrator and take him out  
before he completes the objectives.  
The guards have infinite lives; the infiltrator has only one.

## Warning
This gamemode was relatively rushed and the code has few comments.  
It works, but it may not work well.  It's open-source, have fun.  
I'll fix any major problems that come up.

## Disclaimer
This gamemode includes a modified version of [Active Camouflage](https://steamcommunity.com/sharedfiles/filedetails/?id=308977650) by [piqey](https://steamcommunity.com/profiles/76561198036583412).  
This version changes the appearance of players when invisible.  
I do not claim ownership of the Active Camo weapon.  

## Considerations
There are several things in this gamemode that I could not test for several reasons:  
- Spectate-only mode is completely untested.  
- Avoid infiltrator mode is completely untested.  
- The queue system is untested and probably does not work ideally.  

My friends don't like reading or listening so they didn't help me test.

## Installation
Drop the `infiltrator` folder in your server's addon folder.  
Set the server to run the `infiltrator` gamemode.  
Set the server to run the map `gm_boreas`.  It does not support any other maps.  
Make sure you also have the **requirements** found below.  
The gamemode will automatically force connecting clients to download required content.

## Requirements
The server should be hosting [this collection](https://steamcommunity.com/sharedfiles/filedetails/?id=3251790810).  
**The server also requires the [GetSoundscapeFn binary module](https://github.com/SweptThrone/GetSoundscapeFn).**  
Infiltrator uses this module to determine when players are outside in order to  
cause them to freeze to death.  Unforeseen issues will follow without it installed.

## Contributing
I try to support everything I make forever, so if you found an issue, feel free  
to open an issue or submit a fix or something.  I'm not completely sure how  
public GitHub repositories are supposed to work.  

I'm not really interested in adding new features.  It's a completed gamemode.  

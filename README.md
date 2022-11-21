# PDTracker-linux-executable  
A set of source files necessary to compile a linux executable using a steam API .so library. Doesn't actually get compiled.  
# Requirements
*  a machine running on linux (using Ubuntu 22.04 myself)
*  C++ compiling tools (only using g++, no make)
*  Steamworks SDK source files (if unsure of validity of the files in the repo, get your own archive [here](https://partner.steamgames.com) (juts log into your steam account) - you'll need the **header files** located in *sdk/public/steam/* and the **libsteam_api.so** in *sdk/redistributable_bin/linux64/*
*  installed and running Steam client - only necessary for testing the compiled executable
*  a copy of PDTH in your steam library - only necessary for testing the compiled executable, having the game installed is not required
# File descriptions:  
* *headers* - a collection of all the headers used by steam API
* *linux32* - put it here for  "just in case" reasons - the used .so file is x64
* *sdk* - a literal copy of the headers above, except it's located in the "original" path (how the original sdk archive stores them)
* *PDTracker.cpp* - the main code file. It's win-compiled file is working fine, the only difference here is the "#pragma comment" lib link
* *libsteam_api.so* - a library, a linux-compatible analog of steam_api64.dll
* *steam_appid.txt* - just a .txt with PDTH's app id. Shouldn't be necessary for the release executable file, left as a precaution
# Tested g++ command:
`$ g++ -L./ -l:libsteam_api.so -oPDTracker PDTracker.cpp`  
**command description:** telling gcc to compile a C++ code in the *PDtracker.cpp* file into a *PDTracker* executable located in a local directory ( *./* ) with the use of the *libsteam_api.so* library  
**issue:** undefined references to steam API functions  
# Expected output
For the working program, the result should be a *lobbies.txt* file (created if didn't exist before) consisting of either an error message (connection failed/no lobbies) or the info about currently active PDTH lobbies. Running Steam client with PDTH in the library is required.
# Potential starting point
To get behind the process it might be a good practice to replicate a compilation process shown on this [thread](https://stackoverflow.com/questions/65461498/how-do-you-compile-script-using-steamworks-sdk-on-linux) (can't get this to work, legit lost for words).

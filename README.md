# PDTracker-linux-executable  
A set of source files necessary to compile a linux executable using a steam API .so library. Doesn't actually get compiled.  
# File descriptions:  
* *headers* - a collection of all the headers used by steam API
* *linux32* - put it here for  "just in case" reasons - the used .so file is x64
* *sdk* - a literal copy of the headers above, except it's located in the "original" path (how the original sdk archive stores them)
* *PDTracker.cpp* - the main code file. It's win-compiled file is working fine, the only difference here is the "#pragma comment" lib link
* *libsteam_api.so* - a library, a linux-compatible analog of steam_api64.dll
* *steam_appid.txt* - just a .txt with PDTH's app id. Shouldn't be necessary for the release executable file, left as a precaution
# Tested g++ command:
`$ g++ -L./ -l:libsteam_api.so -oPDTracker PDTracker.cpp`  
**command description:** telling gcc to compile a C++ code in a *PDtracker.cpp* file into a *PDTracker* executable located in a local directory ( *./* ) with the use of *libsteam_api.so* library  
**issue:** undefined references to steam API functions  

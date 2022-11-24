# PDTracker-linux-executable  
A set of source files necessary to compile a linux executable using a steam API .so library.

# Requirements
- machine running linux (tested on Ubuntu 22.04, Arch Linux)
- Steamworks SDK, available [here](https://partner.steamgames.com/downloads/list) (download might require Steam login) - you'll need the **header files** located in *sdk/public/steam/* and the **libsteam_api.so** in *sdk/redistributable_bin/linux64/*
- installed and running Steam client (only during runtime)
- copy of PAYDAY: The Heist in your steam library, not necessarily installed (only during runtime)

# Building
Build requirements: `curl`, `unzip`, `gcc`, `make`.
The `Makefile` takes care of everything, including downloading dependencies, so it's as simple as running `make build`.
It it possible to override some build options:
 - `SDK_ZIP_FILEPATH` - specify different location for the SDK to not download it from Internet - sometimes Steam can respond with an HTML page instead of providing us with a .zip file.

# Expected output
For the working program, the result should be a **lobbies.txt** file (created if didn't exist before) consisting of either an error message (connection failed/no lobbies) or the info about currently active PDTH lobbies. Running Steam client with PAYDAY: The Heist in the library is required.

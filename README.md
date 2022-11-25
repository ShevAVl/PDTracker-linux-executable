# PDTracker-linux-executable  
A set of source files necessary to compile a linux executable using a steam API .so library.

# Requirements
- machine running linux (tested on Ubuntu 22.04, Arch Linux)
- Steamworks SDK, available [here](https://partner.steamgames.com/downloads/list) (download might require Steam login) - you'll need the **header files** located in *sdk/public/steam/* and the **libsteam_api.so** in *sdk/redistributable_bin/linux64/*
- installed and running Steam client with a copy of PADAY: The Heist in library, not necessarily installed (only during runtime)

# Building
Build requirements: `curl`, `unzip`, `gcc`, `make`.  
The `Makefile` takes care of everything, including downloading dependencies, so it's as simple as running `make build`.  
If the build process fails with an error message like: `unzip:  cannot find zipfile directory in one of ./build/steamworks_sdk.zip` that means Steamworks SDK zipfile wasn't downloaded successfully - download it manually and specify its location with the `SDK_ZIP_FILEPATH` environment variable.  
For more advanced usage, it it possible to override some build options with environment variables, see Makefile for more information

# Expected output
For the working program, the result should be a **lobbies.txt** file (created if didn't exist before) consisting of either an error message (connection failed/no lobbies) or the info about currently active PDTH lobbies. Running Steam client with PAYDAY: The Heist in the library is required.

# path to the directory containing third party libraries
LIB_PATH := ./lib

# path to the directory containing Steamworks' API's headers
SDK_PATH := ./sdk

# list of source files, every single one is on a separate line;
# ending lines with '\' lets us declare a multi-line variable
SOURCES := \
	PDTracker.cpp \

# name of resulting executable
TARGET := PDTracker
PLATFORM ?= linux64

.PHONY: sdk build

default: build appid
all: build appid

# override path to the SDK's file (NOT DIRECTORY!) to tell Makefile we already have the file downloaded and there's no need to get it from Internet
# this could be useful in case Steam gives us a HTML page instead of offering a .zip to download
SDK_ZIP_FILEPATH ?= 
# name of the zip file retrieved from Internet, used in case you want to get a different version than the default, latest one
SDK_NAME ?= steamworks_sdk.zip

# download Steamworks' SDK in case it hasn't been downloaded yet
# specify the variable below in case SDK has already been downloaded to a different location
ifeq ($(SDK_ZIP_FILEPATH),)
	SDK_ZIP_FILEPATH = ./build/$(SDK_NAME)
download-sdk:
	@if [ ! -f "$(SDK_ZIP_FILEPATH)" ]; then \
		curl -LO --output-dir "build/" "https://partner.steamgames.com/downloads/$(SDK_NAME)"; \
	else \
		echo "sdk has already been downloaded"; \
	fi
else
download-sdk:
	@echo "sdk located at $(SDK_ZIP_FILEPATH)"
endif

# make sure build/ lib/ and sdk/ directories exist before we do our smart things on them
prepare-dirs:
	mkdir -p ./build "$(LIB_PATH)" "$(SDK_PATH)"

# extract and organise stuff we need from Steamworks' SDK
sdk: download-sdk
	# extract library's shared object
	unzip -j -d "$(LIB_PATH)" "$(SDK_ZIP_FILEPATH)" "sdk/redistributable_bin/$(PLATFORM)/libsteam_api.so"
	# extract library's headers
	unzip -j -d "$(SDK_PATH)" "$(SDK_ZIP_FILEPATH)" "sdk/public/steam/*.h"

build: prepare-dirs sdk
	mkdir -p build/bin
	g++ $(SOURCES) -o build/bin/$(TARGET) -I"$(SDK_PATH)" -L"$(LIB_PATH)" -Wl,-rpath,"$(LIB_PATH)" -l:libsteam_api.so

appid:
	echo 24240 > build/bin/steam_appid.txt

clean:
	rm -f \
		build/bin/$(TARGET) \
		build/bin/steam_appid.txt \
		build/steamworks_sdk.zip \
		build/$(SDK_NAME)

clean-sdk:
	rm -f \
		$(SDK_PATH)/*.h \
		$(LIB_PATH)/libsteam_api.so

clean-all: clean clean-sdk

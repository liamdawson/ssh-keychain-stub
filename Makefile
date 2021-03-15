DYLIBS := x86_64.dylib arm64.dylib
OBJS := $(DYLIBS:%.dylib=%.o)

MACOS_SDK_PATH ?= $(shell xcrun --show-sdk-path)
MACOS_TARGET_VERSION ?= $(shell xcrun --show-sdk-version)

$(OBJS): %.o: lib.c
	clang -target $*-apple-macos$(MACOS_TARGET_VERSION) -std=gnu11 -isysroot $(MACOS_SDK_PATH) -c $^ -o $@

$(DYLIBS): %.dylib: %.o
	clang -target $*-apple-macos$(MACOS_TARGET_VERSION) -isysroot $(MACOS_SDK_PATH) -dynamiclib -install_name /usr/local/lib/ssh-keychain-stub.dylib "$(MACOS_SDK_PATH)/usr/lib/ssh-keychain.tbd" -compatibility_version 1 -current_version 1 -o $@

ssh-keychain-stub.dylib: $(DYLIBS)
	lipo -create $^ -output $@

.PHONY: install clean

clean:
	rm *.o *.dylib

install: ssh-keychain-stub.dylib
	install ssh-keychain-stub.dylib /usr/local/lib/

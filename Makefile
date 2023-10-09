LIBRARY_NAME = pam_watchid.so
DESTINATION = /usr/local/lib/pam
ARCH := $(shell uname -m)
ifeq ($(ARCH), arm64)
TARGET := arm64-apple-darwin20.1.0
else
TARGET := x86_64-apple-darwin20.1.0
endif

all:
	swiftc watchid-pam-extension.swift -o $(LIBRARY_NAME) -target $(TARGET) -emit-library

install: all
	mkdir -p $(DESTINATION)
	cp $(LIBRARY_NAME) $(DESTINATION)/$(LIBRARY_NAME)
	chmod 444 $(DESTINATION)/$(LIBRARY_NAME)
	chown root:wheel $(DESTINATION)/$(LIBRARY_NAME)

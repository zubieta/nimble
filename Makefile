PROG ?= nimble
PREFIX ?= /usr
DESTDIR ?= $(PREFIX)/bin

all: install

install:
	@ln -vfs $(shell pwd)/libexec/$(PROG) $(DESTDIR)/$(PROG)
	@echo "$(PROG) is installed succesfully"
	@echo

uninstall:
	@rm -vf $(DESTDIR)/$(PROG)

.PHONY: install uninstall

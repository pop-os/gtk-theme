SHELL = /bin/bash
COLOR_VARIANTS = '' '-dark'
SIZE_VARIANTS = ''
COMPONENTS = 'gtk-' 'plank'
GTK_VERSIONS = '3.22' '2.0'
SASSC_OPT=-M -t expanded
BASE_DIR=/usr/share/themes
REPODIR=$(CURDIR)
SRCDIR=$(REPODIR)/src
GNOMEVER=3.26

all: sass assets

assets:

clean:
	-rm -rf build

uninstall:
	-rm -rf $(DESTDIR)/usr/share/themes/Pop
	-rm -rf $(DESTDIR)/usr/share/themes/Pop-dark
	-rm -rf $(DESTDIR)/usr/share/themes/Pop-light
	-rm -rf $(DESTDIR)/usr/share/themes/Pop-compact
	-rm -rf $(DESTDIR)/usr/share/themes/Pop-light-compact
	-rm -rf $(DESTDIR)/usr/share/themes/Pop-dark-compact
	-rm -rf $(DESTDIR)/usr/share/themes/Pop-slim
	-rm -rf $(DESTDIR)/usr/share/themes/Pop-dark-slim
	-rm -rf $(DESTDIR)/usr/share/themes/Pop-light-slim

install:


assets-gtk2:


assets-gtk3:


recolor:


sass: gtk3
	@echo "** Generating the CSS..."

gtk2:


prepare:
	@echo "** Setting up a build environment **"
	mkdir -p build
	for color in $(COLOR_VARIANTS); do \
	  for size in $(SIZE_VARIANTS); do \
	    mkdir -p build/Pop$$size$$color; \
	    for component in $(COMPONENTS); do \
	      if [ "$$component" = "gtk-" ]; then \
	        for version in $(GTK_VERSIONS); do \
	          cp -r src/$$component$$version build/Pop$$size$$color/; \
	        done; \
	      else \
	        cp -r src/$$component build/Pop$$size$$color/; \
	      fi; \
	    done; \
	  done; \
	done

gtk3: prepare
	@echo "** Generating GTK3..."

	for color in $(COLOR_VARIANTS); do \
	  for size in $(SIZE_VARIANTS); do \
	    for version in $(GTK_VERSIONS); do \
	      if [ "$$version" != "2.0" ]; then \
	        sassc $(SASSC_OPT) build/Pop$$size$$color/gtk-$$version/gtk$$color$$size.{scss,css}; \
	      fi; \
	    done; \
	  done; \
	done


.PHONY: all install uninstall gtk3 gtk2 sass recolor assets-gtk3 assets-gtk2 clean install-gnome-shell gnomeshell

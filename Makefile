SHELL = /bin/bash
COLORS = '' '-dark'
SIZES = ''
COMPONENTS = 'gtk' 'plank'
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

	for color in $(COLORS); do \
	  for size in $(SIZES); do\
	    export dirname="Pop$$color$$size"; \
	    mkdir -p build/$$dirname; \
	    for component in $(COMPONENTS); do \
	      if [ "$$component" = "gtk" ]; then \
		for version in $(GTK_VERSIONS); do \
		  if [ "$$version" != "2.0" ]; then \
		    cp -r \
		      src/gtk-common \
		      build/$$dirname/gtk-$$version; \
		    cp -r \
		      src/gtk-$$version \
		      build/$$dirname/; \
		  else \
		    cp -r \
		      src/gtk-$$version \
		      build/$$dirname; \
		  fi; \
		done; \
	      else \
		cp -r \
		  src/$$component \
		  build/$$dirname/; \
	      fi; \
	    done; \
	  done; \
	done

gtk3: prepare
	@echo "** Generating GTK3..."

	for color in $(COLORS); do \
	  for size in $(SIZES); do \
	    for version in $(GTK_VERSIONS); do \
	      if [ "$$version" != "2.0" ]; then \
	        sassc $(SASSC_OPT) build/Pop$$size$$color/gtk-$$version/gtk$$color$$size.{scss,css}; \
	      fi; \
	    done; \
	  done; \
	done


.PHONY: all install uninstall gtk3 gtk2 sass recolor assets-gtk3 assets-gtk2 clean install-gnome-shell gnomeshell

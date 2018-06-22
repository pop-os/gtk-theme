SHELL = /bin/bash
COLORS = '' '-dark'
SIZES = ''
THEME_NAME = "Pop-4"
COMPONENTS = 'gtk' 'plank'
GTK_VERSIONS = '3.22' '2.0'
OLDEST_VERSION = 'gtk-3.22'
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
	-rm -rf $(DESTDIR)/usr/share/themes/$(THEME_NAME)
	-rm -rf $(DESTDIR)/usr/share/themes/$(THEME_NAME)-dark
	-rm -rf $(DESTDIR)/usr/share/themes/$(THEME_NAME)-light
	-rm -rf $(DESTDIR)/usr/share/themes/$(THEME_NAME)-compact
	-rm -rf $(DESTDIR)/usr/share/themes/$(THEME_NAME)-light-compact
	-rm -rf $(DESTDIR)/usr/share/themes/$(THEME_NAME)-dark-compact
	-rm -rf $(DESTDIR)/usr/share/themes/$(THEME_NAME)-slim
	-rm -rf $(DESTDIR)/usr/share/themes/$(THEME_NAME)-dark-slim
	-rm -rf $(DESTDIR)/usr/share/themes/$(THEME_NAME)-light-slim

install:
	cp -r build/* $(DESTDIR)/usr/share/themes/
	#gedit build/$(THEME_NAME)/gtk-3.22/gtk.css

assets-gtk2:


assets-gtk3:


recolor:


sass: gtk3
	@echo "** Generated the CSS..."

gtk2:


prepare: lint
	@echo "** Setting up a build environment **"

	for version in $(GTK_VERSIONS); do \
	  mkdir -p src/gtk-$$version; \
	done

	for color in $(COLORS); do \
	  for size in $(SIZES); do\
	    export dirname="$(THEME_NAME)$$color$$size"; \
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
	    cp metadata/index.theme.in build/$$dirname/index.theme; \
	    sed -i -e \
	      s/"~theme~name"/$(THEME_NAME)$$color$$size/g \
	      build/$$dirname/index.theme; \
	    ln -s $(OLDEST_VERSION) build/$$dirname/gtk-3.0; \
	  done; \
	done

gtk3: prepare
	@echo "** Generating GTK3..."

	for color in $(COLORS); do \
	  for size in $(SIZES); do \
	    for version in $(GTK_VERSIONS); do \
	      if [ "$$version" != "2.0" ]; then \
	        sassc $(SASSC_OPT) build/$(THEME_NAME)$$size$$color/gtk-$$version/gtk$$color$$size.{scss,css}; \
	      fi; \
	    done; \
	  done; \
	done

lint:
	@echo "** Checking for Code Quality..."
	sass-lint -vqc scss-lint.yml src/gtk-common/scss/**/*.scss


.PHONY: all install uninstall gtk3 gtk2 sass recolor assets-gtk3 assets-gtk2 clean install-gnome-shell gnomeshell

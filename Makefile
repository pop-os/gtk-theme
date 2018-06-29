SHELL = /bin/bash
COLORS = '' '-dark'
SIZES = ''
GTK_VERSIONS = '3.22' '2.0'
OLDEST_VERSION = 'gtk-3.22'
BASE_DIR=/usr/share/themes
REPODIR=$(CURDIR)
SRCDIR=$(REPODIR)/src
GNOMEVER=3.26

# New variables below:

SHELL = /bin/bash
PREFIX = usr/share/themes
REPO_DIR = $(CURDIR)
SRC_DIR = $(REPODIR)/src
BUILD_DIR = $(REPODIR)/build
THEME_NAME = 'Pop-4'
COMPONENTS = 'gtk3' 'gtk-2.0' 'plank'
DARK = 'FALSE'
LIGHT = 'FALSE'
SLIM = 'FALSE'
GTK3_VERSIONS = '3.22'
GTK3_OLDEST_VERSION = '3.22'
SASSC_OPT=-M -t expanded


all: sass

assets: gtk2
	@echo "** Generating the Assets..."
	cd ./src/gtk-2.0/ && find . -type f -name *.png -exec rm -v '{}' +
	cd ./src/gtk-2.0/ && pwd && ./render-assets.sh
	cd ./src/gtk-2.0/ && ./render-assets-dark.sh

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
	@echo "** Matching Colors"

	cd ./src/gtk-2.0/ && ./recolor-assets.sh > /dev/null


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
		    if [ "$$color" = "-dark" ]; then \
		      echo "copy dark mode"; \
		      cp src/gtk-common/gtk-dark.scss \
		         build/$$dirname/gtk-$$version/gtk.scss; \
	            fi; \
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
	        sassc $(SASSC_OPT) build/$(THEME_NAME)$$size$$color/gtk-$$version/gtk.{scss,css}; \
	        sassc $(SASSC_OPT) build/$(THEME_NAME)$$size$$color/gtk-$$version/gtk-dark.{scss,css}; \
	      fi; \
	    done; \
	  done; \
	done

new-install:
	@echo '** Installing the theme..."
	install="$(DESTDIR)/$(PREFIX)/$(THEME_NAME)"; \
	for component in $(COMPONENTS); do \
	  echo "Installing $$component:"
	  if [ "$$component" == "gtk3" ]; then \
	    for version in $(GTK3_VERSIONS); do \
	      echo "Installing Gtk-$$version"; \
	      install -d $$install; \
	      install -t \
	        $$install \
	        $(BUILD_DIR)/gtk3/gtk-$$version/gtk.css \
	        $(BUILD_DIR)/gtk3/gtk-$$version/gtk-dark.css \
	        $(BUILD_DIR)/gtk3/gtk-$$version/assets; \
	      ln -s $(OLDEST_VERSION) $$install/gtk-3.0; \
	      if [ "$(DARK)" == "TRUE" ]; then \
	        install -d "$$install"-dark; \
	        install -t \
	          "$$install"-dark \
	          $(BUILD_DIR)/gtk3/gtk-$$version/gtk-dark.css \
	          $(BUILD_DIR)/gtk3/gtk-$$version/assets; \
	        cp "$$install"-dark/gtk-dark.css "$$install"-dark/gtk.css; \
	        ln -s $(OLDEST_VERSION) "$$install"-dark/gtk-3.0; \
	      fi; \
	    done; \
	  fi; \
	done

new-gtk3: lint
	@echo '** Generating GTK3...'
	for version in $(GTK3_VERSIONS); do \
	  echo "Building Gtk-$$version:"; \
	  output="$(BUILD_DIR)/gtk3/gtk-$$version"; \
	  mkdir -p $$output; \
	  cp -r $(SRC_DIR)/gtk-common $$output; \
	  cp -r $(SRC_DIR)/gtk-$$version $$output; \
	  sassc $(SASSC_OPT) $$output/gtk.{scss,css}; \
	  sassc $(SASSC-OPT) $$output/gtk-dark.{scss,css}; \
	  if [ "$(LIGHT)" == "TRUE" ]; then \
	    sassc $(SASSC_OPT) $$output/gtk-light.{scss,css}; \
	  fi; \
	  if [ "$(SLIM)" == "TRUE" ]; then \
	    sassc $(SASSC_OPT) $$output/gtk-slim.{scss,css}; \
	    sassc $(SASSC_OPT) $$output/gtk-slim-dark.{scss,css}; \
	  fi; \
	  if [ "$(SLIM)" == "TRUE" ] && [ "$(LIGHT)" == "TRUE" ]; then \
	    sassc $(SASSC_OPT) $$output/gtk-slim-light.{scss,css}; \
	  fi; \
	done

lint:
	@echo "** Checking for Code Quality..."
	sass-lint -vqc scss-lint.yml src/gtk-common/scss/**/*.scss


.PHONY: all install uninstall gtk3 gtk2 sass recolor assets-gtk3 assets-gtk2 clean install-gnome-shell gnomeshell

SHELL = /bin/bash
COLOR_VARIANTS = '' '-dark' '-light'
SIZE_VARIANTS = '' '-compact'

all: sass assets

sass:
	./parse-sass.sh

install:
	./install.sh $(DESTDIR)

gtk2:
	cd ./src/gtk-2.0 && ./recolor-assets.sh

gnome-shell:
	cp -v /usr/share/themes/Pop/gnome-shell/pop.css /usr/share/gnome-shell/theme

assets:
	cd ./src/gtk-3.0/gtk-common/ && find . -type f -name *.png -exec rm -v '{}' +
	cd ./src/gtk-2.0/ && find . -type f -name *.png -exec rm -v '{}' +
	cd ./src/gtk-3.0/gtk-common/ && ./recolor-assets.sh
	cd ./src/gtk-2.0/ && ./recolor-assets.sh
	cd ./src/gtk-3.0/gtk-common/ && ./render-assets.sh
	cd ./src/gtk-2.0/ && ./render-assets.sh
	cd ./src/gtk-2.0/ && ./render-assets-dark.sh

clean:
	-rm -rf ./src/gtk-2.0/assets/*.png
	-rm -rf ./src/gtk-2.0/assets-dark/*.png
	-rm -rf ./src/gtk-3.0/gtk-common/assets/*.png
	-rm -rf ./src/gtk-3.0/**/*.css
	-rm -rf ./src/gnome-shell/**/*.css

uninstall:
	-rm -rf $(DESTDIR)/usr/share/themes/Pop
	-rm -rf $(DESTDIR)/usr/share/themes/Pop-dark
	-rm -rf $(DESTDIR)/usr/share/themes/Pop-light
	-rm -rf $(DESTDIR)/usr/share/themes/Pop-compact
	-rm -rf $(DESTDIR)/usr/share/themes/Pop-light-compact
	-rm -rf $(DESTDIR)/usr/share/themes/Pop-dark-compact

new-install:
	

new-sass:
	@echo "** Generating the CSS..."
	
	echo $(COLOR_VARIANTS)
	echo $(SIZE_VARIANTS)
	echo $(SASSC_OPT)
	
	for color in $(COLOR_VARIANTS); do \
	  sassc $(SASSC_OPT) src/gtk-3.0/3.18/gtk$$color.{scss,css}; \
	  for size in $(SIZE_VARIANTS); do \
	    for version in '3.20' '3.22'; do \
	      sassc $(SASSC_OPT) src/gtk-3.0/$$version/gtk$$color$$size.{scss,css}; \
	    done; \
	    # Skip gnome-shell 3.20 and 3.22 \
	    for version in '3.18' '3.24' '3.26'; do \
	      sassc $(SASSC_OPT) src/gnome-shell/$$version/gnome-shell$$color$$size.{scss,css}; \
	      sassc $(SASSC_OPT) src/gnome-shell/$$version/extensions/workspaces-to-dock/workspaces-to-dock.{scss,css}; \
	      sassc $(SASSC_OPT) src/gnome-shell/$$version/pad-osd.{scss,css}; \
	    done; \
	  done; \
	done

.PHONY: all install uninstall

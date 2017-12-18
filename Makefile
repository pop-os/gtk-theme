all: sass assets

sass:
	./parse-sass.sh

install:
	./install.sh $(DESTDIR)
	mkdir $(DESTDIR)/usr/share/themes/Pop/plank/
	mkdir $(DESTDIR)/usr/share/themes/Pop-dark/plank/
	mkdir $(DESTDIR)/usr/share/themes/Pop-light/plank/
	mkdir $(DESTDIR)/usr/share/themes/Pop-compact/plank/
	mkdir $(DESTDIR)/usr/share/themes/Pop-light-compact/plank/
	mkdir $(DESTDIR)/usr/share/themes/Pop-dark-compact/plank/
	cp -vur ./src/plank/dock.theme $(DESTDIR)/usr/share/themes/Pop/plank/dock.theme
	cp -vur ./src/plank/dock.theme $(DESTDIR)/usr/share/themes/Pop-dark/plank/dock.theme
	cp -vur ./src/plank/dock.theme $(DESTDIR)/usr/share/themes/Pop-light/plank/dock.theme
	cp -vur ./src/plank/dock.theme $(DESTDIR)/usr/share/themes/Pop-compact/plank/dock.theme
	cp -vur ./src/plank/dock.theme $(DESTDIR)/usr/share/themes/Pop-light-compact/plank/dock.theme
	cp -vur ./src/plank/dock.theme $(DESTDIR)/usr/share/themes/Pop-dark-compact/plank/dock.theme

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

.PHONY: all install uninstall

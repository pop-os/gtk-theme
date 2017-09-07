all:
	./parse-sass.sh
	cp ./src/gnome-shell/3.24/gnome-shell.css ./src/gnome-shell/3.24/pop.css
	cp ./src/gnome-shell/3.24/gnome-shell.css ./src/gnome-shell/3.22/pop.css
	cp ./src/gnome-shell/3.24/gnome-shell.css ./src/gnome-shell/3.20/pop.css
	cp ./src/gnome-shell/3.24/gnome-shell.css ./src/gnome-shell/3.18/pop.css

install:
	./install.sh $(DESTDIR)

post-install:
	-gtk-update-icon-cache -q $(DESTDIR)/usr/share/icons/Pop

gtk2:
	cd ./src/gtk-2.0 && ./recolor-assets.sh

gnome-shell:
	cp -r $(DESTDIR)/usr/share/themes/Pop/gnome-shell/ /usr/share/gnome-shell/

assets:
	cd ./src/gtk-3.0/gtk-common/ && find . -type f -name *.png -exec rm -v '{}' +
	cd ./src/gtk-2.0/ && find . -type f -name *.png -exec rm -v '{}' +
	cd ./src/gtk-3.0/gtk-common/ && ./recolor-assets.sh
	cd ./src/gtk-2.0/ && ./recolor-assets.sh
	cd ./src/gtk-3.0/gtk-common/ && ./render-assets.sh
	cd ./src/gtk-2.0/ && ./render-assets.sh
	cd ./src/gtk-2.0/ && ./render-assets-dark.sh

uninstall:
	-rm -rf $(DESTDIR)/usr/share/themes/Pop
	-rm -rf $(DESTDIR)/usr/share/themes/Pop-dark
	-rm -rf $(DESTDIR)/usr/share/themes/Pop-light
	-rm -rf $(DESTDIR)/usr/share/themes/Pop-compact
	-rm -rf $(DESTDIR)/usr/share/themes/Pop-light-compact
	-rm -rf $(DESTDIR)/usr/share/themes/Pop-dark-compact

.PHONY: all install uninstall

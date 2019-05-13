<p align="center">
<img src="https://github.com/system76/pop-gtk-theme/raw/master_cosmic/Pop_gtk-logo.png"/>
</p>

-------------------

A GTK+ theme for Pop!_OS 


## Screenshots
-------------------
![Pop GTK+ Theme](screenshots/main.png) ![GNOME Maps](screenshots/pop-maps.png) ![Dark Theme](screenshots/pop-builder.png)


### Required Components
-------------------
Pop supports Gtk+ 3.22.x

 ```
 * Gtk+-3.0             >= 3.22
 * Gtk+-2.0             >= 2.24.30
 * gtk2-engines-pixbuf  >= 2.24.30
 * gtk2-engines-murrine >= 0.98.1
 ```

### Recommendations

- For GTK, use icons alongside [Pop Icon Theme](https://github.com/pop-os/icon-theme)
- For fonts, use:
 > Window Titles: Fira Sans SemiBold 10

 > Interface: Fira Sans Book 10

 > Documents: Roboto Slab Regular 11

 > Monospace: Fira Mono Regular 11


### Installation

Pop is intended to be installed through the package manager. Packages for Ubuntu are available in PPA:
```
sudo add-apt-repository ppa:system76/pop
sudo apt update
sudo apt install pop-theme
```
It's recommended to use the `pop-theme` metapackage, as this will pull in all components of the look. However, individual components can be installed separately, e.g:
```
sudo apt install pop-gtk-theme
```
It's also recommended to restart the GNOME Shell after applying the theme of your choice.

Enter the Shell's command launcher
```
Alt + F2
```

This will restart the Shell after you hit Enter
```
r
```



### Installation from Git Source
----------------------------

###### Note: You must have sassc installed in order to build Pop. Users of 17.04 or later can all build-dependencies using:

```
sudo apt install libtool pkg-config sassc inkscape optipng parallel libglib2.0-dev libgdk-pixbuf2.0-dev librsvg2-dev libxml2-utils
```


1. If previous versions were installed/existed, remove them first.

 ```
 sudo apt remove system76-pop-gtk-theme
 sudo make uninstall
 sudo rm -rf /usr/share/themes/{Pop,Pop-Eta,Pop-Nokto,Pop-Nokto-Eta}
 rm -rf ~/.local/share/themes/{Pop,Pop-Eta,Pop-Nokto,Pop-Nokto-Eta}
 rm -rf ~/.themes/{Pop,Pop-Eta,Pop-Nokto,Pop-Nokto-Eta}
 ```

2. Generate the theme files.

```
make clean
make
```

3. Install the theme.

```
sudo make install
```

#### Rebuilding after modifications:

You shouldn't need to rebuild the entire theme after modifications. If you 
modify only the GTK3 sources, then using `make gtk3` will be sufficient for 
rebuilding the theme. This saves you needing to build the Gtk-2 assets again. 

TODO
----
* Prepare for Steam theming (priority: Low)

Public License
--------------
 GPLv2.0

 > **Note:**
 >
 > SVG files are licensed under CC BY-SA 4.0

Special Thanks to
--------------
 Nana-4, the developer of Materia.
 tista500 and the Adapta Theme Project: https://github.com/adapta-project/

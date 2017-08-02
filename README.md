<p align="center">
<img src="https://github.com/system76/pop-gtk-theme/raw/master/Pop_gtk-logo.png"/>
</p>

-------------------

An adaptive Gtk+ theme based on the Flat-Plat GTK+ theme.


## Screenshots
-------------------
![Pop GTK+ Theme](screenshots/main.png) ![GNOME Maps](screenshots/pop-maps.png) ![Dark Theme](screenshots/pop-builder.png)


### Required Components
-------------------
Pop supports Gtk+ 3.22.x, 3.20.x and 3.18.x

 ```
 * Gtk+-3.0             >= 3.18.9
 * Gtk+-2.0             >= 2.24.30
 * gtk2-engines-pixbuf  >= 2.24.30
 * gtk2-engines-murrine >= 0.98.1
 ```

#### Supported Desktop Environments
------------------------------

 ```
 * GNOME-Shell     >= 3.18.3
 * GNOME-Flashback >= 3.18.2
 * Budgie-Desktop  >= 10.2.7
 * Unity7          >= 7.4.0
 * XFce4           >= 4.12.2
 * Mate            >= 1.14.0 (Gtk+ 3.2x only)
 * LXDE            >= 0.99.1 (Gtk+ 2.x only)
 ```

 > **Note:**
 >
 >   * Mate-Desktop and Pantheon support are W.I.P.



### Recommendations

- For GTK, use icons alongside [Pop Icon Theme](https://github.com/system76/pop-icon-theme)
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

1. If previous versions were installed/existed, remove them first.

 ```
 sudo apt remove system76-pop-gtk-theme
 sudo rm -rf /usr/share/themes/{Pop,Pop-Eta,Pop-Nokto,Pop-Nokto-Eta}
 rm -rf ~/.local/share/themes/{Pop,Pop-Eta,Pop-Nokto,Pop-Nokto-Eta}
 rm -rf ~/.themes/{Pop,Pop-Eta,Pop-Nokto,Pop-Nokto-Eta}
 ```

2. Check build-requirements:
 Currently Pop bundles neither pre-generated stylesheets nor PNG images.
 So users and/or contributors should generate proper CSSs, PNGs and gresources at build-time.

 ```
 * autoconf
 * automake
 * inkscape
 * libgdk-pixbuf2.0-dev (gdk-pixbuf2-devel)  >= 2.32.2
 * libglib2.0-dev (glib2-devel)              >= 2.48.0
 * librsvg2-dev (librsvg2-devel)             >= 2.40.13
 * libsass0 (libsass)                        >= 3.3.6
 * libxml2-utils (libxml2)
 * pkg-config (pkgconfig)
 * sassc                                     >= 3.3.2
 * parallel                                  (Optional, for faster builds)
 ```

 You can install them using:
 ```
 sudo apt install -y autoconf automake inkscape libgdk-pixbuf2.0-dev \
    libglib2.0-dev librsvg2-dev libsass0 libxml2-utils pkg-config sassc \
    parallel
 ```

 > **Note:**
 >
 >   * In OpenSUSE, add 3 extra dependencies:
 >
 >     ```
 >     gdk-pixbuf-devel        >= 2.32.2
 >     gdk-pixbuf-loader-rsvg  >= 2.40.13
 >     librsvg-devel           >= 2.40.13
 >     ```
 >
 >   * Pop employs **SassC** wrapper of `libsass` to generate CSS stylesheets.
 >   * Pop uses `inkscape` to generate installable PNG files.
 >   * Pop uses `glib-compile-resources` to compile the gresource files for Gtk+ and Gnome-Shell.

3. Build and install system-wide:

 ```
 ./autogen.sh \
 make
 sudo make install
 ```

 > **Note:**
 >
 >   * Default prefix is `/usr`.
 >   * All 4 variants are installed by default.
 >   * `make` generates proper CSSs and PNGs to be installed.
 >     It will take about 5min to 15min to build.
 >     For example, Ubuntu's build-server takes 10min.
 >   * `sudo make install` installs multiple versioned theme and Gtk+ automatically selects the properly versioned one when running.

4. To speed up by using concurrency-build, pass this specific option to `autogen.sh`:

 ```
 --enable-parallel       enable parallel-build support (type: bool)
 ```

 > **Note:**
 >
 >   * This feature requires GNU `parallel`, so please add `parallel` to build-requirements.
 >     Parallel can execute multiple scripts and binaries to be suitable for multi-threading.
 >     It could especially shorten the rendering-time via `inkscape`.
 >   * `-jN` option to be passed to GNU `make` is surely usable, but Pop currently employs `parallel`.
 >   * This feature should not be applied when packaging on remote/shared build-servers.

5. To disable some DE supports, pass these specific options to `autogen.sh`:

 ```
 --disable-gnome         disable gnome-shell support (type: bool)
 --disable-cinnamon      disable cinnamon support (type: bool)
 --disable-flashback     disable flashback support (type: bool)
 --disable-unity         disable unity support (type: bool)
 --disable-xfce          disable xfce support (type: bool)
 --disable-mate          disable mate support (type: bool)
 --disable-openbox       disable openbox support (type: bool)
 ```

 > **Note:**
 >
 >   * The installer installs GNOME/Budgie-Desktop support even if all of options above were applied.
 >   * Cinnamon/Unity/Mate support hooks `metacity-1` directory even if GNOME-Flashback support was disabled.

6. To enable next Gtk+ release support, pass this option:

 ```
 --enable-gtk_legacy    enable Gtk+ 3.18 support (type: bool)
 --enable-gtk_next      enable Gtk+ 4.0 support (type: bool)
 ```

7. To change the default 5 **Key-Colors**, pass these options:

 ```
 --with-selection_color        Primary color for highlighted items in the UI (Default: #faa41a)
 --with-second_selection_color Primary color for 'select' effects (Default: #ffb13d = Cyan300, type: int)
 --with-accent_color           Secondary color for notifications and OSDs, and selected items (Default: #48B9C7)
 --with-suggestion_color       Secondary color for 'suggested' buttons (Default: #73C48F)
 --with-destruction_color      Tertiary color for 'destructive' buttons (Default: #F15D22)
 ```

 > **Note:**
 >
 >   * Color-codes are defined as `#` + 6-digit `HEX`s (Standard RGB definitions in HTML codes).
 >   * Example: If you would like to use 'Teal500' as selection_color, use this:
 >
 >     ```./autogen.sh --with-selection_color=#009688 --with-second_selection_color=#48B9C7```
 >
 >     This switchese the theme to almost Teal key colors.
 >   * Basically `selection_color` and `suggestion_color` should use `500` colors,
 >     and `second_selection_color` and `accent_color` should use `300` colors.
 >   * While doing `make`, Pop changes those 5 colors in all stylesheets and images,
 >     and `make clean` cleans up all generated files from source directories.
 >   * This feature unfortunately is not supported in `Openbox-3` and `Telegram 1.0` theming.

Extra Browser Support
---------------------
 To try legacy Chrome(ium) specific theming (`< 59.0.30xx`), pass this option:

 ```
 --enable-chrome         enable Chrome(ium) support (type: bool)
 ```

 The compressed `crx` files will be installed into `Pop/chrome` and `Pop-Nokto/chrome`.

 > **Note:**
 >
 >   * Chrome(ium) 59.0.30xx or newer, theming is pulled from Gtk+ 3.x directly.
 >     So `Settings > Appearance > Themes` should be `GTK+`.
 >
 >   * Vivaldi can make custom themes via settings like these:
 >     ```
 >     Background: #FAFBFC (#333333)
 >     Foreground: #574F4A (#F6F6F6)
 >     Highlight:  #574F4A
 >     Accent:     #4E4844
 >     Accent Color from Active Page: [ ]
 >     Apply Accent Color to Window:  [*]
 >     Transparent Tabs:              [*]
 >     Corner Rounding:               2px
 >     ```

Extra Dock Support
------------------
 To try "Plank" theming, pass this option:

 ```
 --enable-plank         enable Plank support (type: bool)
 ```

 Then select `Gtk+` via `plank --preferences`.

 > **Note:**
 >
 >   * Both Pop and Pop-Nokto shares the same theming.
 >   * Don't expect too much. Plank is NOT a themeable widget for me!

Extra Compositor Support
------------------------
 Compton is the famous stand-alone compositor that works well with the Openbox window-manager. The installer installs recommended configuration file `compton.conf` into `Pop/openbox-3` directory if Openbox support is enabled.

 Next, copy that file into `~/.config/` and restart compton to read the settings.  That compositor still has some limitations in its features for Pop, however.

Extra Telegram Support
----------------------
 To try "Telegram 1.0" theming, pass this option:

 ```
 --enable-telegram      enable Telegram 1.0 support (type: bool)
 ```

 The installer installs compressed `tdesktop-theme` files into `Pop/telegram` and `Pop-Nokto/telegram` directories if Telegram support is enabled.
 Then open the file via Telegram > Main Menu > Settings > Chat background > Choose from file.

 > **Note:**
 >
 >   * The `pop.tdesktop-theme` is for light-variant, and `pop-nokto.tdesktop-theme` is for dark-variant.
 >   * Bundled noise-texture images are for *tiled* mode.
 >   * Telegram support is a W.I.P currently.

Work in Progress
----------------
* Conversion to Gtk+ 4.0

TODO
----
* Prepare for Meson build system (priority: high)
* Prepare for FlatPak packaging (priority: mid)
* Prepare for Steam theming (priority: Low)
* Add Firefox specific theming (priority: undecided)

Public License
--------------
 GPLv2.0

 > **Note:**
 >
 > SVG files are licensed under CC BY-SA 4.0

Special Thanks to
--------------
 Nana-4, the developer of Flat-Plat.
 tista500 and the Adapta Theme Project: https://github.com/adapta-project/


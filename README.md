<p align="center">
<img src="https://github.com/system76/pop-gtk-theme/raw/master/Pop_gtk-logo.png"/>
</p>

-------------------

A sound theme for Pop!_OS 


### Installation

Pop is intended to be installed through the package manager. Packages for Pop are available in PPA:
```
sudo add-apt-repository ppa:system76/pop
sudo apt update
sudo apt install pop-theme
```
It's recommended to use the `pop-theme` metapackage, as this will pull in all components of the look. However, individual components can be installed separately, e.g:
```
sudo apt install cosmic-sound-theme
```


### Installation from Git Source
----------------------------

This is the recommended method for users who aren't on Pop.


1. If previous versions were installed/existed, remove them first.

 ```
 sudo apt remove cosmic-sound-theme
 sudo rm -rf /usr/share/themes/Pop*
 rm -rf ~/.local/share/themes/Pop*
 rm -rf ~/.themes/Pop*
 ```

2. Clone the repository.

```
git clone https://github.com/pop-os/cosmic-sound-theme.git
cd cosmic-sound-theme
```

3. Generate the theme files.

```
meson build && cd build
ninja
```

4. Install the theme.

```
ninja install
```

#### Rebuilding after modifications:

You shouldn't need to rebuild the entire theme after modifications. If you make
changes to any GTK3 or GTK2 assets, delete the old rendered copies and use the
`render-assets.sh` script to regenerate those with new ones with your 
modifications. 

TODO
----
* Prepare for Steam theming (priority: Low)

Public License
--------------
 Most files: GPL-3.0+
 Upstream Adwaita: LGPLv2.1
 Sound theme: CC-BY-SA-4.0


 > **Note:**
 >
 > SVG files are licensed under CC BY-SA 4.0

Special Thanks to
--------------
 Nana-4, the developer of Materia.
 tista500 and the Adapta Theme Project: https://github.com/adapta-project/

## Summary

- Do not edit the CSS directly, edit the source SCSS files and run `make sass`
- To be able to use the latest/adequate version of Sass, install `sassc`
- To change the SVG assets color, use the recoloring script, and do not edit the
  svg.in files.

## How to tweak the theme

Like the upstream Adwaita, this theme is written and processed in Sass.

You can read about Sass at http://sass-lang.com/documentation/. Once you make
your changes to the SCSS files, run the `./parse-sass.sh` script to rebuild the
CSS files.

Here's a rundown of the _supporting_ stylesheets:

- `_variables.scss`

  variables to allow easier definition of widget sizing/styling.

- `_color-palette.scss`

  Color Palette definitions. This is where the base colors for the theme are
  defined, as well as any special overrides.

- `_colors.scss`

  global color definitions. We keep the number of defined colors to a necessary
  minimum. It covers both the light variant and the dark variant.

- `_colors-public.scss`

  SCSS colors exported through gtk to allow for 3rd party apps color mixing.

- `_drawing.scss`

  drawing helper mixings/functions to allow easier definition of widget drawing
  under specific context.

- `_common.scss`

  actual definitions of style for each widget. This is where you are likely to
  add/remove your changes.

- `_apps.scss` or `_extensions.scss`

  app/extension specific stylings.

## How to change the assets

The svg.in source files are converted to SVG by the `recolor-assets.sh` script,
and then are rendered out to PNG files when the theme is built from
source. You can manually trigger a rebuild by using the `make assets` command. 
This will cause inkscape to render out all of the PNG files, which will 
overwrite any existing files. 

Before rendering or building, all assets are color matched according to the 
`recolor-assets.sh` script. If you want to change the colors of the assets, that
is the correct place to do it. It's also good for basic stlye changes, like 
changing the border radius. 

There is a recolor script for Gtk3, Gtk2, and xfwm. You'll need to edit all 
three (or at least all of them you want to be updated). This is planned to be 
consolidated in the near future.

If you want to modify the look/style of the assets, you can open them in 
inkscape or another vector graphics editor and modify them there. You may need 
to remove the `.in` extension from the end of the filename first. Be sure that 
you don't modify any `.svg` files or save your modifications as `.svg` without
adding the `.in` extension, as these files will be deleted when you rebuild the 
theme.

## Useful Links

#### Upstream theme sources

- [GTK+ 4.0](https://github.com/GNOME/gtk/tree/master/gtk/theme/Adwaita)
  - [3.22](https://github.com/GNOME/gtk/tree/gtk-3-22/gtk/theme/Adwaita)
  - [3.20](https://github.com/GNOME/gtk/tree/gtk-3-20/gtk/theme/Adwaita)
  - [3.18](https://github.com/GNOME/gtk/tree/gtk-3-18/gtk/theme/Adwaita)
- [GTK+ 2](https://github.com/GNOME/gnome-themes-standard/tree/master/themes/Adwaita/gtk-2.0)
- [GNOME Shell](https://github.com/GNOME/gnome-shell/tree/master/data/theme)
  - [Sass sources](https://github.com/GNOME/gnome-shell-sass)

#### Tips

- [Unity/Theming](https://wiki.ubuntu.com/Unity/Theming)
- [Material Design Guidelines](https://www.material.io/guidelines/)
- [Personal CSS Guidelines](https://github.com/nana-4/materia-theme/wiki/CSS-Guidelines)
- [The GTK+ Inspector](https://blog.gtk.org/2017/04/05/the-gtk-inspector/)

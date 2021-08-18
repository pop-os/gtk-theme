#!/bin/sh
set -eu

theme_dir="${MESON_INSTALL_DESTDIR_PREFIX}/$1"
project_name="$2"

install -m755 -d "${theme_dir}"
for ver in gtk-3.0; do
  install -m755 -d "${theme_dir}/gtk-4.0"
  ln -sf "../../${project_name}/gtk-4.0/gtk-dark.css" "${theme_dir}/gtk-4.0/gtk.css"
  ln -sf "../../${project_name}/gtk-4.0/gtk.gresource" "${theme_dir}/gtk-4.0/gtk.gresource"
done

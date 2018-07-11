#!/bin/bash

## Asset Recoloring script for use in the Pop GTK Theme

# This script is part of the Pop GTK theme
# Copyright (C) 2017 by System76, Inc. and Ian Santopietro

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 2 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see
# <https://www.gnu.org/licenses/old-licenses/gpl-2.0.html>.



# List of Current Color definitions:
fg="574F4A"
accent="FAA41A"
primary="48B9C7"
bg="F5F5F5"
bg_lighter="FAFAFA"
base="FBFBFB"

fg_dark="F6F6F6"
accent_dark="BE7704"
primary_dark="2C8691"
bg_dark="3F3B39"
bg_lighter_dark="4C4845"
base_dark="4C4845"

radiusX='rx="4"'
radiusY='ry="4"'

# List of Original colors to use:
fgO="574F4A"
accentO="FAA41A"
primaryO="48B9C7"
bgO="F5F5F5"
bg_lighterO="FAFAFA"
baseO="FBFBFB"

fg_darkO="F6F6F6"
accent_darkO="BE7704"
primary_darkO="2C8691"
bg_darkO="3F3B39"
bg_lighter_darkO="4C4845"
base_darkO="4C4845"

radiusXO='rx="4"'
radiusYO='ry="4"'

# List of Files to replace in. Should be .in to be non-destructive

files='assets.svg.in
       assets-dark.svg.in
       gtkrc.in
       gtkrc-dark.in
       gtkrc-light.in'

# Color replacements happen here:

for i in $files; do

	echo "Replacing colors in $i..."

	cp "$i" "${i}.tmp"

	sed -i "s/$fgO/$fg/g" "$i.tmp"
	echo "Replaced $fgO with $fg in $i.tmp"

	sed -i "s/$accentO/$accent/g" "$i.tmp"
	echo "Replaced $accentO with $accent in $i.tmp"

	sed -i "s/$primaryO/$primary/g" "$i.tmp"
	echo "Replaced $primaryO with $primary in $i.tmp"

	sed -i "s/$bgO/$bg/g" "$i.tmp"
	echo "Replaced $bgO with $bg in $i.tmp"

	sed -i "s/$bg_lighterO/$bg_lighter/g" "$i.tmp"
	echo "Replaced $bg_lighterO with $bg_lighter in $i.tmp"

	sed -i "s/$baseO/$base/g" "$i.tmp"
	echo "Replaced $baseO with $base in $i.tmp"

	sed -i "s/$fg_darkO/$fg_dark/g" "$i.tmp"
	echo "Replaced $fg_darkO with $fg_dark in $i.tmp"

	sed -i "s/$accent_darkO/$accent_dark/g" "$i.tmp"
	echo "Replaced $accent_darkO with $accent_dark in $i.tmp"

	sed -i "s/$primary_darkO/$primary_dark/g" "$i.tmp"
	echo "Replaced $primary_darkO with $primary_dark in $i.tmp"

	sed -i "s/$bg_darkO/$bg_dark/g" "$i.tmp"
	echo "Replaced $bg_darkO with $bg_dark in $i.tmp"

	sed -i "s/$bg_lighter_darkO/$bg_lighter_dark/g" "$i.tmp"
	echo "Replaced $bg_lighter_darkO with $bg_lighter_dark in $i.tmp"

	sed -i "s/$base_darkO/$base_dark/g" "$i.tmp"
	echo "Replaced $base_darkO with $base_dark in $i.tmp"

	sed -i "s/$radiusXO/$radiusX/g" "$i.tmp"
	echo "Replaced $radiusXO with $radiusX in $i.tmp"

	sed -i "s/$radiusYO/$radiusY/g" "$i.tmp"
	echo "Replaced $radiusYO with $radiusY in $i.tmp"
done

for i in $files; do
	f="${i}.tmp"
	mv "$f" "${f%.in.tmp}"
done

echo `pwd`

echo "Color Replacement complete."

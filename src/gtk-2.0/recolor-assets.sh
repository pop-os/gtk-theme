#!/bin/bash

## Asset Recoloring script for use in the Pop GTK Theme

# This script is part of the Pop GTK theme
# Copyright (C) 2017 by System76, Inc. and Ian Santopietro

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see
# <https://www.gnu.org/licenses/old-licenses/gpl-2.0.html>.


# List of Current Color definitions:
accent1="faa41a"
selection1="48b9c7"
black="574f4a"
bg1="49423e"
bg2="574f4a"
bg3="4a5c64"
bg4="49423e"
bg5="3b3633"
menuBg="574f4a"
radiusX='rx="4"'
radiusY='ry="4"'

# List of stock colors to use:
accentO="FF4081"
selectionO="42A5F5"
blackO="000000"
bg1O="44545c"
bg2O="596e79"
bg3O="4a5c64"
bg4O="50636c"
bg5O="37474F"
menuBgO="455A64"
radiusXO='rx="2"'
radiusYO='ry="2"'

# Color replacements happen here:

files='assets.svg
       assets-dark.svg
       gtkrc
       gtkrc-dark
       gtkrc-light'

for i in $files; do
	echo "Replacing colors in $i..."

	sed -i "s/$accentO/$accent1/g" $i
	echo "Replaced $accentO with $accent1 in $i"

	sed -i "s/$selectionO/$selection1/g" $i
	echo "Replaced $selectionO with $selection1 in $i"

	sed -i "s/$blackO/$black/g" $i
	echo "Replaced $blackO with $black in $i"

	sed -i "s/$bg1O/$bg1/g" $i
	echo "Replaced $bg10 with $bg1 in $i"

	sed -i "s/$bg2O/$bg2/g" $i
	echo "Replaced $bg2O with $bg2 in $i"

	sed -i "s/$bg3O/$bg3/g" $i
	echo "Replaced $bg3O with $bg3 in $i"

	sed -i "s/$bg4O/$bg4/g" $i
	echo "Replaced $bg4O with $bg4 in $i"

	sed -i "s/$bg5O/$bg5/g" $i
	echo "Replaced $bg5O with $bg5 in $i"

	sed -i "s/$menuBgO/$menuBg/g" $i
	echo "Replaced $menuBgO with $menuBg in $i"

	sed -i "s/$radiusXO/$radiusX/g" $i
	echo "Replaced $radiusXO with $radiusX in $i"

	sed -i "s/$radiusYO/$radiusY/g" $i
	echo "Replaced $radiusYO with $radiusY in $i"

done
echo "Color Replacement complete."

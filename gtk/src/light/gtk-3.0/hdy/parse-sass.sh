#!/bin/bash

if [ ! "$(which sassc 2> /dev/null)" ]; then
   echo sassc needs to be installed to generate the css.
   exit 1
fi

if [ ! "$(which git 2> /dev/null)" ]; then
   echo git needs to be installed to check GTK.
   exit 1
fi

SASSC_OPT="-M -t compact"

: ${GTK_SOURCE_PATH:="../../../gtk"}
: ${GTK_TAG:="3.24.24"}

if [ ! -d "${GTK_SOURCE_PATH}/gtk/theme/Pop" ]; then
   echo GTK sources not found at ${GTK_SOURCE_PATH}.
   exit 1
fi

# > /dev/null makes pushd and popd silent.
pushd ${GTK_SOURCE_PATH} > /dev/null
GTK_CURRENT_TAG=`git describe --tags`
popd > /dev/null

if [ "${GTK_CURRENT_TAG}" != "${GTK_TAG}" ]; then
   echo GTK must be at tag ${GTK_TAG}.
   exit 1
fi

sassc $SASSC_OPT -I${GTK_SOURCE_PATH}/gtk/theme/Pop \
	Pop.scss Adwaita.css
sassc $SASSC_OPT -I${GTK_SOURCE_PATH}/gtk/theme/Pop \
	Pop-dark.scss Adwaita-dark.css
sassc $SASSC_OPT -I${GTK_SOURCE_PATH}/gtk/theme/Pop \
	fallback.scss fallback.css
sassc $SASSC_OPT -I${GTK_SOURCE_PATH}/gtk/theme/Pop -I${GTK_SOURCE_PATH}/gtk/theme/HighContrast \
	HighContrast.scss HighContrast.css
sassc $SASSC_OPT -I${GTK_SOURCE_PATH}/gtk/theme/Pop -I${GTK_SOURCE_PATH}/gtk/theme/HighContrast \
	HighContrastInverse.scss HighContrastInverse.css
sassc $SASSC_OPT -I${GTK_SOURCE_PATH}/gtk/theme/Pop \
	shared.scss shared.css

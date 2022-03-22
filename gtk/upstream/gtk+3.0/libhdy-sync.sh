#!/usr/bin/env bash
# -*- coding: UTF-8 -*-
## Helper script to sync theme files from upstream to a destination folder
## usage:
##
##      libhdy-sync.sh --destination <path> [--assets]
##
## options:
##    -d, --destination <path>    Destination folder - mandatory
##    -a, --assets                Sync assets file - optional
# CLInt GENERATED_CODE: start

# No-arguments is not allowed
[ $# -eq 0 ] && sed -ne 's/^## \(.*\)/\1/p' $0 && exit 1

# Converting long-options into short ones
for arg in "$@"; do
  shift
  case "$arg" in
"--destination") set -- "$@" "-d";;
"--assets") set -- "$@" "-a";;
  *) set -- "$@" "$arg"
  esac
done

function print_illegal() {
    echo Unexpected flag in command line \"$@\"
}

# Parsing flags and arguments
while getopts 'had:' OPT; do
    case $OPT in
        h) sed -ne 's/^## \(.*\)/\1/p' $0
           exit 1 ;;
        a) _assets=1 ;;
        d) _destination=$OPTARG ;;
        \?) print_illegal $@ >&2;
            echo "---"
            sed -ne 's/^## \(.*\)/\1/p' $0
            exit 1
            ;;
    esac
done
# CLInt  GENERATED_CODE: end

wget_check=`which wget | wc -l`
[ $wget_check == 0 ] && echo "install wget" && exit 1

root=https://gitlab.gnome.org/GNOME/libhandy/-/raw/main/src/themes/

[ ! -d ${_destination} ] && echo ${_destination} folder does not exists && exit 1

files=(
    Pop-dark.css
    Pop-dark.scss
    Pop.css
    Pop.scss
    HighContrast.css
    HighContrast.scss
    HighContrastInverse.css
    HighContrastInverse.scss
    _Pop-base.scss
    _definitions.scss	
    _fallback-base.scss
    _shared-base.scss
    fallback.css
    fallback.scss
    parse-sass.sh
    shared.css
    shared.scss
)

set -e
for i in ${files[@]}; do
    i_i=$(echo ${i} | sed --expression 's/Pop/Adwaita/')
    wget ${root}/${i_i} -O ${_destination}/${i}
done

for i in ${files[@]}; do
    sed -i 's/Adwaita/Pop/' ${_destination}/${i}
    sed -i "/@import 'colors';/d" ${_destination}/${i}
    sed -i "/@import 'drawing';/d" ${_destination}/${i}
done

cp ${_destination}/Pop.scss ${_destination}/_pop.scss
cp ${_destination}/Pop-dark.scss ${_destination}/_pop-dark.scss

#! /usr/bin/env bash

INKSCAPE="/usr/bin/inkscape"
OPTIPNG="/usr/bin/optipng"

SRC_FILE="windows-assets.svg"
ASSETS_DIR="titlebutton"
INDEX="assets.txt"

# check command avalibility
has_command() {
  "$1" -v $1 > /dev/null 2>&1
}

rm -rf "$ASSETS_DIR"
mkdir -p $ASSETS_DIR

for i in `cat $INDEX` ; do
  for d in '' '-dark' ; do

## Normal titlebutton

for scale in 1 2; do
    file="$ASSETS_DIR/$i$d$( [ $scale -gt 1 ] && echo "@${scale}" ).png"
    echo
    echo Rendering "$file"

      $INKSCAPE --export-id=$i$d \
                --export-dpi=$((96 * scale)) \
                --export-id-only \
                --export-filename="$file" $SRC_FILE >/dev/null

    $OPTIPNG -o7 --quiet "$file"
done

  done
done
exit 0

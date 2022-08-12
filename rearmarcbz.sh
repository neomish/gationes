#!/bin/bash
VICTIMA=$1
NUEVO=$( echo "$VICTIMA" | sed 's/\(.*\)\..*/\1/' )
#NUEVO="$NUEVO.cbr"
TEMPORAL=$(echo .uncbr$RANDOM)
mkdir $TEMPORAL
#unrar e "$VICTIMA" "$TEMPORAL"
#7z e "$VICTIMA" -o"$TEMPORAL"
unzip -j "$VICTIMA" -d "$TEMPORAL"
cd "$TEMPORAL"
rmdir * 2> /dev/null
rm -f *db 2> /dev/null
rm -f *fo 2> /dev/null
rm -f *txt 2> /dev/null
rm -f *gif 2> /dev/null
cd ..
mv "$VICTIMA" "$VICTIMA.bk"
mv "$TEMPORAL" "$NUEVO"
crearcbz.sh "$NUEVO"
crearhistorieta.sh "$NUEVO"
rm -rf "$NUEVO/"

#!/bin/bash
VICTIMA=$1
NUEVO=$( echo "$VICTIMA" | sed 's/\(.*\)\..*/\1/' )
#NUEVO="$NUEVO.cbr"
TEMPORAL=$(echo .uncbr$RANDOM)
mkdir $TEMPORAL
unrar e "$VICTIMA" "$TEMPORAL"
mv "$VICTIMA" "$VICTIMA.bk"
cd "$TEMPORAL"
rmdir * 2> /dev/null
rm -f *db 2> /dev/null
rm -f *fo 2> /dev/null
rm -f *txt 2> /dev/null
rm -f *gif 2> /dev/null
cd ..
mv "$TEMPORAL" "$NUEVO"
crearcbr.sh "$NUEVO"
crearhistorieta.sh "$NUEVO"
rm -rf "$NUEVO/"

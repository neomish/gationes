#!/bin/bash

# Revisar cantidad de parámetros rescibidos
if  [ $# -ne 1 ]; then

 #Avisar que se rquieren mas parámetros
 echo ""
 echo "USO: $0 <Comic Book en cbr>"
 echo ""
 echo "    ej:   $0 \"Mi comic.cbr\""

else

 ORIGEN=$1
 DESTINO=$( echo "$ORIGEN" | sed 's/\(.*\)\..*/\1/' )
 DESTINO="$DESTINO.pdf"
 TEMPORAL=$(echo .uncbr$RANDOM)

 mkdir $TEMPORAL

 echo "Creando: $DESTINO"
 #unrar-free e "$1" "${TEMPORAL}" > /dev/null
 #7zr e "$1" -o"${TEMPORAL}" > /dev/null
 rar e "$1" $TEMPORAL > /dev/null
 find $TEMPORAL -iname "*jpg" -exec mogrify -quality 50% '{}' \;
 cd $TEMPORAL
 rmdir * 2> /dev/null
 rm -f *fo 2> /dev/null
 rm -f *db 2> /dev/null

 img2pdf * -o "../${DESTINO}"
 cd ..

 rm -rf $TEMPORAL

fi

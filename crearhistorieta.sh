#!/bin/bash
if  [ $# -ne 1 ]; then
 #Avisar que se requieren mas parámetros
 echo ""
 echo "USO: $0 <nombre de la carpeta con archivos a agrupar del comic>"
 echo ""
 echo "    ej:   $0 \"Mi comic\""
else
  NOMBRE=$1
  ARCHIVOS=$2
  [[ "${NOMBRE}" == */ ]] && NOMBRE="${NOMBRE: : -1}"
  # crear un temporal inecesario pero la putada de montage no funciona con espacios en los nombres de archivos dentro de un bash... maldeetoo!!!
  TEMPORAL=$(echo .pamontar$RANDOM)
  cp -r "${NOMBRE}" ${TEMPORAL}
  if cd ${TEMPORAL} ; then
    rmdir * 2> /dev/null
    if rename 's/ /_/g' * ; then
      cd ..
      # caluclar la cantidad de archivos
      CANTIDAD=$( ls -1 "${TEMPORAL}" | wc -l )
      LISTA=$(echo $(find "${TEMPORAL}" | sort | grep -v "${TEMPORAL}\$" ) )
      # recuerdos de la dura pensada XD
      #LISTA=$(echo $(find "${NOMBRE}" | sort | grep -v "${NOMBRE}\$" | sed 's/ /\\ /g' ) )
      #LISTA=$(echo $(find "${NOMBRE}" | sort | grep -v "${NOMBRE}\$" | sed "s/$/\'/g" | sed "s/^${NOMBRE}/'${NOMBRE}/g"  ) )
      #LISTA=$(echo $(find "${NOMBRE}" | sort | grep -v "${NOMBRE}\$" | sed 's/ /\\ /g' | sed "s/$/\'/g" | sed "s/^${NOMBRE}/'${NOMBRE}/g" ) )
      echo Creando \"$NOMBRE.jpg\"
      montage $LISTA -tile 1x$CANTIDAD -geometry 768x "${NOMBRE}.jpg"
      # Puro debug
      # echo montage $LISTA -tile 1x$CANTIDAD -geometry 768x "${NOMBRE}.jpg"
    else
       echo "hay que instalar el paquete rename"
    fi
  else
    echo "No se pudo crear el archivo"
  fi
  # borrando los relajos
  rm -rf ${TEMPORAL}
fi

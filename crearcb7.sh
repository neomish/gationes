#!/bin/bash

# Revisar cantidad de parámetros rescibidos
if  [ $# -ne 1 ]; then

 #Avisar que se rquieren mas parámetros
 echo ""
 echo "USO: $0 <directorio de archivos con titulo de comic>"
 echo ""
 echo "    ej:   $0 \"carpeta de mi comic\""

else

 # Obtener el  nombre en un solo parámetro
 NOMBRE=$1
 #Limpiando si lleva un símbolo \ al final
 [[ "${NOMBRE}" == */ ]] && NOMBRE="${NOMBRE: : -1}"
 NOMBRE="${NOMBRE}.cb7"
 CARPETA=$1
 # Comprimir el conjuno de imágenes
 rm -f "${CARPETA}"/*db 2> /dev/null
 rm -f "${CARPETA}"/*txt 2> /dev/null
 rmdir "${CARPETA}"/* 2> /dev/null
 #rar a "${NOMBRE}" "${CARPETA}" 2> /dev/null > /dev/null
 7zr -mx=9 a "${NOMBRE}" "${CARPETA}" 2> /dev/null > /dev/null
 #zip -9 -r "${NOMBRE}" "${CARPETA}" 2> /dev/null > /dev/null

fi

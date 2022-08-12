#!/bin/bash
if  [ $# -ne 1 ]; then
  #Avisar que se requieren mas parámetros
  echo ""
  echo "USO: $0 <nombre del archivo encriptado>"
  echo ""
  echo "    ej:   $0 \"unidad.zulu\""
else
  ARCHIVO="$1"
  CLAVE=`kdialog --password "Clave para abrir ${ARCHIVO}"`
  # echo sudo zuluMount-cli -m -K ${UID} -d \"${ARCHIVO}\" -p \"${CLAVE}\"
  sudo zuluMount-cli -m -K ${UID} -d "${ARCHIVO}" -p "${CLAVE}"
  if [ $? != 0 ]; then
     kdialog --sorry "Hubo un problema.\n la clave es incorrecta, o la unidad está ocupada"
  fi
fi

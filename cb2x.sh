#!/bin/bash

function uso() {
 #Avisar que se rquieren mas parámetros
 echo ""
 echo "USO: $0 <tipo> <Comic Book en cbr|cbz|cb7>"
 echo "  TIPOS:"
 echo "        r Comic Book tipo cbr"
 echo "        z Comic Book tipo cbz"
 echo "        7 Comic Book tipo cb7"
 echo "        p Archivo pdf"
 echo "        j Un solo archivo jpg (podría fallar en comics grandes)"
 echo ""
 echo "  ej: $0 z \"Mi comic.cbr\""
}

# Revisar cantidad de parámetros rescibidos
if  [ $# -ne 2 ]; then

 uso

else

 TIPO=$1
 COMIC=$2

 case "${TIPO}" in
  "r"|"z"|"7"|"p"|"j")
   TIPOp="SI";
   ;;
  *)
   TIPOp="NO";
   echo "error: Opción No implementada"
   exit 1
   ;;
 esac

 if [ -f "$COMIC" ]; then
  COMICe="SI"
  COMICf=$( file -b --mime-type "$COMIC" | cut -d "/" -f 2 )
  case "${COMICf}" in
   "x-rar"|"zip"|"x-7z-compressed")
    TIPOf="SI"
   ;;
   *)
    TIPOf="NO"
   ;;
  esac
 else
  COMICe="NO"
 fi

 #echo "${TIPOp} ${TIPOf} ${COMICe}"

 if [[ "${TIPOp}" == "SI" && "${TIPOf}" == "SI" && "${COMICe}" == "SI" ]] ; then
   case "${COMICf}" in
    "x-rar" )
     if [[ "${TIPO}" != "r" ]] ; then
      CONVERTIR='SI'
      COMANDO="rar e '${COMIC}' "
     fi
    ;;
    "zip" )
     if [[ "${TIPO}" != "z" ]] ; then
      CONVERTIR='SI'
      COMANDO="unzip -j '${COMIC}' -d "
     fi
    ;;
    "x-7z-compressed")
     if [[ "${TIPO}" != "7" ]] ; then
      CONVERTIR='SI'
      COMANDO="7zr e '${COMIC}' -o"
     fi
    ;;
   esac
   if [[ "${CONVERTIR}" == "SI" ]] ; then
    DESTINO=$( echo "$COMIC" | sed 's/\(.*\)\..*/\1/' )
    case "${TIPO}" in
     "r"|"z"|"7" )
       EXTENSION="cb${TIPO}"
     ;;
     "p" )
       EXTENSION="pdf"
     ;;
     "j" )
       EXTENSION="jpg"
     ;;
    esac
    DESTINO="$DESTINO.${EXTENSION}"
    if [ -f "${DESTINO}" ]; then
     echo "El comic ${DESTINO} ya existe en esta carpeta"
     exit 1
    else
     echo "Convertir ${COMIC} a ${DESTINO}"

     # creadno un tempoal
     TEMPORAL=$(echo .uncb$RANDOM)
     mkdir $TEMPORAL
     echo "Creando: $DESTINO"

     # Descomprimir el contenido en el temporal
     # echo ${COMANDO}${TEMPORAL}
     eval "${COMANDO}${TEMPORAL} 2> /dev/null > /dev/null"

     # Limpiando de archivos raros
     cd $TEMPORAL
     rmdir * 2> /dev/null
     rm -f *fo 2> /dev/null
     rm -f *db 2> /dev/null
     rm -f *txt 2> /dev/null
     # esto no es tan normal
     rm -f *gif 2> /dev/null
     cd ..

     # Pa ver que pasó
     # exa "${TEMPORAL}"/*
     # read

     # hacer el empaquetado... aun falta
     case "${TIPO}" in
      "r" )
       rar a "${DESTINO}" "${TEMPORAL}" 2> /dev/null > /dev/null
       ;;
      "z" )
       zip -9 -r "${DESTINO}" "${TEMPORAL}" 2> /dev/null > /dev/null
       ;;
      "7" )
       7zr -mx=9 a "${DESTINO}" "${TEMPORAL}" 2> /dev/null > /dev/null
       ;;
      "p" )
        find "$TEMPORAL" -iname "*jpg" -exec mogrify -quality 50% '{}' \; 2> /dev/null > /dev/null
        find "$TEMPORAL" -iname "*png" -exec mogrify -quality 50% '{}' \; 2> /dev/null > /dev/null
        cd "$TEMPORAL"
        #img2pdf * -o "../${DESTINO}" 2> /dev/null > /dev/null
        # En el servicio de KDE confunde completamente la ruta del destino
        img2pdf * -o "${DESTINO}"
        # img2pdf * -o "${DESTINO}" 2> /dev/null > /dev/null
        # por eso una línea mas, inecesaria pero funciona en dolphin
        mv "${DESTINO}" ../
        cd ..
       ;;
      "j" )
       CANTIDAD=$( ls -1 "${TEMPORAL}" | wc -l )
       LISTA=$(echo $(find "${TEMPORAL}" | sort | grep -v "${TEMPORAL}\$" ) )
       montage $LISTA -tile 1x$CANTIDAD -geometry 768x "$DESTINO" 2> /dev/null > /dev/null
       ;;
     esac

     rm -rf $TEMPORAL

    fi
   else
    echo "El tipo de Comic Book resuiltado es el mismo";
    exit 1
   fi
 else
   uso
   exit 1
 fi

fi

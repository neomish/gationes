#!/bin/bash
# Algunos colores
F0="$(tput setaf 0)" # Negro
F1="$(tput setaf 1)" # Rojo
F2="$(tput setaf 2)" # Verde
F3="$(tput setaf 3)" # Amarillo
F4="$(tput setaf 4)" # Azul
F5="$(tput setaf 5)" # Magenta
F6="$(tput setaf 6)" # Cyan
F7="$(tput setaf 7)" # Blanco
F9="$(tput setaf 9)" # Restaurar

# Revisar cantidad de parámetros rescibidos
if  [ $# -ne 1 ]; then
    #Avisar que se rquieren mas parámetros
    echo ""
    echo "${F3}USO:${F7} $0 ${F2}<archivo zip>${F7}"
    echo ""
    echo "  ${F6}ej:${F7} $0 ${F2}\"Archivo compreso.zip\"${F7}"
else
    #Variables locales
    ARCHIVO="$1"
    DESTINO="$(pwd)/$( echo "${ARCHIVO}" | sed 's/\(.*\)\..*/\1/' )"
    MONTAR="SI"
    # Comprobar si existe el archivo
    if [ -f "${ARCHIVO}" ] ; then
        # Comprobar si existe el directorio donde se montará
        if [ -d "${DESTINO}" ] ; then
            # Comprobar que el  directorio está vacío
            if [ $( ls -A "${DESTINO}" ) ]; then
                echo "${F1}El directorio \"${DESTINO}\" está ocupado${F7}"
                MONTAR="NO"
            fi
        else
            # Comprobar is se puede crear el directorio
            if ! mkdir "${DESTINO}" > /dev/null 2> /dev/null ; then
                echo "${F1}El directorio \"${DESTINO}\" no se pudo crear${F7}"
                MONTAR="NO"
            fi
        fi
    else
        echo "${F1}El archivo \"${ARCHIVO}\" no existe${F7}"
        MONTAR="NO"
    fi
    # Comprobar si hay que montar o no
    if [ "$MONTAR" = "SI" ] ; then
        echo "${F3}Montando \"${ARCHIVO}\" en \"${DESTINO}\" ...${F7}"
        if fuse-zip -o allow_other "${ARCHIVO}" "${DESTINO}" > /dev/null 2> /dev/null ; then
            echo "${F2}¡Montado!${F7}"
        else
            echo "${F1}Error: No se pudo montar \"${ARCHIVO}\" en \"${DESTINO}\"${F7}"
        fi
    else
        echo "${F1}No es posible montar \"${ARCHIVO}\" en \"${DESTINO}\"${F7}"
    fi
fi

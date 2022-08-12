#!/bin/bash
#echo "Digite usuario de gmail (sin @gmail.com) : "
#read USUARIO
USUARIO="$1"
echo "Digite la clave de $USUARIO@gmail.com : "
stty -echo
read CLAVE
stty echo
#echo "Digite el correo del destinatario: "
#read DESTINATARIO
DESTINATARIO="$2"
#echo "Digite un asunto para el mensaje: "
#read ASUNTO
ASUNTO="$3"
#echo "Digite un mensaje en una sóla línea: "
#read MENSAJE
MENSAJE="$4"
#echo "Digite ruta del adjunto: "
#read ADJUNTO
ADJUNTO="$5"

echo "De $USUARIO@gmail.com para $DESTINATARIO "
echo "Asunto: $ASUNTO"
echo "Mensaje: $MENSAJE"
echo "Adjunto: $ADJUNTO"


echo "$MENSAJE" | \
  mailx \
  -v \
  -s "$ASUNTO" \
  -a "$ADJUNTO" \
  -S smtp=smtp.gmail.com:587 \
  -S smtp-auth-user=$USUARIO@gmail.com \
  -S smtp-use-starttls \
  -S smtp-auth-password="$CLAVE" \
  -S from=$USUARIO@gmail.com \
  $DESTINATARIO


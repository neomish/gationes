#!/bin/bash
FECHA=$1
pcal -E -s 1.0:0.0:0.0 -n /18 -b sat-sun -a es -o calendario-${FECHA}.ps ${FECHA}
ps2pdf calendario-${FECHA}.ps

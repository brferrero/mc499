#!/bin/bash

INPUT=${1:-fig}
OUTPUT=${2:-lorenz_attractor.mp4}
FPS=5

# rename and create link
LISTA=`ls ${INPUT}/*.png`
NUM=1
PREF="fig_"
for i in $LISTA
do
    POSF=`printf "%06d" $NUM`
    NUM=$(( NUM + 1 ))
    ln -s ${i} ${PREF}${POSF}.png
done

# create movie
avconv -r ${FPS} -i fig_%06d.png -c:v libx264 -crf 10 ${OUTPUT}
rm -f fig_*.png

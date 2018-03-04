#!/bin/bash
DATE=$(date +"%Y%m%d%H%M")
DIR=/opt/recording/data
mkdir $DIR/$DATE/
DIR=$DIR"/"$DATE
#DATE=prueba 
mkfifo $DIR/temp_audio.v
arecord -Dhw:1 -c2 -r24000 -fS32_LE -twav $DIR/temp_audio.v &
ffmpeg -y -nostats -loglevel 0 -f video4linux2 -input_format h264 -s 800x600 -framerate 15 -i /dev/video0 -itsoffset 2.000 -i $DIR/temp_audio.v  -ts abs -ab 32k -c:v copy -c:a aac $DIR/output.mkv


#!/bin/sh
DATE=$(date +"%Y%m%d%H%M")
ffmpeg -y -f video4linux2 -input_format mjpeg -s 800x600 -i /dev/video0 -f alsa -ac 1 -ar 16000 -i hw:1,0 -ts abs -c:v copy /opt/recording/data/output$DATE.mkv

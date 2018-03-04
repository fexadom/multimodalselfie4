# Multimodal Selfie capture synchronization
Automatic recording of audio, video, and pen strokes.

Created for Raspberry Pi Zero W, this setup records:
* Video and audio using ffmpeg
* Pen strokes using a Equil SmartPen2

It synchronizes recording by:
* Mqtt
  * START: topic >start
  * STOP: topic >stop
* Http
  * START: http://<IP ADDRESS DEVICE>:1880/start
  * STOP: http://<IP ADDRESS DEVICE>:1880/stop
* GPIO push button on Pin 05 (GPIO 03):
  * Press once >> START, press again >> STOP
* GPIO LED feedback on Pin 03 (GPIO 02):
  * LED ON: Ready to record, LED OFF: Not ready
* Record LED on camera:
  * LED ON: Recording, LED OFF: Not Recording

It uses the following scripts:
* scripts/do_ffmpeg.sh: starts recording video and audio with ffmpeg. It uses a 800x600 video resolution.
* scripts/controller.sh: starts/stops the smart pen recording.

This project should be installed in the following directory on the device:
* /opt/recording

## Data
When recording it produces in the data directory a folder[timestamp] with de following files:
* notas[int].txt: xy data from the smart pen
* output.mkv: video/audio file from ffmpeg


## Logs
Logs are maintened in the logs directory:
* node-red.log: Registers start/stop events and watchdog restart events
* ffmpeg.log: stderr output of the ffmpeg process
* Equil.err: Register start/stop events of the jsvc
* Equil.out: Register outputs events of the jsvc

## Node-red
Node-red code is in the node-red directory:
* flows_raspberrypi3.json: node-red flows
* settings.js: expected settings file. Copy this file to the local node-red installation folder.
* node-modules: this directory contains all node-red and node.js dependencies.


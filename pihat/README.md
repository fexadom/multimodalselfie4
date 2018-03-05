# Design files for pihat MultimodalSelfie version 4
The pihat for the MMSv4 is a two-layer PCB that connects to the 40-pin GPIO interface of the Raspberry Pi Zero W. It provides the following functionality to the MMSv4:
* Ready LED on GPIO 02
* Push button on GPIO 03
* Two digital MEMS ICS43432 microphones multiplexed together and connected to I2S interface of the Raspberry Pi (GPIO 18-20)

The design files in this repository were made in Eagle v8.

Pihat on device | Pihat front | Pihat back
--- | --- | ---
<img src="/images/multimodalselfiev4_open.JPG" width="375"> | <img src="/images/pihat_mmsv4_front.JPG" width="375"> | <img src="/images/pihat_mmsv4_back.JPG" width="375">

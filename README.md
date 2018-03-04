# MultimodalSelfie v4
The MultimodalSelfie is a personal multimodal recording device designed for traditional classrooms. The device, owned and operated by the student, sits on top of her desk while recording video, audio, and notes during a class session (as seen in the concept image below); effectively taking a "selfie" of her learning experience.

<img src="/images/concept.png" width="250" alt="Concept use of MultimodalSelfie">

## Design
This repository contains all the necessary information to construct and test the fourth version of the MultimodalSelfie device (MMSv4 for short). The MMSv4 is based on the [Raspberry Pi Zero W](https://www.raspberrypi.org/products/raspberry-pi-zero-w/) a stripped down version of the Raspberry Pi with wireless connectivity.

Front View | Components | Functionality
--- | --- | ---
<img src="/images/multimodalselfiev4_front.JPG" width="250" alt="MMSv4 Front"> | <img src="/images/Multimodal_working_battery.PNG" width="450" alt="MMSv4 Components"> | <img src="/images/multimodalselfiev4_components.png" width="375" alt="MMSv4 Functionality">

### Hardware components
The MMSv4 was built using the following components:

Component | Description | Notes
--- | --- | ---
Raspberry Pi Zero W | 1GHz 64-bit, single-core ARMv8 CPU, 512 MB RAM | 32 GB micro SD
Raspberry Pi Camera | Camera Rev 1.3, 5 megapixeles | Capable of 1080p HD video recording at 30fps
Smart Pen | Equil SmartPen2 | [Manufacturer website](https://www.myequil.com/smartpen2/)
3D Printed Case | Three parts printed using PLA | [STLs](/case)
Pihat | Printed Circuit Board that expands the Raspberry Pi capabilities, it connects to the 40 GPIO port. It has a swith, a LED, and two digital microphones. | [Design files](/pihat)
2 x digital MEMS microphones | The two ICS43432 mics are surface mounted on the Pihat and capable of stereo recording. | [Manufacturer website](https://www.invensense.com/products/digital/ics-43432/)
LiPo battery charger  | SparkFun LiPo Charger Basic - Micro-USB | [Manufacturer website](https://www.sparkfun.com/products/10217)
LiPo battery  | 2000mAh Lithium Ion battery | [Manufacturer website](https://www.sparkfun.com/products/13855)

### Software components
The operating system used is [Raspbian Stretch Lite](https://www.raspberrypi.org/downloads/raspbian/) (Release date 2017-11-29). Video and audio are captured and synchronized using **ffmpeg** and overall synchronization is done with Node-Red:
* [Node-Red flows](/synchronization-software)

## Dependencies
After installing Raspbian Stretch Lite (avoid installing any GUI and unnecessary packages) update as needed with:
```bash
sudo apt-get update
sudo apt-get upgrade
```
then install the following dependencies:

### ffmpeg
For best results, install ffmpeg and its dependencies from the official repository:
```bash
sudo apt-get install ffmpeg
```

### Node-RED
Node-RED is pre-installed in Raspbian Stretch, to enable it:
```bash
sudo systemctl enable nodered.service
```

### Equil
The Equil driver for the SmartPen2 requires Java, to install:
```bash
sudo apt-get install jsvc
```
## Configuration Notes
To use the camera port it is necessary to enable it at boot time, run:
```bash
sudo raspi-config
```
and enable the camera. To map the camera driver to /dev/video0 add this line to /etc/rc.local:
```bash
modprobe bcm2835-v4l2
```
### Installation of synchronization software
Install the contents of the [synchronization software](/synchronization-software) in the folder /opt/recording:
```bash
git clone https://github.com/fexadom/multimodalselfie4.git
cd multimodalselfie4
sudo mv synchronization-software /opt/recording
```
* Copy /opt/recording/node-red/settings.js to ~/.node-red/
* Copy the directory /opt/recording/node-red/node_modules/file-exists to ~/.node-red/node_modules/
* Create a directory "data" in /opt/recording
* Restart the system

### Configure Equil software
Open Equil.sh in /opt/recording/scripts/ and modify as needed:
```bash
JAVA_HOME: Location JAVA JRE
EXEC: Location JSVC
```
### Installation of ICS43432 driver
Use this post: [Add an I2S mic using device tree & simple-audio-card](https://www.raspberrypi.org/forums/viewtopic.php?f=44&t=173640) to install the driver for the ICS43432 digital microphones.

### Configure web server Lighttpd
The web server [Lighttpd](https://www.lighttpd.net/) is necessary to extract all recorded software. To install first remove Apache httpd if installed, then install **lighthttpd** from the official repositoty and enable the service:
```bash
sudo apt-get remove apache2
sudo apt-get install lighttpd
sudo systemctl enable lighttpd.service
```


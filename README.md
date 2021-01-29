Click [here](https://www.youtube.com/watch?v=VPdPOVL8c1Q&list=PL9gEr35J45czlRLHXhA3jShGG_jIrRprJ) to see the video series for how Karen was made.

![Karen](https://alfredo.lol/static/karen/img/karen_small.png)
### open source voice assistant

This repo contains the schematics, stl, and [openSCAD](https://www.openscad.org/) files used to create the Karen device in the [Karen video series](https://www.youtube.com/watch?v=VPdPOVL8c1Q&list=PL9gEr35J45czlRLHXhA3jShGG_jIrRprJ).

The threads used for the lid are accomplished using [threadlib by Adrian Schlatter](https://github.com/adrianschlatter/threadlib).

All of the measurements for specific boards were taken using a digital caliper in millimeters.

## How to print
### If you want to 3d Print these parts, the stl files provided are ready to be sliced. The parts have been oriented so that no supports are needed to print any of the parts. The parts in the video were printed using Inland PLA+ at 225 degrees Celcius for the extruder and 70 degrees Celcius for the bed at 30% infill and 0.2mm layer height using the [Creality Ender 3 V2](https://www.amazon.com/Creality-Motherboard-carborundum-Beginners-220x220x250mm/dp/B08LGCKD9S).

## Parts list
### This model was specifically made for the following parts
- (1) [Raspberry pi 4 Model B](https://www.amazon.com/gp/product/B0899VXM8F/): The brain of the system that hosts the [Karen installation](https://github.com/AlfredoSequeida/karen)
- (1) [Audio Injector Sound Card](https://www.amazon.com/Sound-Card-Raspberry-inbuilt-microphone/dp/B01HCC0210): Used to convert the digital signal from the Raspberry pi into an analog RCA signal for the speakers and its built-in microphone input.
- Pair of speakers for stereo audio. You have the choice of 2 79mm (3in) diameter speakers or 2 40mm (1.5in) diameter speakers. Regardless of the speakers you chose, the important thing is that the mounting bracket for the speaker fits the holes for the base, which you can verify by looking at the [openSCAD source code](https://github.com/AlfredoSequeida/karen-model/blob/master/base_model.scad) for the measurements. 
- (1) [5.5mm Female DC adapter](https://www.amazon.com/WHonor-Upgraded-Female-Connector-Adapter/dp/B082NZQ53C)
- (1) [LM2596 DC-DC 3A Buck](https://www.amazon.com/Zixtec-LM2596-Converter-Module-1-25V-30V/): Used to step down the voltage from the 5.5 Female DC adapter to 5V to power the raspberry pi.
- (1) [OEP30Wx2](https://www.amazon.com/Comimark-OEP30Wx2-Digital-Amplifier-Replace/dp/B07YSDZ47S?th=1): Used to amplify the speaker output.

## Putting the model together
### This model was made to be put together using a kit of M2.5 standoffs, screws, and nuts similar to [this](https://www.amazon.com/DYWISHKEY-Pieces-Female-Standoff-Assortment/dp/B07MW5P8JH/) one.

## The Bases
### This model is made up of different bases, each base is specifically made for a component pair, or components in the parts list above.

- [rpi_base](https://github.com/AlfredoSequeida/karen-model/blob/master/rpi_base.stl): This is the base for the Audio Injector Sound Card and the Raspberry 4 Model B (any other 20 pin Raspberry Pi model B with built-in wifi works) as long as it marches the holes on the base. [If you need to modify this base, you can do so by visiting the docs, to find the mechanical specs for your model](https://www.raspberrypi.org/documentation/hardware/raspberrypi/mechanical/README.md). There is also a [handle](https://github.com/AlfredoSequeida/karen-model/blob/master/handle.stl) included that can be attached to the base as an easy way to take the entire build in and of of the enclosure easier.
- [speaker_base](https://github.com/AlfredoSequeida/karen-model/blob/master/speaker_base.stl): This is the base for the 79mm (3in) diameter speakers. If you want stereo audio, you need to print two (one for each speaker).
- [dual_speaker_base](https://github.com/AlfredoSequeida/karen-model/blob/master/dual_speaker_base.stl): This is the base for the two 40mm (1.5in) diameter speakers. One base fits both speakers, thus giving you a more compact design.
- [elec_base](https://github.com/AlfredoSequeida/karen-model/blob/master/elec_base.stl): This is the electronics components base, which holds the 5.5mm diameter female DC adapter, the LM2596 DC-DC 3A Buck, and the OEP30Wx2 audio amplifier. These should be mounted using standoffs to allow room underneath the boards for wire solders.

## [The container](https://github.com/AlfredoSequeida/karen-model/blob/master/container.stl)
### The container is a container for the entire build. It's an easy way to give the whole build a more refined look if you don't like the exposed wire look. The container model is built for the full-size model using the two 79mm (3in) diameter speakers. If you want to fit in the smaller version, this can be easily accomplished using by changing the counter height (h) and the slot height (slot_height) in the openSCAD file.

## [The lid](https://github.com/AlfredoSequeida/karen-model/blob/master/lid.stl)
### if you want to add a lid to your build, the lid model is included. The lid has a Karen logo on the top to allow for sound to make it's way to the mic. If you want to modify the lid, make sure you download [threadlib by Adrian Schlatter](https://github.com/adrianschlatter/threadlib). This library is what was used in the openSCAD. Then you can make the modifications you need including removing the logo. If you want an easy way to add holes, there is a `lid_holes` module, which makes four 3mm radius holes on the top of the lid instead. Simply uncomment line 520, and remove/comment out the logic for the Karen logo.

## How to modify the model
### If you want to make a change to the model you can easily do so using the [openSCAD source code](https://github.com/AlfredoSequeida/karen-model/blob/master/base_model.scad). The model for each base and part is split into a module for ease of modification with all shared unit values at the top of the source code to facilitate scaling the model.

## The electronics
### [schematics.svg](https://github.com/AlfredoSequeida/karen-model/blob/master/schematics.svg) contains the electrical schematics for how to wire everything together.


DISCLAIMER: Links included might be affiliate links. If you purchase a product with the links that I provide I may receive a small commission. There is no additional charge to you!
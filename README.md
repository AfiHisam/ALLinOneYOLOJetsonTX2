# ALLinOneYOLOJetsonTX2
Just a scripts to help you build and install all necessary dependencies to run YOLO in Jetson TX2

Credit to jetsonhacks and pjreddie
https://github.com/jetsonhacks
https://github.com/pjreddie

To run the the build file

$ ./install.sh

And we're done for installation simple and sweet is it !

## Lets Run It

$ cd Darknet 

In the folder Darknet/data their are sample file given to be test, one of them is dog.jpg, of course you can have your own image file, just add and play with it. 

in our case, lets test the dog picture 

$ ./darknet detect cfg/yolo.cfg yolo.weights data/dog.jpg

you can view the result at Darknet folder name predictions.png

now download the video and save to the folder Darknet/data, in our case let rename it as test.mp4 and test it

$ ./darknet detector demo cfg/coco.data cfg/yolo.cfg yolo.weights data/test.mp4

for onboard camara Jetson TX2 write this command 

$ ./darknet detector demo cfg/coco.data cfg/yolo.cfg yolo.weights "nvcamerasrc ! video/x-raw(memory:NVMM), width=(int)1280, height=(int)720,format=(string)I420, framerate=(fraction)30/1 ! nvvidconv flip-method=0 ! video/x-raw, format=(string)BGRx ! videoconvert ! video/x-raw, format=(string)BGR ! appsink"

MIT License

Copyright (c) 2018 Mohamad Afi bin Abdul Hisam

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.


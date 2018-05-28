#!/bin/bash 
#==============================================================================
# Title: install.sh
# Description: Install everything necessary for YOLO to be running in JetsonTX2.
# Author: Afi Hisam <afihisam95@gmail.com>
# Date: 20180322
# Version : 1.01
# Usage: bash install.sh
#
#==============================================================================

# Exit script if any command fails
set -e 


if [ $# -ne 0 ]
  then
    echo "Usage: install.sh"
    exit 1
fi

# Setup OpenCV 3.3

sudo nvpmodel -m 2

cd $HOME
sudo apt-get install -y \
    libglew-dev \
    libtiff5-dev \
    zlib1g-dev \
    libjpeg-dev \
    libpng12-dev \
    libjasper-dev \
    libavcodec-dev \
    libavformat-dev \
    libavutil-dev \
    libpostproc-dev \
    libswscale-dev \
    libeigen3-dev \
    libtbb-dev \
    libgtk2.0-dev \
    cmake \
    pkg-config

# Python 2.7
sudo apt-get install -y python-dev python-numpy python-py python-pytest -y
# GStreamer support
sudo apt-get install -y libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev 

git clone https://github.com/opencv/opencv.git
cd opencv
git checkout -b v3.3.0 3.3.0
# This is for the test data
cd $HOME
git clone https://github.com/opencv/opencv_extra.git
cd opencv_extra
git checkout -b v3.3.0 3.3.0

cd $HOME/opencv
mkdir build
cd build
# Jetson TX2 
cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DBUILD_PNG=OFF \
    -DBUILD_TIFF=OFF \
    -DBUILD_TBB=OFF \
    -DBUILD_JPEG=OFF \
    -DBUILD_JASPER=OFF \
    -DBUILD_ZLIB=OFF \
    -DBUILD_EXAMPLES=ON \
    -DBUILD_opencv_java=OFF \
    -DBUILD_opencv_python2=ON \
    -DBUILD_opencv_python3=OFF \
    -DENABLE_PRECOMPILED_HEADERS=OFF \
    -DWITH_OPENCL=OFF \
    -DWITH_OPENMP=OFF \
    -DWITH_FFMPEG=ON \
    -DWITH_GSTREAMER=ON \
    -DWITH_GSTREAMER_0_10=OFF \
    -DWITH_CUDA=ON \
    -DWITH_GTK=ON \
    -DWITH_VTK=OFF \
    -DWITH_TBB=ON \
    -DWITH_1394=OFF \
    -DWITH_OPENEXR=OFF \
    -DCUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda-8.0 \
    -DCUDA_ARCH_BIN=6.2 \
    -DCUDA_ARCH_PTX="" \
    -DINSTALL_C_EXAMPLES=ON \
    -DINSTALL_TESTS=ON \
    -DOPENCV_TEST_DATA_PATH=../opencv_extra/testdata \
    ../

# Consider using all 6 cores; $ sudo nvpmodel -m 2 or $ sudo nvpmodel -m 0
make -j4


# Install Darknet

mkdir -p darknet 
git clone https://github.com/pjreddie/darknet
cd darknet
sudo sed 's/GPU=0/GPU=1/g' Makefile
sudo sed 's/CUDNN=0/CUDNN=1/g' Makefile
sudo sed 's/OPENCV=0/OPENCV=1/g' Makefile
make -j4
wget https://pjreddie.com/media/files/yolo.weights

cd ..
echo "Yolo Had been installed"

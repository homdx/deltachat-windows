#!/bin/bash

git clone --recursive https://github.com/randombit/botan.git
cd botan
export PATH=/usr/bin:/usr/local/bin
python3 configure.py --prefix=/usr/local --cc=gcc --link-method=hardlink  --with-cmake --os=cygwin
cd build
cmake ..
make

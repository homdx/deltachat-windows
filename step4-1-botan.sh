#!/bin/bash

python3 --version
export PATH=/usr/bin:/usr/local/bin:$PATH
python3 --version
cd $TRAVIS_BUILD_DIR
cd botan-2.9.0
ls -la
python3 configure.py --prefix=/usr/local --cc=gcc --link-method=hardlink  --with-cmake --os=cygwin
cd build
cmake ..
make

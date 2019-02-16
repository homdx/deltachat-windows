#!/bin/bash

if [ $TRAVIS ]
then
echo "Travis run"
python3 --version
export PATH=/usr/bin:/usr/local/bin:$PATH
python3 --version
cd $TRAVIS_BUILD_DIR
tar -xf 2.9.0.tar.gz 
cd botan-2.9.0
else
echo "No travis runing"
fi

ls -la
python3 configure.py --prefix=/usr/local --cc=gcc --link-method=hardlink  --with-cmake --os=cygwin
cd build
cmake ..
make

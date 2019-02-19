#!/bin/bash

if [ $TRAVIS ]
then
echo "Travis run"
python3 --version
export PATH=/usr/bin:/usr/local/bin:$PATH
python3 --version
cd $TRAVIS_BUILD_DIR
wget --quiet https://github.com/randombit/botan/archive/2.9.0.tar.gz -O 2.9.0.tar.gz
tar -xf 2.9.0.tar.gz 
cd botan-2.9.0
else
echo "No travis runing"
git clone --recursive https://github.com/randombit/botan.git
cd botan
git checkout a95c67a5a1fd8c9afd9cb69770cb1542f558f163
fi

ls -la
python3 configure.py --prefix=/usr/local --cc=gcc --link-method=hardlink  --with-cmake --os=cygwin
cd build
cmake ..
make
cd ..

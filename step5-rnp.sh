#!/bin/bash

ls -la

if [ $TRAVIS ]
then
echo "Travis run. Change path env"
export PATH=/usr/bin:/usr/local/bin:/usr/lib:/sbin:$PATH
ls -la


echo current cmake version
cmake --version
wget http://mirrors.kernel.org/sourceware/cygwin/x86_64/release/cmake/cmake-3.13.1-1.tar.xz
tar -xvf cmake-3.13.1-1.tar.xz -C /
rm cmake-3.13.1-1.tar.xz
echo updated cmake version
cmake --version

cd rnp-0.12.0
ls -la
else
echo "No travis runing"
fi

mkdir build
cd build
echo start configure
cmake -DCMAKE_INSTALL_PREFIX=/usr/local -DBUILD_SHARED_LIBS=on -DBUILD_TESTING=off ..
echo start build
make
echo start install
make install

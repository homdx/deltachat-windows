#!/bin/bash

ls -la

if [ $TRAVIS ]
then
echo "Travis run. Change path env"
export PATH=/usr/bin:/usr/local/bin:/usr/lib:/sbin:$PATH

cd $TRAVIS_BUILD_DIR

echo current cmake version
cmake --version
wget http://mirrors.kernel.org/sourceware/cygwin/x86_64/release/cmake/cmake-3.13.1-1.tar.xz
tar -xvf cmake-3.13.1-1.tar.xz -C /
rm cmake-3.13.1-1.tar.xz
echo updated cmake version
cmake --version

tar -xf v0.12.0.tar.gz
cd rnp-0.12.0
else
echo "No travis runing"
git clone --recursive https://github.com/riboseinc/rnp.git
cd rnp
git checkout 586caec6cd728d54dbd281cafe17ee2e1f29dbf1
fi

mkdir build
cd build
echo start configure
cmake -DCMAKE_INSTALL_PREFIX=/usr/local -DBUILD_SHARED_LIBS=on -DBUILD_TESTING=off ..
echo start build
make
echo start install
make install

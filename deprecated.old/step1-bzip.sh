#!/bin/bash


if [ $TRAVIS ]
then
echo "Travis run"
mkdir -p travis/src

cd travis/src
DOT_VERSION=0.1.4
DOT_HASH=c832dfad52332be41033bd91cff8505a5e1bab13bcabc9c0832d4325564bdd7e
DOT_PATH=http://mirrors.kernel.org/sourceware/cygwin/x86_64/release/bzip2
DOT_FILE=bzip2-1.0.6-3-src.tar.xz

set -ex
time wget --quiet ${DOT_PATH}/${DOT_FILE} -O ${DOT_FILE} && \
echo current folder with bzip2 && \
ls -la && \
echo "${DOT_HASH}  ${DOT_FILE}" | sha256sum -c

set +ex
tar -xvf ${DOT_FILE} --directory=/usr/src


#zlib sources
DOT_PATH=http://mirrors.kernel.org/sourceware/cygwin/x86_64/release/zlib
DOT_HASH=5e29d107d09c75ead210d6f81e54d1dc8dc1fa4a35ea739227a7a56a27c0dcdc
DOT_FILE=zlib-1.2.11-1-src.tar.xz
echo $DOT_PATH
set -ex
time wget --quiet ${DOT_PATH}/${DOT_FILE} -O ${DOT_FILE} && \
echo current folder with zlib && \
ls -la && \
echo "${DOT_HASH}  ${DOT_FILE}" | sha256sum -c

set +ex
tar -xvf ${DOT_FILE} --directory=/usr/src
echo current usr-src folder
ls -la /usr/src
#cd .. && cd ..

else
echo "No travis runing"
fi

echo Check sources
if [ -f  /usr/src/bzip2-1.0.6-3.src/bzip2-1.0.6.tar.gz ]
then
echo found bzip 1.0.6
else
echo not found sources for bzip 1.0.6. You need setup sources with cygwin
exit 255
fi

echo Check sources
if [ -f  /usr/src/zlib-1.2.11-1.src/zlib-1.2.11.tar.gz ]
then
echo found zlib 1.2.11
else
echo not found sources for zlib 1.2.11. You need setup sources with cygwin
exit 255
fi


echo Unpack Sources
cp /usr/src/bzip2-1.0.6-3.src/bzip2-1.0.6.tar.gz .
tar -xf bzip2-1.0.6.tar.gz
rm bzip2-1.0.6.tar.gz

echo Make patches
cd bzip2-1.0.6
cp /usr/src/bzip2-1.0.6-3.src/*.patch .
set -ex
patch Makefile-libbz2_so -p0 <1.0.6-cygwin-dll.patch &&
patch -p0 bzip2recover.c <bzip2-1.0.4-bzip2recover.patch &&
patch -p0 <set-out-file-to-null.patch

echo Compile bzip2
make

echo Install bzip2
make install
make clean
cd ../../..

cd travis/src
echo make zlib from source
mkdir -p zlib-src
cd zlib-src


cp /usr/src/zlib-1.2.11-1.src/zlib-1.2.11.tar.gz .
cp /usr/src/zlib-1.2.11-1.src/*.patch .

tar -xf zlib-1.2.11.tar.gz
patch.exe -p0 zlib-1.2.11/contrib/minizip/unzip.c <zlib-1.2.5-minizip-fixuncrypt.patch
mkdir -p src
mv zlib-1.2.11 src/
patch.exe -p0 <1.2.11-gzopen_w.patch
cd src/zlib-1.2.11
echo configure zlib 1.2.11
./configure
echo make zlib
make
echo install zlib
make install
make clean
cd .. && cd .. && cd ..

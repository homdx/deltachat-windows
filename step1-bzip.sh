#!/bin/bash

DOT_VERSION=0.1.4
DOT_HASH=ffb20ea24176fa417218ac7be269f38d5a1982490585dbfd1750c9afe7d37ded
DOT_PATH=https://github.com/homdx/pydelhi_mobile/releases/download
DOT_FILE=bzip2-1.0.6-3.src.tar.gz

if [ $TRAVIS ]
then
echo "Travis run"
cd travis/src
set -ex
time wget --quiet ${DOT_PATH}/${DOT_VERSION}/${DOT_FILE} -O ${DOT_FILE} && \
echo "${DOT_HASH}  ${DOT_FILE}" | sha256sum -c && \
set +ex
tar -xvf ${DOT_FILE} --directory=/usr/src
cd .. && cd ..
else
echo "No travis runing"
fi

echo Check sources
if [ -f  /usr/src/bzip2-1.0.6-3.src/bzip2-1.0.6.tar.gz ]
then
echo found bzip 1.0.6
else
echo not found sources for bzip 1.0.6. You need setup sources or  manual 
compile
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

echo Compile
make

echo Install
make install


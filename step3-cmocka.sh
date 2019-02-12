#!/bin/bash

DOT_VERSION=1.1
DOT_FOLDER=cmocka-1.1.3
DOT_HASH=43eabcf72a9c80e3d03f7c8a1c04e408c18d2db5121eb058a3ef732a9dfabfaf
DOT_PATH=https://cmocka.org/files
DOT_FILE=cmocka-1.1.3.tar.xz

echo linux path
echo $PATH
export PATH=/usr/bin:/usr/local/bin
echo linux new path
echo $PATH
ls -la
ls -la ..

function download_check {

echo "Download and check Cmocka"
set -ex
time wget --quiet ${DOT_PATH}/${DOT_VERSION}/${DOT_FILE} -O ${DOT_FILE} && \
echo "${DOT_HASH}  ${DOT_FILE}" | sha256sum -c && return 0 || echo error download or checksum && exit 255
}

download_check
set +ex
tar -xvf ${DOT_FILE}

cd $DOT_FOLDER
mkdir -p build && cd build
whereis cmake
cmake --version
cygcheck -c
cmake -G 'Unix Makefiles' ..
make || cat CMakeFiles/CMakeError.log
make install
make clean

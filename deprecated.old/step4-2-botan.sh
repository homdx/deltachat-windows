#!/bin/bash

ls -la


if [ $TRAVIS ]
then
echo "Travis run. Change path env. start1 build botan"
echo "current make version"
make --version
export PATH=/usr/bin:/usr/local/bin:$PATH
echo "after patch make version"
make --version
cd $TRAVIS_BUILD_DIR
cd botan-2.9.0
else
cd botan
echo "No travis runing"
fi

echo configure for install botan and install
cp build/libbotan.dll.a  libbotan-2.a
cp build/botan-cli.exe botan.exe
python3 ./src/scripts/install.py --prefix=/usr/local
ls -la /usr/local/bin
ls -la /usr/local/lib
cd ..
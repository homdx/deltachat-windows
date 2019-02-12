#!/bin/bash

ls -la
cd botan
export PATH=/usr/bin:/usr/local/bin
cp build/libbotan.dll.a  libbotan-2.a
cp build/botan-cli.exe botan.exe
python3 ./src/scripts/install.py --prefix=/usr/local
#ls -la /usr/local/bin
#ls -la /usr/local/lib

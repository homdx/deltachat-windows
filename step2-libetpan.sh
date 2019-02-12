#!/bin/bash

mkdir -pv /cygdrive/c/Code
cp -fv libetpan-mailsmtp-cygwin.patch /cygdrive/c/Code
cd /cygdrive/c/Code

function check_command {

echo Check $checkname
if [ -f /usr/bin/$checkname ] 
then 
echo found $checkname
else echo $checkname not found sources. You need setup $checkname to cygwin && exit 255
fi
}

set -ex
checkname=wget
check_command
checkname=dos2unix
check_command
checkname=unzip
check_command
checkname=automake
check_command
checkname=make
check_command
checkname=libtool

set +ex

git clone --recursive https://github.com/dinhviethoa/libetpan.git
mkdir libetpan/third-party1
git checkout -f libetpan/src/low-level/smtp/mailsmtp.c
#dos2unix src/low-level/smtp/mailsmtp.c
cp -vf libetpan-mailsmtp-cygwin.patch libetpan/
cd libetpan/third-party1

echo Download third-part
wget --quiet http://d.etpan.org/mailcore2-deps/zlib-win32/zlib-win32-1.zip -O zlib-win32-1.zip
wget --quiet http://d.etpan.org/mailcore2-deps/misc-win32/openssl-1.0.1j-vs2013.zip -O openssl-1.0.1j-vs2013.zip
wget --quiet http://d.etpan.org/mailcore2-deps/cyrus-sasl-win32/cyrus-sasl-win32-2.zip -O cyrus-sasl-win32-2.zip

function checksum {
echo 'Check sha256 sum'
sha256cyrus=0e2ec45dee16e238947412b28c07e757951cfdaabba829c3caeca9e601850705
sha256openssl=b1aac2fac317404783636e55a1c50a4cc61900ea0ee9198c7f2ded4a4d1500db
sha256zlib=7509eca204ef52b42400aea053b844904add199487cc98a29646b540b8126406

set -ex
echo "$sha256cyrus  cyrus-sasl-win32-2.zip" | sha256sum -c && \
echo "$sha256openssl  openssl-1.0.1j-vs2013.zip" | sha256sum -c && \
echo "$sha256zlib  zlib-win32-1.zip"  | sha256sum -c && return 0 || echo CheckSum error or and Download error && exit 255
}

checksum

echo Unpack
set +ex
unzip -qo cyrus-sasl-win32-2.zip
unzip -qo openssl-1.0.1j-vs2013.zip
unzip -qo zlib-win32-1.zip
mkdir ../third-party
cd cyrus-sasl-win32-2/ && cp -Rv * ../../third-party/ && cd ..
cd openssl-1.0.1j-vs2013/ && cp -Rv * ../../third-party/ && cd ..
cd zlib-win32-1/ && cp -Rv * ../../third-party/ && cd ..

cd ..
echo 'make patch for Cygwin'
dos2unix src/low-level/smtp/mailsmtp.c
dos2unix libetpan-mailsmtp-cygwin.patch
patch -p0 <libetpan-mailsmtp-cygwin.patch
echo compile
ls

find . -name \*.m4|xargs dos2unix
find . -name \*.ac|xargs dos2unix
find . -name \*.am|xargs dos2unix
dos2unix autogen.sh
dos2unix build-windows/gen-public-headers.sh

./autogen.sh
./configure --with-sasl=/cygdrive/c/Code/libetan/third-party  --with-openssl=/cygdrive/c/Code/libetan/third-party --with-zlib=/cygdrive/c/Code/libetan/third-party

echo compile
make

echo install
make install

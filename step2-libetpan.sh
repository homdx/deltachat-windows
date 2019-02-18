#!/bin/bash

echo old version
sh --version
export PATH=/usr/bin:/usr/local/bin:/cygdrive/bin:/cygdrive/usr/bin
echo new version
sh --version

mkdir -pv /cygdrive/c/Code/libetpan

if [ $TRAVIS ]
then
echo "Travis run"
cp -fv $TRAVIS_BUILD_DIR/libetpan-mailsmtp-cygwin.patch /cygdrive/c/Code/libetpan
else
cp -fv libetpan-mailsmtp-cygwin.patch /cygdrive/c/Code/libetpan
fi

cd /cygdrive/c/Code/libetpan

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
check_command
checkname=patch
check_command

echo cygwin make
make --version

set +ex
#wget https://github.com/dinhviethoa/libetpan/archive/1.9.3.tar.gz
git config --list
echo change crlf git config
git config --global core.autocrlf input
git config --list
#git submodule update --init --recursive

git clone --recursive https://github.com/dinhviethoa/libetpan.git
#tar -xf 1.9.3.tar.gz
#mv -vf libetpan-1.9.3 libetpan
sleep 20
cd /cygdrive/c/Code/libetpan
mkdir libetpan/third-party1
dos2unix src/low-level/smtp/mailsmtp.c
ls -la
cp -vf libetpan-mailsmtp-cygwin.patch libetpan/
cd libetpan && git checkout ab999253ead97e3d5a4a077a9ac756c1b2fabd71 && cd ..
cd libetpan/third-party1
ls -la

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

function checksum2 {
echo 'Check sha256 sum'
sha256libetpan=8f7fc8bfa13a7add929b834c7b2a13df7987a738d09073ce7164b33d6f150a63
set -ex
echo "$sha256libetpan  usr-local-libetpan.zip" | sha256sum -c && return 0 || echo CheckSum error or and Download error && exit 255
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

cd /cygdrive/c/Code/libetpan/libetpan
echo current dir before patch is
ls -la
echo 'make patch for Cygwin'
dos2unix src/low-level/smtp/mailsmtp.c
dos2unix libetpan-mailsmtp-cygwin.patch
echo patch file libetpan-mailsmtp-cygwin.patch
patch -p0 <libetpan-mailsmtp-cygwin.patch
echo compile

find . -name \*.m4|xargs dos2unix
find . -name \*.ac|xargs dos2unix
find . -name \*.am|xargs dos2unix


dos2unix autogen.sh
dos2unix build-windows/gen-public-headers.sh

LANG=C ./autogen.sh
#--with-sasl=$TRAVIS_BUILD_DIR/libetpan/third-party
# --with-sasl=/cygdrive/c/Code/libetan/third-party/include  --with-openssl=/cygdrive/c/Code/libetan/third-party/include --with-zlib=/cygdrive/c/Code/libetan/third-party/include

#echo compile
LANG=C ./configure --enable-shared=false

LANG=C make

OUT=$?
if [ $TRAVIS ] && [ $OUT -eq 0 ]
then
echo compiled without error
else
echo need precompiled version
wget --quiet https://github.com/homdx/test-win-build/releases/download/0.0.1/usr-local-libetpan.zip -O usr-local-libetpan.zip
checksum2
set +ex
if [ $TRAVIS ]
then
echo Travis run
unzip -qo usr-local-libetpan.zip
echo move predcompiled files to /usr/local
cp -Rv local/ /usr/
exit 0
else
echo No travis run
fi
fi

echo result status of make command is $OUT

echo now install
make install

echo status install of $?

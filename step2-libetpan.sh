#!/bin/bash


export PATH=/usr/bin:/usr/local/bin:/cygdrive/bin:/cygdrive/usr/bin:$PATH

mkdir -pv /cygdrive/c/Code/libetpan
cp -fv libetpan-mailsmtp-cygwin.patch /cygdrive/c/Code/libetpan
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

echo cygwin make
make --version

set +ex
#wget https://github.com/dinhviethoa/libetpan/archive/1.9.3.tar.gz
git config --list
echo change crlf git config
git config --global add core.autocrlf input
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
cd libetpan && echo git checkout fcbe81e025c01fab1fb807a4aebf7291b3e65253 && cd ..
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
LANG=C ./configure --with-gnu-ld=yes --disable-iconv --disable-silent-rules --enable-shared=false --disable-threads

LANG=C make || echo search la files && find .  "*.la" -print
sleep 15
cat src/low-level/mime/.libs/libmime.la
echo la convert to dos
sleep 15
find . -name \*.la|xargs dos2unix
echo done dos2unix
sleep 15
dos2unix src/low-level/maildir/.libs/libmaildir.la


dos2unix src/low-level/mh/.libs/libmh.la

echo second make
LANG=C make
find . -name \*.la|xargs dos2unix
sleep 15

echo third make
find . -name \*.la|xargs dos2unix
LANG=C make

echo fouth make
LANG=C find . -name \*.la|xargs dos2unix
make

echo five make
LANG=C find . -name \*.la|xargs dos2unix
make


echo language is $LANG
echo now first install
make install

sleep 15
find . -name \*.la|xargs dos2unix
echo done dos2unix
sleep 15

echo now second install
make install

sleep 15
find . -name \*.la|xargs dos2unix
echo done dos2unix
sleep 15

echo now third install
make install

sleep 15
find . -name \*.la|xargs dos2unix
echo done dos2unix
sleep 15

echo now fouth install
make install

sleep 15
find . -name \*.la|xargs dos2unix
echo done dos2unix
sleep 15

echo now five install
make install

echo status install of $?

@echo off
set path=c:\tools\cygwin\bin;%path%
set
echo %path%
set VS140COMNTOOLS=""
cyg-get dos2unix patch unzip automake make bzip2 libsqlite-3-devel libtool gcc-g++ openssl-devel wget gcc doxygen libllvm5 libclang5 libedit0 libxapian30 cmake xz libjson-c-devel libuv1 librhash0 libjsoncpp19 git zlib-devel python3
uname -a
dos2unix step1-bzip.sh
sh step1-bzip.sh

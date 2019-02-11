@echo off
set path=c:\tools\cygwin\bin;%path%
cyg-get dos2unix patch unzip automake make bzip2 libsqlite-3-devel libtool gcc-g++ openssl-devel wget
uname -a
dos2unix step1-bzip.sh
sh step1-bzip.sh

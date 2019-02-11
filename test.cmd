@echo off
echo windows execute cygwin
set path=c:\tools\cygwin\bin;%path%
rem echo %path%
echo cyg-get dos2unix patch unzip automake make bzip2 libsqlite-3-devel libtool gcc-g++ openssl-devel wget
dos2unix step1-bzip.sh
sh step1-bzip.sh

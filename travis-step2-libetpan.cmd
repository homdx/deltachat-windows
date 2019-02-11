@echo off
echo windows execute cygwin
set path=c:\tools\cygwin\bin;%path%
rem echo %path%
dos2unix step2-libetpan.sh
sh step2-libetpan.sh

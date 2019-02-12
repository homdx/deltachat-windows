@echo off
echo windows execute cygwin
set path=c:\tools\cygwin\bin;%path%
rem systeminfo
rem echo %path%
dos2unix step4-1-botan.sh
dos2unix step4-2-botan.sh
dir
rem echo windows path
rem cmd /c echo %path%
sh step4-2-botan.sh

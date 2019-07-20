@echo off
echo windows execute cygwin
set path=c:\tools\cygwin\bin;%path%
rem systeminfo
rem echo %path%
dos2unix step3-cmocka.sh
rem echo windows path
rem cmd /c echo %path%
sh step3-cmocka.sh

@echo off
echo windows execute cygwin
set path=c:\tools\cygwin\bin;%path%
systeminfo
rem echo %path%
dos2unix step3-cmocka.sh
echo windows path
cmd /c echo %path%
sh step3-cmocka.sh

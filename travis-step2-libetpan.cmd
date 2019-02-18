@echo off
echo windows execute cygwin
set path=c:\tools\cygwin\bin;%path%
echo new path
set path=c:\tools\cygwin\bin;C:\Windows\system32;C:\Windows;C:\Windows\System32\Wbem;C:\Windows\System32\WindowsPowerShell\v1.0;C:\Windows\System32\OpenSSH;C:\ProgramData\chocolatey\bin
echo %path%
dos2unix step2-libetpan.sh
#echo sh step2-libetpan.sh
c:\tools\cygwin\cygwin.bat <step2-libetpan.sh

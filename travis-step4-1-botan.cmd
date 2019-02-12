@echo off
echo add python3 package
echo cyg-get python3
echo Run with Cygwin.bat and step4-1-botan.sh
echo c:\tools\cygwin\cygwin.bat step4-1-botan.sh
dos2unix step4-1-botan.sh
dos2unix step4-2-botan.sh
c:\tools\cygwin\cygwin.bat <step4-1-botan.sh
echo sh step4-1-botan.sh

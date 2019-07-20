@echo off
echo windows execute cygwin
dir c:\tools\cygwin\bin
dir c:\tools\cygwin\usr\local\bin
dir c:\tools\cygwin\usr\local\lib
set path=c:\tools\cygwin\bin;c:\tools\cygwin\usr\local\bin;%path%
rem systeminfo
rem echo %path%
dos2unix step5-rnp.sh
echo git clone rnp
git clone --recursive https://github.com/riboseinc/rnp.git
cd rnp
git checkout 586caec6cd728d54dbd281cafe17ee2e1f29dbf1
echo run step5-rnp.sh
sh step5-rnp.sh

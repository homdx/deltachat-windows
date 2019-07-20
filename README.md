[![Build Status](https://travis-ci.org/homdx/deltachat-windows.svg?branch=master)](https://travis-ci.org/homdx/deltachat-windows)

*DeltaChat Windows release and CI builder for Windows*

Download DeltaChat windows:

https://github.com/homdx/deltachat-windows/releases



**Reproduce in your Windows build env:**

1. Setup https://chocolatey.org
2. Setup Git to windows

`choco install nodejs.install aria2`

3. 
```
   git clone https://github.com/homdx/deltachat-windows
   cd deltachat-windows
   dos2unix *.sh
   chmod +x *.sh
   #setup Travis variables and paths
   export TRAVIS=true
   export TRAVIS_BUILD_DIR=~/deltachat-windows
```

4. ./build-all.shl


If you want compile all from sources, without usage precompiled files with cache (for rust and deltachat sources), run with:
```
./make-build-cache.sh --build-arg DISABLECACHE='something'
./build.sh
```

Progress bar for Travis-CI
* [x]  main application deltachat (unpacked)
* [ ]  main application deltachat (packed)

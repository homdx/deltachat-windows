[![Build Status](https://travis-ci.org/homdx/test-win-build.svg?branch=master)](https://travis-ci.org/homdx/test-win-build)

**Reproduce in your Windows env:**

1. Setup https://chocolatey.org
2. Setup Git to windows
3. Setup Meson anb ninja from https://github.com/mesonbuild/meson/releases with msi
3. Install CygWin and cyg-get with:

`choco install cygwin`

`choco install cyg-get`

4. Setup in Cygwin with command cyg-get in Chocolatey with deps packages, defended on file [setup-cygwin-packages.cmd](setup-cygwin-packages.cmd)
5. Run cygwin with: `c:\tools\cygwin\Cygwin.bat`
6. Work with this repositories:
```
git clone https://github.com/homdx/test-win-build
cd test-win-build
dos2unix *.sh
chmod +x *.sh
#setup Travis variables and paths
export TRAVIS=true
export TRAVIS_BUILD_DIR=~/test-win-build
#reproduce all step: ./step1-bzip.sh ; ./step2-libetpan.sh and etc
#if all done then
```

7. Start new command line windows and goto to folder:
```
cd c:\tools\cygwin\home\
dir
cd you_login_windows
cd test-win-build
git clone --recursive https://github.com/deltachat/deltachat-node.git
cd deltachat-node
npm install
#You can have error
#close this cmd and return to cygwin
```
8. Edit file packages.json in folder deltachat-node change to: "install": "bash -c scripts/rebuild-core.js",
9. On cygwin again start `npm install`
You have error with: struct sockaddr has no member named addr.sa_len
Apply my again patch:

```
cp ~/test-win-build/libetpan-mailsmtp-cygwin.patch ~/test-win-build/deltachat-node/deltachat-core/libs/libetpan
cd ~/test-win-build/deltachat-node/deltachat-core/libs/libetpan
patch -p0 <libetpan-mailsmtp-cygwin.patch
cd ~/test-win-build/deltachat-node
npm install
#have error for linking with libiconv? It's need to fix:( downgrade to 0.39)
cd ~/test-win-build/deltachat-node/deltachat-core
git checkout 995d249f0a652548b29b081f9f41f26ac69fcd2a
#and OK compile:)
cd ~/test-win-build/deltachat-node/
npm install
```

Builder windows

Progress bar for Travis-CI

* [x]  bzip
* [x]  libetpan
* [x]  botan
* [x]  cmocka
* [x]  rnp (OpenPGP library)
* [ ]  meson
* [ ]  ninja
* [ ]  nodejs
* [ ]  main application deltachat

#!/bin/bash

export DOT_VERSION=test1
export DOT_PATH=https://github.com/homdx/deltachat-windows/releases/download
export DOT_FILE1=cargo.7z
export DOT_FOLDER1="/c/Users/travis/.cargo"
export DOT_HASH1=0157a466c0035c10811a26c2522947faf05843233ef9d7d96297f8ad2945dccf747ad9fa5b11cb31f45a405539fce19b87313f2283ef7f56d8ae7f0a31f8a8cb
export DOT_FILE2=rustup-arc.7z
export DOT_FOLDER2="/c/Users/travis/.rustup"
export DOT_HASH2=5480fab8f5ae3c05365616c4c327c027b7eb7f0a4ef274362dd05656c51c8a55ad42dd4a30fec4eba7431818a511b1b74ad6f28e272660c1355bb09895426541
export DOT_FILE3=cargo-indexes.7z
export DOT_HASH3=ce49264d54acf662b4fa5a37f819634298ef33b15376bc86e2ec61435254825cc52fa90013b38a8f01c7a10d61b76b11af26554919a36de651487adbdcd86ea2
export DOT_FILE4=deltachat-snapshot-sources.7z
export DOT_HASH4=45637bceedbcf30414c2d7e7f74ecae56f0da1dc4cf03178aec8e3f98cc87d316aa385e9d1096178be71d3b21b14a904dd8c138e1969385e2046155d23977056

if [ -z "$DISABLECACHE" ] ; \
    then echo 'Now enable Cached files for rust. If you not need cache build with: --build-arg DISABLECACHE=something'; \
    set -ex ; \
    mkdir -pv ${DOT_FOLDER1} ; \
    cd ${DOT_FOLDER1} ;\
    time -p aria2c -x 5 ${DOT_PATH}/${DOT_VERSION}/${DOT_FILE1} ; \
    echo "${DOT_HASH1}  ${DOT_FILE1}" | sha512sum -c ; \
    time -p 7z x -y ${DOT_FILE1} ; rm ${DOT_FILE1} ; cd ..; \
    mkdir -pv ${DOT_FOLDER2} ; \
    cd ${DOT_FOLDER2} ;
    time -p aria2c -x 5 ${DOT_PATH}/${DOT_VERSION}/${DOT_FILE2} ; \
    echo "${DOT_HASH2}  ${DOT_FILE2}" | sha512sum -c ; \
    time -p 7z x -y ${DOT_FILE2} ; rm ${DOT_FILE2} ; cd .. ; \
    cd $TRAVIS_BUILD_DIR ; \
    time -p aria2c -x 5 ${DOT_PATH}/${DOT_VERSION}/${DOT_FILE3} ; \
    echo "${DOT_HASH3}  ${DOT_FILE3}" | sha512sum -c ; \
    time -p 7z x -y ${DOT_FILE3} ; rm ${DOT_FILE3} ; \
    time -p aria2c -x 5 ${DOT_PATH}/${DOT_VERSION}/${DOT_FILE4} ; \
    echo "${DOT_HASH4}  ${DOT_FILE4}" | sha512sum -c ; \
    time -p 7z x -y ${DOT_FILE4} ; rm ${DOT_FILE4} ; \
    cp -pv cargo-config2 /c/Users/travis/.cargo/config ; \
    set +ex ; \
    else echo Cache are disabled = $DISABLECACHE build full version with cache; \
    # Build full version \
    echo build Full version; \
    export PATH=/c/Users/travis/.cargo/bin:$PATH ; \
    cd /c/ProgramData/chocolatey/bin ; \
    wget --quiet https://static.rust-lang.org/rustup/dist/i686-pc-windows-gnu/rustup-init.exe ; \
    ./rustup-init.exe -y --default-toolchain nightly ; \
    cd $TRAVIS_BUILD_DIR/ ; git clone --bare https://github.com/rust-lang/crates.io-index.git ; \
    echo 'no copy only update cargo cp -pv cargo-config2 /c/Users/travis/.cargo/config' ; \
    export PATH=/c/Users/travis/.cargo/bin:/c/Program\ Files/nodejs:$PATH ; \
    echo git latest sources ; \
    cd $TRAVIS_BUILD_DIR ; git clone https://github.com/deltachat/deltachat-node --recursive ; \
    cd deltachat-node ; \
    git checkout 583e0f3e68ab813f15b9aac179dbd65630a42324 ; \
    cd .. ; \
    git clone --recursive https://github.com/deltachat/deltachat-desktop ; \
    cd deltachat-desktop ; \
    git checkout 931afdfe2aa78b977faf071c71c09cecc56dca9d ; \
    cd .. ; \
    echo 'git ready for build' ; \
    cd deltachat-node ; cargo --version ; cargo update --verbose ; cargo --version ; \
fi

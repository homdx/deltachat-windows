#!/bin/bash

export DOT_VERSION=v0.105.0-pre2
export DOT_PATH=https://github.com/homdx/deltachat-windows/releases/download
export DOT_FILE1=cargo.7z
export DOT_FOLDER1="/c/Users/travis/.cargo"
export DOT_HASH1=c2fcfb1ae57711f3f2badae0c34d450e1fa0018ff2ea404af6abfc1d25daf5c39f4594e9bbc222779fc7488a35569d3f439b3de498e986741873bb866f7d253b
export DOT_FILE2=rustup-arc.7z
export DOT_FOLDER2="/c/Users/travis/.rustup"
export DOT_HASH2=2ff379d3940560826461d6b6b78985821d20004d5dbe9e99276a6d9149e9709b3f7e757a327c606e8663b9cfe24f9ea0687168103b45fcc47c39fe5c9f6064f2
export DOT_FILE3=cargo-indexes.7z
export DOT_HASH3=05eb132f502c44b844e8f12bd44e1afcc308b4783ea631b6a938122f82cb93b91d44bb5c5421ef6e39d2e74f9bbd2b89241d6765946437f8166284e25304f668
export DOT_FILE4=deltachat-snapshot-sources.7z
export DOT_HASH4=d5401f68ee65c3a9f815e8a2518d23a1f914ff32c7a17259ebe6974cb5541deab4699707a84afeef39d8b471155567404a65e616b4193868f0f9dc00446645c2

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
    git checkout 7a8e05d8f9af4cd62a7441b3acf311dad61f66c8 ; \
    cd .. ; \
    git clone --recursive https://github.com/deltachat/deltachat-desktop ; \
    cd deltachat-desktop ; \
    git checkout ca0460c5bf90a5ebb5bfe2aa794799030d8e23ca ; \
    cd .. ; \
    echo 'git ready for build' ; \
    cd deltachat-node ; cargo --version ; cargo update --verbose ; cargo --version ; \
fi

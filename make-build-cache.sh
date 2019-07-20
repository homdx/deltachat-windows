#!/bin/bash

export DOT_VERSION=v0.105.0-pre2
export DOT_PATH=https://github.com/homdx/deltachat-windows/releases/download
export DOT_FILE1=cargo.7z
export DOT_FOLDER1="/c/Users/travis/.cargo"
export DOT_HASH1=c3a5f78ef5733ce5bc46b20d1dcf14ebeee7039e484fffbbc1558c53f8c158e60f337be0c84a911816a657e1c5374b83038dd7f3e3d14a03200a847360fe4e56
export DOT_FILE2=rustup-arc.7z
export DOT_FOLDER2="/c/Users/travis/.rustup"
export DOT_HASH2=ca0bfa11054f5f4d8a1cb4ea1dbd5b7f5fa195ab5004d437c5ff1969414dc92460140b72ab392fb9f6e59dfc663407cc1a94828e29f6ea3eecf35446426f08c0
export DOT_FILE3=cargo-indexes.7z
export DOT_HASH3=91a5718b51fd5380fde1e024212c1fa4df4c0c992c8a13e78c1b7baa407e27b78d92cfb4a94cb152a4b119eacd1ee499b9043ef979091ff1f06c0cc1dff78a3b
export DOT_FILE4=deltachat-snapshot-sources.7z
export DOT_HASH4=9118ed8b392d29aeb694db4cb7355b3d48f11aa88331ac461d521bbc023c72a52a8ef1df06fc6987181b512f6233028e40a556920684505397329da61201c89c

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

#!/bin/bash

export DOT_VERSION=v0.900.0
export DOT_PATH=https://github.com/homdx/deltachat-windows/releases/download
export DOT_FILE1=cargo.7z
export DOT_FOLDER1="/c/Users/travis/.cargo"
export DOT_HASH1=83e7933301c611101a84feee568b561667e0d14f218695cb9a25cb451fd6fe2f91581234b05861e168cea3686b7ee94fba248422a0fb3411c59d9a7df4dfd928
export DOT_FILE2=rustup-arc.7z
export DOT_FOLDER2="/c/Users/travis/.rustup"
export DOT_HASH2=ce7a5ba2e3b7b3d70c01daf8d35b0623f1eb8031c89d13042232512e78ba237658dafc9c378e3e8b7bf9a8fb104fe864f543a803ab46ba493582403ab9a61ecf
export DOT_FILE3=cargo-indexes.7z
export DOT_HASH3=dd1e13e4a68cba441892571f6f0926d24c80ee58ee52e48237cb89faea917856627a8b46e36dcc89b27da010479eb4bd888f605346b1dfd84bfbd4d0b264363e
export DOT_FILE4=deltachat-snapshot-sources.7z
export DOT_HASH4=456e1440bb0dfab7d7c7372b35550b1083385fcc68316b8e9286577efb2eeda2df0223e1b658ed05f21a1c5500d2a63e551286ea2f74a2216c85fefcd9fbf5f4

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
    git checkout ee236efc8a172a73c7791ee5297db4b4b09885d0 ; \
    cd .. ; \
    git clone --recursive https://github.com/deltachat/deltachat-desktop ; \
    cd deltachat-desktop ; \
    git checkout e0f60a56f9c2da98e204a60b8d54b4c25b1aeba2 ; \
    cd .. ; \
    echo 'git ready for build' ; \
    cd deltachat-node ; cargo --version ; cargo update --verbose ; cargo --version ; \
fi

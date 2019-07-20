#!/bin/bash

if [ -z "$DISABLECACHE" ] ; \
    then echo 'Now not archieve - cached files make are null size. If you not need cache build with: --build-arg DISABLECACHE=something'; \
    cd $TRAVIS_BUILD_DIR ; \
    7z a -bsp1 -t7z -m0=lzma -mx=9 -mfb=64 -md=32m -ms=on -r $TRAVIS_BUILD_DIR/cargo.7z store-cache.sh; \
    7z a -bsp1 -t7z -m0=lzma -mx=9 -mfb=64 -md=32m -ms=on -r $TRAVIS_BUILD_DIR/deltachat-core-rust.7z store-cache.sh ; \
    7z a -bsp1 -t7z -m0=lzma -mx=9 -mfb=64 -md=32m -ms=on -r $TRAVIS_BUILD_DIR/rustup-arc.7z store-cache.sh ; \
    ls -la ; \
    echo desktop node rust>$TRAVIS_BUILD_DIR/deltachat-source-info.txt ; \
    cd $TRAVIS_BUILD_DIR/deltachat-desktop ; echo 11 ; ls -la ; git log -1 >>$TRAVIS_BUILD_DIR/deltachat-source-info.txt ; cd .. ; \
    ls -la ; echo 12 ; cd $TRAVIS_BUILD_DIR/deltachat-node ; ls -la ; git log -1 >>$TRAVIS_BUILD_DIR/deltachat-source-info.txt ; cd deltachat-core-rust ; \
    ls -la ; echo 12 ; git log -1 >>$TRAVIS_BUILD_DIR/deltachat-source-info.txt ; cd .. ; cd .. ; \
    ls -la ; echo 14 ; 7z a -bsp1 -t7z -m0=lzma -mx=9 -mfb=64 -md=32m -ms=on -r  deltachat-snapshot-sources.7z deltachat-source-info.txt ; \
    ls -la ; echo cargo indexes 15 ; 7z a -bsp1 -t7z -m0=lzma -mx=9 -mfb=64 -md=32m -ms=on -r  cargo-indexes.7z crates.io-index.git ; \
    cat deltachat-source-info.txt ; \
    else echo Cache are disabled = $DISABLECACHE; \
    # Store cache and upload  \
    echo Store cache and upload;
    cd /c/Users/travis/.cargo ; 7z a -bsp1 -t7z -m0=lzma -mx=9 -mfb=64 -md=32m -ms=on -r $TRAVIS_BUILD_DIR/cargo.7z * ; \
    cd $TRAVIS_BUILD_DIR/deltachat-node/deltachat-core-rust/  ; 7z a -bsp1 -t7z -m0=lzma -mx=9 -mfb=64 -md=32m -ms=on -r $TRAVIS_BUILD_DIR/deltachat-core-rust.7z * ; \
    cd /c/Users/travis/.rustup/ ; 7z a -bsp1 -t7z -m0=lzma -mx=9 -mfb=64 -md=32m -ms=on -r $TRAVIS_BUILD_DIR/rustup-arc.7z * ; \
    ls -la ; \
    cd $TRAVIS_BUILD_DIR/ ; 7z a -bsp1 -t7z -m0=lzma -mx=9 -mfb=64 -md=32m -ms=on -r deltachat-snapshot-sources.7z deltachat-node/* deltachat-desktop/* ; \
    ls -la ; echo cargo indexes 15 ; 7z a -bsp1 -t7z -m0=lzma -mx=9 -mfb=64 -md=32m -ms=on -r  cargo-indexes.7z crates.io-index.git ; \
    fi

#!/bin/bash

function make_node {
echo make node
cd $TRAVIS_BUILD_DIR && ls -la && export PATH=/c/Users/travis/.cargo/bin:/c/Program\ Files/nodejs:$PATH && cd deltachat-node && npm install && npm link
}

function make_desktop {
echo make desktop
cd $TRAVIS_BUILD_DIR && export PATH=/c/Users/travis/.cargo/bin:/c/Program\ Files/nodejs:$PATH && cd deltachat-desktop && export PATH=/c/Users/travis/.cargo/bin:/c/Program\ Files/nodejs:$PATH && npm link deltachat-node && npm install && echo build deltachat dekstop windows && npm run build && \
if [ -z "$DISABLECACHE" ] ; \
    then echo 'Now enable Cached files for rust. If you not need cache build with: --build-arg DISABLECACHE=something'; \
    else echo Cache are disabled = $DISABLECACHE build full version with cache; \
    echo test deltachat windows ; \
    npm run test ; \
fi
}

function ok_exit {
echo 'All done without error \:-\)'
exit 0
}

function error_exit {
echo 'error with make'
exit 255
}

function pack_win {
cd $TRAVIS_BUILD_DIR/deltachat-desktop && npm run dist || true
}

make_node && make_desktop && pack_win && ok_exit || error_exit

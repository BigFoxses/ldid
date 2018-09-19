#!/bin/bash

set -e

if [ -d /Applications/Xcode-5.1.1.app ]; then
  sudo xcode-select --switch /Applications/Xcode-5.1.1.app
fi

if which xcrun &>/dev/null; then
    flags=(xcrun -sdk macosx g++)
    flags+=(-mmacosx-version-min=10.9)
#    flags=/usr/local/Cellar/gcc/7.2.0_1/bin/gcc-7
    for arch in x86_64; do
        flags+=(-arch "${arch}")
    done
else
    flags=(g++)
fi

flags+=(-I.)

set -x
"${flags[@]}" -c -stdlib=libc++ -o ldid.o ldid.cpp
"${flags[@]}" -stdlib=libc++ -o ldid ldid.o -x c lookup2.c -x c sha1.c

"${flags[@]}" -c -stdlib=libc++ -o ldid2.o ldid2.cpp
"${flags[@]}" -stdlib=libc++ -o ldid2 ldid2.o -x c lookup2.c -x c sha1.c -x c sha224-256.c

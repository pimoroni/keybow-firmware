#!/bin/bash
set -e

WORKING_DIR=$(pwd)

cd bcm2835-1.68
autoreconf -i
./configure --prefix=$(pwd)/build
make
make install
cd $WORKING_DIR

cd lua-5.4.0
make linux
cd $WORKING_DIR

cd libusbgx
autoreconf -i
./configure --prefix=$(pwd)/build
make
make install
cd $WORKING_DIR

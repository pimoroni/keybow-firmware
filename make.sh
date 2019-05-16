set -e

WORKING_DIR=$(pwd)

cd bcm2835-1.58
autoreconf -i
./configure --prefix=$(pwd)/build
make
make install
cd $WORKING_DIR

cd lua-5.3.5
make linux
cd $WORKING_DIR

cd libusbgx
autoreconf -i
./configure --prefix=$(pwd)/build
make
make install
cd $WoRKING_DIR

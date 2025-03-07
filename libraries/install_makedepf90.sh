set -e

source ../setup_gnu_env.sh
 
INSTALL_DIR=$MAKEDEPF90
 
git clone https://salsa.debian.org/science-team/makedepf90.git
 
cd makedepf90
 
FC=gfortran CC=gcc CXX=g++ ./configure --prefix=$INSTALL_DIR
make
make install
 
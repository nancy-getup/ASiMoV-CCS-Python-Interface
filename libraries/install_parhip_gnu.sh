set -e

source setup_gnu_env.sh

INSTALL_DIR=$PARHIP


git clone https://github.com/KaHIP/KaHIP.git parhip
cd parhip
git checkout tags/v3.14
mkdir build
cd build
module load cmake/3.22.1 
CC=mpicc cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR ..
make -j 16
make install

cd ../..
rm -rf parhip

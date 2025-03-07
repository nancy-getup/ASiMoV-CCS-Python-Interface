set -e

source setup_gnu_env.sh

INSTALL_DIR=$HDF5

git clone https://github.com/HDFGroup/hdf5.git
cd hdf5
git checkout tags/hdf5-1_12_1

FC=mpifort CC=mpicc CXX=mpicxx ./configure --enable-parallel --prefix=$INSTALL_DIR
make -j 16
make install

cd ..
rm -rf hdf5

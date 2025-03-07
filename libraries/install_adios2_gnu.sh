set -e

source setup_gnu_env.sh

INSTALL_DIR=$ADIOS2

git clone https://github.com/ornladios/ADIOS2.git adios2
cd adios2
git checkout tags/v2.9.2
mkdir build
cd build
module load cmake/3.22.1 
cmake -DCMAKE_C_COMPILER=mpicc -DCMAKE_CXX_COMPILER=mpicxx -DCMAKE_Fortran_COMPILER=mpifort -DADIOS2_USE_SST=OFF -DADIOS2_USE_Fortran=ON -DADIOS2_USE_MPI=ON -DADIOS2_USE_HDF5=ON -DHDF5_ROOT=/work/m23oc/m23oc/s2517842/Dissertation/libs/install/hdf5 -DADIOS2_USE_Python=OFF -DADIOS2_USE_ZeroMQ=OFF -DBUILD_SHARED_LIBS=ON -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR ..
make -j 16
make install

cd ../..
rm -rf adios2

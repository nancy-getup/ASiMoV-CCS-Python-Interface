set -e

source setup_gnu_env.sh

INSTALL_DIR=$PETSC_DIR

git clone --depth 1 --branch release https://github.com/petsc/petsc.git
cd petsc

./configure --download-fblaslapack=yes --with-cc=mpicc --with-fc=mpifort --with-cxx=mpicxx --with-fortran-datatypes=1 --with-fortran-interfaces=1 --with-fortran-bindings=1 --with-fortran-kernels=1 --with-debugging=1 --prefix=$INSTALL_DIR
make -j 16
make install

cd ..
rm -rf petsc

# export `PETSC_DIR=${HOME}/install/petsc-gnu` to use petsc

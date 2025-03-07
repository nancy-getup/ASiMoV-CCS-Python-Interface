set -e

source setup_gnu_env.sh

INSTALL_DIR=$FYAMLC

git clone --depth 1  https://github.com/Nicholaswogan/fortran-yaml-c.git fyaml
cd fyaml

mkdir build
cd build
module load cmake/3.22.1 
FC=gfortran CC=gcc CXX=g++ cmake -DCMAKE_INSTALL_PREFIX=${INSTALL_DIR} -DBUILD_SHARED_LIBS=Yes ..
cmake --build .
# cmake --install .
mkdir -p $INSTALL_DIR/lib
cp src/*so $INSTALL_DIR/lib
cp -r modules $INSTALL_DIR/

cd ../..
rm -rf fyaml

set -e

source setup_gnu_env.sh

INSTALL_DIR=$PARMETIS

mkdir parmetis
cd parmetis

git clone https://github.com/KarypisLab/GKlib.git gklib
cd gklib
make config cc=mpicc prefix=$INSTALL_DIR
make install -j16
cd ..

git clone https://github.com/KarypisLab/METIS.git metis
cd metis
make config shared=1 cc=mpicc prefix=$INSTALL_DIR gklib_path=$INSTALL_DIR i64=1
make install -j16
cd ..

git clone https://github.com/KarypisLab/ParMETIS.git parmetis
cd parmetis
make config shared=1 cc=mpicc prefix=$INSTALL_DIR gklib_path=$INSTALL_DIR metis_path=$INSTALL_DIR
make install -j16
cd ..


cd ..
rm -rf parmetis

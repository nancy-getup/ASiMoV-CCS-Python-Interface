set -e

# Setup
source ../setup_gnu_env.sh

INSTALL_DIR=$RCM

# Get code
git clone --depth 1 https://github.com/asimovpp/RCM-f90.git rcm-f90
cd rcm-f90

# Build
FC=gfortran make CMP=gnu

# Install
mkdir -p ${INSTALL_DIR}
cp -r lib ${INSTALL_DIR}/
cp -r include ${INSTALL_DIR}/

# Clean up
cd ../
rm -rf rcm-f90

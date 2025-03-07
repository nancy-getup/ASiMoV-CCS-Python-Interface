# source this file to setup up the GNU compilation environment
module load gcc/10.2.0
module load openmpi
module load python/3.9.13

echo "Setting up GNU environment"
# gcc, g++ and gfortran should be available by default
# H=YOUR LIBRARY INSTALLATION FOLDER
H=/work/m23oc/m23oc/s2517842/Dissertation/libs

export LD_LIBRARY_PATH=/scratch/sw/gcc/10.2.0/lib64:$LD_LIBRARY_PATH

export PATH=$H/install:$PATH 

export PATH=$H/install/openmpi-4.1.0-gnu/bin:$PATH 
export LD_LIBRARY_PATH=$H/install/openmpi-4.1.0-gnu/lib:$LD_LIBRARY_PATH 

export PETSC_DIR=$H/install/petsc-gnu
export LD_LIBRARY_PATH=$PETSC_DIR/lib:$LD_LIBRARY_PATH

export FYAMLC=$H/install/fortran-yaml-c
export LD_LIBRARY_PATH=$FYAMLC/lib:$LD_LIBRARY_PATH

export ADIOS2=$H/install/adios2

export PARHIP=$H/install/parhip-gnu
export LD_LIBRARY_PATH=$PARHIP/lib:$LD_LIBRARY_PATH

export PARMETIS=$H/install/parmetis-gnu
export LD_LIBRARY_PATH=$PARMETIS/lib:$LD_LIBRARY_PATH

export HDF5=$H/install/hdf5
export LD_LIBRARY_PATH=$HDF5/lib:$LD_LIBRARY_PATH

export MAKEDEPF90=$H/install/makedepf90

export RCMF90=$H/install/rcm
export LD_LIBRARY_PATH=$RCMF90/lib:$LD_LIBRARY_PATH

export LD_LIBRARY_PATH=/work/m23oc/m23oc/s2517842/Dissertation/asimov-ccs:$LD_LIBRARY_PATH

# Additional environment variables for python interface
# PROJECT_DIR=YOUR PROJECT FOLDER
PROJECT_DIR=/work/m23oc/m23oc/s2517842/Dissertation/asimov-ccs-test
echo "Setting up Python environment variables in $PROJECT_DIR"
export LD_LIBRARY_PATH=$PROJECT_DIR:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=$PROJECT_DIR/src/case_setup/PythonInterface:$LD_LIBRARY_PATH

echo "Environment has been set up"
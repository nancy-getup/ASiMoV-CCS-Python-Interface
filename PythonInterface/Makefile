# Compiler and options
FC = mpif90
FFLAGS = -ffree-line-length-none -fimplicit-none -g -O3 -march=native -mtune=native -fallow-argument-mismatch -fopenmp -fPIC
F2PY = f2py

# Directories
CURRENT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST)))) # Current directory
SRC_DIR = $(shell dirname `dirname \`dirname $(CURRENT_DIR)\``) # Source directory
OBJ_DIR = $(SRC_DIR)/obj # Object directory
# External libraries
INC_DIRS = -I$(SRC_DIR)/include -I$(PETSC_DIR)/include -I$(RCMF90)/include -I$(FYAMLC)/modules -I$(PARHIP)/include -I$(PARMETIS)/include -I$(SRC_DIR)/obj
LIB_DIRS = -L$(SRC_DIR) -L$(FYAMLC)/lib
LIBS = -lccs -lfortran-yaml-c 

# Files
TEST_CALL_TGV2D_SRC = python_call_tgv2d.f90 # Python interface source file
python_objs := $(foreach file, $(wildcard $(OBJ_DIR)/*.o), $(if $(findstring python, $(file)), $(file)))

# Targets
all: $(TEST_CALL_TGV2D_SRC)
	@echo "Building Python interface for TGV2D"
	$(FC) -shared -o libpython.so $(python_objs)
	$(F2PY) --f90flags="$(FFLAGS)" --fcompiler=gfortran -c $< --f2cmap .f2py_f2cmap -m python_tgv2d_f2py_module $(INC_DIRS) $(LIB_DIRS) $(LIBS) -L. -lpython

clean:
	rm -f *.o *.so *.mod *.smod *.log *.h5 *.xmf

.PHONY: all clean

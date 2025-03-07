# Python interface to configure and run test cases in CCS

## Author
- Nan Ji

## Supervisors
- Sebastien Lemaire

## Project Description
### Background 
Recent years have seen progress in the field of computational fluid dynamics (CFD). However, due to the complexity of CFD simulations presents, the ASiMoV-CCS project is designed to serve as a instrument for CFD code developments, enabling large-scale high-performance computing (HPC). The ASiMoV-CCS uses the Portable Extensible Toolkit for Scientific Computation (PETSc) for linear solution and the Message Passing Interface (MPI) for effective parallel computing.

### Goal
This project mainly focuses on developing a Python interface for the Fortran-based ASiMoVCCS project. Currently, ASiMoV-CCS solved the separation problem between user and implementation in CFD simulation code and it requires users to set specific test parameters through yaml configuration files in the Fortran environment. This process makes performance optimization and parameter adjustment difficult due to the complexity of the Fortran interface and the need for recompilation. Therefore, this project proposes to develop a Python interface for calling Fortran code. Through this interface, users can flexibly pass in various parameters (such as number of timesteps and cells) to more easily control the code at runtime. In addition, the project aims to explore better setup parameters by introducing machine learning techniques. Its purpose is to more quickly determine a set of parameters that can meet the accuracy requirements and have the best performance.

### Instructions for Integrating the Python Interface with CCS

- **Prerequisites**
  - Ensure that the Fortran-based [ASiMoV-CCS project](https://github.com/asimovpp/asimov-ccs) is correctly installed and configured on your system. As for the CCS's prerequisites, they are `MPI`, `PETSc`, `makedepf90`, `adios2` with `hdf5`, `fortran-yaml-c`, `python` with the `pyyaml` module and `lit` module, `ParHIP`, `ParMETIS`, `rcm-f90`. To install them, the install script in located in the [`libraries` folder](https://git.ecdf.ed.ac.uk/msc-23-24/s2517842/-/tree/main/libraries?ref_type=heads). 
  - Ensure the successful compilation of CCS project after installing all the library. The steps are shown on the [ReadMe](https://github.com/asimovpp/asimov-ccs/blob/develop/README.md) of CCS.
  - Install the required Python packages, including `numpy`, `f2py` (part of NumPy). 
  - Verify that the Python and Fortran environments are properly set up.

- **Step 1: Clone the Repository**
  - Clone this repository to your local machine using the following command:
    ```bash
    git clone https://git.ecdf.ed.ac.uk/msc-23-24/s2517842.git
    ```
  - Navigate to the project directory:
    ```bash
    cd s2517842
    ```
- **Step 2: Combine the project into the CCS project**
  - Copy the cloned repository to the CCS directory. Assuming the CCS directory is located at `/asimov-ccs`, you can move your project folder using the following command:
    ```bash
    cp -r python_interface_tools asimov-ccs/src
    cp -r PythonInterface asimov-ccs/src/case_setup
    ```
  - Replace the `makefile` in the original CCS with the `makefile` in the `s2517842/CCS` directory
    ```bash
    cp -r CCS/Makefile asimov-ccs
    ```
  - After moving, navigate to the new location:
    ```bash
    cd asimov-ccs/src/case_setup/PythonInterface
    ```
  - Your project is now located within the CCS directory, and you can proceed with further setup and integration steps.

- **Step 3: Compile the Python Interface**
  - Configure the environment and path for compilation. 
    ```bash
    source s2517842/libraries/setup_gnu_env.sh
    ```
    Remember to adjust the path of library installation folder `H` to your current library directory and the `PROJECT_DIR` to your current CCS directory. 
  - Use `makefile` to compile the Fortran code and create Python extension module (`.so`).
    ```bash
    make all
    ```
- **Step 4: Running Test Cases**
  - Run Python scripts to run tgv2d test cases in parallel. 
    ```bash
    mpirun -np 4 python python_tgv_script.py
    ```
    The Python interface allows you to interact with the Fortran code dynamically, without needing to recompile the Fortran code for each change.

- **Step 5: Extending the Interface**
  - If you need to extend the interface to expose additional Fortran functions or modules, modify the Fortran source code as needed and regenerate the Python bindings using `f2py`.
### Performance Test

- **Purpose**
  - The performance test aims to evaluate the efficiency and scalability of the Python interface with the Fortran-based CCS module. This includes measuring execution time and error norms.

- **Step 1: Running Performance Tests**
  - Execute the performance tests using slurm to submit the job to run the code in Cirrus 
    ```bash
    sbatch ~/PythonInterface/PerformanceTest/test_scripts/slurm
    ```
  - Before submission of the slurm, you should adjust the values of different parameters in the slurm.
  - Record the performance metrics such as execution time, CPU/GPU utilization and error level with parameter sets. 

- **Step 2: Analyzing Results**
  - After running the tests, analyze the results. 
    - Firstly, collect the data.
    ```bash
        python ~/PythonInterface/PerformanceTest/test_scripts/collect_data.py
    ```
    - After obtain the csv file with performance test, plot the scatter figure to show the relationship between error and CPU time. 
    ```bash
        python ~/PythonInterface/PerformanceTest/plot_result/analysis_data.ipynb
    ```

- **Step 3: Optimizing Performance**
  - Based on the analysis, make necessary adjustments to the Python interface or Fortran code to improve performance. Rerun the performance tests to validate the improvements.

### Project Structure

- **CCS/**: Contains the Makefile necessary for building and compiling the CCS project and generating the shared library for Python interface. This should replace the origin CCS Makefile to let the python interface can execute successfully. 

- **docs/**: Holds all documentation related to the project.
  - **anylysis_CCS_forPythonInterface.md**: Analysis and planning document for integrating the Python interface with the CCS system.
  - **Meeting_Notes/**: Directory containing notes from project meetings, organized by date.
    - Each markdown file (e.g., `Meeting_20240123.md`) corresponds to a specific meeting, documenting key points in meetings and action items.
  - **version_control_guidelines.md**: Document outlining the version control practices and guidelines for the project.

- **libraries/**: Contains scripts and tools for setting up and managing the external libraries required for the project.
  - **install_*.sh**: Shell scripts to automate the installation of various libraries and dependencies (e.g., PETSc, HDF5).
  - **README.md**: Documentation for using the provided scripts and managing the library environment.

- **PythonInterface/**: Contains the Python interface code and related files.

- **python_interface_tools/**: Contains additional Fortran source code files that support the Python interface.

- **README.md**
  - The main README file for the project, providing an overview, setup instructions, and other key information for users and contributors.

- **LICENSE**: The license file for the project, specifying the terms under which the project's code can be used and distributed.

### Contribution Guidelines
If you would like to contribute to this project, please follow the standard GitHub fork-and-pull workflow:
1. Fork the repository.
2. Create a new branch for your feature or bugfix.
3. Make your changes.
4. Submit a pull request for review.

### License
This project is licensed under the [MIT License](LICENSE).
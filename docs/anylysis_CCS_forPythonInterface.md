# Analysis of TGV2D Fortran Code for Python Interface

## Summary
This document provides a detailed analysis of the TGV2D case in the asimov-ccs(CCS) Fortran project. The goal is to identify the key functions and modules that need to be exposed to Python to facilitate integration between the Fortran and Python components of the project.

## Objectives
- Review the TGV2D Fortran code.
- Identify the key functions and modules that should be interfaced with Python.
- Document the findings to facilitate the binding process between Python and Fortran.

## Fortran Code Review

### Project Structure
The TGV2D case is part of the larger CCS project. The relevant files and modules for the TGV2D case are organized as follows:

```
/CCS
├── src
│   ├── case_setup
│   │   └── TaylorGreenVortex
│   │       ├── tgv2d_core.f90
│   │       ├── tgv2d.f90
│   │       ├── TaylorGreenVortex2D_adios2_config.xml
│   │       └── TaylorGreenVortex2D_config.yaml
├── include
│   └── ccs_macros.inc
├── config.yaml
```

### Key Functions and Modules in TGV2D

**Module: tgv2d_core**
    - **Function: run_tgv2d**
        - **Description:** Main subroutine to run the 2D Taylor-Green Vortex (TGV2D) simulation.
        - **Inputs:**
            - `par_env`: The parallel environment.
            - `shared_env`: The shared parallel environment.
            - `error_L2`: L2 norm of the error for the U, V, and P fields.
            - `error_Linf`: Linf norm of the error for the U, V, and P fields.
            - `input_mesh` (optional): Mesh object to use; if not provided, a square mesh is built.
            - `input_dt` (optional): Time step; if not provided, the value from the YAML config is used.
            - `input_num_steps` (optional): Number of time steps; if not provided, the value from the YAML config is used.
        - **Outputs:** 
            - `error_L2`: L2 norm of the error for the U, V and P fields respectively
            - `error_Linf`: Linf norm of the error for the U, V and P fields respectively
    - **Function: read_configuration**
        - **Description:** Reads the YAML configuration file to set up the simulation parameters.
        - **Inputs:** `config_filename`: Path to the configuration file.
        - **Outputs:** Sets global variables such as `variable_names`, `variable_types`, `num_steps`, etc.
    - **Function: initialise_flow**
        - **Description:** Initializes the flow fields for the TGV2D simulation.
        - **Inputs:** `flow_fields`: A type containing the flow fields.
        - **Outputs:** Initializes velocity (`u`, `v`, `w`), pressure (`p`), viscosity, and density fields.
    - **Function: calc_tgv2d_error**
        - **Description:** Calculates the error norms for the TGV2D simulation.
        - **Inputs:**
        - `par_env`: The parallel environment.
        - `u`, `v`, `w`, `p`: Flow field components.
        - `error_L2`, `error_Linf`: Output arrays for L2 and Linf error norms.
        - **Outputs:** Updates the `error_L2` and `error_Linf` arrays with computed error norms.

### Main Program
- **File: tgv2d.f90**
  - **Program: tgv2d**
    - **Description:** The main program to set up and run the TGV2D simulation.
    - **Key Steps:**
      - Initializes the parallel environment.
      - Calls `run_tgv2d` to perform the simulation.
      - Finalizes the parallel environment.

## Binding Strategy

### Tools and Libraries
- **f2py:** Part of NumPy, useful for automatically generating Python bindings to Fortran code.

### Steps for Binding

1. **Prepare Fortran Code:** Ensure that the Fortran code is well-documented and modular.
2. **Use f2py to Generate Python Bindings:**
   - Install `f2py`.
   - Use `f2py` to generate Python wrappers for the Fortran functions.
3. **Create Python Interface:**
   - Import the generated Fortran modules in Python.
   - Create Python functions that call the Fortran code.
4. **Testing:**
   - Write test cases in Python to verify the functionality of the Fortran code.

## Example:
```python
# Example of using the run_tgv2d function from tgv2d_core module

import tgv2d_core

# Define inputs
error_L2 = [0.0, 0.0, 0.0]
error_Linf = [0.0, 0.0, 0.0]
input_mesh = None
input_dt = 0.01
input_num_steps = 1000

# Call the Fortran function
output = tgv2d_core.run_tgv2d(error_L2, error_Linf, input_mesh, input_dt, input_num_steps)

# Output the results
print("L2 Errors:", error_L2)
print("Linf Errors:", error_Linf)
```
Because par_env, shared_env are the custom type in Fortran, which can not be created in pytho, thus, they should be defined in Fortran instead of Python.

## Conclusion

This document outlines the structure and key functions of the TGV2D case in the CCS Fortran project. The proposed binding strategy involves using `f2py` to generate Python wrappers for the Fortran functions, creating a seamless interface between Python and Fortran. The next steps involve implementing the binding process and writing test cases to ensure the functionality of the interfaced modules.
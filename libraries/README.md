# Libraries Directory

## Overview

The `libraries` directory contains scripts used to install dependencies for the `ASiMoV-CCS` project on the Cirrus system. Each script is designed to install different dependencies that the project requires. The directory serves as a centralized collection of installation routines, ensuring that any person can set up the development environments in a consistent manner.

## How to Use

To install the dependencies, follow these steps:

1. **Navigate to the Directory**: Change to the `libraries` directory in your terminal.

2. **Set the Environment Setting**: Setting the environments' modules and libraries paths with `setup_gnu_env.sh`. 
    ```sh
    source setup_gnu_env.sh
    ```

3. **Running Installation Scripts**: Execute the installation scripts one by one. Each script is named according to the library or dependency it installs. For example, to install ADIOS2, you would run:
   ```sh
   source install_adios2_gnu.sh
   ```
   Replace `install_adios2_gnu.sh` with the corresponding script name for each dependency you wish to install.

4. **Permissions**: Ensure you have the necessary permissions to execute the scripts, especially for the `makedepf90` (it is the binary file so you no need to install and you just need to make it executable). You might need to modify the permissions with the following command:
   ```sh
   chmod +x *.sh
   ```

5. **Order of Installation**: Some dependencies may need to be installed before others. Refer to `ASiMoV-CCS` project documentation for the correct order.

6. **Custom Installation**: If you need to modify the installation process, edit the script files with your preferred text editor and adjust the installation commands as necessary.

## Additional Information

- **Dependencies**: Before running the installation scripts, make sure all system requirements are met, such as having a Fortran compiler and relevant libraries.

- **Script Maintenance**: Keep the scripts updated with the latest version of the dependencies. If a new version breaks compatibility, document the changes and update the scripts accordingly.

- **Troubleshooting**: If you encounter issues during installation, review the script logs for errors, and consult the Cirrus system documentation or reach out to the support team.

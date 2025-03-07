module python_call_tgv2d
#include "ccs_macros.inc"

  use python_tgv2d_core, only: run_tgv2d ! Import the function that runs the TGV2D simulation
  use constants, only: ccs_split_type_shared
  use parallel, only: initialise_parallel_environment, create_new_par_env, cleanup_parallel_environment
  use parallel_types, only: parallel_environment
  use kinds, only: ccs_real, ccs_int

  implicit none

contains

  subroutine process_tgv2d(error_L2, error_Linf, python_input_dt, python_input_num_steps, python_case_name, python_cps)
    class(parallel_environment), allocatable :: par_env !< The parallel environment
    class(parallel_environment), allocatable :: shared_env !< The parallel environment
    real(ccs_real), dimension(4), intent(out) :: error_L2 !< L2 norm of the error for the U, V and P fields respectively
    real(ccs_real), dimension(4), intent(out) :: error_Linf  !< Linf norm of the error for the U, V and P fields respectively
    logical :: use_mpi_splitting !< Whether to use MPI splitting

    character(len=*), intent(in), optional :: python_case_name ! Case name from python 
    integer(ccs_int), intent(in), optional  :: python_cps ! Cells per side from python
    real(ccs_real), intent(in), optional :: python_input_dt !< timestep from Python
    integer(ccs_int), intent(in), optional :: python_input_num_steps !< number of timesteps from Python

    ! Local variables to store the input values
    character(len=:), allocatable :: local_python_case_name
    integer(ccs_int) :: local_python_cps
    real(ccs_real) :: local_input_dt  
    integer(ccs_int) :: local_input_num_steps 

    ! Set the default values for the input parameters if they are not provided
    if (.not. present(python_case_name) .or. len_trim(python_case_name) == 0) then
      local_python_case_name = "TaylorGreenVortex2D"  ! Default case name
    else
      local_python_case_name = trim(adjustl(python_case_name))  ! Remove any leading/trailing spaces
    endif

    if (.not. present(python_cps) .or. python_cps <= 0) then
      local_python_cps = 16  ! Default number of cells per side
    else
      local_python_cps = python_cps
    endif

    if(.not. present(python_input_dt) .or. python_input_dt <= 0.0) then
      local_input_dt = 0.01 ! Default timestep
    else
      local_input_dt = python_input_dt
    endif 
    
    if(.not. present(python_input_num_steps) .or. python_input_num_steps <= 0) then
      local_input_num_steps = 5 ! Default number of timesteps
    else
      local_input_num_steps = python_input_num_steps
    endif

    ! Initialise the parallel environment
    call initialise_parallel_environment(par_env)
    use_mpi_splitting = .true.
    call create_new_par_env(par_env, ccs_split_type_shared, use_mpi_splitting, shared_env)
    ! Run the TGV2D simulation, which is the main function of this module
    call run_tgv2d(par_env=par_env, shared_env=shared_env, error_L2=error_L2, error_Linf=error_Linf, input_dt=local_input_dt, input_num_steps=local_input_num_steps, python_case_name=local_python_case_name, python_cps=local_python_cps)
    ! Clean up the parallel environment
    call cleanup_parallel_environment(par_env)
  end subroutine process_tgv2d

end module python_call_tgv2d